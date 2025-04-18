-- Insert sample users (these will be linked to auth.users)
INSERT INTO public.profiles (id, username, full_name, avatar_url) VALUES
    ('11111111-1111-1111-1111-111111111111', 'johndoe', 'John Doe', 'https://api.dicebear.com/7.x/avataaars/svg?seed=John'),
    ('22222222-2222-2222-2222-222222222222', 'janedoe', 'Jane Smith', 'https://api.dicebear.com/7.x/avataaars/svg?seed=Jane'),
    ('33333333-3333-3333-3333-333333333333', 'bobsmith', 'Bob Smith', 'https://api.dicebear.com/7.x/avataaars/svg?seed=Bob');

-- Insert sample competitions
INSERT INTO public.competitions (
    id, creator_id, title, description, question, answer, status,
    start_date, end_date, ticket_price, min_tickets, max_tickets,
    charity_percentage, charity_name, charity_registration
) VALUES
    (
        'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
        '11111111-1111-1111-1111-111111111111',
        'Win a PlayStation 5',
        'Enter for a chance to win a brand new PlayStation 5 console!',
        'What is the capital of France?',
        'Paris',
        'active',
        NOW() - INTERVAL '1 day',
        NOW() + INTERVAL '7 days',
        5.00,
        10,
        100,
        10,
        'Gaming for Good',
        'GB123456'
    ),
    (
        'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
        '22222222-2222-2222-2222-222222222222',
        'Luxury Weekend Getaway',
        'Win a weekend stay at a luxury hotel in London!',
        'What year was the first iPhone released?',
        '2007',
        'active',
        NOW() - INTERVAL '2 days',
        NOW() + INTERVAL '14 days',
        10.00,
        20,
        200,
        15,
        'Housing for All',
        'GB789012'
    ),
    (
        'cccccccc-cccc-cccc-cccc-cccccccccccc',
        '11111111-1111-1111-1111-111111111111',
        'Gourmet Cooking Experience',
        'Win a private cooking class with a Michelin-starred chef!',
        'What is the main ingredient in hummus?',
        'Chickpeas',
        'ended',
        NOW() - INTERVAL '30 days',
        NOW() - INTERVAL '1 day',
        15.00,
        15,
        150,
        20,
        'Food for All',
        'GB345678'
    );

-- Insert sample prizes
INSERT INTO public.prizes (
    id, competition_id, title, description, image_url, value, position
) VALUES
    -- PlayStation 5 competition prizes
    (
        'dddddddd-dddd-dddd-dddd-dddddddddddd',
        'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
        'PlayStation 5 Console',
        'Brand new PlayStation 5 console with DualSense controller',
        'https://example.com/ps5.jpg',
        499.99,
        1
    ),
    (
        'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee',
        'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
        'PS5 Games Bundle',
        'Collection of 5 popular PS5 games',
        'https://example.com/games.jpg',
        299.99,
        2
    ),
    -- Luxury Weekend prizes
    (
        'ffffffff-ffff-ffff-ffff-ffffffffffff',
        'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
        'Luxury Hotel Stay',
        '2-night stay in a luxury suite',
        'https://example.com/hotel.jpg',
        800.00,
        1
    ),
    (
        'gggggggg-gggg-gggg-gggg-gggggggggggg',
        'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
        'Spa Treatment',
        'Full day spa experience',
        'https://example.com/spa.jpg',
        200.00,
        2
    ),
    -- Cooking Experience prizes
    (
        'hhhhhhhh-hhhh-hhhh-hhhh-hhhhhhhhhhhh',
        'cccccccc-cccc-cccc-cccc-cccccccccccc',
        'Private Cooking Class',
        '3-hour private cooking class',
        'https://example.com/cooking.jpg',
        500.00,
        1
    ),
    (
        'iiiiiiii-iiii-iiii-iiii-iiiiiiiiiiii',
        'cccccccc-cccc-cccc-cccc-cccccccccccc',
        'Gourmet Dinner',
        'Dinner for two at the chef''s restaurant',
        'https://example.com/dinner.jpg',
        200.00,
        2
    );

-- Insert sample entries
INSERT INTO public.entries (
    id, competition_id, user_id, email, answer, status, ticket_number, stripe_payment_id
) VALUES
    -- PlayStation 5 entries
    (
        'jjjjjjjj-jjjj-jjjj-jjjj-jjjjjjjjjjjj',
        'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
        '22222222-2222-2222-2222-222222222222',
        'jane@example.com',
        'Paris',
        'valid',
        1,
        'pi_123456789'
    ),
    (
        'kkkkkkkk-kkkk-kkkk-kkkk-kkkkkkkkkkkk',
        'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
        '33333333-3333-3333-3333-333333333333',
        'bob@example.com',
        'Paris',
        'valid',
        2,
        'pi_987654321'
    ),
    -- Luxury Weekend entries
    (
        'llllllll-llll-llll-llll-llllllllllll',
        'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
        '11111111-1111-1111-1111-111111111111',
        'john@example.com',
        '2007',
        'valid',
        1,
        'pi_456789123'
    ),
    -- Cooking Experience entries
    (
        'mmmmmmmm-mmmm-mmmm-mmmm-mmmmmmmmmmmm',
        'cccccccc-cccc-cccc-cccc-cccccccccccc',
        '22222222-2222-2222-2222-222222222222',
        'jane@example.com',
        'Chickpeas',
        'winner',
        1,
        'pi_789123456'
    ),
    (
        'nnnnnnnn-nnnn-nnnn-nnnn-nnnnnnnnnnnn',
        'cccccccc-cccc-cccc-cccc-cccccccccccc',
        '33333333-3333-3333-3333-333333333333',
        'bob@example.com',
        'Chickpeas',
        'valid',
        2,
        'pi_321654987'
    );

-- Insert sample winners (only for ended competition)
INSERT INTO public.winners (
    id, entry_id, prize_id, position
) VALUES
    (
        'oooooooo-oooo-oooo-oooo-oooooooooooo',
        'mmmmmmmm-mmmm-mmmm-mmmm-mmmmmmmmmmmm',
        'hhhhhhhh-hhhh-hhhh-hhhh-hhhhhhhhhhhh',
        1
    ),
    (
        'pppppppp-pppp-pppp-pppp-pppppppppppp',
        'nnnnnnnn-nnnn-nnnn-nnnn-nnnnnnnnnnnn',
        'iiiiiiii-iiii-iiii-iiii-iiiiiiiiiiii',
        2
    );

-- Insert sample subscribers
INSERT INTO public.subscribers (email) VALUES
    ('subscriber1@example.com'),
    ('subscriber2@example.com'),
    ('subscriber3@example.com');

-- Insert sample competition followers
INSERT INTO public.competition_followers (competition_id, user_id) VALUES
    ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '22222222-2222-2222-2222-222222222222'),
    ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '11111111-1111-1111-1111-111111111111'),
    ('cccccccc-cccc-cccc-cccc-cccccccccccc', '33333333-3333-3333-3333-333333333333'); 