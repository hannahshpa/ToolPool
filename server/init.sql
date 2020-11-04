CREATE TYPE ToolCondition AS ENUM ('poor', 'fair', 'good', 'great', 'new');


CREATE TABLE IF NOT EXISTS users(
    user_id BIGSERIAL PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
    phone_number VARCHAR(12),
    email VARCHAR(320) NOT NULL
);

CREATE TABLE IF NOT EXISTS tools(
    tool_id BIGSERIAL PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
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
    rating SMALLINT NOT NULL,
    review TEXT,
    PRIMARY KEY(tool, "user")
);

CREATE TABLE IF NOT EXISTS user_ratings(
    reviewer BIGINT NOT NULL REFERENCES users (user_id),
    reviewee BIGINT NOT NULL REFERENCES users (user_id),
    rating SMALLINT NOT NULL,
    review TEXT,
    PRIMARY KEY(reviewer, reviewee)
);

CREATE TABLE IF NOT EXISTS borrow(
    borrow_id BIGSERIAL PRIMARY KEY,
    tool BIGINT NOT NULL REFERENCES tools (tool_id),
    "user" BIGINT NOT NULL REFERENCES users (user_id),
    cost FLOAT NOT NULL,
    loan_period TSTZRANGE NOT NULL,
    time_returned TIMESTAMPTZ
);