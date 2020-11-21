CREATE OR REPLACE FUNCTION check_user_borrowed_tool()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$$
BEGIN
    IF (SELECT 1 FROM borrow WHERE time_returned IS NOT NULL AND "user" = NEW."user" AND tool = NEW.tool) IS NULL THEN
    RAISE EXCEPTION 'The user must have borrowed and returned a tool before rating';
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER user_has_borrowed_tool
    BEFORE INSERT
    ON tool_ratings
    FOR EACH ROW
    EXECUTE PROCEDURE check_user_borrowed_tool(); 

CREATE OR REPLACE FUNCTION check_user_borrowed_from_reviewer()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$$
BEGIN
    IF (SELECT 1 FROM borrow 
        JOIN tools ON tool_id = tool 
        WHERE time_returned IS NOT NULL 
          AND "user" = NEW.reviewee 
          AND owner = NEW.reviewer) IS NULL THEN
    RAISE EXCEPTION 'The reviewee must have borrowed and returned a tool owned by the reviewer before rating';
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER reviewee_has_borrowed_tool_from_reviewer
    BEFORE INSERT
    ON user_ratings
    FOR EACH ROW
    EXECUTE PROCEDURE check_user_borrowed_from_reviewer(); 