INSERT INTO users (name, phone_number, email) VALUES 
    ('John Doe', '15555555555', 'john@example.com'),
    ('Jane Doe', '12345678990', 'jane@example.org'),
    ('Eric Smith', '14238462003', 'esmith@gmail.com');

INSERT INTO tools (name, description, condition, location, owner) VALUES
    ('Power Washer', 'Power washes with water, electricity. Very good', 'good', point(34.0447, -118.4487), 1),
    ('Lawn Mower', 'Stihl brand lawnmower, cuts grass very well', 'great', point(34.0448, -118.4487), 1),
    ('Blender', 'Oscar blender, blends perfect smoothies', 'fair', point(34.0445, -118.44878), 1),
    ('Hammer', 'Pretty self-explanatory', 'fair', point(34.0449, -118.4486), 2);

INSERT INTO borrow (tool, "user", cost, loan_period, time_returned) VALUES 
    (1, 2, 5.99, '[2020-11-06 14:30, 2020-11-07 14:30]', '2020-11-07 12:51'),
    (3, 3, 12.08, '[2020-11-09 8:00, 2020-11-12 12:00]', null);

INSERT INTO tool_schedule (tool, period) VALUES 
    (1, '[2020-11-07 14:30, 2020-11-20 14:30]');

INSERT INTO tool_ratings (tool, "user", rating, review) VALUES
    (1, 2, 5, 'Lawn Mower was excellent, 10/10');

INSERT INTO user_ratings (reviewer, reviewee, rating, review) VALUES
    (2, 3, 1, 'They broke my hammer! what a jerk...');
