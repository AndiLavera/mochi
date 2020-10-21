--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4
-- Dumped by pg_dump version 12.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: i_users; Type: TABLE; Schema: public; Owner: mochi
--

CREATE TABLE public.i_users (
    id integer NOT NULL,
    email character varying(254),
    password_digest character varying(254),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    locked_at timestamp without time zone,
    unlock_token character varying(254),
    failed_attempts integer,
    reset_password_sent_at timestamp without time zone,
    reset_password_token character varying(254),
    password_reset_in_progress boolean,
    uid character varying(254),
    sign_in_count integer,
    current_sign_in_ip character varying(254),
    last_sign_in_ip character varying(254),
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    confirmed boolean,
    confirmed_at timestamp without time zone,
    confirmation_token character varying(254),
    confirmation_sent_at timestamp without time zone,
    uncomfirmed_email character varying(254),
    invitation_accepted_at timestamp without time zone,
    invitation_created_at timestamp without time zone,
    invitation_token character varying(254),
    invited_by bigint,
    invitation_sent_at timestamp without time zone
);


ALTER TABLE public.i_users OWNER TO mochi;

--
-- Name: i_users_id_seq; Type: SEQUENCE; Schema: public; Owner: mochi
--

CREATE SEQUENCE public.i_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.i_users_id_seq OWNER TO mochi;

--
-- Name: i_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mochi
--

ALTER SEQUENCE public.i_users_id_seq OWNED BY public.i_users.id;


--
-- Name: jennifer_users; Type: TABLE; Schema: public; Owner: mochi
--

CREATE TABLE public.jennifer_users (
    id integer NOT NULL,
    email character varying(254),
    password_digest character varying(254),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    confirmed boolean DEFAULT false,
    confirmed_at timestamp without time zone,
    confirmation_token character varying(254),
    confirmation_sent_at timestamp without time zone,
    uncomfirmed_email character varying(254),
    sign_in_count integer DEFAULT 0,
    current_sign_in_ip character varying(254),
    last_sign_in_ip character varying(254),
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    uid character varying(254),
    reset_password_sent_at timestamp without time zone,
    reset_password_token character varying(254),
    password_reset_in_progress boolean DEFAULT false,
    locked_at timestamp without time zone,
    unlock_token character varying(254),
    failed_attempts integer DEFAULT 0,
    invitation_accepted_at timestamp without time zone,
    invitation_created_at timestamp without time zone,
    invitation_token character varying(254),
    invited_by integer,
    invitation_sent_at timestamp without time zone
);


ALTER TABLE public.jennifer_users OWNER TO mochi;

--
-- Name: jennifer_users_id_seq; Type: SEQUENCE; Schema: public; Owner: mochi
--

CREATE SEQUENCE public.jennifer_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jennifer_users_id_seq OWNER TO mochi;

--
-- Name: jennifer_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mochi
--

ALTER SEQUENCE public.jennifer_users_id_seq OWNED BY public.jennifer_users.id;


--
-- Name: migration_versions; Type: TABLE; Schema: public; Owner: mochi
--

CREATE TABLE public.migration_versions (
    id integer NOT NULL,
    version character varying(17) NOT NULL
);


ALTER TABLE public.migration_versions OWNER TO mochi;

--
-- Name: migration_versions_id_seq; Type: SEQUENCE; Schema: public; Owner: mochi
--

CREATE SEQUENCE public.migration_versions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migration_versions_id_seq OWNER TO mochi;

--
-- Name: migration_versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mochi
--

ALTER SEQUENCE public.migration_versions_id_seq OWNED BY public.migration_versions.id;


--
-- Name: i_users id; Type: DEFAULT; Schema: public; Owner: mochi
--

ALTER TABLE ONLY public.i_users ALTER COLUMN id SET DEFAULT nextval('public.i_users_id_seq'::regclass);


--
-- Name: jennifer_users id; Type: DEFAULT; Schema: public; Owner: mochi
--

ALTER TABLE ONLY public.jennifer_users ALTER COLUMN id SET DEFAULT nextval('public.jennifer_users_id_seq'::regclass);


--
-- Name: migration_versions id; Type: DEFAULT; Schema: public; Owner: mochi
--

ALTER TABLE ONLY public.migration_versions ALTER COLUMN id SET DEFAULT nextval('public.migration_versions_id_seq'::regclass);


--
-- Name: i_users i_users_pkey; Type: CONSTRAINT; Schema: public; Owner: mochi
--

ALTER TABLE ONLY public.i_users
    ADD CONSTRAINT i_users_pkey PRIMARY KEY (id);


--
-- Name: jennifer_users jennifer_users_pkey; Type: CONSTRAINT; Schema: public; Owner: mochi
--

ALTER TABLE ONLY public.jennifer_users
    ADD CONSTRAINT jennifer_users_pkey PRIMARY KEY (id);


--
-- Name: migration_versions migration_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: mochi
--

ALTER TABLE ONLY public.migration_versions
    ADD CONSTRAINT migration_versions_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

