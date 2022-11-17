CREATE FUNCTION set_updated_at_to_now() RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language plpgsql;
-- Your database schema. Use the Schema Designer at http://localhost:8001/ to add some tables.
CREATE TABLE plays (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    strategy TEXT NOT NULL,
    direction TEXT NOT NULL,
    is_long BOOLEAN DEFAULT false NOT NULL,
    underlying TEXT NOT NULL,
    pct_max_goal INT NOT NULL,
    closing_thoughts TEXT DEFAULT '' NOT NULL,
    is_success BOOLEAN DEFAULT false NOT NULL,
    commission REAL NOT NULL,
    fees REAL NOT NULL,
    underlying_price DOUBLE PRECISION NOT NULL,
    profit_prob INT NOT NULL,
    opening_thoughts TEXT NOT NULL,
    trade_price DOUBLE PRECISION NOT NULL,
    mark DOUBLE PRECISION NOT NULL,
    close_price DOUBLE PRECISION NOT NULL
);
