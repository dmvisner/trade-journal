CREATE FUNCTION set_updated_at_to_now() RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language plpgsql;
-- Your database schema. Use the Schema Designer at http://localhost:8001/ to add some tables.
CREATE TABLE plays (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    underlying TEXT NOT NULL,
    strategy TEXT NOT NULL,
    direction TEXT NOT NULL,
    quantity INT DEFAULT 1 NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL
);
CREATE TABLE legs (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    open_price INT DEFAULT 1 NOT NULL,
    play UUID NOT NULL,
    expiration_date DATE NOT NULL
);
CREATE INDEX plays_created_at_index ON plays (created_at);
ALTER TABLE legs ADD CONSTRAINT legs_ref_play FOREIGN KEY (play) REFERENCES plays (id) ON DELETE NO ACTION;
