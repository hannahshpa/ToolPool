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

CREATE VIEW fulltool_v AS 
    SELECT tool_id, t.name, t.description, t.condition, t.location[0] as lat, t.location[1] as lon, 
        u.user_id as owner_id, u.name as owner_name, u.phone_number as owner_phone_number, u.email as owner_email,
        array_remove(array_agg(ti.image_uri), NULL) as images,
        array_remove(array_agg(tt.tag), NULL) as tags
    FROM tools t
    LEFT JOIN tool_images ti ON ti.tool = t.tool_id
    LEFT JOIN tool_tags tt ON tt.tool = t.tool_id
    JOIN users u ON u.user_id = t.owner
    GROUP BY t.tool_id, u.user_id;

CREATE VIEW fullborrow_v AS
    SELECT borrow_id, cost, LOWER(loan_period) AS loan_start, UPPER(loan_period) as loan_end, time_returned,
        user_id, u.name as user_name, u.phone_number as user_phone_number, u.email as user_email,
        tool_id, t.name as tool_name, t.description as tool_description, t.condition as tool_condition,
        t.lat as tool_lat, t.lon as tool_lon, t.images as tool_images, t.tags as tool_tags
    FROM borrow
    JOIN users u ON u.user_id = borrow.user
    JOIN fulltool_v t ON t.tool_id = tool;