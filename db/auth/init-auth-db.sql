\connect authdb;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT FROM pg_catalog.pg_roles WHERE rolname = 'authuser'
  ) THEN
    CREATE ROLE authuser WITH LOGIN;
    ALTER ROLE authuser PASSWORD 'authpass';
  END IF;
END
$$;

GRANT ALL ON SCHEMA public TO authuser;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT ALL ON TABLES TO authuser;

CREATE TABLE IF NOT EXISTS test_connection (
  id SERIAL PRIMARY KEY,
  created_at TIMESTAMP DEFAULT now()
);