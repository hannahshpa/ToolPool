-- Required to create exclusion of times
CREATE DATABASE testing;
\connect testing;
\i /docker-entrypoint-initdb.d/1000.sql
\i /docker-entrypoint-initdb.d/1001.sql

INSERT INTO users (name, password, phone_number, email) VALUES
('example', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8' ,'11111111111', 'example@example.com'),
('example2', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8' ,'11111111111', 'example2@example.com');

INSERT INTO tools (name, description, condition, hourly_cost, location, owner) VALUES
    ('tool1', 'tool1', 'good', 1.00, point(0.0, 0.0), 1);

INSERT INTO borrow (tool, "user", cost, loan_period, status, time_returned, return_accepted) VALUES 
    (1, 2, 5.99, '[2001-01-01 00:00, 2001-01-01 00:00:01]', 'accepted', null, null)