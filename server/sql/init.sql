-- Required to create exclusion of times
CREATE EXTENSION btree_gist;

CREATE TYPE ToolCondition AS ENUM ('poor', 'fair', 'good', 'great', 'new');
CREATE TYPE BorrowStatus AS ENUM ('accepted', 'rejected', 'pending');

CREATE TABLE IF NOT EXISTS users(
    user_id BIGSERIAL PRIMARY KEY,
    password VARCHAR(64) NOT NULL,
    name VARCHAR(64) NOT NULL,
    phone_number VARCHAR(12),
    email VARCHAR(320) NOT NULL
);

CREATE TABLE IF NOT EXISTS tools(
    tool_id BIGSERIAL PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
    hourly_cost FLOAT NOT NULL,
    description TEXT NOT NULL,
    condition ToolCondition NOT NULL,
    location POINT NOT NULL,
    owner BIGINT NOT NULL REFERENCES users (user_id)
    );

CREATE TABLE IF NOT EXISTS tool_schedule(
    tool BIGINT NOT NULL REFERENCES tools (tool_id),
    period TSTZRANGE NOT NULL,
    PRIMARY KEY(tool, period)
);

CREATE TABLE IF NOT EXISTS tool_ratings(
    tool BIGINT NOT NULL REFERENCES tools (tool_id),
    "user" BIGINT NOT NULL REFERENCES users (user_id),
    rating SMALLINT NOT NULL CHECK (rating >= 0 AND rating <= 5),
    review TEXT,
    PRIMARY KEY(tool, "user")
);

CREATE TABLE IF NOT EXISTS tool_images(
    tool BIGINT NOT NULL REFERENCES tools (tool_id),
    image_uri TEXT NOT NULL,
    PRIMARY KEY (tool, image_uri)
);

CREATE TABLE IF NOT EXISTS tool_tags(
    tool BIGINT NOT NULL REFERENCES tools (tool_id),
    tag VARCHAR(128) NOT NULL,
    PRIMARY KEY (tool, tag)
);

CREATE TABLE IF NOT EXISTS user_ratings(
    reviewer BIGINT NOT NULL REFERENCES users (user_id),
    reviewee BIGINT NOT NULL REFERENCES users (user_id),
    rating SMALLINT NOT NULL CHECK (rating >= 0 AND rating <= 5),
    review TEXT,
    PRIMARY KEY(reviewer, reviewee)
);

CREATE TABLE IF NOT EXISTS borrow(
    borrow_id BIGSERIAL PRIMARY KEY,
    tool BIGINT NOT NULL REFERENCES tools (tool_id),
    "user" BIGINT NOT NULL REFERENCES users (user_id),
    cost FLOAT NOT NULL,
    status BorrowStatus NOT NULL DEFAULT 'pending',
    loan_period TSTZRANGE NOT NULL,
    time_returned TIMESTAMPTZ,
    return_accepted BOOLEAN,
    CONSTRAINT overlapping_times EXCLUDE USING GIST (
        tool WITH =,
        loan_period WITH &&
    ) WHERE (status = 'accepted')
);
