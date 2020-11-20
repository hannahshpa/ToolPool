INSERT INTO users (name, phone_number, email) VALUES 
    ('John Doe', '15555555555', 'john@example.com'),
    ('Jane Doe', '12345678990', 'jane@example.org'),
    ('Eric Smith', '14238462003', 'esmith@gmail.com');

INSERT INTO tools (name, description, condition, location, owner) VALUES
    ('Power Washer', 'Power washes with water, electricity. Very good', 'good', point(34.0447, -118.4487), 1),
    ('Lawn Mower', 'Stihl brand lawnmower, cuts grass very well', 'great', point(34.0448, -118.4487), 1),
    ('Blender', 'Oscar blender, blends perfect smoothies', 'fair', point(34.0445, -118.44878), 1),
    ('Hammer', 'Pretty self-explanatory', 'fair', point(34.0449, -118.4486), 2);

INSERT INTO borrow (tool, "user", cost, loan_period, time_returned, approved) VALUES 
    (1, 2, 5.99, '[2020-11-06 14:30, 2020-11-07 14:30]', '2020-11-07 12:51', FALSE),
    (3, 3, 12.08, '[2020-11-09 8:00, 2020-11-12 12:00]', null, FALSE);

INSERT INTO tool_schedule (tool, period) VALUES 
    (1, '[2020-11-07 14:30, 2020-11-20 14:30]');

INSERT INTO tool_tags (tool, tag) VALUES
    (1, 'outdoor'), (1, 'power washer'),
    (2, 'outdoor'), (2, 'lawn mower'),
    (3, 'blender'), (3, 'kitchen');

INSERT INTO tool_images (tool, image_uri) VALUES
    (1, 'https://images.homedepot-static.com/productImages/407b8230-f2f5-497f-9ec6-6c04f237d781/svn/ryobi-gas-pressure-washers-ry803001-64_1000.jpg'),
    (2, 'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/mower-1568302588.jpg?crop=1.00xw:0.669xh;0,0.318xh&resize=1200:*'),
    (4, 'https://images-na.ssl-images-amazon.com/images/I/61fnMMgkGIL._AC_SL1098_.jpg');

INSERT INTO tool_ratings (tool, "user", rating, review) VALUES
    (1, 2, 5, 'Lawn Mower was excellent, 10/10');

INSERT INTO user_ratings (reviewer, reviewee, rating, review) VALUES
    (2, 3, 1, 'They broke my hammer! what a jerk...');
