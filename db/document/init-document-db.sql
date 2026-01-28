\connect documentdb;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT FROM pg_catalog.pg_roles WHERE rolname = 'docuser'
  ) THEN
    CREATE ROLE docuser WITH LOGIN;
    ALTER ROLE docuser PASSWORD 'docpass';
  END IF;
END
$$;

GRANT ALL ON SCHEMA public TO docuser;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT ALL ON TABLES TO docuser;

CREATE TABLE IF NOT EXISTS test_connection (
  id SERIAL PRIMARY KEY,
  created_at TIMESTAMP DEFAULT now()
);