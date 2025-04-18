-- First, create the auth.users entries
INSERT INTO auth.users (
    id,
    instance_id,
    email,
    encrypted_password,
    email_confirmed_at,
    created_at,
    updated_at,
    raw_user_meta_data
) VALUES
    (
        '11111111-1111-1111-1111-111111111111',
        '00000000-0000-0000-0000-000000000000',
        'john@example.com',
        crypt('password123', gen_salt('bf')),
        NOW(),
        NOW(),
        NOW(),
        '{"username": "johndoe", "full_name": "John Doe"}'
    ),
    (
        '22222222-2222-2222-2222-222222222222',
        '00000000-0000-0000-0000-000000000000',
        'jane@example.com',
        crypt('password123', gen_salt('bf')),
        NOW(),
        NOW(),
        NOW(),
        '{"username": "janedoe", "full_name": "Jane Smith"}'
    ),
    (
        '33333333-3333-3333-3333-333333333333',
        '00000000-0000-0000-0000-000000000000',
        'bob@example.com',
        crypt('password123', gen_salt('bf')),
        NOW(),
        NOW(),
        NOW(),
        '{"username": "bobsmith", "full_name": "Bob Smith"}'
    );

-- Insert sample competitions
INSERT INTO public.competitions (
    id, creator_id, title, description, question, answer, status,
    start_date, end_date, ticket_price, min_tickets, max_tickets,
    charity_percentage, charity_name, charity_registration
) VALUES
    (
        'aaaaaaaa-aaaa-4aaa-aaaa-aaaaaaaaaaaa',
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
        'bbbbbbbb-bbbb-4bbb-bbbb-bbbbbbbbbbbb',
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
        'cccccccc-cccc-4ccc-cccc-cccccccccccc',
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
        'dddddddd-dddd-4ddd-dddd-dddddddddddd',
        'aaaaaaaa-aaaa-4aaa-aaaa-aaaaaaaaaaaa',
        'PlayStation 5 Console',
        'Brand new PlayStation 5 console with DualSense controller',
        'https://example.com/ps5.jpg',
        499.99,
        1
    ),
    (
        'eeeeeeee-eeee-4eee-eeee-eeeeeeeeeeee',
        'aaaaaaaa-aaaa-4aaa-aaaa-aaaaaaaaaaaa',
        'PS5 Games Bundle',
        'Collection of 5 popular PS5 games',
        'https://example.com/games.jpg',
        299.99,
        2
    ),
    -- Luxury Weekend prizes
    (
        'ffffffff-ffff-4fff-ffff-ffffffffffff',
        'bbbbbbbb-bbbb-4bbb-bbbb-bbbbbbbbbbbb',
        'Luxury Hotel Stay',
        '2-night stay in a luxury suite',
        'https://example.com/hotel.jpg',
        800.00,
        1
    ),
    (
        '11111111-1111-4111-1111-111111111111',
        'bbbbbbbb-bbbb-4bbb-bbbb-bbbbbbbbbbbb',
        'Spa Treatment',
        'Full day spa experience',
        'https://example.com/spa.jpg',
        200.00,
        2
    ),
    -- Cooking Experience prizes
    (
        '22222222-2222-4222-2222-222222222222',
        'cccccccc-cccc-4ccc-cccc-cccccccccccc',
        'Private Cooking Class',
        '3-hour private cooking class',
        'https://example.com/cooking.jpg',
        500.00,
        1
    ),
    (
        '33333333-3333-4333-3333-333333333333',
        'cccccccc-cccc-4ccc-cccc-cccccccccccc',
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
        '44444444-4444-4444-4444-444444444444',
        'aaaaaaaa-aaaa-4aaa-aaaa-aaaaaaaaaaaa',
        '22222222-2222-2222-2222-222222222222',
        'jane@example.com',
        'Paris',
        'valid',
        1,
        'pi_123456789'
    ),
    (
        '55555555-5555-5555-5555-555555555555',
        'aaaaaaaa-aaaa-4aaa-aaaa-aaaaaaaaaaaa',
        '33333333-3333-3333-3333-333333333333',
        'bob@example.com',
        'Paris',
        'valid',
        2,
        'pi_987654321'
    ),
    -- Luxury Weekend entries
    (
        '66666666-6666-6666-6666-666666666666',
        'bbbbbbbb-bbbb-4bbb-bbbb-bbbbbbbbbbbb',
        '11111111-1111-1111-1111-111111111111',
        'john@example.com',
        '2007',
        'valid',
        1,
        'pi_456789123'
    ),
    -- Cooking Experience entries
    (
        '77777777-7777-7777-7777-777777777777',
        'cccccccc-cccc-4ccc-cccc-cccccccccccc',
        '22222222-2222-2222-2222-222222222222',
        'jane@example.com',
        'Chickpeas',
        'winner',
        1,
        'pi_789123456'
    ),
    (
        '88888888-8888-8888-8888-888888888888',
        'cccccccc-cccc-4ccc-cccc-cccccccccccc',
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
        '99999999-9999-9999-9999-999999999999',
        '77777777-7777-7777-7777-777777777777',
        '22222222-2222-4222-2222-222222222222',
        1
    ),
    (
        'aaaaaaaa-aaaa-4aaa-aaaa-aaaaaaaaaaaa',
        '88888888-8888-8888-8888-888888888888',
        '33333333-3333-4333-3333-333333333333',
        2
    );

-- Insert sample subscribers
INSERT INTO public.subscribers (email) VALUES
    ('subscriber1@example.com'),
    ('subscriber2@example.com'),
    ('subscriber3@example.com');

-- Insert sample competition followers
INSERT INTO public.competition_followers (competition_id, user_id) VALUES
    ('aaaaaaaa-aaaa-4aaa-aaaa-aaaaaaaaaaaa', '22222222-2222-2222-2222-222222222222'),
    ('bbbbbbbb-bbbb-4bbb-bbbb-bbbbbbbbbbbb', '11111111-1111-1111-1111-111111111111'),
    ('cccccccc-cccc-4ccc-cccc-cccccccccccc', '33333333-3333-3333-3333-333333333333'); 