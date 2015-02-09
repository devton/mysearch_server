--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: crawled_urls; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE crawled_urls (
    id integer NOT NULL,
    url_scheme character varying NOT NULL,
    host text NOT NULL,
    path text NOT NULL,
    fragment text,
    query_strings text,
    last_parsed_at timestamp without time zone,
    last_check_at timestamp without time zone,
    dead boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: crawled_urls_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE crawled_urls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: crawled_urls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE crawled_urls_id_seq OWNED BY crawled_urls.id;


--
-- Name: negative_expressions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE negative_expressions (
    id integer NOT NULL,
    domains text[] NOT NULL,
    expressions text[] NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: negative_expressions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE negative_expressions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: negative_expressions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE negative_expressions_id_seq OWNED BY negative_expressions.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY crawled_urls ALTER COLUMN id SET DEFAULT nextval('crawled_urls_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY negative_expressions ALTER COLUMN id SET DEFAULT nextval('negative_expressions_id_seq'::regclass);


--
-- Name: crawled_urls_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY crawled_urls
    ADD CONSTRAINT crawled_urls_pkey PRIMARY KEY (id);


--
-- Name: negative_expressions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY negative_expressions
    ADD CONSTRAINT negative_expressions_pkey PRIMARY KEY (id);


--
-- Name: index_crawled_urls_on_host; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_crawled_urls_on_host ON crawled_urls USING btree (host);


--
-- Name: index_negative_expressions_on_domains; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_negative_expressions_on_domains ON negative_expressions USING gin (domains);


--
-- Name: index_negative_expressions_on_expressions; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_negative_expressions_on_expressions ON negative_expressions USING gin (expressions);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20150204041839');

INSERT INTO schema_migrations (version) VALUES ('20150206014727');

INSERT INTO schema_migrations (version) VALUES ('20150207035230');

INSERT INTO schema_migrations (version) VALUES ('20150209001235');

