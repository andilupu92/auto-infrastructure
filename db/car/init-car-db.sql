\connect cardb;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT FROM pg_catalog.pg_roles WHERE rolname = 'caruser'
  ) THEN
    CREATE ROLE caruser WITH LOGIN;
    ALTER ROLE caruser PASSWORD 'carpass';
  END IF;
END
$$;

GRANT ALL ON SCHEMA public TO caruser;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT ALL ON TABLES TO caruser;

CREATE TABLE IF NOT EXISTS test_connection (
  id SERIAL PRIMARY KEY,
  created_at TIMESTAMP DEFAULT now()
);