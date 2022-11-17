CREATE FUNCTION set_updated_at_to_now() RETURNS TRIGGER AS $$BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;$$ language PLPGSQL;
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
    opening_thoughts TEXT NOT NULL
);
CREATE TABLE legs (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    open_date DATE NOT NULL,
    close_date DATE NOT NULL,
    is_roll BOOLEAN DEFAULT false NOT NULL,
    expiration_date DATE NOT NULL,
    trade_price REAL NOT NULL,
    mark REAL NOT NULL,
    play UUID NOT NULL,
    close_price REAL NOT NULL,
    delta REAL NOT NULL
);
ALTER TABLE legs ADD CONSTRAINT legs_ref_play FOREIGN KEY (play) REFERENCES plays (id) ON DELETE NO ACTION;
