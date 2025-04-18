-- Enable necessary extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Create custom types
CREATE TYPE competition_status AS ENUM ('draft', 'active', 'ended', 'cancelled');
CREATE TYPE entry_status AS ENUM ('pending', 'valid', 'invalid', 'winner');

-- Create users table (extends Supabase auth.users)
CREATE TABLE IF NOT EXISTS public.profiles (
    id UUID REFERENCES auth.users ON DELETE CASCADE PRIMARY KEY,
    username TEXT UNIQUE,
    full_name TEXT,
    avatar_url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create competitions table
CREATE TABLE IF NOT EXISTS public.competitions (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    creator_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    description TEXT,
    question TEXT NOT NULL,
    answer TEXT NOT NULL,
    status competition_status DEFAULT 'draft',
    start_date TIMESTAMPTZ,
    end_date TIMESTAMPTZ NOT NULL,
    ticket_price DECIMAL(10,2) NOT NULL,
    min_tickets INTEGER DEFAULT 1,
    max_tickets INTEGER,
    charity_percentage INTEGER DEFAULT 0,
    charity_name TEXT,
    charity_registration TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    CONSTRAINT valid_dates CHECK (end_date > start_date),
    CONSTRAINT valid_ticket_limits CHECK (max_tickets >= min_tickets)
);

-- Create prizes table
CREATE TABLE IF NOT EXISTS public.prizes (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    competition_id UUID REFERENCES public.competitions(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    description TEXT,
    image_url TEXT,
    value DECIMAL(10,2),
    position INTEGER NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create entries table
CREATE TABLE IF NOT EXISTS public.entries (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    competition_id UUID REFERENCES public.competitions(id) ON DELETE CASCADE,
    user_id UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
    email TEXT NOT NULL,
    answer TEXT NOT NULL,
    status entry_status DEFAULT 'pending',
    ticket_number INTEGER NOT NULL,
    stripe_payment_id TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create winners table
CREATE TABLE IF NOT EXISTS public.winners (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    entry_id UUID REFERENCES public.entries(id) ON DELETE CASCADE,
    prize_id UUID REFERENCES public.prizes(id) ON DELETE CASCADE,
    position INTEGER NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create subscribers table
CREATE TABLE IF NOT EXISTS public.subscribers (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    email TEXT UNIQUE NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create competition followers table
CREATE TABLE IF NOT EXISTS public.competition_followers (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    competition_id UUID REFERENCES public.competitions(id) ON DELETE CASCADE,
    user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    UNIQUE(competition_id, user_id)
);

-- Create RLS policies
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.competitions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.prizes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.entries ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.winners ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.subscribers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.competition_followers ENABLE ROW LEVEL SECURITY;

-- Profiles policies
CREATE POLICY "Public profiles are viewable by everyone"
    ON public.profiles FOR SELECT
    USING (true);

CREATE POLICY "Users can update their own profile"
    ON public.profiles FOR UPDATE
    USING (auth.uid() = id);

-- Competitions policies
CREATE POLICY "Competitions are viewable by everyone"
    ON public.competitions FOR SELECT
    USING (true);

CREATE POLICY "Users can create competitions"
    ON public.competitions FOR INSERT
    WITH CHECK (auth.uid() = creator_id);

CREATE POLICY "Users can update their own competitions"
    ON public.competitions FOR UPDATE
    USING (auth.uid() = creator_id);

-- Prizes policies
CREATE POLICY "Prizes are viewable by everyone"
    ON public.prizes FOR SELECT
    USING (true);

CREATE POLICY "Users can manage prizes for their competitions"
    ON public.prizes FOR ALL
    USING (
        EXISTS (
            SELECT 1 FROM public.competitions
            WHERE competitions.id = prizes.competition_id
            AND competitions.creator_id = auth.uid()
        )
    );

-- Entries policies
CREATE POLICY "Entries are viewable by competition creator"
    ON public.entries FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM public.competitions
            WHERE competitions.id = entries.competition_id
            AND competitions.creator_id = auth.uid()
        )
    );

CREATE POLICY "Users can create entries"
    ON public.entries FOR INSERT
    WITH CHECK (true);

-- Winners policies
CREATE POLICY "Winners are viewable by everyone"
    ON public.winners FOR SELECT
    USING (true);

CREATE POLICY "Only competition creator can manage winners"
    ON public.winners FOR ALL
    USING (
        EXISTS (
            SELECT 1 FROM public.entries
            JOIN public.competitions ON competitions.id = entries.competition_id
            WHERE entries.id = winners.entry_id
            AND competitions.creator_id = auth.uid()
        )
    );

-- Subscribers policies
CREATE POLICY "Anyone can subscribe"
    ON public.subscribers FOR INSERT
    WITH CHECK (true);

-- Competition followers policies
CREATE POLICY "Users can follow competitions"
    ON public.competition_followers FOR ALL
    USING (auth.uid() = user_id);

-- Create indexes
CREATE INDEX idx_competitions_creator ON public.competitions(creator_id);
CREATE INDEX idx_competitions_status ON public.competitions(status);
CREATE INDEX idx_entries_competition ON public.entries(competition_id);
CREATE INDEX idx_entries_user ON public.entries(user_id);
CREATE INDEX idx_entries_email ON public.entries(email);
CREATE INDEX idx_prizes_competition ON public.prizes(competition_id);
CREATE INDEX idx_winners_entry ON public.winners(entry_id);
CREATE INDEX idx_winners_prize ON public.winners(prize_id);

-- Create functions
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.profiles (id, username, full_name)
    VALUES (new.id, new.raw_user_meta_data->>'username', new.raw_user_meta_data->>'full_name');
    RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create trigger for new user creation
CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION public.handle_new_user(); 