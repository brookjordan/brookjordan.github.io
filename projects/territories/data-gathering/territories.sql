--
-- PostgreSQL database dump
--

-- Dumped from database version 12.2
-- Dumped by pg_dump version 12.2

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

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ISO_3166-1_alpha-3; Type: TABLE; Schema: public; Owner: brook
--

CREATE TABLE public."ISO_3166-1_alpha-3" (
    id integer NOT NULL,
    uuid character(36) DEFAULT public.uuid_generate_v4() NOT NULL,
    name character(3) NOT NULL,
    type text NOT NULL,
    territory character(36) NOT NULL,
    assignment_date date
);


ALTER TABLE public."ISO_3166-1_alpha-3" OWNER TO brook;

--
-- Name: ISO_3166-1_alpha-3_id_seq; Type: SEQUENCE; Schema: public; Owner: brook
--

CREATE SEQUENCE public."ISO_3166-1_alpha-3_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ISO_3166-1_alpha-3_id_seq" OWNER TO brook;

--
-- Name: ISO_3166-1_alpha-3_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brook
--

ALTER SEQUENCE public."ISO_3166-1_alpha-3_id_seq" OWNED BY public."ISO_3166-1_alpha-3".id;


--
-- Name: ISO_3166-2; Type: TABLE; Schema: public; Owner: brook
--

CREATE TABLE public."ISO_3166-2" (
    id integer NOT NULL,
    uuid text DEFAULT public.uuid_generate_v4() NOT NULL,
    name character(2) NOT NULL,
    assignment_date date,
    expiry_date date,
    type text DEFAULT ''::text NOT NULL,
    territory character(36)
);


ALTER TABLE public."ISO_3166-2" OWNER TO brook;

--
-- Name: ISO_3166-2_id_seq; Type: SEQUENCE; Schema: public; Owner: brook
--

CREATE SEQUENCE public."ISO_3166-2_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ISO_3166-2_id_seq" OWNER TO brook;

--
-- Name: ISO_3166-2_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brook
--

ALTER SEQUENCE public."ISO_3166-2_id_seq" OWNED BY public."ISO_3166-2".id;


--
-- Name: ISO_3166_type; Type: TABLE; Schema: public; Owner: brook
--

CREATE TABLE public."ISO_3166_type" (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public."ISO_3166_type" OWNER TO brook;

--
-- Name: ISO_3166-2_types_id_seq; Type: SEQUENCE; Schema: public; Owner: brook
--

CREATE SEQUENCE public."ISO_3166-2_types_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ISO_3166-2_types_id_seq" OWNER TO brook;

--
-- Name: ISO_3166-2_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brook
--

ALTER SEQUENCE public."ISO_3166-2_types_id_seq" OWNED BY public."ISO_3166_type".id;


--
-- Name: ISO_3166-3; Type: TABLE; Schema: public; Owner: brook
--

CREATE TABLE public."ISO_3166-3" (
    id integer NOT NULL,
    uuid character(36) DEFAULT public.uuid_generate_v4() NOT NULL,
    territory character(36) NOT NULL,
    previous_territory character(36) NOT NULL,
    name character(4) NOT NULL,
    assignment_date date,
    expiry_date date,
    type text NOT NULL
);


ALTER TABLE public."ISO_3166-3" OWNER TO brook;

--
-- Name: ISO_3166-3_id_seq; Type: SEQUENCE; Schema: public; Owner: brook
--

CREATE SEQUENCE public."ISO_3166-3_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ISO_3166-3_id_seq" OWNER TO brook;

--
-- Name: ISO_3166-3_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brook
--

ALTER SEQUENCE public."ISO_3166-3_id_seq" OWNED BY public."ISO_3166-3".id;


--
-- Name: ISO_3166-3_type; Type: TABLE; Schema: public; Owner: brook
--

CREATE TABLE public."ISO_3166-3_type" (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public."ISO_3166-3_type" OWNER TO brook;

--
-- Name: ISO_3166-3_types_id_seq; Type: SEQUENCE; Schema: public; Owner: brook
--

CREATE SEQUENCE public."ISO_3166-3_types_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ISO_3166-3_types_id_seq" OWNER TO brook;

--
-- Name: ISO_3166-3_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brook
--

ALTER SEQUENCE public."ISO_3166-3_types_id_seq" OWNED BY public."ISO_3166-3_type".id;


--
-- Name: demonym; Type: TABLE; Schema: public; Owner: brook
--

CREATE TABLE public.demonym (
    id integer NOT NULL,
    uuid character(36) DEFAULT public.uuid_generate_v4() NOT NULL,
    label text,
    territory text
);


ALTER TABLE public.demonym OWNER TO brook;

--
-- Name: demonym_id_seq; Type: SEQUENCE; Schema: public; Owner: brook
--

CREATE SEQUENCE public.demonym_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.demonym_id_seq OWNER TO brook;

--
-- Name: demonym_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brook
--

ALTER SEQUENCE public.demonym_id_seq OWNED BY public.demonym.id;


--
-- Name: language; Type: TABLE; Schema: public; Owner: brook
--

CREATE TABLE public.language (
    id integer NOT NULL,
    uuid character(36) DEFAULT public.uuid_generate_v4() NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.language OWNER TO brook;

--
-- Name: language_id_seq; Type: SEQUENCE; Schema: public; Owner: brook
--

CREATE SEQUENCE public.language_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.language_id_seq OWNER TO brook;

--
-- Name: language_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brook
--

ALTER SEQUENCE public.language_id_seq OWNED BY public.language.id;


--
-- Name: language_label; Type: TABLE; Schema: public; Owner: brook
--

CREATE TABLE public.language_label (
    id integer NOT NULL,
    uuid character(36) DEFAULT public.uuid_generate_v4() NOT NULL,
    label text NOT NULL,
    language character(36) NOT NULL
);


ALTER TABLE public.language_label OWNER TO brook;

--
-- Name: language_label_id_seq; Type: SEQUENCE; Schema: public; Owner: brook
--

CREATE SEQUENCE public.language_label_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.language_label_id_seq OWNER TO brook;

--
-- Name: language_label_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brook
--

ALTER SEQUENCE public.language_label_id_seq OWNED BY public.language_label.id;


--
-- Name: language_relationship; Type: TABLE; Schema: public; Owner: brook
--

CREATE TABLE public.language_relationship (
    id integer NOT NULL,
    uuid character(36) DEFAULT public.uuid_generate_v4() NOT NULL,
    language character(36) NOT NULL,
    related_language character(36) NOT NULL,
    type text NOT NULL
);


ALTER TABLE public.language_relationship OWNER TO brook;

--
-- Name: language_relationship_id_seq; Type: SEQUENCE; Schema: public; Owner: brook
--

CREATE SEQUENCE public.language_relationship_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.language_relationship_id_seq OWNER TO brook;

--
-- Name: language_relationship_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brook
--

ALTER SEQUENCE public.language_relationship_id_seq OWNED BY public.language_relationship.id;


--
-- Name: language_relationship_type; Type: TABLE; Schema: public; Owner: brook
--

CREATE TABLE public.language_relationship_type (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.language_relationship_type OWNER TO brook;

--
-- Name: language_relationship_type_id_seq; Type: SEQUENCE; Schema: public; Owner: brook
--

CREATE SEQUENCE public.language_relationship_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.language_relationship_type_id_seq OWNER TO brook;

--
-- Name: language_relationship_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brook
--

ALTER SEQUENCE public.language_relationship_type_id_seq OWNED BY public.language_relationship_type.id;


--
-- Name: passport_travel_requirements; Type: TABLE; Schema: public; Owner: brook
--

CREATE TABLE public.passport_travel_requirements (
    id integer NOT NULL,
    passport_territory character(36) NOT NULL,
    destination_territory character(36) NOT NULL,
    visa_type text NOT NULL,
    stay_length interval,
    notes text,
    uuid character(36) DEFAULT public.uuid_generate_v4() NOT NULL,
    route character(72) NOT NULL,
    CONSTRAINT passport_travel_requirements_check CHECK (((route)::text = concat(passport_territory, destination_territory)))
);


ALTER TABLE public.passport_travel_requirements OWNER TO brook;

--
-- Name: passport_travel_requirements_id_seq; Type: SEQUENCE; Schema: public; Owner: brook
--

CREATE SEQUENCE public.passport_travel_requirements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.passport_travel_requirements_id_seq OWNER TO brook;

--
-- Name: passport_travel_requirements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brook
--

ALTER SEQUENCE public.passport_travel_requirements_id_seq OWNED BY public.passport_travel_requirements.id;


--
-- Name: svg_path; Type: TABLE; Schema: public; Owner: brook
--

CREATE TABLE public.svg_path (
    id integer NOT NULL,
    uuid character(36) DEFAULT public.uuid_generate_v4() NOT NULL,
    territory character(36) NOT NULL,
    path text NOT NULL
);


ALTER TABLE public.svg_path OWNER TO brook;

--
-- Name: svg_path_id_seq; Type: SEQUENCE; Schema: public; Owner: brook
--

CREATE SEQUENCE public.svg_path_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.svg_path_id_seq OWNER TO brook;

--
-- Name: svg_path_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brook
--

ALTER SEQUENCE public.svg_path_id_seq OWNED BY public.svg_path.id;


--
-- Name: territory; Type: TABLE; Schema: public; Owner: brook
--

CREATE TABLE public.territory (
    id integer NOT NULL,
    uuid character(36) DEFAULT public.uuid_generate_v4() NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.territory OWNER TO brook;

--
-- Name: territory_id_seq; Type: SEQUENCE; Schema: public; Owner: brook
--

CREATE SEQUENCE public.territory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.territory_id_seq OWNER TO brook;

--
-- Name: territory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brook
--

ALTER SEQUENCE public.territory_id_seq OWNED BY public.territory.id;


--
-- Name: territory_label; Type: TABLE; Schema: public; Owner: brook
--

CREATE TABLE public.territory_label (
    id integer NOT NULL,
    uuid character(36) DEFAULT public.uuid_generate_v4() NOT NULL,
    label text NOT NULL,
    territory character(36) NOT NULL,
    the boolean NOT NULL
);


ALTER TABLE public.territory_label OWNER TO brook;

--
-- Name: territory_label_id_seq; Type: SEQUENCE; Schema: public; Owner: brook
--

CREATE SEQUENCE public.territory_label_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.territory_label_id_seq OWNER TO brook;

--
-- Name: territory_label_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brook
--

ALTER SEQUENCE public.territory_label_id_seq OWNED BY public.territory_label.id;


--
-- Name: territory_language; Type: TABLE; Schema: public; Owner: brook
--

CREATE TABLE public.territory_language (
    id integer NOT NULL,
    uuid character(36) DEFAULT public.uuid_generate_v4() NOT NULL,
    territory character(36) NOT NULL,
    language character(36) NOT NULL
);


ALTER TABLE public.territory_language OWNER TO brook;

--
-- Name: territory_language_id_seq; Type: SEQUENCE; Schema: public; Owner: brook
--

CREATE SEQUENCE public.territory_language_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.territory_language_id_seq OWNER TO brook;

--
-- Name: territory_language_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brook
--

ALTER SEQUENCE public.territory_language_id_seq OWNED BY public.territory_language.id;


--
-- Name: territory_reltionship; Type: TABLE; Schema: public; Owner: brook
--

CREATE TABLE public.territory_reltionship (
    id integer NOT NULL,
    territory character(36) NOT NULL,
    related_territory character(36) NOT NULL,
    relationship text NOT NULL
);


ALTER TABLE public.territory_reltionship OWNER TO brook;

--
-- Name: territory_reltionship_id_seq; Type: SEQUENCE; Schema: public; Owner: brook
--

CREATE SEQUENCE public.territory_reltionship_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.territory_reltionship_id_seq OWNER TO brook;

--
-- Name: territory_reltionship_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brook
--

ALTER SEQUENCE public.territory_reltionship_id_seq OWNED BY public.territory_reltionship.id;


--
-- Name: territory_reltionship_type; Type: TABLE; Schema: public; Owner: brook
--

CREATE TABLE public.territory_reltionship_type (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.territory_reltionship_type OWNER TO brook;

--
-- Name: territory_reltionship_type_id_seq; Type: SEQUENCE; Schema: public; Owner: brook
--

CREATE SEQUENCE public.territory_reltionship_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.territory_reltionship_type_id_seq OWNER TO brook;

--
-- Name: territory_reltionship_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brook
--

ALTER SEQUENCE public.territory_reltionship_type_id_seq OWNED BY public.territory_reltionship_type.id;


--
-- Name: territory_top_level_domain; Type: TABLE; Schema: public; Owner: brook
--

CREATE TABLE public.territory_top_level_domain (
    id integer NOT NULL,
    uuid character(36) DEFAULT public.uuid_generate_v4() NOT NULL,
    territory character(36) NOT NULL,
    top_level_domain text NOT NULL
);


ALTER TABLE public.territory_top_level_domain OWNER TO brook;

--
-- Name: territory_top_level_domain_id_seq; Type: SEQUENCE; Schema: public; Owner: brook
--

CREATE SEQUENCE public.territory_top_level_domain_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.territory_top_level_domain_id_seq OWNER TO brook;

--
-- Name: territory_top_level_domain_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brook
--

ALTER SEQUENCE public.territory_top_level_domain_id_seq OWNED BY public.territory_top_level_domain.id;


--
-- Name: top_level_domain; Type: TABLE; Schema: public; Owner: brook
--

CREATE TABLE public.top_level_domain (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.top_level_domain OWNER TO brook;

--
-- Name: top_level_domains_id_seq; Type: SEQUENCE; Schema: public; Owner: brook
--

CREATE SEQUENCE public.top_level_domains_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.top_level_domains_id_seq OWNER TO brook;

--
-- Name: top_level_domains_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brook
--

ALTER SEQUENCE public.top_level_domains_id_seq OWNED BY public.top_level_domain.id;


--
-- Name: visa_ease_of_entry; Type: TABLE; Schema: public; Owner: brook
--

CREATE TABLE public.visa_ease_of_entry (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.visa_ease_of_entry OWNER TO brook;

--
-- Name: visa_ease_of_entry_id_seq; Type: SEQUENCE; Schema: public; Owner: brook
--

CREATE SEQUENCE public.visa_ease_of_entry_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.visa_ease_of_entry_id_seq OWNER TO brook;

--
-- Name: visa_ease_of_entry_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brook
--

ALTER SEQUENCE public.visa_ease_of_entry_id_seq OWNED BY public.visa_ease_of_entry.id;


--
-- Name: visa_type; Type: TABLE; Schema: public; Owner: brook
--

CREATE TABLE public.visa_type (
    id integer NOT NULL,
    ease text NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.visa_type OWNER TO brook;

--
-- Name: visa_types_id_seq; Type: SEQUENCE; Schema: public; Owner: brook
--

CREATE SEQUENCE public.visa_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.visa_types_id_seq OWNER TO brook;

--
-- Name: visa_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brook
--

ALTER SEQUENCE public.visa_types_id_seq OWNED BY public.visa_type.id;


--
-- Name: ISO_3166-1_alpha-3 id; Type: DEFAULT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public."ISO_3166-1_alpha-3" ALTER COLUMN id SET DEFAULT nextval('public."ISO_3166-1_alpha-3_id_seq"'::regclass);


--
-- Name: ISO_3166-2 id; Type: DEFAULT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public."ISO_3166-2" ALTER COLUMN id SET DEFAULT nextval('public."ISO_3166-2_id_seq"'::regclass);


--
-- Name: ISO_3166-3 id; Type: DEFAULT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public."ISO_3166-3" ALTER COLUMN id SET DEFAULT nextval('public."ISO_3166-3_id_seq"'::regclass);


--
-- Name: ISO_3166-3_type id; Type: DEFAULT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public."ISO_3166-3_type" ALTER COLUMN id SET DEFAULT nextval('public."ISO_3166-3_types_id_seq"'::regclass);


--
-- Name: ISO_3166_type id; Type: DEFAULT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public."ISO_3166_type" ALTER COLUMN id SET DEFAULT nextval('public."ISO_3166-2_types_id_seq"'::regclass);


--
-- Name: demonym id; Type: DEFAULT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.demonym ALTER COLUMN id SET DEFAULT nextval('public.demonym_id_seq'::regclass);


--
-- Name: language id; Type: DEFAULT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.language ALTER COLUMN id SET DEFAULT nextval('public.language_id_seq'::regclass);


--
-- Name: language_label id; Type: DEFAULT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.language_label ALTER COLUMN id SET DEFAULT nextval('public.language_label_id_seq'::regclass);


--
-- Name: language_relationship id; Type: DEFAULT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.language_relationship ALTER COLUMN id SET DEFAULT nextval('public.language_relationship_id_seq'::regclass);


--
-- Name: language_relationship_type id; Type: DEFAULT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.language_relationship_type ALTER COLUMN id SET DEFAULT nextval('public.language_relationship_type_id_seq'::regclass);


--
-- Name: passport_travel_requirements id; Type: DEFAULT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.passport_travel_requirements ALTER COLUMN id SET DEFAULT nextval('public.passport_travel_requirements_id_seq'::regclass);


--
-- Name: svg_path id; Type: DEFAULT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.svg_path ALTER COLUMN id SET DEFAULT nextval('public.svg_path_id_seq'::regclass);


--
-- Name: territory id; Type: DEFAULT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.territory ALTER COLUMN id SET DEFAULT nextval('public.territory_id_seq'::regclass);


--
-- Name: territory_label id; Type: DEFAULT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.territory_label ALTER COLUMN id SET DEFAULT nextval('public.territory_label_id_seq'::regclass);


--
-- Name: territory_language id; Type: DEFAULT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.territory_language ALTER COLUMN id SET DEFAULT nextval('public.territory_language_id_seq'::regclass);


--
-- Name: territory_reltionship id; Type: DEFAULT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.territory_reltionship ALTER COLUMN id SET DEFAULT nextval('public.territory_reltionship_id_seq'::regclass);


--
-- Name: territory_reltionship_type id; Type: DEFAULT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.territory_reltionship_type ALTER COLUMN id SET DEFAULT nextval('public.territory_reltionship_type_id_seq'::regclass);


--
-- Name: territory_top_level_domain id; Type: DEFAULT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.territory_top_level_domain ALTER COLUMN id SET DEFAULT nextval('public.territory_top_level_domain_id_seq'::regclass);


--
-- Name: top_level_domain id; Type: DEFAULT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.top_level_domain ALTER COLUMN id SET DEFAULT nextval('public.top_level_domains_id_seq'::regclass);


--
-- Name: visa_ease_of_entry id; Type: DEFAULT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.visa_ease_of_entry ALTER COLUMN id SET DEFAULT nextval('public.visa_ease_of_entry_id_seq'::regclass);


--
-- Name: visa_type id; Type: DEFAULT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.visa_type ALTER COLUMN id SET DEFAULT nextval('public.visa_types_id_seq'::regclass);


--
-- Data for Name: ISO_3166-1_alpha-3; Type: TABLE DATA; Schema: public; Owner: brook
--

COPY public."ISO_3166-1_alpha-3" (id, uuid, name, type, territory, assignment_date) FROM stdin;
1	3ad24848-5d57-49c9-937b-9fcbb0500300	AFI	deleted	74718d89-2c74-4664-a9f9-c3bda5884237	\N
2	4772362f-dc42-441e-81e5-c8ac8fb01310	BDS	indeterminate	49494a5b-205f-4756-9145-2784c9269a99	\N
3	78dd3db0-0a35-4c4d-a2b6-7b92ab7cbf16	ANT	transitional	437b6b0d-4fe4-4e6a-b869-9aca4351a182	2010-12-01
4	1515a51d-dc10-49fe-9dd1-7ffac5df5d26	FXX	exceptional	af123316-5e2b-4453-9908-13434c758d89	\N
5	ffb3442b-44f8-48ec-a290-164e08f4ef89	CSK	transitional	7fb270a5-06a1-4488-951f-55dcc7e822c0	1993-06-01
6	601918ae-d937-4d7e-af8e-0ce3b70adc94	YUG	transitional	9081511d-8a3b-4372-b828-44afb55b2dc4	2003-07-01
7	09ca1099-ded4-4b1d-9a8c-e5be525e00ea	SCG	transitional	ba063fe6-f538-45d8-9450-81c536a1aa29	2006-09-01
8	5d2f420f-aebd-4abe-8ffb-a55ce6193a77	AND	current	1965c743-cf9a-4021-9ed1-b9e4e77486a2	\N
9	ce8b5872-a666-4f86-a982-9def5efa1592	AIA	current	793360a3-aa91-4703-acfe-60287e3f9b74	\N
10	930bb39d-d709-4cf3-a6e4-89226526748e	ARE	current	2b1a33fe-be25-452b-8a1c-c7d5f1dce9c2	\N
11	d836d217-d85c-4d3a-8543-389ebd938add	ALA	current	ca1a8efc-5d84-4e75-9f3b-5d005b9afca5	\N
12	f200d1cf-eb81-4537-956c-61dfb71da931	BRB	current	49494a5b-205f-4756-9145-2784c9269a99	\N
13	b4483444-ed9c-43cf-8381-1d9331baff97	CZE	current	c5db5d6b-ebcd-4642-9604-0f1ebf2fdf9d	\N
14	6bdba136-92cd-4672-aae0-4eb819dc467f	SVK	current	2dd507e0-8e57-4924-a57f-8fc2e22555e2	\N
15	b58e25ba-1610-4114-8785-9286905ed2c6	MNE	current	6702177a-fbed-4cf3-aa32-22da244beab0	\N
16	2839e3a8-f92d-4ed1-b4ae-c8367d1a074c	SRB	current	aae2ba87-a67d-43bd-8516-e403843d61d9	\N
17	01c8a7db-dde0-42d1-b2a5-a5bba2120958	GBR	current	0f433ba9-47e1-4fe6-902c-632bf40355a9	\N
18	fd2f8dbd-1700-4a3f-a149-bf9085eba1b6	GBR	current	56c6dacf-b4d9-401b-874a-6518da0cd567	\N
19	f9f37136-21f4-466b-9791-1e68d1186105	GBR	current	c5bc507e-7bca-4c9d-8d7b-a3441b33dffe	\N
20	0828289b-7bb7-40e6-84fe-3fc58e85ec38	GBR	current	e054a323-d773-441e-9cbb-9843a1780b2d	\N
21	826208f3-19b0-40b8-bcbc-e4fc750412c3	GBR	current	c639dcd9-0e03-4f83-bdba-8a5a921b021a	\N
22	06e7685f-d177-4678-af1f-e8bba4304d2c	DJI	current	0b48c87c-ddaa-49d2-b736-61d9c44636e0	\N
\.


--
-- Data for Name: ISO_3166-2; Type: TABLE DATA; Schema: public; Owner: brook
--

COPY public."ISO_3166-2" (id, uuid, name, assignment_date, expiry_date, type, territory) FROM stdin;
1	ecf9cbfd-8eb9-42d8-93c2-086b17a9e979	AI	\N	\N	deleted	74718d89-2c74-4664-a9f9-c3bda5884237
2	bbfb663c-c435-4178-bc0c-f400bd2dbdef	AX	\N	\N	exceptional	ca1a8efc-5d84-4e75-9f3b-5d005b9afca5
3	36cc80a8-ccf6-4d6f-bccf-5e36fde62297	AN	\N	2060-12-01	transitional	437b6b0d-4fe4-4e6a-b869-9aca4351a182
4	cb732b9a-7223-491d-8fd4-96077e4b6f14	FX	\N	\N	exceptional	af123316-5e2b-4453-9908-13434c758d89
5	8258682a-52f6-4303-aaa5-d724fd0a86a1	BU	\N	2030-12-01	transitional	509e1050-f5ab-4d6b-ba04-501765fb9ecf
6	77602172-9d9c-42f6-9df6-db1355d887ca	YU	\N	2053-07-01	transitional	9081511d-8a3b-4372-b828-44afb55b2dc4
7	cc94f3ea-03f2-4af6-973e-a5cc7fdf950e	CS	\N	\N	deleted	7fb270a5-06a1-4488-951f-55dcc7e822c0
8	63f6fdce-e3f6-4ab9-a804-2e52f7e9ee11	CS	\N	2056-09-01	transitional	ba063fe6-f538-45d8-9450-81c536a1aa29
9	cd8083e8-fb9b-4419-b8d9-ab4351249bac	AI	1985-01-01	\N	current	793360a3-aa91-4703-acfe-60287e3f9b74
10	259d8417-dd22-458c-9a86-c4ba143c9a19	AX	2004-01-01	\N	current	ca1a8efc-5d84-4e75-9f3b-5d005b9afca5
11	b7321873-8648-44d6-9e6b-5d402305812b	BB	1974-01-01	\N	current	49494a5b-205f-4756-9145-2784c9269a99
12	9c33dc91-e869-4804-9a33-7aa9df1eabc3	CZ	1993-01-01	\N	current	c5db5d6b-ebcd-4642-9604-0f1ebf2fdf9d
13	1c94fb78-0ebf-48f9-820d-cf13f4d0de2f	SK	1993-01-01	\N	current	2dd507e0-8e57-4924-a57f-8fc2e22555e2
14	d5c3eeef-6cf2-4d67-8fe5-aa41c897970c	MM	1989-01-01	\N	current	ac8b13ec-0d98-4fad-852e-a351d68e6a16
15	78908366-24b0-4abc-b2af-cf70df5e09e3	ME	2006-01-01	\N	current	6702177a-fbed-4cf3-aa32-22da244beab0
16	8b3cb148-8b55-4c34-89b3-6a52c0a92293	RS	2006-01-01	\N	current	aae2ba87-a67d-43bd-8516-e403843d61d9
17	7075c37a-63a7-4375-843c-99b9f5045928	GB	1974-01-01	\N	current	0f433ba9-47e1-4fe6-902c-632bf40355a9
18	0115f7e6-06c2-4771-b297-b5b4481ac1cf	GB	1974-01-01	\N	current	56c6dacf-b4d9-401b-874a-6518da0cd567
19	197288cc-905c-4ba6-9465-b07eff31067e	GB	1974-01-01	\N	current	c5bc507e-7bca-4c9d-8d7b-a3441b33dffe
20	90a492a8-4fc4-4f85-80ad-2afd8f517f85	GB	1974-01-01	\N	current	e054a323-d773-441e-9cbb-9843a1780b2d
21	79d34df4-5ef4-44a5-a2f3-de9ad694a81d	GB	1974-01-01	\N	current	c639dcd9-0e03-4f83-bdba-8a5a921b021a
22	b3a7a538-d1b1-4d4f-a77b-e26651eac7b6	AD	1974-01-01	\N	current	1965c743-cf9a-4021-9ed1-b9e4e77486a2
23	185da967-f31a-4719-a78b-b3a6cb75abd1	AE	1974-01-01	\N	current	2b1a33fe-be25-452b-8a1c-c7d5f1dce9c2
24	6fe46e53-ad5f-42d1-be3f-b7f9a98d66b6	DJ	1977-01-01	\N	current	0b48c87c-ddaa-49d2-b736-61d9c44636e0
\.


--
-- Data for Name: ISO_3166-3; Type: TABLE DATA; Schema: public; Owner: brook
--

COPY public."ISO_3166-3" (id, uuid, territory, previous_territory, name, assignment_date, expiry_date, type) FROM stdin;
1	152b1da8-6838-4d8a-af56-c0798a254f7a	b7b802fe-8789-4b6d-b085-7c25a92dab7b	af123316-5e2b-4453-9908-13434c758d89	FXFR	1993-01-01	1997-01-01	merge into
2	15545c5c-48ea-4490-a8b2-088668806d43	c5db5d6b-ebcd-4642-9604-0f1ebf2fdf9d	7fb270a5-06a1-4488-951f-55dcc7e822c0	CSHH	1974-01-01	1993-01-01	divide into
3	67104572-cd44-4a89-bcc8-850a43014b19	2dd507e0-8e57-4924-a57f-8fc2e22555e2	7fb270a5-06a1-4488-951f-55dcc7e822c0	CSHH	1974-01-01	1993-01-01	divide into
4	661d4907-a455-4793-93b3-036949c846a3	ba063fe6-f538-45d8-9450-81c536a1aa29	9081511d-8a3b-4372-b828-44afb55b2dc4	YUCS	1974-01-01	2003-01-01	name change to
5	5f15c19e-8bab-456a-bcc7-23f18bc44760	aae2ba87-a67d-43bd-8516-e403843d61d9	ba063fe6-f538-45d8-9450-81c536a1aa29	CSXX	2003-01-01	2006-01-01	divide into
6	a7316b8d-5928-43c3-88c7-928ea8e0cb02	6702177a-fbed-4cf3-aa32-22da244beab0	ba063fe6-f538-45d8-9450-81c536a1aa29	CSXX	2003-01-01	2006-01-01	divide into
7	0038ea48-aa8b-4616-b8f9-49a21874b9a7	ac8b13ec-0d98-4fad-852e-a351d68e6a16	509e1050-f5ab-4d6b-ba04-501765fb9ecf	BUMM	1974-01-01	1989-01-01	name change to
\.


--
-- Data for Name: ISO_3166-3_type; Type: TABLE DATA; Schema: public; Owner: brook
--

COPY public."ISO_3166-3_type" (id, name) FROM stdin;
1	merge into
2	divide into
3	name change to
\.


--
-- Data for Name: ISO_3166_type; Type: TABLE DATA; Schema: public; Owner: brook
--

COPY public."ISO_3166_type" (id, name) FROM stdin;
1	current
2	deleted
3	exceptional
4	transitional
5	world intellectual property organization
6	indeterminate
\.


--
-- Data for Name: demonym; Type: TABLE DATA; Schema: public; Owner: brook
--

COPY public.demonym (id, uuid, label, territory) FROM stdin;
1	5bb9df83-05d5-4339-93dd-eab4fa63d13a	afghan	b33be079-39b7-4a1d-b689-97c224d5fece
2	ec78d002-2dde-4e8d-a6d6-5f71a00bba36	ahvenanmaalainen	ca1a8efc-5d84-4e75-9f3b-5d005b9afca5
3	f720697a-3486-4fab-99f5-0c00d0b94460	åländare	ca1a8efc-5d84-4e75-9f3b-5d005b9afca5
4	7cdd1078-ab9e-49c4-946d-7a3dfb884e41	ålandic	ca1a8efc-5d84-4e75-9f3b-5d005b9afca5
5	c59f6874-ca15-42cf-8716-b1615a82161c	ålandish	ca1a8efc-5d84-4e75-9f3b-5d005b9afca5
6	d299f2f6-996b-4219-a894-39d2537f5978	ålänning	ca1a8efc-5d84-4e75-9f3b-5d005b9afca5
7	8c296818-85b7-4c17-8820-80dd687eebb2	albanian	6c7e4e7d-9bf4-4e47-b2e4-c925f54bcd1a
8	5de949d7-92af-4812-a2a4-201a998203bf	algerian	d9b8f8c8-5b5a-41ef-8538-26d822a4c9bd
9	69d03e78-550f-426d-aa60-4a80a1d77d15	american	0bea6297-7d53-49a7-927e-e5cbc57e3b5a
10	a7443747-c611-4959-944c-f6733f5fc967	american samoan	7d76fbc2-43bb-467f-b36b-1b899f3d013a
11	f49c08f7-07e3-4a6a-ae4c-5fd6d538428a	andorran	1965c743-cf9a-4021-9ed1-b9e4e77486a2
12	6be45a5e-12f2-405e-a00e-440b3821f315	angolan	bf07965f-f874-453e-a725-54c5a1254ee8
13	9aa167ae-f84c-49f2-a710-c47546c15d87	anguillan	793360a3-aa91-4703-acfe-60287e3f9b74
14	91139747-46d7-49af-8b68-14d05df4aaa9	antiguan	90de1527-d5a5-446f-a960-eccda43af198
15	736cb560-41c4-4088-8baf-304e15ed9704	argentine	78219cc6-d1b2-4193-9da7-e7abc92863ee
16	6283aedb-b2e7-4f57-b7ea-d533e2d05f39	argentinian	78219cc6-d1b2-4193-9da7-e7abc92863ee
17	6ca69135-3176-475c-b40e-699c50d8f3a8	armenian	f2f3e704-bb03-467a-a1a0-1d56b6faadce
18	b6e7f4a4-760d-4ffa-9df6-6440f1799d6c	aruban	44344c65-9381-42d7-a573-6a9e38ead0f0
19	059950ec-dee8-46de-ae22-45308e4875c6	australian	0a3e548d-7e30-426f-840c-07ff9b6772f7
20	a83a2f0b-86e2-4fd6-92ac-a086bff61da1	austrian	e14f7607-8074-4eeb-8b3f-3093575719a4
21	54806553-e2d3-4963-9e6c-6c3a806cfdd5	azerbaijani	319530a8-8cd2-4dc3-84a6-29ac720c51da
22	f7930574-dbfd-430a-b7ef-24ca8e07ccec	azeri	319530a8-8cd2-4dc3-84a6-29ac720c51da
23	1e27524b-a7ef-4741-ab91-e6963c24530f	bahamian	ac6434f1-bbb9-4242-a393-d78d367f034a
24	83e1e01d-ab7a-4980-9ab9-673b71f56a42	bahraini	497550d7-f9e9-4f1a-a5e0-8c9019c7bc31
25	fe5275cd-7ff5-41cf-8aab-76e5daad8b1e	bangladeshi	bb3fa754-b35e-45ee-8d66-fb159c96d821
26	e96ac471-3cb3-41a8-ab19-288f7b832bb9	barbadian	49494a5b-205f-4756-9145-2784c9269a99
27	6fa61f57-cce7-4deb-a5d5-b74cab238d8e	barbudan	90de1527-d5a5-446f-a960-eccda43af198
28	be51233e-60e7-4081-ae69-099d0c562bc4	basotho	f7ca89ef-b000-416a-b9f4-6059b2d8a3ca
29	da3576d2-103c-4167-8d41-2ba112153694	batswana	ff4c5033-aee4-4325-90cc-1f96ef10bbce
30	17b7647f-698d-450d-8410-d41c99d7ebda	belarusian	ac612169-1567-4c5e-a203-3987fa26c267
31	12a29e1e-94cc-496d-a76b-e0ecc0ce48d5	belgian	1f4dd261-dc57-49ec-b872-8b1917703616
32	de47e965-cb14-4422-bd36-eae6304faa44	belizean	3e62d48d-717d-4421-91c2-abb059a80576
33	02ec0be0-d20c-4e95-b6df-193cf617e9a0	beninese	5fbebc32-e410-4faa-94e5-822252f8b499
34	fdf647d8-e6e3-4993-9bc1-77cf50267edf	beninois	5fbebc32-e410-4faa-94e5-822252f8b499
35	c7b9fa2b-6b37-4b0b-8cf9-fdb9977de209	bermudan	5cbe7035-cbba-4ba4-9e59-1338db15983a
36	aea7dfa0-5d8a-42b9-a2ef-46563ce1d2ca	bermudian	5cbe7035-cbba-4ba4-9e59-1338db15983a
37	63ef1283-4a2a-408f-9e65-4539a0f1ae2e	bhutanese	1d58bd18-8519-4e53-8cd1-6a7e93cda614
38	7ce30b86-2bae-45b0-92ff-45597280d6e5	biot	83f3b190-021f-4694-a033-57058c22cbf4
39	83efa709-f2db-499f-bb36-8c2fc2116589	bissau-guinean	b3e98c98-8a15-45bf-8f86-f26f6a07a425
40	bacd911b-dc59-4cc8-9602-8c06187bfade	bolivian	546440bf-236c-4f99-bd12-3bba52d50e02
41	79393a08-17ba-4a3a-a61a-f7ccaa70b42f	bosnian	c103dabb-a386-4a6a-bce5-c0c0fa5f43f6
42	8b70be98-88c6-4f0d-86fe-187f1b97ac90	botswanan	ff4c5033-aee4-4325-90cc-1f96ef10bbce
43	6ac6f393-1738-49b8-a96c-552dba752b79	brazilian	1b558876-4f84-41fb-8215-93143842ba53
44	b3ba2a45-11e0-48b8-beaa-2f7f50eef574	british	0f433ba9-47e1-4fe6-902c-632bf40355a9
45	d9532755-c6a3-4ba5-98fc-ecf73ce5f9bb	british	83f3b190-021f-4694-a033-57058c22cbf4
46	88ced739-71b3-4c59-928b-af2a13d05ba9	british virgin islander	4fe94a12-77e5-4a49-94c4-6bff7b9f1b2e
47	0d7b2fa8-0fb6-436f-a428-4c6c040022cb	briton	0f433ba9-47e1-4fe6-902c-632bf40355a9
48	456734b5-d982-4fdc-b678-39758043dc7e	bruneian	49ca53d4-0d59-4be8-9724-70b0eff911ce
49	c216a5d1-ed78-42a5-b233-f5841d81e3ae	bulgarian	dde93861-da65-40d4-8159-3e67e8d58e02
50	f094676f-49ef-47e0-85f5-259b247e50ef	burkinabé	a22c7473-248e-4447-8bc7-1fc51c00ca3e
51	bacaefdc-227d-4c6b-beaa-5a38bada63ed	burmese	509e1050-f5ab-4d6b-ba04-501765fb9ecf
52	2800e8cb-24d4-4d7a-866f-1e847cbd7525	burmese	ac8b13ec-0d98-4fad-852e-a351d68e6a16
53	684ff5c9-ba69-446f-af73-03d857df2971	burundian	4f0fe689-81e0-4b91-a093-cad33a305482
54	006f2565-3612-4ced-a2a2-fab7d40d80cf	cabo verdean	0b35bd76-e5ef-4a77-bacf-46918e1d9d06
55	fd057303-0dfb-45ac-ab52-880d13741f80	cambodian	723de35c-616a-4b10-b479-c08378f3765b
56	bb81ba31-1f52-4493-877d-58a309437103	cameroonian	526f75ae-3c43-45a3-924e-1d7e11177a68
57	0c28dbbc-a854-49d1-9430-fae18eb729ae	canadian	e242cbe2-dc75-4807-a7c9-c171d164ec2d
58	813fa7c9-3c61-4aa7-80cf-0f859a316889	cantonese	ae7c2b6b-a504-4e11-a52c-97175217c0a7
59	3579ec59-acc8-4bd7-b6b1-2b7096d9554c	caymanian	8372a0ad-58ad-41f7-af06-dea7df6ef891
60	5994c272-3e53-43ec-8558-afbde1f90cb4	central african	2b1aaccb-5846-45c1-8481-12bb8b5e0aa4
61	9bc79e4a-667f-4390-ab1c-247693dc9cc9	chadian	3f759fc5-8287-4acb-b58d-f235c5ef4981
62	7fa829fa-4582-47c6-8464-c663bac64baf	chilean	c5a755fa-0935-4ec5-a880-3d4854beabfd
63	de9e1785-3095-419a-8a4f-3f3c70e63557	chinese	7178da96-360e-4b0a-ada4-9640c498daf8
64	0fd2c316-0206-4bfd-b605-219eef4660bc	colombian	8b58bd46-c2d7-4df7-8871-378dbe921468
65	a65dba82-8e0e-41fd-ad2b-8da08027354e	comoran	48847459-b1b2-4092-9bf0-f0c08b928c74
66	037dc7b6-b839-4de6-b892-dbb32cd2b50b	comorian	48847459-b1b2-4092-9bf0-f0c08b928c74
67	3412411c-5d1b-4f18-ae5f-720b9f4a60b1	congolese	196ed632-cc17-4b9f-87cb-cbc9832e8617
68	5f757289-675a-4d1a-8bf2-fad2b8f35e27	cook islander	9982d96a-7b45-4e8a-93c5-83056d6b0fc8
69	0244736c-7c33-4d5f-8e16-43968b670217	costa rican	cf56f0da-daf4-4437-9ad9-4b61bbedc31a
70	b8864c27-2075-4613-b0eb-b55b9b71c7f1	croatian	14730d5f-e0e5-43a8-bc67-ca9f92c8502a
71	0533c54d-be10-4dc0-8ee6-42731eff48c4	cuban	16a55dd1-2e47-489d-830c-3a88aad464a9
72	8934b9b0-77d0-461c-93dc-4d1cf61a9a82	curaçaoan	3ba46aea-ed4b-48bc-919d-a93a4d6f1d6e
73	c7592430-d3ac-4aa5-9af0-d98a973d67bb	cypriot	f36ec987-ed66-4a88-9157-b1d4a934e515
74	caf65208-5ec1-42c7-95e5-5682a1da7b5a	czech	c5db5d6b-ebcd-4642-9604-0f1ebf2fdf9d
75	e8f46495-e6ea-4850-a55a-1dd91ec2be29	czechoslovak	7fb270a5-06a1-4488-951f-55dcc7e822c0
76	bace64ba-87c1-41bd-ad44-1a317b50c47e	danish	870d8300-9c56-4b34-9447-bcdfedf8454c
77	356d38ae-505a-40b4-acd0-894c0e5f4e75	djiboutian	0b48c87c-ddaa-49d2-b736-61d9c44636e0
78	dc303af4-a86d-49fa-9248-ad2d0af1b476	dominican	a66c6aaf-f010-4056-8928-1653d670edf3
79	6f8ba89c-8165-44b2-bdbb-8adfbdd86729	dutch	437b6b0d-4fe4-4e6a-b869-9aca4351a182
80	234ec32a-0510-4f44-8de1-19867849107a	dutch antillean	437b6b0d-4fe4-4e6a-b869-9aca4351a182
81	623f421e-db8a-4b9f-88da-458ec8f96838	ecuadorian	41fa1fc8-a7c9-4045-ac6a-92fe36c27bd9
82	83142ff0-f8c6-445b-999b-748d08400a6c	egyptian	0d0a18fd-d424-4a69-b646-38fffd942dd5
83	b26d644e-d0e9-4650-b6f4-d5f68363660d	emirati	2b1a33fe-be25-452b-8a1c-c7d5f1dce9c2
84	279b5903-2940-4495-bfbd-eee3898f585a	emiri	2b1a33fe-be25-452b-8a1c-c7d5f1dce9c2
85	fd243454-e829-4373-8624-1771a4364ead	emirian	2b1a33fe-be25-452b-8a1c-c7d5f1dce9c2
86	c9e05c05-98e9-4286-8164-1a616ed2b80d	english	56c6dacf-b4d9-401b-874a-6518da0cd567
87	e188602d-d05d-4c27-8e41-305082fcbeb4	english person	56c6dacf-b4d9-401b-874a-6518da0cd567
88	58d7a8a7-1e3d-49e1-ab32-784ccba9e2f1	englishman	56c6dacf-b4d9-401b-874a-6518da0cd567
89	436b7f81-717c-4d20-80b7-46cad96cb22d	englishwoman	56c6dacf-b4d9-401b-874a-6518da0cd567
90	4eb987a8-c1dc-4bac-832f-c39fc568c89a	equatoguinean	43d35de8-4ed4-4bd7-9fce-54d9adcdeec6
91	ccfd6952-30fc-4f93-9447-70b5eca6862a	equatorial guinean	43d35de8-4ed4-4bd7-9fce-54d9adcdeec6
92	69b1ddb5-acad-4ca6-9fd9-75c858b70554	eritrean	b2db2210-e9b8-4d51-b3c0-ed8e3d6adc9b
93	c10d5f15-37ef-47f0-b369-1441ba15c385	estonian	061c7757-87bb-4acc-bfb5-ebb5a4dc9429
94	f0ab3bbe-cdc9-4bd9-83fa-17343bc17544	ethiopian	f76a50d7-c955-4658-a2da-f191b746b434
95	b9dae1f2-7a13-4420-9b32-2e09297f2523	falkland islander	ff772da3-5cb8-4833-a427-2651adf6fbd6
96	ba3a3322-b2ba-4487-bfc5-47e467cb33e0	falklander	ff772da3-5cb8-4833-a427-2651adf6fbd6
97	6a99b826-64e3-4852-9094-0d687c205f1e	falklandic	ff772da3-5cb8-4833-a427-2651adf6fbd6
98	17aa387a-eacb-4274-a04b-3abf1948115a	faroese	13ba7194-35d8-4666-bc59-4eb69058dc48
99	ff55739b-4222-490f-8ee2-5907e9b09ad2	fijian	923566be-1a81-4281-a9f5-fc3d8e59e53e
100	bc191daa-4693-4f1b-a57c-678cc5b53e3e	filipino	d29dcef8-e41b-4540-8f88-8849607ad3f3
101	dafdd9c5-563e-4fa7-a12c-26d6b086dc89	finnish	d322fe64-203a-4eb4-8316-2c6c1af401a3
102	5f37fa5f-f932-4d42-8772-0add0ab95f1c	formosan	7178da96-360e-4b0a-ada4-9640c498daf8
103	161e0e54-0bf3-4fb6-b4cf-a855c0ba0e98	french	74718d89-2c74-4664-a9f9-c3bda5884237
104	495d9f9d-86e1-4fa7-bc9b-9913e0b3cd34	french	af123316-5e2b-4453-9908-13434c758d89
105	6c5dea9f-4aa8-4b5e-a501-0b18c9c04a4e	french	b7b802fe-8789-4b6d-b085-7c25a92dab7b
106	e8d05bbe-5a06-44f2-a42a-d47f16f660c6	french guianese	fef2c7ae-f872-4a71-9c87-0d0727258c26
107	4965d1bb-413f-444e-8133-aa73a0e6b0cc	french polynesian	472108f0-b6a2-410c-9885-d4fa3b3412bd
108	ce75c613-6e6a-4e95-869a-04e281b67bb6	frenchman	74718d89-2c74-4664-a9f9-c3bda5884237
109	6e667ab8-4da7-420d-a1b8-303af1aaba26	frenchman	af123316-5e2b-4453-9908-13434c758d89
110	77fb47e5-04db-4b7f-9597-64e9338d7c72	frenchman	b7b802fe-8789-4b6d-b085-7c25a92dab7b
111	aeb76459-d865-4d90-8ca5-c76dea8a819e	frenchwoman	74718d89-2c74-4664-a9f9-c3bda5884237
112	91b60f51-2046-4bb6-ac92-4b7cbafa3a5e	frenchwoman	af123316-5e2b-4453-9908-13434c758d89
113	ed2f50c6-b9ed-4d1f-b8e5-564abadc15fd	frenchwoman	b7b802fe-8789-4b6d-b085-7c25a92dab7b
114	f70fd207-a147-42d8-a749-82d9e7238081	gabonese	6a95dca7-5bc9-438d-ba51-5cc4603d70a4
115	6c2b6b83-e6f8-42c3-aad2-bc505442b479	gambian	81e9890e-9239-4c33-b429-66950b214814
116	88bfdc2c-af03-41c4-9703-b8d014a64a1f	georgian	f2e17057-cb16-4fd3-92ef-07a6320c1818
117	82941afa-6f39-40b0-84af-e13fd11dee5a	german	d80301ed-7cdc-4f2c-8093-cfec014b077a
118	2e649f63-8383-4d74-99a4-367b280f33cb	ghanaian	53618499-ed33-49f9-aeae-e24d02029f1e
119	2bef0dd6-6dd1-4c5f-a2f7-ba981a733830	greek	1a76eb8a-5fca-4552-a0dd-9728217998b0
120	38881479-deb7-4973-948e-b1e41ea66494	greenlandic	5f5fad3d-69c4-41b1-bc88-d9b8cff77027
121	45a5d294-648d-452c-91a1-96c391c084a1	grenadian	aedfe3b8-fc01-41f8-a152-516e139dc8b6
122	d34b1b0d-e51d-4ada-900c-15c51d701918	guadeloupe	ba5a63e1-7feb-4d40-ae2f-d0a9f2123c0c
123	969acc75-0bd9-40fd-a761-a720ec0fad51	guatemalan	0e291c7e-51a2-466f-94b9-de8d9dec9dd2
124	7cf83a8b-6359-474e-a95b-de0656b76cf4	guinean	43d35de8-4ed4-4bd7-9fce-54d9adcdeec6
125	9323d004-9908-4ed5-bb88-1ceacf8aebd5	guyanese	f11d746c-8b82-4fe1-acb0-788067f0071c
126	52f30199-849d-4b0e-b411-6b6f5825e2fa	haitian	99530f46-46c4-4263-bd88-dca23dc0383f
127	40d2e445-1bbe-4664-9b16-d761764a1499	hellenic	1a76eb8a-5fca-4552-a0dd-9728217998b0
128	4abf9556-13d7-451d-b2f8-6ad34608ac1a	herzegovinian	c103dabb-a386-4a6a-bce5-c0c0fa5f43f6
129	36b31ee8-ddaa-412f-b11a-4c4c7352e521	honduran	3e33cfe7-603b-4d88-a6e3-f4dcc331d9f2
130	c75e4b3d-129a-414d-91fd-8c7e5adb3faa	hong konger	ae7c2b6b-a504-4e11-a52c-97175217c0a7
131	e097359f-65b4-4e50-9c29-3e7231e915a8	hong kongese	ae7c2b6b-a504-4e11-a52c-97175217c0a7
132	1ed38616-9b80-4287-b621-565d6cc9255d	hungarian	8287bea9-2349-46e4-9ac0-fb1e799497af
133	a9626461-8bb9-4f58-8f52-15886df3b83d	i-kiribati	8275007a-70b9-4a04-bcfa-1c23825d4874
134	d6960603-7242-4a3c-81ce-1ccb97983f8e	icelandic	68563b3e-8866-4310-bdce-659b3cc9c2ac
135	521abb3f-ca28-43a5-ac24-85539fea1250	indian	83f3b190-021f-4694-a033-57058c22cbf4
136	0c65535c-280d-46cb-8d9b-2dc4636f38ba	indonesian	a3122035-5d20-411c-a94d-17360ed55678
137	cd9b2a97-0a89-4067-9162-720fe432cab1	iranian	1baa5d83-2707-4a0d-8f86-45efc106dffd
138	c9adb103-efed-4390-8e81-5a89ff975778	iraqi	e130f15d-7a37-4ddf-a6b5-e9c1266e128a
139	27741afe-5c72-4f22-90bd-e44b7e6b3a61	irish	c639dcd9-0e03-4f83-bdba-8a5a921b021a
140	ef10e69f-b11e-4371-abd8-66cdd9b4b4ba	israeli	fc3338b4-47f1-4342-8def-3acabc77a994
141	f9ad8cd1-2e40-4119-8c53-ad94bd24fe5c	israelite	fc3338b4-47f1-4342-8def-3acabc77a994
142	67da980f-b120-4c75-afd6-e0db505d0ea2	italian	161a32a0-755e-430b-86dc-8f153f7de9b1
143	e174eef7-7e67-4397-8e25-9ccbe6adde98	ivorian	31d93d6a-5130-4cfa-87ba-90d971d98d34
144	c0004d72-7a73-4fc4-bdac-6864498e44a9	jamaican	96abeca6-c08e-4df8-b22f-2fefc55a8d5b
145	a8532ca7-a60d-4a14-9aef-2d936a572255	japanese	8e5a125d-73cb-45c1-a511-f0c65d7448e7
146	3f9857cc-3a63-48e0-812d-0c3c9ddfd973	jock	e054a323-d773-441e-9cbb-9843a1780b2d
147	4ceaa66d-e3fd-4d19-a4cc-2e1ec8d52a3a	jordanian	c728bbe4-373f-4d0a-9a3f-985679759733
148	4eb296d1-4ba4-4120-919f-a94e07b02914	kazakh	c6a8ea7c-3fed-4a1d-9929-5569db7ab968
149	7e77c280-0e9d-4a67-81a2-6ca40e1bba84	kazakhstani	c6a8ea7c-3fed-4a1d-9929-5569db7ab968
150	a35a64f5-3a97-4747-85c8-0ff93d46cece	kenyan	e91cae72-f62c-407e-b388-3f3b86f7a0c3
151	7b54bd51-80a0-4f42-a436-db760455b98b	kirghiz	6cec735b-3406-430f-be56-71d96ff8f41e
152	ed9e077b-cde2-4906-9e45-fd99afa715f1	kirgiz	6cec735b-3406-430f-be56-71d96ff8f41e
153	3185ec61-9d5a-4309-a5b9-ddef8f48fea0	kiribati	8275007a-70b9-4a04-bcfa-1c23825d4874
154	0b0f2747-d3b7-4eb2-9cad-a93f0f6ae156	kittitian	ec506881-6436-49fc-b56e-42da02dd7d5b
155	3eeecca3-d060-43c3-bdbc-544e77164171	kiwi	ca1a8efc-5d84-4e75-9f3b-5d005b9afca5
156	b7212f02-9f3b-49f2-a844-ab98b2f9daa3	korean	52dc85c7-9f30-470a-9de9-09b95bc11e86
157	3bc96ff4-2124-4fc7-a328-c78198f541e7	korean	9ad23145-f384-4a8f-a075-4648d1837d46
158	052112a6-62d1-48bb-9120-2bbb0679593f	kuwaiti	ab2a946c-f1e3-43f5-bbfd-4b54adae333a
159	00e83059-1c40-491d-93be-e8bb21a72b4a	kyrgyz	6cec735b-3406-430f-be56-71d96ff8f41e
160	9a21b322-b497-4cf0-b428-665d3d6dbc3b	kyrgyzstani	6cec735b-3406-430f-be56-71d96ff8f41e
161	c8caf832-323e-40df-8c65-64502bda623a	lao	34e549be-e921-419a-a64d-2349902ee1e8
162	c37bce91-91bd-4f14-b02e-7b501bb73790	laotian	34e549be-e921-419a-a64d-2349902ee1e8
163	491974ef-cbe0-4832-b8ac-f3c704baa70e	latvian	85b0fd58-f24b-4249-a31c-46e40023744c
164	8c7125fc-5859-47db-a1ff-3e6a01f32ac6	lebanese	6a6a8869-35f4-4d7f-af9f-c881d3b4bc19
165	7bedf739-e32f-4337-b862-1e583c8c188e	lettish	85b0fd58-f24b-4249-a31c-46e40023744c
166	9e3c2df3-9f58-4363-b3f5-b7068732fa8c	liberian	e3c9a7c1-e5ec-46aa-be24-13a63b23c24a
167	13043fd5-f60a-4d2b-af7b-e2ae10aaddb4	libyan	a9bc64d6-1f2e-4882-90bc-4930614667da
168	010e1e07-f7fb-44d8-b688-b97902fac4e4	liechtensteiner	8510166b-62a4-475f-8afe-891fe1cb22a0
169	268c82a0-d246-4079-b95a-4ccc52fa891f	lithuanian	d4d24a30-2184-4fd3-8315-248ddc094526
170	6a88ddad-bdc2-4c97-b547-029b7e31f73b	luxembourger	a94b35b0-c269-4e9f-9d66-80d8f3081989
171	34ebcba7-d7d0-4f5c-bfeb-871e83884963	luxembourgish	a94b35b0-c269-4e9f-9d66-80d8f3081989
172	67051b5b-79db-4859-82b3-164b2084019d	macedonian	6b9ca8c2-1096-496b-9aa2-0a0dc3fb4f32
173	7269fa0d-b9a3-471a-8024-933e6b4f3be0	macs	e054a323-d773-441e-9cbb-9843a1780b2d
174	75730273-8c38-4ccd-a4ce-da27c24bf341	magyar	8287bea9-2349-46e4-9ac0-fb1e799497af
175	4ea90a77-0ec7-4f4f-8d78-66a412096f34	mahoran	4f7bf3fc-1cdd-42ea-acc1-2325444ea405
176	38fbba4b-08ec-4abb-9c6a-5334e69e40e3	malagasy	b7206cc1-2cca-454d-9447-3788640f7b5e
177	0f4e2476-7ba5-4dcc-baf2-67e4203e6abc	malawian	413fe813-55c0-49e9-8853-47654b4ae73b
178	cde30621-ab4f-4a98-a9a1-576d62d930ca	malaysian	d42ac9fd-1e10-4995-8dc1-4d25cee7a022
179	6107e973-5a87-4891-a4aa-13b6394e57b4	maldivian	2b8d132e-e3b8-4a97-aa78-a265bf65836d
180	46608caa-0e8c-443e-a0a5-43b1df2ab981	malian	a8c0bf67-69a5-4293-8282-622c6b61962c
181	d31599b7-62e3-4235-b864-7c63c57b643d	malinese	a8c0bf67-69a5-4293-8282-622c6b61962c
182	81e88a54-90cf-4071-8670-b3ce932ad619	maltese	ca8f94ef-b748-47c8-b040-b996e3cf2581
183	430c3ee7-ad9e-4351-aee6-26f3073b495c	marshallese	27f40e7e-ab08-4e44-b643-f9546021f2c2
184	56231a6a-3418-4c5f-a3bb-f2711e135bdf	martinican	07546102-9696-4e5b-80fb-c435267230aa
185	36321a10-bd36-4a99-8e6f-2659aefea8fa	martiniquais	07546102-9696-4e5b-80fb-c435267230aa
186	75258b1e-3559-47c6-b693-c6727ffc587d	mauritanian	a4d1f62b-6131-44de-92fe-975d0a463bc7
187	e858aed4-75ff-4b99-9909-86d42a6ad7be	mauritian	59a60488-bbd7-476a-813e-a92fa901e8e7
188	a51d37aa-ecce-49cc-8b19-a72e4adde127	mexican	846ec109-79bc-4e46-a303-40e20bcb2f36
189	a32c7d4b-40b9-45f0-8577-184dbb0dae04	micronesian	0343465d-616b-4419-b3ac-6e358776cb2e
190	3ff1bc67-6c38-43fd-8de2-42c7634f4b27	moldovan	6f37afd2-3170-4c9d-8fde-28d6a44eda0d
191	e41dbcc2-52c3-46a0-965e-2a2df5c7065d	monacan	e1b6cef2-9a2d-441a-96db-2cb815ac9398
192	d6748201-3d09-4b47-843d-6bad5b519888	monégasque	e1b6cef2-9a2d-441a-96db-2cb815ac9398
193	938229f7-458a-4f70-be34-5a2f04496034	mongolian	b60fe946-71ac-40be-97dc-8ee0b78c3384
194	b3eefcad-2f2a-4425-a396-d3fa04feba7c	montenegrin	6702177a-fbed-4cf3-aa32-22da244beab0
195	8c949c04-f6b7-4308-a656-8c9a48bf756a	montserratian	adc6de52-b3d9-4448-a7d6-39622cf3261f
196	0c183ccc-a681-4ae4-8005-5e31b7825a92	moroccan	a7462d3b-b094-454a-a09c-08573a566463
197	e20659d7-9a3f-432e-b650-37e11c6e2a50	motswana	ff4c5033-aee4-4325-90cc-1f96ef10bbce
198	ab640f61-3786-4c23-a324-d9b5ccefaf7c	mozambican	95251d34-e411-4cb7-9112-0a1f95b239e0
199	621c55e4-4f56-4454-b6a8-a5c30e61c107	myanma	ac8b13ec-0d98-4fad-852e-a351d68e6a16
200	b659e3b2-a41e-4be8-93a2-731554abab38	namibian	dff0e275-70f0-4d4b-9d4a-3b4029ab3cd1
201	bb0b1267-778e-413d-aa23-e69cbbc2e517	nauruan	c00f0e5e-a315-4118-b879-8d0a07faa486
202	4eb79502-51ac-4a54-85d3-fc1667f33eff	nepalese	52a86412-42e6-499e-a742-a0902ca649b5
203	073e13bc-e828-48d6-aa85-40dd29722a11	nepali	52a86412-42e6-499e-a742-a0902ca649b5
204	8206ce0d-3897-4efc-8e1a-089ee4eae1aa	netherlandic	437b6b0d-4fe4-4e6a-b869-9aca4351a182
205	ed585472-537b-45d7-8a59-39c127c36a87	netherlands antillean	437b6b0d-4fe4-4e6a-b869-9aca4351a182
206	f03597d7-8361-4d75-a7cf-66d132afd6ee	nevisian	ec506881-6436-49fc-b56e-42da02dd7d5b
207	0c7e710d-6cf7-4f01-b54b-57ed5948d1b0	new caledonian	17b783e7-ad5c-473c-8787-aab9c9397fed
208	23f91bd5-8184-4d62-acf3-686ac9b178ef	new zealander	ca1a8efc-5d84-4e75-9f3b-5d005b9afca5
209	de1f0b42-5978-40e9-98c6-7d9103280721	ni-vanuatu	33f94df7-cd4f-487a-aa5c-fb45b65f19d5
210	49f47428-1786-4f58-bcae-e2713947dd0c	nicaraguan	390d0b06-0892-405b-93f4-8b1b69af9667
211	a9712752-c00f-41e4-87c3-70a5f2955545	nigerian	363bc536-025f-4ef7-95c0-a083bb8f37e6
212	951f7367-6876-4ee6-8666-d5dec5acbe22	nigerien	363bc536-025f-4ef7-95c0-a083bb8f37e6
213	0119e4c6-53ec-4439-abec-c5a19fc87d56	niuean	25064811-fb8f-487b-a95a-acce0aebdb8e
214	8723d912-403b-45a9-b901-a58c6418e7d3	north american	0bea6297-7d53-49a7-927e-e5cbc57e3b5a
215	cb56cf44-0197-4d4c-8aef-690bd878ef8b	north korean	9ad23145-f384-4a8f-a075-4648d1837d46
216	3c100302-b847-4efa-bc35-897cf4c41227	northern irish	c639dcd9-0e03-4f83-bdba-8a5a921b021a
217	96924ed1-2d18-4057-886e-0516afcf7de0	norwegian	4f50cb61-60cb-48f5-9c7a-974d9c3840d5
218	65620461-12a3-4f89-bc45-ef226d833d89	omani	7a1e411c-5e2b-4ef6-9561-73a4466af643
219	d645a6f7-f524-4d5d-b711-52ef66b278cb	pakistani	abc45575-6e5a-49c5-9967-e067a503c8a6
220	67559779-de58-4ad4-99e2-d9171054a010	palauan	43e7d908-36ff-47b2-813c-146e89e91aef
221	b55e7b86-5228-4564-ba41-de375a1a0ee5	palestinian	6ed0c70e-c6ab-4148-aae3-fbf474467390
222	c640f2b9-c62d-4244-9bbb-1bfb4281ae7c	panamanian	e32cd55b-2b25-444e-beb4-f86a6e81819b
223	1e68d1dd-6eb8-4ca3-ac0c-120b5c5db2c5	papua new guinean	b3e98c98-8a15-45bf-8f86-f26f6a07a425
224	9167af98-b398-4d76-8fa0-5522c4d1cc32	papuan	b3e98c98-8a15-45bf-8f86-f26f6a07a425
225	d919fadc-3ac6-4056-897a-fe9e8112cc96	paraguayan	5091a6a9-aa19-4e48-890a-d0d3ccce88c7
226	f250d9d3-801d-4237-b8a5-a1ea35f36baa	persian	1baa5d83-2707-4a0d-8f86-45efc106dffd
227	e56aa042-fe00-460d-9612-4ef4c915d931	peruvian	6fd50499-8698-4764-a9ea-d063e211ae85
228	e6f93f1e-14d1-452a-bb56-2e83ca8c28ad	philippine	d29dcef8-e41b-4540-8f88-8849607ad3f3
229	be95d04c-6f0c-4047-8b4c-3b22b161fd43	pitcairn islander	6fda58dd-3eb4-49f9-8f07-8e0c4562675b
230	7f97669a-d00a-46c8-a941-c31f26bfc6e5	polish	9a7ad7e0-1e36-4004-9879-568b56d0cf87
231	0b220824-f35b-4e87-aaca-7fb48f8e95bc	portuguese	c2f84d45-aa39-4df1-8a87-e4dd0c5b34a1
232	90f0c6da-6517-4ce1-9d9a-bdd7b3303777	puerto rican	f18ec7fe-184e-4e4b-9ac5-14c5bfbf1fb7
233	15d7b7e2-19c0-44da-b7d0-7181e0169b35	qatari	90a93353-4714-42fc-8632-09f25bc1312a
234	2a6dc028-6904-4e8d-8e12-5d43212fd5f9	réunionese	e600ef6e-e2fa-42cd-a54e-60cd0a48c98f
235	aae0c382-7517-4de3-b157-1f981a01da51	réunionnais	e600ef6e-e2fa-42cd-a54e-60cd0a48c98f
236	a6e5076d-309e-48a8-b3f1-4411ca99fc8b	romanian	7a1e411c-5e2b-4ef6-9561-73a4466af643
237	3668657d-b207-4416-925e-5383a2e1acd5	russian	ae5dee3a-1222-4f42-9f97-470ab88b3b7e
238	aa2502ae-51c6-4b41-8b04-e59a311a6151	rwandan	418d8911-a62b-4686-bf0e-f18b204398d8
239	591583e6-8a56-47ba-b9a6-bc78834a17fe	sahraouian	7c843d31-a3b7-4fd6-854d-a41fd456ab79
240	c83051bf-f7ef-44b3-b812-4ac2ab1454b4	sahrawi	7c843d31-a3b7-4fd6-854d-a41fd456ab79
241	08e089f7-78d3-4456-8ebf-56f9a4494ddf	sahrawian	7c843d31-a3b7-4fd6-854d-a41fd456ab79
242	37276d05-c4c2-4007-909b-64a4ac8accfd	saint lucian	e3b26362-6759-4612-8863-4785505a679e
243	97b008c0-1c3c-4b1e-96ea-86a1d345e2ab	saint vincentian	54824162-df76-4f5e-8783-404687f907f1
244	ea1514f5-2826-4a9f-bf35-8caae1adc04c	salvadoran	bae2df87-ee9b-4efe-8482-2b05b54ebb11
245	0afd51aa-18c9-4d1d-a8dc-43390dc88c79	sammarinese	1bc1c6a9-2028-4dcd-94bf-6d19bea049e6
246	f00092c9-ebc0-48d7-9b8b-d8d52a92fa3d	samoan	7d76fbc2-43bb-467f-b36b-1b899f3d013a
247	9a08b961-a0cf-4d5e-b221-4b135a3c7445	são toméan	ab4bc3a4-7c19-4a94-905c-a7973e0feaff
248	8dd9322a-840a-4f3f-8885-a5ab7fd94493	saudi	dfffd0b6-a252-421b-94cb-6d44695c5c8c
249	632a50e6-1304-44fc-a88a-36df6506d70f	saudi arabian	dfffd0b6-a252-421b-94cb-6d44695c5c8c
250	a0df2404-6546-47f1-906d-7fdf5b360fe6	scot	e054a323-d773-441e-9cbb-9843a1780b2d
251	eb3d38e6-8b35-4188-a99f-7cd2249926e2	scottie	e054a323-d773-441e-9cbb-9843a1780b2d
252	207245e1-5b61-48e9-8545-fe402145a27e	scottish	e054a323-d773-441e-9cbb-9843a1780b2d
253	506f9cb7-09c5-4eca-9c1b-d4ee983ab775	senegalese	e98795b2-4086-41b5-bac1-4789d9aee005
254	4a36669f-0418-4e7e-bb72-b1c15bf492e2	serb	aae2ba87-a67d-43bd-8516-e403843d61d9
255	3d706acf-d160-46bc-862c-22747e26bc7f	serbian	aae2ba87-a67d-43bd-8516-e403843d61d9
256	49fa8864-6e27-4b93-bd6a-d8e8f72ac50d	seychellois	4998e162-96ca-4381-ab19-3dc43922884a
257	8cc94ece-7316-442d-a6a3-e7683c407012	sierra leonean	d8df4bc3-503b-41ca-987e-423e41ecb52c
258	e965605d-21ca-4583-beae-31220666c6c9	singaporean	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db
259	70b679d2-d5fb-4eab-b42c-6d81df1e3338	sint maarten	f873ab5f-e175-4a90-9e0e-1efe1d0880ff
260	f8fab8b6-4ee8-47d6-8ad7-d0e27469c606	slovak	2dd507e0-8e57-4924-a57f-8fc2e22555e2
261	5df8d172-e242-47d1-9372-60785a5c9631	slovakian	2dd507e0-8e57-4924-a57f-8fc2e22555e2
262	409926b5-ef52-4508-95be-a3a6d3dda66e	slovene	dbc583de-b4de-46ba-aae0-1e8d35054bf3
263	007735d7-0889-47ea-b569-bef1c5af41d8	slovenian	dbc583de-b4de-46ba-aae0-1e8d35054bf3
264	2b98796a-87c7-40de-aa4a-50970bb026a5	solomon islander	b7f76500-4fa3-457f-aca8-477f05aab728
265	8c3e8a3c-c7a1-4792-a61a-2bda0d65ca7a	somali	a8c0bf67-69a5-4293-8282-622c6b61962c
266	0cba1a29-52c0-4f23-9123-f6ad8cf517f6	somalilander	a8c0bf67-69a5-4293-8282-622c6b61962c
267	b973749c-de6f-48f4-8133-66e6e8820051	south african	247ff0fd-78ad-4ca4-90f2-f0394a714535
268	4fa5a9c5-7c51-48b1-a179-3070ed048e63	south georgian	f2e17057-cb16-4fd3-92ef-07a6320c1818
269	c4172830-985b-4013-b0b0-4b13ed3c2321	south korean	52dc85c7-9f30-470a-9de9-09b95bc11e86
270	8122cbe6-142f-4734-b72c-ba869976212e	south sandwich islander	f2e17057-cb16-4fd3-92ef-07a6320c1818
271	9853acf2-49dd-4d37-a359-135d48a8f550	south sudanese	3ffea3be-1c82-411a-b085-933205f900c7
272	d0084f20-051d-4acf-be82-742c0223d7d1	spanish	02e5c743-3075-4226-8c1d-ad97dadda3d8
273	4264c1b9-93f3-4a40-8329-583d024b654e	sri lankan	6c6c9e3f-2353-431c-83c4-2c0cc6c42ff6
274	3681a15e-6046-4501-ab07-6839c10f14b8	sudanese	3ffea3be-1c82-411a-b085-933205f900c7
275	225d4c61-9c89-48c9-aee9-df59c9004943	surinamese	e0e0a4c5-9076-4a1e-949f-9dd4521eb0f3
276	01f396ec-7696-478b-867d-dc4dc8eaaa07	swati	188c245e-16ba-4c8b-a894-dcfd252e6735
277	2df4a065-8956-489d-a454-1a37fae9cd8c	swati	188c245e-16ba-4c8b-a894-dcfd252e6735
278	a3cc3bf6-9568-4cfa-9ea1-b50703928b84	swazi	188c245e-16ba-4c8b-a894-dcfd252e6735
279	e5997e61-4e76-45a4-84d7-e3a8aa34bbd9	swazi	188c245e-16ba-4c8b-a894-dcfd252e6735
280	8fa122fc-2f6a-49bb-82fa-692826813d42	swedish	5c3dd764-6824-4689-a3e1-1d8c2dc3bc93
281	d800266e-fb07-44a0-b810-1147a8739827	swiss	dacd5cdd-8e56-4067-bfd8-febc66a04058
282	bce81a07-057f-40e8-8280-a64feaef7ab0	syrian	7073c668-a71d-4cf0-a8dd-71008877f8ca
283	800ca7a5-9063-454f-a59e-5b412f2acd04	taff	c5bc507e-7bca-4c9d-8d7b-a3441b33dffe
284	794c71e4-c792-400e-9549-b20e78eb63e1	taiwanese	1f6e1df0-b5ff-4eb0-89b2-0bd06cf52883
285	0afce5fd-bc02-4fb7-b9da-19b5610f940b	tajikistani	893ca48d-0871-46b1-b299-4bf7e7c98dfa
286	ad03ed44-bed2-4ed7-a53a-7f73b5673b8a	tanzanian	1bf315d2-0a2d-4686-9ecb-6d28f8a5b861
287	71901158-adaf-4002-8f04-f9d6e3cb7849	thai	99d1c02c-0a04-4eae-b6cd-403f94e43959
288	16208f3a-3543-4d07-95c5-33c4654f182c	timorese	1a61eb0b-45a3-4b91-89c2-c22a20676491
289	95996ba3-fdac-4121-a482-c14645859afa	tobagonian	06659bc5-9958-457e-ac56-2860917a3d28
290	212092ee-26c7-4413-b0fd-b722fac8c3f2	togolese	1a7ba610-72c3-4816-81b5-aad9503a4a9b
291	e3ef2e80-d5b1-4452-869e-58cde8883fb2	tokelauan	ed22e6e0-5acc-4f0a-9a6a-e85dac1fca31
292	f1196b7f-b93d-4c67-a294-85f7bb0e531a	tongan	85e41f4f-c125-4753-bbed-c2ffc7e1c288
293	16b4156b-468b-426d-8768-f996265d889e	trinidadian	06659bc5-9958-457e-ac56-2860917a3d28
294	4ce04231-34d5-44bd-8dfe-0ce356fbf862	tunisian	cac7a781-be5d-4c59-b9b8-d8bb65fb1487
295	e0e2bd9f-12ac-4493-878b-8a766d81e234	turkish	fb99fe5c-118c-44d8-97ba-6570cdb7bd33
296	f127422a-fb4a-4d75-a8cb-8927a7e86659	turkmen	0adc54bf-ff91-4cb0-8571-d89b779f1061
297	49c4df80-7605-4cb1-ac67-b904ad6cf62b	turks and caicos islander	29c528d3-2b84-4b14-adec-78d0f7a06fc1
298	08311f1f-9916-4710-999a-b437fc16842b	tuvaluan	6596da04-74ae-4968-9776-6a7debe1b0aa
299	dba17955-6325-4404-9219-12d60a2de8d6	ugandan	c5ce24da-dd58-4e8e-a5e3-91b478717bb4
300	db9f3089-0232-4e0e-94fa-0112d93d4b3a	ukrainian	6b63bb5b-0238-4263-bdf4-8064a4fb5c26
301	7e0c3d1b-daf2-4e1a-a5b9-6253edc2ae8b	ulsterman	c639dcd9-0e03-4f83-bdba-8a5a921b021a
302	655b32c3-464b-4c27-aef0-365044a3f78d	uruguayan	d95a4486-5ca4-4500-8b10-211b945552c8
303	5e326e22-d56d-44f4-a2c4-725d250c3c88	us virgin islander	cd560671-9a56-4d59-a90b-3fc5876c54a8
304	e463009f-f99c-45cd-93db-f357f2508630	uzbek	19c52566-e35f-44fd-8130-d64562928fe2
305	eb424206-6d0d-4c46-8f67-4129dbf2ea40	uzbekistani	19c52566-e35f-44fd-8130-d64562928fe2
306	89ecbcde-df71-41db-b1ce-1e330bf1dcd8	vanuatuan	33f94df7-cd4f-487a-aa5c-fb45b65f19d5
307	fe43dae5-2ad9-4346-8d40-c8a48529e8ec	venezuelan	3a93a29d-abcc-45af-8915-8e983662c88a
308	f16b631d-962e-4a6e-8423-039028a1419c	vietnamese	ec48dda4-e153-4854-9bc3-453263e606b1
309	a9b12328-6541-4624-9ebd-8d015f5fbe89	vincentian	54824162-df76-4f5e-8783-404687f907f1
310	e5a9724f-b260-4023-8db4-bb59e95ab8a8	virgin islander	4fe94a12-77e5-4a49-94c4-6bff7b9f1b2e
311	12d92592-acf2-49b9-9266-b22a1bb0e097	virgin islander	cd560671-9a56-4d59-a90b-3fc5876c54a8
312	e8d2a15d-fd73-4888-8777-6f71e6995674	welsh	c5bc507e-7bca-4c9d-8d7b-a3441b33dffe
313	bdd075e7-dd35-4547-85c4-0f48a52088ca	welshman	c5bc507e-7bca-4c9d-8d7b-a3441b33dffe
314	3a19039f-deed-4fda-847c-ffa1b6198ec4	welshwoman	c5bc507e-7bca-4c9d-8d7b-a3441b33dffe
315	8529fa78-36c2-4f18-8f9d-890ec70c353d	yemeni	9da8253b-a4dc-41f8-b8fa-e751b6812191
316	23dc8a1a-b3fa-4c7a-b8fc-7424b2df9b53	yugoslav	9081511d-8a3b-4372-b828-44afb55b2dc4
317	c1f7c4be-dc1b-43be-93cd-24731a642657	yugoslav	ba063fe6-f538-45d8-9450-81c536a1aa29
318	a5c375d1-4410-4141-849e-903d951e6dc4	yugoslavian	9081511d-8a3b-4372-b828-44afb55b2dc4
319	8ae98c59-d7af-4263-b3ea-875868fa588a	zambian	40fbcdb1-c386-45b7-946f-7e4190dcc02c
320	7914b626-7fb1-40f3-b799-6f43f3b86738	zimbabwean	39658cd7-be12-4512-8a90-0b2cc9b2769d
\.


--
-- Data for Name: language; Type: TABLE DATA; Schema: public; Owner: brook
--

COPY public.language (id, uuid, name) FROM stdin;
1	c037e229-3731-4118-bea4-64cd069afbc8	english
2	e6611c19-fe1f-4086-8eb1-bb0d5620e5d0	uk english
3	08260f08-1fec-456d-ad5e-660cbc7f1c4c	standard english
4	edc7faab-cc45-48a1-8a42-8794e36b1e56	northern england english
5	3a64b4cc-a944-4de5-b4a1-e43aa06bd453	cheshire
6	aab443fd-b97f-4227-8460-252bdc963676	cumbrian
7	93d099c3-e59f-4fac-8626-61aea08da79c	geordie
8	ef358155-beed-4d7c-a192-3292d36cdb5a	hartlepudlian
9	ec559dcd-d33e-408f-ade4-ede2fdb8f268	lancastrian
10	642175da-eae4-4c57-8738-a788b222f53e	mackem
11	d4abb8bb-abc0-4e68-8de7-509b25e49aeb	mancunian
12	153f0c0d-19e4-4daa-b8ce-96f17e02cff2	northumbrian
13	ccb43e2a-a80b-4928-9eda-e7cf1cc40869	pitmatic
14	6e24223b-f5ff-4fad-aadc-bc408804a96e	scouse
15	a94ba838-0739-4e4e-a8c6-6395925a0d47	smoggie
16	308f62f4-ed24-4044-a357-8e4002758712	yorkshire
17	1d6f2e5b-cf55-4610-82a3-554550bbafec	east midlands english
18	7e0f0c88-617e-4fdc-b932-6014095c40d7	lincolnshire
19	568df935-3bd4-4ad7-b15d-a5207ad55d7b	east lincolnshire
20	805c0a97-3a1f-4dd4-be40-d010fa1ef649	west midlands english
21	1c793214-2fa9-4fd8-8c6a-12bf2323f6f7	black country
22	8b6fd7bc-a736-46e0-9302-ef7b3085989c	brummie
23	25c92819-94eb-4a2b-a90c-30487f971e99	potteries
24	bc8387d0-dcfd-4218-b98a-4474fddbd7e4	coventry
25	34736690-6d67-45f9-a131-ba50f97b42b3	east anglian english
26	73fd776f-97f0-4c33-a08e-0d2dc5d38ad8	norfolk
27	e8eb5128-600f-4cd2-88d5-1f6d7f082975	suffolk
28	f1d5efe1-8d4d-40eb-87e1-095e984a6ad4	southern english
29	17653e00-0701-492a-9027-98e9011ba117	cockney
30	5953e4ea-1028-47aa-8f40-43c896c6ac75	essaxon
31	bbf336ff-f76d-4785-a84f-43e2d7a69fc7	estuary
32	64bd2f79-1385-4c3f-9d01-d3a1dcdae9f4	pompey dialect
33	b82db911-e952-4a8a-b6db-511e58eb6a3a	kentish
34	16ab38f0-d2e0-46ca-83e6-a924e92ad743	multicultural london
35	8bd7f9cd-36e1-44b2-9d48-bcb0c2a75152	sussex
36	d5b9bc9b-6b19-4986-b5d8-1ab08f914fd1	west country english
37	2b3ba231-a783-4c17-a25c-6436be10dc9e	anglo-cornis
38	5f06c74e-ba40-447f-9bc3-0229aca25c25	bristolia
39	fb4c3bce-35b2-4c42-9c6d-5d938cc8a695	janne
40	80772a3b-361f-4960-9dc3-3ddb5278659d	dorse
41	d9477607-b4ca-46a3-a583-3fe1d0efacc2	international english
42	0be0340a-e78b-4846-9feb-74d73c34e450	received pronunciation english
\.


--
-- Data for Name: language_label; Type: TABLE DATA; Schema: public; Owner: brook
--

COPY public.language_label (id, uuid, label, language) FROM stdin;
2	2a15fedf-e156-480c-a129-1180e9c13e03	English	c037e229-3731-4118-bea4-64cd069afbc8
3	21102d76-a9e1-4eb9-9064-48f0a2cfc41f	English English	e6611c19-fe1f-4086-8eb1-bb0d5620e5d0
4	35a959ba-4315-4ab0-a2ee-49150eb93658	Anglo-English	e6611c19-fe1f-4086-8eb1-bb0d5620e5d0
5	5f3c5135-0ad5-4b2c-a2da-d5ffee7c48ea	British English in England	e6611c19-fe1f-4086-8eb1-bb0d5620e5d0
6	67a6df85-88bd-4213-8692-a592be3483ce	Standard English	08260f08-1fec-456d-ad5e-660cbc7f1c4c
7	ed9038ca-3062-4abc-8d7c-8d09d78365ce	Northern England English	edc7faab-cc45-48a1-8a42-8794e36b1e56
8	8b17683e-4940-4950-9570-6f5099aa642b	Northern English	edc7faab-cc45-48a1-8a42-8794e36b1e56
9	bee5ce83-cef8-476d-b40b-71bbca6e84d6	Cheshire	3a64b4cc-a944-4de5-b4a1-e43aa06bd453
10	59c206bd-c18b-4581-b24a-21ad3705edd3	Cumbrian	aab443fd-b97f-4227-8460-252bdc963676
11	2f7ba6e1-4f8f-4bd9-a1f5-86d6c48db8e6	Barrovian	aab443fd-b97f-4227-8460-252bdc963676
12	4fbbd431-7f20-4b62-a8f0-f683165aa8e3	Geordie	93d099c3-e59f-4fac-8626-61aea08da79c
13	46b3167b-ffbd-46a6-ae7f-4a936f94b77c	Hartlepudlian	ef358155-beed-4d7c-a192-3292d36cdb5a
14	62963806-5913-4ea5-9ee1-02fa9adb0462	Lancastrian	ec559dcd-d33e-408f-ade4-ede2fdb8f268
15	761b63fc-a3ba-4352-9009-057970c833ed	Mackem	642175da-eae4-4c57-8738-a788b222f53e
16	c259d541-242d-414a-84e2-65220987d287	Mancunian	d4abb8bb-abc0-4e68-8de7-509b25e49aeb
17	7d82966b-ae91-4841-9007-14ffa652d455	Northumbrian	153f0c0d-19e4-4daa-b8ce-96f17e02cff2
18	e7f39bc1-41f7-4ab8-9aa1-4c34c638664f	Pitmatic	ccb43e2a-a80b-4928-9eda-e7cf1cc40869
19	5557138b-3be8-4682-a20c-8fb8906cc998	Scouse	6e24223b-f5ff-4fad-aadc-bc408804a96e
20	0ebc991a-5e9c-46fc-b8ee-3996570fcb65	Smoggie	a94ba838-0739-4e4e-a8c6-6395925a0d47
21	bed972d4-1c7f-4a2a-b74b-a92eb437f8e0	Yorkshire	308f62f4-ed24-4044-a357-8e4002758712
22	0bc88f01-1bb1-41cc-b257-e02a67782dbb	East Midlands English	1d6f2e5b-cf55-4610-82a3-554550bbafec
23	0e22e3b7-2cba-40c9-8acf-54129a09091c	Lincolnshire English	7e0f0c88-617e-4fdc-b932-6014095c40d7
24	d463cfc1-0185-4787-bc8a-32a6adf0e7c1	East Lincolnshire English	568df935-3bd4-4ad7-b15d-a5207ad55d7b
25	79187494-272c-4a1e-a2a1-dd955eddce31	West Midlands English	805c0a97-3a1f-4dd4-be40-d010fa1ef649
26	c0e1c32a-b487-4a97-a5cd-7e679ba5762a	Black Country	1c793214-2fa9-4fd8-8c6a-12bf2323f6f7
27	fd9c9c05-a385-4b87-aab1-78bc005715e3	Brummie	8b6fd7bc-a736-46e0-9302-ef7b3085989c
28	490fc46e-c7b6-4f4b-9be2-7e45b0747e25	Potteries	25c92819-94eb-4a2b-a90c-30487f971e99
29	2bcdd884-d584-46d4-970b-ebe76a27394d	Coventry	bc8387d0-dcfd-4218-b98a-4474fddbd7e4
30	175b9e81-0ccf-4245-a755-06b7c5a19521	East Anglian English	34736690-6d67-45f9-a131-ba50f97b42b3
31	d7e6d4bf-f01b-45f6-ae44-442c31e29a6f	Norfolk	73fd776f-97f0-4c33-a08e-0d2dc5d38ad8
32	bb39f9a9-3ead-46ee-9363-599bf9e22f53	Suffolk	e8eb5128-600f-4cd2-88d5-1f6d7f082975
33	c81d051a-bac9-4977-ba2d-3c44d8139390	English in southern England	f1d5efe1-8d4d-40eb-87e1-095e984a6ad4
34	d14bb4a5-0552-4980-bfbe-a00348ade52e	Southern English English	f1d5efe1-8d4d-40eb-87e1-095e984a6ad4
35	5a7478b6-53fd-4786-814f-a0791f5c6f0c	Southern English	f1d5efe1-8d4d-40eb-87e1-095e984a6ad4
36	f3abbadd-9f64-4eaa-a484-da22de61ed2c	Cockney	17653e00-0701-492a-9027-98e9011ba117
37	7210a733-1d5b-49f8-8d84-f4771e067aca	Essaxon	5953e4ea-1028-47aa-8f40-43c896c6ac75
38	2a8a0063-8d6d-4529-8c0c-31c1bfa51dc1	Estuary	bbf336ff-f76d-4785-a84f-43e2d7a69fc7
39	7f6dad56-1ac8-4139-978a-6249cb67c121	Pompey dialect	64bd2f79-1385-4c3f-9d01-d3a1dcdae9f4
40	ed6e4f9f-8e1a-4eeb-ab8e-6c7f0ab61857	Kentish	b82db911-e952-4a8a-b6db-511e58eb6a3a
41	20aa5106-024c-428f-8fae-8a634549830d	Multicultural London	16ab38f0-d2e0-46ca-83e6-a924e92ad743
42	59c97b78-2e2f-4614-8bee-7868e6b64ed3	Sussex	8bd7f9cd-36e1-44b2-9d48-bcb0c2a75152
43	f9654e8f-ddf6-4922-9427-1feac0b3b356	West Country English	d5b9bc9b-6b19-4986-b5d8-1ab08f914fd1
44	e7ac5f66-e781-4b4b-8255-6583486bb51b	Anglo-Cornish	2b3ba231-a783-4c17-a25c-6436be10dc9e
45	da8c0ab6-60d7-46fd-9f38-75456253acc8	Bristolian	5f06c74e-ba40-447f-9bc3-0229aca25c25
46	4bd49b5e-2b91-4885-a1c1-7b84be437a54	Janner	fb4c3bce-35b2-4c42-9c6d-5d938cc8a695
47	0ad31f47-2df2-4090-873c-fb20f15b1870	Dorset	80772a3b-361f-4960-9dc3-3ddb5278659d
48	e6c2d388-2900-4f4d-a858-2841cb1587ec	International English	d9477607-b4ca-46a3-a583-3fe1d0efacc2
49	22de869b-55a7-41b7-9cf4-d8bbf8447a25	Global English	d9477607-b4ca-46a3-a583-3fe1d0efacc2
50	6823572a-9b3c-4afc-a744-1738d3dfeaf8	World English	d9477607-b4ca-46a3-a583-3fe1d0efacc2
51	1499ae78-981d-43ca-8558-b69a10128f58	Common English	d9477607-b4ca-46a3-a583-3fe1d0efacc2
52	795cf96c-a444-46a2-ba51-ffaab05bc069	Continental English	d9477607-b4ca-46a3-a583-3fe1d0efacc2
53	56509c73-0bfd-416e-aa2f-2800732aa34d	General English	d9477607-b4ca-46a3-a583-3fe1d0efacc2
54	c9a9cdcd-06ce-4464-a2cc-17b8f3d9e1d2	Engas	d9477607-b4ca-46a3-a583-3fe1d0efacc2
55	11c7d8a0-f58f-452b-9dc7-eb9f137d5bf4	Globish	d9477607-b4ca-46a3-a583-3fe1d0efacc2
56	e93a6013-df51-4384-bcdf-f2727f4f0068	Received Pronunciation	0be0340a-e78b-4846-9feb-74d73c34e450
57	934527db-663d-4de5-9272-d2bbd94aaeb1	BBC English	0be0340a-e78b-4846-9feb-74d73c34e450
58	5c5d6a86-a921-422e-8080-c9e3c79461fc	Standard British pronunciation	0be0340a-e78b-4846-9feb-74d73c34e450
59	779434e6-f8ae-4994-af9c-507a270b4321	Southern British pronunciation	0be0340a-e78b-4846-9feb-74d73c34e450
\.


--
-- Data for Name: language_relationship; Type: TABLE DATA; Schema: public; Owner: brook
--

COPY public.language_relationship (id, uuid, language, related_language, type) FROM stdin;
5	f793d9c9-00a8-4607-9c47-e9746436e561	e6611c19-fe1f-4086-8eb1-bb0d5620e5d0	c037e229-3731-4118-bea4-64cd069afbc8	dialect of
6	54ac6e2d-a8fd-48a6-bb69-531b91445a07	08260f08-1fec-456d-ad5e-660cbc7f1c4c	e6611c19-fe1f-4086-8eb1-bb0d5620e5d0	dialect of
7	b949bb5f-1538-4c0d-8601-c518411e8ce6	edc7faab-cc45-48a1-8a42-8794e36b1e56	e6611c19-fe1f-4086-8eb1-bb0d5620e5d0	dialect of
8	b7eabfdd-a299-4257-b87a-ca9503ce751b	3a64b4cc-a944-4de5-b4a1-e43aa06bd453	edc7faab-cc45-48a1-8a42-8794e36b1e56	dialect of
9	a3c7b1c0-eb72-4c69-87d6-b6791c266739	aab443fd-b97f-4227-8460-252bdc963676	edc7faab-cc45-48a1-8a42-8794e36b1e56	dialect of
10	05a8f72e-50a9-465f-a972-5cb133959061	93d099c3-e59f-4fac-8626-61aea08da79c	edc7faab-cc45-48a1-8a42-8794e36b1e56	dialect of
11	1fa947ce-2a46-4b6b-b417-1e14b0ff394e	ef358155-beed-4d7c-a192-3292d36cdb5a	edc7faab-cc45-48a1-8a42-8794e36b1e56	dialect of
12	d5f46c91-b15b-41d5-b135-8d290bd0f16f	ec559dcd-d33e-408f-ade4-ede2fdb8f268	edc7faab-cc45-48a1-8a42-8794e36b1e56	dialect of
13	ca2c830c-622c-40c1-9f38-73313cadde85	642175da-eae4-4c57-8738-a788b222f53e	edc7faab-cc45-48a1-8a42-8794e36b1e56	dialect of
14	30e9705d-db33-42f0-8832-a4f8f36d8b04	d4abb8bb-abc0-4e68-8de7-509b25e49aeb	edc7faab-cc45-48a1-8a42-8794e36b1e56	dialect of
15	4f82dc19-20ea-4603-8247-2ef1470bdaf3	153f0c0d-19e4-4daa-b8ce-96f17e02cff2	edc7faab-cc45-48a1-8a42-8794e36b1e56	dialect of
16	4c2abdf4-cd2e-49ad-b8f6-bb55c7f039b8	ccb43e2a-a80b-4928-9eda-e7cf1cc40869	edc7faab-cc45-48a1-8a42-8794e36b1e56	dialect of
17	cac4307d-bde6-4ed5-8f71-f3a7daad129e	6e24223b-f5ff-4fad-aadc-bc408804a96e	edc7faab-cc45-48a1-8a42-8794e36b1e56	dialect of
18	9851c5a9-3831-451b-8f4f-4510925d7b84	a94ba838-0739-4e4e-a8c6-6395925a0d47	edc7faab-cc45-48a1-8a42-8794e36b1e56	dialect of
19	1cf455fc-38a6-4aee-a8f3-f7b8bd0e1c59	308f62f4-ed24-4044-a357-8e4002758712	edc7faab-cc45-48a1-8a42-8794e36b1e56	dialect of
20	b33f4894-e2d1-4e0d-8c62-37f289c80c1b	1d6f2e5b-cf55-4610-82a3-554550bbafec	e6611c19-fe1f-4086-8eb1-bb0d5620e5d0	dialect of
21	6e2ccbdf-72b9-4bbf-8d6b-c3cad5f736bf	7e0f0c88-617e-4fdc-b932-6014095c40d7	1d6f2e5b-cf55-4610-82a3-554550bbafec	dialect of
22	9b8725ef-2e29-47fa-bc9b-a3d5395bc38d	568df935-3bd4-4ad7-b15d-a5207ad55d7b	1d6f2e5b-cf55-4610-82a3-554550bbafec	dialect of
23	e97755d5-de17-456d-90bd-2df3e836f693	805c0a97-3a1f-4dd4-be40-d010fa1ef649	e6611c19-fe1f-4086-8eb1-bb0d5620e5d0	dialect of
24	b34bf43a-7ea0-4b18-a69f-9f97ed049ec5	1c793214-2fa9-4fd8-8c6a-12bf2323f6f7	805c0a97-3a1f-4dd4-be40-d010fa1ef649	dialect of
25	c517a760-8136-49a3-b509-9d9108ee4b12	8b6fd7bc-a736-46e0-9302-ef7b3085989c	805c0a97-3a1f-4dd4-be40-d010fa1ef649	dialect of
26	50bfeb00-fdc4-4ee7-88af-fb69c1dae11f	25c92819-94eb-4a2b-a90c-30487f971e99	805c0a97-3a1f-4dd4-be40-d010fa1ef649	dialect of
27	0253f529-ac69-438b-b5cc-e2d39da03b0b	bc8387d0-dcfd-4218-b98a-4474fddbd7e4	805c0a97-3a1f-4dd4-be40-d010fa1ef649	dialect of
28	cf974bea-4397-4145-b14b-aaef07723a3f	34736690-6d67-45f9-a131-ba50f97b42b3	e6611c19-fe1f-4086-8eb1-bb0d5620e5d0	dialect of
29	7e52e41e-0ff7-40c1-95ef-e5cdbfa3a1e2	73fd776f-97f0-4c33-a08e-0d2dc5d38ad8	34736690-6d67-45f9-a131-ba50f97b42b3	dialect of
30	a4081b3b-1b57-49f0-9493-4bb1062dbc40	e8eb5128-600f-4cd2-88d5-1f6d7f082975	34736690-6d67-45f9-a131-ba50f97b42b3	dialect of
31	3eecf94b-ac2c-444a-b999-4b8d215a55ef	f1d5efe1-8d4d-40eb-87e1-095e984a6ad4	e6611c19-fe1f-4086-8eb1-bb0d5620e5d0	dialect of
32	4b93a082-d882-4d18-8f31-bfabf1083772	17653e00-0701-492a-9027-98e9011ba117	f1d5efe1-8d4d-40eb-87e1-095e984a6ad4	dialect of
33	41ef8637-ac65-4201-894d-27801682f69d	5953e4ea-1028-47aa-8f40-43c896c6ac75	f1d5efe1-8d4d-40eb-87e1-095e984a6ad4	dialect of
34	208a27d5-fbc9-431c-945d-b4268352115b	bbf336ff-f76d-4785-a84f-43e2d7a69fc7	f1d5efe1-8d4d-40eb-87e1-095e984a6ad4	dialect of
35	a822a3ba-65fa-40e2-8ddb-677d4f82d827	64bd2f79-1385-4c3f-9d01-d3a1dcdae9f4	f1d5efe1-8d4d-40eb-87e1-095e984a6ad4	dialect of
36	5c71f7b7-1e50-481f-a87e-5a26fba714c3	b82db911-e952-4a8a-b6db-511e58eb6a3a	f1d5efe1-8d4d-40eb-87e1-095e984a6ad4	dialect of
37	8f7bc50f-7196-4f30-961e-27b98ae8ea98	16ab38f0-d2e0-46ca-83e6-a924e92ad743	f1d5efe1-8d4d-40eb-87e1-095e984a6ad4	dialect of
38	a730d9d5-5175-4353-a145-25eccc01cd7d	8bd7f9cd-36e1-44b2-9d48-bcb0c2a75152	f1d5efe1-8d4d-40eb-87e1-095e984a6ad4	dialect of
39	377c7807-33c8-40d0-b675-8b03e7f2a80c	d5b9bc9b-6b19-4986-b5d8-1ab08f914fd1	e6611c19-fe1f-4086-8eb1-bb0d5620e5d0	dialect of
40	79c58446-3bd0-4ddf-83c5-4128bfa1fc1c	2b3ba231-a783-4c17-a25c-6436be10dc9e	d5b9bc9b-6b19-4986-b5d8-1ab08f914fd1	dialect of
41	4c1ade3b-22b0-485f-ba18-f193e51697f3	5f06c74e-ba40-447f-9bc3-0229aca25c25	d5b9bc9b-6b19-4986-b5d8-1ab08f914fd1	dialect of
42	5fe86fd8-4c38-45a0-abcc-a556b20f4334	fb4c3bce-35b2-4c42-9c6d-5d938cc8a695	d5b9bc9b-6b19-4986-b5d8-1ab08f914fd1	dialect of
43	4586cf49-1109-4f15-8083-de7dff9f09c7	80772a3b-361f-4960-9dc3-3ddb5278659d	d5b9bc9b-6b19-4986-b5d8-1ab08f914fd1	dialect of
44	9028146a-6273-4a9b-858a-67fbb70f8c95	d9477607-b4ca-46a3-a583-3fe1d0efacc2	c037e229-3731-4118-bea4-64cd069afbc8	dialect of
45	ad01dcaf-674d-43f8-ac8d-008ddf2831d5	0be0340a-e78b-4846-9feb-74d73c34e450	c037e229-3731-4118-bea4-64cd069afbc8	dialect of
\.


--
-- Data for Name: language_relationship_type; Type: TABLE DATA; Schema: public; Owner: brook
--

COPY public.language_relationship_type (id, name) FROM stdin;
1	dialect of
\.


--
-- Data for Name: passport_travel_requirements; Type: TABLE DATA; Schema: public; Owner: brook
--

COPY public.passport_travel_requirements (id, passport_territory, destination_territory, visa_type, stay_length, notes, uuid, route) FROM stdin;
1	0f433ba9-47e1-4fe6-902c-632bf40355a9	1965c743-cf9a-4021-9ed1-b9e4e77486a2	visa not required	90 days	\N	25fa7777-29b1-49ed-9813-c7ac202a74ec	0f433ba9-47e1-4fe6-902c-632bf40355a91965c743-cf9a-4021-9ed1-b9e4e77486a2
7	0f433ba9-47e1-4fe6-902c-632bf40355a9	2dd507e0-8e57-4924-a57f-8fc2e22555e2	visa not required	\N	\N	cb57eeda-784b-4b91-8731-240ab57c4ed4	0f433ba9-47e1-4fe6-902c-632bf40355a92dd507e0-8e57-4924-a57f-8fc2e22555e2
5	0f433ba9-47e1-4fe6-902c-632bf40355a9	49494a5b-205f-4756-9145-2784c9269a99	visa not required	6 mons	\N	c6bc9e09-56e3-4952-9e09-103fdab616c6	0f433ba9-47e1-4fe6-902c-632bf40355a949494a5b-205f-4756-9145-2784c9269a99
6	0f433ba9-47e1-4fe6-902c-632bf40355a9	c5db5d6b-ebcd-4642-9604-0f1ebf2fdf9d	visa not required	\N	\N	cae05655-eff4-4d28-970a-c37dedc3b99e	0f433ba9-47e1-4fe6-902c-632bf40355a9c5db5d6b-ebcd-4642-9604-0f1ebf2fdf9d
11	0f433ba9-47e1-4fe6-902c-632bf40355a9	0b48c87c-ddaa-49d2-b736-61d9c44636e0	evisa	31 days	\N	1bed4fe6-a491-4fac-8099-a6e1a72db7d8	0f433ba9-47e1-4fe6-902c-632bf40355a90b48c87c-ddaa-49d2-b736-61d9c44636e0
4	0f433ba9-47e1-4fe6-902c-632bf40355a9	ca1a8efc-5d84-4e75-9f3b-5d005b9afca5	freedom of movement	\N	\N	e6acb079-da2a-4b9c-b2e6-f18d423d01d0	0f433ba9-47e1-4fe6-902c-632bf40355a9ca1a8efc-5d84-4e75-9f3b-5d005b9afca5
2	0f433ba9-47e1-4fe6-902c-632bf40355a9	2b1a33fe-be25-452b-8a1c-c7d5f1dce9c2	free visa on arrival	30 days	\N	fbd633ef-2c7c-4b7b-a91c-347f49da89d5	0f433ba9-47e1-4fe6-902c-632bf40355a92b1a33fe-be25-452b-8a1c-c7d5f1dce9c2
8	0f433ba9-47e1-4fe6-902c-632bf40355a9	ac8b13ec-0d98-4fad-852e-a351d68e6a16	evisa	28 days	eVisa holders must arrive via Yangon, Nay Pyi Taw or Mandalay airports or via land border crossings with Thailand — Tachileik, Myawaddy and Kawthaung or India — Rih Khaw Dar and Tamu.  eVisa available for both tourism (allowed stay is 28 days) or business purposes (allowed stay is 70 days).	2fb37c86-a666-4684-85cf-7f637922a0a4	0f433ba9-47e1-4fe6-902c-632bf40355a9ac8b13ec-0d98-4fad-852e-a351d68e6a16
10	0f433ba9-47e1-4fe6-902c-632bf40355a9	aae2ba87-a67d-43bd-8516-e403843d61d9	visa not required	90 days	\N	8abf0369-f4a9-4729-9d06-94d2342e9182	0f433ba9-47e1-4fe6-902c-632bf40355a9aae2ba87-a67d-43bd-8516-e403843d61d9
9	0f433ba9-47e1-4fe6-902c-632bf40355a9	6702177a-fbed-4cf3-aa32-22da244beab0	visa not required	90 days	Must register with the local police station (either through a tourist organisation or at hotel reception) within 24 hours of arrival.	64384ee4-02d8-4140-9cb2-dc29c6a49a6f	0f433ba9-47e1-4fe6-902c-632bf40355a96702177a-fbed-4cf3-aa32-22da244beab0
3	0f433ba9-47e1-4fe6-902c-632bf40355a9	793360a3-aa91-4703-acfe-60287e3f9b74	visa not required	3 mons	\N	3fb617a8-6f66-488a-956d-b533f20daf5a	0f433ba9-47e1-4fe6-902c-632bf40355a9793360a3-aa91-4703-acfe-60287e3f9b74
90	0f433ba9-47e1-4fe6-902c-632bf40355a9	723de35c-616a-4b10-b479-c08378f3765b	visa on arrival	30 days	Extendable for another 30 days.	ec140f3c-c550-42b6-97af-d8574bf49273	0f433ba9-47e1-4fe6-902c-632bf40355a9723de35c-616a-4b10-b479-c08378f3765b
91	0f433ba9-47e1-4fe6-902c-632bf40355a9	526f75ae-3c43-45a3-924e-1d7e11177a68	visa required	\N	Pre-approved visa can be picked up on arrival.	5ede18e8-c173-47aa-ab71-96881ee6df03	0f433ba9-47e1-4fe6-902c-632bf40355a9526f75ae-3c43-45a3-924e-1d7e11177a68
92	0f433ba9-47e1-4fe6-902c-632bf40355a9	e242cbe2-dc75-4807-a7c9-c171d164ec2d	visa not required	6 mons	eTA required if arriving by air.	72d9673e-1f4e-4525-9ce1-b4a718aa8976	0f433ba9-47e1-4fe6-902c-632bf40355a9e242cbe2-dc75-4807-a7c9-c171d164ec2d
93	0f433ba9-47e1-4fe6-902c-632bf40355a9	3e77325d-7fea-46ad-a8fa-b2d31056b3ea	visa not required	30 days	Must register online at least five days prior to arrival.	875eb931-948d-4c4a-a4c3-3fa99dfebde0	0f433ba9-47e1-4fe6-902c-632bf40355a93e77325d-7fea-46ad-a8fa-b2d31056b3ea
94	0f433ba9-47e1-4fe6-902c-632bf40355a9	2b1aaccb-5846-45c1-8481-12bb8b5e0aa4	visa required	\N	\N	f7036ddb-0a82-4796-ba47-1ac705f4be17	0f433ba9-47e1-4fe6-902c-632bf40355a92b1aaccb-5846-45c1-8481-12bb8b5e0aa4
95	0f433ba9-47e1-4fe6-902c-632bf40355a9	3f759fc5-8287-4acb-b58d-f235c5ef4981	visa required	\N	\N	f40b4e82-d523-492a-b1cb-094d38b6a0b4	0f433ba9-47e1-4fe6-902c-632bf40355a93f759fc5-8287-4acb-b58d-f235c5ef4981
96	0f433ba9-47e1-4fe6-902c-632bf40355a9	c5a755fa-0935-4ec5-a880-3d4854beabfd	visa not required	90 days	May be extended.	ef3bf2ab-fac1-473a-bf85-ec1e307c2f0f	0f433ba9-47e1-4fe6-902c-632bf40355a9c5a755fa-0935-4ec5-a880-3d4854beabfd
97	0f433ba9-47e1-4fe6-902c-632bf40355a9	7178da96-360e-4b0a-ada4-9640c498daf8	visa required	\N	72-hour visit without a visa when in transit at Changsha, Chengdu, Chongqing, Guangzhou, Guilin, Harbin, Kunming, Qingdao, Wuhan, Xi'an and Xiamen.144-hours visit without a visa when in transit through Beijing Capital International Airport, Dalian, Hangzhou, Shijiazhuang Zhengding International Airport in Hebei, Nanjing, Shanghai Hongqiao International Airport and Shanghai Pudong International Airport, Shanghai railway station and the Port of Shanghai; Shenyang and Tianjin Binhai International Airport\\nHong Kong, Macau, and Taiwan do count as third countries under the 72 and 144-hours visa-free visit transit policy.\\nVisiting visas issued to British citizens are generally valid for 2 years	6add32ed-bd3c-415a-adfc-6845633d14d4	0f433ba9-47e1-4fe6-902c-632bf40355a97178da96-360e-4b0a-ada4-9640c498daf8
98	0f433ba9-47e1-4fe6-902c-632bf40355a9	8b58bd46-c2d7-4df7-8871-378dbe921468	visa not required	90 days	Extendable up to 180-days stay consecutively within a one-year period.	d476b072-9db7-4bc2-94b7-b6d507d38525	0f433ba9-47e1-4fe6-902c-632bf40355a98b58bd46-c2d7-4df7-8871-378dbe921468
99	0f433ba9-47e1-4fe6-902c-632bf40355a9	48847459-b1b2-4092-9bf0-f0c08b928c74	visa on arrival	\N	\N	06dce50a-13da-4d93-ad06-65214eff78b4	0f433ba9-47e1-4fe6-902c-632bf40355a948847459-b1b2-4092-9bf0-f0c08b928c74
100	0f433ba9-47e1-4fe6-902c-632bf40355a9	196ed632-cc17-4b9f-87cb-cbc9832e8617	visa required	\N	\N	0682ad1d-ee82-4c26-ba4f-9ec2083845ca	0f433ba9-47e1-4fe6-902c-632bf40355a9196ed632-cc17-4b9f-87cb-cbc9832e8617
101	0f433ba9-47e1-4fe6-902c-632bf40355a9	80b3fc54-1fa6-49c6-ac4c-998b002d754f	visa required	\N	\N	ba2f14c0-86b9-45a6-8788-5b74cc3f2160	0f433ba9-47e1-4fe6-902c-632bf40355a980b3fc54-1fa6-49c6-ac4c-998b002d754f
102	0f433ba9-47e1-4fe6-902c-632bf40355a9	cf56f0da-daf4-4437-9ad9-4b61bbedc31a	visa not required	3 mons	\N	a79afa80-9ec9-4ff5-856c-318d3d4b5b94	0f433ba9-47e1-4fe6-902c-632bf40355a9cf56f0da-daf4-4437-9ad9-4b61bbedc31a
103	0f433ba9-47e1-4fe6-902c-632bf40355a9	14730d5f-e0e5-43a8-bc67-ca9f92c8502a	visa not required	\N	\N	a0f46ab6-92bf-4042-8ae6-b64e76d8c123	0f433ba9-47e1-4fe6-902c-632bf40355a914730d5f-e0e5-43a8-bc67-ca9f92c8502a
104	0f433ba9-47e1-4fe6-902c-632bf40355a9	16a55dd1-2e47-489d-830c-3a88aad464a9	tourist card required	30 days	\N	320dc967-e1ca-4aee-a90f-3335a165200c	0f433ba9-47e1-4fe6-902c-632bf40355a916a55dd1-2e47-489d-830c-3a88aad464a9
105	0f433ba9-47e1-4fe6-902c-632bf40355a9	f36ec987-ed66-4a88-9157-b1d4a934e515	visa not required	\N	\N	b32d32a9-c811-4087-9a19-0a1c17f6b1fb	0f433ba9-47e1-4fe6-902c-632bf40355a9f36ec987-ed66-4a88-9157-b1d4a934e515
228	0f433ba9-47e1-4fe6-902c-632bf40355a9	99530f46-46c4-4263-bd88-dca23dc0383f	visa not required	90 days	\N	155dd621-eef6-4fba-ba88-a5a0140958d9	0f433ba9-47e1-4fe6-902c-632bf40355a999530f46-46c4-4263-bd88-dca23dc0383f
31	0f433ba9-47e1-4fe6-902c-632bf40355a9	b33be079-39b7-4a1d-b689-97c224d5fece	visa required	\N	\N	bbfdcecc-5b93-4c4e-89ed-8cfbb56bf6e2	0f433ba9-47e1-4fe6-902c-632bf40355a9b33be079-39b7-4a1d-b689-97c224d5fece
32	0f433ba9-47e1-4fe6-902c-632bf40355a9	6c7e4e7d-9bf4-4e47-b2e4-c925f54bcd1a	visa not required	90 days	\N	e1115ea6-74f9-4657-964e-e708ff8014a9	0f433ba9-47e1-4fe6-902c-632bf40355a96c7e4e7d-9bf4-4e47-b2e4-c925f54bcd1a
33	0f433ba9-47e1-4fe6-902c-632bf40355a9	d9b8f8c8-5b5a-41ef-8538-26d822a4c9bd	visa required	\N	\N	3904f9f7-d1c7-4f4e-a667-63733b01cd20	0f433ba9-47e1-4fe6-902c-632bf40355a9d9b8f8c8-5b5a-41ef-8538-26d822a4c9bd
34	0f433ba9-47e1-4fe6-902c-632bf40355a9	bf07965f-f874-453e-a725-54c5a1254ee8	evisa	30 days	Visitors who have been granted an online pre-visa or have requested such pre-visa from the consulates of Angola abroad, are then issued with a visa on arrival at the country's border check points.\\nFor a maximum total stay of 90 days within a one year period.\\nBesides having printed confirmation that a visa will be issued upon arrival, passengers must: have a return/onward ticket, and have a hotel reservation confirmation.	62849f83-c4a8-4efd-9fa3-adc3a461c5e1	0f433ba9-47e1-4fe6-902c-632bf40355a9bf07965f-f874-453e-a725-54c5a1254ee8
35	0f433ba9-47e1-4fe6-902c-632bf40355a9	90de1527-d5a5-446f-a960-eccda43af198	visa not required	6 mons	\N	ebd0b81d-223f-4b74-bf4f-2c47cb502580	0f433ba9-47e1-4fe6-902c-632bf40355a990de1527-d5a5-446f-a960-eccda43af198
36	0f433ba9-47e1-4fe6-902c-632bf40355a9	78219cc6-d1b2-4193-9da7-e7abc92863ee	visa not required	90 days	\N	2b62de73-71c9-4eac-bd87-7e291438cdef	0f433ba9-47e1-4fe6-902c-632bf40355a978219cc6-d1b2-4193-9da7-e7abc92863ee
37	0f433ba9-47e1-4fe6-902c-632bf40355a9	f2f3e704-bb03-467a-a1a0-1d56b6faadce	visa not required	180 days	\N	b82ec576-73da-4f24-9709-ca863edaaf09	0f433ba9-47e1-4fe6-902c-632bf40355a9f2f3e704-bb03-467a-a1a0-1d56b6faadce
38	0f433ba9-47e1-4fe6-902c-632bf40355a9	0a3e548d-7e30-426f-840c-07ff9b6772f7	evisitor	90 days	If granted, eVisitor allows British citizens to stay in Australia for 90 days per visit.\\nIssued free of charge and valid for one year.	d30fa93d-e4a9-4f1d-8bd1-628f9bdc614f	0f433ba9-47e1-4fe6-902c-632bf40355a90a3e548d-7e30-426f-840c-07ff9b6772f7
39	0f433ba9-47e1-4fe6-902c-632bf40355a9	e14f7607-8074-4eeb-8b3f-3093575719a4	visa not required	\N	\N	8f53d8b8-aa24-40e1-893c-6f6277d0d1da	0f433ba9-47e1-4fe6-902c-632bf40355a9e14f7607-8074-4eeb-8b3f-3093575719a4
40	0f433ba9-47e1-4fe6-902c-632bf40355a9	319530a8-8cd2-4dc3-84a6-29ac720c51da	evisa	30 days	\N	fd750b6b-cd53-41d9-97a0-c5f2c7a20091	0f433ba9-47e1-4fe6-902c-632bf40355a9319530a8-8cd2-4dc3-84a6-29ac720c51da
41	0f433ba9-47e1-4fe6-902c-632bf40355a9	ac6434f1-bbb9-4242-a393-d78d367f034a	visa not required	21 days	Extendable up to eight months.	79627386-38ec-4504-84b4-b8b7c8a70623	0f433ba9-47e1-4fe6-902c-632bf40355a9ac6434f1-bbb9-4242-a393-d78d367f034a
42	0f433ba9-47e1-4fe6-902c-632bf40355a9	497550d7-f9e9-4f1a-a5e0-8c9019c7bc31	visa on arrival	3 mons	Visas can be issued on arrival for a stay up to 3 months.\\neVisa issued for 14 days, extendable once.	599ac73a-f224-4357-a689-6fa73474b147	0f433ba9-47e1-4fe6-902c-632bf40355a9497550d7-f9e9-4f1a-a5e0-8c9019c7bc31
43	0f433ba9-47e1-4fe6-902c-632bf40355a9	bb3fa754-b35e-45ee-8d66-fb159c96d821	visa on arrival	30 days	Visa on arrival available at Dhaka International Airport	7d4231ed-e908-4896-b39b-d7807003045e	0f433ba9-47e1-4fe6-902c-632bf40355a9bb3fa754-b35e-45ee-8d66-fb159c96d821
44	0f433ba9-47e1-4fe6-902c-632bf40355a9	ac612169-1567-4c5e-a203-3987fa26c267	visa not required	30 days	Must arrive and leave via Minsk International Airport\\nVisas are also issued on arrival at the Minsk International Airport if the support documents were submitted by inviting organisation/person not later than 3 business days before expected date of arrival. Police registration required for stays of more than 5 days.	80e47ddb-59af-4fad-9d84-225e8658df88	0f433ba9-47e1-4fe6-902c-632bf40355a9ac612169-1567-4c5e-a203-3987fa26c267
45	0f433ba9-47e1-4fe6-902c-632bf40355a9	1f4dd261-dc57-49ec-b872-8b1917703616	visa not required	\N	\N	d419a998-4404-4816-8306-fd37d7d4e4a5	0f433ba9-47e1-4fe6-902c-632bf40355a91f4dd261-dc57-49ec-b872-8b1917703616
46	0f433ba9-47e1-4fe6-902c-632bf40355a9	3e62d48d-717d-4421-91c2-abb059a80576	visa not required	\N	\N	6092d57c-c7f9-4cbe-9bcb-afb60b42ef94	0f433ba9-47e1-4fe6-902c-632bf40355a93e62d48d-717d-4421-91c2-abb059a80576
47	0f433ba9-47e1-4fe6-902c-632bf40355a9	5fbebc32-e410-4faa-94e5-822252f8b499	visa on arrival	30 days	Must have an international vaccination certificate.	07eb717d-8a49-4140-a880-17bd6b01ea3e	0f433ba9-47e1-4fe6-902c-632bf40355a95fbebc32-e410-4faa-94e5-822252f8b499
48	0f433ba9-47e1-4fe6-902c-632bf40355a9	1d58bd18-8519-4e53-8cd1-6a7e93cda614	visa required	\N	Visa via approved tour operators only	26288470-f397-4f7a-91e2-290c45d9d713	0f433ba9-47e1-4fe6-902c-632bf40355a91d58bd18-8519-4e53-8cd1-6a7e93cda614
49	0f433ba9-47e1-4fe6-902c-632bf40355a9	546440bf-236c-4f99-bd12-3bba52d50e02	visa not required	90 days	\N	e52872cd-3cd2-4d5c-af9f-9aa6b2c03b06	0f433ba9-47e1-4fe6-902c-632bf40355a9546440bf-236c-4f99-bd12-3bba52d50e02
50	0f433ba9-47e1-4fe6-902c-632bf40355a9	c103dabb-a386-4a6a-bce5-c0c0fa5f43f6	visa not required	90 days	90 days within any 6-month period.	54ceb4c8-a7fa-4284-b075-2115eabb35d2	0f433ba9-47e1-4fe6-902c-632bf40355a9c103dabb-a386-4a6a-bce5-c0c0fa5f43f6
51	0f433ba9-47e1-4fe6-902c-632bf40355a9	ff4c5033-aee4-4325-90cc-1f96ef10bbce	visa not required	90 days	\N	f16436f7-1d6b-4ca1-9a7a-c1394edf3960	0f433ba9-47e1-4fe6-902c-632bf40355a9ff4c5033-aee4-4325-90cc-1f96ef10bbce
52	0f433ba9-47e1-4fe6-902c-632bf40355a9	1b558876-4f84-41fb-8215-93143842ba53	visa not required	90 days	Extendable for further 90 days	a4aa4273-35e5-437b-a5b8-e3f7ee1f915d	0f433ba9-47e1-4fe6-902c-632bf40355a91b558876-4f84-41fb-8215-93143842ba53
53	0f433ba9-47e1-4fe6-902c-632bf40355a9	49ca53d4-0d59-4be8-9724-70b0eff911ce	visa not required	90 days	\N	2d808028-9bec-4e28-a11f-665ab0ab1d5c	0f433ba9-47e1-4fe6-902c-632bf40355a949ca53d4-0d59-4be8-9724-70b0eff911ce
54	0f433ba9-47e1-4fe6-902c-632bf40355a9	dde93861-da65-40d4-8159-3e67e8d58e02	visa not required	\N	\N	9228f4c7-6175-4964-b092-62e8c8f5735f	0f433ba9-47e1-4fe6-902c-632bf40355a9dde93861-da65-40d4-8159-3e67e8d58e02
55	0f433ba9-47e1-4fe6-902c-632bf40355a9	a22c7473-248e-4447-8bc7-1fc51c00ca3e	visa on arrival	1 mon	\N	820999f2-b7bc-4daa-8620-970d4ffed87c	0f433ba9-47e1-4fe6-902c-632bf40355a9a22c7473-248e-4447-8bc7-1fc51c00ca3e
56	0f433ba9-47e1-4fe6-902c-632bf40355a9	4f0fe689-81e0-4b91-a093-cad33a305482	visa required	\N	\N	b764e8d4-9231-48c7-b447-89fb845dd2d2	0f433ba9-47e1-4fe6-902c-632bf40355a94f0fe689-81e0-4b91-a093-cad33a305482
229	0f433ba9-47e1-4fe6-902c-632bf40355a9	3e33cfe7-603b-4d88-a6e3-f4dcc331d9f2	visa not required	3 mons	\N	3e00dde7-0464-4793-b18c-68a0a6264b2e	0f433ba9-47e1-4fe6-902c-632bf40355a93e33cfe7-603b-4d88-a6e3-f4dcc331d9f2
109	0f433ba9-47e1-4fe6-902c-632bf40355a9	870d8300-9c56-4b34-9447-bcdfedf8454c	visa not required	\N	\N	98616a6c-3cc0-4832-8778-853fabc2a814	0f433ba9-47e1-4fe6-902c-632bf40355a9870d8300-9c56-4b34-9447-bcdfedf8454c
110	0f433ba9-47e1-4fe6-902c-632bf40355a9	a66c6aaf-f010-4056-8928-1653d670edf3	visa not required	6 mons	\N	75cce801-e380-4181-84d1-d42a576f55b7	0f433ba9-47e1-4fe6-902c-632bf40355a9a66c6aaf-f010-4056-8928-1653d670edf3
111	0f433ba9-47e1-4fe6-902c-632bf40355a9	7caae20c-20fa-4ce0-a987-cca304a302b9	visa not required	30 days	As of April 2018, can be extended to 60 days.	8c3eab58-3e38-49cb-b22c-271b5052f21e	0f433ba9-47e1-4fe6-902c-632bf40355a97caae20c-20fa-4ce0-a987-cca304a302b9
112	0f433ba9-47e1-4fe6-902c-632bf40355a9	41fa1fc8-a7c9-4045-ac6a-92fe36c27bd9	visa not required	90 days	May be extended.	94cf29e4-4e3f-4395-be07-153f4fce87b9	0f433ba9-47e1-4fe6-902c-632bf40355a941fa1fc8-a7c9-4045-ac6a-92fe36c27bd9
113	0f433ba9-47e1-4fe6-902c-632bf40355a9	0d0a18fd-d424-4a69-b646-38fffd942dd5	visa on arrival	30 days	\N	fc1ca413-a8b7-4f13-bd04-317632af6e51	0f433ba9-47e1-4fe6-902c-632bf40355a90d0a18fd-d424-4a69-b646-38fffd942dd5
114	0f433ba9-47e1-4fe6-902c-632bf40355a9	bae2df87-ee9b-4efe-8482-2b05b54ebb11	visa not required	3 mons	\N	f39ceb56-72c5-4f47-8744-454c013a2868	0f433ba9-47e1-4fe6-902c-632bf40355a9bae2df87-ee9b-4efe-8482-2b05b54ebb11
115	0f433ba9-47e1-4fe6-902c-632bf40355a9	43d35de8-4ed4-4bd7-9fce-54d9adcdeec6	visa required	\N	\N	7f180584-d704-4b6c-a70a-69c15a368c58	0f433ba9-47e1-4fe6-902c-632bf40355a943d35de8-4ed4-4bd7-9fce-54d9adcdeec6
116	0f433ba9-47e1-4fe6-902c-632bf40355a9	b2db2210-e9b8-4d51-b3c0-ed8e3d6adc9b	visa required	\N	Pre-approved visa can be picked up on arrival.	3c0c55b8-02bc-409d-abc1-b5e08d9b499b	0f433ba9-47e1-4fe6-902c-632bf40355a9b2db2210-e9b8-4d51-b3c0-ed8e3d6adc9b
117	0f433ba9-47e1-4fe6-902c-632bf40355a9	061c7757-87bb-4acc-bfb5-ebb5a4dc9429	visa not required	\N	\N	30c03679-0c67-4a81-80e5-076694ff21eb	0f433ba9-47e1-4fe6-902c-632bf40355a9061c7757-87bb-4acc-bfb5-ebb5a4dc9429
118	0f433ba9-47e1-4fe6-902c-632bf40355a9	646467f2-a7ee-4dc3-8589-902f948694cf	visa not required	30 days	\N	8e5eb53a-a11a-41ef-ae86-9abbff71e871	0f433ba9-47e1-4fe6-902c-632bf40355a9646467f2-a7ee-4dc3-8589-902f948694cf
119	0f433ba9-47e1-4fe6-902c-632bf40355a9	f76a50d7-c955-4658-a2da-f191b746b434	visa on arrival	90 days	Visa on arrival is obtainable only at Addis Ababa Bole International Airport.\\neVisa holders must arrive via Addis Ababa Bole International Airport.\\neVisas are available for 30 or 90 days.	fe06cde3-4c4f-49f4-96d9-321533fdd00f	0f433ba9-47e1-4fe6-902c-632bf40355a9f76a50d7-c955-4658-a2da-f191b746b434
120	0f433ba9-47e1-4fe6-902c-632bf40355a9	923566be-1a81-4281-a9f5-fc3d8e59e53e	visa not required	4 mons	\N	8101d58b-76d6-4083-ae55-9b07a7ea5750	0f433ba9-47e1-4fe6-902c-632bf40355a9923566be-1a81-4281-a9f5-fc3d8e59e53e
121	0f433ba9-47e1-4fe6-902c-632bf40355a9	d322fe64-203a-4eb4-8316-2c6c1af401a3	visa not required	\N	\N	262a1fba-df1c-4df7-9977-d4d46b698cb6	0f433ba9-47e1-4fe6-902c-632bf40355a9d322fe64-203a-4eb4-8316-2c6c1af401a3
122	0f433ba9-47e1-4fe6-902c-632bf40355a9	b7b802fe-8789-4b6d-b085-7c25a92dab7b	visa not required	\N	\N	e27a64aa-6eba-4c64-b126-9dd0d67af1b4	0f433ba9-47e1-4fe6-902c-632bf40355a9b7b802fe-8789-4b6d-b085-7c25a92dab7b
123	0f433ba9-47e1-4fe6-902c-632bf40355a9	6a95dca7-5bc9-438d-ba51-5cc4603d70a4	visa on arrival	90 days	eVisa holders must arrive via Libreville International Airport.	8981482d-2fec-44c8-b3c2-f442cbd16730	0f433ba9-47e1-4fe6-902c-632bf40355a96a95dca7-5bc9-438d-ba51-5cc4603d70a4
124	0f433ba9-47e1-4fe6-902c-632bf40355a9	81e9890e-9239-4c33-b429-66950b214814	visa not required	90 days	\N	140a8aa1-f25f-4052-aa63-e6f893c49102	0f433ba9-47e1-4fe6-902c-632bf40355a981e9890e-9239-4c33-b429-66950b214814
125	0f433ba9-47e1-4fe6-902c-632bf40355a9	f2e17057-cb16-4fd3-92ef-07a6320c1818	visa not required	1 year	\N	c1c48eea-b103-4b62-8d81-95dad8ca79fb	0f433ba9-47e1-4fe6-902c-632bf40355a9f2e17057-cb16-4fd3-92ef-07a6320c1818
126	0f433ba9-47e1-4fe6-902c-632bf40355a9	d80301ed-7cdc-4f2c-8093-cfec014b077a	visa not required	\N	\N	8271b9b5-f532-4767-8bb3-abf66b5ba554	0f433ba9-47e1-4fe6-902c-632bf40355a9d80301ed-7cdc-4f2c-8093-cfec014b077a
127	0f433ba9-47e1-4fe6-902c-632bf40355a9	53618499-ed33-49f9-aeae-e24d02029f1e	visa required	\N	Pre-approved visa can be picked up on arrival.	dbd055d6-555f-4bef-b400-367a65aed63d	0f433ba9-47e1-4fe6-902c-632bf40355a953618499-ed33-49f9-aeae-e24d02029f1e
128	0f433ba9-47e1-4fe6-902c-632bf40355a9	1a76eb8a-5fca-4552-a0dd-9728217998b0	visa not required	\N	\N	3c817468-882f-4150-ba3e-593d7f47f004	0f433ba9-47e1-4fe6-902c-632bf40355a91a76eb8a-5fca-4552-a0dd-9728217998b0
129	0f433ba9-47e1-4fe6-902c-632bf40355a9	aedfe3b8-fc01-41f8-a152-516e139dc8b6	visa not required	6 mons	\N	b2a4deef-63aa-410a-abea-2525f1251f2b	0f433ba9-47e1-4fe6-902c-632bf40355a9aedfe3b8-fc01-41f8-a152-516e139dc8b6
130	0f433ba9-47e1-4fe6-902c-632bf40355a9	0e291c7e-51a2-466f-94b9-de8d9dec9dd2	visa not required	90 days	\N	7a181c04-f753-4555-aa6a-a41d0adb28d4	0f433ba9-47e1-4fe6-902c-632bf40355a90e291c7e-51a2-466f-94b9-de8d9dec9dd2
131	0f433ba9-47e1-4fe6-902c-632bf40355a9	b3e98c98-8a15-45bf-8f86-f26f6a07a425	evisa	90 days	\N	630cf961-ec59-4204-8de8-ed913690b9c4	0f433ba9-47e1-4fe6-902c-632bf40355a9b3e98c98-8a15-45bf-8f86-f26f6a07a425
132	0f433ba9-47e1-4fe6-902c-632bf40355a9	98fd5d7d-6f4c-434d-bd97-6fabe502db00	visa on arrival	90 days	\N	79a3f5aa-0b45-437e-9a0d-82b19b4143bd	0f433ba9-47e1-4fe6-902c-632bf40355a998fd5d7d-6f4c-434d-bd97-6fabe502db00
133	0f433ba9-47e1-4fe6-902c-632bf40355a9	f11d746c-8b82-4fe1-acb0-788067f0071c	visa not required	3 mons	\N	a6f2a706-a70c-4122-bd97-cc8fc257b73d	0f433ba9-47e1-4fe6-902c-632bf40355a9f11d746c-8b82-4fe1-acb0-788067f0071c
230	0f433ba9-47e1-4fe6-902c-632bf40355a9	8287bea9-2349-46e4-9ac0-fb1e799497af	visa not required	\N	\N	676444b9-cc3f-479c-85f2-3a2cb6de7bf4	0f433ba9-47e1-4fe6-902c-632bf40355a98287bea9-2349-46e4-9ac0-fb1e799497af
231	0f433ba9-47e1-4fe6-902c-632bf40355a9	68563b3e-8866-4310-bdce-659b3cc9c2ac	visa not required	\N	\N	441c9d6a-25e8-4e19-84ce-f9152c307352	0f433ba9-47e1-4fe6-902c-632bf40355a968563b3e-8866-4310-bdce-659b3cc9c2ac
232	0f433ba9-47e1-4fe6-902c-632bf40355a9	83f3b190-021f-4694-a033-57058c22cbf4	evisa	1 year	e-Visa holders must arrive via 26 designated airports[Note 1] or 3 designated seaports.[Note 2]\\nAn Indian e-Tourist Visa can only be obtained twice in one calendar year.	986a9628-270e-480f-a190-4efbfe449db5	0f433ba9-47e1-4fe6-902c-632bf40355a983f3b190-021f-4694-a033-57058c22cbf4
233	0f433ba9-47e1-4fe6-902c-632bf40355a9	a3122035-5d20-411c-a94d-17360ed55678	visa not required	30 days	Not available at all entry points.	737b4f68-1d0f-4201-aeee-7958483d5d9f	0f433ba9-47e1-4fe6-902c-632bf40355a9a3122035-5d20-411c-a94d-17360ed55678
234	0f433ba9-47e1-4fe6-902c-632bf40355a9	1baa5d83-2707-4a0d-8f86-45efc106dffd	visa required	\N	\N	1cb89316-219d-4cda-8e87-798a3e5ab88f	0f433ba9-47e1-4fe6-902c-632bf40355a91baa5d83-2707-4a0d-8f86-45efc106dffd
235	0f433ba9-47e1-4fe6-902c-632bf40355a9	e130f15d-7a37-4ddf-a6b5-e9c1266e128a	visa required	\N	Visa on arrival for 30 days at Erbil and Sulaymaniyah airports.	f07bada3-d3a7-4aee-8dee-08975df45071	0f433ba9-47e1-4fe6-902c-632bf40355a9e130f15d-7a37-4ddf-a6b5-e9c1266e128a
236	0f433ba9-47e1-4fe6-902c-632bf40355a9	48d25a4f-6bcb-4595-bf82-1492334695ec	visa not required	\N	\N	00d16360-0be4-491f-aae5-3576c2e6567f	0f433ba9-47e1-4fe6-902c-632bf40355a948d25a4f-6bcb-4595-bf82-1492334695ec
237	0f433ba9-47e1-4fe6-902c-632bf40355a9	fc3338b4-47f1-4342-8def-3acabc77a994	visa not required	3 mons	Entry refused to anyone who who knowingly issues a public call for boycotting Israel.	34ecf562-b374-4dc1-b3a9-d80a24b5c230	0f433ba9-47e1-4fe6-902c-632bf40355a9fc3338b4-47f1-4342-8def-3acabc77a994
238	0f433ba9-47e1-4fe6-902c-632bf40355a9	161a32a0-755e-430b-86dc-8f153f7de9b1	visa not required	\N	\N	65d3b49c-8aa2-4ba9-8008-31aeaa862da3	0f433ba9-47e1-4fe6-902c-632bf40355a9161a32a0-755e-430b-86dc-8f153f7de9b1
239	0f433ba9-47e1-4fe6-902c-632bf40355a9	31d93d6a-5130-4cfa-87ba-90d971d98d34	evisa	3 mons	eVisa holders must arrive via Port Bouet Airport.	af3287a1-0c1f-4cde-af66-228f413f3206	0f433ba9-47e1-4fe6-902c-632bf40355a931d93d6a-5130-4cfa-87ba-90d971d98d34
240	0f433ba9-47e1-4fe6-902c-632bf40355a9	96abeca6-c08e-4df8-b22f-2fefc55a8d5b	visa not required	180 days	\N	d2ed1869-e0c1-465d-acf0-b284241f5709	0f433ba9-47e1-4fe6-902c-632bf40355a996abeca6-c08e-4df8-b22f-2fefc55a8d5b
241	0f433ba9-47e1-4fe6-902c-632bf40355a9	8e5a125d-73cb-45c1-a511-f0c65d7448e7	visa not required	90 days	May be extended once for a further 90 days.	c1ea7160-ffd3-46ac-a040-f64b96af98be	0f433ba9-47e1-4fe6-902c-632bf40355a98e5a125d-73cb-45c1-a511-f0c65d7448e7
242	0f433ba9-47e1-4fe6-902c-632bf40355a9	c728bbe4-373f-4d0a-9a3f-985679759733	free visa on arrival	\N	Conditions apply	cfd2a544-978d-4ddd-8190-9ad715b4debe	0f433ba9-47e1-4fe6-902c-632bf40355a9c728bbe4-373f-4d0a-9a3f-985679759733
243	0f433ba9-47e1-4fe6-902c-632bf40355a9	c6a8ea7c-3fed-4a1d-9929-5569db7ab968	visa not required	30 days	\N	d70c2da8-1218-4d65-8ae8-09687b32b944	0f433ba9-47e1-4fe6-902c-632bf40355a9c6a8ea7c-3fed-4a1d-9929-5569db7ab968
244	0f433ba9-47e1-4fe6-902c-632bf40355a9	e91cae72-f62c-407e-b388-3f3b86f7a0c3	visa on arrival	3 mons	Can also be entered on an East Africa Tourist Visa issued by Rwanda or Uganda.	c6e0d290-dbf8-4579-a9d4-0f16baaa368b	0f433ba9-47e1-4fe6-902c-632bf40355a9e91cae72-f62c-407e-b388-3f3b86f7a0c3
245	0f433ba9-47e1-4fe6-902c-632bf40355a9	8275007a-70b9-4a04-bcfa-1c23825d4874	visa not required	30 days	\N	d94b010b-3394-4795-a686-fe2c7997b39b	0f433ba9-47e1-4fe6-902c-632bf40355a98275007a-70b9-4a04-bcfa-1c23825d4874
246	0f433ba9-47e1-4fe6-902c-632bf40355a9	9ad23145-f384-4a8f-a075-4648d1837d46	visa required	\N	\N	555ad2db-19cb-46f1-b2b7-24419ab9f55b	0f433ba9-47e1-4fe6-902c-632bf40355a99ad23145-f384-4a8f-a075-4648d1837d46
247	0f433ba9-47e1-4fe6-902c-632bf40355a9	52dc85c7-9f30-470a-9de9-09b95bc11e86	visa not required	90 days	\N	30808cf8-8aa7-4667-9f32-f50491703164	0f433ba9-47e1-4fe6-902c-632bf40355a952dc85c7-9f30-470a-9de9-09b95bc11e86
248	0f433ba9-47e1-4fe6-902c-632bf40355a9	ab2a946c-f1e3-43f5-bbfd-4b54adae333a	visa on arrival	3 mons	\N	211c6ed2-36a3-4149-8888-66cb875e4870	0f433ba9-47e1-4fe6-902c-632bf40355a9ab2a946c-f1e3-43f5-bbfd-4b54adae333a
249	0f433ba9-47e1-4fe6-902c-632bf40355a9	6cec735b-3406-430f-be56-71d96ff8f41e	visa not required	60 days	\N	ae8066e6-8ebf-4164-88b6-e4aaee253b63	0f433ba9-47e1-4fe6-902c-632bf40355a96cec735b-3406-430f-be56-71d96ff8f41e
250	0f433ba9-47e1-4fe6-902c-632bf40355a9	34e549be-e921-419a-a64d-2349902ee1e8	visa on arrival	30 days	\N	a126d72b-84b9-4668-aa14-4ad6e5be8a18	0f433ba9-47e1-4fe6-902c-632bf40355a934e549be-e921-419a-a64d-2349902ee1e8
251	0f433ba9-47e1-4fe6-902c-632bf40355a9	85b0fd58-f24b-4249-a31c-46e40023744c	visa not required	\N	\N	7ef6196f-6a99-4a7f-be6d-263cdf54d3ec	0f433ba9-47e1-4fe6-902c-632bf40355a985b0fd58-f24b-4249-a31c-46e40023744c
252	0f433ba9-47e1-4fe6-902c-632bf40355a9	6a6a8869-35f4-4d7f-af9f-c881d3b4bc19	free visa on arrival	1 mon	Extendable for 2 additional months; granted free of charge at Beirut International Airport or any other port of entry if there is no Israeli visa or seal, holding a telephone number, an address in Lebanon, and a non refundable return or circle trip ticket.	6fb03ec2-249f-495c-8089-d9a9efc4c156	0f433ba9-47e1-4fe6-902c-632bf40355a96a6a8869-35f4-4d7f-af9f-c881d3b4bc19
253	0f433ba9-47e1-4fe6-902c-632bf40355a9	f7ca89ef-b000-416a-b9f4-6059b2d8a3ca	visa not required	14 days	\N	363bdf58-d311-432d-8ad2-6d6a0d3b30c5	0f433ba9-47e1-4fe6-902c-632bf40355a9f7ca89ef-b000-416a-b9f4-6059b2d8a3ca
254	0f433ba9-47e1-4fe6-902c-632bf40355a9	e3c9a7c1-e5ec-46aa-be24-13a63b23c24a	visa required	\N	Pre-approved visa can be picked up on arrival.	c5775680-22d0-409c-a03e-54933bfd2a49	0f433ba9-47e1-4fe6-902c-632bf40355a9e3c9a7c1-e5ec-46aa-be24-13a63b23c24a
255	0f433ba9-47e1-4fe6-902c-632bf40355a9	a9bc64d6-1f2e-4882-90bc-4930614667da	visa required	\N	Pre-approved visa can be picked up on arrival.	6648a48b-ba3d-4b60-b233-16048a9f22fa	0f433ba9-47e1-4fe6-902c-632bf40355a9a9bc64d6-1f2e-4882-90bc-4930614667da
256	0f433ba9-47e1-4fe6-902c-632bf40355a9	8510166b-62a4-475f-8afe-891fe1cb22a0	visa not required	\N	\N	06c5d86d-ac11-4c2f-a93d-c641f552fd27	0f433ba9-47e1-4fe6-902c-632bf40355a98510166b-62a4-475f-8afe-891fe1cb22a0
257	0f433ba9-47e1-4fe6-902c-632bf40355a9	d4d24a30-2184-4fd3-8315-248ddc094526	visa not required	\N	\N	a755fd8f-b9bd-4577-8226-403c3c3f1fb6	0f433ba9-47e1-4fe6-902c-632bf40355a9d4d24a30-2184-4fd3-8315-248ddc094526
258	0f433ba9-47e1-4fe6-902c-632bf40355a9	a94b35b0-c269-4e9f-9d66-80d8f3081989	visa not required	\N	\N	41152ef1-983b-435a-9e62-a3185f26365f	0f433ba9-47e1-4fe6-902c-632bf40355a9a94b35b0-c269-4e9f-9d66-80d8f3081989
259	0f433ba9-47e1-4fe6-902c-632bf40355a9	b7206cc1-2cca-454d-9447-3788640f7b5e	visa on arrival	90 days	\N	bcbd880b-2aeb-4356-9856-705bbb5f190d	0f433ba9-47e1-4fe6-902c-632bf40355a9b7206cc1-2cca-454d-9447-3788640f7b5e
260	0f433ba9-47e1-4fe6-902c-632bf40355a9	413fe813-55c0-49e9-8853-47654b4ae73b	visa on arrival	90 days	\N	11dfa639-db98-4e90-88c1-710d5c5ebfb5	0f433ba9-47e1-4fe6-902c-632bf40355a9413fe813-55c0-49e9-8853-47654b4ae73b
261	0f433ba9-47e1-4fe6-902c-632bf40355a9	d42ac9fd-1e10-4995-8dc1-4d25cee7a022	visa not required	3 mons	\N	7d774c93-e02d-4708-a7a6-39b56c7c2714	0f433ba9-47e1-4fe6-902c-632bf40355a9d42ac9fd-1e10-4995-8dc1-4d25cee7a022
262	0f433ba9-47e1-4fe6-902c-632bf40355a9	2b8d132e-e3b8-4a97-aa78-a265bf65836d	free visa on arrival	30 days	\N	2a466793-772a-4867-8ec0-66510a3ff249	0f433ba9-47e1-4fe6-902c-632bf40355a92b8d132e-e3b8-4a97-aa78-a265bf65836d
263	0f433ba9-47e1-4fe6-902c-632bf40355a9	a8c0bf67-69a5-4293-8282-622c6b61962c	visa required	\N	\N	5db20b41-3829-48eb-9548-a5a4330b3954	0f433ba9-47e1-4fe6-902c-632bf40355a9a8c0bf67-69a5-4293-8282-622c6b61962c
264	0f433ba9-47e1-4fe6-902c-632bf40355a9	ca8f94ef-b748-47c8-b040-b996e3cf2581	visa not required	\N	\N	6f0c9ab5-f9b0-4206-9ffd-234294d9c523	0f433ba9-47e1-4fe6-902c-632bf40355a9ca8f94ef-b748-47c8-b040-b996e3cf2581
265	0f433ba9-47e1-4fe6-902c-632bf40355a9	27f40e7e-ab08-4e44-b643-f9546021f2c2	visa not required	90 days	90 days within any 180-day period	67e231f0-fd78-41e5-ada2-2b4fd2142195	0f433ba9-47e1-4fe6-902c-632bf40355a927f40e7e-ab08-4e44-b643-f9546021f2c2
266	0f433ba9-47e1-4fe6-902c-632bf40355a9	a4d1f62b-6131-44de-92fe-975d0a463bc7	visa on arrival	\N	Available at Nouakchott–Oumtounsy International Airport.	72ebc6b7-e696-4402-8e1e-5b31a6c9c8e9	0f433ba9-47e1-4fe6-902c-632bf40355a9a4d1f62b-6131-44de-92fe-975d0a463bc7
267	0f433ba9-47e1-4fe6-902c-632bf40355a9	59a60488-bbd7-476a-813e-a92fa901e8e7	visa not required	90 days	\N	91b8a5f8-a24e-425d-a90c-60993e096669	0f433ba9-47e1-4fe6-902c-632bf40355a959a60488-bbd7-476a-813e-a92fa901e8e7
268	0f433ba9-47e1-4fe6-902c-632bf40355a9	846ec109-79bc-4e46-a303-40e20bcb2f36	visa not required	180 days	\N	aaed4a9b-88b6-4c57-b144-24283d0a0bf4	0f433ba9-47e1-4fe6-902c-632bf40355a9846ec109-79bc-4e46-a303-40e20bcb2f36
269	0f433ba9-47e1-4fe6-902c-632bf40355a9	0343465d-616b-4419-b3ac-6e358776cb2e	visa not required	30 days	\N	1860ba39-c956-42dd-80b3-8dd9d1718b57	0f433ba9-47e1-4fe6-902c-632bf40355a90343465d-616b-4419-b3ac-6e358776cb2e
270	0f433ba9-47e1-4fe6-902c-632bf40355a9	6f37afd2-3170-4c9d-8fde-28d6a44eda0d	visa not required	90 days	90 days within any 180 day period	5beef097-c4b5-48a9-97bd-9318a8361db6	0f433ba9-47e1-4fe6-902c-632bf40355a96f37afd2-3170-4c9d-8fde-28d6a44eda0d
271	0f433ba9-47e1-4fe6-902c-632bf40355a9	e1b6cef2-9a2d-441a-96db-2cb815ac9398	visa not required	\N	\N	5c166f7c-0c54-49e5-a7fb-c99d1d6772c6	0f433ba9-47e1-4fe6-902c-632bf40355a9e1b6cef2-9a2d-441a-96db-2cb815ac9398
272	0f433ba9-47e1-4fe6-902c-632bf40355a9	b60fe946-71ac-40be-97dc-8ee0b78c3384	visa required	\N	\N	8089f2b0-f9b9-4d1f-961a-cc484e713e4d	0f433ba9-47e1-4fe6-902c-632bf40355a9b60fe946-71ac-40be-97dc-8ee0b78c3384
273	0f433ba9-47e1-4fe6-902c-632bf40355a9	a7462d3b-b094-454a-a09c-08573a566463	visa not required	90 days	For periods of longer than 90 days, a resident permit is required and can be issued by the Police Department in place of residence in Morocco.	0f0a215d-3d57-402a-bd1e-5c60cc6773cc	0f433ba9-47e1-4fe6-902c-632bf40355a9a7462d3b-b094-454a-a09c-08573a566463
274	0f433ba9-47e1-4fe6-902c-632bf40355a9	95251d34-e411-4cb7-9112-0a1f95b239e0	visa on arrival	30 days	\N	54ed825e-2d87-45fa-b4a1-8e60996cc22e	0f433ba9-47e1-4fe6-902c-632bf40355a995251d34-e411-4cb7-9112-0a1f95b239e0
275	0f433ba9-47e1-4fe6-902c-632bf40355a9	dff0e275-70f0-4d4b-9d4a-3b4029ab3cd1	visa not required	3 mons	3 months within a calendar year	912dfb7a-34f3-4f50-80d9-47bf9298550a	0f433ba9-47e1-4fe6-902c-632bf40355a9dff0e275-70f0-4d4b-9d4a-3b4029ab3cd1
276	0f433ba9-47e1-4fe6-902c-632bf40355a9	c00f0e5e-a315-4118-b879-8d0a07faa486	visa required	\N	\N	5d7de179-649d-432d-aef1-7110d4217164	0f433ba9-47e1-4fe6-902c-632bf40355a9c00f0e5e-a315-4118-b879-8d0a07faa486
277	0f433ba9-47e1-4fe6-902c-632bf40355a9	52a86412-42e6-499e-a742-a0902ca649b5	visa on arrival	90 days	Visa on arrival is extendable	8725977a-3b63-49ea-aec9-79abf215b833	0f433ba9-47e1-4fe6-902c-632bf40355a952a86412-42e6-499e-a742-a0902ca649b5
278	0f433ba9-47e1-4fe6-902c-632bf40355a9	649e4cd5-204a-41ae-add6-5c7433d23973	visa not required	\N	\N	48ef9747-52d4-4630-b2d0-4f6927724650	0f433ba9-47e1-4fe6-902c-632bf40355a9649e4cd5-204a-41ae-add6-5c7433d23973
279	0f433ba9-47e1-4fe6-902c-632bf40355a9	903625d0-0df4-4537-8370-4c3cda4ffed6	electronic travel authority	6 mons	May enter using eGate.\\nInternational Visitor Conservation and Tourism Levy must be obtained alongside Electronic Travel Authority.	93f411f7-c6bc-4164-8481-cd9926c1e47c	0f433ba9-47e1-4fe6-902c-632bf40355a9903625d0-0df4-4537-8370-4c3cda4ffed6
280	0f433ba9-47e1-4fe6-902c-632bf40355a9	390d0b06-0892-405b-93f4-8b1b69af9667	visa not required	90 days	\N	bcd8facf-fbde-4ed4-a591-9b7f66f0b11f	0f433ba9-47e1-4fe6-902c-632bf40355a9390d0b06-0892-405b-93f4-8b1b69af9667
281	0f433ba9-47e1-4fe6-902c-632bf40355a9	363bc536-025f-4ef7-95c0-a083bb8f37e6	visa required	\N	\N	3565c73f-9dbe-47df-92c1-485e38458e8e	0f433ba9-47e1-4fe6-902c-632bf40355a9363bc536-025f-4ef7-95c0-a083bb8f37e6
282	0f433ba9-47e1-4fe6-902c-632bf40355a9	7ce306aa-4c86-4016-93ab-cf3f5c22c621	visa required	\N	Pre-approved visa can be picked up on arrival.	4a4acb24-8103-4f91-a339-baf2c7336b12	0f433ba9-47e1-4fe6-902c-632bf40355a97ce306aa-4c86-4016-93ab-cf3f5c22c621
283	0f433ba9-47e1-4fe6-902c-632bf40355a9	6b9ca8c2-1096-496b-9aa2-0a0dc3fb4f32	visa not required	90 days	\N	0c9cf95b-9155-4517-9b4b-d8c1fcf38113	0f433ba9-47e1-4fe6-902c-632bf40355a96b9ca8c2-1096-496b-9aa2-0a0dc3fb4f32
284	0f433ba9-47e1-4fe6-902c-632bf40355a9	4f50cb61-60cb-48f5-9c7a-974d9c3840d5	visa not required	\N	\N	de37b41b-409b-4eb6-969e-cdd90e457d13	0f433ba9-47e1-4fe6-902c-632bf40355a94f50cb61-60cb-48f5-9c7a-974d9c3840d5
596	0f433ba9-47e1-4fe6-902c-632bf40355a9	c5ce24da-dd58-4e8e-a5e3-91b478717bb4	visa on arrival	\N	May apply online. Can also be entered on an East Africa Tourist Visa issued by Kenya or Rwanda.	e14fa177-37d8-4443-aafa-6247db396f5b	0f433ba9-47e1-4fe6-902c-632bf40355a9c5ce24da-dd58-4e8e-a5e3-91b478717bb4
597	0f433ba9-47e1-4fe6-902c-632bf40355a9	6b63bb5b-0238-4263-bdf4-8064a4fb5c26	visa not required	90 days	90 days within any 180 day period Until January 30, 2021.	af0048eb-1b8d-41c3-b6c4-c5cb6936805d	0f433ba9-47e1-4fe6-902c-632bf40355a96b63bb5b-0238-4263-bdf4-8064a4fb5c26
598	0f433ba9-47e1-4fe6-902c-632bf40355a9	0bea6297-7d53-49a7-927e-e5cbc57e3b5a	visa waiver program	90 days	ESTA required if arriving by air or cruise ship, which is valid for 2 years. ESTA is not required for Guam and Northern Mariana Islands.	651e02bb-8f83-488e-9e55-12684996864c	0f433ba9-47e1-4fe6-902c-632bf40355a90bea6297-7d53-49a7-927e-e5cbc57e3b5a
599	0f433ba9-47e1-4fe6-902c-632bf40355a9	3af87d1b-0507-4bfc-b6a1-e9b91d57fe65	visa not required	\N	\N	ec14f5ad-d86f-4f79-8115-1469f9032e9f	0f433ba9-47e1-4fe6-902c-632bf40355a93af87d1b-0507-4bfc-b6a1-e9b91d57fe65
600	0f433ba9-47e1-4fe6-902c-632bf40355a9	ec48dda4-e153-4854-9bc3-453263e606b1	visa not required	15 days	A single entry eVisa valid for 30 days is also available. Visa exemption extended until 30 June 2021. For periods longer than 30 days, a tourist visa is available.	0581d702-5ec6-4e76-b516-bf73ba93f791	0f433ba9-47e1-4fe6-902c-632bf40355a9ec48dda4-e153-4854-9bc3-453263e606b1
601	0f433ba9-47e1-4fe6-902c-632bf40355a9	9da8253b-a4dc-41f8-b8fa-e751b6812191	visa required	\N	A single tourist visa for British citizens is issued for a maximum stay of 60 days from arrival into Yemen.	a35c33d7-aef3-45b4-8fba-9dd91be7ec45	0f433ba9-47e1-4fe6-902c-632bf40355a99da8253b-a4dc-41f8-b8fa-e751b6812191
602	0f433ba9-47e1-4fe6-902c-632bf40355a9	40fbcdb1-c386-45b7-946f-7e4190dcc02c	visa on arrival	90 days	British citizens are eligible for a universal visa allowing access to Zimbabwe.	834f438c-b646-4f8a-9b5d-da820b54fb57	0f433ba9-47e1-4fe6-902c-632bf40355a940fbcdb1-c386-45b7-946f-7e4190dcc02c
603	0f433ba9-47e1-4fe6-902c-632bf40355a9	39658cd7-be12-4512-8a90-0b2cc9b2769d	visa on arrival	3 mons	British citizens are also eligible for a universal visa allowing access to Zambia.	7b1477ba-bc7f-4d4c-a999-a1f98848e1d0	0f433ba9-47e1-4fe6-902c-632bf40355a939658cd7-be12-4512-8a90-0b2cc9b2769d
604	0f433ba9-47e1-4fe6-902c-632bf40355a9	5cbe7035-cbba-4ba4-9e59-1338db15983a	visa not required	6 mons	British citizens with a connection to the territory have right of abode.	e5633cf6-a24a-49f3-9ea3-897b3001b357	0f433ba9-47e1-4fe6-902c-632bf40355a95cbe7035-cbba-4ba4-9e59-1338db15983a
605	0f433ba9-47e1-4fe6-902c-632bf40355a9	4fe94a12-77e5-4a49-94c4-6bff7b9f1b2e	visa not required	1 mon	Extension of stay possible. British citizens with a connection to the territory have right of abode.	35ad6bda-6b92-47cb-ab30-767a28a41283	0f433ba9-47e1-4fe6-902c-632bf40355a94fe94a12-77e5-4a49-94c4-6bff7b9f1b2e
606	0f433ba9-47e1-4fe6-902c-632bf40355a9	8372a0ad-58ad-41f7-af06-dea7df6ef891	visa not required	6 mons	British citizens with a connection to the territory have right of abode.	3db94a8b-e863-4cd4-ae70-48475f128972	0f433ba9-47e1-4fe6-902c-632bf40355a98372a0ad-58ad-41f7-af06-dea7df6ef891
607	0f433ba9-47e1-4fe6-902c-632bf40355a9	ff772da3-5cb8-4833-a427-2651adf6fbd6	visitor permit on arrival	28 days	The initial visitor's permit is valid for 4 weeks. Visitors who have a connection with the Falkland Islands have right of abode.	7768ccfa-2a91-42ce-b230-d611a58988f0	0f433ba9-47e1-4fe6-902c-632bf40355a9ff772da3-5cb8-4833-a427-2651adf6fbd6
608	0f433ba9-47e1-4fe6-902c-632bf40355a9	adc6de52-b3d9-4448-a7d6-39622cf3261f	visa not required	6 mons	British citizens with a connection to the territory have right of abode.	949c7f67-7dfd-4d4b-9b1b-d62b73f84fdc	0f433ba9-47e1-4fe6-902c-632bf40355a9adc6de52-b3d9-4448-a7d6-39622cf3261f
609	0f433ba9-47e1-4fe6-902c-632bf40355a9	6fda58dd-3eb4-49f9-8f07-8e0c4562675b	visa not required	14 days	Landing fee applies.	1bf512dd-271f-40af-8362-09c6351e2f6e	0f433ba9-47e1-4fe6-902c-632bf40355a96fda58dd-3eb4-49f9-8f07-8e0c4562675b
610	0f433ba9-47e1-4fe6-902c-632bf40355a9	29c528d3-2b84-4b14-adec-78d0f7a06fc1	visa not required	90 days	British citizens with a connection to the territory have right of abode.	1e326232-f5b6-4584-80bf-3b4bd98aa852	0f433ba9-47e1-4fe6-902c-632bf40355a929c528d3-2b84-4b14-adec-78d0f7a06fc1
611	0f433ba9-47e1-4fe6-902c-632bf40355a9	13ba7194-35d8-4666-bc59-4eb69058dc48	visa not required	\N	\N	693e600f-d83d-4b88-bc91-53f33183d99a	0f433ba9-47e1-4fe6-902c-632bf40355a913ba7194-35d8-4666-bc59-4eb69058dc48
612	0f433ba9-47e1-4fe6-902c-632bf40355a9	e9d06599-c594-4a7f-9e16-2c81897bd5dd	permit required	\N	Permit issued by the local police required for staying for less than 24 hours and permit issued by the Norwegian police for staying for more than 24 hours.	9fdcc2a9-fc91-4253-b1e7-ea1f5a986706	0f433ba9-47e1-4fe6-902c-632bf40355a9e9d06599-c594-4a7f-9e16-2c81897bd5dd
613	0f433ba9-47e1-4fe6-902c-632bf40355a9	cf4779ca-37a6-4f60-bc03-5d760a12c978	visa not required	\N	Unlimited Stay (Indefinite Stay).	4fc6d2ec-06a9-4163-8b78-940ac6587312	0f433ba9-47e1-4fe6-902c-632bf40355a9cf4779ca-37a6-4f60-bc03-5d760a12c978
614	0f433ba9-47e1-4fe6-902c-632bf40355a9	0a0b42b2-ee8d-44cb-8ce1-84effb466438	visa not required	\N	Visa free 90 days	2dc6ca16-ec5a-43e1-8136-9198a294f52a	0f433ba9-47e1-4fe6-902c-632bf40355a90a0b42b2-ee8d-44cb-8ce1-84effb466438
615	0f433ba9-47e1-4fe6-902c-632bf40355a9	0c720e46-2f5d-471e-9fc1-dc27bc3629f3	visa not required	\N	Visa free, however an invitation from a South Ossetian citizen or organisation must be provided. Multiple entry visa to Russia and three-day prior notification are also required to enter South Ossetia.	220d9850-b78d-4f01-9d97-76c43d37b8a0	0f433ba9-47e1-4fe6-902c-632bf40355a90c720e46-2f5d-471e-9fc1-dc27bc3629f3
616	0f433ba9-47e1-4fe6-902c-632bf40355a9	4f7bf3fc-1cdd-42ea-acc1-2325444ea405	freedom of movement	\N	Valid ID or Passport Required.	04172ea1-1931-443e-aeac-1b3757f84d7c	0f433ba9-47e1-4fe6-902c-632bf40355a94f7bf3fc-1cdd-42ea-acc1-2325444ea405
617	0f433ba9-47e1-4fe6-902c-632bf40355a9	e600ef6e-e2fa-42cd-a54e-60cd0a48c98f	freedom of movement	\N	Valid ID or Passport Required.	bcecb9c8-6c93-4154-b6db-45813acd2684	0f433ba9-47e1-4fe6-902c-632bf40355a9e600ef6e-e2fa-42cd-a54e-60cd0a48c98f
618	0f433ba9-47e1-4fe6-902c-632bf40355a9	ae7c2b6b-a504-4e11-a52c-97175217c0a7	visa not required	\N	Visa not required for 180 days. Prior to April 1997, British citizens were allowed to land and remain in Hong Kong for 12 months without being subject to any other condition of stay.	560ca232-bc4d-4a84-8240-62bc8441a21e	0f433ba9-47e1-4fe6-902c-632bf40355a9ae7c2b6b-a504-4e11-a52c-97175217c0a7
619	0f433ba9-47e1-4fe6-902c-632bf40355a9	be30ad9f-9895-40aa-825f-997c0efddfab	visa not required	\N	Visa not required for 6 months	4eb30ef3-f5c5-4bee-89ee-76906091f632	0f433ba9-47e1-4fe6-902c-632bf40355a9be30ad9f-9895-40aa-825f-997c0efddfab
620	0f433ba9-47e1-4fe6-902c-632bf40355a9	6ed0c70e-c6ab-4148-aae3-fbf474467390	visa not required	\N	Arrival by sea to Gaza Strip not allowed.	87fcea93-48d2-4ea2-9221-cf2734402b97	0f433ba9-47e1-4fe6-902c-632bf40355a96ed0c70e-c6ab-4148-aae3-fbf474467390
621	0f433ba9-47e1-4fe6-902c-632bf40355a9	1f6e1df0-b5ff-4eb0-89b2-0bd06cf52883	visa not required	\N	Visa not required for 90 days	41587932-90ea-4f5a-9098-eef73432d96f	0f433ba9-47e1-4fe6-902c-632bf40355a91f6e1df0-b5ff-4eb0-89b2-0bd06cf52883
622	0f433ba9-47e1-4fe6-902c-632bf40355a9	44344c65-9381-42d7-a573-6a9e38ead0f0	visa not required	\N	Visa not required for 30 days, extendable to 180 days.	de3340da-95b5-4e7c-aa3a-b27fc2d3da67	0f433ba9-47e1-4fe6-902c-632bf40355a944344c65-9381-42d7-a573-6a9e38ead0f0
623	0f433ba9-47e1-4fe6-902c-632bf40355a9	57781bac-bb12-4862-9e29-a3eb6ebed059	visa not required	\N	Visa not required up to 3 months	237fad9a-9ccd-4ff5-a5e1-7793f789e233	0f433ba9-47e1-4fe6-902c-632bf40355a957781bac-bb12-4862-9e29-a3eb6ebed059
624	0f433ba9-47e1-4fe6-902c-632bf40355a9	3ba46aea-ed4b-48bc-919d-a93a4d6f1d6e	visa not required	\N	Visa not required for 3 months.	ac7e53f8-8197-4872-85a6-5b6f8e8c3ef2	0f433ba9-47e1-4fe6-902c-632bf40355a93ba46aea-ed4b-48bc-919d-a93a4d6f1d6e
625	0f433ba9-47e1-4fe6-902c-632bf40355a9	5f5fad3d-69c4-41b1-bc88-d9b8cff77027	visa not required	\N	\N	7d4971f2-4cb9-4ddc-b46b-3e935441b527	0f433ba9-47e1-4fe6-902c-632bf40355a95f5fad3d-69c4-41b1-bc88-d9b8cff77027
626	0f433ba9-47e1-4fe6-902c-632bf40355a9	f18ec7fe-184e-4e4b-9ac5-14c5bfbf1fb7	visa not required	\N	Visa not required under the Visa Waiver Program, for 90 days on arrival from overseas for 2 years. ESTA required.	b4662aaa-4727-4bcd-b405-e2a2c92e734c	0f433ba9-47e1-4fe6-902c-632bf40355a9f18ec7fe-184e-4e4b-9ac5-14c5bfbf1fb7
627	0f433ba9-47e1-4fe6-902c-632bf40355a9	6668152c-57e0-4e48-b346-ced1c1abd14f	visa not required	\N	Visa not required for 90 days.	6da50b6d-3095-4f33-b8f2-bb920c665568	0f433ba9-47e1-4fe6-902c-632bf40355a96668152c-57e0-4e48-b346-ced1c1abd14f
628	0f433ba9-47e1-4fe6-902c-632bf40355a9	f873ab5f-e175-4a90-9e0e-1efe1d0880ff	visa not required	\N	Visa not required for 3 months.	fd26793a-13c7-493e-8a87-f71523b8c972	0f433ba9-47e1-4fe6-902c-632bf40355a9f873ab5f-e175-4a90-9e0e-1efe1d0880ff
629	0f433ba9-47e1-4fe6-902c-632bf40355a9	cd560671-9a56-4d59-a90b-3fc5876c54a8	visa not required	\N	Visa not required under the Visa Waiver Program, for 90 days on arrival from overseas for 2 years. ESTA required.	4ebdc236-2045-4283-921e-7e4c5950080c	0f433ba9-47e1-4fe6-902c-632bf40355a9cd560671-9a56-4d59-a90b-3fc5876c54a8
630	0f433ba9-47e1-4fe6-902c-632bf40355a9	9982d96a-7b45-4e8a-93c5-83056d6b0fc8	visa not required	\N	Visa free access for 31 days.	b048a09a-0cd5-4f64-90b2-87143b50e125	0f433ba9-47e1-4fe6-902c-632bf40355a99982d96a-7b45-4e8a-93c5-83056d6b0fc8
631	0f433ba9-47e1-4fe6-902c-632bf40355a9	472108f0-b6a2-410c-9885-d4fa3b3412bd	visa not required	\N	Visa not required.	3eedfcb8-3235-4c42-803d-7e0a1681b2c6	0f433ba9-47e1-4fe6-902c-632bf40355a9472108f0-b6a2-410c-9885-d4fa3b3412bd
632	0f433ba9-47e1-4fe6-902c-632bf40355a9	dbb53edf-6817-4a18-89b0-f6e2747c95ba	visa not required	\N	45 days	397ae410-c212-45d8-b4f2-e1079bc69c7f	0f433ba9-47e1-4fe6-902c-632bf40355a9dbb53edf-6817-4a18-89b0-f6e2747c95ba
633	0f433ba9-47e1-4fe6-902c-632bf40355a9	17b783e7-ad5c-473c-8787-aab9c9397fed	visa not required	\N	Visa not required for 3 months.	2b792891-d748-43d2-8276-3e888e17fade	0f433ba9-47e1-4fe6-902c-632bf40355a917b783e7-ad5c-473c-8787-aab9c9397fed
634	0f433ba9-47e1-4fe6-902c-632bf40355a9	90b92de2-8101-4bce-af13-51bf5f5e6da0	visa not required	\N	45 days	6ac8ae52-6e50-48d5-aa33-a2f9dcfb701e	0f433ba9-47e1-4fe6-902c-632bf40355a990b92de2-8101-4bce-af13-51bf5f5e6da0
635	0f433ba9-47e1-4fe6-902c-632bf40355a9	ed22e6e0-5acc-4f0a-9a6a-e85dac1fca31	entry permit required	\N	\N	f43a649b-1a15-4bd2-bf70-99d34de606a5	0f433ba9-47e1-4fe6-902c-632bf40355a9ed22e6e0-5acc-4f0a-9a6a-e85dac1fca31
636	0f433ba9-47e1-4fe6-902c-632bf40355a9	077da062-83f7-44a0-9a02-a6db1579d6ea	visa not required	\N	Visa not required.	6f96d49f-377a-494d-bc3a-31248b4bc7a0	0f433ba9-47e1-4fe6-902c-632bf40355a9077da062-83f7-44a0-9a02-a6db1579d6ea
637	0f433ba9-47e1-4fe6-902c-632bf40355a9	f2cdea77-ac81-4009-a139-487fed267132	special authorisation required	\N	Special permits required for  French Southern and Antarctic Lands,  Argentine Antarctica,  Australian Antarctic Territory,  Chilean Antarctic Territory,  Heard Island and McDonald Islands,  Peter I Island,  Queen Maud Land,  Ross Dependency.	5c220ef4-840b-40c3-b826-72cd8ba390b9	0f433ba9-47e1-4fe6-902c-632bf40355a9f2cdea77-ac81-4009-a139-487fed267132
638	0f433ba9-47e1-4fe6-902c-632bf40355a9	d95a4486-5ca4-4500-8b10-211b945552c8	visa not required	90 days	\N	ab8aa8c0-3a7d-4432-b27d-af1a67249bad	0f433ba9-47e1-4fe6-902c-632bf40355a9d95a4486-5ca4-4500-8b10-211b945552c8
639	0f433ba9-47e1-4fe6-902c-632bf40355a9	19c52566-e35f-44fd-8130-d64562928fe2	visa not required	30 days	\N	9136052a-749a-435e-a550-159aea6dcf18	0f433ba9-47e1-4fe6-902c-632bf40355a919c52566-e35f-44fd-8130-d64562928fe2
640	0f433ba9-47e1-4fe6-902c-632bf40355a9	33f94df7-cd4f-487a-aa5c-fb45b65f19d5	visa not required	30 days	\N	d7c35529-8f9e-42da-ac60-3e2f16e4df54	0f433ba9-47e1-4fe6-902c-632bf40355a933f94df7-cd4f-487a-aa5c-fb45b65f19d5
334	0f433ba9-47e1-4fe6-902c-632bf40355a9	7a1e411c-5e2b-4ef6-9561-73a4466af643	evisa	30 days	\N	5f34cd9f-0b00-46e9-b428-2387852de885	0f433ba9-47e1-4fe6-902c-632bf40355a97a1e411c-5e2b-4ef6-9561-73a4466af643
335	0f433ba9-47e1-4fe6-902c-632bf40355a9	abc45575-6e5a-49c5-9967-e067a503c8a6	online visa	\N	Online Visa eligible.\\nElectronic Travel Authorisation to obtain a visa on arrival for business purposes.	4c84746f-a3a5-4e01-9c7e-c16bd2885122	0f433ba9-47e1-4fe6-902c-632bf40355a9abc45575-6e5a-49c5-9967-e067a503c8a6
336	0f433ba9-47e1-4fe6-902c-632bf40355a9	43e7d908-36ff-47b2-813c-146e89e91aef	free visa on arrival	30 days	\N	84dc9153-d159-416e-a36d-647d660bf10b	0f433ba9-47e1-4fe6-902c-632bf40355a943e7d908-36ff-47b2-813c-146e89e91aef
337	0f433ba9-47e1-4fe6-902c-632bf40355a9	e32cd55b-2b25-444e-beb4-f86a6e81819b	visa not required	180 days	British nationals don't need a visa to visit Panama except if arriving by sea.	058ab19a-9357-4e4e-9af2-00b426c3377e	0f433ba9-47e1-4fe6-902c-632bf40355a9e32cd55b-2b25-444e-beb4-f86a6e81819b
338	0f433ba9-47e1-4fe6-902c-632bf40355a9	2f5d487b-20b7-47c4-b8fe-378d3c40839a	free visa on arrival	60 days	\N	ca1027d6-3f51-4abc-95ad-7129375c1d09	0f433ba9-47e1-4fe6-902c-632bf40355a92f5d487b-20b7-47c4-b8fe-378d3c40839a
339	0f433ba9-47e1-4fe6-902c-632bf40355a9	5091a6a9-aa19-4e48-890a-d0d3ccce88c7	visa not required	90 days	\N	de71011f-2d8d-4929-b738-f0aca04c96d9	0f433ba9-47e1-4fe6-902c-632bf40355a95091a6a9-aa19-4e48-890a-d0d3ccce88c7
340	0f433ba9-47e1-4fe6-902c-632bf40355a9	6fd50499-8698-4764-a9ea-d063e211ae85	visa not required	183 days	\N	954eb527-227c-4214-b387-80e63dd94c64	0f433ba9-47e1-4fe6-902c-632bf40355a96fd50499-8698-4764-a9ea-d063e211ae85
341	0f433ba9-47e1-4fe6-902c-632bf40355a9	d29dcef8-e41b-4540-8f88-8849607ad3f3	visa not required	30 days	A tourist visa is available from the Philippine Embassy before you travel, which will allow an initial 59 day stay.\\nSingle entry (3) and multiple entry visa with the length of stay of six (6) months to a year is available.	b37da8e8-59d8-40cd-9186-21306445274a	0f433ba9-47e1-4fe6-902c-632bf40355a9d29dcef8-e41b-4540-8f88-8849607ad3f3
342	0f433ba9-47e1-4fe6-902c-632bf40355a9	9a7ad7e0-1e36-4004-9879-568b56d0cf87	visa not required	\N	\N	73f10916-5b09-4335-ac9f-6415149cccc2	0f433ba9-47e1-4fe6-902c-632bf40355a99a7ad7e0-1e36-4004-9879-568b56d0cf87
343	0f433ba9-47e1-4fe6-902c-632bf40355a9	c2f84d45-aa39-4df1-8a87-e4dd0c5b34a1	visa not required	\N	\N	a2c1d64b-1762-46bc-9f60-8a0582a43e7d	0f433ba9-47e1-4fe6-902c-632bf40355a9c2f84d45-aa39-4df1-8a87-e4dd0c5b34a1
344	0f433ba9-47e1-4fe6-902c-632bf40355a9	90a93353-4714-42fc-8632-09f25bc1312a	visa not required	30 days	\N	3dfee19a-34e7-4a31-b840-a3391e6a4aa7	0f433ba9-47e1-4fe6-902c-632bf40355a990a93353-4714-42fc-8632-09f25bc1312a
345	0f433ba9-47e1-4fe6-902c-632bf40355a9	fdf4338f-fd3a-446b-9688-b28515d38074	visa not required	\N	\N	1d45e47e-0531-498f-9f4c-338ada170b75	0f433ba9-47e1-4fe6-902c-632bf40355a9fdf4338f-fd3a-446b-9688-b28515d38074
346	0f433ba9-47e1-4fe6-902c-632bf40355a9	ae5dee3a-1222-4f42-9f97-470ab88b3b7e	visa required	\N	72-hours visa free visit when entering by regular ferry via port of St. Petersburg, provided that a passenger spends the night on-board or in accommodation specifically approved by the travel agency.	5935d700-5c70-47d4-a3e3-4e7a1a14bf64	0f433ba9-47e1-4fe6-902c-632bf40355a9ae5dee3a-1222-4f42-9f97-470ab88b3b7e
347	0f433ba9-47e1-4fe6-902c-632bf40355a9	418d8911-a62b-4686-bf0e-f18b204398d8	visa on arrival	30 days	Can also be entered on an East Africa Tourist Visa issued by Kenya or Uganda.	6d076c81-c8ba-484f-adf6-6d88df238d87	0f433ba9-47e1-4fe6-902c-632bf40355a9418d8911-a62b-4686-bf0e-f18b204398d8
348	0f433ba9-47e1-4fe6-902c-632bf40355a9	ec506881-6436-49fc-b56e-42da02dd7d5b	visa not required	3 mons	\N	55d34b70-c680-4255-bdbe-d90257bb07de	0f433ba9-47e1-4fe6-902c-632bf40355a9ec506881-6436-49fc-b56e-42da02dd7d5b
349	0f433ba9-47e1-4fe6-902c-632bf40355a9	e3b26362-6759-4612-8863-4785505a679e	visa not required	42 days	\N	28fa56e5-31c4-4d97-9c3b-9a4a0e1fa645	0f433ba9-47e1-4fe6-902c-632bf40355a9e3b26362-6759-4612-8863-4785505a679e
350	0f433ba9-47e1-4fe6-902c-632bf40355a9	54824162-df76-4f5e-8783-404687f907f1	visa not required	1 mon	Extension of stay possible for additional 11 months.	4c9454e7-ff17-4916-9a20-30b0cc3833f4	0f433ba9-47e1-4fe6-902c-632bf40355a954824162-df76-4f5e-8783-404687f907f1
351	0f433ba9-47e1-4fe6-902c-632bf40355a9	7d76fbc2-43bb-467f-b36b-1b899f3d013a	visa not required	60 days	\N	95e3049c-c9a6-412c-9859-643dc69fab2e	0f433ba9-47e1-4fe6-902c-632bf40355a97d76fbc2-43bb-467f-b36b-1b899f3d013a
352	0f433ba9-47e1-4fe6-902c-632bf40355a9	1bc1c6a9-2028-4dcd-94bf-6d19bea049e6	visa not required	\N	\N	a9416143-0ba6-459a-8d32-f24ec30d9400	0f433ba9-47e1-4fe6-902c-632bf40355a91bc1c6a9-2028-4dcd-94bf-6d19bea049e6
353	0f433ba9-47e1-4fe6-902c-632bf40355a9	ab4bc3a4-7c19-4a94-905c-a7973e0feaff	visa not required	15 days	\N	312da041-dfa9-48d1-a939-1128d0e87a27	0f433ba9-47e1-4fe6-902c-632bf40355a9ab4bc3a4-7c19-4a94-905c-a7973e0feaff
354	0f433ba9-47e1-4fe6-902c-632bf40355a9	dfffd0b6-a252-421b-94cb-6d44695c5c8c	visa on arrival	90 days	\N	b5a66a01-3995-4e6b-a85c-daf16b353e76	0f433ba9-47e1-4fe6-902c-632bf40355a9dfffd0b6-a252-421b-94cb-6d44695c5c8c
355	0f433ba9-47e1-4fe6-902c-632bf40355a9	e98795b2-4086-41b5-bac1-4789d9aee005	visa not required	90 days	\N	652925df-4647-49c3-b7c3-61f44f6b1360	0f433ba9-47e1-4fe6-902c-632bf40355a9e98795b2-4086-41b5-bac1-4789d9aee005
356	0f433ba9-47e1-4fe6-902c-632bf40355a9	4998e162-96ca-4381-ab19-3dc43922884a	free visitor permit on arrival	3 mons	Issued free of charge.	1ccfe9c2-39f6-4dd8-b5a7-f7f166093ee5	0f433ba9-47e1-4fe6-902c-632bf40355a94998e162-96ca-4381-ab19-3dc43922884a
357	0f433ba9-47e1-4fe6-902c-632bf40355a9	d8df4bc3-503b-41ca-987e-423e41ecb52c	visa on arrival	30 days	\N	991ee8c0-777c-432c-9f64-cdf28182621f	0f433ba9-47e1-4fe6-902c-632bf40355a9d8df4bc3-503b-41ca-987e-423e41ecb52c
358	0f433ba9-47e1-4fe6-902c-632bf40355a9	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	visa not required	90 days	\N	f4d4a571-e7c0-4886-bc3b-3854d1aee762	0f433ba9-47e1-4fe6-902c-632bf40355a96e83ec38-7e2d-4c2d-8a9d-6991d4e876db
359	0f433ba9-47e1-4fe6-902c-632bf40355a9	dbc583de-b4de-46ba-aae0-1e8d35054bf3	visa not required	\N	\N	156761d9-8be9-4d43-bea1-2cd678db2782	0f433ba9-47e1-4fe6-902c-632bf40355a9dbc583de-b4de-46ba-aae0-1e8d35054bf3
360	0f433ba9-47e1-4fe6-902c-632bf40355a9	b7f76500-4fa3-457f-aca8-477f05aab728	free visitor permit on arrival	3 mons	Issued free of charge.	e078403b-74e3-4226-8b50-52ed7ae69cd3	0f433ba9-47e1-4fe6-902c-632bf40355a9b7f76500-4fa3-457f-aca8-477f05aab728
361	0f433ba9-47e1-4fe6-902c-632bf40355a9	98943525-f93f-426f-a3fe-b48bc18c0c52	visa on arrival	\N	Available at Berbera, Borama, Burao, Erigavo and Hargeisa airports.\\n30 days, available at Bosaso Airport, Galcaio Airport and Mogadishu Airport.	e3f3b154-baf8-4559-b689-9df95189a535	0f433ba9-47e1-4fe6-902c-632bf40355a998943525-f93f-426f-a3fe-b48bc18c0c52
362	0f433ba9-47e1-4fe6-902c-632bf40355a9	247ff0fd-78ad-4ca4-90f2-f0394a714535	visa not required	90 days	\N	43a30e6f-2609-4eb2-b991-d199393b5baa	0f433ba9-47e1-4fe6-902c-632bf40355a9247ff0fd-78ad-4ca4-90f2-f0394a714535
363	0f433ba9-47e1-4fe6-902c-632bf40355a9	3ffea3be-1c82-411a-b085-933205f900c7	visa required	\N	\N	e41a09ea-ac9e-4fdc-84f6-49c7d8a8b3a5	0f433ba9-47e1-4fe6-902c-632bf40355a93ffea3be-1c82-411a-b085-933205f900c7
364	0f433ba9-47e1-4fe6-902c-632bf40355a9	02e5c743-3075-4226-8c1d-ad97dadda3d8	visa not required	\N	\N	9799568d-ce0d-483e-b6d7-e259d93b6d66	0f433ba9-47e1-4fe6-902c-632bf40355a902e5c743-3075-4226-8c1d-ad97dadda3d8
365	0f433ba9-47e1-4fe6-902c-632bf40355a9	6c6c9e3f-2353-431c-83c4-2c0cc6c42ff6	visa on arrival	30 days	British citizens are allowed to extend their stay twice when in the country to a maximum stay of 90 days in total.	66b05039-a7ae-4e40-ba79-2faa2d4798e4	0f433ba9-47e1-4fe6-902c-632bf40355a96c6c9e3f-2353-431c-83c4-2c0cc6c42ff6
366	0f433ba9-47e1-4fe6-902c-632bf40355a9	c149c091-51c2-41d7-85a7-7d67bcac4230	visa required	\N	\N	eea3f6c4-743c-444f-a605-02c3de05dddf	0f433ba9-47e1-4fe6-902c-632bf40355a9c149c091-51c2-41d7-85a7-7d67bcac4230
367	0f433ba9-47e1-4fe6-902c-632bf40355a9	e0e0a4c5-9076-4a1e-949f-9dd4521eb0f3	e tourist card	90 days	Multiple entry eVisa is also available.	ba42074e-a18e-4a22-930b-bbd20bebb7c1	0f433ba9-47e1-4fe6-902c-632bf40355a9e0e0a4c5-9076-4a1e-949f-9dd4521eb0f3
368	0f433ba9-47e1-4fe6-902c-632bf40355a9	5c3dd764-6824-4689-a3e1-1d8c2dc3bc93	visa not required	\N	\N	ac11c89f-8bb9-42b8-b63f-ab4bf36dd0ff	0f433ba9-47e1-4fe6-902c-632bf40355a95c3dd764-6824-4689-a3e1-1d8c2dc3bc93
369	0f433ba9-47e1-4fe6-902c-632bf40355a9	dacd5cdd-8e56-4067-bfd8-febc66a04058	visa not required	\N	\N	30bc5d42-7b2f-4f43-bc10-b275f6cb6563	0f433ba9-47e1-4fe6-902c-632bf40355a9dacd5cdd-8e56-4067-bfd8-febc66a04058
370	0f433ba9-47e1-4fe6-902c-632bf40355a9	7073c668-a71d-4cf0-a8dd-71008877f8ca	visa required	\N	Visa not required for citizens born in Syria.	0421629a-ee66-490f-8559-4dc0f2ebc55e	0f433ba9-47e1-4fe6-902c-632bf40355a97073c668-a71d-4cf0-a8dd-71008877f8ca
371	0f433ba9-47e1-4fe6-902c-632bf40355a9	893ca48d-0871-46b1-b299-4bf7e7c98dfa	evisa	45 days	\N	20d58cf6-0acb-46c0-8643-59c61ba0bc1d	0f433ba9-47e1-4fe6-902c-632bf40355a9893ca48d-0871-46b1-b299-4bf7e7c98dfa
372	0f433ba9-47e1-4fe6-902c-632bf40355a9	1bf315d2-0a2d-4686-9ecb-6d28f8a5b861	visa on arrival	3 mons	\N	d8518b1c-3d10-4479-bbbf-a44d7f77496e	0f433ba9-47e1-4fe6-902c-632bf40355a91bf315d2-0a2d-4686-9ecb-6d28f8a5b861
373	0f433ba9-47e1-4fe6-902c-632bf40355a9	99d1c02c-0a04-4eae-b6cd-403f94e43959	visa not required	30 days	If not arriving by air, British citizens are only permitted two visits per year.\\nFor longer periods up to 60 days, a Tourist visa is available online.	3825048a-79f0-4fa6-9f7a-f44f8af9aeb7	0f433ba9-47e1-4fe6-902c-632bf40355a999d1c02c-0a04-4eae-b6cd-403f94e43959
374	0f433ba9-47e1-4fe6-902c-632bf40355a9	1a61eb0b-45a3-4b91-89c2-c22a20676491	visa on arrival	30 days	Visa on arrival is only available at the Presidente Nicolau Lobato International Airport or at the Dili Sea Port.	464baba2-b4d6-4e0b-9e2e-fcaf85aca616	0f433ba9-47e1-4fe6-902c-632bf40355a91a61eb0b-45a3-4b91-89c2-c22a20676491
375	0f433ba9-47e1-4fe6-902c-632bf40355a9	1a7ba610-72c3-4816-81b5-aad9503a4a9b	visa on arrival	7 days	\N	fac943bb-78ea-47bf-b641-29db67c5d3e1	0f433ba9-47e1-4fe6-902c-632bf40355a91a7ba610-72c3-4816-81b5-aad9503a4a9b
376	0f433ba9-47e1-4fe6-902c-632bf40355a9	85e41f4f-c125-4753-bbed-c2ffc7e1c288	free visa on arrival	31 days	\N	3e643a29-a18e-4348-9ed3-fef60a326a05	0f433ba9-47e1-4fe6-902c-632bf40355a985e41f4f-c125-4753-bbed-c2ffc7e1c288
377	0f433ba9-47e1-4fe6-902c-632bf40355a9	06659bc5-9958-457e-ac56-2860917a3d28	visa not required	\N	\N	abd14295-e508-495d-a9c0-9d4c6a0eb6b3	0f433ba9-47e1-4fe6-902c-632bf40355a906659bc5-9958-457e-ac56-2860917a3d28
378	0f433ba9-47e1-4fe6-902c-632bf40355a9	cac7a781-be5d-4c59-b9b8-d8bb65fb1487	visa not required	3 mons	\N	e8a51602-61fa-41ed-a61d-d39845bf8c69	0f433ba9-47e1-4fe6-902c-632bf40355a9cac7a781-be5d-4c59-b9b8-d8bb65fb1487
379	0f433ba9-47e1-4fe6-902c-632bf40355a9	fb99fe5c-118c-44d8-97ba-6570cdb7bd33	visa not required	3 mons	90 days within any 180 day period (as of 2nd March 2020)	de90cfaa-bb01-404b-8a5e-2c39dcfde1f1	0f433ba9-47e1-4fe6-902c-632bf40355a9fb99fe5c-118c-44d8-97ba-6570cdb7bd33
380	0f433ba9-47e1-4fe6-902c-632bf40355a9	0adc54bf-ff91-4cb0-8571-d89b779f1061	visa required	\N	Pre-approved visa can be picked up on arrival.	97d2d0fe-6745-4f08-93e8-f52feae739a2	0f433ba9-47e1-4fe6-902c-632bf40355a90adc54bf-ff91-4cb0-8571-d89b779f1061
381	0f433ba9-47e1-4fe6-902c-632bf40355a9	6596da04-74ae-4968-9776-6a7debe1b0aa	free visa on arrival	1 mon	\N	96f1145c-14fe-4c7d-862e-b12f1f2d45dd	0f433ba9-47e1-4fe6-902c-632bf40355a96596da04-74ae-4968-9776-6a7debe1b0aa
641	0f433ba9-47e1-4fe6-902c-632bf40355a9	3a93a29d-abcc-45af-8915-8e983662c88a	visa not required	90 days	\N	520c0733-697c-4a03-af34-f8b46d5e0a96	0f433ba9-47e1-4fe6-902c-632bf40355a93a93a29d-abcc-45af-8915-8e983662c88a
642	0f433ba9-47e1-4fe6-902c-632bf40355a9	99436fc3-8e6d-41af-9a25-f9ff3f9eadc5	right of abode	\N	British citizens have right of abode in the Bailiwick of Guernsey. In Guernsey and Sark, a work or employment permit is not required. In Alderney, a work or employment permit is required for persons without Guernsey (Alderney) status.	3f666842-2d98-471c-be7c-25a665db15c9	0f433ba9-47e1-4fe6-902c-632bf40355a999436fc3-8e6d-41af-9a25-f9ff3f9eadc5
643	0f433ba9-47e1-4fe6-902c-632bf40355a9	534d150e-315d-40fa-ae9d-6876e3ab6aa1	right of abode	\N	Work or employment permit is required for persons without “Isle of Man worker” status.	55818eb2-444a-4666-8622-2f2f91339485	0f433ba9-47e1-4fe6-902c-632bf40355a9534d150e-315d-40fa-ae9d-6876e3ab6aa1
644	0f433ba9-47e1-4fe6-902c-632bf40355a9	242bc52e-221a-4254-b523-8b339182f620	right of abode	\N	Work or employment permit is not required.	5962a814-93e2-41b1-a00f-1e99cf6e9b70	0f433ba9-47e1-4fe6-902c-632bf40355a9242bc52e-221a-4254-b523-8b339182f620
645	0f433ba9-47e1-4fe6-902c-632bf40355a9	c4d460f0-d8f6-49c2-a75d-076d40c3bf4e	right of abode	\N	British citizens have right of abode in Gibraltar.	94bd1a62-dce1-4fe3-9b23-7aba24318260	0f433ba9-47e1-4fe6-902c-632bf40355a9c4d460f0-d8f6-49c2-a75d-076d40c3bf4e
646	0f433ba9-47e1-4fe6-902c-632bf40355a9	7c843d31-a3b7-4fd6-854d-a41fd456ab79	visa not required	\N	Visa not required up to 3 months in the Western Sahara controlled territory.	79705b8a-277b-48d6-9471-4b6808faea8f	0f433ba9-47e1-4fe6-902c-632bf40355a97c843d31-a3b7-4fd6-854d-a41fd456ab79
647	0f433ba9-47e1-4fe6-902c-632bf40355a9	fef2c7ae-f872-4a71-9c87-0d0727258c26	visa not required	90 days	\N	0f0643b5-8f33-4e82-888d-3963f3eccee1	0f433ba9-47e1-4fe6-902c-632bf40355a9fef2c7ae-f872-4a71-9c87-0d0727258c26
648	0f433ba9-47e1-4fe6-902c-632bf40355a9	ba5a63e1-7feb-4d40-ae2f-d0a9f2123c0c	visa not required	90 days	French West Indies refers to Martinique, Guadeloupe, Saint Martin and Saint Barthélemy.	c494f068-5123-4914-a1b6-68d29af88cf5	0f433ba9-47e1-4fe6-902c-632bf40355a9ba5a63e1-7feb-4d40-ae2f-d0a9f2123c0c
649	0f433ba9-47e1-4fe6-902c-632bf40355a9	07546102-9696-4e5b-80fb-c435267230aa	visa not required	90 days	French West Indies refers to Martinique, Guadeloupe, Saint Martin and Saint Barthélemy.	cbe17311-b764-46ee-8db7-e7735990476e	0f433ba9-47e1-4fe6-902c-632bf40355a907546102-9696-4e5b-80fb-c435267230aa
650	0f433ba9-47e1-4fe6-902c-632bf40355a9	b4a2b89a-1d72-4928-becb-eb198ed494be	visa not required	3 mons	\N	a6fb0153-90ad-4a77-add8-28f6ed9a674b	0f433ba9-47e1-4fe6-902c-632bf40355a9b4a2b89a-1d72-4928-becb-eb198ed494be
1234	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	b33be079-39b7-4a1d-b689-97c224d5fece	visa required	\N	\N	62ec20e7-2fa1-40ff-8231-795f01245425	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbb33be079-39b7-4a1d-b689-97c224d5fece
652	0f433ba9-47e1-4fe6-902c-632bf40355a9	38c4b24f-a7d0-4af2-9d09-724ab4ad9017	visa not required	90 days	\N	66249b9b-487a-4ab8-814f-96680e5454a4	0f433ba9-47e1-4fe6-902c-632bf40355a938c4b24f-a7d0-4af2-9d09-724ab4ad9017
653	0f433ba9-47e1-4fe6-902c-632bf40355a9	188c245e-16ba-4c8b-a894-dcfd252e6735	visa required	30 days	\N	0b572511-2482-4fae-946b-2f3d08db73fb	0f433ba9-47e1-4fe6-902c-632bf40355a9188c245e-16ba-4c8b-a894-dcfd252e6735
654	d29dcef8-e41b-4540-8f88-8849607ad3f3	b33be079-39b7-4a1d-b689-97c224d5fece	visa required	\N	Women of all nationalities must cover their body with clothing, except for their face, hands and feet.	3fc8d252-e882-42d8-b8e6-fa4a9225f5f7	d29dcef8-e41b-4540-8f88-8849607ad3f3b33be079-39b7-4a1d-b689-97c224d5fece
655	d29dcef8-e41b-4540-8f88-8849607ad3f3	6c7e4e7d-9bf4-4e47-b2e4-c925f54bcd1a	visa required	\N	Philippine passport holders who have a valid, multiple-entry Schengen visa, which has been previously used in one of the Schengen states, or foreign citizens who have a valid permit of stay in one of the Schengen states, can enter visa-free.\\nPhilippine passport holders who have a valid, multiple-entry U.S. or UK visa, which has been previously used in the respective country of issuance, or have valid permit of stay in the U.S. or UK, can enter visa-free.	20992bea-a850-4023-89e4-46afe173af24	d29dcef8-e41b-4540-8f88-8849607ad3f36c7e4e7d-9bf4-4e47-b2e4-c925f54bcd1a
656	d29dcef8-e41b-4540-8f88-8849607ad3f3	d9b8f8c8-5b5a-41ef-8538-26d822a4c9bd	visa required	\N	\N	bb52a27f-f91c-4a5e-821d-5a4fd738c684	d29dcef8-e41b-4540-8f88-8849607ad3f3d9b8f8c8-5b5a-41ef-8538-26d822a4c9bd
657	d29dcef8-e41b-4540-8f88-8849607ad3f3	1965c743-cf9a-4021-9ed1-b9e4e77486a2	visa required	3 mons	There are no visa requirements for entry into Andorra, but it can only be accessed by passing through France or Spain. A multiple entry visa is required to re-enter either France or Spain when leaving Andorra.\\nAll visitors can stay for 3 months.	f072af63-4180-4e50-a08e-3479c63a72f1	d29dcef8-e41b-4540-8f88-8849607ad3f31965c743-cf9a-4021-9ed1-b9e4e77486a2
658	d29dcef8-e41b-4540-8f88-8849607ad3f3	bf07965f-f874-453e-a725-54c5a1254ee8	visa required	\N	\N	558ec0f9-bdfb-4faf-9b54-643159c82deb	d29dcef8-e41b-4540-8f88-8849607ad3f3bf07965f-f874-453e-a725-54c5a1254ee8
659	d29dcef8-e41b-4540-8f88-8849607ad3f3	793360a3-aa91-4703-acfe-60287e3f9b74	electronic entry visa	\N	\N	0462fe20-5768-43d1-a063-22c95510e8ce	d29dcef8-e41b-4540-8f88-8849607ad3f3793360a3-aa91-4703-acfe-60287e3f9b74
660	d29dcef8-e41b-4540-8f88-8849607ad3f3	f2cdea77-ac81-4009-a139-487fed267132	visa required	\N	Those with valid B2 or B1/B2 visa issued by the U.S. are eligible to apply for Electronic Travel Authorization (eTA) prior to arrival (eTA fee is $50 USD and processing time is 20 working days).	f623c3c4-1546-49e0-a291-6d19d4234c9d	d29dcef8-e41b-4540-8f88-8849607ad3f3f2cdea77-ac81-4009-a139-487fed267132
661	d29dcef8-e41b-4540-8f88-8849607ad3f3	90de1527-d5a5-446f-a960-eccda43af198	visa on arrival	120 days	\N	3c07d171-fedc-4e80-a53f-d5a1b9e1e45c	d29dcef8-e41b-4540-8f88-8849607ad3f390de1527-d5a5-446f-a960-eccda43af198
662	d29dcef8-e41b-4540-8f88-8849607ad3f3	0a3e548d-7e30-426f-840c-07ff9b6772f7	visa required	\N	May apply online (Online Visitor e600 visa).	b3422f4e-6ce9-424e-8c0e-8965b6c3d6ce	d29dcef8-e41b-4540-8f88-8849607ad3f30a3e548d-7e30-426f-840c-07ff9b6772f7
663	d29dcef8-e41b-4540-8f88-8849607ad3f3	e14f7607-8074-4eeb-8b3f-3093575719a4	visa required	\N	\N	dd7ae3a6-71c7-42c8-b697-e68507c235f0	d29dcef8-e41b-4540-8f88-8849607ad3f3e14f7607-8074-4eeb-8b3f-3093575719a4
693	d29dcef8-e41b-4540-8f88-8849607ad3f3	80b3fc54-1fa6-49c6-ac4c-998b002d754f	visa required	\N	\N	c079c9f9-87ce-430c-ba70-ef9a301aabf4	d29dcef8-e41b-4540-8f88-8849607ad3f380b3fc54-1fa6-49c6-ac4c-998b002d754f
664	d29dcef8-e41b-4540-8f88-8849607ad3f3	319530a8-8cd2-4dc3-84a6-29ac720c51da	visa required	\N	Visa on arrival for Filipinos residing in United Arab Emirates. Valid UAE residence visa along with the passport or travel document must be presented.	cef70384-a32c-48d1-8f4e-ac79ff634d65	d29dcef8-e41b-4540-8f88-8849607ad3f3319530a8-8cd2-4dc3-84a6-29ac720c51da
665	d29dcef8-e41b-4540-8f88-8849607ad3f3	ac6434f1-bbb9-4242-a393-d78d367f034a	visa required	\N	Permanent Residents of Canada do not need a visa and may stay up to 30 days.	f7d8f10a-0473-43f8-b21f-6d81384cad43	d29dcef8-e41b-4540-8f88-8849607ad3f3ac6434f1-bbb9-4242-a393-d78d367f034a
666	d29dcef8-e41b-4540-8f88-8849607ad3f3	497550d7-f9e9-4f1a-a5e0-8c9019c7bc31	visa required	\N	\N	00fe99c4-999e-442b-84f2-a2ec53cc7b71	d29dcef8-e41b-4540-8f88-8849607ad3f3497550d7-f9e9-4f1a-a5e0-8c9019c7bc31
667	d29dcef8-e41b-4540-8f88-8849607ad3f3	bb3fa754-b35e-45ee-8d66-fb159c96d821	visa required	\N	\N	42f906ba-ecbe-41a4-a124-c117ea106801	d29dcef8-e41b-4540-8f88-8849607ad3f3bb3fa754-b35e-45ee-8d66-fb159c96d821
668	d29dcef8-e41b-4540-8f88-8849607ad3f3	49494a5b-205f-4756-9145-2784c9269a99	visa not required	90 days	\N	98ac7393-bd89-48c4-8a85-909296a572a0	d29dcef8-e41b-4540-8f88-8849607ad3f349494a5b-205f-4756-9145-2784c9269a99
669	d29dcef8-e41b-4540-8f88-8849607ad3f3	ac612169-1567-4c5e-a203-3987fa26c267	visa required	\N	\N	092c86e4-1952-4d9f-9734-6eb5cf0d0a99	d29dcef8-e41b-4540-8f88-8849607ad3f3ac612169-1567-4c5e-a203-3987fa26c267
670	d29dcef8-e41b-4540-8f88-8849607ad3f3	1f4dd261-dc57-49ec-b872-8b1917703616	visa required	\N	\N	3e6b3e8f-2ea5-413f-a7f9-bf1906679d84	d29dcef8-e41b-4540-8f88-8849607ad3f31f4dd261-dc57-49ec-b872-8b1917703616
671	d29dcef8-e41b-4540-8f88-8849607ad3f3	3e62d48d-717d-4421-91c2-abb059a80576	visa required	\N	As of 2018, individuals with valid U.S. or Schengen Treaty Visas in their passports, as well as individuals with valid U.S. residency, do not require a visa to travel to Belize.	2069fd1a-5244-48c6-88aa-fd0857a0063e	d29dcef8-e41b-4540-8f88-8849607ad3f33e62d48d-717d-4421-91c2-abb059a80576
672	d29dcef8-e41b-4540-8f88-8849607ad3f3	5fbebc32-e410-4faa-94e5-822252f8b499	visa on arrival	30 days	Must have an international vaccination certificate.	c23b6e3a-2880-4887-8035-2e47c387f4cc	d29dcef8-e41b-4540-8f88-8849607ad3f35fbebc32-e410-4faa-94e5-822252f8b499
673	d29dcef8-e41b-4540-8f88-8849607ad3f3	1d58bd18-8519-4e53-8cd1-6a7e93cda614	visa required	\N	\N	ead7fad7-d706-4782-8d3b-b8f7ea700659	d29dcef8-e41b-4540-8f88-8849607ad3f31d58bd18-8519-4e53-8cd1-6a7e93cda614
674	d29dcef8-e41b-4540-8f88-8849607ad3f3	546440bf-236c-4f99-bd12-3bba52d50e02	visa not required	90 days	\N	d208c262-882f-4fed-97c3-2c4af285d8f2	d29dcef8-e41b-4540-8f88-8849607ad3f3546440bf-236c-4f99-bd12-3bba52d50e02
675	d29dcef8-e41b-4540-8f88-8849607ad3f3	c103dabb-a386-4a6a-bce5-c0c0fa5f43f6	visa required	\N	Visa free for up to 30 days for valid UK or Schengen visa holders.	99d0f13f-2146-4007-9ae6-d372dedabb4f	d29dcef8-e41b-4540-8f88-8849607ad3f3c103dabb-a386-4a6a-bce5-c0c0fa5f43f6
676	d29dcef8-e41b-4540-8f88-8849607ad3f3	ff4c5033-aee4-4325-90cc-1f96ef10bbce	visa required	\N	\N	6b71522e-29eb-42c2-96b7-51430272f256	d29dcef8-e41b-4540-8f88-8849607ad3f3ff4c5033-aee4-4325-90cc-1f96ef10bbce
677	d29dcef8-e41b-4540-8f88-8849607ad3f3	1b558876-4f84-41fb-8215-93143842ba53	visa not required	90 days	\N	cdf7f755-a6d8-4b54-b9db-4baa3594bc75	d29dcef8-e41b-4540-8f88-8849607ad3f31b558876-4f84-41fb-8215-93143842ba53
678	d29dcef8-e41b-4540-8f88-8849607ad3f3	49ca53d4-0d59-4be8-9724-70b0eff911ce	visa not required	14 days	\N	4e238207-410e-4249-a1bd-ec7ebacc2129	d29dcef8-e41b-4540-8f88-8849607ad3f349ca53d4-0d59-4be8-9724-70b0eff911ce
679	d29dcef8-e41b-4540-8f88-8849607ad3f3	dde93861-da65-40d4-8159-3e67e8d58e02	visa required	\N	\N	a35ccece-fa35-412d-816b-e2b9e2ee27b5	d29dcef8-e41b-4540-8f88-8849607ad3f3dde93861-da65-40d4-8159-3e67e8d58e02
680	d29dcef8-e41b-4540-8f88-8849607ad3f3	a22c7473-248e-4447-8bc7-1fc51c00ca3e	visa required	\N	\N	9f35db2b-b9db-4cd2-a9e1-bf2ff1f89d63	d29dcef8-e41b-4540-8f88-8849607ad3f3a22c7473-248e-4447-8bc7-1fc51c00ca3e
681	d29dcef8-e41b-4540-8f88-8849607ad3f3	4f0fe689-81e0-4b91-a093-cad33a305482	visa required	\N	\N	1922599d-f37b-4371-901d-4b787c4c1fd0	d29dcef8-e41b-4540-8f88-8849607ad3f34f0fe689-81e0-4b91-a093-cad33a305482
682	d29dcef8-e41b-4540-8f88-8849607ad3f3	723de35c-616a-4b10-b479-c08378f3765b	visa not required	30 days	\N	9c9e77d7-2280-4a88-ad9d-e09b403d7f06	d29dcef8-e41b-4540-8f88-8849607ad3f3723de35c-616a-4b10-b479-c08378f3765b
683	d29dcef8-e41b-4540-8f88-8849607ad3f3	526f75ae-3c43-45a3-924e-1d7e11177a68	visa required	\N	\N	33e2fea9-7896-478a-96f6-fe5451551d0d	d29dcef8-e41b-4540-8f88-8849607ad3f3526f75ae-3c43-45a3-924e-1d7e11177a68
684	d29dcef8-e41b-4540-8f88-8849607ad3f3	e242cbe2-dc75-4807-a7c9-c171d164ec2d	visa required	\N	Holders of 'Green cards' issued by the U.S. do not need a visa to visit or transit Canada, unless deemed inadmissible. Holders of B or C visas issued in Switzerland do not require transit visas when flying with Air Canada via the U.S.	444e7f1b-de59-4223-a61c-573fef9bdd76	d29dcef8-e41b-4540-8f88-8849607ad3f3e242cbe2-dc75-4807-a7c9-c171d164ec2d
685	d29dcef8-e41b-4540-8f88-8849607ad3f3	3e77325d-7fea-46ad-a8fa-b2d31056b3ea	visa on arrival	\N	\N	e028065d-0eef-4282-b7aa-d6044cf46f1b	d29dcef8-e41b-4540-8f88-8849607ad3f33e77325d-7fea-46ad-a8fa-b2d31056b3ea
686	d29dcef8-e41b-4540-8f88-8849607ad3f3	2b1aaccb-5846-45c1-8481-12bb8b5e0aa4	visa required	\N	\N	33aa15fe-6039-42e7-b89e-4ade0a726329	d29dcef8-e41b-4540-8f88-8849607ad3f32b1aaccb-5846-45c1-8481-12bb8b5e0aa4
687	d29dcef8-e41b-4540-8f88-8849607ad3f3	3f759fc5-8287-4acb-b58d-f235c5ef4981	visa required	\N	\N	3f69ced1-67cb-4067-b931-c315f30ed787	d29dcef8-e41b-4540-8f88-8849607ad3f33f759fc5-8287-4acb-b58d-f235c5ef4981
688	d29dcef8-e41b-4540-8f88-8849607ad3f3	c5a755fa-0935-4ec5-a880-3d4854beabfd	visa required	\N	\N	25592b90-9e2b-4908-9d87-483dfb6d15bf	d29dcef8-e41b-4540-8f88-8849607ad3f3c5a755fa-0935-4ec5-a880-3d4854beabfd
689	d29dcef8-e41b-4540-8f88-8849607ad3f3	7178da96-360e-4b0a-ada4-9640c498daf8	visa required	\N	Filipino citizens may travel without a visa to Hainan.\\nVisa on arrival for Shenzhen, provided that they have a previously issued Chinese visa, whether valid or expired.	3ee630df-6806-4704-ab1c-27a9d4fdd334	d29dcef8-e41b-4540-8f88-8849607ad3f37178da96-360e-4b0a-ada4-9640c498daf8
690	d29dcef8-e41b-4540-8f88-8849607ad3f3	8b58bd46-c2d7-4df7-8871-378dbe921468	visa not required	180 days	90 days on arrival, can extend another 90 days for 180 days total.	d0fe5b48-5b54-4079-ae45-31a7cdd203c3	d29dcef8-e41b-4540-8f88-8849607ad3f38b58bd46-c2d7-4df7-8871-378dbe921468
691	d29dcef8-e41b-4540-8f88-8849607ad3f3	48847459-b1b2-4092-9bf0-f0c08b928c74	visa on arrival	45 days	\N	5a0d707c-3046-4407-a007-144e06cbd7f9	d29dcef8-e41b-4540-8f88-8849607ad3f348847459-b1b2-4092-9bf0-f0c08b928c74
692	d29dcef8-e41b-4540-8f88-8849607ad3f3	196ed632-cc17-4b9f-87cb-cbc9832e8617	visa required	\N	\N	9bd7b9b7-a847-465c-835e-ea9232388c9b	d29dcef8-e41b-4540-8f88-8849607ad3f3196ed632-cc17-4b9f-87cb-cbc9832e8617
694	d29dcef8-e41b-4540-8f88-8849607ad3f3	cf56f0da-daf4-4437-9ad9-4b61bbedc31a	visa not required	90 days	30 days upon arrival, can extend for total of 90 days.	75afbdc3-99e6-4d44-85b6-ed0f18e03bf1	d29dcef8-e41b-4540-8f88-8849607ad3f3cf56f0da-daf4-4437-9ad9-4b61bbedc31a
695	d29dcef8-e41b-4540-8f88-8849607ad3f3	31d93d6a-5130-4cfa-87ba-90d971d98d34	visa not required	90 days	\N	0d7de5bf-1a60-4426-ab84-42c5a9f5b903	d29dcef8-e41b-4540-8f88-8849607ad3f331d93d6a-5130-4cfa-87ba-90d971d98d34
696	d29dcef8-e41b-4540-8f88-8849607ad3f3	14730d5f-e0e5-43a8-bc67-ca9f92c8502a	visa required	\N	Visa free for a maximum stay of 90 days for valid visa holders or residents of the Schengen member states.	e683af71-a97b-4ff8-8b27-26c97054fe40	d29dcef8-e41b-4540-8f88-8849607ad3f314730d5f-e0e5-43a8-bc67-ca9f92c8502a
697	d29dcef8-e41b-4540-8f88-8849607ad3f3	16a55dd1-2e47-489d-830c-3a88aad464a9	visa required	\N	Eligible to travel to Cuba for up to 30 days, provided that the Philippine passport holder has a tourist card and also holds a valid visa or permanent residence permit issued by Canada, the United States or an EU member state.	d04b5be4-0e79-41ce-a65c-b148486fabaf	d29dcef8-e41b-4540-8f88-8849607ad3f316a55dd1-2e47-489d-830c-3a88aad464a9
698	d29dcef8-e41b-4540-8f88-8849607ad3f3	f36ec987-ed66-4a88-9157-b1d4a934e515	visa required	\N	\N	14522058-9752-4e14-9b5e-dac71243acc4	d29dcef8-e41b-4540-8f88-8849607ad3f3f36ec987-ed66-4a88-9157-b1d4a934e515
699	d29dcef8-e41b-4540-8f88-8849607ad3f3	c5db5d6b-ebcd-4642-9604-0f1ebf2fdf9d	visa required	\N	\N	28ea18c0-6ca1-4bb8-ba23-6a534a1b6320	d29dcef8-e41b-4540-8f88-8849607ad3f3c5db5d6b-ebcd-4642-9604-0f1ebf2fdf9d
700	d29dcef8-e41b-4540-8f88-8849607ad3f3	870d8300-9c56-4b34-9447-bcdfedf8454c	visa required	\N	\N	6162778d-fc90-4853-aa1d-4390af09d8c3	d29dcef8-e41b-4540-8f88-8849607ad3f3870d8300-9c56-4b34-9447-bcdfedf8454c
701	d29dcef8-e41b-4540-8f88-8849607ad3f3	0b48c87c-ddaa-49d2-b736-61d9c44636e0	evisa	31 days	\N	2380546f-0bae-45ea-a2f8-86624de17a0b	d29dcef8-e41b-4540-8f88-8849607ad3f30b48c87c-ddaa-49d2-b736-61d9c44636e0
702	d29dcef8-e41b-4540-8f88-8849607ad3f3	a66c6aaf-f010-4056-8928-1653d670edf3	visa not required	21 days	\N	f7a3a0b1-0f3d-4c95-8e71-5ebe3c6b510d	d29dcef8-e41b-4540-8f88-8849607ad3f3a66c6aaf-f010-4056-8928-1653d670edf3
703	d29dcef8-e41b-4540-8f88-8849607ad3f3	7caae20c-20fa-4ce0-a987-cca304a302b9	visa required	\N	Permanent Residents of Canada do not require a visa and may stay up to 30 days.	551ec901-5268-483c-967f-e54afdcefb2b	d29dcef8-e41b-4540-8f88-8849607ad3f37caae20c-20fa-4ce0-a987-cca304a302b9
704	d29dcef8-e41b-4540-8f88-8849607ad3f3	41fa1fc8-a7c9-4045-ac6a-92fe36c27bd9	visa not required	90 days	\N	76b933f2-c674-424e-bc04-a9a802161de2	d29dcef8-e41b-4540-8f88-8849607ad3f341fa1fc8-a7c9-4045-ac6a-92fe36c27bd9
705	d29dcef8-e41b-4540-8f88-8849607ad3f3	0d0a18fd-d424-4a69-b646-38fffd942dd5	visa required	\N	\N	c69315d3-138d-413c-8d6a-4497a7be1617	d29dcef8-e41b-4540-8f88-8849607ad3f30d0a18fd-d424-4a69-b646-38fffd942dd5
706	d29dcef8-e41b-4540-8f88-8849607ad3f3	bae2df87-ee9b-4efe-8482-2b05b54ebb11	visa required	\N	\N	c9319d88-fb4e-4374-acef-e0875b9f5e97	d29dcef8-e41b-4540-8f88-8849607ad3f3bae2df87-ee9b-4efe-8482-2b05b54ebb11
707	d29dcef8-e41b-4540-8f88-8849607ad3f3	43d35de8-4ed4-4bd7-9fce-54d9adcdeec6	visa required	\N	\N	27e7a98c-44ad-4232-b448-c85422c3d1a9	d29dcef8-e41b-4540-8f88-8849607ad3f343d35de8-4ed4-4bd7-9fce-54d9adcdeec6
708	d29dcef8-e41b-4540-8f88-8849607ad3f3	b2db2210-e9b8-4d51-b3c0-ed8e3d6adc9b	visa required	\N	\N	401151aa-9d7f-44ee-b3e2-2e21d1a1a996	d29dcef8-e41b-4540-8f88-8849607ad3f3b2db2210-e9b8-4d51-b3c0-ed8e3d6adc9b
709	d29dcef8-e41b-4540-8f88-8849607ad3f3	061c7757-87bb-4acc-bfb5-ebb5a4dc9429	visa required	\N	\N	ab0643ff-c566-4969-9e4e-cd210640e3fc	d29dcef8-e41b-4540-8f88-8849607ad3f3061c7757-87bb-4acc-bfb5-ebb5a4dc9429
710	d29dcef8-e41b-4540-8f88-8849607ad3f3	646467f2-a7ee-4dc3-8589-902f948694cf	visa required	\N	\N	b3976334-ae9f-4691-ae95-47be5c2bc4fb	d29dcef8-e41b-4540-8f88-8849607ad3f3646467f2-a7ee-4dc3-8589-902f948694cf
711	d29dcef8-e41b-4540-8f88-8849607ad3f3	f76a50d7-c955-4658-a2da-f191b746b434	evisa	90 days	eVisa holders must arrive via Addis Ababa Bole International Airport.	591db20f-8445-408a-8c07-1847ac88b894	d29dcef8-e41b-4540-8f88-8849607ad3f3f76a50d7-c955-4658-a2da-f191b746b434
712	d29dcef8-e41b-4540-8f88-8849607ad3f3	923566be-1a81-4281-a9f5-fc3d8e59e53e	visa not required	4 mons	\N	09c6860b-1c18-4359-af9b-4e16db4b5e0d	d29dcef8-e41b-4540-8f88-8849607ad3f3923566be-1a81-4281-a9f5-fc3d8e59e53e
713	d29dcef8-e41b-4540-8f88-8849607ad3f3	d322fe64-203a-4eb4-8316-2c6c1af401a3	visa required	\N	\N	48e0e552-069b-41b8-a413-9421ee04b1b9	d29dcef8-e41b-4540-8f88-8849607ad3f3d322fe64-203a-4eb4-8316-2c6c1af401a3
714	d29dcef8-e41b-4540-8f88-8849607ad3f3	b7b802fe-8789-4b6d-b085-7c25a92dab7b	visa required	\N	Transit through a French airport also requires a transit visa	527a1961-139a-45ac-8176-25220b558414	d29dcef8-e41b-4540-8f88-8849607ad3f3b7b802fe-8789-4b6d-b085-7c25a92dab7b
715	d29dcef8-e41b-4540-8f88-8849607ad3f3	6a95dca7-5bc9-438d-ba51-5cc4603d70a4	evisa	\N	Electronic visa holders must arrive via Libreville International Airport.	37756243-4804-4c08-bdb4-8be265d8805a	d29dcef8-e41b-4540-8f88-8849607ad3f36a95dca7-5bc9-438d-ba51-5cc4603d70a4
716	d29dcef8-e41b-4540-8f88-8849607ad3f3	81e9890e-9239-4c33-b429-66950b214814	visa not required	90 days	Must obtain an entry clearance from the Gambian Immigration prior to travel.	be8f9bc6-9c27-41e0-8647-6172838dc4c0	d29dcef8-e41b-4540-8f88-8849607ad3f381e9890e-9239-4c33-b429-66950b214814
717	d29dcef8-e41b-4540-8f88-8849607ad3f3	f2e17057-cb16-4fd3-92ef-07a6320c1818	evisa	\N	No visa required for visit as a tourist if a valid Schengen visa is in a passport, must not stay longer than the validity period of the Schengen visa. No visa required for visit as a tourist if a valid original resident permit card from any GCC States is presented with Official English Translation (if the card has NO English Translation) and a Travel Insurance. With this scheme, a Philippine citizen can enter Georgia without a visa for 90 days in any 180-day period. Please, note that you must present relevant valid visa or residence permit along with your travel document/passport at the moment of crossing Georgian border. This should be verified with the travel document or/and other relevant document.	84067ddd-4a17-4f96-9b71-fbda3c1dff74	d29dcef8-e41b-4540-8f88-8849607ad3f3f2e17057-cb16-4fd3-92ef-07a6320c1818
718	d29dcef8-e41b-4540-8f88-8849607ad3f3	d80301ed-7cdc-4f2c-8093-cfec014b077a	visa required	\N	\N	48e6f4e3-608f-41d3-84a6-bae9d5f15170	d29dcef8-e41b-4540-8f88-8849607ad3f3d80301ed-7cdc-4f2c-8093-cfec014b077a
719	d29dcef8-e41b-4540-8f88-8849607ad3f3	53618499-ed33-49f9-aeae-e24d02029f1e	visa required	\N	\N	71a8186c-d482-48a3-85f3-f2bfc8d910fd	d29dcef8-e41b-4540-8f88-8849607ad3f353618499-ed33-49f9-aeae-e24d02029f1e
720	d29dcef8-e41b-4540-8f88-8849607ad3f3	1a76eb8a-5fca-4552-a0dd-9728217998b0	visa required	\N	\N	032788c0-bf87-49be-b235-246bb71a0851	d29dcef8-e41b-4540-8f88-8849607ad3f31a76eb8a-5fca-4552-a0dd-9728217998b0
721	d29dcef8-e41b-4540-8f88-8849607ad3f3	aedfe3b8-fc01-41f8-a152-516e139dc8b6	visa required	\N	\N	a802e02a-76a5-45e6-ad11-54624c391b52	d29dcef8-e41b-4540-8f88-8849607ad3f3aedfe3b8-fc01-41f8-a152-516e139dc8b6
722	d29dcef8-e41b-4540-8f88-8849607ad3f3	0e291c7e-51a2-466f-94b9-de8d9dec9dd2	visa required	\N	\N	58dd299f-58fa-4829-9887-64567127db71	d29dcef8-e41b-4540-8f88-8849607ad3f30e291c7e-51a2-466f-94b9-de8d9dec9dd2
723	d29dcef8-e41b-4540-8f88-8849607ad3f3	b3e98c98-8a15-45bf-8f86-f26f6a07a425	evisa	90 days	\N	ce48bc04-84b8-45bd-9363-622c709a92af	d29dcef8-e41b-4540-8f88-8849607ad3f3b3e98c98-8a15-45bf-8f86-f26f6a07a425
724	d29dcef8-e41b-4540-8f88-8849607ad3f3	98fd5d7d-6f4c-434d-bd97-6fabe502db00	visa on arrival	90 days	\N	255d9e8f-f011-4486-9016-d1f3465fcf92	d29dcef8-e41b-4540-8f88-8849607ad3f398fd5d7d-6f4c-434d-bd97-6fabe502db00
725	d29dcef8-e41b-4540-8f88-8849607ad3f3	f11d746c-8b82-4fe1-acb0-788067f0071c	visa required	\N	\N	3843b864-e78b-4d8d-8a29-c4b1671cbb2c	d29dcef8-e41b-4540-8f88-8849607ad3f3f11d746c-8b82-4fe1-acb0-788067f0071c
726	d29dcef8-e41b-4540-8f88-8849607ad3f3	99530f46-46c4-4263-bd88-dca23dc0383f	visa not required	3 mons	\N	d2441beb-33be-4808-b7b9-a2b2957533a0	d29dcef8-e41b-4540-8f88-8849607ad3f399530f46-46c4-4263-bd88-dca23dc0383f
727	d29dcef8-e41b-4540-8f88-8849607ad3f3	3e33cfe7-603b-4d88-a6e3-f4dcc331d9f2	visa required	\N	\N	6c358602-1307-4133-b019-3af5d3224f1f	d29dcef8-e41b-4540-8f88-8849607ad3f33e33cfe7-603b-4d88-a6e3-f4dcc331d9f2
728	d29dcef8-e41b-4540-8f88-8849607ad3f3	8287bea9-2349-46e4-9ac0-fb1e799497af	visa required	\N	\N	535059fa-2f41-4f25-af28-38c7573c632e	d29dcef8-e41b-4540-8f88-8849607ad3f38287bea9-2349-46e4-9ac0-fb1e799497af
729	d29dcef8-e41b-4540-8f88-8849607ad3f3	68563b3e-8866-4310-bdce-659b3cc9c2ac	visa required	\N	\N	fa8f354c-8fd7-4b79-8131-33f13746ad94	d29dcef8-e41b-4540-8f88-8849607ad3f368563b3e-8866-4310-bdce-659b3cc9c2ac
730	d29dcef8-e41b-4540-8f88-8849607ad3f3	83f3b190-021f-4694-a033-57058c22cbf4	evisa	180 days	e-Visa holders must arrive via 26 designated airports or 3 designated seaports. An Indian e-Tourist Visa can only be obtained twice in one calendar year.	67aa2a6b-38d7-4471-88b0-3925b8c60a40	d29dcef8-e41b-4540-8f88-8849607ad3f383f3b190-021f-4694-a033-57058c22cbf4
731	d29dcef8-e41b-4540-8f88-8849607ad3f3	a3122035-5d20-411c-a94d-17360ed55678	visa not required	30 days	\N	215ee866-8919-429d-8cd3-4908a681602c	d29dcef8-e41b-4540-8f88-8849607ad3f3a3122035-5d20-411c-a94d-17360ed55678
732	d29dcef8-e41b-4540-8f88-8849607ad3f3	1baa5d83-2707-4a0d-8f86-45efc106dffd	visa on arrival	30 days	\N	b23840d2-4b69-40eb-b694-a83676665a02	d29dcef8-e41b-4540-8f88-8849607ad3f31baa5d83-2707-4a0d-8f86-45efc106dffd
733	d29dcef8-e41b-4540-8f88-8849607ad3f3	e130f15d-7a37-4ddf-a6b5-e9c1266e128a	visa required	\N	\N	3b1e76e3-3f3f-4882-8cb2-b58b20a770ea	d29dcef8-e41b-4540-8f88-8849607ad3f3e130f15d-7a37-4ddf-a6b5-e9c1266e128a
734	d29dcef8-e41b-4540-8f88-8849607ad3f3	48d25a4f-6bcb-4595-bf82-1492334695ec	visa required	\N	\N	2e9ce5f3-7a38-4b2e-af2a-1fde6cbc1cd3	d29dcef8-e41b-4540-8f88-8849607ad3f348d25a4f-6bcb-4595-bf82-1492334695ec
735	d29dcef8-e41b-4540-8f88-8849607ad3f3	fc3338b4-47f1-4342-8def-3acabc77a994	visa not required	3 mons	\N	fed2d744-08cd-40ea-8286-a348b3c76ecb	d29dcef8-e41b-4540-8f88-8849607ad3f3fc3338b4-47f1-4342-8def-3acabc77a994
736	d29dcef8-e41b-4540-8f88-8849607ad3f3	161a32a0-755e-430b-86dc-8f153f7de9b1	visa required	\N	\N	413f3daa-9732-48b5-a506-9e2765fd7639	d29dcef8-e41b-4540-8f88-8849607ad3f3161a32a0-755e-430b-86dc-8f153f7de9b1
737	d29dcef8-e41b-4540-8f88-8849607ad3f3	96abeca6-c08e-4df8-b22f-2fefc55a8d5b	visa required	\N	Permanent Residents of Canada do not require a visa.	7283264b-18ab-4684-92b1-01f9f8c040ad	d29dcef8-e41b-4540-8f88-8849607ad3f396abeca6-c08e-4df8-b22f-2fefc55a8d5b
738	d29dcef8-e41b-4540-8f88-8849607ad3f3	8e5a125d-73cb-45c1-a511-f0c65d7448e7	visa required	\N	\N	3180be03-c4f6-4f34-b21c-e0e412ecea0e	d29dcef8-e41b-4540-8f88-8849607ad3f38e5a125d-73cb-45c1-a511-f0c65d7448e7
739	d29dcef8-e41b-4540-8f88-8849607ad3f3	c728bbe4-373f-4d0a-9a3f-985679759733	visa required	\N	\N	650e0c4f-74c5-4d62-bde5-7a695ef3b18c	d29dcef8-e41b-4540-8f88-8849607ad3f3c728bbe4-373f-4d0a-9a3f-985679759733
740	d29dcef8-e41b-4540-8f88-8849607ad3f3	c6a8ea7c-3fed-4a1d-9929-5569db7ab968	visa not required	\N	\N	2791f9d7-93b5-4436-bde9-294bc5ffef71	d29dcef8-e41b-4540-8f88-8849607ad3f3c6a8ea7c-3fed-4a1d-9929-5569db7ab968
741	d29dcef8-e41b-4540-8f88-8849607ad3f3	e91cae72-f62c-407e-b388-3f3b86f7a0c3	visa on arrival	3 mons	\N	a0d54a73-ddc7-477d-99dc-5d936cd6fb2f	d29dcef8-e41b-4540-8f88-8849607ad3f3e91cae72-f62c-407e-b388-3f3b86f7a0c3
742	d29dcef8-e41b-4540-8f88-8849607ad3f3	8275007a-70b9-4a04-bcfa-1c23825d4874	visa required	\N	\N	e140c31d-9ca7-4a85-8686-892195209cd2	d29dcef8-e41b-4540-8f88-8849607ad3f38275007a-70b9-4a04-bcfa-1c23825d4874
743	d29dcef8-e41b-4540-8f88-8849607ad3f3	9ad23145-f384-4a8f-a075-4648d1837d46	visa required	\N	\N	42e085ba-6409-43aa-8e3f-48cd61d56759	d29dcef8-e41b-4540-8f88-8849607ad3f39ad23145-f384-4a8f-a075-4648d1837d46
744	d29dcef8-e41b-4540-8f88-8849607ad3f3	52dc85c7-9f30-470a-9de9-09b95bc11e86	visa required	\N	Visa free transit (up to 30 days) provided holding a valid U.S., Canada, Australia, New Zealand visa, and arriving from or departing to those countries. Visa free access for 30 days to Jeju Island.	d95455b5-4de9-4850-8af7-e8c487a77f94	d29dcef8-e41b-4540-8f88-8849607ad3f352dc85c7-9f30-470a-9de9-09b95bc11e86
745	d29dcef8-e41b-4540-8f88-8849607ad3f3	ab2a946c-f1e3-43f5-bbfd-4b54adae333a	visa required	\N	\N	9f5a33d2-d043-476a-be4f-67e8966eea31	d29dcef8-e41b-4540-8f88-8849607ad3f3ab2a946c-f1e3-43f5-bbfd-4b54adae333a
746	d29dcef8-e41b-4540-8f88-8849607ad3f3	6cec735b-3406-430f-be56-71d96ff8f41e	visa on arrival	1 mon	Visa on arrival available at Manas International Airport. Electronic visa holders must arrive via Manas International Airport or Osh Airport or through land crossings with China (at Irkeshtam and Torugart), Kazakhstan (at Ak-jol, Ak-Tilek, Chaldybar, Chon-Kapka), Tajikistan (at Bor-Dobo, Kulundu, Kyzyl-Bel) and Uzbekistan (at Dostuk).	576c7074-c082-4fcb-925d-5cb47b956a10	d29dcef8-e41b-4540-8f88-8849607ad3f36cec735b-3406-430f-be56-71d96ff8f41e
747	d29dcef8-e41b-4540-8f88-8849607ad3f3	34e549be-e921-419a-a64d-2349902ee1e8	visa not required	30 days	\N	cd3fc44c-1fa2-4318-85cb-9ec331f9cfba	d29dcef8-e41b-4540-8f88-8849607ad3f334e549be-e921-419a-a64d-2349902ee1e8
748	d29dcef8-e41b-4540-8f88-8849607ad3f3	85b0fd58-f24b-4249-a31c-46e40023744c	visa required	\N	\N	8d736c45-b908-4d4e-9d45-129b7a8cc1ce	d29dcef8-e41b-4540-8f88-8849607ad3f385b0fd58-f24b-4249-a31c-46e40023744c
749	d29dcef8-e41b-4540-8f88-8849607ad3f3	6a6a8869-35f4-4d7f-af9f-c881d3b4bc19	visa required	\N	In addition to a visa, an approval should be obtained from the immigration department of the General Directorate of General Security (La Sûreté Générale).	fec46b2b-6cfc-47e9-8008-b88e991c31b4	d29dcef8-e41b-4540-8f88-8849607ad3f36a6a8869-35f4-4d7f-af9f-c881d3b4bc19
750	d29dcef8-e41b-4540-8f88-8849607ad3f3	f7ca89ef-b000-416a-b9f4-6059b2d8a3ca	evisa	\N	\N	f839d6e2-9722-4952-8a08-add822a71e4b	d29dcef8-e41b-4540-8f88-8849607ad3f3f7ca89ef-b000-416a-b9f4-6059b2d8a3ca
751	d29dcef8-e41b-4540-8f88-8849607ad3f3	e3c9a7c1-e5ec-46aa-be24-13a63b23c24a	visa required	\N	\N	4d606504-d399-446a-aa00-9c78dbcd8eb2	d29dcef8-e41b-4540-8f88-8849607ad3f3e3c9a7c1-e5ec-46aa-be24-13a63b23c24a
752	d29dcef8-e41b-4540-8f88-8849607ad3f3	a9bc64d6-1f2e-4882-90bc-4930614667da	visa required	\N	\N	bcdc4511-0298-4775-a907-c69e5c8a598d	d29dcef8-e41b-4540-8f88-8849607ad3f3a9bc64d6-1f2e-4882-90bc-4930614667da
753	d29dcef8-e41b-4540-8f88-8849607ad3f3	8510166b-62a4-475f-8afe-891fe1cb22a0	visa required	\N	\N	5488ad04-b013-4934-a628-09729c20f011	d29dcef8-e41b-4540-8f88-8849607ad3f38510166b-62a4-475f-8afe-891fe1cb22a0
754	d29dcef8-e41b-4540-8f88-8849607ad3f3	d4d24a30-2184-4fd3-8315-248ddc094526	visa required	\N	\N	b1fac780-2728-4e49-95ef-ae460f757f5d	d29dcef8-e41b-4540-8f88-8849607ad3f3d4d24a30-2184-4fd3-8315-248ddc094526
755	d29dcef8-e41b-4540-8f88-8849607ad3f3	a94b35b0-c269-4e9f-9d66-80d8f3081989	visa required	\N	\N	a65fd3ff-5c6e-4a20-8f96-472e0941dd57	d29dcef8-e41b-4540-8f88-8849607ad3f3a94b35b0-c269-4e9f-9d66-80d8f3081989
756	d29dcef8-e41b-4540-8f88-8849607ad3f3	b7206cc1-2cca-454d-9447-3788640f7b5e	visa on arrival	90 days	\N	fe0cb355-f2c1-4f63-9dcf-5a24d483c135	d29dcef8-e41b-4540-8f88-8849607ad3f3b7206cc1-2cca-454d-9447-3788640f7b5e
757	d29dcef8-e41b-4540-8f88-8849607ad3f3	413fe813-55c0-49e9-8853-47654b4ae73b	visa on arrival	90 days	30 days upon arrival. Can extend for a total of 90 days.	c78601d6-c7d6-4c51-abca-a8bba75c3206	d29dcef8-e41b-4540-8f88-8849607ad3f3413fe813-55c0-49e9-8853-47654b4ae73b
758	d29dcef8-e41b-4540-8f88-8849607ad3f3	d42ac9fd-1e10-4995-8dc1-4d25cee7a022	visa not required	30 days	\N	16026612-d86b-4ee5-8bb9-79f05119a87b	d29dcef8-e41b-4540-8f88-8849607ad3f3d42ac9fd-1e10-4995-8dc1-4d25cee7a022
759	d29dcef8-e41b-4540-8f88-8849607ad3f3	2b8d132e-e3b8-4a97-aa78-a265bf65836d	visa on arrival	30 days	\N	e360009f-12fa-4303-ad14-5359097b2bdb	d29dcef8-e41b-4540-8f88-8849607ad3f32b8d132e-e3b8-4a97-aa78-a265bf65836d
760	d29dcef8-e41b-4540-8f88-8849607ad3f3	a8c0bf67-69a5-4293-8282-622c6b61962c	visa required	\N	\N	2d8016ab-0512-431c-aa04-ccc84409da31	d29dcef8-e41b-4540-8f88-8849607ad3f3a8c0bf67-69a5-4293-8282-622c6b61962c
761	d29dcef8-e41b-4540-8f88-8849607ad3f3	ca8f94ef-b748-47c8-b040-b996e3cf2581	visa required	\N	\N	a49cf868-d7de-4463-9867-353e10dc8612	d29dcef8-e41b-4540-8f88-8849607ad3f3ca8f94ef-b748-47c8-b040-b996e3cf2581
762	d29dcef8-e41b-4540-8f88-8849607ad3f3	27f40e7e-ab08-4e44-b643-f9546021f2c2	visa on arrival	90 days	\N	b1f904f1-1a69-4adc-9d16-e9c3d6f9a6c8	d29dcef8-e41b-4540-8f88-8849607ad3f327f40e7e-ab08-4e44-b643-f9546021f2c2
763	d29dcef8-e41b-4540-8f88-8849607ad3f3	a4d1f62b-6131-44de-92fe-975d0a463bc7	visa on arrival	\N	Available at Nouakchott–Oumtounsy International Airport.	23ff63d7-2b8c-4045-be24-0b6342debd52	d29dcef8-e41b-4540-8f88-8849607ad3f3a4d1f62b-6131-44de-92fe-975d0a463bc7
764	d29dcef8-e41b-4540-8f88-8849607ad3f3	59a60488-bbd7-476a-813e-a92fa901e8e7	visa on arrival	60 days	\N	4a1d861e-5843-4a08-8054-a92d6eaf2084	d29dcef8-e41b-4540-8f88-8849607ad3f359a60488-bbd7-476a-813e-a92fa901e8e7
765	d29dcef8-e41b-4540-8f88-8849607ad3f3	846ec109-79bc-4e46-a303-40e20bcb2f36	visa required	\N	Permanent residents of Canada or of the United States (i.e., Green Card Holders), or holders of a valid Schengen visa or U.S. or Japan visa do not require a visa.	7221c9d3-a7f2-4ccb-95ae-feb259f22712	d29dcef8-e41b-4540-8f88-8849607ad3f3846ec109-79bc-4e46-a303-40e20bcb2f36
766	d29dcef8-e41b-4540-8f88-8849607ad3f3	0343465d-616b-4419-b3ac-6e358776cb2e	visa not required	30 days	\N	6164ba60-9553-4a09-b25e-fce77d1a7c61	d29dcef8-e41b-4540-8f88-8849607ad3f30343465d-616b-4419-b3ac-6e358776cb2e
767	d29dcef8-e41b-4540-8f88-8849607ad3f3	6f37afd2-3170-4c9d-8fde-28d6a44eda0d	visa required	\N	\N	18d61fbb-b12c-44d4-b8e0-ec2e2c8222f1	d29dcef8-e41b-4540-8f88-8849607ad3f36f37afd2-3170-4c9d-8fde-28d6a44eda0d
768	d29dcef8-e41b-4540-8f88-8849607ad3f3	e1b6cef2-9a2d-441a-96db-2cb815ac9398	visa required	\N	\N	32efa8b6-b418-4c8d-9c13-041856f8b5de	d29dcef8-e41b-4540-8f88-8849607ad3f3e1b6cef2-9a2d-441a-96db-2cb815ac9398
769	d29dcef8-e41b-4540-8f88-8849607ad3f3	b60fe946-71ac-40be-97dc-8ee0b78c3384	visa not required	21 days	\N	f861cf4b-5644-478c-b091-38a9f8b0054a	d29dcef8-e41b-4540-8f88-8849607ad3f3b60fe946-71ac-40be-97dc-8ee0b78c3384
770	d29dcef8-e41b-4540-8f88-8849607ad3f3	6702177a-fbed-4cf3-aa32-22da244beab0	visa required	\N	Holders of travel documents containing a valid Schengen, U.S., UK or Ireland visa, or a permission to stay in these countries, may enter and stay, or pass through the territory of Montenegro up to 30 days, and not longer than the expiry of visa, if the period of validity of the visa is less than 30 days.	4e37096d-bbf3-4360-8ef5-bd9bd3ba76a4	d29dcef8-e41b-4540-8f88-8849607ad3f36702177a-fbed-4cf3-aa32-22da244beab0
771	d29dcef8-e41b-4540-8f88-8849607ad3f3	a7462d3b-b094-454a-a09c-08573a566463	visa not required	90 days	\N	c374ccae-1b09-4b0d-b027-e267eca62281	d29dcef8-e41b-4540-8f88-8849607ad3f3a7462d3b-b094-454a-a09c-08573a566463
772	d29dcef8-e41b-4540-8f88-8849607ad3f3	95251d34-e411-4cb7-9112-0a1f95b239e0	visa on arrival	30 days	\N	351881d2-dad8-47df-9251-96dbe05754de	d29dcef8-e41b-4540-8f88-8849607ad3f395251d34-e411-4cb7-9112-0a1f95b239e0
773	d29dcef8-e41b-4540-8f88-8849607ad3f3	ac8b13ec-0d98-4fad-852e-a351d68e6a16	visa not required	14 days	Also eVisa available for 28 days. Holders must arrive via Yangon, Nay Pyi Taw or Mandalay airports.	31f2a284-ff38-463f-ab81-bc71f02e7b0d	d29dcef8-e41b-4540-8f88-8849607ad3f3ac8b13ec-0d98-4fad-852e-a351d68e6a16
774	d29dcef8-e41b-4540-8f88-8849607ad3f3	dff0e275-70f0-4d4b-9d4a-3b4029ab3cd1	visa required	\N	\N	73aafc43-55b7-4bad-8265-424521f136be	d29dcef8-e41b-4540-8f88-8849607ad3f3dff0e275-70f0-4d4b-9d4a-3b4029ab3cd1
775	d29dcef8-e41b-4540-8f88-8849607ad3f3	c00f0e5e-a315-4118-b879-8d0a07faa486	visa required	\N	\N	a73b831b-06aa-4a1a-8a05-f42916a4f084	d29dcef8-e41b-4540-8f88-8849607ad3f3c00f0e5e-a315-4118-b879-8d0a07faa486
776	d29dcef8-e41b-4540-8f88-8849607ad3f3	52a86412-42e6-499e-a742-a0902ca649b5	visa on arrival	90 days	\N	613c28f2-4ac2-421d-a071-1a3868caa93f	d29dcef8-e41b-4540-8f88-8849607ad3f352a86412-42e6-499e-a742-a0902ca649b5
777	d29dcef8-e41b-4540-8f88-8849607ad3f3	649e4cd5-204a-41ae-add6-5c7433d23973	visa required	\N	\N	510a4c43-c4ed-46cc-86ff-066100750f10	d29dcef8-e41b-4540-8f88-8849607ad3f3649e4cd5-204a-41ae-add6-5c7433d23973
778	d29dcef8-e41b-4540-8f88-8849607ad3f3	903625d0-0df4-4537-8370-4c3cda4ffed6	visa required	\N	May transit without a visa.	2d38f2db-ad0f-4b79-b5e4-34d76f54f6d4	d29dcef8-e41b-4540-8f88-8849607ad3f3903625d0-0df4-4537-8370-4c3cda4ffed6
779	d29dcef8-e41b-4540-8f88-8849607ad3f3	390d0b06-0892-405b-93f4-8b1b69af9667	visa on arrival	90 days	\N	220c758d-c0e1-4b77-9230-67b1b5b5f67e	d29dcef8-e41b-4540-8f88-8849607ad3f3390d0b06-0892-405b-93f4-8b1b69af9667
780	d29dcef8-e41b-4540-8f88-8849607ad3f3	363bc536-025f-4ef7-95c0-a083bb8f37e6	visa required	\N	\N	9e38d185-0b62-4c2e-85ab-2a89ed9c267a	d29dcef8-e41b-4540-8f88-8849607ad3f3363bc536-025f-4ef7-95c0-a083bb8f37e6
781	d29dcef8-e41b-4540-8f88-8849607ad3f3	7ce306aa-4c86-4016-93ab-cf3f5c22c621	visa required	\N	\N	fd608390-3d98-45f0-b146-20f71424fd5c	d29dcef8-e41b-4540-8f88-8849607ad3f37ce306aa-4c86-4016-93ab-cf3f5c22c621
782	d29dcef8-e41b-4540-8f88-8849607ad3f3	6b9ca8c2-1096-496b-9aa2-0a0dc3fb4f32	visa required	\N	Those with a valid British, Canadian or U.S. visa with a validity date at least 5 days beyond the intended period of stay in the Republic of Macedonia can stay for up to 15 (fifteen) days at any given entry on the territory of the Republic of Macedonia while the total duration of consecutive stays in the Republic of Macedonia must not exceed 3 (three) months in any six-month period calculated from the day of first entry.	bb5fdd0e-8639-4094-ad40-be2c0e2032a3	d29dcef8-e41b-4540-8f88-8849607ad3f36b9ca8c2-1096-496b-9aa2-0a0dc3fb4f32
783	d29dcef8-e41b-4540-8f88-8849607ad3f3	4f50cb61-60cb-48f5-9c7a-974d9c3840d5	visa required	\N	\N	23d8b3cd-349f-423c-bd9a-2da8ee28d35c	d29dcef8-e41b-4540-8f88-8849607ad3f34f50cb61-60cb-48f5-9c7a-974d9c3840d5
784	d29dcef8-e41b-4540-8f88-8849607ad3f3	7a1e411c-5e2b-4ef6-9561-73a4466af643	visa required	\N	\N	cf658a73-538d-40aa-b3fd-c7661c5e7e22	d29dcef8-e41b-4540-8f88-8849607ad3f37a1e411c-5e2b-4ef6-9561-73a4466af643
785	d29dcef8-e41b-4540-8f88-8849607ad3f3	abc45575-6e5a-49c5-9967-e067a503c8a6	online visa	\N	Online Visa eligible. Electronic Travel Authorization to obtain a visa on arrival for business purposes.	692b5ecc-ed4b-430e-aa35-36ffcc71d30d	d29dcef8-e41b-4540-8f88-8849607ad3f3abc45575-6e5a-49c5-9967-e067a503c8a6
786	d29dcef8-e41b-4540-8f88-8849607ad3f3	43e7d908-36ff-47b2-813c-146e89e91aef	visa on arrival	30 days	\N	8ff6d96c-be11-44d0-8a2e-2749ab9b7673	d29dcef8-e41b-4540-8f88-8849607ad3f343e7d908-36ff-47b2-813c-146e89e91aef
787	d29dcef8-e41b-4540-8f88-8849607ad3f3	e32cd55b-2b25-444e-beb4-f86a6e81819b	visa required	\N	Holders of a valid, multiple-entry visa of the United States, or United Kingdom, or Canada, or Australia, or Japan, or the Schengen Area, or Singapore, or South Korea are allowed to stay for thirty (30) days. Permanent residents of the United States, or United Kingdom, or Canada, or Australia, or Japan, of the European Union, or Singapore, or South Korea are allowed entry to stay for thirty (30) days.	03509b4b-b558-4881-8275-4c509632b729	d29dcef8-e41b-4540-8f88-8849607ad3f3e32cd55b-2b25-444e-beb4-f86a6e81819b
788	d29dcef8-e41b-4540-8f88-8849607ad3f3	2f5d487b-20b7-47c4-b8fe-378d3c40839a	free visa on arrival	60 days	\N	933ec608-0fea-4ddc-8a09-a21a5cee3cc0	d29dcef8-e41b-4540-8f88-8849607ad3f32f5d487b-20b7-47c4-b8fe-378d3c40839a
789	d29dcef8-e41b-4540-8f88-8849607ad3f3	5091a6a9-aa19-4e48-890a-d0d3ccce88c7	visa required	\N	\N	6ea254b9-c627-4bc8-85a5-418ffa6f5e00	d29dcef8-e41b-4540-8f88-8849607ad3f35091a6a9-aa19-4e48-890a-d0d3ccce88c7
790	d29dcef8-e41b-4540-8f88-8849607ad3f3	6fd50499-8698-4764-a9ea-d063e211ae85	visa not required	183 days	\N	88549897-623b-49ee-9989-1bb2219cebb1	d29dcef8-e41b-4540-8f88-8849607ad3f36fd50499-8698-4764-a9ea-d063e211ae85
791	d29dcef8-e41b-4540-8f88-8849607ad3f3	9a7ad7e0-1e36-4004-9879-568b56d0cf87	visa required	\N	\N	bbb5217b-9a2b-4d4e-a904-1707b7fa02d2	d29dcef8-e41b-4540-8f88-8849607ad3f39a7ad7e0-1e36-4004-9879-568b56d0cf87
792	d29dcef8-e41b-4540-8f88-8849607ad3f3	c2f84d45-aa39-4df1-8a87-e4dd0c5b34a1	visa required	\N	\N	dde6eaaa-79c3-404f-9fd3-dd2b012209d2	d29dcef8-e41b-4540-8f88-8849607ad3f3c2f84d45-aa39-4df1-8a87-e4dd0c5b34a1
793	d29dcef8-e41b-4540-8f88-8849607ad3f3	90a93353-4714-42fc-8632-09f25bc1312a	evisa	\N	\N	bc635804-06ed-4863-8e03-f7b65568f22a	d29dcef8-e41b-4540-8f88-8849607ad3f390a93353-4714-42fc-8632-09f25bc1312a
794	d29dcef8-e41b-4540-8f88-8849607ad3f3	fdf4338f-fd3a-446b-9688-b28515d38074	visa required	\N	\N	2a142969-6ed8-4107-822e-b09c527de366	d29dcef8-e41b-4540-8f88-8849607ad3f3fdf4338f-fd3a-446b-9688-b28515d38074
795	d29dcef8-e41b-4540-8f88-8849607ad3f3	ae5dee3a-1222-4f42-9f97-470ab88b3b7e	visa required	\N	As of July 1, 2019, Filipinos can apply online for an eVisa to visit the Kaliningrad Oblast for up to 8 days, for tourism or business purposes. Holders of eVisas must enter Kaliningrad through the following ports of entry: Khrabrovo (Air), Baltiysk Svetly (Seaport), Mamonovo Sovetsk (Railway) or Bagrationovsk Gusev (Road). As of October 1, 2019, Filipinos can apply online for a free eVisa to visit Saint Petersburg and the Leningrad Region for up to 8 days, for tourism or business purposes.	101b2f42-a427-4af7-9da7-256982660d1d	d29dcef8-e41b-4540-8f88-8849607ad3f3ae5dee3a-1222-4f42-9f97-470ab88b3b7e
796	d29dcef8-e41b-4540-8f88-8849607ad3f3	418d8911-a62b-4686-bf0e-f18b204398d8	visa not required	90 days	\N	78459819-78b9-4443-98ed-09e2fbba6418	d29dcef8-e41b-4540-8f88-8849607ad3f3418d8911-a62b-4686-bf0e-f18b204398d8
797	d29dcef8-e41b-4540-8f88-8849607ad3f3	57ec88b9-c03d-4f44-914b-27c8d2e9169c	evisa	30 days	\N	da405e2f-c225-420d-9c69-f4e481cfd012	d29dcef8-e41b-4540-8f88-8849607ad3f357ec88b9-c03d-4f44-914b-27c8d2e9169c
798	d29dcef8-e41b-4540-8f88-8849607ad3f3	52ee76db-8c13-4deb-9de4-a3b518a8e9bc	visa on arrival	42 days	\N	c67d963f-a9e8-4f41-9130-30ef5e28f469	d29dcef8-e41b-4540-8f88-8849607ad3f352ee76db-8c13-4deb-9de4-a3b518a8e9bc
799	d29dcef8-e41b-4540-8f88-8849607ad3f3	54824162-df76-4f5e-8783-404687f907f1	visa not required	1 mon	\N	5c850c69-a88f-49f2-b6d8-8a8f22ff40ac	d29dcef8-e41b-4540-8f88-8849607ad3f354824162-df76-4f5e-8783-404687f907f1
800	d29dcef8-e41b-4540-8f88-8849607ad3f3	7d76fbc2-43bb-467f-b36b-1b899f3d013a	entry permit on arrival	60 days	\N	25b0bcfa-e9a3-46c8-bfc2-73499c02b1e3	d29dcef8-e41b-4540-8f88-8849607ad3f37d76fbc2-43bb-467f-b36b-1b899f3d013a
801	d29dcef8-e41b-4540-8f88-8849607ad3f3	1bc1c6a9-2028-4dcd-94bf-6d19bea049e6	visa required	\N	\N	b8b5bcfb-4c0f-4eef-b736-fb304c87efdf	d29dcef8-e41b-4540-8f88-8849607ad3f31bc1c6a9-2028-4dcd-94bf-6d19bea049e6
802	d29dcef8-e41b-4540-8f88-8849607ad3f3	ab4bc3a4-7c19-4a94-905c-a7973e0feaff	evisa	\N	Visa is obtained online.	e23f5b11-3e53-4730-807b-ac97a5dbfae9	d29dcef8-e41b-4540-8f88-8849607ad3f3ab4bc3a4-7c19-4a94-905c-a7973e0feaff
803	d29dcef8-e41b-4540-8f88-8849607ad3f3	dfffd0b6-a252-421b-94cb-6d44695c5c8c	visa required	\N	Philippine passport holder with already used but still valid US, UK, Schengen visas can avail visa on arrival at any port of entry in Saudi Arabia.	c6565a98-10e1-4580-9a9e-40eb9a04a425	d29dcef8-e41b-4540-8f88-8849607ad3f3dfffd0b6-a252-421b-94cb-6d44695c5c8c
804	d29dcef8-e41b-4540-8f88-8849607ad3f3	e98795b2-4086-41b5-bac1-4789d9aee005	visa on arrival	90 days	\N	c7250919-1c77-4992-8d23-8c4486731a66	d29dcef8-e41b-4540-8f88-8849607ad3f3e98795b2-4086-41b5-bac1-4789d9aee005
805	d29dcef8-e41b-4540-8f88-8849607ad3f3	aae2ba87-a67d-43bd-8516-e403843d61d9	visa required	\N	Visa free for a maximum stay of 90 days for valid visa holders or residents of the European Union member states, Switzerland and the United States.	c33184db-d1b1-4ddd-88b9-93f01a4d743f	d29dcef8-e41b-4540-8f88-8849607ad3f3aae2ba87-a67d-43bd-8516-e403843d61d9
806	d29dcef8-e41b-4540-8f88-8849607ad3f3	4998e162-96ca-4381-ab19-3dc43922884a	free visitor permit on arrival	3 mons	\N	d7f39b82-c543-42ef-9799-d982c0c077f5	d29dcef8-e41b-4540-8f88-8849607ad3f34998e162-96ca-4381-ab19-3dc43922884a
807	d29dcef8-e41b-4540-8f88-8849607ad3f3	d8df4bc3-503b-41ca-987e-423e41ecb52c	visa required	\N	\N	7d352611-73d1-4b4e-8910-1420b184bb1b	d29dcef8-e41b-4540-8f88-8849607ad3f3d8df4bc3-503b-41ca-987e-423e41ecb52c
808	d29dcef8-e41b-4540-8f88-8849607ad3f3	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	visa not required	30 days	\N	16a5394e-29c7-4076-b94e-22e03d4165e3	d29dcef8-e41b-4540-8f88-8849607ad3f36e83ec38-7e2d-4c2d-8a9d-6991d4e876db
809	d29dcef8-e41b-4540-8f88-8849607ad3f3	2dd507e0-8e57-4924-a57f-8fc2e22555e2	visa required	\N	\N	d5175a30-0104-4197-8866-1657775b6d7f	d29dcef8-e41b-4540-8f88-8849607ad3f32dd507e0-8e57-4924-a57f-8fc2e22555e2
810	d29dcef8-e41b-4540-8f88-8849607ad3f3	dbc583de-b4de-46ba-aae0-1e8d35054bf3	visa required	\N	\N	19fcd5c0-133b-4dc3-83b9-24a94e666933	d29dcef8-e41b-4540-8f88-8849607ad3f3dbc583de-b4de-46ba-aae0-1e8d35054bf3
811	d29dcef8-e41b-4540-8f88-8849607ad3f3	b7f76500-4fa3-457f-aca8-477f05aab728	visa required	\N	\N	1cea5eec-5a18-47c4-ad6f-105c6ce3f998	d29dcef8-e41b-4540-8f88-8849607ad3f3b7f76500-4fa3-457f-aca8-477f05aab728
812	d29dcef8-e41b-4540-8f88-8849607ad3f3	98943525-f93f-426f-a3fe-b48bc18c0c52	visa on arrival	30 days	Available at Bosaso Airport, Galcaio Airport and Mogadishu Airport.	cec73f5c-da36-481b-ab1d-70c9a4d4b5c0	d29dcef8-e41b-4540-8f88-8849607ad3f398943525-f93f-426f-a3fe-b48bc18c0c52
813	d29dcef8-e41b-4540-8f88-8849607ad3f3	247ff0fd-78ad-4ca4-90f2-f0394a714535	visa required	\N	\N	d6bb2a5f-bb73-4d2f-bcdf-da4e98a0ae43	d29dcef8-e41b-4540-8f88-8849607ad3f3247ff0fd-78ad-4ca4-90f2-f0394a714535
814	d29dcef8-e41b-4540-8f88-8849607ad3f3	3ffea3be-1c82-411a-b085-933205f900c7	visa required	\N	\N	f9f8f15d-bd83-4bbf-8c84-23280167d341	d29dcef8-e41b-4540-8f88-8849607ad3f33ffea3be-1c82-411a-b085-933205f900c7
815	d29dcef8-e41b-4540-8f88-8849607ad3f3	02e5c743-3075-4226-8c1d-ad97dadda3d8	visa required	\N	\N	ad457fbc-5956-4915-9d09-afd80f38a8bd	d29dcef8-e41b-4540-8f88-8849607ad3f302e5c743-3075-4226-8c1d-ad97dadda3d8
816	d29dcef8-e41b-4540-8f88-8849607ad3f3	6c6c9e3f-2353-431c-83c4-2c0cc6c42ff6	visa on arrival	30 days	\N	ea74bb37-bafd-485c-a234-d09ad2b5e3c1	d29dcef8-e41b-4540-8f88-8849607ad3f36c6c9e3f-2353-431c-83c4-2c0cc6c42ff6
817	d29dcef8-e41b-4540-8f88-8849607ad3f3	c149c091-51c2-41d7-85a7-7d67bcac4230	visa required	\N	\N	23598db9-038b-42ca-b47d-5e884a54b6eb	d29dcef8-e41b-4540-8f88-8849607ad3f3c149c091-51c2-41d7-85a7-7d67bcac4230
818	d29dcef8-e41b-4540-8f88-8849607ad3f3	e0e0a4c5-9076-4a1e-949f-9dd4521eb0f3	visa not required	90 days	\N	3f6f2bb0-c793-416c-810a-2e4b241b1f56	d29dcef8-e41b-4540-8f88-8849607ad3f3e0e0a4c5-9076-4a1e-949f-9dd4521eb0f3
819	d29dcef8-e41b-4540-8f88-8849607ad3f3	5c3dd764-6824-4689-a3e1-1d8c2dc3bc93	visa required	\N	\N	262b09b7-0d3a-419f-9306-8dcedfa5e089	d29dcef8-e41b-4540-8f88-8849607ad3f35c3dd764-6824-4689-a3e1-1d8c2dc3bc93
820	d29dcef8-e41b-4540-8f88-8849607ad3f3	dacd5cdd-8e56-4067-bfd8-febc66a04058	visa required	\N	\N	cb44d70e-26d6-44b7-a73c-433f0cfe31b1	d29dcef8-e41b-4540-8f88-8849607ad3f3dacd5cdd-8e56-4067-bfd8-febc66a04058
821	d29dcef8-e41b-4540-8f88-8849607ad3f3	7073c668-a71d-4cf0-a8dd-71008877f8ca	visa required	\N	\N	58f5ca6a-8a6a-484a-a44c-8fcca47b028d	d29dcef8-e41b-4540-8f88-8849607ad3f37073c668-a71d-4cf0-a8dd-71008877f8ca
823	d29dcef8-e41b-4540-8f88-8849607ad3f3	893ca48d-0871-46b1-b299-4bf7e7c98dfa	evisa	45 days	E-visa holders can enter through all border points.	9fe10904-e2ab-4c86-b1d4-8bd895843fea	d29dcef8-e41b-4540-8f88-8849607ad3f3893ca48d-0871-46b1-b299-4bf7e7c98dfa
824	d29dcef8-e41b-4540-8f88-8849607ad3f3	1bf315d2-0a2d-4686-9ecb-6d28f8a5b861	visa on arrival	3 mons	\N	e7a01d9a-52c7-4d50-ad79-611299cde622	d29dcef8-e41b-4540-8f88-8849607ad3f31bf315d2-0a2d-4686-9ecb-6d28f8a5b861
825	d29dcef8-e41b-4540-8f88-8849607ad3f3	99d1c02c-0a04-4eae-b6cd-403f94e43959	visa not required	30 days	Maximum two visits annually if not arriving by air.	8ac3ef48-23e5-421b-995e-66e5dfda7de5	d29dcef8-e41b-4540-8f88-8849607ad3f399d1c02c-0a04-4eae-b6cd-403f94e43959
826	d29dcef8-e41b-4540-8f88-8849607ad3f3	1a61eb0b-45a3-4b91-89c2-c22a20676491	visa on arrival	30 days	\N	a4e11bad-0820-43c8-9940-29da432b9523	d29dcef8-e41b-4540-8f88-8849607ad3f31a61eb0b-45a3-4b91-89c2-c22a20676491
827	d29dcef8-e41b-4540-8f88-8849607ad3f3	1a7ba610-72c3-4816-81b5-aad9503a4a9b	visa on arrival	7 days	\N	e9f88695-a4c5-471e-a635-2b793bea2d47	d29dcef8-e41b-4540-8f88-8849607ad3f31a7ba610-72c3-4816-81b5-aad9503a4a9b
828	d29dcef8-e41b-4540-8f88-8849607ad3f3	85e41f4f-c125-4753-bbed-c2ffc7e1c288	visa required	\N	\N	17aa343f-fdda-42a6-93b3-637f2d55ab9d	d29dcef8-e41b-4540-8f88-8849607ad3f385e41f4f-c125-4753-bbed-c2ffc7e1c288
829	d29dcef8-e41b-4540-8f88-8849607ad3f3	06659bc5-9958-457e-ac56-2860917a3d28	visa on arrival	\N	\N	72b2732c-5a42-416e-90df-a72bf0328665	d29dcef8-e41b-4540-8f88-8849607ad3f306659bc5-9958-457e-ac56-2860917a3d28
830	d29dcef8-e41b-4540-8f88-8849607ad3f3	cac7a781-be5d-4c59-b9b8-d8bb65fb1487	visa required	\N	\N	8b5f028d-1935-45d7-bc74-d390a0a4224b	d29dcef8-e41b-4540-8f88-8849607ad3f3cac7a781-be5d-4c59-b9b8-d8bb65fb1487
831	d29dcef8-e41b-4540-8f88-8849607ad3f3	fb99fe5c-118c-44d8-97ba-6570cdb7bd33	visa required	30 days	eVisas can be obtained online for US$20 provided that a return ticket, hotel reservation and at least US$50 for each day's stay is shown. Must travel for the purposes of tourism or business and hold a valid visa OR valid residence permit from one of the Schengen countries, U.S., UK or Ireland (E-visas are not accepted).	1ff21861-16d8-469d-b343-b9567c7074e7	d29dcef8-e41b-4540-8f88-8849607ad3f3fb99fe5c-118c-44d8-97ba-6570cdb7bd33
832	d29dcef8-e41b-4540-8f88-8849607ad3f3	0adc54bf-ff91-4cb0-8571-d89b779f1061	visa required	\N	\N	b3623584-0234-42e4-9ea7-f1bd5d83b5de	d29dcef8-e41b-4540-8f88-8849607ad3f30adc54bf-ff91-4cb0-8571-d89b779f1061
833	d29dcef8-e41b-4540-8f88-8849607ad3f3	6596da04-74ae-4968-9776-6a7debe1b0aa	visa on arrival	1 mon	\N	793a65a3-6877-48db-86ce-6fa85d6b1122	d29dcef8-e41b-4540-8f88-8849607ad3f36596da04-74ae-4968-9776-6a7debe1b0aa
834	d29dcef8-e41b-4540-8f88-8849607ad3f3	c5ce24da-dd58-4e8e-a5e3-91b478717bb4	visa on arrival	\N	May apply online.	3aedf4ee-5ece-4dea-83c6-072ee82ab143	d29dcef8-e41b-4540-8f88-8849607ad3f3c5ce24da-dd58-4e8e-a5e3-91b478717bb4
835	d29dcef8-e41b-4540-8f88-8849607ad3f3	6b63bb5b-0238-4263-bdf4-8064a4fb5c26	visa required	\N	\N	9e044830-f3e5-47b4-8fcc-8cde15ce5218	d29dcef8-e41b-4540-8f88-8849607ad3f36b63bb5b-0238-4263-bdf4-8064a4fb5c26
836	d29dcef8-e41b-4540-8f88-8849607ad3f3	2b1a33fe-be25-452b-8a1c-c7d5f1dce9c2	visa required	\N	\N	896d4a9e-b5f7-4326-9e7e-d61765afa8eb	d29dcef8-e41b-4540-8f88-8849607ad3f32b1a33fe-be25-452b-8a1c-c7d5f1dce9c2
837	d29dcef8-e41b-4540-8f88-8849607ad3f3	0f433ba9-47e1-4fe6-902c-632bf40355a9	visa required	\N	\N	6cbcf865-9b14-49a4-bf9c-accc099399e2	d29dcef8-e41b-4540-8f88-8849607ad3f30f433ba9-47e1-4fe6-902c-632bf40355a9
838	d29dcef8-e41b-4540-8f88-8849607ad3f3	0bea6297-7d53-49a7-927e-e5cbc57e3b5a	visa required	\N	\N	704d10fa-1e85-499b-be67-f535fdec4d94	d29dcef8-e41b-4540-8f88-8849607ad3f30bea6297-7d53-49a7-927e-e5cbc57e3b5a
839	d29dcef8-e41b-4540-8f88-8849607ad3f3	d95a4486-5ca4-4500-8b10-211b945552c8	visa required	\N	\N	4bafea16-ed0a-4f80-9224-53de4953c7c9	d29dcef8-e41b-4540-8f88-8849607ad3f3d95a4486-5ca4-4500-8b10-211b945552c8
840	d29dcef8-e41b-4540-8f88-8849607ad3f3	19c52566-e35f-44fd-8130-d64562928fe2	evisa	30 days	5-day visa free transit when in transit at the international airports on condition of holding a confirmed onward ticket for a flight to a third country.	fcb92f8b-82a7-4050-932a-dfc955cb55f4	d29dcef8-e41b-4540-8f88-8849607ad3f319c52566-e35f-44fd-8130-d64562928fe2
841	d29dcef8-e41b-4540-8f88-8849607ad3f3	33f94df7-cd4f-487a-aa5c-fb45b65f19d5	visa not required	30 days	\N	27ade60b-075b-4b7c-8c6b-1eef524d0e46	d29dcef8-e41b-4540-8f88-8849607ad3f333f94df7-cd4f-487a-aa5c-fb45b65f19d5
842	d29dcef8-e41b-4540-8f88-8849607ad3f3	3af87d1b-0507-4bfc-b6a1-e9b91d57fe65	visa required	\N	\N	d2783b93-7514-4b57-8511-d0672cd87f91	d29dcef8-e41b-4540-8f88-8849607ad3f33af87d1b-0507-4bfc-b6a1-e9b91d57fe65
843	d29dcef8-e41b-4540-8f88-8849607ad3f3	3a93a29d-abcc-45af-8915-8e983662c88a	visa required	\N	\N	5262bdec-78e7-4b4a-8d43-df0bdb92a78f	d29dcef8-e41b-4540-8f88-8849607ad3f33a93a29d-abcc-45af-8915-8e983662c88a
844	d29dcef8-e41b-4540-8f88-8849607ad3f3	ec48dda4-e153-4854-9bc3-453263e606b1	visa not required	21 days	A single entry eVisa valid for 30 days is also available.	1fc41ce9-b09a-4c24-a8fa-805cb123329e	d29dcef8-e41b-4540-8f88-8849607ad3f3ec48dda4-e153-4854-9bc3-453263e606b1
845	d29dcef8-e41b-4540-8f88-8849607ad3f3	9da8253b-a4dc-41f8-b8fa-e751b6812191	visa required	\N	\N	40c56542-b7c2-4ab5-a68b-15b5279434fc	d29dcef8-e41b-4540-8f88-8849607ad3f39da8253b-a4dc-41f8-b8fa-e751b6812191
846	d29dcef8-e41b-4540-8f88-8849607ad3f3	40fbcdb1-c386-45b7-946f-7e4190dcc02c	evisa	\N	\N	56930d4c-beab-4e18-b16e-ac2cc2672c72	d29dcef8-e41b-4540-8f88-8849607ad3f340fbcdb1-c386-45b7-946f-7e4190dcc02c
847	d29dcef8-e41b-4540-8f88-8849607ad3f3	39658cd7-be12-4512-8a90-0b2cc9b2769d	evisa	\N	\N	1762a0c7-acd0-45e3-abb6-b340b89c31fb	d29dcef8-e41b-4540-8f88-8849607ad3f339658cd7-be12-4512-8a90-0b2cc9b2769d
848	fdf4338f-fd3a-446b-9688-b28515d38074	b33be079-39b7-4a1d-b689-97c224d5fece	visa required	\N	\N	457d5b74-b6f8-4303-b430-a803c83c0dd0	fdf4338f-fd3a-446b-9688-b28515d38074b33be079-39b7-4a1d-b689-97c224d5fece
849	fdf4338f-fd3a-446b-9688-b28515d38074	6c7e4e7d-9bf4-4e47-b2e4-c925f54bcd1a	visa not required	90 days	ID card valid	c0e60047-00bf-4fd5-974e-14d375b42641	fdf4338f-fd3a-446b-9688-b28515d380746c7e4e7d-9bf4-4e47-b2e4-c925f54bcd1a
850	fdf4338f-fd3a-446b-9688-b28515d38074	d9b8f8c8-5b5a-41ef-8538-26d822a4c9bd	visa required	\N	\N	5263ab0d-84bb-4fc4-878a-213dc61acbc6	fdf4338f-fd3a-446b-9688-b28515d38074d9b8f8c8-5b5a-41ef-8538-26d822a4c9bd
851	fdf4338f-fd3a-446b-9688-b28515d38074	1965c743-cf9a-4021-9ed1-b9e4e77486a2	visa not required	\N	ID card valid	eb8fa023-ba16-4b1e-92e0-cb9ff103b4c9	fdf4338f-fd3a-446b-9688-b28515d380741965c743-cf9a-4021-9ed1-b9e4e77486a2
852	fdf4338f-fd3a-446b-9688-b28515d38074	bf07965f-f874-453e-a725-54c5a1254ee8	evisa	30 days	Visitors who have been granted an online pre-visa or have requested such pre-visa from the consulates of Angola abroad, are then issued with a visa on arrival at the country's border check points. For a maximum total stay of 90 days within a one year period. Besides having printed confirmation that a visa will be issued upon arrival, passengers must: have a return/onward ticket, and have a hotel reservation confirmation.	6f116dab-f704-4880-95b8-50eafed5bede	fdf4338f-fd3a-446b-9688-b28515d38074bf07965f-f874-453e-a725-54c5a1254ee8
853	fdf4338f-fd3a-446b-9688-b28515d38074	90de1527-d5a5-446f-a960-eccda43af198	visa not required	3 mons	\N	721323d5-10c4-49bb-8c19-47774ef747f1	fdf4338f-fd3a-446b-9688-b28515d3807490de1527-d5a5-446f-a960-eccda43af198
854	fdf4338f-fd3a-446b-9688-b28515d38074	78219cc6-d1b2-4193-9da7-e7abc92863ee	visa not required	90 days	\N	c5164b5d-bb5c-479e-ab14-77af46f4ea3f	fdf4338f-fd3a-446b-9688-b28515d3807478219cc6-d1b2-4193-9da7-e7abc92863ee
855	fdf4338f-fd3a-446b-9688-b28515d38074	f2f3e704-bb03-467a-a1a0-1d56b6faadce	visa not required	180 days	\N	324e400e-2b16-4fcc-9437-d61bf89f57e5	fdf4338f-fd3a-446b-9688-b28515d38074f2f3e704-bb03-467a-a1a0-1d56b6faadce
856	fdf4338f-fd3a-446b-9688-b28515d38074	0a3e548d-7e30-426f-840c-07ff9b6772f7	evisitor	90 days	90 days on each visit in 12-month period if granted. The Romanian government officially considers that Australia maintains a visa regime towards its citizens since most are granted an eVisitor only manually after delays, and around 25% are denied. This claim was dismissed by the European Commission.	b706b813-d00e-480d-945a-7164be113e4f	fdf4338f-fd3a-446b-9688-b28515d380740a3e548d-7e30-426f-840c-07ff9b6772f7
857	fdf4338f-fd3a-446b-9688-b28515d38074	e14f7607-8074-4eeb-8b3f-3093575719a4	visa not required	\N	\N	6fbe1c0f-736a-49e1-acbb-e271c35a84e4	fdf4338f-fd3a-446b-9688-b28515d38074e14f7607-8074-4eeb-8b3f-3093575719a4
858	fdf4338f-fd3a-446b-9688-b28515d38074	319530a8-8cd2-4dc3-84a6-29ac720c51da	evisa	30 days	\N	3b25b650-52c2-4a7c-8630-b4cebef587ca	fdf4338f-fd3a-446b-9688-b28515d38074319530a8-8cd2-4dc3-84a6-29ac720c51da
859	fdf4338f-fd3a-446b-9688-b28515d38074	ac6434f1-bbb9-4242-a393-d78d367f034a	visa not required	3 mons	\N	23eeef89-7b4a-4920-b45c-e22485e0a43c	fdf4338f-fd3a-446b-9688-b28515d38074ac6434f1-bbb9-4242-a393-d78d367f034a
860	fdf4338f-fd3a-446b-9688-b28515d38074	497550d7-f9e9-4f1a-a5e0-8c9019c7bc31	visa on arrival	14 days	Online visa available.	bc24a413-c8c9-43b6-8a12-f0a4806ecad9	fdf4338f-fd3a-446b-9688-b28515d38074497550d7-f9e9-4f1a-a5e0-8c9019c7bc31
861	fdf4338f-fd3a-446b-9688-b28515d38074	bb3fa754-b35e-45ee-8d66-fb159c96d821	visa on arrival	30 days	\N	e2b4225c-4f02-4b65-aea6-2bc4493adf71	fdf4338f-fd3a-446b-9688-b28515d38074bb3fa754-b35e-45ee-8d66-fb159c96d821
862	fdf4338f-fd3a-446b-9688-b28515d38074	49494a5b-205f-4756-9145-2784c9269a99	visa not required	3 mons	\N	07b4b1b8-f43b-4b00-9c32-735c5f7784e8	fdf4338f-fd3a-446b-9688-b28515d3807449494a5b-205f-4756-9145-2784c9269a99
863	fdf4338f-fd3a-446b-9688-b28515d38074	ac612169-1567-4c5e-a203-3987fa26c267	visa not required	30 days	Must arrive and depart via Minsk International Airport.	281a25b1-bd7f-4895-9131-88553d7989e4	fdf4338f-fd3a-446b-9688-b28515d38074ac612169-1567-4c5e-a203-3987fa26c267
864	fdf4338f-fd3a-446b-9688-b28515d38074	1f4dd261-dc57-49ec-b872-8b1917703616	visa not required	\N	\N	cc22bceb-20a8-4798-9edf-3d87aab99995	fdf4338f-fd3a-446b-9688-b28515d380741f4dd261-dc57-49ec-b872-8b1917703616
865	fdf4338f-fd3a-446b-9688-b28515d38074	3e62d48d-717d-4421-91c2-abb059a80576	visa not required	1 mon	\N	139247d3-0c49-4503-9d48-55f15f905923	fdf4338f-fd3a-446b-9688-b28515d380743e62d48d-717d-4421-91c2-abb059a80576
866	fdf4338f-fd3a-446b-9688-b28515d38074	5fbebc32-e410-4faa-94e5-822252f8b499	visa on arrival	30 days	Must have an international vaccination certificate.	3bf6f430-7579-49fb-a134-dc267a6fb54c	fdf4338f-fd3a-446b-9688-b28515d380745fbebc32-e410-4faa-94e5-822252f8b499
867	fdf4338f-fd3a-446b-9688-b28515d38074	1d58bd18-8519-4e53-8cd1-6a7e93cda614	visa required	\N	\N	f669c17b-e603-423c-bbff-150cfabd9bc9	fdf4338f-fd3a-446b-9688-b28515d380741d58bd18-8519-4e53-8cd1-6a7e93cda614
868	fdf4338f-fd3a-446b-9688-b28515d38074	546440bf-236c-4f99-bd12-3bba52d50e02	visa on arrival	\N	\N	d54f41a6-075e-4696-a769-77abe26a4c00	fdf4338f-fd3a-446b-9688-b28515d38074546440bf-236c-4f99-bd12-3bba52d50e02
869	fdf4338f-fd3a-446b-9688-b28515d38074	c103dabb-a386-4a6a-bce5-c0c0fa5f43f6	visa not required	90 days	90 days within any 6-month period ID card valid	da344f31-51bb-48c8-bc8f-ca9abe742526	fdf4338f-fd3a-446b-9688-b28515d38074c103dabb-a386-4a6a-bce5-c0c0fa5f43f6
870	fdf4338f-fd3a-446b-9688-b28515d38074	ff4c5033-aee4-4325-90cc-1f96ef10bbce	visa not required	90 days	\N	af01fc65-609e-4e4b-9b0a-a71dc44b15a8	fdf4338f-fd3a-446b-9688-b28515d38074ff4c5033-aee4-4325-90cc-1f96ef10bbce
871	fdf4338f-fd3a-446b-9688-b28515d38074	1b558876-4f84-41fb-8215-93143842ba53	visa not required	90 days	90 days within any 180-day period	9e39831b-e99e-4160-95f8-99d344ae941c	fdf4338f-fd3a-446b-9688-b28515d380741b558876-4f84-41fb-8215-93143842ba53
872	fdf4338f-fd3a-446b-9688-b28515d38074	49ca53d4-0d59-4be8-9724-70b0eff911ce	visa not required	90 days	\N	9eaf5a16-a92d-45a1-ac92-9f33dea197ff	fdf4338f-fd3a-446b-9688-b28515d3807449ca53d4-0d59-4be8-9724-70b0eff911ce
873	fdf4338f-fd3a-446b-9688-b28515d38074	dde93861-da65-40d4-8159-3e67e8d58e02	visa not required	\N	\N	6b71c5e7-c72a-4f6a-99a1-20212ac39ccd	fdf4338f-fd3a-446b-9688-b28515d38074dde93861-da65-40d4-8159-3e67e8d58e02
874	fdf4338f-fd3a-446b-9688-b28515d38074	a22c7473-248e-4447-8bc7-1fc51c00ca3e	visa required	\N	\N	9baaae7a-f4e3-45fa-aaa5-ba549ec6d212	fdf4338f-fd3a-446b-9688-b28515d38074a22c7473-248e-4447-8bc7-1fc51c00ca3e
875	fdf4338f-fd3a-446b-9688-b28515d38074	4f0fe689-81e0-4b91-a093-cad33a305482	visa required	\N	\N	a7dfed4c-5910-48cb-9447-8c349ad18b55	fdf4338f-fd3a-446b-9688-b28515d380744f0fe689-81e0-4b91-a093-cad33a305482
876	fdf4338f-fd3a-446b-9688-b28515d38074	723de35c-616a-4b10-b479-c08378f3765b	visa on arrival	30 days	Online visa available.	d368b7ea-838b-426b-acf1-25f8426f7ce9	fdf4338f-fd3a-446b-9688-b28515d38074723de35c-616a-4b10-b479-c08378f3765b
877	fdf4338f-fd3a-446b-9688-b28515d38074	526f75ae-3c43-45a3-924e-1d7e11177a68	visa required	\N	\N	39f13253-5140-4749-b9ea-5c1b20455607	fdf4338f-fd3a-446b-9688-b28515d38074526f75ae-3c43-45a3-924e-1d7e11177a68
878	fdf4338f-fd3a-446b-9688-b28515d38074	e242cbe2-dc75-4807-a7c9-c171d164ec2d	visa not required	6 mons	eTA required if arriving by air. Electronic passport required for visa-free travel. Non-electronic passports only eligible for visa-free travel with an expired Canadian visitor visa or a valid United States non-immigrant visa, with an eTA issued before 1 December 2017.	5a841480-b2de-4e63-9a1a-919f0104d238	fdf4338f-fd3a-446b-9688-b28515d38074e242cbe2-dc75-4807-a7c9-c171d164ec2d
879	fdf4338f-fd3a-446b-9688-b28515d38074	3e77325d-7fea-46ad-a8fa-b2d31056b3ea	visa not required	30 days	Must register online at least five days prior to arrival.	d5326c47-cc90-4a8d-a43c-ef956584d799	fdf4338f-fd3a-446b-9688-b28515d380743e77325d-7fea-46ad-a8fa-b2d31056b3ea
880	fdf4338f-fd3a-446b-9688-b28515d38074	2b1aaccb-5846-45c1-8481-12bb8b5e0aa4	visa required	\N	\N	64d78cca-08a5-4fed-9097-4806aefa322c	fdf4338f-fd3a-446b-9688-b28515d380742b1aaccb-5846-45c1-8481-12bb8b5e0aa4
881	fdf4338f-fd3a-446b-9688-b28515d38074	3f759fc5-8287-4acb-b58d-f235c5ef4981	visa required	\N	\N	308c4882-5a4a-4c5c-8a9c-53e6d9b17c72	fdf4338f-fd3a-446b-9688-b28515d380743f759fc5-8287-4acb-b58d-f235c5ef4981
882	fdf4338f-fd3a-446b-9688-b28515d38074	c5a755fa-0935-4ec5-a880-3d4854beabfd	visa not required	90 days	\N	1fdf8e90-a36f-416f-982f-cbdc2187b525	fdf4338f-fd3a-446b-9688-b28515d38074c5a755fa-0935-4ec5-a880-3d4854beabfd
883	fdf4338f-fd3a-446b-9688-b28515d38074	7178da96-360e-4b0a-ada4-9640c498daf8	visa required	\N	24-hour visit without a visa when in transit through China (unless arriving in Fuzhou Changle International Airport, Huangshan Tunxi International Airport, Mudanjiang Hailang Airport, Shenzhen Bao'an International Airport and Yanji Chaoyangchuan Airport). 72-hour visit without a visa when in transit through Changsha, Guilin and Harbin. 144-hours visit without a visa when in transit through Beijing, Chengdu, Chongqing, Dalian, Guangzhou, Hangzhou, Jieyang, Kunming, Nanjing, Ningbo, Qinhuangdao, Qingdao, Shanghai, Shenyang, Shenzhen, Shijiazhuang, Tianjin, Wuhan, Xiamen and Xi'an. Hong Kong, Macau, and Taiwan do count as third countries under the 24, 72 and 144-hours visa-free transit (TWOV) policies. Visa not required for holders of normal Romanian passports endorsed “for public affairs”.	55dbf500-509d-42c0-99d0-889ccb65b314	fdf4338f-fd3a-446b-9688-b28515d380747178da96-360e-4b0a-ada4-9640c498daf8
884	fdf4338f-fd3a-446b-9688-b28515d38074	8b58bd46-c2d7-4df7-8871-378dbe921468	visa not required	180 days	90 days – extendable up to 180-days stay within a one-year period	03a661b6-b186-4bca-9533-0581a3b3c938	fdf4338f-fd3a-446b-9688-b28515d380748b58bd46-c2d7-4df7-8871-378dbe921468
885	fdf4338f-fd3a-446b-9688-b28515d38074	48847459-b1b2-4092-9bf0-f0c08b928c74	visa on arrival	\N	\N	e4bf8e66-317c-4804-b661-1b915ed57e2a	fdf4338f-fd3a-446b-9688-b28515d3807448847459-b1b2-4092-9bf0-f0c08b928c74
886	fdf4338f-fd3a-446b-9688-b28515d38074	196ed632-cc17-4b9f-87cb-cbc9832e8617	visa required	\N	\N	09e0258a-0a93-4358-bbb0-0fb4f24d1bc8	fdf4338f-fd3a-446b-9688-b28515d38074196ed632-cc17-4b9f-87cb-cbc9832e8617
887	fdf4338f-fd3a-446b-9688-b28515d38074	80b3fc54-1fa6-49c6-ac4c-998b002d754f	visa required	\N	\N	9cf56ea0-e435-4199-85af-03496c150965	fdf4338f-fd3a-446b-9688-b28515d3807480b3fc54-1fa6-49c6-ac4c-998b002d754f
888	fdf4338f-fd3a-446b-9688-b28515d38074	cf56f0da-daf4-4437-9ad9-4b61bbedc31a	visa not required	90 days	\N	601115df-639e-4f21-8ffc-8cc9daa7207c	fdf4338f-fd3a-446b-9688-b28515d38074cf56f0da-daf4-4437-9ad9-4b61bbedc31a
889	fdf4338f-fd3a-446b-9688-b28515d38074	31d93d6a-5130-4cfa-87ba-90d971d98d34	evisa	3 mons	eVisa holders must arrive via Port Bouet Airport.	7c6803f8-7823-4a83-9397-bcfb64890dbc	fdf4338f-fd3a-446b-9688-b28515d3807431d93d6a-5130-4cfa-87ba-90d971d98d34
890	fdf4338f-fd3a-446b-9688-b28515d38074	14730d5f-e0e5-43a8-bc67-ca9f92c8502a	visa not required	\N	\N	a7c77e3d-7ed4-4ffd-8aaa-c143388314f2	fdf4338f-fd3a-446b-9688-b28515d3807414730d5f-e0e5-43a8-bc67-ca9f92c8502a
891	fdf4338f-fd3a-446b-9688-b28515d38074	16a55dd1-2e47-489d-830c-3a88aad464a9	tourist card required	\N	\N	ef6a6a97-f37b-449e-9bb1-edfb968e5286	fdf4338f-fd3a-446b-9688-b28515d3807416a55dd1-2e47-489d-830c-3a88aad464a9
892	fdf4338f-fd3a-446b-9688-b28515d38074	f36ec987-ed66-4a88-9157-b1d4a934e515	visa not required	\N	\N	755ca20f-24e6-4c2a-a71c-66e4e20b5e25	fdf4338f-fd3a-446b-9688-b28515d38074f36ec987-ed66-4a88-9157-b1d4a934e515
893	fdf4338f-fd3a-446b-9688-b28515d38074	c5db5d6b-ebcd-4642-9604-0f1ebf2fdf9d	visa not required	\N	\N	0ab835d3-b175-4b30-bda2-d11ed75b67c6	fdf4338f-fd3a-446b-9688-b28515d38074c5db5d6b-ebcd-4642-9604-0f1ebf2fdf9d
894	fdf4338f-fd3a-446b-9688-b28515d38074	870d8300-9c56-4b34-9447-bcdfedf8454c	visa not required	\N	\N	c4002230-0b8d-4d53-9c88-a76fcfef41fd	fdf4338f-fd3a-446b-9688-b28515d38074870d8300-9c56-4b34-9447-bcdfedf8454c
895	fdf4338f-fd3a-446b-9688-b28515d38074	0b48c87c-ddaa-49d2-b736-61d9c44636e0	evisa	31 days	\N	61231c5e-73fb-4783-acd6-88109c51b7b1	fdf4338f-fd3a-446b-9688-b28515d380740b48c87c-ddaa-49d2-b736-61d9c44636e0
896	fdf4338f-fd3a-446b-9688-b28515d38074	a66c6aaf-f010-4056-8928-1653d670edf3	visa not required	90 days	90 days within any 180-day period	79cbfcae-6ace-4c13-91f8-3729548ffdb2	fdf4338f-fd3a-446b-9688-b28515d38074a66c6aaf-f010-4056-8928-1653d670edf3
897	fdf4338f-fd3a-446b-9688-b28515d38074	7caae20c-20fa-4ce0-a987-cca304a302b9	visa not required	90 days	\N	d2af827e-90ab-4fab-9f74-cae0f7f762b5	fdf4338f-fd3a-446b-9688-b28515d380747caae20c-20fa-4ce0-a987-cca304a302b9
898	fdf4338f-fd3a-446b-9688-b28515d38074	41fa1fc8-a7c9-4045-ac6a-92fe36c27bd9	visa not required	90 days	\N	44cca597-2fc2-412a-8120-cfa001be178f	fdf4338f-fd3a-446b-9688-b28515d3807441fa1fc8-a7c9-4045-ac6a-92fe36c27bd9
899	fdf4338f-fd3a-446b-9688-b28515d38074	0d0a18fd-d424-4a69-b646-38fffd942dd5	visa on arrival	30 days	\N	43cb8eaf-8bd5-4ba1-861b-640d0d11f8b7	fdf4338f-fd3a-446b-9688-b28515d380740d0a18fd-d424-4a69-b646-38fffd942dd5
900	fdf4338f-fd3a-446b-9688-b28515d38074	bae2df87-ee9b-4efe-8482-2b05b54ebb11	visa not required	3 mons	\N	9b63d7bd-f617-41d0-afa6-44baecb243e5	fdf4338f-fd3a-446b-9688-b28515d38074bae2df87-ee9b-4efe-8482-2b05b54ebb11
901	fdf4338f-fd3a-446b-9688-b28515d38074	43d35de8-4ed4-4bd7-9fce-54d9adcdeec6	visa required	\N	\N	6941cfc6-fa59-4e61-8fea-947ae2d6394a	fdf4338f-fd3a-446b-9688-b28515d3807443d35de8-4ed4-4bd7-9fce-54d9adcdeec6
902	fdf4338f-fd3a-446b-9688-b28515d38074	b2db2210-e9b8-4d51-b3c0-ed8e3d6adc9b	visa required	\N	\N	56132713-821e-423f-8d85-3d8e237e47d5	fdf4338f-fd3a-446b-9688-b28515d38074b2db2210-e9b8-4d51-b3c0-ed8e3d6adc9b
903	fdf4338f-fd3a-446b-9688-b28515d38074	061c7757-87bb-4acc-bfb5-ebb5a4dc9429	visa not required	\N	\N	f7177a96-11ec-48a2-9d31-20c5513de19d	fdf4338f-fd3a-446b-9688-b28515d38074061c7757-87bb-4acc-bfb5-ebb5a4dc9429
904	fdf4338f-fd3a-446b-9688-b28515d38074	646467f2-a7ee-4dc3-8589-902f948694cf	visa required	\N	\N	60e822b3-54a5-4afd-a814-78125bc163b3	fdf4338f-fd3a-446b-9688-b28515d38074646467f2-a7ee-4dc3-8589-902f948694cf
905	fdf4338f-fd3a-446b-9688-b28515d38074	f76a50d7-c955-4658-a2da-f191b746b434	evisa	90 days	eVisa holders must arrive via Addis Ababa Bole International Airport	259dad59-30f0-4d7f-994e-ec3e7adf271f	fdf4338f-fd3a-446b-9688-b28515d38074f76a50d7-c955-4658-a2da-f191b746b434
906	fdf4338f-fd3a-446b-9688-b28515d38074	923566be-1a81-4281-a9f5-fc3d8e59e53e	visa not required	4 mons	\N	9be6f5d1-d51a-4cc9-a080-f35d6b6667c7	fdf4338f-fd3a-446b-9688-b28515d38074923566be-1a81-4281-a9f5-fc3d8e59e53e
907	fdf4338f-fd3a-446b-9688-b28515d38074	d322fe64-203a-4eb4-8316-2c6c1af401a3	visa not required	\N	\N	60905e7f-8178-49cd-8f60-feb48504ef60	fdf4338f-fd3a-446b-9688-b28515d38074d322fe64-203a-4eb4-8316-2c6c1af401a3
908	fdf4338f-fd3a-446b-9688-b28515d38074	b7b802fe-8789-4b6d-b085-7c25a92dab7b	visa not required	\N	\N	a1b5ee01-c407-45cc-bc6f-cc72bec8119d	fdf4338f-fd3a-446b-9688-b28515d38074b7b802fe-8789-4b6d-b085-7c25a92dab7b
909	fdf4338f-fd3a-446b-9688-b28515d38074	6a95dca7-5bc9-438d-ba51-5cc4603d70a4	visa on arrival	90 days	Electronic visa holders must arrive via Libreville International Airport.	17c033a3-f531-4103-8e41-64583c615d3d	fdf4338f-fd3a-446b-9688-b28515d380746a95dca7-5bc9-438d-ba51-5cc4603d70a4
910	fdf4338f-fd3a-446b-9688-b28515d38074	81e9890e-9239-4c33-b429-66950b214814	visa not required	90 days	\N	1f0de1ef-8804-4c9c-b7cc-e21e3ad34ae3	fdf4338f-fd3a-446b-9688-b28515d3807481e9890e-9239-4c33-b429-66950b214814
911	fdf4338f-fd3a-446b-9688-b28515d38074	f2e17057-cb16-4fd3-92ef-07a6320c1818	visa not required	1 year	ID card valid	2ddaf4f7-0e84-4ee0-a5f2-14576b85abad	fdf4338f-fd3a-446b-9688-b28515d38074f2e17057-cb16-4fd3-92ef-07a6320c1818
912	fdf4338f-fd3a-446b-9688-b28515d38074	d80301ed-7cdc-4f2c-8093-cfec014b077a	visa not required	\N	\N	d6ff56f3-9595-4135-893b-0dc21cba2480	fdf4338f-fd3a-446b-9688-b28515d38074d80301ed-7cdc-4f2c-8093-cfec014b077a
913	fdf4338f-fd3a-446b-9688-b28515d38074	53618499-ed33-49f9-aeae-e24d02029f1e	visa required	\N	\N	08ef85fc-8217-43a8-a576-07bbf3d4194e	fdf4338f-fd3a-446b-9688-b28515d3807453618499-ed33-49f9-aeae-e24d02029f1e
914	fdf4338f-fd3a-446b-9688-b28515d38074	1a76eb8a-5fca-4552-a0dd-9728217998b0	visa not required	\N	\N	0c68eb95-b51f-4cd1-aa02-b8f24aa627d2	fdf4338f-fd3a-446b-9688-b28515d380741a76eb8a-5fca-4552-a0dd-9728217998b0
915	fdf4338f-fd3a-446b-9688-b28515d38074	aedfe3b8-fc01-41f8-a152-516e139dc8b6	visa not required	3 mons	\N	5e027a46-fcc6-4a60-83a0-332a1804f2d9	fdf4338f-fd3a-446b-9688-b28515d38074aedfe3b8-fc01-41f8-a152-516e139dc8b6
916	fdf4338f-fd3a-446b-9688-b28515d38074	0e291c7e-51a2-466f-94b9-de8d9dec9dd2	visa not required	90 days	\N	814811b2-818d-4d42-8677-bef8abf6decb	fdf4338f-fd3a-446b-9688-b28515d380740e291c7e-51a2-466f-94b9-de8d9dec9dd2
917	fdf4338f-fd3a-446b-9688-b28515d38074	b3e98c98-8a15-45bf-8f86-f26f6a07a425	evisa	90 days	\N	db26f2e8-d344-454d-b38b-b8245bdf6392	fdf4338f-fd3a-446b-9688-b28515d38074b3e98c98-8a15-45bf-8f86-f26f6a07a425
918	fdf4338f-fd3a-446b-9688-b28515d38074	98fd5d7d-6f4c-434d-bd97-6fabe502db00	visa on arrival	90 days	\N	9c031c7a-1b20-49fd-a59d-f4884b45825b	fdf4338f-fd3a-446b-9688-b28515d3807498fd5d7d-6f4c-434d-bd97-6fabe502db00
919	fdf4338f-fd3a-446b-9688-b28515d38074	f11d746c-8b82-4fe1-acb0-788067f0071c	visa required	\N	\N	0ac2d326-e47d-4419-84c6-57bc9798540c	fdf4338f-fd3a-446b-9688-b28515d38074f11d746c-8b82-4fe1-acb0-788067f0071c
920	fdf4338f-fd3a-446b-9688-b28515d38074	99530f46-46c4-4263-bd88-dca23dc0383f	visa not required	90 days	\N	6555028e-d5e2-47b3-b436-11d7b8632c46	fdf4338f-fd3a-446b-9688-b28515d3807499530f46-46c4-4263-bd88-dca23dc0383f
921	fdf4338f-fd3a-446b-9688-b28515d38074	3e33cfe7-603b-4d88-a6e3-f4dcc331d9f2	visa not required	3 mons	\N	01f99272-114b-4691-a29b-11b64bc3aeb0	fdf4338f-fd3a-446b-9688-b28515d380743e33cfe7-603b-4d88-a6e3-f4dcc331d9f2
922	fdf4338f-fd3a-446b-9688-b28515d38074	8287bea9-2349-46e4-9ac0-fb1e799497af	visa not required	\N	\N	2ddbc987-345c-4de6-9654-4e81543b7cc9	fdf4338f-fd3a-446b-9688-b28515d380748287bea9-2349-46e4-9ac0-fb1e799497af
923	fdf4338f-fd3a-446b-9688-b28515d38074	68563b3e-8866-4310-bdce-659b3cc9c2ac	visa not required	\N	\N	c362c1f6-c680-4004-90e0-d327d32c47ff	fdf4338f-fd3a-446b-9688-b28515d3807468563b3e-8866-4310-bdce-659b3cc9c2ac
924	fdf4338f-fd3a-446b-9688-b28515d38074	83f3b190-021f-4694-a033-57058c22cbf4	evisa	60 days	e-Visa holders must arrive via 26 designated airports or 3 designated seaports. An Indian e-Tourist Visa can only be obtained twice in one calendar year.	7dffcda8-7f86-4608-855a-78de08754841	fdf4338f-fd3a-446b-9688-b28515d3807483f3b190-021f-4694-a033-57058c22cbf4
925	fdf4338f-fd3a-446b-9688-b28515d38074	a3122035-5d20-411c-a94d-17360ed55678	visa not required	30 days	\N	4b0226a9-cf0d-41b5-9438-20c37e3f186c	fdf4338f-fd3a-446b-9688-b28515d38074a3122035-5d20-411c-a94d-17360ed55678
926	fdf4338f-fd3a-446b-9688-b28515d38074	1baa5d83-2707-4a0d-8f86-45efc106dffd	visa on arrival	30 days	\N	179e0e91-ea76-4019-8ed9-9c82ae2e3186	fdf4338f-fd3a-446b-9688-b28515d380741baa5d83-2707-4a0d-8f86-45efc106dffd
927	fdf4338f-fd3a-446b-9688-b28515d38074	e130f15d-7a37-4ddf-a6b5-e9c1266e128a	visa required	\N	\N	b83b43aa-b4e6-4781-8e71-67568070fc2f	fdf4338f-fd3a-446b-9688-b28515d38074e130f15d-7a37-4ddf-a6b5-e9c1266e128a
928	fdf4338f-fd3a-446b-9688-b28515d38074	48d25a4f-6bcb-4595-bf82-1492334695ec	visa not required	\N	\N	b741c79d-2773-44ed-bbe8-2a6d32b31e3e	fdf4338f-fd3a-446b-9688-b28515d3807448d25a4f-6bcb-4595-bf82-1492334695ec
929	fdf4338f-fd3a-446b-9688-b28515d38074	fc3338b4-47f1-4342-8def-3acabc77a994	visa not required	3 mons	\N	f117cdc3-f0fd-4f7f-b2f0-c11be8fa7033	fdf4338f-fd3a-446b-9688-b28515d38074fc3338b4-47f1-4342-8def-3acabc77a994
930	fdf4338f-fd3a-446b-9688-b28515d38074	161a32a0-755e-430b-86dc-8f153f7de9b1	visa not required	\N	\N	04fc91bd-e2a8-4fb5-80a1-8d0242250e1c	fdf4338f-fd3a-446b-9688-b28515d38074161a32a0-755e-430b-86dc-8f153f7de9b1
931	fdf4338f-fd3a-446b-9688-b28515d38074	96abeca6-c08e-4df8-b22f-2fefc55a8d5b	visa on arrival	\N	\N	135e0feb-a673-45ee-b0ad-e0f8f369d901	fdf4338f-fd3a-446b-9688-b28515d3807496abeca6-c08e-4df8-b22f-2fefc55a8d5b
932	fdf4338f-fd3a-446b-9688-b28515d38074	8e5a125d-73cb-45c1-a511-f0c65d7448e7	visa not required	90 days	\N	b9f7ba0c-160b-40f6-9113-7d01393a6ab9	fdf4338f-fd3a-446b-9688-b28515d380748e5a125d-73cb-45c1-a511-f0c65d7448e7
933	fdf4338f-fd3a-446b-9688-b28515d38074	c728bbe4-373f-4d0a-9a3f-985679759733	free visa on arrival	\N	Conditions apply	fd31d767-0ec1-4983-b202-42c73993c61f	fdf4338f-fd3a-446b-9688-b28515d38074c728bbe4-373f-4d0a-9a3f-985679759733
934	fdf4338f-fd3a-446b-9688-b28515d38074	c6a8ea7c-3fed-4a1d-9929-5569db7ab968	visa not required	30 days	\N	7a800584-feec-492c-8dd8-9cfadb7274d6	fdf4338f-fd3a-446b-9688-b28515d38074c6a8ea7c-3fed-4a1d-9929-5569db7ab968
935	fdf4338f-fd3a-446b-9688-b28515d38074	e91cae72-f62c-407e-b388-3f3b86f7a0c3	visa on arrival	3 mons	\N	a96cf5b2-2091-4cd8-a98c-c56ab22f244c	fdf4338f-fd3a-446b-9688-b28515d38074e91cae72-f62c-407e-b388-3f3b86f7a0c3
936	fdf4338f-fd3a-446b-9688-b28515d38074	8275007a-70b9-4a04-bcfa-1c23825d4874	visa not required	90 days	90 days within any 180-day period	df2d4607-5fb1-4f13-97f1-f0142e9cbdcc	fdf4338f-fd3a-446b-9688-b28515d380748275007a-70b9-4a04-bcfa-1c23825d4874
937	fdf4338f-fd3a-446b-9688-b28515d38074	9ad23145-f384-4a8f-a075-4648d1837d46	visa required	\N	\N	357603e2-08cd-413b-b3cf-e2fe7f6ac97c	fdf4338f-fd3a-446b-9688-b28515d380749ad23145-f384-4a8f-a075-4648d1837d46
938	fdf4338f-fd3a-446b-9688-b28515d38074	52dc85c7-9f30-470a-9de9-09b95bc11e86	visa not required	90 days	\N	1da9d9eb-533a-492c-8f1e-6efa07369046	fdf4338f-fd3a-446b-9688-b28515d3807452dc85c7-9f30-470a-9de9-09b95bc11e86
939	fdf4338f-fd3a-446b-9688-b28515d38074	ab2a946c-f1e3-43f5-bbfd-4b54adae333a	visa on arrival	3 mons	Online visa available (eVisa).	35793d41-089f-49f0-a7ba-2bd3d850f339	fdf4338f-fd3a-446b-9688-b28515d38074ab2a946c-f1e3-43f5-bbfd-4b54adae333a
940	fdf4338f-fd3a-446b-9688-b28515d38074	6cec735b-3406-430f-be56-71d96ff8f41e	visa on arrival	1 mon	Electronic visa holders must arrive via Manas International Airport or Osh Airport or through land crossings with China (at Irkeshtam and Torugart), Kazakhstan (at Ak-jol, Ak-Tilek, Chaldybar, Chon-Kapka), Tajikistan (at Bor-Dobo, Kulundu, Kyzyl-Bel) and Uzbekistan (at Dostuk). Visa on arrival available at Manas International Airport.	ba5ebb0e-1593-47b3-a057-02028ee3f9eb	fdf4338f-fd3a-446b-9688-b28515d380746cec735b-3406-430f-be56-71d96ff8f41e
941	fdf4338f-fd3a-446b-9688-b28515d38074	34e549be-e921-419a-a64d-2349902ee1e8	visa on arrival	30 days	Visa on arrival is available at international airports Luangphabang, Pakse, Savannakhet and Vientiane, and at 4 land borders Friendship Bridge, and at 13 border crossings as well as Tanalaeng train station in Vientiane, which connects to the train station in Nongkai, Thailand. Visa on arrival facility will be gradually phased out at various border crossings starting January 2020. eVisa may be used to enter Laos through the following entry points — Wattay International Airport and the First Thai–Lao Friendship Bridge Entry points Lalai, Lantui, Meuang mom, Pakxan, and Phoudou are open only to visa holders. Visa on arrival is extendable up to 60 days.	f1f95037-3b90-4e95-90c9-af7e2f26cfdf	fdf4338f-fd3a-446b-9688-b28515d3807434e549be-e921-419a-a64d-2349902ee1e8
942	fdf4338f-fd3a-446b-9688-b28515d38074	85b0fd58-f24b-4249-a31c-46e40023744c	visa not required	\N	\N	5c111f7e-2a5f-4e9c-beda-e78d184768a4	fdf4338f-fd3a-446b-9688-b28515d3807485b0fd58-f24b-4249-a31c-46e40023744c
943	fdf4338f-fd3a-446b-9688-b28515d38074	6a6a8869-35f4-4d7f-af9f-c881d3b4bc19	visa on arrival	1 mon	Extendable for 2 additional months Granted free of charge at Beirut International Airport or any other port of entry if there is no Israeli visa or seal, holding a telephone number, an address in Lebanon, and a non-refundable return or circle trip ticket.	03108f4c-1d03-485c-834d-cfc33ac930b6	fdf4338f-fd3a-446b-9688-b28515d380746a6a8869-35f4-4d7f-af9f-c881d3b4bc19
944	fdf4338f-fd3a-446b-9688-b28515d38074	f7ca89ef-b000-416a-b9f4-6059b2d8a3ca	evisa	\N	\N	5f9ea359-03eb-49cd-8c95-1ac42c6b037f	fdf4338f-fd3a-446b-9688-b28515d38074f7ca89ef-b000-416a-b9f4-6059b2d8a3ca
945	fdf4338f-fd3a-446b-9688-b28515d38074	e3c9a7c1-e5ec-46aa-be24-13a63b23c24a	visa required	\N	\N	b3838daf-ff4a-4792-a33c-637a3317c0db	fdf4338f-fd3a-446b-9688-b28515d38074e3c9a7c1-e5ec-46aa-be24-13a63b23c24a
946	fdf4338f-fd3a-446b-9688-b28515d38074	a9bc64d6-1f2e-4882-90bc-4930614667da	visa required	\N	\N	11bd00fb-2228-4b81-aa31-6baca91c00b7	fdf4338f-fd3a-446b-9688-b28515d38074a9bc64d6-1f2e-4882-90bc-4930614667da
947	fdf4338f-fd3a-446b-9688-b28515d38074	8510166b-62a4-475f-8afe-891fe1cb22a0	visa not required	\N	\N	a3144202-e753-426e-bf0f-f6125d8a643d	fdf4338f-fd3a-446b-9688-b28515d380748510166b-62a4-475f-8afe-891fe1cb22a0
948	fdf4338f-fd3a-446b-9688-b28515d38074	d4d24a30-2184-4fd3-8315-248ddc094526	visa not required	\N	\N	ffdb2ffc-c3e1-4021-a8d4-3e6ffeac0f9a	fdf4338f-fd3a-446b-9688-b28515d38074d4d24a30-2184-4fd3-8315-248ddc094526
949	fdf4338f-fd3a-446b-9688-b28515d38074	a94b35b0-c269-4e9f-9d66-80d8f3081989	visa not required	\N	\N	21268d77-3b33-4383-86f9-a7b13d332f9a	fdf4338f-fd3a-446b-9688-b28515d38074a94b35b0-c269-4e9f-9d66-80d8f3081989
950	fdf4338f-fd3a-446b-9688-b28515d38074	b7206cc1-2cca-454d-9447-3788640f7b5e	visa on arrival	90 days	\N	096d0a38-5e76-4efd-9497-7f1df779cc89	fdf4338f-fd3a-446b-9688-b28515d38074b7206cc1-2cca-454d-9447-3788640f7b5e
951	fdf4338f-fd3a-446b-9688-b28515d38074	413fe813-55c0-49e9-8853-47654b4ae73b	visa on arrival	90 days	\N	7ef06c30-e82f-4817-be4d-3dc8707b60c9	fdf4338f-fd3a-446b-9688-b28515d38074413fe813-55c0-49e9-8853-47654b4ae73b
952	fdf4338f-fd3a-446b-9688-b28515d38074	d42ac9fd-1e10-4995-8dc1-4d25cee7a022	visa not required	90 days	\N	451cca96-ec1f-4418-bb2e-39b6bb9b9ca8	fdf4338f-fd3a-446b-9688-b28515d38074d42ac9fd-1e10-4995-8dc1-4d25cee7a022
953	fdf4338f-fd3a-446b-9688-b28515d38074	2b8d132e-e3b8-4a97-aa78-a265bf65836d	visa on arrival	30 days	\N	63770118-9010-4f9f-92d5-38ab2b5de3c8	fdf4338f-fd3a-446b-9688-b28515d380742b8d132e-e3b8-4a97-aa78-a265bf65836d
954	fdf4338f-fd3a-446b-9688-b28515d38074	a8c0bf67-69a5-4293-8282-622c6b61962c	visa required	\N	\N	f5c2153d-783b-43e2-ae34-16927639c473	fdf4338f-fd3a-446b-9688-b28515d38074a8c0bf67-69a5-4293-8282-622c6b61962c
955	fdf4338f-fd3a-446b-9688-b28515d38074	ca8f94ef-b748-47c8-b040-b996e3cf2581	visa not required	\N	\N	be9c7a34-8d37-45d1-a669-d29899272360	fdf4338f-fd3a-446b-9688-b28515d38074ca8f94ef-b748-47c8-b040-b996e3cf2581
956	fdf4338f-fd3a-446b-9688-b28515d38074	27f40e7e-ab08-4e44-b643-f9546021f2c2	visa not required	90 days	90 days within any 180-day period	fe0a6594-66b3-40f7-94bc-489632301582	fdf4338f-fd3a-446b-9688-b28515d3807427f40e7e-ab08-4e44-b643-f9546021f2c2
957	fdf4338f-fd3a-446b-9688-b28515d38074	a4d1f62b-6131-44de-92fe-975d0a463bc7	visa on arrival	\N	Available at Nouakchott–Oumtounsy International Airport.	b8e2787e-5af5-4156-b45f-1e747493e7d7	fdf4338f-fd3a-446b-9688-b28515d38074a4d1f62b-6131-44de-92fe-975d0a463bc7
958	fdf4338f-fd3a-446b-9688-b28515d38074	59a60488-bbd7-476a-813e-a92fa901e8e7	visa not required	90 days	\N	7edd7ea3-ae75-4f8f-afdc-2ba92150d668	fdf4338f-fd3a-446b-9688-b28515d3807459a60488-bbd7-476a-813e-a92fa901e8e7
959	fdf4338f-fd3a-446b-9688-b28515d38074	846ec109-79bc-4e46-a303-40e20bcb2f36	visa not required	180 days	\N	10eebbd5-79f6-400c-b644-a7b0715b8313	fdf4338f-fd3a-446b-9688-b28515d38074846ec109-79bc-4e46-a303-40e20bcb2f36
960	fdf4338f-fd3a-446b-9688-b28515d38074	0343465d-616b-4419-b3ac-6e358776cb2e	visa not required	90 days	90 days within any 180-day period	e34298f3-5190-4c2f-80d2-c7fe2d57ce32	fdf4338f-fd3a-446b-9688-b28515d380740343465d-616b-4419-b3ac-6e358776cb2e
961	fdf4338f-fd3a-446b-9688-b28515d38074	6f37afd2-3170-4c9d-8fde-28d6a44eda0d	visa not required	90 days	90 days within any 180-day period ID card valid	7fc7df6f-728f-4d27-ac0b-2cccd56ad65d	fdf4338f-fd3a-446b-9688-b28515d380746f37afd2-3170-4c9d-8fde-28d6a44eda0d
962	fdf4338f-fd3a-446b-9688-b28515d38074	e1b6cef2-9a2d-441a-96db-2cb815ac9398	visa not required	\N	ID card valid	9f5ac841-268e-40ef-aae9-b5ebaa989574	fdf4338f-fd3a-446b-9688-b28515d38074e1b6cef2-9a2d-441a-96db-2cb815ac9398
963	fdf4338f-fd3a-446b-9688-b28515d38074	b60fe946-71ac-40be-97dc-8ee0b78c3384	visa on arrival	30 days	Tourists who are coming from European countries where there is no Mongolian diplomatic presence are eligible to acquire on-arrival visa at the airport in Ulaanbaatar or Mongolian border points.	5c4e386d-7b7b-4b32-8b26-d52b69cafe1f	fdf4338f-fd3a-446b-9688-b28515d38074b60fe946-71ac-40be-97dc-8ee0b78c3384
964	fdf4338f-fd3a-446b-9688-b28515d38074	6702177a-fbed-4cf3-aa32-22da244beab0	visa not required	90 days	ID card valid for 30 days	f6c26e4f-da5a-4b5d-a46a-a9a8d143dded	fdf4338f-fd3a-446b-9688-b28515d380746702177a-fbed-4cf3-aa32-22da244beab0
965	fdf4338f-fd3a-446b-9688-b28515d38074	a7462d3b-b094-454a-a09c-08573a566463	visa not required	3 mons	\N	c6b940f3-b358-43dc-8c68-f722bbef4423	fdf4338f-fd3a-446b-9688-b28515d38074a7462d3b-b094-454a-a09c-08573a566463
966	fdf4338f-fd3a-446b-9688-b28515d38074	95251d34-e411-4cb7-9112-0a1f95b239e0	visa on arrival	30 days	\N	dfbb8684-6fe3-40d2-85ae-763f2d8d31f5	fdf4338f-fd3a-446b-9688-b28515d3807495251d34-e411-4cb7-9112-0a1f95b239e0
967	fdf4338f-fd3a-446b-9688-b28515d38074	ac8b13ec-0d98-4fad-852e-a351d68e6a16	evisa	28 days	eVisa holders must arrive via Yangon, Nay Pyi Taw or Mandalay airports or via land border crossings with Thailand — Tachileik, Myawaddy and Kawthaung or India — Rih Khaw Dar and Tamu. eVisa available for both tourism (allowed stay is 28 days) or business (allowed stay is 70 days) purposes.	6d9a51d3-da9b-47da-93ff-f0420c4660f9	fdf4338f-fd3a-446b-9688-b28515d38074ac8b13ec-0d98-4fad-852e-a351d68e6a16
968	fdf4338f-fd3a-446b-9688-b28515d38074	dff0e275-70f0-4d4b-9d4a-3b4029ab3cd1	visa on arrival	3 mons	Available at Hosea Kutako International Airport.	01742feb-7a1f-4bd1-9751-0881ce7e69b1	fdf4338f-fd3a-446b-9688-b28515d38074dff0e275-70f0-4d4b-9d4a-3b4029ab3cd1
969	fdf4338f-fd3a-446b-9688-b28515d38074	c00f0e5e-a315-4118-b879-8d0a07faa486	visa required	\N	\N	499fb9b8-b671-43af-9a57-b24d4a100b5f	fdf4338f-fd3a-446b-9688-b28515d38074c00f0e5e-a315-4118-b879-8d0a07faa486
970	fdf4338f-fd3a-446b-9688-b28515d38074	52a86412-42e6-499e-a742-a0902ca649b5	visa on arrival	90 days	\N	59aaa35d-a7b9-470e-ba3a-d7369e3d93bc	fdf4338f-fd3a-446b-9688-b28515d3807452a86412-42e6-499e-a742-a0902ca649b5
971	fdf4338f-fd3a-446b-9688-b28515d38074	649e4cd5-204a-41ae-add6-5c7433d23973	visa not required	\N	\N	6b27f75d-8dee-414f-a200-9e99815bb5a0	fdf4338f-fd3a-446b-9688-b28515d38074649e4cd5-204a-41ae-add6-5c7433d23973
972	fdf4338f-fd3a-446b-9688-b28515d38074	903625d0-0df4-4537-8370-4c3cda4ffed6	electronic travel authority	90 days	International Visitor Conservation and Tourism Levy must be acquired alongside Electronic Travel Authority.	3d3373fa-1307-4d53-8d34-5f96021fb5fe	fdf4338f-fd3a-446b-9688-b28515d38074903625d0-0df4-4537-8370-4c3cda4ffed6
973	fdf4338f-fd3a-446b-9688-b28515d38074	390d0b06-0892-405b-93f4-8b1b69af9667	visa not required	90 days	\N	ff2dd570-13d5-44fb-91e3-6bb4c0bba647	fdf4338f-fd3a-446b-9688-b28515d38074390d0b06-0892-405b-93f4-8b1b69af9667
974	fdf4338f-fd3a-446b-9688-b28515d38074	363bc536-025f-4ef7-95c0-a083bb8f37e6	visa required	\N	\N	cc8f7d0f-14f7-4926-bd72-36b5cc9ba9de	fdf4338f-fd3a-446b-9688-b28515d38074363bc536-025f-4ef7-95c0-a083bb8f37e6
975	fdf4338f-fd3a-446b-9688-b28515d38074	7ce306aa-4c86-4016-93ab-cf3f5c22c621	visa required	\N	\N	e27b6c0a-8cad-44ef-9edf-1bb41d1ce86f	fdf4338f-fd3a-446b-9688-b28515d380747ce306aa-4c86-4016-93ab-cf3f5c22c621
976	fdf4338f-fd3a-446b-9688-b28515d38074	6b9ca8c2-1096-496b-9aa2-0a0dc3fb4f32	visa not required	90 days	ID card valid	6160456b-cefb-4ed8-b9af-d1749929c753	fdf4338f-fd3a-446b-9688-b28515d380746b9ca8c2-1096-496b-9aa2-0a0dc3fb4f32
977	fdf4338f-fd3a-446b-9688-b28515d38074	4f50cb61-60cb-48f5-9c7a-974d9c3840d5	visa not required	\N	\N	a9b12604-766f-4420-8d2d-a9a709c4dcfb	fdf4338f-fd3a-446b-9688-b28515d380744f50cb61-60cb-48f5-9c7a-974d9c3840d5
978	fdf4338f-fd3a-446b-9688-b28515d38074	7a1e411c-5e2b-4ef6-9561-73a4466af643	evisa	30 days	\N	1251773c-d118-405c-8a4e-6b866f3b8fff	fdf4338f-fd3a-446b-9688-b28515d380747a1e411c-5e2b-4ef6-9561-73a4466af643
979	fdf4338f-fd3a-446b-9688-b28515d38074	abc45575-6e5a-49c5-9967-e067a503c8a6	online visa	\N	Online Visa eligible. Electronic Travel Authorization to acquire a visa on arrival for business purposes.	23347e45-f42f-49cd-97ba-dfea22f4b9ba	fdf4338f-fd3a-446b-9688-b28515d38074abc45575-6e5a-49c5-9967-e067a503c8a6
980	fdf4338f-fd3a-446b-9688-b28515d38074	43e7d908-36ff-47b2-813c-146e89e91aef	visa not required	90 days	90 days within any 180-day period	384a7a7a-093a-471e-9b54-1b5b586f5bc1	fdf4338f-fd3a-446b-9688-b28515d3807443e7d908-36ff-47b2-813c-146e89e91aef
981	fdf4338f-fd3a-446b-9688-b28515d38074	e32cd55b-2b25-444e-beb4-f86a6e81819b	visa not required	180 days	\N	c145ad55-e172-4c0e-9500-592ffb498a95	fdf4338f-fd3a-446b-9688-b28515d38074e32cd55b-2b25-444e-beb4-f86a6e81819b
982	fdf4338f-fd3a-446b-9688-b28515d38074	2f5d487b-20b7-47c4-b8fe-378d3c40839a	free visa on arrival	60 days	\N	9928420f-534d-4cb6-84aa-6d26111ffebe	fdf4338f-fd3a-446b-9688-b28515d380742f5d487b-20b7-47c4-b8fe-378d3c40839a
983	fdf4338f-fd3a-446b-9688-b28515d38074	5091a6a9-aa19-4e48-890a-d0d3ccce88c7	visa not required	90 days	\N	e4604541-30b8-4b51-b52c-f4b95865a4e8	fdf4338f-fd3a-446b-9688-b28515d380745091a6a9-aa19-4e48-890a-d0d3ccce88c7
984	fdf4338f-fd3a-446b-9688-b28515d38074	6fd50499-8698-4764-a9ea-d063e211ae85	visa not required	90 days	90 days within any 6-month period	2d84b8ba-deee-47b9-ae6f-cec047fab674	fdf4338f-fd3a-446b-9688-b28515d380746fd50499-8698-4764-a9ea-d063e211ae85
985	fdf4338f-fd3a-446b-9688-b28515d38074	d29dcef8-e41b-4540-8f88-8849607ad3f3	visa not required	30 days	\N	6dff23ff-8174-4c10-9704-e3f06d389efd	fdf4338f-fd3a-446b-9688-b28515d38074d29dcef8-e41b-4540-8f88-8849607ad3f3
986	fdf4338f-fd3a-446b-9688-b28515d38074	9a7ad7e0-1e36-4004-9879-568b56d0cf87	visa not required	\N	\N	0f8db5f3-c64e-4712-8dc5-54fcac04de93	fdf4338f-fd3a-446b-9688-b28515d380749a7ad7e0-1e36-4004-9879-568b56d0cf87
987	fdf4338f-fd3a-446b-9688-b28515d38074	c2f84d45-aa39-4df1-8a87-e4dd0c5b34a1	visa not required	\N	\N	a188a27a-2480-42f0-a2ba-49ad9c6d3627	fdf4338f-fd3a-446b-9688-b28515d38074c2f84d45-aa39-4df1-8a87-e4dd0c5b34a1
988	fdf4338f-fd3a-446b-9688-b28515d38074	90a93353-4714-42fc-8632-09f25bc1312a	visa not required	90 days	\N	f8fa751a-7614-4417-b511-599fa8560bfc	fdf4338f-fd3a-446b-9688-b28515d3807490a93353-4714-42fc-8632-09f25bc1312a
989	fdf4338f-fd3a-446b-9688-b28515d38074	ae5dee3a-1222-4f42-9f97-470ab88b3b7e	visa required	\N	From 1 July 2019, Romanian citizens are eligible for E-visa access to Kaliningrad oblast for 8 days.	d10de0c9-abc2-432a-a21a-e80247c9b6da	fdf4338f-fd3a-446b-9688-b28515d38074ae5dee3a-1222-4f42-9f97-470ab88b3b7e
990	fdf4338f-fd3a-446b-9688-b28515d38074	418d8911-a62b-4686-bf0e-f18b204398d8	visa on arrival	30 days	\N	75985ee7-286e-45b6-af1c-6ce7fa8d10a8	fdf4338f-fd3a-446b-9688-b28515d38074418d8911-a62b-4686-bf0e-f18b204398d8
991	fdf4338f-fd3a-446b-9688-b28515d38074	ec506881-6436-49fc-b56e-42da02dd7d5b	visa not required	3 mons	\N	1e92d082-31f0-4b93-997a-aa344574fa32	fdf4338f-fd3a-446b-9688-b28515d38074ec506881-6436-49fc-b56e-42da02dd7d5b
992	fdf4338f-fd3a-446b-9688-b28515d38074	e3b26362-6759-4612-8863-4785505a679e	visa not required	90 days	90 days within any 180-day period	f3359f51-f800-422b-9a52-07c78c2b3bf8	fdf4338f-fd3a-446b-9688-b28515d38074e3b26362-6759-4612-8863-4785505a679e
993	fdf4338f-fd3a-446b-9688-b28515d38074	54824162-df76-4f5e-8783-404687f907f1	visa not required	90 days	90 days within any 180-day period	677474ba-388a-4e2c-a244-75af213e2a8c	fdf4338f-fd3a-446b-9688-b28515d3807454824162-df76-4f5e-8783-404687f907f1
994	fdf4338f-fd3a-446b-9688-b28515d38074	7d76fbc2-43bb-467f-b36b-1b899f3d013a	visa not required	90 days	90 days within any 180-day period	7b3ac0e2-9002-456d-a5cc-32ea168335af	fdf4338f-fd3a-446b-9688-b28515d380747d76fbc2-43bb-467f-b36b-1b899f3d013a
995	fdf4338f-fd3a-446b-9688-b28515d38074	1bc1c6a9-2028-4dcd-94bf-6d19bea049e6	visa not required	\N	ID card valid	fb4c54a0-6b28-4900-b4cb-0b36e5b23698	fdf4338f-fd3a-446b-9688-b28515d380741bc1c6a9-2028-4dcd-94bf-6d19bea049e6
996	fdf4338f-fd3a-446b-9688-b28515d38074	ab4bc3a4-7c19-4a94-905c-a7973e0feaff	visa not required	15 days	\N	0f83c64e-c824-4fbe-a479-c00bd501a03d	fdf4338f-fd3a-446b-9688-b28515d38074ab4bc3a4-7c19-4a94-905c-a7973e0feaff
997	fdf4338f-fd3a-446b-9688-b28515d38074	dfffd0b6-a252-421b-94cb-6d44695c5c8c	visa on arrival	90 days	\N	dd8f4495-02bb-4830-bf69-8759c2dca067	fdf4338f-fd3a-446b-9688-b28515d38074dfffd0b6-a252-421b-94cb-6d44695c5c8c
998	fdf4338f-fd3a-446b-9688-b28515d38074	e98795b2-4086-41b5-bac1-4789d9aee005	visa not required	90 days	\N	b825c057-f043-4db5-a428-88457ea472cb	fdf4338f-fd3a-446b-9688-b28515d38074e98795b2-4086-41b5-bac1-4789d9aee005
999	fdf4338f-fd3a-446b-9688-b28515d38074	aae2ba87-a67d-43bd-8516-e403843d61d9	visa not required	90 days	90 days within any 6-month period ID card valid	5a44bf7a-568f-48d8-b74d-7b96a4fcd831	fdf4338f-fd3a-446b-9688-b28515d38074aae2ba87-a67d-43bd-8516-e403843d61d9
1000	fdf4338f-fd3a-446b-9688-b28515d38074	4998e162-96ca-4381-ab19-3dc43922884a	visa not required	3 mons	\N	98b37533-a670-4eb3-a731-26f73c2e084b	fdf4338f-fd3a-446b-9688-b28515d380744998e162-96ca-4381-ab19-3dc43922884a
1001	fdf4338f-fd3a-446b-9688-b28515d38074	d8df4bc3-503b-41ca-987e-423e41ecb52c	visa on arrival	\N	\N	3f6e4fcc-bac2-49dd-9637-9b60700ad2ee	fdf4338f-fd3a-446b-9688-b28515d38074d8df4bc3-503b-41ca-987e-423e41ecb52c
1002	fdf4338f-fd3a-446b-9688-b28515d38074	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	visa not required	90 days	\N	ba49c671-8a8c-46eb-ae94-d8fb066ecbd4	fdf4338f-fd3a-446b-9688-b28515d380746e83ec38-7e2d-4c2d-8a9d-6991d4e876db
1003	fdf4338f-fd3a-446b-9688-b28515d38074	2dd507e0-8e57-4924-a57f-8fc2e22555e2	visa not required	\N	\N	48a1d2a1-34ce-46c8-80ff-c4687ccc88cb	fdf4338f-fd3a-446b-9688-b28515d380742dd507e0-8e57-4924-a57f-8fc2e22555e2
1004	fdf4338f-fd3a-446b-9688-b28515d38074	dbc583de-b4de-46ba-aae0-1e8d35054bf3	visa not required	\N	\N	0f26f2a2-76b5-4bdc-a5ab-dd61c9d8d9cc	fdf4338f-fd3a-446b-9688-b28515d38074dbc583de-b4de-46ba-aae0-1e8d35054bf3
1005	fdf4338f-fd3a-446b-9688-b28515d38074	b7f76500-4fa3-457f-aca8-477f05aab728	visa not required	90 days	90 days within any 180-day period	a685b70f-c5e1-4fa6-81cb-8e71263a2978	fdf4338f-fd3a-446b-9688-b28515d38074b7f76500-4fa3-457f-aca8-477f05aab728
1006	fdf4338f-fd3a-446b-9688-b28515d38074	98943525-f93f-426f-a3fe-b48bc18c0c52	visa on arrival	\N	Available at Berbera, Borama, Burao, Erigavo and Hargeisa airports. 30 days, available at Bosaso Airport, Galcaio Airport and Mogadishu Airport.	ec13d224-81a4-4304-a374-f72fc8d7d7da	fdf4338f-fd3a-446b-9688-b28515d3807498943525-f93f-426f-a3fe-b48bc18c0c52
1007	fdf4338f-fd3a-446b-9688-b28515d38074	247ff0fd-78ad-4ca4-90f2-f0394a714535	visa required	\N	\N	afd8c621-13c8-48a3-b2f8-f45a64f5f5ea	fdf4338f-fd3a-446b-9688-b28515d38074247ff0fd-78ad-4ca4-90f2-f0394a714535
1008	fdf4338f-fd3a-446b-9688-b28515d38074	3ffea3be-1c82-411a-b085-933205f900c7	visa required	\N	\N	9a6b8169-d9f2-427f-b41e-f2cc230979eb	fdf4338f-fd3a-446b-9688-b28515d380743ffea3be-1c82-411a-b085-933205f900c7
1009	fdf4338f-fd3a-446b-9688-b28515d38074	02e5c743-3075-4226-8c1d-ad97dadda3d8	visa not required	\N	\N	438e5f5a-d17a-4e88-b310-77a47eefbf81	fdf4338f-fd3a-446b-9688-b28515d3807402e5c743-3075-4226-8c1d-ad97dadda3d8
1010	fdf4338f-fd3a-446b-9688-b28515d38074	6c6c9e3f-2353-431c-83c4-2c0cc6c42ff6	visa on arrival	30 days	\N	86d5ec73-c193-4fb0-b3cf-8919cfb2f452	fdf4338f-fd3a-446b-9688-b28515d380746c6c9e3f-2353-431c-83c4-2c0cc6c42ff6
1011	fdf4338f-fd3a-446b-9688-b28515d38074	c149c091-51c2-41d7-85a7-7d67bcac4230	visa required	\N	\N	0a9c5e14-22b8-4c9e-814f-06423c613365	fdf4338f-fd3a-446b-9688-b28515d38074c149c091-51c2-41d7-85a7-7d67bcac4230
1012	fdf4338f-fd3a-446b-9688-b28515d38074	e0e0a4c5-9076-4a1e-949f-9dd4521eb0f3	evisa	\N	\N	53ab7a8a-c66b-4f49-8c8d-7d7efbfb5f1a	fdf4338f-fd3a-446b-9688-b28515d38074e0e0a4c5-9076-4a1e-949f-9dd4521eb0f3
1013	fdf4338f-fd3a-446b-9688-b28515d38074	5c3dd764-6824-4689-a3e1-1d8c2dc3bc93	visa not required	\N	\N	eb4078b7-d0d1-4896-bfc9-1acb9938484e	fdf4338f-fd3a-446b-9688-b28515d380745c3dd764-6824-4689-a3e1-1d8c2dc3bc93
1014	fdf4338f-fd3a-446b-9688-b28515d38074	dacd5cdd-8e56-4067-bfd8-febc66a04058	visa not required	\N	\N	2c66d98a-a265-4dfe-9ab9-aabc3d7cb04c	fdf4338f-fd3a-446b-9688-b28515d38074dacd5cdd-8e56-4067-bfd8-febc66a04058
1015	fdf4338f-fd3a-446b-9688-b28515d38074	7073c668-a71d-4cf0-a8dd-71008877f8ca	visa required	\N	\N	2e56a8fe-a82c-48a8-adec-5de2d15f18ea	fdf4338f-fd3a-446b-9688-b28515d380747073c668-a71d-4cf0-a8dd-71008877f8ca
1016	fdf4338f-fd3a-446b-9688-b28515d38074	893ca48d-0871-46b1-b299-4bf7e7c98dfa	visa on arrival	45 days	At Dushanbe International Airport. Visa also available online. E-visa holders can enter through all border points.	7b5fd42c-3f1b-488f-9ed5-074f2bbfa493	fdf4338f-fd3a-446b-9688-b28515d38074893ca48d-0871-46b1-b299-4bf7e7c98dfa
1017	fdf4338f-fd3a-446b-9688-b28515d38074	1bf315d2-0a2d-4686-9ecb-6d28f8a5b861	visa not required	\N	\N	ccef51ef-b0d2-4241-a3e7-8c5eb91e21e8	fdf4338f-fd3a-446b-9688-b28515d380741bf315d2-0a2d-4686-9ecb-6d28f8a5b861
1018	fdf4338f-fd3a-446b-9688-b28515d38074	99d1c02c-0a04-4eae-b6cd-403f94e43959	visa on arrival	15 days	\N	09d79d89-6ada-4991-8abf-0085ccbafc8d	fdf4338f-fd3a-446b-9688-b28515d3807499d1c02c-0a04-4eae-b6cd-403f94e43959
1019	fdf4338f-fd3a-446b-9688-b28515d38074	1a61eb0b-45a3-4b91-89c2-c22a20676491	visa not required	90 days	90 days within any 180-day period	454cab1b-aef8-4691-b984-5bdf6a992f23	fdf4338f-fd3a-446b-9688-b28515d380741a61eb0b-45a3-4b91-89c2-c22a20676491
1020	fdf4338f-fd3a-446b-9688-b28515d38074	1a7ba610-72c3-4816-81b5-aad9503a4a9b	visa not required	\N	Information from the Togo Embassy in the United Kingdom that is not found in the IATA database which states that visa can be acquired on arrival.	8546db4d-f860-4113-8cc8-50232d71b6e2	fdf4338f-fd3a-446b-9688-b28515d380741a7ba610-72c3-4816-81b5-aad9503a4a9b
1021	fdf4338f-fd3a-446b-9688-b28515d38074	85e41f4f-c125-4753-bbed-c2ffc7e1c288	visa not required	90 days	90 days within any 180-day period	ef569855-cf78-438c-b78b-11dd00b028c4	fdf4338f-fd3a-446b-9688-b28515d3807485e41f4f-c125-4753-bbed-c2ffc7e1c288
1022	fdf4338f-fd3a-446b-9688-b28515d38074	06659bc5-9958-457e-ac56-2860917a3d28	visa not required	90 days	90 days within any 180-day period	cc3b5d65-cd4b-4b78-a417-00ece569c4db	fdf4338f-fd3a-446b-9688-b28515d3807406659bc5-9958-457e-ac56-2860917a3d28
1023	fdf4338f-fd3a-446b-9688-b28515d38074	cac7a781-be5d-4c59-b9b8-d8bb65fb1487	visa not required	3 mons	\N	67af18d9-4851-4dde-8fb5-8e4dd086de1a	fdf4338f-fd3a-446b-9688-b28515d38074cac7a781-be5d-4c59-b9b8-d8bb65fb1487
1024	fdf4338f-fd3a-446b-9688-b28515d38074	fb99fe5c-118c-44d8-97ba-6570cdb7bd33	visa not required	3 mons	\N	f92c45a5-797c-4066-9f90-5b9be916d2cc	fdf4338f-fd3a-446b-9688-b28515d38074fb99fe5c-118c-44d8-97ba-6570cdb7bd33
1025	fdf4338f-fd3a-446b-9688-b28515d38074	0adc54bf-ff91-4cb0-8571-d89b779f1061	visa required	\N	\N	7c40245d-96f2-40b1-825e-28afd63f1412	fdf4338f-fd3a-446b-9688-b28515d380740adc54bf-ff91-4cb0-8571-d89b779f1061
1026	fdf4338f-fd3a-446b-9688-b28515d38074	6596da04-74ae-4968-9776-6a7debe1b0aa	visa not required	90 days	90 days within any 180-day period	b5b48e75-06e0-4042-b238-51d7be40fe9c	fdf4338f-fd3a-446b-9688-b28515d380746596da04-74ae-4968-9776-6a7debe1b0aa
1027	fdf4338f-fd3a-446b-9688-b28515d38074	c5ce24da-dd58-4e8e-a5e3-91b478717bb4	visa on arrival	\N	May apply online.	b9d17e0a-ba1c-4198-8404-475de8a0ed56	fdf4338f-fd3a-446b-9688-b28515d38074c5ce24da-dd58-4e8e-a5e3-91b478717bb4
1028	fdf4338f-fd3a-446b-9688-b28515d38074	6b63bb5b-0238-4263-bdf4-8064a4fb5c26	visa not required	90 days	90 days within any 180-day period	7fd4031c-d63f-47a3-9932-524ea68bb29a	fdf4338f-fd3a-446b-9688-b28515d380746b63bb5b-0238-4263-bdf4-8064a4fb5c26
1029	fdf4338f-fd3a-446b-9688-b28515d38074	2b1a33fe-be25-452b-8a1c-c7d5f1dce9c2	visa not required	90 days	90 days within any 180-day period	b1d678d3-e443-43ac-81e7-0a3f9aadbe06	fdf4338f-fd3a-446b-9688-b28515d380742b1a33fe-be25-452b-8a1c-c7d5f1dce9c2
1030	fdf4338f-fd3a-446b-9688-b28515d38074	0f433ba9-47e1-4fe6-902c-632bf40355a9	visa not required	\N	\N	eb0096a1-87fb-4126-8809-6efee6f5fe8d	fdf4338f-fd3a-446b-9688-b28515d380740f433ba9-47e1-4fe6-902c-632bf40355a9
1031	fdf4338f-fd3a-446b-9688-b28515d38074	0bea6297-7d53-49a7-927e-e5cbc57e3b5a	visa required	\N	\N	01683a44-82f4-498e-baaf-c94752094cb4	fdf4338f-fd3a-446b-9688-b28515d380740bea6297-7d53-49a7-927e-e5cbc57e3b5a
1032	fdf4338f-fd3a-446b-9688-b28515d38074	d95a4486-5ca4-4500-8b10-211b945552c8	visa not required	90 days	\N	f18a67fb-b274-4d61-bf3b-ebff517593b8	fdf4338f-fd3a-446b-9688-b28515d38074d95a4486-5ca4-4500-8b10-211b945552c8
1033	fdf4338f-fd3a-446b-9688-b28515d38074	19c52566-e35f-44fd-8130-d64562928fe2	visa not required	30 days	\N	d4c26cf8-2a6c-4f99-9d83-41dc640f09af	fdf4338f-fd3a-446b-9688-b28515d3807419c52566-e35f-44fd-8130-d64562928fe2
1034	fdf4338f-fd3a-446b-9688-b28515d38074	33f94df7-cd4f-487a-aa5c-fb45b65f19d5	visa not required	90 days	90 days within any 180-day period	ead94aa9-5875-42d3-95f1-4e520054ccf6	fdf4338f-fd3a-446b-9688-b28515d3807433f94df7-cd4f-487a-aa5c-fb45b65f19d5
1035	fdf4338f-fd3a-446b-9688-b28515d38074	3af87d1b-0507-4bfc-b6a1-e9b91d57fe65	visa not required	\N	ID card valid	9c0f00c4-4002-41b7-8f08-eca06f371e53	fdf4338f-fd3a-446b-9688-b28515d380743af87d1b-0507-4bfc-b6a1-e9b91d57fe65
1036	fdf4338f-fd3a-446b-9688-b28515d38074	3a93a29d-abcc-45af-8915-8e983662c88a	visa not required	90 days	\N	5af64fc6-ecc6-4323-8596-cc8b484fa19d	fdf4338f-fd3a-446b-9688-b28515d380743a93a29d-abcc-45af-8915-8e983662c88a
1037	fdf4338f-fd3a-446b-9688-b28515d38074	ec48dda4-e153-4854-9bc3-453263e606b1	evisa	30 days	\N	67651b86-a0fb-4a54-bbfa-d6793b7f5c0e	fdf4338f-fd3a-446b-9688-b28515d38074ec48dda4-e153-4854-9bc3-453263e606b1
1038	fdf4338f-fd3a-446b-9688-b28515d38074	9da8253b-a4dc-41f8-b8fa-e751b6812191	visa required	\N	\N	970ac781-7c97-421b-bf71-f656f925e044	fdf4338f-fd3a-446b-9688-b28515d380749da8253b-a4dc-41f8-b8fa-e751b6812191
1039	fdf4338f-fd3a-446b-9688-b28515d38074	40fbcdb1-c386-45b7-946f-7e4190dcc02c	visa not required	90 days	\N	7b0da4c2-069a-477d-801a-34f235862c9c	fdf4338f-fd3a-446b-9688-b28515d3807440fbcdb1-c386-45b7-946f-7e4190dcc02c
1040	fdf4338f-fd3a-446b-9688-b28515d38074	39658cd7-be12-4512-8a90-0b2cc9b2769d	visa on arrival	3 mons	30 days for visits on business, 3 months for tourists	8be17707-3272-4b09-a274-3c0fb6a0e8cb	fdf4338f-fd3a-446b-9688-b28515d3807439658cd7-be12-4512-8a90-0b2cc9b2769d
1235	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	6c7e4e7d-9bf4-4e47-b2e4-c925f54bcd1a	visa not required	90 days	May enter with a National ID card	1f0269df-16f4-442c-aa6e-0a8bb0feb6f6	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db6c7e4e7d-9bf4-4e47-b2e4-c925f54bcd1a
1236	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	d9b8f8c8-5b5a-41ef-8538-26d822a4c9bd	visa required	\N	\N	6f47633b-b182-432c-9da6-3dc7ca07007c	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbd9b8f8c8-5b5a-41ef-8538-26d822a4c9bd
1237	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	1965c743-cf9a-4021-9ed1-b9e4e77486a2	visa not required	\N	\N	cde05697-3e21-402e-b266-9e67f8a55176	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db1965c743-cf9a-4021-9ed1-b9e4e77486a2
1238	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	bf07965f-f874-453e-a725-54c5a1254ee8	visa not required	30 days	For a maximum total stay of 90 days within year period.	5699cb50-9365-4de4-b59e-52bc86568d63	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbbf07965f-f874-453e-a725-54c5a1254ee8
1239	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	90de1527-d5a5-446f-a960-eccda43af198	visa not required	1 mon	\N	5f753550-c00e-4f0b-bede-9fe060273d6b	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db90de1527-d5a5-446f-a960-eccda43af198
1240	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	78219cc6-d1b2-4193-9da7-e7abc92863ee	visa not required	90 days	\N	ceaca8bd-f30d-4008-ae92-cf413236a05b	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db78219cc6-d1b2-4193-9da7-e7abc92863ee
1241	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	f2f3e704-bb03-467a-a1a0-1d56b6faadce	visa not required	180 days	\N	86876d3b-1044-41fc-b861-b40bc2c024b2	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbf2f3e704-bb03-467a-a1a0-1d56b6faadce
1242	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	0a3e548d-7e30-426f-840c-07ff9b6772f7	electronic travel authority	90 days	90 days on each visit in 12-month period if granted. May enter using SmartGate on arrival in Australia.	59ed4639-d8c8-4c7f-9b51-62661559b751	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db0a3e548d-7e30-426f-840c-07ff9b6772f7
1243	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	e14f7607-8074-4eeb-8b3f-3093575719a4	visa not required	90 days	90 days within any 180-day period in the Schengen Area	f6d10eb5-f54c-4d9d-9cbb-47538f5a2da8	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbe14f7607-8074-4eeb-8b3f-3093575719a4
1244	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	319530a8-8cd2-4dc3-84a6-29ac720c51da	visa on arrival	30 days	Available at airports eVisa valid for 30 days available otherwise. Singaporeans of Armenian origin, and those whose passports bear evidence of travel to the separatist region of Nagorno-Karabakh (the de facto Nagorno-Karabakh Republic), its surrounding territories and the Azerbaijani exclaves of Karki, Yuxarı Əskipara, Barxudarlı and Sofulu will be permanently banned from entering Azerbaijan and will be included into the “list of persona non grata”.	f8df7a6a-9f4f-42dd-b326-3b5068e9fb3a	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db319530a8-8cd2-4dc3-84a6-29ac720c51da
1245	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	ac6434f1-bbb9-4242-a393-d78d367f034a	visa not required	3 mons	\N	43c80981-4600-40d9-b9c7-6dc43b6b8cf1	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbac6434f1-bbb9-4242-a393-d78d367f034a
1246	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	497550d7-f9e9-4f1a-a5e0-8c9019c7bc31	visa on arrival	14 days	May also be obtained online in the form of an E-Visa.	c560a18d-a544-4496-aa39-a7fad17638fc	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db497550d7-f9e9-4f1a-a5e0-8c9019c7bc31
1247	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	bb3fa754-b35e-45ee-8d66-fb159c96d821	visa on arrival	30 days	Not available at all entry points.	b7b775ea-d98b-4bd1-8aee-5b3351c36efa	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbbb3fa754-b35e-45ee-8d66-fb159c96d821
1248	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	49494a5b-205f-4756-9145-2784c9269a99	visa not required	6 mons	\N	f02e34e9-81a6-4e6e-9ac5-b5967e026da3	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db49494a5b-205f-4756-9145-2784c9269a99
1249	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	ac612169-1567-4c5e-a203-3987fa26c267	visa not required	30 days	Must arrive and depart via Minsk International Airport.	87476540-9363-4e2e-bc06-e90073c3d07c	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbac612169-1567-4c5e-a203-3987fa26c267
1250	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	1f4dd261-dc57-49ec-b872-8b1917703616	visa not required	90 days	90 days within any 180-day period in the Schengen Area	348185fe-96be-494c-80bf-30d7c5122c8f	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db1f4dd261-dc57-49ec-b872-8b1917703616
1251	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	3e62d48d-717d-4421-91c2-abb059a80576	visa not required	\N	\N	174fe2ef-c414-4989-9652-5103e5ff1207	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db3e62d48d-717d-4421-91c2-abb059a80576
1252	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	5fbebc32-e410-4faa-94e5-822252f8b499	visa on arrival	30 days	Must have an international vaccination certificate.	59cc6534-2d65-4f3d-9eff-f9c1ae2627a8	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db5fbebc32-e410-4faa-94e5-822252f8b499
1253	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	1d58bd18-8519-4e53-8cd1-6a7e93cda614	visa required	\N	\N	35cda355-2d21-4f41-a2a3-a894ea6e618a	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db1d58bd18-8519-4e53-8cd1-6a7e93cda614
1254	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	546440bf-236c-4f99-bd12-3bba52d50e02	visa on arrival	90 days	Fee is US$52.	5b215946-5eb9-469d-9c7a-9210442a2a96	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db546440bf-236c-4f99-bd12-3bba52d50e02
1255	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	c103dabb-a386-4a6a-bce5-c0c0fa5f43f6	visa not required	90 days	90 days within any 6-month period	fa97b256-0bed-4ad2-8679-8f7756eadbc0	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbc103dabb-a386-4a6a-bce5-c0c0fa5f43f6
1256	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	ff4c5033-aee4-4325-90cc-1f96ef10bbce	visa not required	90 days	90 days within any year period	d591cbec-52b5-4772-94d1-f343416a4767	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbff4c5033-aee4-4325-90cc-1f96ef10bbce
1257	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	1b558876-4f84-41fb-8215-93143842ba53	visa not required	30 days	\N	58b8f8c7-e4af-4ee7-bb17-7867826e27d3	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db1b558876-4f84-41fb-8215-93143842ba53
1258	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	49ca53d4-0d59-4be8-9724-70b0eff911ce	visa not required	30 days	\N	72c36fbf-ca8c-4cff-bca5-c7d97cebbc34	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db49ca53d4-0d59-4be8-9724-70b0eff911ce
1259	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	dde93861-da65-40d4-8159-3e67e8d58e02	visa not required	90 days	90 days within any 180-day period	5b3bfe26-70bf-4178-89e1-f9e6625ce650	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbdde93861-da65-40d4-8159-3e67e8d58e02
1260	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	a22c7473-248e-4447-8bc7-1fc51c00ca3e	visa not required	30 days	\N	440e96ba-34cc-4930-8169-98cfd0112835	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dba22c7473-248e-4447-8bc7-1fc51c00ca3e
1261	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	4f0fe689-81e0-4b91-a093-cad33a305482	visa required	\N	\N	dade388d-01f1-4dcd-a9c2-597630de9164	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db4f0fe689-81e0-4b91-a093-cad33a305482
1262	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	723de35c-616a-4b10-b479-c08378f3765b	visa not required	30 days	\N	46af37a7-74f0-402e-8eb2-c56df5a70cc6	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db723de35c-616a-4b10-b479-c08378f3765b
1263	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	526f75ae-3c43-45a3-924e-1d7e11177a68	visa required	\N	Holders of a pre-arranged approval issued by “Le Delegue General de la Surete” can obtain a visa on arrival.	5da84ac3-b99e-454e-b805-406bcccfaa78	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db526f75ae-3c43-45a3-924e-1d7e11177a68
1322	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	8275007a-70b9-4a04-bcfa-1c23825d4874	visa not required	30 days	\N	6e13c46c-3654-4919-a73b-b6f3d98e6b76	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db8275007a-70b9-4a04-bcfa-1c23825d4874
1264	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	e242cbe2-dc75-4807-a7c9-c171d164ec2d	visa not required	6 mons	eTA required if arriving by air.	90621f29-a35a-48fa-ac23-6da9ead38643	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbe242cbe2-dc75-4807-a7c9-c171d164ec2d
1265	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	3e77325d-7fea-46ad-a8fa-b2d31056b3ea	visa not required	90 days	\N	04b88e14-1118-4a59-830b-7bf423c702b9	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db3e77325d-7fea-46ad-a8fa-b2d31056b3ea
1266	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	2b1aaccb-5846-45c1-8481-12bb8b5e0aa4	visa required	\N	\N	240a441f-6f33-4386-a3fd-7a763aa87f8b	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db2b1aaccb-5846-45c1-8481-12bb8b5e0aa4
1267	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	3f759fc5-8287-4acb-b58d-f235c5ef4981	visa required	\N	\N	1e24ffb7-5a5e-466a-bf26-9e593192e3ff	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db3f759fc5-8287-4acb-b58d-f235c5ef4981
1268	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	c5a755fa-0935-4ec5-a880-3d4854beabfd	visa not required	30 days	\N	b0b1fe20-5228-464d-9704-becc5e08ea0e	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbc5a755fa-0935-4ec5-a880-3d4854beabfd
1269	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	7178da96-360e-4b0a-ada4-9640c498daf8	visa not required	15 days	\N	54188f54-fd90-49fb-bb00-2f2d1efcb467	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db7178da96-360e-4b0a-ada4-9640c498daf8
1270	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	8b58bd46-c2d7-4df7-8871-378dbe921468	visa not required	180 days	90 days – extendable up to 180-day stay within a one-year period	587162ca-f006-44f1-ad07-b93f64b180f2	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db8b58bd46-c2d7-4df7-8871-378dbe921468
1271	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	48847459-b1b2-4092-9bf0-f0c08b928c74	visa on arrival	45 days	\N	55425ff5-8dbd-418b-b7c6-1724c58e2a4f	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db48847459-b1b2-4092-9bf0-f0c08b928c74
1272	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	196ed632-cc17-4b9f-87cb-cbc9832e8617	visa required	\N	Except Passengers with VIP invitation.	69160ab4-dba9-4329-98b5-293ffc7b149c	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db196ed632-cc17-4b9f-87cb-cbc9832e8617
1273	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	80b3fc54-1fa6-49c6-ac4c-998b002d754f	visa required	\N	\N	1579762b-0d3a-496f-88e5-3e22b90f6678	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db80b3fc54-1fa6-49c6-ac4c-998b002d754f
1274	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	cf56f0da-daf4-4437-9ad9-4b61bbedc31a	visa not required	90 days	\N	a5e36618-c0e3-4ed9-a31b-0e0355afb6e4	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbcf56f0da-daf4-4437-9ad9-4b61bbedc31a
1275	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	31d93d6a-5130-4cfa-87ba-90d971d98d34	visa not required	90 days	\N	1d8dac8f-af26-4de2-b24c-13222d7c45c0	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db31d93d6a-5130-4cfa-87ba-90d971d98d34
1276	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	14730d5f-e0e5-43a8-bc67-ca9f92c8502a	visa not required	90 days	90 days within any 180-day period	21ca5bda-a350-437d-a8c5-4c8e546f0ea0	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db14730d5f-e0e5-43a8-bc67-ca9f92c8502a
1277	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	16a55dd1-2e47-489d-830c-3a88aad464a9	visa not required	30 days	\N	3953ced5-0f1f-44b7-802a-0e54b4247290	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db16a55dd1-2e47-489d-830c-3a88aad464a9
1278	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	f36ec987-ed66-4a88-9157-b1d4a934e515	visa not required	90 days	90 days within any 180-day period	afc6a8a4-6614-4221-9b32-84c33099c962	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbf36ec987-ed66-4a88-9157-b1d4a934e515
1279	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	c5db5d6b-ebcd-4642-9604-0f1ebf2fdf9d	visa not required	90 days	90 days within any 180-day period in the Schengen Area	0c13f857-0fa6-4c1d-9f6a-2132093ddb62	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbc5db5d6b-ebcd-4642-9604-0f1ebf2fdf9d
1280	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	870d8300-9c56-4b34-9447-bcdfedf8454c	visa not required	3 mons	3 months within the past 6 months, regardless of previous time spent in other Schengen countries, but including time spent in other Nordic countries	153730b3-7dd1-4d60-8ede-8bc44f87a7b0	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db870d8300-9c56-4b34-9447-bcdfedf8454c
1281	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	0b48c87c-ddaa-49d2-b736-61d9c44636e0	visa not required	\N	\N	d4032a4d-abe2-48ec-9a7c-095a9c5ded01	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db0b48c87c-ddaa-49d2-b736-61d9c44636e0
1282	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	a66c6aaf-f010-4056-8928-1653d670edf3	visa not required	6 mons	\N	ab7cde27-44e4-47cd-a09b-247498d74c1f	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dba66c6aaf-f010-4056-8928-1653d670edf3
1283	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	7caae20c-20fa-4ce0-a987-cca304a302b9	visa not required	30 days	\N	d67ea752-3820-4a7b-890a-12647e1bd969	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db7caae20c-20fa-4ce0-a987-cca304a302b9
1284	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	41fa1fc8-a7c9-4045-ac6a-92fe36c27bd9	visa not required	90 days	\N	45dfeb85-62d8-4e40-8bd6-a5177b2afec8	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db41fa1fc8-a7c9-4045-ac6a-92fe36c27bd9
1285	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	0d0a18fd-d424-4a69-b646-38fffd942dd5	visa on arrival	30 days	Extension possible (needs to be shaded in light green on the map).	f1462f8d-c1bc-4f39-803a-03bdd58d8dca	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db0d0a18fd-d424-4a69-b646-38fffd942dd5
1286	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	bae2df87-ee9b-4efe-8482-2b05b54ebb11	visa not required	3 mons	\N	516e6f06-1d9b-478f-84ef-386545bb1f29	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbbae2df87-ee9b-4efe-8482-2b05b54ebb11
1287	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	43d35de8-4ed4-4bd7-9fce-54d9adcdeec6	visa required	\N	\N	c249c2ed-b7ce-4382-961e-30d043e74310	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db43d35de8-4ed4-4bd7-9fce-54d9adcdeec6
1288	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	b2db2210-e9b8-4d51-b3c0-ed8e3d6adc9b	visa required	\N	\N	0ea8a557-9ed9-413c-a364-3789b4379c88	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbb2db2210-e9b8-4d51-b3c0-ed8e3d6adc9b
1289	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	061c7757-87bb-4acc-bfb5-ebb5a4dc9429	visa not required	90 days	90 days within any 180-day period in the Schengen Area	cc922a30-7b1f-4245-89ef-34a4a3f17867	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db061c7757-87bb-4acc-bfb5-ebb5a4dc9429
1290	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	646467f2-a7ee-4dc3-8589-902f948694cf	visa not required	30 days	\N	ebc06c3f-446d-4244-b6e2-d7f25e15bd16	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db646467f2-a7ee-4dc3-8589-902f948694cf
1291	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	f76a50d7-c955-4658-a2da-f191b746b434	evisa	90 days	eVisa holders must arrive via Addis Ababa Bole International Airport	35ab9196-6316-498d-816b-45807f99b671	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbf76a50d7-c955-4658-a2da-f191b746b434
1292	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	923566be-1a81-4281-a9f5-fc3d8e59e53e	visa not required	4 mons	\N	bfb605da-f049-4000-9336-fb43d52a365c	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db923566be-1a81-4281-a9f5-fc3d8e59e53e
1293	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	d322fe64-203a-4eb4-8316-2c6c1af401a3	visa not required	90 days	90 days within any 180-day period in the Schengen Area	150b48b8-9c16-453b-9d85-5623b0d17392	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbd322fe64-203a-4eb4-8316-2c6c1af401a3
1294	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	b7b802fe-8789-4b6d-b085-7c25a92dab7b	visa not required	90 days	90 days within any 180-day period in the Schengen Area (in Regions of France)	5a655f92-2a86-40ae-a620-5edf0f7d3630	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbb7b802fe-8789-4b6d-b085-7c25a92dab7b
1295	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	6a95dca7-5bc9-438d-ba51-5cc4603d70a4	evisa	\N	Passengers arriving at Libreville International Airport do not need a visa if they have filled out the online Electronic Authorization Form. Approval process takes up to 72 hours following submission of the visa waiver request.	ea1c6483-02bd-4f77-8e2f-be76a7368c1d	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db6a95dca7-5bc9-438d-ba51-5cc4603d70a4
1296	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	81e9890e-9239-4c33-b429-66950b214814	visa not required	90 days	\N	cff4a9cd-a3c9-4881-97f5-dd05fcdcf53d	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db81e9890e-9239-4c33-b429-66950b214814
1297	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	f2e17057-cb16-4fd3-92ef-07a6320c1818	visa not required	1 year	\N	b291df09-8735-4328-a1be-443f4a504834	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbf2e17057-cb16-4fd3-92ef-07a6320c1818
1298	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	d80301ed-7cdc-4f2c-8093-cfec014b077a	visa not required	90 days	90 days within any 180-day period in the Schengen Area	7aa42046-9f24-422e-a2ea-cf0bb34178bb	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbd80301ed-7cdc-4f2c-8093-cfec014b077a
1299	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	53618499-ed33-49f9-aeae-e24d02029f1e	visa not required	\N	\N	95b9619c-db98-4827-bb56-409df18c52fd	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db53618499-ed33-49f9-aeae-e24d02029f1e
1300	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	1a76eb8a-5fca-4552-a0dd-9728217998b0	visa not required	90 days	90 days within any 180-day period in the Schengen Area	a2cdd6e5-6623-4450-9e18-d0b479117040	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db1a76eb8a-5fca-4552-a0dd-9728217998b0
1301	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	aedfe3b8-fc01-41f8-a152-516e139dc8b6	visa not required	3 mons	\N	7875b317-22d5-4828-909d-3e344e9f9beb	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbaedfe3b8-fc01-41f8-a152-516e139dc8b6
1302	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	0e291c7e-51a2-466f-94b9-de8d9dec9dd2	visa not required	90 days	\N	5e7d2514-40f1-4c88-8aee-94a760df14c1	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db0e291c7e-51a2-466f-94b9-de8d9dec9dd2
1303	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	b3e98c98-8a15-45bf-8f86-f26f6a07a425	visa not required	30 days	\N	4342c362-85a1-4a96-a596-5567388e8d9d	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbb3e98c98-8a15-45bf-8f86-f26f6a07a425
1304	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	98fd5d7d-6f4c-434d-bd97-6fabe502db00	visa on arrival	90 days	\N	8ab6cc9b-d192-4ca5-ba8f-ed8bb6676d07	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db98fd5d7d-6f4c-434d-bd97-6fabe502db00
1305	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	f11d746c-8b82-4fe1-acb0-788067f0071c	visa required	\N	Those travelling as tourists can obtain a visa on arrival for a maximum stay of 30 days provided holding a letter of invitation from sponsor or host. Otherwise, pre-arrival visa is required.	7527c95f-34c1-4f01-9d36-817d1db56ddc	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbf11d746c-8b82-4fe1-acb0-788067f0071c
1306	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	99530f46-46c4-4263-bd88-dca23dc0383f	visa not required	3 mons	\N	c9efa2e8-236f-4cc6-9dba-dae679f8a6d3	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db99530f46-46c4-4263-bd88-dca23dc0383f
1307	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	3e33cfe7-603b-4d88-a6e3-f4dcc331d9f2	visa not required	3 mons	\N	05a4c0f2-2e69-42ba-9722-c73061cd9258	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db3e33cfe7-603b-4d88-a6e3-f4dcc331d9f2
1308	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	8287bea9-2349-46e4-9ac0-fb1e799497af	visa not required	90 days	90 days within any 180-day period in the Schengen Area	bae38138-11b9-45c8-9f09-416fc32460ea	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db8287bea9-2349-46e4-9ac0-fb1e799497af
1309	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	68563b3e-8866-4310-bdce-659b3cc9c2ac	visa not required	90 days	90 days within any 180-day period in the Schengen Area	403e1498-bb46-4c2d-8601-40f96582725a	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db68563b3e-8866-4310-bdce-659b3cc9c2ac
1310	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	83f3b190-021f-4694-a033-57058c22cbf4	evisa	60 days	e-Visa holders must arrive via 26 designated airports or 3 designated seaports. An Indian e-Tourist Visa can only be obtained twice in one calendar year. Holders of a valid Person of Indian Origin or Overseas Citizen of India Card are exempt from the visa requirement, and may travel to India unlimited times.	73a2b86b-9693-4521-b87d-d9468f50dc20	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db83f3b190-021f-4694-a033-57058c22cbf4
1311	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	a3122035-5d20-411c-a94d-17360ed55678	visa not required	30 days	\N	4ee9c774-b919-4152-b83a-212660e29e6a	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dba3122035-5d20-411c-a94d-17360ed55678
1312	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	1baa5d83-2707-4a0d-8f86-45efc106dffd	visa on arrival	30 days	\N	ade6053a-bf65-49c6-ac39-a1051dcd579d	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db1baa5d83-2707-4a0d-8f86-45efc106dffd
1313	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	e130f15d-7a37-4ddf-a6b5-e9c1266e128a	visa required	\N	\N	3e3425fc-4c97-46a2-a1cf-a3d99fb295ab	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbe130f15d-7a37-4ddf-a6b5-e9c1266e128a
1314	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	48d25a4f-6bcb-4595-bf82-1492334695ec	visa not required	3 mons	\N	9fe226e5-daad-4a17-95c9-e752ecfd34ce	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db48d25a4f-6bcb-4595-bf82-1492334695ec
1315	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	fc3338b4-47f1-4342-8def-3acabc77a994	visa not required	3 mons	\N	2f5be455-78fa-4313-b02e-805e3709d579	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbfc3338b4-47f1-4342-8def-3acabc77a994
1316	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	161a32a0-755e-430b-86dc-8f153f7de9b1	visa not required	90 days	90 days within any 180-day period in the Schengen Area	2b4885ed-d382-433e-8b0c-4a10ab7b2165	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db161a32a0-755e-430b-86dc-8f153f7de9b1
1317	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	96abeca6-c08e-4df8-b22f-2fefc55a8d5b	visa not required	6 mons	\N	9e79347d-6e8a-49b0-8ec5-a6a1896a65b7	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db96abeca6-c08e-4df8-b22f-2fefc55a8d5b
1318	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	8e5a125d-73cb-45c1-a511-f0c65d7448e7	visa not required	90 days	\N	9c4146bb-e373-4736-935f-8a9d57542e2a	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db8e5a125d-73cb-45c1-a511-f0c65d7448e7
1319	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	c728bbe4-373f-4d0a-9a3f-985679759733	visa on arrival	\N	Visa is issued free of charge in most circumstances. Not available at all entry points.	b8d21383-d6e4-48cf-a962-377c835f83ff	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbc728bbe4-373f-4d0a-9a3f-985679759733
1320	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	c6a8ea7c-3fed-4a1d-9929-5569db7ab968	visa not required	30 days	\N	0ca7aa80-5359-440a-8032-bd79ce9a9b7c	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbc6a8ea7c-3fed-4a1d-9929-5569db7ab968
1321	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	e91cae72-f62c-407e-b388-3f3b86f7a0c3	visa not required	3 mons	\N	c3ecd962-a174-47fb-8561-1fb937805a4a	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbe91cae72-f62c-407e-b388-3f3b86f7a0c3
1323	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	9ad23145-f384-4a8f-a075-4648d1837d46	visa required	\N	\N	3092c15b-8260-4fd9-a13b-1332e16aa666	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db9ad23145-f384-4a8f-a075-4648d1837d46
1324	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	52dc85c7-9f30-470a-9de9-09b95bc11e86	visa not required	90 days	\N	5867168e-d71c-4e9d-9ea3-7e425d18f779	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db52dc85c7-9f30-470a-9de9-09b95bc11e86
1325	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	ab2a946c-f1e3-43f5-bbfd-4b54adae333a	visa on arrival	3 mons	E-Visa is also available online.	69f9ce71-a044-4585-8b60-1ca74fe32c55	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbab2a946c-f1e3-43f5-bbfd-4b54adae333a
1326	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	6cec735b-3406-430f-be56-71d96ff8f41e	visa not required	60 days	\N	a92e3d3b-b9eb-40d8-a59c-d2d530dc3ebd	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db6cec735b-3406-430f-be56-71d96ff8f41e
1327	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	34e549be-e921-419a-a64d-2349902ee1e8	visa not required	30 days	\N	b09510f7-42eb-43af-b3b9-9124094a479e	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db34e549be-e921-419a-a64d-2349902ee1e8
1328	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	85b0fd58-f24b-4249-a31c-46e40023744c	visa not required	90 days	90 days within any 180-day period in the Schengen Area	be5a3390-b12d-4236-bacf-ae8ce8907121	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db85b0fd58-f24b-4249-a31c-46e40023744c
1329	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	6a6a8869-35f4-4d7f-af9f-c881d3b4bc19	free visa on arrival	1 mon	1 month extendable for 2 additional months Granted free of charge at Beirut International Airport or any other port of entry if there is no Israeli visa or stamp in the passport, and in possession of phone number & address to be visited in Lebanon, and a non-refundable onward or round trip ticket.	90cef28f-8ba3-4667-8a9d-cd732db4618d	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db6a6a8869-35f4-4d7f-af9f-c881d3b4bc19
1330	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	f7ca89ef-b000-416a-b9f4-6059b2d8a3ca	visa not required	30 days	\N	498b25bf-5cda-470d-b05f-0864fe3e51fe	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbf7ca89ef-b000-416a-b9f4-6059b2d8a3ca
1331	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	e3c9a7c1-e5ec-46aa-be24-13a63b23c24a	visa required	\N	\N	56062ed0-63ce-4cdf-91d9-8afb6617e05b	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbe3c9a7c1-e5ec-46aa-be24-13a63b23c24a
1332	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	a9bc64d6-1f2e-4882-90bc-4930614667da	visa required	\N	\N	45ef310d-4f91-4304-a7f9-6e0452b71c49	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dba9bc64d6-1f2e-4882-90bc-4930614667da
1333	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	8510166b-62a4-475f-8afe-891fe1cb22a0	visa not required	90 days	90 days within any 180-day period in the Schengen Area	7fd5ffab-6954-4556-b32d-76b72f68d31e	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db8510166b-62a4-475f-8afe-891fe1cb22a0
1334	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	d4d24a30-2184-4fd3-8315-248ddc094526	visa not required	90 days	90 days within any 180-day period in the Schengen Area	7777687a-eaa9-4bd0-a559-bcc7caafa6f8	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbd4d24a30-2184-4fd3-8315-248ddc094526
1335	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	a94b35b0-c269-4e9f-9d66-80d8f3081989	visa not required	90 days	90 days within any 180-day period in the Schengen Area	360c146e-e544-4ff1-9697-f6547fb0cf97	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dba94b35b0-c269-4e9f-9d66-80d8f3081989
1336	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	b7206cc1-2cca-454d-9447-3788640f7b5e	visa on arrival	90 days	\N	7abd0e4e-b3cb-4829-ae5a-e4759173abf8	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbb7206cc1-2cca-454d-9447-3788640f7b5e
1337	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	413fe813-55c0-49e9-8853-47654b4ae73b	visa on arrival	90 days	\N	8d6be6e9-6a1b-4cad-bbc1-0bfc49eb6834	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db413fe813-55c0-49e9-8853-47654b4ae73b
1338	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	d42ac9fd-1e10-4995-8dc1-4d25cee7a022	visa not required	1 mon	\N	459cc55d-c7e8-4348-872a-31b96593257f	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbd42ac9fd-1e10-4995-8dc1-4d25cee7a022
1339	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	2b8d132e-e3b8-4a97-aa78-a265bf65836d	free visa on arrival	30 days	\N	db0c78a0-f4a1-411f-8f7e-aaf13b867afa	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db2b8d132e-e3b8-4a97-aa78-a265bf65836d
1340	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	a8c0bf67-69a5-4293-8282-622c6b61962c	visa required	\N	\N	d96d56ca-e516-410c-9574-f558e1001ab2	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dba8c0bf67-69a5-4293-8282-622c6b61962c
1341	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	ca8f94ef-b748-47c8-b040-b996e3cf2581	visa not required	90 days	90 days within any 180-day period in the Schengen Area	4c0894ee-40fd-4a14-a054-0040ad409767	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbca8f94ef-b748-47c8-b040-b996e3cf2581
1342	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	27f40e7e-ab08-4e44-b643-f9546021f2c2	visa on arrival	90 days	\N	961c5ec0-ccba-45ff-b842-2016aef54f8d	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db27f40e7e-ab08-4e44-b643-f9546021f2c2
1343	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	a4d1f62b-6131-44de-92fe-975d0a463bc7	visa on arrival	\N	Available at Nouakchott–Oumtounsy International Airport.	0c41689a-5653-4fe8-b51f-f0d35d2c741c	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dba4d1f62b-6131-44de-92fe-975d0a463bc7
1344	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	59a60488-bbd7-476a-813e-a92fa901e8e7	visa not required	90 days	\N	e87a7c92-2086-4170-88ce-6d1da84a9349	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db59a60488-bbd7-476a-813e-a92fa901e8e7
1345	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	846ec109-79bc-4e46-a303-40e20bcb2f36	visa not required	180 days	\N	c0d39bcb-6992-474f-8088-835365805f89	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db846ec109-79bc-4e46-a303-40e20bcb2f36
1346	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	0343465d-616b-4419-b3ac-6e358776cb2e	visa not required	30 days	\N	ce967f7c-b929-43ed-99a7-d3e2a1b800a2	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db0343465d-616b-4419-b3ac-6e358776cb2e
1347	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	6f37afd2-3170-4c9d-8fde-28d6a44eda0d	visa not required	90 days	90 days within any 180-day period	e6e4e638-8fa9-499e-92b7-d5a719833d0a	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db6f37afd2-3170-4c9d-8fde-28d6a44eda0d
1348	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	e1b6cef2-9a2d-441a-96db-2cb815ac9398	visa not required	\N	\N	025f0fef-821e-4215-95bb-40f2246ce78f	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbe1b6cef2-9a2d-441a-96db-2cb815ac9398
1349	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	b60fe946-71ac-40be-97dc-8ee0b78c3384	visa not required	30 days	\N	d64f689c-fd4b-4ca1-963f-9bbd36f6e402	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbb60fe946-71ac-40be-97dc-8ee0b78c3384
1350	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	6702177a-fbed-4cf3-aa32-22da244beab0	visa not required	90 days	\N	335e7aed-a485-4cae-abbc-d60310fc47c3	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db6702177a-fbed-4cf3-aa32-22da244beab0
1351	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	a7462d3b-b094-454a-a09c-08573a566463	visa not required	30 days	\N	dcf7e161-178a-4b4e-93e3-9121e22c3e58	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dba7462d3b-b094-454a-a09c-08573a566463
1352	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	95251d34-e411-4cb7-9112-0a1f95b239e0	visa on arrival	30 days	Conditions apply.	a63730cc-0ac3-4117-9fb4-ca5862636a01	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db95251d34-e411-4cb7-9112-0a1f95b239e0
1353	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	ac8b13ec-0d98-4fad-852e-a351d68e6a16	visa not required	30 days	\N	6050d4ac-6966-4e8e-8fe7-526423d62227	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbac8b13ec-0d98-4fad-852e-a351d68e6a16
1354	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	dff0e275-70f0-4d4b-9d4a-3b4029ab3cd1	visa not required	3 mons	\N	7012e8b6-45ed-4361-bc29-9802155ab469	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbdff0e275-70f0-4d4b-9d4a-3b4029ab3cd1
1355	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	c00f0e5e-a315-4118-b879-8d0a07faa486	visa required	\N	\N	8959bb80-81a5-4a17-912e-844fbe62eafd	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbc00f0e5e-a315-4118-b879-8d0a07faa486
1356	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	52a86412-42e6-499e-a742-a0902ca649b5	visa on arrival	90 days	\N	3efa39f4-f746-4679-84a2-a5c234102a79	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db52a86412-42e6-499e-a742-a0902ca649b5
1357	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	649e4cd5-204a-41ae-add6-5c7433d23973	visa not required	90 days	90 days within any 180-day period in the Schengen Area (European Netherlands)	a82e67c5-f188-4df8-89a5-9028a3955c6e	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db649e4cd5-204a-41ae-add6-5c7433d23973
1358	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	903625d0-0df4-4537-8370-4c3cda4ffed6	electronic travel authority	90 days	May enter using eGate. International Visitor Conservation and Tourism Levy must be obtained alongside Electronic Travel Authority.	9132c139-0310-4062-b821-663ad6f21223	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db903625d0-0df4-4537-8370-4c3cda4ffed6
1359	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	390d0b06-0892-405b-93f4-8b1b69af9667	visa not required	90 days	\N	51097b12-517a-4082-af4b-358ae2bb2aed	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db390d0b06-0892-405b-93f4-8b1b69af9667
1360	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	363bc536-025f-4ef7-95c0-a083bb8f37e6	visa required	\N	\N	fcecdb39-c2d3-4e1f-8722-85116ee0008d	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db363bc536-025f-4ef7-95c0-a083bb8f37e6
1361	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	7ce306aa-4c86-4016-93ab-cf3f5c22c621	visa required	\N	Holders of written e-visa approval issued by Immigration Authority Headquarters in Abuja, can obtain a visa on arrival.	c8521ae8-3c0e-425f-97e7-555ef46b9926	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db7ce306aa-4c86-4016-93ab-cf3f5c22c621
1362	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	6b9ca8c2-1096-496b-9aa2-0a0dc3fb4f32	visa not required	90 days	\N	abbd7158-03ed-4ba5-bde1-b84b916d3304	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db6b9ca8c2-1096-496b-9aa2-0a0dc3fb4f32
1363	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	4f50cb61-60cb-48f5-9c7a-974d9c3840d5	visa not required	3 mons	3 months within the past 6 months, regardless of previous time spent in other Schengen countries, but including time spent in other Nordic countries	5daaae4e-ab32-4c82-ba99-874193419515	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db4f50cb61-60cb-48f5-9c7a-974d9c3840d5
1364	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	7a1e411c-5e2b-4ef6-9561-73a4466af643	evisa	30 days	\N	43b696e1-8f9a-4e94-b5d5-651374c3d4bd	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db7a1e411c-5e2b-4ef6-9561-73a4466af643
1365	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	abc45575-6e5a-49c5-9967-e067a503c8a6	electronic travel authorization	\N	Electronic Travel Authorization to obtain a visa on arrival for tourism purposes. Electronic Travel Authorization to obtain a visa on arrival for business purposes. Online Visa eligible.	61860719-fff7-4c73-9085-ae676822c2b4	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbabc45575-6e5a-49c5-9967-e067a503c8a6
1366	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	43e7d908-36ff-47b2-813c-146e89e91aef	free visa on arrival	30 days	A visa is issued free of charge upon arrival at any port of entries.	6f0c8fcc-6fc6-4d65-a079-a5d73da432dd	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db43e7d908-36ff-47b2-813c-146e89e91aef
1367	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	e32cd55b-2b25-444e-beb4-f86a6e81819b	visa not required	180 days	\N	a7546f02-5b22-41bb-a4c8-33774d4c3848	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbe32cd55b-2b25-444e-beb4-f86a6e81819b
1368	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	2f5d487b-20b7-47c4-b8fe-378d3c40839a	free visa on arrival	60 days	\N	25e36b8c-dd29-44d3-9ac9-ddc9b8f39647	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db2f5d487b-20b7-47c4-b8fe-378d3c40839a
1369	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	5091a6a9-aa19-4e48-890a-d0d3ccce88c7	visa not required	30 days	\N	13de9126-5537-4913-b3d0-9b3408475bcb	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db5091a6a9-aa19-4e48-890a-d0d3ccce88c7
1370	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	6fd50499-8698-4764-a9ea-d063e211ae85	visa not required	183 days	\N	d04040b6-3ea6-41f7-8b88-30df9c45e957	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db6fd50499-8698-4764-a9ea-d063e211ae85
1371	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	d29dcef8-e41b-4540-8f88-8849607ad3f3	visa not required	30 days	\N	6a1a5fb4-d6b2-438f-be4f-f22b287a703d	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbd29dcef8-e41b-4540-8f88-8849607ad3f3
1372	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	9a7ad7e0-1e36-4004-9879-568b56d0cf87	visa not required	90 days	90 days within a 180 day period, regardless of previous time spent in other Schengen countries (pursuant to the Poland-Singapore bilateral agreement regulating visa-free traffic that was concluded before Poland joined the European Union and the Schengen Area)	dabc5d8f-049a-41e7-a37b-d8023258b103	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db9a7ad7e0-1e36-4004-9879-568b56d0cf87
1373	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	c2f84d45-aa39-4df1-8a87-e4dd0c5b34a1	visa not required	90 days	90 days within any 180-day period in the Schengen Area	77af99cf-116c-4ed4-8cf2-be7dfda49f07	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbc2f84d45-aa39-4df1-8a87-e4dd0c5b34a1
1374	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	90a93353-4714-42fc-8632-09f25bc1312a	visa not required	30 days	\N	5401294c-3f84-4b5d-87b8-cdc8f18b6d97	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db90a93353-4714-42fc-8632-09f25bc1312a
1375	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	fdf4338f-fd3a-446b-9688-b28515d38074	visa not required	90 days	90 days within any 180-day period	c0f6c40b-2a12-4058-9b3e-da7c3f7f4d68	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbfdf4338f-fd3a-446b-9688-b28515d38074
1376	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	ae5dee3a-1222-4f42-9f97-470ab88b3b7e	visa required	\N	eVisa for up to 8 days for Amur Oblast, Chukotka, Kamchatka, Khabarovsk Krai, Primorye and Sakhalin regions of the Russian Far East for tourism, business and humanitarian purposes. Available at 6 airports, 5 seaports, some railway and road entry points. Holders of an APEC Business Travel Card (ABTC) travelling on business do not require a visa. Singaporean citizens are eligible for eVisas to Kaliningrad Oblast for up to 8 days.	2f59cb0d-ca39-44f7-b50b-e6efa07515e7	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbae5dee3a-1222-4f42-9f97-470ab88b3b7e
1377	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	418d8911-a62b-4686-bf0e-f18b204398d8	visa not required	90 days	\N	83da6c83-c338-4cd7-9e3e-ca7ff9579940	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db418d8911-a62b-4686-bf0e-f18b204398d8
1378	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	ec506881-6436-49fc-b56e-42da02dd7d5b	visa not required	3 mons	\N	19d6c8ba-8825-4942-a5bc-6c5fbf291b26	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbec506881-6436-49fc-b56e-42da02dd7d5b
1379	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	e3b26362-6759-4612-8863-4785505a679e	visa not required	15 days	\N	08234d0c-d2c6-4887-97cc-b3c69a8b2c3b	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbe3b26362-6759-4612-8863-4785505a679e
1380	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	54824162-df76-4f5e-8783-404687f907f1	visa not required	1 mon	\N	abae93aa-e4cc-42d3-b36b-7bdbaff49ec3	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db54824162-df76-4f5e-8783-404687f907f1
1381	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	7d76fbc2-43bb-467f-b36b-1b899f3d013a	free entry permit on arrival	60 days	\N	a237af16-7682-4d1e-844e-4e09a9cb465b	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db7d76fbc2-43bb-467f-b36b-1b899f3d013a
1382	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	1bc1c6a9-2028-4dcd-94bf-6d19bea049e6	visa not required	\N	\N	5d316962-417e-401d-8ea7-7c8959b4644e	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db1bc1c6a9-2028-4dcd-94bf-6d19bea049e6
1383	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	ab4bc3a4-7c19-4a94-905c-a7973e0feaff	evisa	\N	Travelers holding a visa issued by the United States or a Schengen Member State together with a passport valid for a minimum of 3 months from the arrival date may enter visa free for a stay of up to 15 days	22261fda-846b-469f-9b85-fd70161f3508	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbab4bc3a4-7c19-4a94-905c-a7973e0feaff
1384	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	dfffd0b6-a252-421b-94cb-6d44695c5c8c	visa on arrival	90 days	\N	ac8c9ca3-0c22-451a-b9ce-6d7e4da0c204	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbdfffd0b6-a252-421b-94cb-6d44695c5c8c
1385	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	e98795b2-4086-41b5-bac1-4789d9aee005	visa not required	90 days	\N	436b9878-72bf-414d-b6ca-d5c4f15157e8	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbe98795b2-4086-41b5-bac1-4789d9aee005
1386	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	aae2ba87-a67d-43bd-8516-e403843d61d9	visa not required	90 days	90 days within 6-month period	5cd11af2-e811-49d7-81eb-35c37f94c7a5	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbaae2ba87-a67d-43bd-8516-e403843d61d9
1387	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	4998e162-96ca-4381-ab19-3dc43922884a	free visitor permit on arrival	3 mons	Extendable up to a year with a fee	07495647-a850-402f-807a-7c314e50104f	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db4998e162-96ca-4381-ab19-3dc43922884a
1388	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	d8df4bc3-503b-41ca-987e-423e41ecb52c	visa on arrival	30 days	\N	c5c06b30-5ed3-49f7-ada5-4326344c3170	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbd8df4bc3-503b-41ca-987e-423e41ecb52c
1389	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	2dd507e0-8e57-4924-a57f-8fc2e22555e2	visa not required	90 days	90 days within any 180-day period in the Schengen Area	088ae6f2-ee54-482d-af4a-a5f22f447176	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db2dd507e0-8e57-4924-a57f-8fc2e22555e2
1390	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	dbc583de-b4de-46ba-aae0-1e8d35054bf3	visa not required	90 days	90 days within any 180-day period in the Schengen Area	25290afa-6367-4422-9082-47fbfed43446	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbdbc583de-b4de-46ba-aae0-1e8d35054bf3
1391	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	b7f76500-4fa3-457f-aca8-477f05aab728	free visitor permit on arrival	3 mons	3 months within any year period	32c61715-e78d-442e-b265-3c3b532adf23	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbb7f76500-4fa3-457f-aca8-477f05aab728
1392	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	98943525-f93f-426f-a3fe-b48bc18c0c52	visa on arrival	\N	Visa is issued on arrival is available at Bosaso (BSA), Galcaio (GLK) and Mogadishu (MGQ) airports for a maximum stay of 30 days.	8c913dbf-f50a-4be9-b12a-bf69ef95a483	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db98943525-f93f-426f-a3fe-b48bc18c0c52
1393	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	247ff0fd-78ad-4ca4-90f2-f0394a714535	visa not required	90 days	\N	fca99e62-8813-4398-a3b8-28568e807567	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db247ff0fd-78ad-4ca4-90f2-f0394a714535
1394	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	3ffea3be-1c82-411a-b085-933205f900c7	visa required	\N	Foreign nationals of South Sudan origin can obtain a visa on arrival.	53763b96-b69a-4b0e-9be7-64c73db4a345	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db3ffea3be-1c82-411a-b085-933205f900c7
1395	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	02e5c743-3075-4226-8c1d-ad97dadda3d8	visa not required	90 days	90 days within any 180-day period in the Schengen Area	a5a0744d-6462-457a-a027-622ac3efbb33	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db02e5c743-3075-4226-8c1d-ad97dadda3d8
1396	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	6c6c9e3f-2353-431c-83c4-2c0cc6c42ff6	free visa on arrival	\N	Visas are issued on arrival free of charge with a validity of 30 days Extendible for another 150 days.	a7e48f49-921c-4441-bc43-847288f56627	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db6c6c9e3f-2353-431c-83c4-2c0cc6c42ff6
1397	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	c149c091-51c2-41d7-85a7-7d67bcac4230	visa required	\N	Pre-Approved Visa can be obtained on arrival.	8c25a885-c934-4964-af43-345fae0e2043	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbc149c091-51c2-41d7-85a7-7d67bcac4230
1398	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	e0e0a4c5-9076-4a1e-949f-9dd4521eb0f3	e tourist card	90 days	Multiple entry eVisa is also available.	219e7b2b-9743-4a8d-8176-b4fab214ac53	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbe0e0a4c5-9076-4a1e-949f-9dd4521eb0f3
1399	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	5c3dd764-6824-4689-a3e1-1d8c2dc3bc93	visa not required	90 days	90 days within any 180-day period in the Schengen Area	69e21e76-1b18-465e-ac00-2c1072925aac	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db5c3dd764-6824-4689-a3e1-1d8c2dc3bc93
1400	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	dacd5cdd-8e56-4067-bfd8-febc66a04058	visa not required	90 days	90 days within any 180-day period in the Schengen Area	747a2154-e4aa-4e98-bcf4-b149001c7c84	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbdacd5cdd-8e56-4067-bfd8-febc66a04058
1401	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	7073c668-a71d-4cf0-a8dd-71008877f8ca	visa required	\N	\N	95140e92-de8b-4fdf-be28-3d890eeeae31	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db7073c668-a71d-4cf0-a8dd-71008877f8ca
1402	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	893ca48d-0871-46b1-b299-4bf7e7c98dfa	visa on arrival	45 days	E-visa holders can enter through all border points. Application form must be completed online to obtain visa on arrival	c58faadc-5284-4eaa-a251-8efdd4f78be3	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db893ca48d-0871-46b1-b299-4bf7e7c98dfa
1403	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	1bf315d2-0a2d-4686-9ecb-6d28f8a5b861	visa not required	90 days	\N	bbca6ee9-271d-4764-b7d1-a5ee6eeac64c	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db1bf315d2-0a2d-4686-9ecb-6d28f8a5b861
1404	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	99d1c02c-0a04-4eae-b6cd-403f94e43959	visa not required	30 days	Maximum two visits annually if not arriving by air.	34a99d32-6370-4e59-92db-b9d07fbb4d38	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db99d1c02c-0a04-4eae-b6cd-403f94e43959
1405	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	1a61eb0b-45a3-4b91-89c2-c22a20676491	visa on arrival	30 days	Not available at all entry points but obtainable at Presidente Nicolau Lobato International Airport or at Dili Sea Port. Fee: Transit: USD20, tourist US$30: business US$50.	397cdb61-53a7-4c14-a14a-a53c877fdd12	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db1a61eb0b-45a3-4b91-89c2-c22a20676491
1406	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	1a7ba610-72c3-4816-81b5-aad9503a4a9b	visa on arrival	7 days	\N	e21955a4-5aa3-48f9-b265-126e14843949	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db1a7ba610-72c3-4816-81b5-aad9503a4a9b
1407	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	85e41f4f-c125-4753-bbed-c2ffc7e1c288	free visa on arrival	31 days	\N	173ddb59-b94a-4f76-960a-bdf5054eea95	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db85e41f4f-c125-4753-bbed-c2ffc7e1c288
1408	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	06659bc5-9958-457e-ac56-2860917a3d28	visa not required	\N	\N	b284a239-5514-4320-b629-5f61575d4e30	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db06659bc5-9958-457e-ac56-2860917a3d28
1409	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	cac7a781-be5d-4c59-b9b8-d8bb65fb1487	visa not required	3 mons	An exit fee of 30 Tunisian Dinars is required for non-residents exiting Tunisia.	aba7d49d-0de9-49c7-bfdd-c80b557fed25	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbcac7a781-be5d-4c59-b9b8-d8bb65fb1487
1410	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	fb99fe5c-118c-44d8-97ba-6570cdb7bd33	visa not required	3 mons	\N	69f5f1b0-7027-4e16-ac36-8b7d1d3b3098	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbfb99fe5c-118c-44d8-97ba-6570cdb7bd33
1411	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	0adc54bf-ff91-4cb0-8571-d89b779f1061	visa required	\N	\N	4f9e0cec-b268-470c-af5c-850881ca98ca	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db0adc54bf-ff91-4cb0-8571-d89b779f1061
1412	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	6596da04-74ae-4968-9776-6a7debe1b0aa	visa on arrival	1 mon	\N	e794b9e2-d0d5-4fa5-b24f-3484748a206b	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db6596da04-74ae-4968-9776-6a7debe1b0aa
1413	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	c5ce24da-dd58-4e8e-a5e3-91b478717bb4	visa not required	3 mons	\N	db03bdca-0f32-4746-be4e-5abd126a225a	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbc5ce24da-dd58-4e8e-a5e3-91b478717bb4
1414	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	6b63bb5b-0238-4263-bdf4-8064a4fb5c26	evisa	30 days	\N	6bafcd0f-8f5d-4af8-8118-30c52c9f5ea1	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db6b63bb5b-0238-4263-bdf4-8064a4fb5c26
1415	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	2b1a33fe-be25-452b-8a1c-c7d5f1dce9c2	free visa on arrival	\N	Visa on Arrival is issued free of charge for stays not exceeding 30 Days. Extension is possible for a fee.	86079ba8-a135-4885-a4ea-546b770a2a39	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db2b1a33fe-be25-452b-8a1c-c7d5f1dce9c2
1416	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	0f433ba9-47e1-4fe6-902c-632bf40355a9	visa not required	6 mons	\N	0d7c538d-0a70-4f30-be48-7dcb0396fb17	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db0f433ba9-47e1-4fe6-902c-632bf40355a9
1417	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	0bea6297-7d53-49a7-927e-e5cbc57e3b5a	visa waiver program	90 days	On arrival from overseas; ESTA (valid for 2 years when issued) required if arriving by air or cruise ship. ESTA is not required for Guam and Northern Mariana Islands.	49ae19ca-c631-4313-97f5-9783a05efd92	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db0bea6297-7d53-49a7-927e-e5cbc57e3b5a
1418	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	d95a4486-5ca4-4500-8b10-211b945552c8	visa not required	3 mons	\N	8ae9c03f-3f55-4008-9043-9c036408cce6	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbd95a4486-5ca4-4500-8b10-211b945552c8
1419	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	19c52566-e35f-44fd-8130-d64562928fe2	visa not required	30 days	\N	6ba869fb-6e9f-40a5-bbde-bd077ecec96c	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db19c52566-e35f-44fd-8130-d64562928fe2
1420	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	33f94df7-cd4f-487a-aa5c-fb45b65f19d5	visa not required	30 days	\N	c9fbe3b0-53d5-4890-add7-726304260b82	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db33f94df7-cd4f-487a-aa5c-fb45b65f19d5
1421	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	3af87d1b-0507-4bfc-b6a1-e9b91d57fe65	visa not required	\N	\N	0906805f-21ee-43fc-8f36-aa6f516b306d	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db3af87d1b-0507-4bfc-b6a1-e9b91d57fe65
1422	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	3a93a29d-abcc-45af-8915-8e983662c88a	visa required	\N	\N	bd9f4c5e-8c2a-4cbd-9ee0-94fa022144f5	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db3a93a29d-abcc-45af-8915-8e983662c88a
1423	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	ec48dda4-e153-4854-9bc3-453263e606b1	visa not required	30 days	\N	ac3bb862-c910-4363-8b22-8a41dc33c418	6e83ec38-7e2d-4c2d-8a9d-6991d4e876dbec48dda4-e153-4854-9bc3-453263e606b1
1424	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	9da8253b-a4dc-41f8-b8fa-e751b6812191	visa required	\N	\N	e71e68db-fe43-49f8-b86e-119fea6f688b	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db9da8253b-a4dc-41f8-b8fa-e751b6812191
1425	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	40fbcdb1-c386-45b7-946f-7e4190dcc02c	visa not required	90 days	\N	62a1e847-51b4-4bc1-adb2-74be3306e7a7	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db40fbcdb1-c386-45b7-946f-7e4190dcc02c
1426	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	39658cd7-be12-4512-8a90-0b2cc9b2769d	visa not required	3 mons	\N	2990f7b8-10a7-4169-b842-683ae5b15905	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db39658cd7-be12-4512-8a90-0b2cc9b2769d
\.


--
-- Data for Name: svg_path; Type: TABLE DATA; Schema: public; Owner: brook
--

COPY public.svg_path (id, uuid, territory, path) FROM stdin;
1	2dffdc3c-4b48-40eb-8dd9-13751ab729c3	b33be079-39b7-4a1d-b689-97c224d5fece	M1369.9 333.8h-5.4l-3.8-.5-2.5 2.9-2.1.7-1.5 1.3-2.6-2.1-1-5.4-1.6-.3v-2l-3.2-1.5-1.7 2.3.2 2.6-.6.9-3.2-.1-.9 3-2.1-1.3-3.3 2.1-1.8-.8-4.3-1.4h-2.9l-1.6-.2-2.9-1.7-.3 2.3-4.1 1.2.1 5.2-2.5 2-4 .9-.4 3-3.9.8-5.9-2.4-.5 8-.5 4.7 2.5.9-1.6 3.5 2.7 5.1 1.1 4 4.3 1.1 1.1 4-3.9 5.8 9.6 3.2 5.3-.9 3.3.8.9-1.4 3.8.5 6.6-2.6-.8-5.4 2.3-3.6h4l.2-1.7 4-.9 2.1.6 1.7-1.8-1.1-3.8 1.5-3.8 3-1.6-3-4.2 5.1.2.9-2.3-.8-2.5 2-2.7-1.4-3.2-1.9-2.8 2.4-2.8 5.3-1.3 5.8-.8 2.4-1.2 2.8-.7-1.4-1.9z
2	014172a2-3c5e-43a0-bdb2-242efecc7b3d	6c7e4e7d-9bf4-4e47-b2e4-c925f54bcd1a	M1077.5 300.5l-2 3.1.5 1.9 1 1-.5 1.9-.1 4.3.7 3 3 2.1.2 1.4 1 .4 2.1-3 .1-2.1 1.6-.9V312l-2.3-1.6-.9-2.6.4-2.1-.5-2.3-1.3-.6-1.3-1.6-1.3.5-.4-1.2z
3	1e143a00-c410-4629-8f94-82d126dd3f68	d9b8f8c8-5b5a-41ef-8538-26d822a4c9bd	M1021 336.9l-3.6.4-2.2-1.5h-5.6l-4.9 2.6-2.7-1-8.7.5-8.9 1.2-5 2-3.4 2.6-5.7 1.2-5.1 3.5 2 4.1.3 3.9 1.8 6.7 1.4 1.4-1 2.5-7 1-2.5 2.4-3.1.5-.3 4.7-6.3 2.5-2.1 3.2-4.4 1.7-5.4 1-8.9 4.7-.1 7.5v.4l-.1 1.2 20.3 15.5 18.4 13.9 18.6 13.8 1.3 3 3.4 1.8 2.6 1.1.1 4 6.1-.6 7.8-2.8 15.8-12.5 18.6-12.2-2.5-4-4.3-2.9-2.6 1.2-2-3.6-.2-2.7-3.4-4.7 2.1-2.6-.5-4 .6-3.5-.5-2.9.9-5.2-.4-3-1.9-5.6-2.6-11.3-3.4-2.6v-1.5l-4.5-3.8-.6-4.8 3.2-3.6 1.1-5.3-1-6.2 1-3.3z
4	290f878e-7aa3-4794-a762-4ba9fb903e62	1965c743-cf9a-4021-9ed1-b9e4e77486a2	M985.4 301.7l.1-.2.1-.2v-.1l-.2-.1-.7-.2-.3-.1-.2.1-.2.2-.1.3.1.1v.4l.1.2h.4l.3-.1.5-.3h.1z
5	3992b982-2f75-4c31-97c2-3b0959e51d37	bf07965f-f874-453e-a725-54c5a1254ee8	M1068.3 609.6l-16.6-.1-1.9.7-1.7-.1-2.3.9-.5 1.2 2.8 4 1.1 4.3 1.6 6.1-1.7 2.6-.3 1.3 1.3 3.8 1.5 3.9 1.6 2.2.3 3.6-.7 4.8-1.8 2.8-3.3 4.2-1.3 2.6-1.9 5.7-.3 2.7-2 5.9-.9 5.5.5 4 2.7-1.2 3.3-1 3.6.1 3.2 2.9.9-.4 22.5-.3 3.7 3 13.4.9 10.3-2.5-3.5-4-3.6-5.2.8-20.3 11.6.1-.5-2.2.9-2.4-.9-3 .7-3-.5-2-2.6-.4-3.5 1-2.4-.2-1.4.6.5-7.6-1.9-2.3-.3-4 .9-3.8-1.2-2.4v-4h-6.8l.5-2.3h-2.9l-.3 1.1-3.4.3-1.5 3.7-.9 1.6-3-.9-1.9.9-3.7.5-2.1-3.3-1.3-2.1-1.6-3.8-1.3-4.7zm-21.8-1.3l.2-2.7.9-1.7 2-1.3-2-2.2-1.8 1.1-2.2 2.7 1.4 4.8 1.5-.7z
6	63de0a20-90a7-45f5-ac4c-a35f4270a83a	793360a3-aa91-4703-acfe-60287e3f9b74	M627.9 456.2l.1-.2-.2-.1-.8.5v.1l.9-.3z
7	8f398793-99ed-494f-b8a6-dafd05e64407	90de1527-d5a5-446f-a960-eccda43af198	M634.3 463.8l.2-.1V463.4l-.1-.1-.1-.2-.4-.2-.5.5v.2l.1.3.6.1.2-.2zm.2-3.5v-.5l-.1-.2h-.3l-.1-.1h-.1l-.1.1.1.6.5.3.1-.2z
8	5bf1931c-1ff3-45a9-b38e-c9111a3d42ad	78219cc6-d1b2-4193-9da7-e7abc92863ee	M669.8 920.7l.9-3-7.3-1.5-7.7-3.6-4.3-4.6-3-2.8 5.9 13.5h5l2.9.2 3.3 2.1 4.3-.3zm-50.4-208.1l-7.4-1.5-4 5.7.9 1.6-1.1 6.6-5.6 3.2 1.6 10.6-.9 2 2 2.5-3.2 4-2.6 5.9-.9 5.8 1.7 6.2-2.1 6.5 4.9 10.9 1.6 1.2 1.3 5.9-1.6 6.2 1.4 5.4-2.9 4.3 1.5 5.9 3.3 6.3-2.5 2.4.3 5.7.7 6.4 3.3 7.6-1.6 1.2 3.6 7.1 3.1 2.3-.8 2.6 2.8 1.3 1.3 2.3-1.8 1.1 1.8 3.7 1.1 8.2-.7 5.3 1.8 3.2-.1 3.9-2.7 2.7 3.1 6.6 2.6 2.2 3.1-.4 1.8 4.6 3.5 3.6 12 .8 4.8.9 2.2.4-4.7-3.6-4.1-6.3.9-2.9 3.5-2.5.5-7.2 4.7-3.5-.2-5.6-5.2-1.3-6.4-4.5-.1-4.7 2.9-3.1 4.7-.1.2-3.3-1.2-6.1 2.9-3.9 4.1-1.9-2.5-3.2-2.2 2-4-1.9-2.5-6.2 1.5-1.6 5.6 2.3 5-.9 2.5-2.2-1.8-3.1-.1-4.8-2-3.8 5.8.6 10.2-1.3 6.9-3.4 3.3-8.3-.3-3.2-3.9-2.8-.1-4.5-7.8-5.5-.3-3.3-.4-4.2.9-1.4-1.1-6.3.3-6.5.5-5.1 5.9-8.6 5.3-6.2 3.3-2.6 4.2-3.5-.5-5.1-3.1-3.7-2.6 1.2-.3 5.7-4.3 4.8-4.2 1.1-6.2-1-5.7-1.8 4.2-9.6-1.1-2.8-5.9-2.5-7.2-4.7-4.6-1-11.2-10.4-1-1.3-6.3-.3-1.6 5.1-3.7-4.6z
9	5c86e876-91fb-4233-8177-4c3af1ef612f	f2f3e704-bb03-467a-a1a0-1d56b6faadce	M1219 325.1l-.9-4.4-2.5-1.1-2.5-1.7 1-2-3.1-2.2.7-1.5-2.2-1.1-1.4-1.7-6.9 1 1.3 2.2v3.1l4.2 1.5 2.4 1.9 1-.2 1.8 1.7h2.3l.2 1 2.8 3.7 1.8-.2z
10	dc4231f1-79a7-44d0-8557-8aa6d9caf0f1	0a3e548d-7e30-426f-840c-07ff9b6772f7	M1726.7 832l-3-.5-1.9 2.9-.6 5.4-2.1 4-.5 5.3 3 .2.8.3 6.6-4.3.6 1.7 4-4.9 3.2-2.2 4.5-7.3-2.8-.5-4.8 1.2-3.4.9-3.6-2.2zm50.1-172.3l.5-2.3.1-3.6-1.6-3.2.1-2.7-1.3-.8.1-3.9-1.2-3.2-2.3 2.4-.4 1.8-1.5 3.5-1.8 3.4.6 2.1-1.2 1.3-1.5 4.8.1 3.7-.7 1.8.3 3.1-2.6 5-1.3 3.5-1.7 2.9-1.7 3.4-4.1 2.1-4.9-2.1-.5-2-2.5-1.6h-1.6l-3.3-3.8-2.5-2.2-3.9-2-3.9-3.5-.1-1.8 2.5-3.1 2.1-3.2-.3-2.6 1.9-.2 2.5-2.5 2-3.4-2.2-3.2-1.5 1.2-2-.5-3.5 1.8-3.2-2-1.7.7-4.5-1.6-2.7-2.7-3.5-1.5-3.1.9 3.9 2.1-.3 3.2-4.8 1.2-2.8-.7-3.6 2.2-2.9 3.7.6 1.5-2.7 1.7-3.4 5.1.6 3.5-3.4-.6h-3.5l-2.5-3.8-3.7-2.9-2.8.8-2.6.9-.3 1.6-2.4-.7-.3 1.8-3 1.1-1.7 2.5-3.5 3.1-1.4 4.8-2.3-1.3-2.2 3.1 1.5 3-2.6 1.2-1.4-5.5-4.8 5.4-.8 3.5-.7 2.5-3.8 3.3-2 3.4-3.5 2.8-6.1 1.9-3.1-.2-1.5.6-1.1 1.4-3.5.7-4.7 2.4-1.4-.8-2.6.5-4.6 2.3-3.2 2.7-4.8 2.1-3.1 4.4.4-4.8-3.1 4.6-.1 3.7-1.3 3.2-1.5 1.5-1.3 3.7.9 1.9.1 2 1.6 5-.7 3.3-1-2.5-2.3-1.8.4 5.9-1.7-2.8.1 2.8 1.8 5-.6 5 1.7 2.5-.4 1.9.9 4.1-1.3 3.6-.3 3.6.7 6.5-.7 3.7-2.2 4.4-.6 2.3-1.5 1.5-2.9.8-1.5 3.7 2.4 1.2 4 4.1h3.6l3.8.3 3.3-2.1 3.4-1.8 1.4.3 4.5-3.4 3.8-.3 4.1-.7 4.2 1.2 3.6-.6 4.6-.2 3-2.6 2.3-3.3 5.2-1.5 6.9-3.2 5 .4 6.9-2.1 7.8-2.3 9.8-.6 4 3.1 3.7.2 5.3 3.8-1.6 1.5 1.8 2.4 1.3 4.6-1.6 3.4 2.9 2.6 4.3-5.1 4.3-2.1 6.7-5.5-1.6 4.7-3.4 3.2-2.5 3.7-4.4 3.5 5.2-1.2 4.7-4.4-.9 4.8-3.2 3.1 4.7.8 1.3 2.6-.4 3.3-1.5 4.9 1.4 4 4 1.9 2.8.4 2.4 1 3.5 1.8 7.2-4.7 3.5-1.2-2.7 3.4 2.6 1.1 2.7 2.8 4.7-2.7 3.8-2.5 6.3-2.7 6-.2 4.2-2.3.9-2 3-4.5 3.9-4.8 3.6-3.2 4.4-5.6 3.3-3.1 4.4-5 5.4-3.1 5-5.8 3.1-4.5 1.4-3.6 3.8-5.7 2.1-2.9 2.5-5.7-.7-5.4 1.7-3.9 1.1-3.7v-5.1l-2.8-5.1-1.9-2.5-2.9-3.9.7-6.7-1.5 1-1.6-2.8-2.5 1.4-.6-6.9-2.2-4 1-1.5-3.1-2.8-3.2-3-5.3-3.3-.9-4.3 1.3-3.3-.4-5.5-1.3-.7-.2-3.2-.2-5.5 1.1-2.8-2.3-2.5-1.4-2.7-3.9 2.4-1.2-5z
11	04fbc0b9-84d3-4248-b45d-4c708b903cdf	e14f7607-8074-4eeb-8b3f-3093575719a4	M1060.2 264l-2.3-1.2-2.3.3-4-1.9-1.7.5-2.6 2.5-3.8-2-1.5 2.9-1.7.8 1 4-.4 1.1-1.7-1.3-2.4-.2-3.4 1.2-4.4-.3-.6 1.6-2.6-1.7-1.5.3.2 1.1-.7 1.6 2.3 1.1 2.6.2 3.1.9.5-1.2 4.8-1.1 1.3 2.2 7.2 1.6 4.2.4 2.4-1.4 4.3-.1.9-1.1 1.3-4-1.1-1.3h2.8l.2-2.6-.7-2.1.3-.8z
12	fad59fba-d0e5-4341-b728-3a94d92ef2d1	319530a8-8cd2-4dc3-84a6-29ac720c51da	M1210.1 318.9l-1 .2 1.2 2.4 3.2 2.9 3.7.9-2.8-3.7-.2-1h-2.3l-1.8-1.7zm10.4-9.3l-4.3-3.8-1.5-.2-1.1.9 3.2 3.4-.6.7-2.8-.4-4.2-1.8-1.1 1 1.4 1.7 2.2 1.1-.7 1.5 3.1 2.2-1 2 2.5 1.7 2.5 1.1.9 4.4 5.3-4.7 1.9-.5 1.9 1.9-1.2 3.1 3.8 3.4 1.3-.3-.8-3.2 1.7-1.5.4-2.2-.1-5 4.2-.5-2-1.7-2.5-.2-3.5-4.5-3.4-3.2-2.6 2.5-.5 1.5-2.4-.4z
13	e8561dbe-f1d3-4e1a-b94c-5b2b3c0ed0e4	ac6434f1-bbb9-4242-a393-d78d367f034a	M574.4 437.3l.2-.6-.3-.1-.5.7-.6.3h-.3l-.7-.3h-.5l-.4.5-.6.1.1.1v.2l-.2.3v.2l.1.3 1.5-.1 1.3-.2.7-.9.2-.5zm.8-2l-.4-.3-.4.3.1.3.7-.3zm0-5.8l-.4-.2-.3.5.3.1.7-.1.5.1.5.4.3-.2-.1-.1-.4-.3-.6-.1h-.2l-.3-.1zm-6.6 1.3l.7-.6.7-.3.9-1.1-.1-.9.2-.4-.6.1-.1.3-.1.3.3.4v.2l-.2.4-.3.1-.1.2-.3.1-.4.5-.8.6-.2.3.4-.2zm1.2-3.2l-.6-.2-.2-.4-.4-.1-.1.2v.2l.1.4.2-.1.8.4.4-.3-.2-.1zm-4.1-1.1v-.7l-.4-.5-.6-.4-.1-1.2-.3-.7-.2-.6-.4-.8v.5l.1.1.1.6.4.9.1.4-.1.4-.4.1-.1.2.5.3.8.3.5 1.3.1-.2zm-4.1-3.5l-.5-.3-.2-.3-.7-.7-.3-.1-.2.4.4.1.9.7.4.2h.2zm7.3-4l-.1-.3h-.1l-.3.1-.3.9h.3l.5-.7zm-17.6-1.1l-.2-.3-.3.2h-.5l-.2.1h-.4l-.3.2.4.8.3.3.1 1 .2.1-.1.7 1.1.1.4-.8V418.6l-.3-.5-.4.6-.4-.3.6-.4v-.1zm12.9.3l-1-1.4v-.2l-.5-1.5-.3-.1-.1.1-.1.2.4.4v.4l.3.2.4 1.1.4.4-.1.3-.4.3-.1.2h.1l.6-.1h.4v-.3zm-10.5-5.2l.5-.2-.3-.2h-.7l-.4.1-.2.2.1.1.4.1.6-.1zm-2.4 2l-.5-.6-.3-.9-.2-.4.1-.5-.3-.4-.6-.4-.3.1.1 1.1-.2.6-.8 1.1.1.4.1.2-.5.4v-.3l-.6.1.3.5.6.4.3.1.3-.2v.5l.3.4.1.4.3-.3.6-.2.2-.2.7-.4v-.2l.1-.6.1-.7zm6.7-5l-.3-.5-.1.1-.1.4-.3.4.5-.1.4.1.6.5.7.2.3.6.6.6v.6l-.4.6-.1.7-.6.1.1.1.3.3.1.4.2.2v-.7l.3-.8.4-1.3-.1-.3-.3-.3-.7-.9-.7-.3-.8-.7zm-8.8-7.9l-.5-.4-.2.4v.1l-.1.3-.5.4-.5.1-.7-.6-.2-.1.8 1.1.3.1h.4l.9-.3 1.6-.5 1.7-.2.1-.2-.1-.3-.8.2-1-.1-.2.2h-.4l-.6-.2zm6.1 5.2l.2-.3.4-1.8.8-.6.1-1.2-.5-.5-.4-.2-.1-.2.1-.2-.2-.1-.3-.2-.4-.6-.4-.4-.7-.1-.6-.1-.4-.1-.5.3h.8l1.5.3.7 1.5.5.4.1.4-.2.4v.4l-.3.5-.1.8-.3.4-.7.5.4.2.3.6.2-.1z
44	da04bc7f-d947-4475-a917-a306014f04bc	0b48c87c-ddaa-49d2-b736-61d9c44636e0	M1217.8 499.2l-2.5-1.7 3.1-1.5.1-2.7-1.4-1.9-1.6 1.5-2.4-.5-1.9 2.8-1.8 3 .5 1.7.2 2 3.1.1 1.3-.5 1.3 1.1 2-3.4z
14	bbec18dc-74ab-4f0a-b76a-8d6f45dbef92	bb3fa754-b35e-45ee-8d66-fb159c96d821	M1486.5 431.9l-4.5-10.1-1.5.1-.2 4-3.5-3.3 1.1-3.6 2.4-.4 1.6-5.3-3.4-1.1-5 .1-5.4-.9-1.2-4.4-2.7-.4-4.8-2.7-1.2 4.3 4.6 3.4-3.1 2.4-.8 2.3 3.7 1.7-.4 3.8 2.6 4.8 1.6 5.2 2.2.6 1.7.7.6-1.2 2.5 1.3 1.3-3.5-.9-2.6 5.1.2 2.8 3.7 1.5 3.1.8 3.2 2 3.3-1.1-5.1 2.1 1-.5-4.6z
15	68f5e4de-a112-46db-b0fa-d130467224c6	49494a5b-205f-4756-9145-2784c9269a99	M644.9 488.9l.4-.4-.3-.3-.6-.8-.3.1v1l.1.3.5.3.2-.2z
16	27c68363-bf22-4d1d-8a2c-3ecb3b281642	ac612169-1567-4c5e-a203-3987fa26c267	M1112.8 219.4l-5.2-1.5-4.6 2.3-2.6 1 .9 2.6-3.5 2-.5 3.4-4.8 2.2h-4.6l.6 2.7 1.7 2.3.3 2.4-2.7 1.2 1.9 2.9.5 2.7 2.2-.3 2.4-1.6 3.7-.2 5 .5 5.6 1.5 3.8.1 2 .9 1.6-1.1 1.5 1.5 4.3-.3 2 .6-.2-3.1 1.2-1.4 4.1-.3-2-3.9-1.5-2 .8-.6 3.9.2 1.6-1.3-1.7-1.6-3.4-1.1.1-1.1-2.2-1.1-3.7-3.9.6-1.6-1-2.9-4.8-1.4-2.3.7-1-1.4z
17	57f5ae19-bc0e-4a62-950b-19c26ff53f1f	1f4dd261-dc57-49ec-b872-8b1917703616	M1000.7 246.2l-4.4 1.3-3.6-.5-3.8 1.2.7 2.2 2.2.1 2.4 2.4 3.4 2.9 2.5-.4 4.4 2.8.4-3.5 1.3-.2.4-4.2-2.8-1.4-3.1-2.7z
18	d2b654fe-248e-499b-8d28-b03815ed5ca1	3e62d48d-717d-4421-91c2-abb059a80576	M482.5 471.1l1.4-2.2 1-.2 1.3-1.7 1-3.2-.3-.6.9-2.3-.4-1 1.3-2.7.3-1.8h-1.1l.1-.9h-1l-2.5 3.9-.9-.8-.7.3-.1 1-.7 5-1.2 7.2h1.6z
19	f9aa6ed6-64c4-4e7d-99a5-1b1bfb547dc9	5fbebc32-e410-4faa-94e5-822252f8b499	M996.9 498l-4.3-3.7h-2l-1.9 1.9-1.2 1.9-2.7.6-1.2 2.8-1.9.7-.7 3.3 1.7 1.9 2 2.3.2 3.1 1.1 1.3-.2 14.6 1.4 4.4 4.6-.8.3-10.2-.1-4.1 1-4 1.7-1.9 2.7-4-.6-1.7 1.1-2.5-1.2-3.8.2-2.1z
20	6d722273-3cfa-4dfd-8436-9c2f2942daea	1d58bd18-8519-4e53-8cd1-6a7e93cda614	M1474.7 395.5l-2.7-1.8-2.9-.1-4.2-1.5-2.6 1.6-2.6 4.8.3 1.2 5.5 2.5 3.2-1 4.7.4 4.4-.2-.4-3.9-2.7-2z
21	b0c47e57-30b3-4af5-ac18-eb23e580d4f1	546440bf-236c-4f99-bd12-3bba52d50e02	M655.7 700.5l1.6-1.3-.8-3.6 1.3-2.8.5-5-1.6-4-3.2-1.7-.8-2.6.6-3.6-10.7-.3-2.7-7.4 1.6-.1-.3-2.8-1.2-1.8-.5-3.7-3.3-1.9-3.5.1-2.5-1.9-3.8-1.2-2.4-2.4-6.3-1-6.4-5.7.3-4.3-.9-2.5.4-4.7-7.3 1.1-2.8 2.3-4.8 2.6-1.1 1.9-2.9.2-4.2-.6 5.5 10.3-1.1 2.1.1 4.5.3 5.4-1.9 3.2 1.2 2.4-1.1 2.1 2.8 5.3-2.8 6.9 3.1 4.3 1.2 4.6 3.2 2.7-1.1 6.2 3.7 7.1 3.1 8.8 3.8-.9 4-5.7 7.4 1.5 3.7 4.6 1.6-5.1 6.3.3 1 1.3 1.5-7.6-.2-3.4 2.1-5.6 9.5-1.9 5.1.1 5.4 3.3.3 1.9z
22	e4f82956-d0b8-4ab7-8c0c-afce1d49747b	c103dabb-a386-4a6a-bce5-c0c0fa5f43f6	M1062.2 284.9l-2.3.1-1 1.3-1.9-1.4-.9 2.5 2.7 2.9 1.3 1.9 2.5 2.3 2 1.4 2.2 2.5 4.7 2.4.4-3.4 1.5-1.4.9-.6 1.2-.3.5-2.9-2.7-2.3 1-2.7h-1.8l-2.4-1.4-3.5.1-4.4-1z
23	6b68e101-0fa8-4ef6-8f33-d4c21093718a	ff4c5033-aee4-4325-90cc-1f96ef10bbce	M1116.7 685l-1-.5-3.2 1.5h-1.6l-3.7 2.5-2-2.6-8.6 2.2-4.1.2-.9 22.7-5.4.2-.6 18.5 1.4 1 3 6.1-.7 3.8 1.1 2.3 4-.7 2.8-2.8 2.7-1.9 1.5-3.1 2.7-1.5 2.3.8 2.5 1.8 4.4.3 3.6-1.5.6-2 1.2-3 3-.5 1.7-2.4 2-4.3 5.2-4.7 8-4.7-3.4-2.9-4.2-.9-1.5-4.1.1-2.2-2.3-.7-6-7-1.6-3.7-1.1-1.1-1.9-5.1z
24	3dc54d56-4d38-4cbd-a03a-729568601d10	1b558876-4f84-41fb-8215-93143842ba53	M659 560.1l-1.4.2-3.1-.5-1.8 1.7-2.6 1.1-1.7.2-.7 1.3-2.7-.3-3.5-3-.3-2.9-1.4-3.3 1-5.4 1.6-2.2-1.2-3-1.9-.9.8-2.8-1.3-1.5-2.9.3.7 1.8-2.1 2.4-6.4 2.4-4 1-1.7 1.5-4.4-1.6-4.2-.8-1 .6 2.4 1.6-.3 4.3.7 4 4.8.5.3 1.4-4.1 1.8-.7 2.7-2.3 1-4.2 1.5-1.1 1.9-4.4.5-3-3.4-1.1.8-1-3.8-1.6-2-1.9 2.2-10.9-.1v3.9l3.3.7-.2 2.4-1.1-.6-3.2 1v4.6l2.5 2.4.9 3.6-.1 2.8-2.2 17.4-5.1-.3-.7 1-4.6 1.2-6.2 4.3-.4 3-1.3 2.2.7 3.4-3.3 1.9.1 2.7-1.5 1.1 2.6 5.8 3.3 3.8-1 2.8 3.7.3 2.3 3.4 4.9.2 4.4-3.8.2 9.7 2.6.7 3-1.1 4.2.6 2.9-.2 1.1-1.9 4.8-2.6 2.8-2.3 7.3-1.1-.4 4.7.9 2.5-.3 4.3 6.4 5.7 6.3 1 2.4 2.4 3.8 1.2 2.5 1.9 3.5-.1 3.3 1.9.5 3.7 1.2 1.8.3 2.8-1.6.1 2.7 7.4 10.7.3-.6 3.6.8 2.6 3.2 1.7 1.6 4-.5 5-1.3 2.8.8 3.6-1.6 1.3 1.9 3.6.4 8.6 6 1.2 2.1-1.2 3.9 1.7 1.2 1.9 1 5.8.9 2.5 2 .3 2-1.1 2.1 1.2.3 3.5-.3 3.8-.7 3.6 2.6-1.2 3.1 3.7.5 5.1-4.2 3.5-3.3 2.6-5.3 6.2-5.9 8.6 3.4-.7 6.2 4.9 1.9-.2 6.2 4.1 4.8 3.5 3.8 4.3-1.9 3 2.1 3.7 2.9-3.7 1.5-6 3.2-3 3.9-5 4.5-11.2 3.4-3.5.8-3.1.3-6.4-1.3-3.5.3-4.8 4.1-6.3 6-5.1 6-1.8 3.6-2.9 8.5-2.4h5.9l1.1-3.8 4.2-2.8.6-6.5 5.1-8.3.5-8.5 1.6-2.6.3-4.1 1.1-9.9-1-11.9 1.4-4.7 1.4-.1 3.9-5.5 3.3-7.2 7.7-8.8 2.7-4.2 2-10.5-1-3.9-2-8.1-2.1-2-4.8-.2-4.3-1.9-7.3-7.1-8.4-5.3-8.4.3-10.9-3.4-6.5 2 .8-3.5-2.7-3.8-9.4-3.8-7.1-2.3-4.2 4.1-.3-6.3-9.9-1-1.7-2 4.2-5.2-.1-4.4-3-1-3-11.2-1.3-3.5-1.9.3-3.5 5.8-1.8 4.7-2.1 2.4-2.7.5-.8-1.8-1.2-.3-1.8 1.8-2.4-1.3-3.2-1.4-2.7.7-2.3-.6-.5 1.8.9 1.3-.5 1.3-3.1-.5z
25	7aed4496-ade5-4d53-b6fc-b499ed86a45f	dde93861-da65-40d4-8159-3e67e8d58e02	M1121.6 294.3l-3-.7-4-2.2-5.8 1.4-2.3 1.6-7.5-.3-4-1-1.9.5-1.8-2.6-1.1 1.4.7 2.3 2.8 2.6-1.7 1.9-.7 2 .6.7-.7.9 2.8 2 .8 4.1 3.8.2 3.9-1.7 3.9 2.1 4.6-.6-.3-3 5-2 4.5.8-2.1-3.5 1.3-4.4 2.2-2.5z
26	0ab17fe4-81ef-4288-8e46-6790615cb877	a22c7473-248e-4447-8bc7-1fc51c00ca3e	M978.8 477.2h-3.6l-1.4-1.2-3 .9-5.2 2.6-1.1 2-4.3 2.9-.8 1.6-2.3 1.3-2.7-.9-1.6 1.6-.8 4.4-4.5 5.2.2 2.2-1.6 2.7.4 3.7 2.5 1.4 1 2.1 2.5 1.3 1.9-1.6 2.7-.2 3.8 1.6-.8-4.8.2-3.6 9.7-.3 2.4.5 1.8-1 2.6.5 4.9.1 1.9-.7 1.2-2.8 2.7-.6 1.2-1.9.1-4.4-6.4-1.4-.2-3.1-3.1-4.1-.8-2.9.5-3.1z
27	00d31483-3064-418f-abf4-81eecbb6ef41	4f0fe689-81e0-4b91-a093-cad33a305482	M1148.2 590l-.3-2.5-3-.4-1.7 3.6-3.5-.5 1.4 2.9.1 1.1 2 6.1-.1.3.6-.1 2.1-2.3 2.2-3.3 1.4-1.4v-2l-1.2-1.5z
28	e986e333-2f29-4abf-ba73-01975e9357aa	723de35c-616a-4b10-b479-c08378f3765b	M1574.8 481.8l-5.2-2.3-2 4.3-4.9-2.4-5.3-1-7.1 1.3-3 5.2 2.1 7.7 3.4 6.6 2.6 3.3 4.7.9 4.7-2.5 5.8-.5-2.8-3.8 8.9-4.9-.1-7.7-1.8-4.2z
29	5a53a786-f37f-4aa6-8068-a267db13ca13	526f75ae-3c43-45a3-924e-1d7e11177a68	M1060.1 502.9l.2-4.3-.5-4.2-2.2-4.1-1.6.4-.2 2 2.3 2.6-.6 1.1-.3 2.1-4.6 5-1.5 4-.7 3.3-1.2 1.4-1.1 4.5-3 2.6-.8 3.2-1.2 2.6-.5 2.6-3.9 2.2-3.2-2.6-2.1.1-3.3 3.7-1.6.1-2.7 6.1-1.4 4.5v1.8l1.4.9 1.1 2.8 2.6 1.1 2.2 4.2-.8 5 9.2.2 2.6-.4 3.4.8 3.4-.8.7.3 7.1.3 4.5 1.7 4.5 1.5.4-3.5-.6-1.8-.3-2.9-2.6-2.1-2.1-3.2-.5-2.3-2.6-3.3.4-1.9-.6-2.7.4-5 1.4-1.1 2.7-6.5.9-1.7-1.8-4.4-.8-2.6-2.5-1.1-3.3-3.7 1.2-3 2.5.6 1.6-.4 3.1.1-3.1-5.8z
30	6cb48d99-4896-4346-8720-65c09e566f2b	e242cbe2-dc75-4807-a7c9-c171d164ec2d	M659 276.7l-.7-3-2.5 1.9.5 2.1 5.6 2.6 1.9-.4 3.3-2.5-4.7.1-3.4-.8zm14.4-15.9l.2-1.1-4.1-2.6-5.9-1.6-1.9.6 3.5 2.9 5.7 1.9 2.5-.1zm-305.3 3.7l.2-3.4-3.2-2.6-.4-2.9-.1-2.1-4.1-.7-2.4-.9-4.1-1.4-1.4 1.5-.6 3.3 4.3 1.1-.4 1.8 2.9 2.2v2.2l6.3 2.8 3-.9zM704.2 251l3.9-3.8 1.4-1.7-2.1-.3-4.9 2.2-4.2 3.5-8.1 9.8-5.3 3.7 1.6 1.7-3.8 2.2.2 1.9 9.6.1 5.4-.3 4.4 1.5-4.4 2.9 2.9.2 7.3-5.4 1.2.8-2.5 5.1 3 1.2 2.3-.2 3.5-5.5-.5-3.9.3-3.3-3.7 1.1 2.8-4.6-4.3-1.9-2.7 1.5-3.9-1.7 2.4-2.1-2.9-1.3-3.8 2 4.9-5.4zm-356.8-21.2l-1.9 2-1.4 2.6.9 1.9-.6 2.8.7 2.8h1.9l-.2-4.9 7.1-6.9-4.9.5-1.6-.8zm280.9-47l-.4-1.2-1.7-.1-2.8 1.7-.4.4.1 1.7 1.7.5 3.5-3zm-9.6-3.2l.8-1.1-6-.1-4.9 2.7v1.5l3 .2 7.1-3.2zm-3.1-16.6l-2.7-.5-5 5.2-3.6 4.4-5.7 2.8 6.3-.6-.8 3.4 8.2-3 6.2-3 .8 2.6 5.9 1.3 4.9-1.8-1.9-1.8-3.4.4 1.3-2.7-3.7-1.7-3.4-1.9-1.5-1.5-2.8.9.9-2.5zm44.6-8.2l3.7-1.7 1-.7 1.4-2.3-2.3-1.5-4.2.7-3.8 3.1-.7 2.6 4.9-.2zm-73.8-10.7l-.8-2-.3-1-1.6-1-3-1.5-4.9 2.3-5 1.7 3.5 2.4 3.8-.6 4.1 1.6 4.2-1.9zm22.4-2.1l-6.6-1 5.7-2.6-.4-6-1.9-2.3-4.5-.8-8.1 3.8-5.5 5.8 2.9 2.1 1.6 3.3-6.3 5.5-3.2-.2-6.2 4.4 4.2-5.2-4.8-1.8-4.5.9-2.4 3.4-5.9-.1-7.2.8-5.1-2.4-5 .4-1.5-2.9-2.1-1.3-3.8.5-5.2.3-4.4 1.8 2 2.3-7 2.8-1.4-3.3-4.4 1-11.8.6-6.4-1.2 8.5-2.6-2.8-2.8-4.4.4-4.7-1-7.5-1.9-3.8-2.3-4.5-.3-3.3 1.6-5.9.9 3.9-4.1-9.4 3.6-1.4-4.7-2.1-.6-3.8 2.5-4.5 1.2-.2-2.2-8.2 1.4-8.8 2.3-5.2-.6-7 1.6-6.2 2.3-3.7-.5-3.3-2.6-5.9-1.3-24.3 20.2-35.4 32.4 4.2.1 2.7 1.6.6 2.6.2 3.9 7.6-3.3 6.4-1.9-.5 3 .7 2.4 1.7 2.7-1.1 4.2-1.5 6.8 4.6 3.8-3.1 3.7-5.1 2.9-2.5 3.1 2.1 4.4-3.1 4.9 4.1 2.6-3.6 3.7-1.3 5.5 6.9 2.5 1.6 2.7 5.4 6.1h136.6l1.3-2.4h1.6l-.8 3.4 1 1 3.2.4 4.6 1 3.8 1.9 4.4-.8 5.3 1.6 3.2-2.4 3.2-1 1.8-1.5 1.5-.8 4 1.2 3.3.2.8.8.1 3.5 5.2 1-1.7 1.7 1.2 1.9-1.9 2.3 1.8.8-1.9 2.1 1.2.2 1.3-.9.5 1.4 3.4.7 3.8.1 3.8.6 4 1.2.8 2 1.4 4.7-2.4 2-3.8-.8-1-3.8-.9 3.9-3.8 3.4-.8 2.9-1.1 1.7-4.1 2-3.7 3.4-2 2.2 2.7.4 4.5-2 2.9-1.7 1.6-.3 2.6.6 1.7-.9 2.8-.8 4.7-.8.3-1.8-.3.1-1.7.3-1.8-.6 2.3-2.1 1.9-.7 3.9-.9 4.6-.9 1.8 1.2 1.9-1.4 1.9-.8.9.4.1.1 6.7-4.2 2.7-1.2h17l1-1.6 1.7-.3 2.5-.9 2.7-2.8 3.2-4.9 5.5-4.7 1.1 1.7 3.7-1.1 1.5 1.8-2.8 8.5 2.1 3.5 5.9-.8 8.1-.2-10.4 5.1-1.5 5.2 3.7.5 7.1-4.5 5.8-2.4 12.2-3.7 7.5-4.1-2.6-2.2 1-4.5-7.1 7-8.6.8-5.5-3.1-.1-4.6.6-6.8 6.1-4.1-3.3-3.1-7.6.6-12.1 5.2-10.9 8.2-4.6 1 7.8-5.7 10.1-8.3 7.2-2.7 5.7-4.4 5.2-.5 7.3.1 10 1.3 8.6-1 7.8-5.1 8.7-2.2 4.2-2.1 4.2-2.3 2-6.8-1.1-2.3-3.4-.8v-5.1l-2.3-1.9-6.9-1.6-2.8-3.4-4.8-3.4 3.4-3.7-2-7.1-2.6-7.5-1-5.2-4.3 2.7-7.4 6.5-8.1 3.2-1.6-3.4-3.7-1 2.2-7.3 2.6-4.9-7.7-.5-.1-2.2-3.6-3.3-3-2-4.5 1.5-4.2-.5-6.6-1.6-3.9 1.3-3.8 9-1 5.3-8.8 6.1 3.1 4.5.5 5-1.7 4-4.7 4.1-7.5 4.2-9 2.8 1.7 3.2-2.2 9.6-5.6 6.3-4.6 1.9-4.4-5.8-.1-6.8 1.7-6 3.6-5.2-4.8-.6-7.5-.4-3.6-2.5-4.8-1.6-1.7-2.9-3.3-2.2-7-2.6-7.1 1.2.7-4.5 1.5-5.5-6-1 4.9-6.8 4.9-4.6 9.4-6.5 8.6-4.6 5.6-.7 2.9-3.7 5.1-2.4 6.4-.4 7.7-3.8 2.9-2.4 7.4-4.7 3.2-2.8 3.2 1.7 6.5-.9L637 155l2.3-2.7-.8-2.9 5-2.9 1.7-2.7-3.5-2.6-5.4-.8-5.5-.4-4.6 5.9-6.5 4.6-7.2 4-1.3-3.7 4.2-4-2.2-3.5-8.7 4.2 4.3-5.5zm-75.5-18.9l-2.8-1-14.1 3.2-5.1 2-7.8 3.9 5.4 1.4 6.2-.1-11.5 2.1v1.9l5.6.1 9-.4 6.5 1.2-6.2 1-5.5-.3-7.1.9-3.3.6.6 4.2 4.2-.6 4.1 1.5-.3 2.5 7.8-.5 11.2-.8 9.4-1.8 5-.4 5.7 1.5 6.7.8 3.1-1.9-.7-2.1 7-.4 2.6-2.4-5-2.5-4.2-2.6 2.4-3.6 2.7-5.1-2.2-2-3-.9-4.2.8-2.8 5.3-4.3 2.1 2.2-5.1-1.7-1.7-7.3 2.7-2.6-2.6-10.4 1.5 4.7-2.4zm39.1-1.5l-1.7-1.1-5.4.2-2.1.7 2.2 3.6 7-3.4zm107.7 1.6l-4.4-2.8-8.4-.5-2.1.3-1.7 1.8 2 2.8.9.3 4.8-.7 4.1.1 4.1.1.7-1.4zm-39.4-.3l5.7-3.2-11.2 1.3-5.8 2.1-7.1 4.6-3.3 5.2 5.6.1-6.1 2.3 1.8 1.9 5.9.8 7.3 1.5 13.8 1.2 7.9-.6 3.2-1.6 2 1.8 3.3.3 2 3.3-3.5 1.4 7.1 1.8 4.6 2.6.5 1.9-.4 2.4-8.6 5.4-3.2 2.7.2 2-9.2.7-8 .1-5.4 4.2 2.4 1.9 13-.9.9-1.6 4.7 2.7 4.7 2.9-2.4 1.6 3.8 2.8 7.6 3.3 10.7 2.3.3-2-2.8-3.5-3.5-4.9 8.5 4.6 4.7 1.5 3.6-4.1v-5.6l-1-1.5-4.4-2.5-2.7-3.3 2.3-3.2 5.8-.7 3.8 5.4 4 2.4 10.7-6.5 3.3-3.9-6.4-.3-3.2-5.1-5.9-1.2-7.7-3.5 9-2.5-.8-5-2.2-2.1-8.3-2.1-1.9-3.3-8.2 1.2 1.1-2.3-3.6-2.5-6.8-2.6-5.2 2.1-9 1.5 3.3-3.4-2.3-5.3-11.6 2.1-7.1 4.1-.3-3.2zm-50-3.4l-7.1 2.4.9 3.4-7.4-.7-1.7 1.7 5.8 3.9.9 2 3.4.5 8.4-2 5.1-4.7-3.8-2.2 6-2.4.5-1.5-7.5.6-3.5-1zm22.3 5.4l5.6-1 10-4.5-6.1-1.2-7.8-.2-5.2 1.4-4.2 2.1-2.5 2.6-1.8 4.5 4.3.2 7.7-3.9zm-114.7 7.2l2.6-2.3 9.1-3.6 13.8-3.6 6.4-1.3-1.6-2.1-1.9-1.5-9.4-.2-4.1-1.1-14 .8-.3 3.1-7.6 3.3-7.4 3.8-4.3 2.2 5.9 2.7-.6 2.3 13.4-2.5zm124.1-18.3l.3-1.6-1.4-1.7-6.9 1.3-4.4 2.2 3.2 1.3 5.1.4 4.1-1.9zm-8.7-8.6l-1.1.7-4.8-.3-7.6 1.6-3.8-.1-4.3 3.8 6.6-.4-3.4 2.9 3.2.8 6.8-.5 5.8-3.7 2.8-2.5-.2-2.3zm-39.1 2.5l1.8-2.3-3.1-.5-5.7 1.7-.7 4.7-6.1-.4-2.8-2.9-8.2-1.6-5.4 1.4-11.6 4.8 4.1.8 17.8-.5-10.6 2.2-1.5 1.6 5.9-.1 12.2-2.2 13.8-.8 5.1-2.3 2.3-2.4-3.7-.2-4.3.8.7-1.8zm55.2-4.3l-7.1-.3-3.8 2 2.6 1.5 7 .6 1.4 2.1-2.2 2.4-1.5 2.8 8.5 1.6 5.5.6 8-.1 11.6-.8 4.3.6 6.7-1 3.5-1.4 1-2-2.3-1.9-5.8-.3-8 .4-7 1.1-5.1-.4-4.8-.3-1.2-1.1-3.1-1.1 2.8-1.9-1.4-1.6-7.3.1-2.3-1.6zm-75-2.6l-6 .7-5.5-.1-12.1 3.1-11.6 3.7 3.6 1 7-.7 9.8-2.1 3.8-.3 5.2-1.6 5.8-3.7zm80.5.6l1-.5-1.5-.9-7.2-.1-.6 1.3 6.4.3 1.9-.1zm-58.4-.8l3.2-1.4-4.1-.8-5.9.5-5.1 1.5 3.3 1.5 8.6-1.3zm7.8-4.2l-3.3-.9-1.6-.2-5.7 1.3-1 .7h6l5.6-.9zm46.4 2.5l3-1.7-2.3-1.6-1.7-.3-4.4-.1-2.1 1.8-.7 1.8 1.6 1.1 6.6-1zm-13.7-1.2l.1-2.2-7.4-1.7-6.1-.6-2.1 1.7 2.8 1.1-5.3 1.4 7.7.2 4 1.5 5.2.5 1.1-1.9zm53.7-6.1l.6-2.8-4.7-.8-4.7-.9-1.6-2.2-8.2.2.3.9-3.9.3-4.1 1.3-4.9 1.9-.3 1.9 2 1.5h6.5l-4.3 1.2-2.1 1.6 1.6 1.9 6.7.6 6.8-.4 10.5-3.4 6.4-1.3-2.6-1.5zm78.5-13.8l-7-.2-6.9-.3-10.2.6-1.4-.4-10.3.2-6.4.4-5.1.6-5 2-2.3-1-3.9-.2-6.7 1.4-7.4.6-4.1.1-6 .8-1.1 1.3 2.5 1.2.8 1.6 4.4 1.5 12.4-.3 7.2.5-7.2 1.5-2.2-.4-9.3-.2-1.1 2.2 3 1.7-2.8 1.6-7.5 1.1-4.9 1.7 4.8.9 1.7 3-7.5-2-2.5.3-2 3.4-8 1.1-2 2.3 6.7.3 4.9.6 11.7-.8 8.4 1.4 12.6-3 1-1.1-6.4.2.5-1.1 6.5-1.4 3.6-1.9 6.8-1.3 5-1.6-.8-2.2 3.3-.8-4.3-.6 11.1-.4 3.2-.9 7.9-.8 9.3-3.5 6.8-1.1 10.3-2.5h-7.4l3.9-.9 9-.8 9.7-1.6 1.1-1.1-5.2-1-6.7-.4-8.5-.3z
43	ae20d3f4-00cf-4231-a1bc-ea761ee3ba71	870d8300-9c56-4b34-9447-bcdfedf8454c	M1035.9 221.2l-1.7-3-6.7 2 .9 2.5 5.1 3.4 2.4-4.9zm-8.6-5.1l-2.6-.9-.7-1.6 1.3-2-.1-3-3.6 1.6-1.5 1.7-4 .4-1.2 1.7-.7 1.6.4 6.1 2.1 3.4 3.6.8 3-.9-1.5-3 3.1-4.3 1.4.7 1-2.3z
31	64c30568-8630-430d-93b1-420b667b3f7d	2b1aaccb-5846-45c1-8481-12bb8b5e0aa4	M1110.5 517.3l-.5-.3-2-1.8-.3-2 .8-2.6V508l-3.3-4-.7-2.7-3.5 1.1-2.8 2.5-4 7-5.2 2.9-5.4-.4-1.6.6.6 2.3-2.9 2.2-2.3 2.5-7.1 2.4-1.4-1.4-.9-.2-1 1.7-4.7.4-2.7 6.5-1.4 1.1-.4 5 .6 2.7-.4 1.9 2.6 3.3.5 2.3 2.1 3.2 2.6 2.1.3 2.9.6 1.8 2.9-5.9 3.3-3.4 3.8 1.1 3.6.4.5-4.5 2.2-3.2 3-2 4.6 2.1 3.6 2.4 4.1.6 4.2 1.2 1.6-3.8.8-.5 2.6.6 6.2-3.1 2.2 1.3 1.8-.2.9-1.5 2-.6 4.3.7 3.6.1 1.8-.6-.9-2.1-4.2-2.5-1.5-3.8-2.4-2.7-3.8-3.4-.1-2-3.1-2.6-3.8-2.5z
68	637737e0-2131-4948-aea8-75354f7ae559	f11d746c-8b82-4fe1-acb0-788067f0071c	M656.1 534.2l-2.1-2.3-2.9-3.1-2.1-.1-.1-3.3-3.3-4.1-3.6-2.4-4.6 3.8-.6 2.3 1.9 2.3-1.5 1.2-3.4 1.1v2.9l-1.6 1.8 3.7 4.8 2.9-.3 1.3 1.5-.8 2.8 1.9.9 1.2 3-1.6 2.2-1 5.4 1.4 3.3.3 2.9 3.5 3 2.7.3.7-1.3 1.7-.2 2.6-1.1 1.8-1.7 3.1.5 1.4-.2-3.3-5.6-.7-3.5-1.8-.1-2.4-4.6 1.1-3.3-.3-1.5 3.5-1.6 1-5.7z
32	d5c499f8-e668-4d6a-9b99-176279ac51c3	3f759fc5-8287-4acb-b58d-f235c5ef4981	M1108.4 447.6l-22.4-12.2-22.3-12.2-5.4 3.5 1.6 9.9 2 1.6.2 2.1 2.3 2.2-1.1 2.7-1.8 12.9-.2 8.3-6.9 6-2.3 8.4 2.4 2.3v4.1l3.6.2-.5 2.9 2.2 4.1.5 4.2-.2 4.3 3.1 5.8-3.1-.1-1.6.4-2.5-.6-1.2 3 3.3 3.7 2.5 1.1.8 2.6 1.8 4.4-.9 1.7 4.7-.4 1-1.7.9.2 1.4 1.4 7.1-2.4 2.3-2.5 2.9-2.2-.6-2.3 1.6-.6 5.4.4 5.2-2.9 4-7 2.8-2.5 3.5-1.1v-1.6l-2.1-1.8-.1-3.7-1.2-2.5-2 .4.5-2.4 1.4-2.6-.7-2.7 1.8-1.9-1.2-1.5 1.4-3.9 2.4-4.7 4.8.4-1.1-25.2z
33	6309ccb8-f591-4b55-8477-d8708214c7b1	c5a755fa-0935-4ec5-a880-3d4854beabfd	M648.4 905.2l-3.7-.7-3.3 2.5.2 4.1-1.2 2.8-7.2-2.2-8.6-4-4.5-1.3 9.7 6.8 6.3 3.2 7.5 3.4 5.3.9 4.3 1.8 3 .5 2.3.1 3.2-1.8.5-2.4-2.9-.2h-5l-5.9-13.5zm-47.3-196.3l-3.7-7.1 1.1-6.2-3.2-2.7-1.2-4.6-3.1-4.3-1.2 3.3-2.7 1.6 2.1 9 1.5 10.4-.1 14.2v13.2l.9 12.3-1.9 7.8 2.1 7.8-.5 5.3 3.2 9.5-.1 9.5-1.2 10.2-.6 10.5-2.1.2 2.4 7.3 3.3 6.3-1.1 4.3 1.9 11.6 1.5 8.8 3.5.9-1.1-7.7 4 1.6 1.8 12.7-6.4-2.1 2 10.2-2.7 5.5 8.2 1.8-3.4 4.8.2 6 5 10.6 4.2 4.1.2 3.6 3.3 3.8 7.5 3.5 7.4 4.2 6.2 2 2-.1-1.8-5.7 3.4-2.2 1.7-1.5h4.2l-4.8-.9-12-.8-3.5-3.6-1.8-4.6-3.1.4-2.6-2.2-3.1-6.6 2.7-2.7.1-3.9-1.8-3.2.7-5.3-1.1-8.2-1.8-3.7 1.8-1.1-1.3-2.3-2.8-1.3.8-2.6-3.1-2.3-3.6-7.1 1.6-1.2-3.3-7.6-.7-6.4-.3-5.7 2.5-2.4-3.3-6.3-1.5-5.9 2.9-4.3-1.4-5.4 1.6-6.2-1.3-5.9-1.6-1.2-4.9-10.9 2.1-6.5-1.7-6.2.9-5.8 2.6-5.9 3.2-4-2-2.5.9-2-1.6-10.6 5.6-3.2 1.1-6.6-.9-1.6-3.8.9-3.1-8.8z
34	df7c923d-cd2b-42c0-8cbe-9a385396635b	7178da96-360e-4b0a-ada4-9640c498daf8	M1587.2 453.3l.6-3.6 2-2.8-1.6-2.5-3.2-.1-5.8 1.8-2.2 2.8 1 5.5 4.9 2 4.3-3.1zm13.2-196.5l-6.1-6.1-4.4-3.7-3.8-2.7-7.7-6.1-5.9-2.3-8.5-1.8-6.2.2-5.1 1.1-1.7 3 3.7 1.5 2.5 3.3-1.2 2 .1 6.5 1.9 2.7-4.4 3.9-7.3-2.3.6 4.6.3 6.2 2.7 2.6 2.4-.8 5.4 1 2.5-2.3 5.1 2 7.2 4.3.7 2.2-4.3-.7-6.8.8-2.4 1.8-1.4 4.1-6.3 2.4-3.1 3.3-5.9-1.3-3.2-.5-.4 4 2.9 2.3 1.9 2.1-2.5 2-1.9 3.3-4.9 2.2-7.5.2-7.2 2.2-4.4 3.3-3.2-2-6.2.1-9.3-3.8-5.5-.9-6.4.8-11.2-1.3-5.5.1-4.7-3.6-4.9-5.7-3.4-.7-7.9-3.8-7.2-.9-6.4-1-3-2.7-1.3-7.3-5.8-5-8.1-2.3-5.7-3.3-3.3-4.4-1.7.5-1.8 4.2-3.8.6 2.5 6.2-1.6 2.8-10.7-2 1 11.1-2 1.4-9 2.4 8.7 10.7-2.9 1.6 1.7 3.5-.2 1.4-6.8 3.4-1 2.4-6.4.8-.6 4-5.7-.9-3.2 1.2-4 3 1.1 1.5-1 1.5 3 5.9 1.6-.6 3.5 1.4.6 2.5 1.8 3.7 1.4 1.9 4.7 3 2.9 5 9.4 2.6 7.6 7.5.8 5.2 3 3.3.6 3.3-4.1-.9 3.2 7 6.2 4 8.5 4.4 1.9-1.5 4.7 2 6.4 4.1 3.2.9 2.5 3.1 4.5 1.2 5 2.8 6.4 1.5 6.5.6 3-1.4 1.5 5.1 2.6-4.8 2.6-1.6 4.2 1.5 2.9.1 2.7 1.8 4.2-.8 3.9-4.8 5.3-4 4.9 1.5 3.2-2.6 3.5 3.9-1.2 2.7 6.1.9 3-.4 2.7 3.7 2.7 1.5 1.3 4.9.8 5.3-4.1 5.3.7 7.5 5.6-1 2.3 5.8 3.7 1.3-.8 5.2 4.5 2.4 2.5 1.2 3.8-1.8.6 2.6.7 1.5 2.9.1-1.9-7.2 2.7-1 2.7-1.5h4.3l5.3-.7 4.1-3.4 3 2.4 5.2 1.1-.2 3.7 3 2.6 5.9 1.6 2.4-1 7.7 2-.9 2.5 2.2 4.6 3-.4.8-6.7 5.6-.9 7.2-3.2 2.5-3.2 2.3 2.1 2.8-2.9 6.1-.7 6.6-5.3 6.3-5.9 3.3-7.6 2.3-8.4 2.1-6.9 2.8-.5-.1-5.1-.8-5.1-3.8-2-2.5-3.4 2.8-1.7-1.6-4.7-5.4-4.9-5.4-5.8-4.6-6.3-7.1-3.5.9-4.6 3.8-3.2 1-3.5 6.7-1.8-2.4-3.4-3.4-.2-5.8-2.5-3.9 4.6-4.9-1.9-1.5-2.9-4.7-1-4.7-4.4 1.2-3 5-.3 1.2-4.1 3.6-4.4 3.4-2.2 4.4 3.3-1.9 4.2 2.3 2.5-1.4 3 4.8-1.8 2.4-2.9 6.3-1.9 2.1-4 3.8-3.4 1-4.4 3.6 2 4.6.2-2.7-3.3 6.3-2.6-.1-3.5 5.5 3.6-1.9-3.1 2.5-.1-3.8-7.3-4.7-5.3 2.9-2.2 6.8 1.1-.6-6-2.8-6.8.4-2.3-1.3-5.6-6.9 1.8-2.6 2.5h-7.5l-6-5.8-8.9-4.5-9.9-1.9z
35	192e2e8b-db3a-49ab-8a9c-3ecda28c49e6	8b58bd46-c2d7-4df7-8871-378dbe921468	M578.3 497.2l1.2-2.1-1.3-1.7-2-.4-2.9 3.1-2.3 1.4-4.6 3.2-4.3-.5-.5 1.3-3.6.1-3.3 3-1.4 5.4-.1 2.1-2.4.7-4.4 4.4-2.9-.2-.7.9 1.1 3.8-1.1 1.9-1.8-.5-.9 3.1 2.2 3.4.6 5.4-1.2 1.6 1.1 5.9-1.2 3.7 2 1.5-2.2 3.3-2.5 4-2.8.4-1.4 2.3.2 3.2-2.1.5.8 2 5.6 3.6 1-.1 1.4 2.7 4.7.9 1.6-1 2.8 2.1 2.4 1.5 1.5-.6 3.7 3 1.8 3 2.7 1.7 3.4 6.7 4.2.8 3-1.7 2.1 1.1 3.3-.6 4.4 3-3.5 6.5 1.7.1 2.9 3.4 2.2-17.4.1-2.8-.9-3.6-2.5-2.4v-4.6l3.2-1 1.1.6.2-2.4-3.3-.7v-3.9l10.9.1 1.9-2.2 1.6 2 1 3.8 1.1-.8-1.7-6.4-1.4-2.2-2-1.4 2.9-3.1-.2-1.5-1.5-1.9-1-4.2.5-4.6 1.3-2.1 1.2-3.4-2-1.1-3.2.7-4-.3-2.3.7-3.8-5.5-3.2-.8-7.2.6-1.3-2.2-1.3-.6-.2-1.3.8-2.4-.4-2.5-1.1-1.4-.6-2.9-2.9-.5 1.8-3.7.9-4.5 1.8-2.4 2.2-1.8 1.6-3.2 3.7-1.1z
36	8d430460-3c9c-48e2-86b6-6529aa9ba773	48847459-b1b2-4092-9bf0-f0c08b928c74	M1221.1 650.5l-.4-.4h-.4v.2l.1.4 1.1.2-.4-.4zm3.9-1.5h-.1l-.2.1-.1.2-.1.3h-.9l.8.5.5.5.2.2.1-.2.1-.7-.3-.9zm-5.6-1.1l.2-.3-.2-.7-.4-.8.1-1.4-.2-.2h-.3l-.1.1-.1.3-.3 2 .4.6.3.1.5.4.1-.1z
37	a83767ad-4c34-42d7-a425-78a18e7461ad	196ed632-cc17-4b9f-87cb-cbc9832e8617	M1080.3 549.9l-3.6-.4-3.8-1.1-3.3 3.4-2.9 5.9-.4 3.5-4.5-1.5-4.5-1.7-7.1-.3-.4 2.8 1.5 3.3 4.2-.5 1.4 1.2-2.4 7.4 2.7 3.8.6 4.9-.8 4.3-1.7 3-4.9-.3-3-3-.5 2.8-3.8.8-1.9 1.6 2.1 4.2-4.3 3.5 4.6 6.7 2.2-2.7 1.8-1.1 2 2.2 1.5.6 1.9-2.4 3.1.1.4 1.8 2 1.1 3.4-4 3.3-3.1 1.4-2-.2-5.3 2.5-6.2 2.6-3.2 3.7-3.1.6-2 .2-2.4.9-2.2-.3-3.6.7-5.6 1.1-4 1.6-3.4.3-3.8z
38	9a6b0249-385f-4b5a-9e2b-f862c1bd604b	cf56f0da-daf4-4437-9ad9-4b61bbedc31a	M509.1 502.6l-1.4 1.3-1.7-.4-.8-1.3-1.7-.5-1.4.8-3.5-1.7-.9.8-1.4 1.2 1.5.9-.9 2-.1 2 .7 1.3 1.7.6 1.2 1.8 1.2-1.6-.3-1.8 1.4 1.1.3 1.9 1.9.8 2.1 1.3 1.5 1.5.1 1.4-.7 1.1 1.1 1.3 2.9 1.4.4-1.2.5-1.3-.1-1.2.8-.7-1.1-1 .1-2.5 2.2-.6-2.4-2.7-2-2.6-1.2-3.4z
39	3d4110dd-b128-4d66-9900-410edf1fa1ae	14730d5f-e0e5-43a8-bc67-ca9f92c8502a	M1065 280.4l-4-2.6-1.6-.8-3.9 1.7-.3 2.5-1.7.6.2 1.7-2-.1-1.8-1-.8 1-3.5-.2-.2.1v2.2l1.7 2 1.3-2.6 3.3 1 .3 2 2.5 2.6-1 .5 4.6 4.5 4.8 1.8 3.1 2.2 5 2.3.5-1-4.7-2.4-2.2-2.5-2-1.4-2.5-2.3-1.3-1.9-2.7-2.9.9-2.5 1.9 1.4 1-1.3 2.3-.1 4.4 1 3.5-.1 2.4 1.4 1.7-2.3-1.7-1.8-1.5-2.4-1.8.9-4.2-1.2z
40	f4bd136c-7894-4d10-90c8-6b6b7e66431d	16a55dd1-2e47-489d-830c-3a88aad464a9	M539 427.3l-4.9-2.1-4.3-.1-4.7-.5-1.4.7-4.2.6-3 1.3-2.7 1.4-1.5 2.3-3.1 2 2.2.6 2.9-.7.9-1.6 2.3-.1 4.4-3.3 5.4.3-2.3 1.6 1.8 1.3 7 1 1.5 1.3 4.9 1.7 3.2-.2.8 3.6 1.7 1.8 3.5.4 2.1 1.7-4.1 3.5 7.9-.6 3.8.5 3.7-.3 3.8-.8.8-1.5-3.9-2.6-4-.3.6-1.7-3.1-1.3h-1.9l-3-2.8-4.2-4-1.8-1.5-5.2.8-1.9-2.4z
41	b03ab799-2b41-447f-9b75-2f9627247f3c	f36ec987-ed66-4a88-9157-b1d4a934e515	M1149.9 348.4l-.3-.1-.5.2-.4.4-.4.3-.5-.3.2.9.6 1.1.2.3.3.2 1.1.3H1151.1l.2.1.2.4h.4v-.4l.2-.2.3-.2h.3l.6-.1.6-.2.5-.4.9-1h1.2l.6-.1-.2-.4-.1-.1-.4-.5-.2-.4.1-.6 2.5-1.9.5-.5-.8.2-.6.4-.4.2-.7.4-2.3.8-.8.1h-.8l-1-.1-.9-.2v.7l-.2.6-.6.2-.3-.1z
42	ecacd104-b833-489e-8480-e83caccc5d90	c5db5d6b-ebcd-4642-9604-0f1ebf2fdf9d	M1049.4 248.5l-2.1.6-1.4-.7-1.1 1.2-3.4 1.2-1.7 1.5-3.4 1.3 1 1.9.7 2.6 2.6 1.5 2.9 2.6 3.8 2 2.6-2.5 1.7-.5 4 1.9 2.3-.3 2.3 1.2.6-1.4 2.2.1 1.6-.6.1-.6.9-.3.2-1.4 1.1-.3.6-1.1h1.5l-2.6-3.1-3.6-.3-.7-2-3.4-.6-.6 1.5-2.7-1.2.1-1.7-3.7-.6-2.4-1.9z
45	20d72a9e-a97a-4cf6-8b0b-9203bce45ce2	a66c6aaf-f010-4056-8928-1653d670edf3	M635.8 475.1l.3-.7-.1-1-.2-.4-.8-.3v.2l-.1.5.3.8.1 1.1.5-.2z
46	401ba406-74e0-45db-b529-bdf52f493928	7caae20c-20fa-4ce0-a987-cca304a302b9	M579.6 457.4v1.8l1.4 1 2.6-4.4 2-.9.6 1.6 2.2-.4 1.1-1.2 1.8.3 2.6-.2 2.5 1.3 2.3-2.6-2.5-2.3-2.4-.2.3-1.9-3 .1-.8-2.2-1.4.1-3.1-1.6-4.4-.1-.8 1.1.2 3.5-.7 2.4-1.5 1.1 1.2 1.9-.2 1.8z
69	db111182-967f-4e2d-85d0-391ecf33da28	99530f46-46c4-4263-bd88-dca23dc0383f	M580.6 446.7l-4.6-1-3.4-.2-1.4 1.7 3.4 1-.3 2.4 2.2 2.8-2.1 1.4-4.2-.5-5-.9-.7 2.1 2.8 1.9 2.7-1.1 3.3.4 2.7-.4 3.6 1.1.2-1.8-1.2-1.9 1.5-1.1.7-2.4-.2-3.5z
70	cf9d56f8-5f73-4d5a-8b5a-57c5b1f0807a	3e33cfe7-603b-4d88-a6e3-f4dcc331d9f2	M514.1 476.8l-1.3-1.8-1.9-1-1.5-1.4-1.6-1.2-.8-.1-2.5-.9-1.1.5-1.5.2-1.3-.4-1.7-.4-.8.7-1.8.7-2.6.2-2.5-.6-.9.4-.5-.6-1.6.1-1.3 1.1-.6-.2-2.8 2.4-2.8 1.8-.5 1.2.3 1.3-1.3 1.6 1.5.5 1.1 1.3 1.6 1 .1.9 2.5-.8 1.1.5.7.7-.6 2.5 1.7.6.7 2 1.8-.3.8-1.5h.8l.2-3.1 1.3-.2h1.2l1.4-1.7 1.5 1.3.6-.8 1.1-.7 2.1-1.8.3-1.3.5.1.8-1.5.6-.2.9.9 1.1.3 1.3-.8h1.4l2-.8.9-.9 1.9.2z
47	5108dd92-d183-4bae-8613-de41d506e404	80b3fc54-1fa6-49c6-ac4c-998b002d754f	M1124.9 539.4l-4.3-.7-2 .6-.9 1.5-1.8.2-2.2-1.3-6.2 3.1-2.6-.6-.8.5-1.6 3.8-4.2-1.2-4.1-.6-3.6-2.4-4.6-2.1-3 2-2.2 3.2-.5 4.5-.3 3.8-1.6 3.4-1.1 4-.7 5.6.3 3.6-.9 2.2-.2 2.4-.6 2-3.7 3.1-2.6 3.2-2.5 6.2.2 5.3-1.4 2-3.3 3.1-3.4 4-2-1.1-.4-1.8-3.1-.1-1.9 2.4-1.5-.6-2 1.3-.9 1.7-.2 2.7-1.5.7.8 2 2.3-.9 1.7.1 1.9-.7 16.6.1 1.3 4.7 1.6 3.8 1.3 2.1 2.1 3.3 3.7-.5 1.9-.9 3 .9.9-1.6 1.5-3.7 3.4-.3.3-1.1h2.9l-.5 2.3h6.8v4l1.2 2.4-.9 3.8.3 4 1.9 2.3-.5 7.6 1.4-.6 2.4.2 3.5-1 2.6.4 1.9.1.3 2 2.6-.1 3.5.6 1.8 2.8 4.5.9 3.4-2 1.2 3.4 4.3.8 2 2.8 2.1 3.5h4.3l-.3-6.9-1.5 1.2-3.9-2.5-1.4-1.1.8-6.4 1.2-7.5-1.2-2.8 1.6-4.1 1.6-.7 7.5-1.1 1 .3.2-1.1-1.5-1.7-.7-3.5-3.4-3.5-1.8-4.5 1-2.7-1.5-3.6 1.1-10.2.1.1-.1-1.1-1.4-2.9.6-3.5.8-.4.2-3.8 1.6-1.8.1-4.8 1.3-2.4.3-5.1 1.2-3 2.1-3.3 2.2-1.7 1.8-2.3-2.3-.8.3-7.5-5-4.2-1.4-2.7-3.1 1.3-2.6-.4-1.5 1.1-2.5-.8-3.5-5.2-1.8.6-3.6-.1z
48	1ec96175-b401-436e-b909-1167c5add211	41fa1fc8-a7c9-4045-ac6a-92fe36c27bd9	M553.1 573.1l-2.4-1.5-2.8-2.1-1.6 1-4.7-.9-1.4-2.7-1 .1-5.6-3.6-3.9 2.5-3.1 1.4.4 2.6-2.2 4.1-1 3.9-1.9 1 1 5.8-1.1 1.8 3.4 2.7 2.1-2.9 1.3 2.8-2.9 4.7.7 2.7-1.5 1.5.2 2.3 2.3-.5 2.3.7 2.5 3.2 3.1-2.6.9-4.3 3.3-5.5 6.7-2.5 6-6.7 1.7-4.1-.8-4.9z
49	aedaac41-77b0-407c-b5ac-39f416b4c7bb	0d0a18fd-d424-4a69-b646-38fffd942dd5	M1129.7 374.8l-5.5-1.9-5.3-1.7-7.1.2-1.8 3 1.1 2.7-1.2 3.9 2 5.1 1.3 22.7 1 23.4h65.3l-1-1.3-6.8-5.7-.4-4.2 1-1.1-5.3-7-2-3.6-2.3-3.5-4.8-9.9-3.9-6.4-2.8-6.7.5-.6 4.6 9.1 2.7 2.9 2 2 1.2-1.1 1.2-3.3.7-4.8 1.3-2.5-.7-1.7-3.9-9.2-2.5 1.6-4.2-.4-4.4-1.5-1.1 2.1-1.7-3.2-3.9-.8-4.7.6-2.1 1.8-3.9 2-2.6-1z
50	1de6ba26-9f55-49fd-8d6d-12c1dab4cbea	bae2df87-ee9b-4efe-8482-2b05b54ebb11	M487.2 487l.6-2.5-.7-.7-1.1-.5-2.5.8-.1-.9-1.6-1-1.1-1.3-1.5-.5-1.4.4.2.7-1.1.7-2.1 1.6-.2 1 1.4 1.3 3.1.4 2.2 1.3 1.9.6 3.3.1.7-1.5z
51	907d73c0-7ac7-40d8-97a8-f6beea1a4f4a	43d35de8-4ed4-4bd7-9fce-54d9adcdeec6	M1040.1 557.8l-9.2-.2-1.9 7.2 1 .9 1.9-.3h8.2v-7.6z
52	b0b55df8-74e3-48df-8a8b-de07322a085d	b2db2210-e9b8-4d51-b3c0-ed8e3d6adc9b	M1198.1 474l-3.2-3.1-1.8-5.9-3.7-7.3-2.6 3.6-4 1-1.6 2-.4 4.2-1.9 9.4.7 2.5 6.5 1.3 1.5-4.7 3.5 2.9 3.2-1.5 1.4 1.3 3.9.1 4.9 2.5 1.6 2.2 2.5 2.1 2.5 3.7 2 2.1 2.4.5 1.6-1.5-2.8-1.9-1.9-2.2-3.2-3.7-3.2-3.6-7.9-6z
53	40f1c65a-544a-407e-9569-a1723f4fcc24	061c7757-87bb-4acc-bfb5-ebb5a4dc9429	M1093.2 197.5l-5.5.9-5.4 1.6.9 3.4 3.3 2.1 1.5-.8.1 3.5 3.7-1 2.1.7 4.4 2.2h3.8l1.6-1.9-2.5-5.5 2.6-3.4-.9-1-4.6.2-5.1-1z
54	a873e5b1-fe19-4da3-a6cf-fbe471364955	f76a50d7-c955-4658-a2da-f191b746b434	M1187.6 477l-1.5 4.7-6.5-1.3-.7 5.5-2.1 6.2-3.2 3.2-2.3 4.8-.5 2.6-2.6 1.8-1.4 6.7v.7l.2 5-.8 2-3 .1-1.8 3.6 3.4.5 2.9 3.1 1 2.5 2.6 1.5 3.5 6.9 2.9 1.1v3.6l2 2.1h3.9l7.2 5.4h1.8l1.3-.1 1.2.7 3.8.5 1.6-2.7 5.1-2.6 2.3 2.1h3.8l1.5-2 3.6-.1 4.9-4.5 7.4-.3 15.4-19.1-4.8.1-18.5-7.6-2.2-2.2-2.1-3.1-2.2-3.5 1.1-2.3-1.3-1.1-1.3.5-3.1-.1-.2-2-.5-1.7 1.8-3 1.9-2.8-2-2.1-2.5-3.7-2.5-2.1-1.6-2.2-4.9-2.5-3.9-.1-1.4-1.3-3.2 1.5-3.5-2.9z
55	6af2dde8-4b27-419a-b5bf-827f3f7986b6	923566be-1a81-4281-a9f5-fc3d8e59e53e	M1976.7 674.4l-3.7 2-1.9.3-3.1 1.3.2 2.4 3.9-1.3 3.9-1.6.7-3.1zm-11 8.1l-1.6 1-2.3-.8-2.7 2.2-.2 2.8 2.9.8 3.6-.9 1.8-3.3-1.5-1.8z
56	b60a5dc2-5996-4a5d-aaa7-4d0347874bc8	d322fe64-203a-4eb4-8316-2c6c1af401a3	M1093.4 144.4l.8-3.8-5.7-2.1-5.8 1.8-1.1 3.9-3.4 2.4-4.7-1.3-5.3.3-5.1-2.9-2.1 1.4 5.9 2.7 7.2 3.7 1.7 8.4 1.9 2.2 6.4 2.6.9 2.3-2.6 1.2-8.7 6.1-3.3 3.6-1.5 3.3 2.9 5.2-.1 5.7 4.7 1.9 3.1 3.1 7.1-1.2 7.5-2.1 8-.5 7.9-7.4 3.3-3.3.9-2.9-7.3-3.9.9-3.7-4.9-4.1 1.7-4.8-6.4-6.3 2.8-4.1-7.2-3.7-.4-3.7z
57	3ee30f00-52e0-4bf9-84f8-ffea4778bab4	b7b802fe-8789-4b6d-b085-7c25a92dab7b	M1025.7 303.8l-1.1-5.2-3.2 2.3-1 2.3 1.4 4.2 2.4 1.2 1.5-4.8zm-31.5-50.9l-2.4-2.4-2.2-.1-.7-2.2-4.3 1.2-1.4 5.1-11.3 4.8-4.6-2.6 1.4 7-8.2-1.6-6.4 1.3.4 4.6 7.5 2.4 3.6 3.1 5.1 6.5-1 12.3-2.7 3.7 2 2.4 9.4 2.8 1.9-1.3 5.7 2.8 6-.8.5-3.7 7.4-2 10 1.6 4.5-3.4.5-2.7-2.7-.8-1.5-4.8 1.7-1.8-1.6-2.4.2-1.7-1.8-2.7-2.4.9v-2.8l3.5-3.5-.2-1.6 2.3.6 1.3-1 .5-4.5 2.3-4.2-7.1-1.2-2.4-1.6-1.4.1-1.1-.5-4.4-2.8-2.5.4-3.4-2.9z
58	56421cb7-aaf9-48c6-84a0-35eba399ae67	6a95dca7-5bc9-438d-ba51-5cc4603d70a4	M1050.2 557.7l-.7-.3-3.4.8-3.4-.8-2.6.4v7.6h-8.2l-1.9.3-1.1 4.8-1.3 4.6-1.3 2-.2 2.1 3.4 6.6 3.7 5.3 5.8 6.4 4.3-3.5-2.1-4.2 1.9-1.6 3.8-.8.5-2.8 3 3 4.9.3 1.7-3 .8-4.3-.6-4.9-2.7-3.8 2.4-7.4-1.4-1.2-4.2.5-1.5-3.3.4-2.8z
59	01035583-ce05-4b15-af1c-3f8f0533e2f8	81e9890e-9239-4c33-b429-66950b214814	M882.8 488.5l5 .1 1.4-.9h1l2.1-1.5 2.4 1.4 2.4.1 2.4-1.5-1.1-1.8-1.8 1.1-1.8-.1-2.1-1.5-1.8.1-1.3 1.5-6.1.2-.7 2.8z
60	7c8da5d6-22b4-4b3a-a05c-c85061c397df	f2e17057-cb16-4fd3-92ef-07a6320c1818	M1200 300.2l-7.5-2.9-7.7-1-4.5-1.1-.5.7 2.2 1.9 3 .7 3.4 2.3 2.1 4.2-.3 2.7 5.4-.3 5.6 3 6.9-1 1.1-1 4.2 1.8 2.8.4.6-.7-3.2-3.4 1.1-.9-3.5-1.4-2.1-2.5-5.1-1.3-2.9 1-1.1-1.2z
61	10059cf8-1a63-4e14-a928-79c96003798b	d80301ed-7cdc-4f2c-8093-cfec014b077a	M1043.6 232.3l-2.4-1.9-5.5-2.4-2.5 1.7-4.7 1.1-.1-2.1-4.9-1.4-.2-2.3-3 .9-3.6-.8.4 3.4 1.2 2.2-3 3-1-1.3-3.9.3-.9 1.3 1 2-1 5.6-1.1 2.3h-2.9l1.1 6.4-.4 4.2 1 1.4-.2 2.7 2.4 1.6 7.1 1.2-2.3 4.2-.5 4.5h4.2l1-1.4 5.4 1.9 1.5-.3 2.6 1.7.6-1.6 4.4.3 3.4-1.2 2.4.2 1.7 1.3.4-1.1-1-4 1.7-.8 1.5-2.9-2.9-2.6-2.6-1.5-.7-2.6-1-1.9 3.4-1.3 1.7-1.5 3.4-1.2 1.1-1.2 1.4.7 2.1-.6-2.3-3.9.1-2.1-1.4-3.3-2-2.2 1.2-1.6-1.4-3.1z
62	3ee9477d-cfce-42fa-bd74-94f59a295bad	53618499-ed33-49f9-aeae-e24d02029f1e	M976.8 502.1l-2.6-.5-1.8 1-2.4-.5-9.7.3-.2 3.6.8 4.8 1.4 9.1-2.3 5.3-1.5 7.2 2.4 5.5-.2 2.5 5 1.8 5-1.9 3.2-2.1 8.7-3.8-1.2-2.2-1.5-4-.4-3.2 1.2-5.7-1.4-2.3-.6-5.1.1-4.6-2.4-3.3.4-1.9z
77	d9cb4c2a-f88f-49be-b1e8-eb30b62f0907	48d25a4f-6bcb-4595-bf82-1492334695ec	M947.3 231.7l-3.5-1.3-2.9.1 1.1-3.2-.8-3.2-3.7 2.8-6.7 4.7 2.1 6.1-4.2 6.4 6.7.9 8.7-3.6 3.9-5.4-.7-4.3z
63	ad60bcb9-e524-4ef1-b096-a015aeadb964	1a76eb8a-5fca-4552-a0dd-9728217998b0	M1101.9 344.9l-.8 2.8 6.6 1.2v1.1l7.6-.6.5-1.9-2.8.8v-1.1l-3.9-.5-4.1.4-3.1-2.2zm11.5-37.4l-2.7-1.6.3 3-4.6.6-3.9-2.1-3.9 1.7-3.8-.2-1 .2-.7 1.1-2.8-.1-1.9 1.3-3.3.6v1.6l-1.6.9-.1 2.1-2.1 3 .5 1.9 2.9 3.6 2.3 3 1.3 4.3 2.3 5.1 4.6 2.9 3.4-.1-2.4-5.7 3.3-.7-1.9-3.3 5 1.7-.4-3.7-2.7-1.8-3.2-3 1.8-1.4-2.8-3-1.6-3.8.9-1.3 3 3.2h2.9l2.5-1-3.9-3.6 6.1-1.6 2.7.6 3.2.2 1.1-.7 1.2-3.9z
64	0565b2b7-a1ad-47f2-91ce-87f110d35765	aedfe3b8-fc01-41f8-a152-516e139dc8b6	M632.1 495.7l.5-.2.2-1.1-.3-.1-.3.3-.3.5v.4l-.2.3.4-.1z
65	8231e540-d619-4ed4-91b4-d250951f8f94	0e291c7e-51a2-466f-94b9-de8d9dec9dd2	M482.8 458.9l-5.1-.1h-5.2l-.4 3.6h-2.6l1.8 2.1 1.9 1.5.5 1.4.8.4-.4 2.1H467l-3.3 5.2.7 1.2-.8 1.5-.4 1.9 2.7 2.6 2.5 1.3 3.4.1 2.8 1.1.2-1 2.1-1.6 1.1-.7-.2-.7 1.4-.4 1.3-1.6-.3-1.3.5-1.2 2.8-1.8 2.8-2.4-1.5-.8-.6.9-1.7-1.1h-1.6l1.2-7.2.7-5z
66	b132dc95-978f-4486-9873-0699ffc072f1	98fd5d7d-6f4c-434d-bd97-6fabe502db00	M900.2 492.1l-10.3-.3-1.5.7-1.8-.2-3 1.1.3 1.3 1.7 1.4v.9l1.2 1.8 2.4.5 2.9 2.6 2.6-3.1 1.7.1 1.4-1h1.3l.8-.9-.4-2.1.6-.7.1-2.1z
67	9587f5fd-8609-4be8-b425-e96289e5d788	b3e98c98-8a15-45bf-8f86-f26f6a07a425	M912.4 493l-.8.4-3-.5-.4.7-1.3.1-4-1.5-2.7-.1-.1 2.1-.6.7.4 2.1-.8.9h-1.3l-1.4 1-1.7-.1-2.6 3.1 1.6 1.1.8 1.4.7 2.8 1.3 1.2 1.5.9 2.1 2.5 2.4 3.7 3-2.8.7-1.7 1-1.4 1.5-.2 1.3-1.2h4.5l1.5 2.3 1.2 2.7-.2 1.8.9 1.7v2.3l1.5-.3 1.2-.2 1.5-.7 2.3 3.9-.4 2.6 1.1 1.3 1.6.1 1.1-2.6 1.6.2h.9l.3-2.8-.4-1.2.6-.9 2-.8-1.3-5.1-1.3-2.6.5-2.2 1.1-.5-1.7-1.8.3-1.9-.7-.7-1.2.6.2-2.1 1.2-1.6-2.3-2.7-.6-1.7-1.3-1.4-1.1-.2-1.3.9-1.8.8-1.6 1.4-2.4-.5-1.5-1.6-.9-.2-1.5.8h-.9l-.3-2.3z
71	41e82432-5bb2-4c9d-917f-576bc3060116	8287bea9-2349-46e4-9ac0-fb1e799497af	M1079.1 263.8l-1.6.4-1 1.5-2.2.7-.6-.4-2.3 1-1.9.2-.3 1.2-4.1.8-1.9-.7-2.6-1.6-.2 2.6h-2.8l1.1 1.3-1.3 4 .8.1 1.2 2.1 1.6.8 4 2.6 4.2 1.2 1.8-.9 3.7-1.6 3.2.2 3.8-1.1 2.6-4.3 1.9-4.2 2.9-1.3-.6-1.6-2.9-1.7-1 .6-5.5-1.9z
72	aa9ec671-1ab5-4aa2-8393-bcc8c189a187	68563b3e-8866-4310-bdce-659b3cc9c2ac	M915.7 158.6l-6.9-.4-7.3 2.9-5.1-1.5-6.9 3-5.9-3.8-6.5.8-3.6 3.7 8.7 1.3-.1 1.6-7.8 1.1 8.8 2.7-4.6 2.5 11.7 1.8 5.6.8 3.9-1 12.9-3.9 6.1-4.2-4.4-3.8 1.4-3.6z
73	5e63b010-458a-43cb-9776-1fb93f7f42ff	83f3b190-021f-4694-a033-57058c22cbf4	M1414.1 380.1l-8.5-4.4-6.2-4-3.2-7 4.1.9-.6-3.3-3-3.3-.8-5.2-7.6-7.5-3.7 5.4-5.7 1-8.5-1.6-1.9 2.8 3.2 5.6 2.9 4.3 5 3.1-3.7 3.7 1 4.5-3.9 6.3-2.1 6.5-4.5 6.7-6.4-.5-4.9 6.6 4 2.9 1.3 4.9 3.5 3.2 1.8 5.5h-12l-3.2 4.2 7.1 5.4 1.9 2.5-2.4 2.3 8 7.7 4 .8 7.6-3.8 1.7 5.9.8 7.8 2.5 8.1 3.6 12.3 5.8 8.8 1.3 3.9 2 8 3.4 6.1 2.2 3 2.5 6.4 3.1 8.9 5.5 6 2.2-1.8 1.7-4.4 5-1.8-1.8-2.1 2.2-4.8 2.9-.3-.7-10.8 1.9-6.1-.7-5.3-1.9-8.2 1.2-4.9 2.5-.3 4.8-2.3 2.6-1.6-.3-2.9 5-4.2 3.7-4 5.3-7.5 7.4-4.2 2.4-3.8-.9-4.8 6.6-1.3 3.7.1.5-2.4-1.6-5.2-2.6-4.8.4-3.8-3.7-1.7.8-2.3 3.1-2.4-4.6-3.4 1.2-4.3 4.8 2.7 2.7.4 1.2 4.4 5.4.9 5-.1 3.4 1.1-1.6 5.3-2.4.4-1.1 3.6 3.5 3.3.2-4 1.5-.1 4.5 10.1 2.4-1.5-.9-2.7.9-2.1-.9-6.6 4.6 1.4 1.5-5.2-.3-3.1 2.1-5.4-.9-3.6 6.1-4.4 4.1 1.1-1.3-3.9 1.6-1.2-.9-2.4-6.1-.9 1.2-2.7-3.5-3.9-3.2 2.6-4.9-1.5-5.3 4-3.9 4.8-4.2.8 2.7 2 .4 3.9-4.4.2-4.7-.4-3.2 1-5.5-2.5-.3-1.2-1.5-5.1-3 1.4.1 2.7 1.5 4.1-.1 2.5-4.6.1-6.8-1.5-4.3-.6-3.8-3.2-7.6-.9-7.7-3.5-5.8-3.1-5.7-2.5.9-5.9 2.8-2.9z
74	8675cde0-7eba-487d-a86e-cbfe2ee73018	a3122035-5d20-411c-a94d-17360ed55678	M1651.9 637.3l.5-1.7-1.8-1.9-2.8-2-5.3 1.3 7 4.4 2.4-.1zm20.9-.6l4-4.8.1-1.9-.5-1.3-5.7 2.6-2.8 3.9-.7 2.1.6.8 5-1.4zm-35.6-13l-1.6 2.2-3.1.1-2.2 3.6 3 .1 3.9-.9 6.6-1.2-1.2-2.8-3.5.6-1.9-1.7zm28.1 0l-5.2 2.3-3.8.5-3.4-1.9-4.5 1.3-.2 2.3 7.4.8 8.6-1.8 1.1-3.5zm-79.5-8.4l-.7-2.3-2.3-.5-4.4-2.4-6.8-.4-4.1 6.1 5.1.4.8 2.8 10 2.6 2.4-.8 4.1.6 6.3 2.4 5.2 1.2 5.8.5 5.1-.2 5.9 2.5 6.6-2.4-6.6-3.8-8.3-1.1-1.8-4.1-10.3-3.1-1.3 2.6-10.7-.6zm146.6-3.6l.2-3-1.2-1.9-1.3 2.2-1.2 2.2.3 4.8 3.2-4.3zm-41-17.5l-1.4-2.1-5.7.3 1 2.7 3.9 1.2 2.2-2.1zm18.1-2.4l-6.1-1.8-6.9.3-1.5 3.5 3.9.2 3.2-.4 4.6.5 4.7 2.6-1.9-4.9zm21-12.3l-.8-2.4-9-2.6-2.9 2.1-7.6 1.5 2.3 3.2 5 1.2 2.1 3.7 8.3.1.4 1.6-4-.1-6.2 2.3 4.2 3.1-.1 2.8 1.2 2.3 2.1-.5 1.8-3.1 8.2 5.9 4.6.5 10.6 5.4 2.3 5.3 1 6.9-3.7 1.8-2.8 5.2 7.1-.2 1.6-1.8 5.5 1.3 4.6 5.2 1.5-20.8 1-20.7-6-1.2-4.1-2.3-4.7-2.2h-5l-6.6 3.8-4.9 6.8-5.7-3.8-1.3-10.3zm-50-16.4l-1-1.4-5.5 4.6-6.5.3-7.1-.9-4.4-1.9-4.7 4.8-1.2 2.6-2.9 9.6-.9 5-2.4 4.2 1.6 4.3 2.3.1.6 6.1-1.9 5.9 2.3 1.9 3.6-1 .3-9.1-.2-7.4 3.8-1.9-.7 6.2 3.9 3.7-.8 2.5 1.3 1.7 5.6-2.4-3 5.2 2.1 2.2 3.1-1.9.3-4.1-4.7-7.4 1.1-2.2-5.1-8.1 5-2.5 2.6-3.7 2.4.9.5-2.9-10.5 2.1-3.1 2.9-5-5.6.9-4.8 4.9-1 9.3-.3 5.4 1.3 4.3-1.3 4.4-6.3zm19.4 1.9l-.6-2.6-3.3-.6-.5-3.5-1.8 2.3-1 5.1 1.7 8.2 2.2 4 1.6-.8-2.3-3.3.9-3.9 2.9.6.2-5.5zm-60.9-4.5l.9-2.9-4.3-6 3-5.8-5-1h-6.4l-1.7 7.2-2 2.2-2.7 8.9-4.5 1.3-5.4-1.8-2.7.6-3.2 3.2-3.6-.4-3.6 1.2-3.9-3.5-1-4.3-3.3 4.2-.6 5.9.8 5.6 2.6 5.4 2.8 1.8.7 8.5 4.6.8 3.6-.4 2 3.1 6.7-2.3 2.8 2 4 .4 2 3.9 6.5-2.9.8 2.3 2.5-9.7.3-6.4 5.5-4.3-.2-5.8 1.8-4.3 6.7-.8-6.5-5.9zm-68.7 48.9l.7-9.8 1.7-8-2.6-4-4.1-.5-1.9-3.6-.9-4.4-2-.2-3.2-2.2 2.3-5.2-4.3-2.9-3.3-5.3-4.8-4.4-5.7-.1-5.5-6.8-3.2-2.7-4.5-4.3-5.2-6.2-8.8-1.2-3.6-.3.6 3.2 6.1 7 4.4 3.6 3.1 5.5 5.1 4 2.2 4.9 1.7 5.5 4.9 5.3 4.1 8.9 2.7 4.8 4.1 5.2 2.2 3.8 7 5.2 4.5 5.3 6.2-.1z
75	7f2de6fa-7b08-48d0-8acf-76f623266258	1baa5d83-2707-4a0d-8f86-45efc106dffd	M1213.5 324.4l-3.2-2.9-1.2-2.4-3.3 1.8 2.9 7.3-.7 2 3.7 5.2 4.7 7.8 3.7 1.9 1 3.8-2.3 2.2-.5 5 4.6 6.1 7 3.4 3.5 4.9-.2 4.6h1.7l.5 3.3 3.4 3.4 1.7-2.5 3.7 2.1 2.8-1 5.1 8.4 4.3 6.1 5.5 1.8 6.1 4.9 6.9 2.1 5.1-3.1 4-1.1 2.8 1.1 3.2 7.8 6.3.8 6.1 1.5 10.5 1.9 1.2-7.4 7.4-3.3-.9-2.9-2.7-1-1-5.7-5.6-2.7-2.8-3.9-3.2-3.3 3.9-5.8-1.1-4-4.3-1.1-1.1-4-2.7-5.1 1.6-3.5-2.5-.9.5-4.7.5-8-1.6-5.5-3.9-.2-7.3-5.7-4.3-.7-6.5-3.3-3.8-.6-2.1 1.2-3.5-.2-3 3.7-4.4 1.2-.2 1.6-7.9 1.7-7.6-1.1-4.3-3.3-5.2-1.3-2.5-4.8-1.3.3-3.8-3.4 1.2-3.1-1.9-1.9-1.9.5-5.3 4.7-1.8.2-3.7-.9z
76	58e32b10-a8fd-4c57-93bf-61b9b2b96bab	e130f15d-7a37-4ddf-a6b5-e9c1266e128a	M1207.3 334.9l-6.2-.9-2.1 1-2.1 4.1-2.7 1.6 1.2 4.7-.9 7.8-11 6.7 3.1 7.7 6.7 1.7 8.5 4.5 16.7 12.7 10.2.5 3.2-6.1 3.7.5 3.2.4-3.4-3.4-.5-3.3h-1.7l.2-4.6-3.5-4.9-7-3.4-4.6-6.1.5-5 2.3-2.2-1-3.8-3.7-1.9-4.7-7.8-2.3 1.1-2.1-1.6z
78	a6169fdf-f321-4788-9ba2-1529f6baafb1	fc3338b4-47f1-4342-8def-3acabc77a994	M1167.8 360.5l-1.4.1-.4 1.1h-1.8l-.1.1-.6 1.6-.6 4.8-1.1 2.9.4.4-1.4 2.1 3.9 9.2.7 1.7 1.7-10.2-.4-2.4-2.4.8.1-1.7 1.2-.8-1.4-.7.7-4.3 2 .9.7-2h-.1l.6-1-.3-2.6z
79	6f16f81e-a2f6-44ad-bec2-45c3f31fa105	161a32a0-755e-430b-86dc-8f153f7de9b1	M1057.8 328.6l-4 .5-5.2.7-6.2-.6-.6 3.4 7.5 3.3 2.7.7 4.2 2.4.9-3.3-.9-2 1.6-5.1zm-33.7-18.9l-2.5 1.9-2.8-.3 1.3 3.6.4 7.6 2.1 1.7 2-2.1 2.4.4.4-8.4-3.3-4.4zm14.3-34.3l-1.3-2.2-4.8 1.1-.5 1.2-3.1-.9-.3 2.5-2.1 1.1-3.8-.8-.9 2.5-2.4.2-.9-1-2.7 2.1-2.4.3-2.2-1.3-.2 1.7 1.6 2.4-1.7 1.8 1.5 4.8 2.7.8-.5 2.7 2.1-.5 2.8-2.8 2.3-.9 4.2 2.1 2.6.7 1.9 6 3.6 3.6 4.9 4 4.2 2.8 3.9.4 2.3 2.5 3.4 1.2 1.7 2.7 2.2.8 1.8 3.2 2.3 3.7-1.1 1.3-.8 3.5.1 2 2.1-.5 2.5-5.6 2.1-.4.4-3.3-3.9-2.3 1.9-4.1 4.5 1 3.1 3 .8-2.3-.6-1.2-4.7-3.2-3.9-1.9-4.8-2.3 1.4-1.2-1.4-1.4-4 .1-6-5-2.9-5.1-4.9-3.1-1.9-3.1.5-1.8-.4-3 3.9-2.2 4.1.9-1.4-2.7.3-3-7.2-1.6z
80	60ab4beb-0e9a-45f7-9a95-6afcd08ce9f9	31d93d6a-5130-4cfa-87ba-90d971d98d34	M946.5 506.2l-2.3.9-1.3.8-.9-2.7-1.6.7-1-.1-1 1.9-4.3-.1-1.6-1-.7.6-1.1.5-.5 2.2 1.3 2.6 1.3 5.1-2 .8-.6.9.4 1.2-.3 2.8h-.9l-.3 1.8.6 3.1-1.2 2.8 1.6 1.8 1.8.4 2.3 2.7.2 2.5-.5.8-.5 5.2 1.1.2 5.6-2.4 3.9-1.8 6.6-1.1 3.6-.1 3.9 1.3 2.6-.1.2-2.5-2.4-5.5 1.5-7.2 2.3-5.3-1.4-9.1-3.8-1.6-2.7.2-1.9 1.6-2.5-1.3-1-2.1-2.5-1.4z
81	454df98c-8158-40f5-bfd2-c5310bbf9fb6	96abeca6-c08e-4df8-b22f-2fefc55a8d5b	M550.7 458.5l3.9-.1-.8-1.8-2.7-1.5-3.7-.6-1.2-.2-2.4.4-.8 1.5 2.9 2.3 3 1 1.8-1z
82	83d69b0f-ed2b-4bc1-972a-f7157087e7b1	8e5a125d-73cb-45c1-a511-f0c65d7448e7	M1692.5 354.9l-4.5-1.3-1.1 2.7-3.3-.8-1.3 3.8 1.2 3 4.2 1.8-.1-3.7 2.1-1.5 3.1 2.1 1.3-3.9-1.6-2.2zm24.4-19.3l-3.6-6.7 1.3-6.4-2.8-5.2-8.1-8.7-4.8 1.2.2 3.9 5.1 7.1 1 7.9-1.7 2.5-4.5 6.5-5-3.1v11.5l-6.3-1.3-9.6 1.9-1.9 4.4-3.9 3.3-1.1 4-4.3 2 4 4.3 4.1 1.9.9 5.7 3.5 2.5 2.5-2.7-.8-10.8-7.3-4.7 6.1-.1 5-3 8.6-1.4 2.4 4.8 4.6 2.4 4.4-7.3 9.1-.4 5.4-3 .6-4.6-2.5-3.2-.6-5.2zm-11.8-44.2l-5.3-2.1-10.4-6.4 1.9 4.8 4.3 8.5-5.2.4.6 4.7 4.6 6.1h5.7l-1.6-6.8 10.8 4.2.4-6.1 6.4-1.7-6-6.9-1.7 2.6-4.5-1.3z
83	19f2a1f2-4bf3-482e-8f2e-0ee950a18fe9	c728bbe4-373f-4d0a-9a3f-985679759733	M1186.6 367.6l-3.1-7.7-9.6 6.7-6.3-2.5-.7 2 .4 3.9-.6 1.9.4 2.4-1.7 10.2.3.9 6.1 1 2.1-2 1.1-2.3 4-.8.7-2.2 1.7-1-6.1-6.4 10.4-3.1.9-1z
84	92482d61-2979-4f42-bcb9-e45953890383	c6a8ea7c-3fed-4a1d-9929-5569db7ab968	M1308.8 223.8l-9-1.3-3.1 2.5-10.8 2.2-1.7 1.5-16.8 2.1-1.4 2.1 5 4.1-3.9 1.6 1.5 1.7-3.6 2.9 9.4 4.2-.2 3-6.9-.3-.8 1.8-7.3-3.2-7.6.2-4.3 2.5-6.6-2.4-11.9-4.3-7.5.2-8.1 6.6.7 4.6-6-3.6-2.1 6.8 1.7 1.2-1.7 4.7 5.3 4.3 3.6-.2 4.2 4.1.2 3.2 2.8 1 4.4-1.3 5-2.7 4.7 1.5 4.9-.3 1.9 3.9.6 6-4.6-.9-4 1 .9 4.5-5-.6.6 2 3.2 1.6 3.7 5.5 6.4 2.1 1.5 2.1-.7 2.6.7 1.5 1.8-2 5.5-1.3 3.8 1.7 4.9 4.9 2.5-.3-6.2-22.8 11.9-3.6 1.1.5 9.1 4.5 4.8 2.3 6.5 5.5 5.7-.9 8.6-.5 7.5 4.5 1.5 6.2 2.5.1 2.6 5 6.6.2 2.3 3h1.9l.9-4.5 5.4-4.3 2.5-1.2.3-2.7 3.1-.8 9.1 2.1-.5-3.6 2.5-1.3 8.1 2.6 1.6-.7 8.6.2 7.8.6 3.3 2.2 3.5.9-1.7-3.5 2.9-1.6-8.7-10.7 9-2.4 2-1.4-1-11.1 10.7 2 1.6-2.8-2.5-6.2 3.8-.6 1.8-4.2-4.3-3.8-6 .9-3.3-2.6-3.9-1.2-4.1-3.6-3.2-1.1-6.2 1.6-8.3-3.6-1.1 3.3-18.1-15.5-8.3-4.7.8-1.9-9.1 5.7-4.4.4-1.2-3.3-7-2.1-4.3 1.5-4.3-6.3z
85	0cb41121-15fa-47cf-b1fe-a0bdba3da66b	e91cae72-f62c-407e-b388-3f3b86f7a0c3	M1211.7 547.2h-3.8l-2.3-2.1-5.1 2.6-1.6 2.7-3.8-.5-1.2-.7-1.3.1h-1.8l-7.2-5.4h-3.9l-2-2.1v-3.6l-2.9-1.1-3.8 4.2-3.4 3.8 2.7 4.4.7 3.2 2.6 7.3-2.1 4.7-2.7 4.2-1.6 2.6v.3l1.4 2.4-.4 4.7 20.2 13 .4 3.7 8 6.3 2.2-2.1 1.2-4.2 1.8-2.6.9-4.5 2.1-.4 1.4-2.7 4-2.5-3.3-5.3-.2-23.2 4.8-7.2z
86	bc0d7ea0-c655-4fd0-9bd9-15424770306e	ab2a946c-f1e3-43f5-bbfd-4b54adae333a	M1235.6 381.4l-3.7-.5-3.2 6.1 4.9.6 1.7 3.1 3.8-.2-2.4-4.8.3-1.5-1.4-2.8z
87	1494d5eb-d1a9-4684-99d7-04804cc364ad	6cec735b-3406-430f-be56-71d96ff8f41e	M1387.2 302.6l-3.5-.9-3.3-2.2-7.8-.6-8.6-.2-1.6.7-8.1-2.6-2.5 1.3.5 3.6-9.1-2.1-3.1.8-.3 2.7 1.8.6-3.1 4.1 4.6 2.3 3.2-1.6 7.1 3.3-5.2 4.5-4.1-.6-1.4 2-5.9-1.1.6 3.7 5.4-.5 7.1 2 9.5-.9 1-1.5-1.1-1.5 4-3 3.2-1.2 5.7.9.6-4 6.4-.8 1-2.4 6.8-3.4.2-1.4z
88	f4b1dbba-e19b-4c38-bc53-632027c62a0a	85b0fd58-f24b-4249-a31c-46e40023744c	M1102.1 210.1h-3.8l-4.4-2.2-2.1-.7-3.7 1-.2 4.6-3.6.1-4.4-4.5-4 2.1-1.7 3.7.5 4.5 5-1.9 7.9.4 4.4-.6.9 1.3 2.5.4 5 2.9 2.6-1 4.6-2.3-2.1-3.6-1-2.8-2.4-1.4z
89	c1c212c4-4642-4fd8-9ec4-d4af78661626	6a6a8869-35f4-4d7f-af9f-c881d3b4bc19	M1167.8 360.5l.9-3.5 2.6-2.4-1.2-2.5-2.4-.3-.1.2-2.1 4.5-1.3 5.2h1.8l.4-1.1 1.4-.1z
90	9e7a9a17-2460-4ee4-8d80-cf6b8bb65908	f7ca89ef-b000-416a-b9f4-6059b2d8a3ca	M1128.1 766.5l1.1-2 3.1-1 1.1-2.1 1.9-3.1-1.7-1.9-2.3-2-2.6 1.3-3.1 2.5-3.2 4 3.7 4.9 2-.6z
91	a7c9fbf6-be01-4dc8-92a9-5b89855abc12	e3c9a7c1-e5ec-46aa-be24-13a63b23c24a	M929.4 523.3l-1.6-.2-1.1 2.6-1.6-.1-1.1-1.3.4-2.6-2.3-3.9-1.5.7-1.2.2-2.6 3-2.6 3.4-.3 1.9-1.3 2 3.7 4.1 4.8 3.5 5.1 4.8 5.7 3.1 1.5-.1.5-5.2.5-.8-.2-2.5-2.3-2.7-1.8-.4-1.6-1.8 1.2-2.8-.6-3.1.3-1.8z
92	08f21efd-f287-4518-a482-043292e35f4f	a9bc64d6-1f2e-4882-90bc-4930614667da	M1111.8 371.4l-1.5-2.1-5.4-.8-1.8-1.1h-2l-2-2.8-7.3-1.3-3.6.8-3.7 3-1.5 3.1 1.5 4.8-2.4 3-2.5 1.6-5.9-3.1-7.7-2.7-4.9-1.2-2.8-5.7-7.2-2.8-4.5-1.1-2.2.6-6.4-2.2-.1 4.9-2.6 1.8-1.5 2-3.7 2.5.7 2.6-.4 2.7-2.6 1.4 1.9 5.6.4 3-.9 5.2.5 2.9-.6 3.5.5 4-2.1 2.6 3.4 4.7.2 2.7 2 3.6 2.6-1.2 4.3 2.9 2.5 4 8.8 2.8 3.1 3.5 3.9-2.4 5.4-3.5 22.3 12.2 22.4 12.2v-2.7h6.3l-.5-12.7-1-23.4-1.3-22.7-2-5.1 1.2-3.9-1.1-2.7 1.8-3z
93	b6adbc40-2a0a-45bd-a3bf-11be8d0e4a59	d4d24a30-2184-4fd3-8315-248ddc094526	M1100.4 221.2l-5-2.9-2.5-.4-.9-1.3-4.4.6-7.9-.4-5 1.9 1.7 5 5 1.1 2.2.9-.2 1.7.6 1.5 2.5.6 1.4 1.9h4.6l4.8-2.2.5-3.4 3.5-2-.9-2.6z
94	2a95ef6e-252d-4bfc-937e-84c58021b835	a94b35b0-c269-4e9f-9d66-80d8f3081989	M1007 258.6l.2-2.7-1-1.4-1.3.2-.4 3.5 1.1.5 1.4-.1z
95	84b0977e-867d-43a9-801e-f364c3f40c89	b7206cc1-2cca-454d-9447-3788640f7b5e	M1255.7 658.4l-1.1-4.2-1.4-2.7-1.8-2.7-2 2.8-.3 3.8-3.3 4.5-2.3-.8.6 2.7-1.8 3.2-4.8 3.9-3.4 3.7h-2.4l-2.2 1.2-3.1 1.3-2.8.2-1 4.1-2.2 3.5.1 5.9.8 4 1.1 3-.8 4.1-2.9 4.8-.2 2.1-2.6 1.1-1.3 4.6.2 4.6 1.6 5-.1 5.7 1.2 3.3 4.2 2.3 3 1.7 5-2.7 4.6-1.5 3.1-7.4 2.8-8.9 4.3-12 3.3-8.8 2.7-7.4.8-5.4 1.6-1.5.7-2.7-.8-4.7 1.2-1.9 1.6 3.8 1.1-1.9.8-3.1-1.3-2.9-.5-7.7z
96	12eb7b56-0fbf-4213-a18a-56fca4c62c42	413fe813-55c0-49e9-8853-47654b4ae73b	M1169.2 661.5l.1-2.3-1.2-1.9.1-2.8-1.5-4.7 1.7-3.5-.1-7.7-1.9-4.1.2-.7-1.1-1.7-5.4-1.2 2.6 2.8 1.2 5.4-1 1.8-1.2 5.1.9 5.3-1.8 2.2-1.9 5.9 2.9 1.7 3 3 1.6-.6 2.1 1.6.3 2.6-1.3 2.9.2 4.5 3.4 4 1.9-4.5 2.5-1.3-.1-8.2-2.2-4.6-1.9-2h-.3v.8l1.1.3 1 3.4-.2.8-1.9-2.5-1 1.6-.8-1.4z
97	b0a00a30-f30a-4957-b380-4a0fdf25b169	d42ac9fd-1e10-4995-8dc1-4d25cee7a022	M1543.6 532.7l-4.7-2.8-.9 1.1 1.4 2.7-.4 4.7 2.1 3.4 1 5.3 3.4 4.3.8 3.2 6.7 5 5.4 4.8 4-.5.1-2.1-2.3-5.6-2.1-1.8-.5-3.8-.6-2.1.5-2.9-.5-4.3-2.6-4.3-3.5-3.8-1.3-.6-1.7 2.6-3.7.8-.6-3.3zm99 11l-1.2-3.1 3.8-.4.3-2.4-4.8-2-3.8-1.7-.4-2.8-3.1-3.2h-2.3l-2.5 5-4.1 4.4-.1 3.1-.1 4.1-2.7-.2-1.1 2.2-2.7-3.3-2.6 4-3.8 5-6.7 1.4-2.4 1.2-.9 5.4-4.4 1.2-4.1-2.2 1 4.3 3.9 3.5 3.6-1.2 3.6.4 3.2-3.2 2.7-.6 5.4 1.8 4.5-1.3 2.7-8.9 2-2.2 1.7-7.2h6.4l5 1 4-2.1z
98	8e86cb0a-db55-4f43-a668-6d4b89b981fe	2b8d132e-e3b8-4a97-aa78-a265bf65836d	M1389.1 551.6l.1-.1v-.2l-.1-.1h-.1l-.1.2v.2h.2zm.3-5.9l.1-.2v-.4l-.1.1-.1.2v.1l-.1.1v.1h.2z
99	18f2821b-6c13-43bd-91e1-03bce50fc09d	a8c0bf67-69a5-4293-8282-622c6b61962c	M1000.3 450.3l-6.1.6-.1-4-2.6-1.1-3.4-1.8-1.3-3-18.6-13.8-18.4-13.9-8.4.1 2.4 27.4 2.4 27.5 1 .8-1.3 4.4-22.3.1-.9 1.4-2.1-.4-3.2 1.3-3.8-1.8-1.8.2-1 3.7-1.9 1.2.2 3.9 1.1 3.7 2.1 1.8.4 2.4-.3 2 .3 2.3h.9l1.5-.8.9.2 1.5 1.6 2.4.5 1.6-1.4 1.8-.8 1.3-.9 1.1.2 1.3 1.4.6 1.7 2.3 2.7-1.2 1.6-.2 2.1 1.2-.6.7.7-.3 1.9 1.7 1.8.7-.6 1.6 1 4.3.1 1-1.9 1 .1 1.6-.7.9 2.7 1.3-.8 2.3-.9-.4-3.7 1.6-2.7-.2-2.2 4.5-5.2.8-4.4 1.6-1.6 2.7.9 2.3-1.3.8-1.6 4.3-2.9 1.1-2 5.2-2.6 3-.9 1.4 1.2h3.6l3.6-.3 2-2.2 7.6-.6 4.9-1 .5-3.9 3-4.3-.1-14.6z
100	eef8592e-f1ce-4bd8-87dd-539d839df98e	ca8f94ef-b748-47c8-b040-b996e3cf2581	M1053.6 344l-.2-.2-.5-.5-.5-.1.1.6.4.4h.5l.2-.2zm-1.4-1.2v-.2l-.3-.1-.4.1.1.1.3.2.3-.1z
101	a9fea452-37ce-4044-8666-8f4defd1ff08	a4d1f62b-6131-44de-92fe-975d0a463bc7	M949.8 413.3l-20.3-15.5-.2 9.7-17.9-.3-.2 16.3-5.2.5-1.4 3.3.9 9.2-21.6-.1-1.2 2.2 2.8 2.7 1.4 3-.7 3.2.6 3.2.5 6.3-.8 5.9-1.7 3.2.4 3.4 2-2 2.7.5 2.8-1.4h3.1l2.6 1.8 3.7 1.7 3.2 4.7 3.6 4.4 1.9-1.2 1-3.7 1.8-.2 3.8 1.8 3.2-1.3 2.1.4.9-1.4 22.3-.1 1.3-4.4-1-.8-2.4-27.5-2.4-27.4 8.4-.1z
102	d20dd929-321c-4ceb-a8a8-4c88dba5ef90	59a60488-bbd7-476a-813e-a92fa901e8e7	M1294.7 702.5l.3-.3.2-.4.3-.3.1-.7-.2-.8-.4-.7-.5.1-.3.4-.2.5-.5.3-.1.3-.2.7-.1.4-.2.1v.2l.3.3.8.1.7-.2z
103	86f01942-b930-4225-b488-1ca4b8ca71b2	846ec109-79bc-4e46-a303-40e20bcb2f36	M444.4 407.8l-3.6-1.4-3.9-2-.8-3-.2-4.5-2.4-3.6-1-3.7-1.6-4.4-3.1-2.5-4.4.1-4.8 5-4-1.9-2.2-1.9-.4-3.5-.8-3.3-2.4-2.8-2.1-2-1.3-2.2h-9.3l-.8 2.6h-15l-10.7-4.4-7.1-3.1 1-1.3-7 .7-6.3.5.2 5.7.7 5.1.7 4.1.8 4 2.6 1.8 2.9 4.5-1 2.9-2.7 2.3-2.1-.3-.6.5 2.3 3.7 2.9 1.5 1 1.7.9-.9 3.1 2.9 2.1 2 .1 3.4-1.2 4.7 2.5 1.6 3.3 3.1 2.9 3.6.7 3.9h1l2.7-2.3.4-1.2-1.5-2.8-1.6-2.9-2.6-.2.4-3.4-.9-3-1-2.8-.5-5.9-2.6-3.2-.6-2.3-1.2-1.6v-4.1l-1 .1-.1-2.2-.7-.5-.4-1.4-2.7-4.4-1.1-2.6 1-4.8.1-3 1.8-2.6 2.4 1.7 1.9-.2 3.1 2.5-.9 2.4.4 4.9 1.5 4.7-.4 2 1.7 3.1 2.3 3.4 2.7.5.3 4.4 2.4 3.1 2.5 1.5-1.8 4 .7 1.5 4.1 2.6 1.9 4 4.5 4.9 3.8 6.4 1.3 3.2v2.5l1.4 2.9-.3 2.2-1.6 1.6.3 1.8-1.9.7.8 3.1 2.2 4 5.3 3.6 1.9 2.9 5.4 2 3 .4 1.2 1.7 4.2 3 5.9 3 4 .9 4.8 2.9 4 1.2 3.7 1.7 2.9-.7 4.8-2.4 3.1-.4 4.4 1.6 2.6 2.1 5.5 6.9.4-1.9.8-1.5-.7-1.2 3.3-5.2h7.1l.4-2.1-.8-.4-.5-1.4-1.9-1.5-1.8-2.1h2.6l.4-3.6h5.2l5.1.1.1-1 .7-.3.9.8 2.5-3.9h1l1.2-.1 1.2 1.6 2-5 1.2-2.7-.9-1.1 1.8-3.9 3.5-3.8.6-3.1-1.2-1.3-3.4.5-4.8-.2-6 1.5-4 1.7-1.2 1.8-1.2 5.4-1.8 3.7-3.9 2.6-3.6 1.1-4.3 1.1-4.3.6-5.1 1.8-1.9-2.6-5.6-1.7-1.8-3.2-.7-3.6-3-4.7-.4-5-1.2-3.1-.5-3.4 1.1-3.1 1.8-8.6 1.8-4.5 3.1-5.6-2.1.2z
104	0e7d49a6-0af8-4b4e-b3d5-59664cd320d6	6f37afd2-3170-4c9d-8fde-28d6a44eda0d	M1118.5 283.3l1.2-.7.5-2.1 1.1-2-.5-1.1 1-.5.6.9 3 .2 1.2-.5-1-.6.2-1-2-1.5-1.1-2.6-1.9-1.1v-2.1l-2.5-1.6-2-.3-3.9-1.9-3.2.6-1.1.9 1.6.6 1.8 1.9 1.9 2.6 3.4 3.7.6 2.7-.2 2.7 1.3 2.8z
121	2e6d65af-77e2-45b9-8a33-97efbb7ffeaf	abc45575-6e5a-49c5-9967-e067a503c8a6	M1388.3 346.3l-9.4-2.6-2.9-5-4.7-3-2.8.7-2.4 1.2-5.8.8-5.3 1.3-2.4 2.8 1.9 2.8 1.4 3.2-2 2.7.8 2.5-.9 2.3-5.1-.2 3 4.2-3 1.6-1.5 3.8 1.1 3.8-1.7 1.8-2.1-.6-4 .9-.2 1.7h-4l-2.3 3.6.8 5.4-6.6 2.6-3.8-.5-.9 1.4-3.3-.8-5.3.9-9.6-3.2 3.2 3.3 2.8 3.9 5.6 2.7 1 5.7 2.7 1 .9 2.9-7.4 3.3-1.2 7.4 7.6-.9 8.9-.1 9.9-1.2 4.9 4.8 2.1 4.6 4.2 1.6 3.2-4.2h12l-1.8-5.5-3.5-3.2-1.3-4.9-4-2.9 4.9-6.6 6.4.5 4.5-6.7 2.1-6.5 3.9-6.3-1-4.5 3.7-3.7-5-3.1-2.9-4.3-3.2-5.6 1.9-2.8 8.5 1.6 5.7-1 3.7-5.4z
105	f72bca3f-dd05-4a75-abbd-f8c3e94f8763	b60fe946-71ac-40be-97dc-8ee0b78c3384	M1473.7 252.1l-3.7-4.6-6.6-1.5-4.8-.8-6.9-2.5-1.3 6.4 4 3.6-2.4 4.3-7.9-1.6-5-.2-4.7-2.9-5.1-.1-5.3-1.9-5.9 2.9-6.6 5.4-4.7 1 3.3 4.4 5.7 3.3 8.1 2.3 5.8 5 1.3 7.3 3 2.7 6.4 1 7.2.9 7.9 3.8 3.4.7 4.9 5.7 4.7 3.6 5.5-.1 11.2 1.3 6.4-.8 5.5.9 9.3 3.8 6.2-.1 3.2 2 4.4-3.3 7.2-2.2 7.5-.2 4.9-2.2 1.9-3.3 2.5-2-1.9-2.1-2.9-2.3.4-4 3.2.5 5.9 1.3 3.1-3.3 6.3-2.4 1.4-4.1 2.4-1.8 6.8-.8 4.3.7-.7-2.2-7.2-4.3-5.1-2-2.5 2.3-5.4-1-2.4.8-2.7-2.6-.3-6.2-.6-4.6-5.5.5-3.9-2.1-3.3-.7-4.5 4.4-5.8 1-3.6 1.6-6.7-1h-4.5l-4.9-3.1-6.5-3-5.4-.8-5.7.8-3.9 1.1-8.4-2.6z
106	e7b6ec02-07b9-45af-998a-befc95ed4eb0	6702177a-fbed-4cf3-aa32-22da244beab0	M1080 299.8l.4-.6-2-1.2-1.8-.7-.8-.8-1.5-1.1-.9.6-1.5 1.4-.4 3.4-.5 1 2.3 1.2 1.6 2.1 1.1.4-.5-1.9 2-3.1.4 1.2 1.3-.5.8-1.4z
107	e2b4b837-f9f5-49de-a783-da635a0708df	a7462d3b-b094-454a-a09c-08573a566463	M965.2 348.4l-2.3-.1-5.5-1.4-5 .4-3.1-2.7h-3.9l-1.8 3.9-3.7 6.7-4 2.6-5.4 2.9-3.5 4.3-.9 3.4-2.1 5.4 1.1 7.9-4.7 5.3-2.7 1.7-4.4 4.4-5.1.7-2.8 2.4-.1.1-3.6 6.5-3.7 2.3-2.1 4-.2 3.3-1.6 3.8-1.9 1-3.1 4-2 4.5.3 2.2-1.9 3.3-2.2 1.7-.3 3h.1l12.4-.5.7-2.3 2.3-2.9 2-8.8 7.8-6.8 2.8-8.1 1.7-.4 1.9-5 4.6-.7 1.9.9h2.5l1.8-1.5 3.4-.2-.1-3.4h.8l.1-7.5 8.9-4.7 5.4-1 4.4-1.7 2.1-3.2 6.3-2.5.3-4.7 3.1-.5 2.5-2.4 7-1 1-2.5-1.4-1.4-1.8-6.7-.3-3.9-2-4.1z
108	2c5c6b54-f40a-4740-99e3-ed4331d7e28b	95251d34-e411-4cb7-9112-0a1f95b239e0	M1203 640.7l-.8-2.9-4.6 3.7-6.2 2.5-3.3-.1-2.1 1.9-3.9.1-1.4.8-6.7-1.8-2.1.3-1.6 6 .7 7.3h.3l1.9 2 2.2 4.6.1 8.2-2.5 1.3-1.9 4.5-3.4-4-.2-4.5 1.3-2.9-.3-2.6-2.1-1.6-1.6.6-3-3-17.1 5.2.3 4.5.3 2.4 4.6-.1 2.6 1.3 1.1 1.6 2.6.5 2.8 2-.3 8.1-1.3 4.4-.5 4.7.8 1.9-.8 3.7-.9.6-1.6 4.6-6.2 7.2 2.2 9 1.1 4.5-1.4 7.1.4 2.3.6 2.9.3 2.8h4.1l.7-3.3-1.4-.5-.3-2.6 2.6-2.4 6.8-3.4 4.6-2.2 2.5-2.3.9-2.6-1.2-1.1 1.1-3 .5-6.2-1 .3v-1.9l-.8-3.7-2.4-4.8.7-4.6 2.3-1.4 4.1-4.6 2.2-1.1 6.7-6.8 6.4-3.1 5.2-2.5 3.7-3.9 2.4-4.4 1.9-4.6-.9-3.1.2-9.9-.4-5.6.4-6.3z
141	72dd1a0c-10de-4138-8c89-3bc64ab31697	2dd507e0-8e57-4924-a57f-8fc2e22555e2	M1087.4 260.9l-4.9-2.3-3.4.8-2.4-.6-2.8 1.3-2.7-2.2-1.9.9-.3-.4h-1.5l-.6 1.1-1.1.3-.2 1.4-.9.3-.1.6-1.6.6-2.2-.1-.6 1.4-.3.8.7 2.1 2.6 1.6 1.9.7 4.1-.8.3-1.2 1.9-.2 2.3-1 .6.4 2.2-.7 1-1.5 1.6-.4 5.5 1.9 1-.6.7-2.5 1.1-1.7z
109	b9761f4c-55b7-41dd-8a4a-ee7e8875a6fa	ac8b13ec-0d98-4fad-852e-a351d68e6a16	M1533.9 435.8l-.6-2.6-3.8 1.8-2.5-1.2-4.5-2.4.8-5.2-3.7-1.3-2.3-5.8-5.6 1-.7-7.5 4.1-5.3-.8-5.3-1.3-4.9-2.7-1.5-2.7-3.7-3 .4.9 2.4-1.6 1.2 1.3 3.9-4.1-1.1-6.1 4.4.9 3.6-2.1 5.4.3 3.1-1.5 5.2-4.6-1.4.9 6.6-.9 2.1.9 2.7-2.4 1.5.5 4.6-2.1-1 1.1 5.1 4.6 5.2 3.4.9-.4 2.2 5.4 7.4 1.9 5.9-.9 7.9 3.6 1.5 3.2.6 5.8-4.6 3.2-3.1 3.1 5.2 2 8.1 2.6 7.6 2.6 3.3.2 6.9 2.2 3.8-1.3 4.8.9 4.8 2.2-6.6 2.6-5.9-2.8-5.8-.2-3-1-3.5-4.2-5.1-1.7-3.2 1.7-1.1 1.4-5.6-2.9-4.2-4.1-4.6-3.5-5.6 2.2-1.1 1.5-6.9 3.9-.3 2.8-2.8 3-1.4.8-2.4 4.1-4.1z
110	ca116692-d003-45f6-ade9-86154e19ea90	dff0e275-70f0-4d4b-9d4a-3b4029ab3cd1	M1105.4 683.7l-10.3 2.5-13.4-.9-3.7-3-22.5.3-.9.4-3.2-2.9-3.6-.1-3.3 1-2.7 1.2.2 4.9 4.4 6.2 1.1 4 2.8 7.7 2.7 5.2 2.1 2.6.6 3.5v7.6l1.6 9.8 1.2 4.6 1 6.2 1.9 4.7 3.9 4.8 2.7-3.2 2.1 1.8.8 2.7 2.4.5 3.3 1.2 2.9-.5 5-3.2 1.1-23.6.6-18.5 5.4-.2.9-22.7 4.1-.2 8.6-2.2 2 2.6 3.7-2.5h1.6l3.2-1.5v-.5l-2.1-1.4-3.6-.4-4.6 1.5z
111	6416d2cb-10e6-413e-8f35-b68863afa509	c00f0e5e-a315-4118-b879-8d0a07faa486	M1915 575.5v-.2h-.2l-.1.2.1.1.1.1.1-.2z
112	954bfedd-da76-45fb-a02e-ad9e50679b83	52a86412-42e6-499e-a742-a0902ca649b5	M1455.2 394.8l-6.5-.6-6.4-1.5-5-2.8-4.5-1.2-2.5-3.1-3.2-.9-6.4-4.1-4.7-2-1.9 1.5-2.8 2.9-.9 5.9 5.7 2.5 5.8 3.1 7.7 3.5 7.6.9 3.8 3.2 4.3.6 6.8 1.5 4.6-.1.1-2.5-1.5-4.1-.1-2.7z
113	25fd2e5b-f429-4623-9ac1-62c3bfeb5a1e	649e4cd5-204a-41ae-add6-5c7433d23973	M1005.5 243.9h2.9l1.1-2.3 1-5.6-1-2-3.9-.2-6.5 2.6-3.9 8.9-2.5 1.7 3.6.5 4.4-1.3 3.1 2.7 2.8 1.4-1.1-6.4z
114	b626ffec-fbc4-4e33-83ba-72ed366c0da4	903625d0-0df4-4537-8370-4c3cda4ffed6	M1868.6 832.8l.9-2.6-5.8 2.9-3.4 3.4-3.2 1.6-5.9 4.6-5.6 3.2-7 3.2-5.5 2.4-4.3 1.1-11.3 6.1-6.4 4.6-1.1 2.3 5.1.4 1.5 2.1 4.5.1 4-1.8 6.3-2.8 8.1-6.2 4.7-4.1 6.2-2.3 4-.1.6-2.9 4.6-2.5 7-4.5 4.2-2.9 2.1-2.6.5-2.6-5.6 2.5.8-2.6zm28.8-30.5l1.9-5.7-3.1-1.7-.8-3.6-2.3.5-.4 4.6.8 5.7.9 2.7-.9 1.1-.6 4.4-2.4 4.1-4.2 5-5.3 2.2-1.7 2.4 3.7 2.5-.8 3.5-6.9 5.1 1.4.9-.4 1.6 5.9-2.5 5.9-4.2 4.5-3.4 1.6-1.2 1.5-2.7 2.8-2 3.8.2 4.2-3.8 5.1-5.7-2.1-.8-4.6 2.5-3.2-.5-2.9-2.1 2.3-4.9-1.2-1.8-2.9 4.4.4-6.8z
115	414634bb-dcf7-455a-beb1-12eebbb7b5e2	390d0b06-0892-405b-93f4-8b1b69af9667	M514.1 476.8l-1.9-.2-.9.9-2 .8h-1.4l-1.3.8-1.1-.3-.9-.9-.6.2-.8 1.5-.5-.1-.3 1.3-2.1 1.8-1.1.7-.6.8-1.5-1.3-1.4 1.7h-1.2l-1.3.2-.2 3.1h-.8l-.8 1.5-1.8.3-.4.4-.9-1-.7 1 2.6 2.9 2.2 2 1 2.1 2.5 2.6 1.8 2 .9-.8 3.5 1.7 1.4-.8 1.7.5.8 1.3 1.7.4 1.4-1.3-.8-1.1-.1-1.7 1.2-1.6-.2-1.7.7-2.7.9-.7.1-2.8-.2-1.7.4-2.8.9-2.5 1.4-2.2-.3-2.3.4-1.4.6-.6z
116	2fc0a597-e659-420e-b6b8-cd81142d29c5	363bc536-025f-4ef7-95c0-a083bb8f37e6	M1051.3 425.6l-8.8-2.8-18.6 12.2-15.8 12.5-7.8 2.8.1 14.6-3 4.3-.5 3.9-4.9 1-7.6.6-2 2.2-3.6.3-.5 3.1.8 2.9 3.1 4.1.2 3.1 6.4 1.4-.1 4.4 1.9-1.9h2l4.3 3.7.3-5.7 1.6-2.6.8-3.6 1.4-1.4 6-.8 5.6 2.4 2.1 2.4 2.9.1 2.6-1.5 6.8 3.3 2.8-.2 3.3-2.7 3.3.2 1.6-.9 3 .4 4.3 1.8 4.3-3.5 1.3.2 3.9 7 1-.2.2-2 1.6-.4.5-2.9-3.6-.2v-4.1l-2.4-2.3 2.3-8.4 6.9-6 .2-8.3 1.8-12.9 1.1-2.7-2.3-2.2-.2-2.1-2-1.6-1.6-9.9-3.9 2.4-3.1-3.5z
117	0a904f24-0a6d-48e9-b894-bcaa49849b1e	7ce306aa-4c86-4016-93ab-cf3f5c22c621	M1055.8 492.7l-1 .2-3.9-7-1.3-.2-4.3 3.5-4.3-1.8-3-.4-1.6.9-3.3-.2-3.3 2.7-2.8.2-6.8-3.3-2.6 1.5-2.9-.1-2.1-2.4-5.6-2.4-6 .8-1.4 1.4-.8 3.6-1.6 2.6-.3 5.7-.2 2.1 1.2 3.8-1.1 2.5.6 1.7-2.7 4-1.7 1.9-1 4 .1 4.1-.3 10.2h9.2l3.9 4.2 1.9 4.6 3 3.9 4.5.2 2.2-1.4 2.1.3 5.8-2.3 1.4-4.5 2.7-6.1 1.6-.1 3.3-3.7 2.1-.1 3.2 2.6 3.9-2.2.5-2.6 1.2-2.6.8-3.2 3-2.6 1.1-4.5 1.2-1.4.7-3.3 1.5-4 4.6-5 .3-2.1.6-1.1-2.3-2.6z
118	e5f423d7-6d28-4c81-b0f8-9f4e35d020f2	9ad23145-f384-4a8f-a075-4648d1837d46	M1644.7 302.3l-5.5-3.6.1 3.5-6.3 2.6 2.7 3.3-4.6-.2-3.6-2-1 4.4-3.8 3.4-2.1 4 3.3 1.7 3.4.7.8 1 .4 3.5 1.1 1.2-.9.7-.1 2.9 1.9 1 1.6.6.8 1.2 1.3-.5v-1.3l3.1 1.3.1-.6 2.4.2.7-2.9 3.5-.3 2.1-.4-.1-1.6-4.3-2.8-2.6-1 .2-.7-1.2-2.8 1.3-1.7 2.9-1 1-1.9.3-1.1 1.9-1.4-2.8-4.5.3-2.1.9-2 2.2.3-1.4-1.1z
119	f0097c8b-3992-4e51-a248-47e60611d0ac	4f50cb61-60cb-48f5-9c7a-974d9c3840d5	M1088.8 133.1l-6.9 1.1-7.3-.3-5.1 4.4-6.7-.3-8.5 2.3-10.1 6.8-6.4 4-8.8 10.7-7.1 7.8-8.1 5.8-11.2 4.8-3.9 3.6 1.9 13.4 1.9 6.3 6.4 3 6-1.4 8.5-6.8 3.3 3.6 1.7-3.3 3.4-4 .9-6.9-3.1-2.9-1-7.6 2.3-5.3 4.3.1 1.3-2.2-1.8-1.9 5.7-7.9 3.4-6.1 2.2-3.9 4 .1.6-3.1 7.9.9v-3.5l2.5-.3 2.1-1.4 5.1 2.9 5.3-.3 4.7 1.3 3.4-2.4 1.1-3.9 5.8-1.8 5.7 2.1-.8 3.8 3.2-.5 6.4-2.2-5.4-3.3 4.8-1.4-13.6-3.9zm-22.6-33.3l-5.6-1-1.9-1.7-7.2.9 2.6 1.5-2.2 1.2 6.7 1.1 7.6-2zm-25.4-8.3l-4.8-1.6-5.1.2-1 1.5h-5l-2.2-1.5-9.3 1.6 3.2 3.5 7.6 3.8 5.7 1.4-3 1.7 8.4 2.9 4.4-.2.9-3.9 3-.9 1.2-3.4 8.5-1.8-12.5-3.3zm24.2-3.1l-9.1-1-3.2 1.2-5.3-1-10.4 1.2 4.3 2h5.1l.9 1.3 10.6.7 10.1-.5 4.3-2.4-7.3-1.5z
120	21702931-5633-4495-9e6c-5da4a33963dc	7a1e411c-5e2b-4ef6-9561-73a4466af643	M1301 437.8l2.1-2 .8-1.8 1.6-3.8-.1-1.4-2.1-.8-1.6-2.1-2.9-3.7-3.3-1.1-4.1-.9-3.3-2.3-2.9-4.3h-2.8l-.1 4.2 1.1.8-2.4 1.3.3 2.6-1.4 2.6.1 2.6 2.9 4.5-2.6 12.7-16.1 6.4 5.2 10.5 2.1 4.4 2.5-.3 3.6-2.2 3.1.6 2.5-1.8-.2-2.5 2.1-1.6h3.4l1.2-1.3.2-3.1 3.3-2.4h2.6l.4-.8-1-4.2.6-3.2 1-1.5 2.5.3 1.7-4.4zm-16.6-30.4l.2-2.6-.7-.6-1.3 2.2 1.3 2.2.5-1.2z
122	7254f33d-39b6-40fb-ba58-f8786798bed5	e32cd55b-2b25-444e-beb4-f86a6e81819b	M543.5 517l-2-1.8-1.7-1.9-2.5-1.1-3.1-.2.3-.6-3.1-.4-2 1.9-3.5 1.3-2.5 1.6-2.7.5-1.5-1.6-.5.5-2.3-.3.2-1.3-1.9-2.3-2.2.6-.1 2.5 1.1 1-.8.7.1 1.2-.5 1.3-.4 1.2.6 1 .3-1.4h2.4l1.4.7 2.3.5 1 2.5 1.8.4.8-1.1.8 3.8 2.6-.3.9-.9 1.5-.9-2.5-3.4.6-1.3 1.3-.3 2.3-1.6 1.2-2.2 2.5-.4 2.7 1.8 1 2.1 1.4.4-1.5 1.7 1 3.5 1.8 1.8.9-3.1 1.8.5 1.1-1.9-1.1-3.8.7-.9z
142	704a1679-ef82-46ad-bf2f-15c778a4c837	dbc583de-b4de-46ba-aae0-1e8d35054bf3	M1059.4 277l-1.2-2.1-.8-.1-.9 1.1-4.3.1-2.4 1.4-4.2-.4-.3 3 1.4 2.7-1.1.5 3.5.2.8-1 1.8 1 2 .1-.2-1.7 1.7-.6.3-2.5 3.9-1.7z
123	88031d88-8542-430b-a22b-55bb21b88f3c	2f5d487b-20b7-47c4-b8fe-378d3c40839a	M1850.7 615.6l.9-1.8-2.4-2.2-2.5-4-1.6-1.5-.5-1.9-.8.7.9 4.8 2.2 4 2.2 2.5 1.6-.6zm-21.2-8.6l2.1-3.9.4-3.5-1.1-1-3.4.1.4 3.7-3.3 2.3-1.7 2.2-3.2.5-.4-3.4-.8.1-1 3.1-3.1.5-5-.9-.6 1.9 3.1 1.8 4.5 1.9h2.9l3-1.5 3.2-1.6 1-1.8 3-.5zm-27.8 12.2l-.9-4.3 5.2-.7-1.1-3.3-9.1-4-.6-3.7-2.9-3.2-3.7-3.3-10.2-3.6-9.6-4.4-1 20.7-1.5 20.8 5.7.2 3.1 1.1 4.6-2.2-.3-4.7 3.6-2.1 4.9-1.8 7 2.8 2.4 5.6 2.9 3.5 3.9 4 5.5 1 4.8.7 1.1 1.6 3.8-.4.8-1.8-5.6-2.7 1.8-1.2-4.2-1.1.5-2.8-3.2.2-3-6.8-4.7-4.1zm34.7-18.4l-.5-3.3-2-2.1-2.1-2.6-2.3-1.5-1.9-1.4-2.9-1.8-1.6 1.5 3.9 1.9 3.1 2.7 2.4 2.1 1.2 2.4.8 3.8 1.9-1.7z
124	e03a599b-91ec-48b9-b223-5c56e012aa17	5091a6a9-aa19-4e48-890a-d0d3ccce88c7	M655.7 700.5l-.3-1.9-5.4-3.3-5.1-.1-9.5 1.9-2.1 5.6.2 3.4-1.5 7.6 11.2 10.4 4.6 1 7.2 4.7 5.9 2.5 1.1 2.8-4.2 9.6 5.7 1.8 6.2 1 4.2-1.1 4.3-4.8.3-5.7.7-3.6.3-3.8-.3-3.5-2.1-1.2-2 1.1-2-.3-.9-2.5-1-5.8-1.2-1.9-3.9-1.7-2.1 1.2-6-1.2-.4-8.6-1.9-3.6z
125	f7de8386-afec-4831-839c-51d1fbea620a	6fd50499-8698-4764-a9ea-d063e211ae85	M584.3 599.5l-2.9-3.4-1.7-.1 3.5-6.5-4.4-3-3.3.6-2.1-1.1-3 1.7-4.2-.8-3.4-6.7-2.7-1.7-1.8-3-3.7-3-1.5.6.8 4.9-1.7 4.1-6 6.7-6.7 2.5-3.3 5.5-.9 4.3-3.1 2.6-2.5-3.2-2.3-.7-2.3.5-.2-2.3 1.5-1.5-.7-2.7-4.4 4-1.6 4.5 3 6.1-1.7 2.8 4.1 2.6 4.5 4.1 2 4.7 2.4 2.9 6 12.7 6.2 11.7 5.4 8.4-.8 1.8 2.8 5.3 4.6 3.9 10.7 6.9 11.6 6.4.7 2.6 5.9 3.7 2.7-1.6 1.2-3.3 2.8-6.9-2.8-5.3 1.1-2.1-1.2-2.4 1.9-3.2-.3-5.4-.1-4.5 1.1-2.1-5.5-10.3-3 1.1-2.6-.7-.2-9.7-4.4 3.8-4.9-.2-2.3-3.4-3.7-.3 1-2.8-3.3-3.8-2.6-5.8 1.5-1.1-.1-2.7 3.3-1.9-.7-3.4 1.3-2.2.4-3 6.2-4.3 4.6-1.2.7-1 5.1.3z
126	89adfd96-c980-4a3a-afde-2c5b2130a521	d29dcef8-e41b-4540-8f88-8849607ad3f3	M1684.6 518.6l-.6-2.3-.8-3.2-4.8-3 .8 4.9-3.9.2-.7 2.8-4.2 1.7-2.2-2.8-2.8 2.4-3.4 1.7-1.9 5.4 1.1 1.9 3.9-3.6 2.7.3 1.5-2.7 3.8 3-1.5 3.1 1.9 4.6 6.8 3.7 1.4-3-2.1-4.7 2.4-3.2 2.5 6.4 1.5-5.8-.6-3.5-.8-4.3zm-14.5-11.8v-6.1l-3.6 6.1.5-4.2-3 .3-.3 4-1.2 1.8-1 1.7 3.8 4.4 1.6-1.9 1.4-4 1.8-2.1zm-30.1 6.1l2.6-4.4 3.4-3.5-1.5-5.2-2.4 6.3-2.9 4.4-3.8 4-2.4 4.4 7-6zm17.4-16.4l1.2 3-.1 3.3.5 2.9 3.3-1.9 2.4-2.7-.2-2.6h-3.6l-3.5-2zm20-1.7l-1.8-2.4-5.4-.1 4 4.8.3 2.4-3.3-.5 1.2 3.9 1.7.3.7 4.5 2.5-1.4-1.7-4-.4-2.1 4.5 1.7-2.3-7.1zm-22.9-5.8l-2.2-2.3-4.8-.2 3.4 4.8 2.8 3.2.8-5.5zm-6.4-34.6h-3.3l-.9 5.8 1.1 9.9-2.6-2 1.2 6 1.2 2.8 3.3 3.7.4-2.3 1.8 1.4-1.5 1.7.1 2.6 2.9 1.4 5-.9 4 3.8 1.1-2.4 2.5 3.4 4.8 3.1.2-2.9-2-1.6.1-3.4-7.5-3.6-2.3.8-3.1-.7-2-5.1.1-5.1 3-2.1.6-5.3-2.7-4.6.4-2.6-.7-1.6-1.5 1.6-3.7-1.8z
127	b8ae68de-7374-4e24-bfe2-6d02d8aec2f1	9a7ad7e0-1e36-4004-9879-568b56d0cf87	M1069.4 228.3l-4.6-.1-.5-1.4-4.8-1.1-5.7 2.1-7.1 2.8-3.1 1.7 1.4 3.1-1.2 1.6 2 2.2 1.4 3.3-.1 2.1 2.3 3.9 2.4 1.9 3.7.6-.1 1.7 2.7 1.2.6-1.5 3.4.6.7 2 3.6.3 2.6 3.1.3.4 1.9-.9 2.7 2.2 2.8-1.3 2.4.6 3.4-.8 4.9 2.3 1.1.4-1.6-2.8 3.8-5.1 2.3-.7.3-1.8-3.1-5.3-.5-2.7-1.9-2.9 2.7-1.2-.3-2.4-1.7-2.3-.6-2.7-1.4-1.9-2.5-.6-8.7.1-5.9-.7z
128	748be0fb-681e-4c01-93ab-a60f5da3dad6	c2f84d45-aa39-4df1-8a87-e4dd0c5b34a1	M937.6 335.9l-.4-2.1 2-2.5.8-1.7-1.8-1.9 1.6-4.3-2-3.8 2.2-.5.3-3 .9-.9.2-4.9 2.4-1.7-1.3-3.1-3-.2-.9.8h-3l-1.2-3.1-2.1.9-1.9 1.6.1 2.1.9 2.2.1 2.7-1.3 3.8-.4 2.5-2.2 2.3-.6 4.2 1.2 2.4 2.3.6.4 4-1 5.1 2.8-.7 2.7.9 2.2-1.7z
129	85711358-fabd-423f-96b9-7b1976f99e2f	90a93353-4714-42fc-8632-09f25bc1312a	M1258 415.5l.8-3.8-.5-3.7-1.9-2-1.4.7-1.1 3.3.8 4.7 1.8 1.2 1.5-.4z
130	e2222ef4-8fb2-4e78-8ae9-d897241bc18d	fdf4338f-fd3a-446b-9688-b28515d38074	M1108.1 266.3h-2.1l-1 1.5-3.6.6-1.6.9-2.4-1.5h-3.2l-3.2-.7-1.9 1.3-2.9 1.3-1.9 4.2-2.6 4.3-3.8 1.1 2.9 2.5.8 1.9 3.2 1.5.7 2.5 3.1 1.8 1.4-1.3 1.4.7-1.1 1.1 1 1 1.8 2.6 1.9-.5 4 1 7.5.3 2.3-1.6 5.8-1.4 4 2.2 3 .7.4-7.4 1.6.5 2.3-1.3-.4-1.6-2.4-1.1-2.2 1-2.4-1.1-1.3-2.8.2-2.7-.6-2.7-3.4-3.7-1.9-2.6-1.8-1.9-1.6-.6z
131	389d713c-2ee8-4d87-b7d6-ad0221ee998b	ae5dee3a-1222-4f42-9f97-470ab88b3b7e	M1332.3 95.1l-4.5-4-13.6-4.1-9.4-2.1-6.2.9-5.3 2.9 5.8.8 6.6 3.2 8 1.7 11.5 1.3 7.1-.6zm-178.7-7.3l.9-.6-5.7-.9-2.8.7-1.3 1-1.5-1.2-5.2.1-6.2.8 7.7.1-1.1 1.3 4.4 1 3.6-.7.1-.7 2.9-.3 4.2-.6zm200.5 9.9l-1.5-1.8-12.5-2.6-3-.3-2.2.5 1.2 6 18-1.8zm15.2 6.3l-9.2-.7 3.4-1.2-8.2-1.5-6.1 1.9-1 2 1.5 2.1-6.9-.1-5.3 2.6-4.3-1.1-9.3.5.3 1.3-9.2.7-4.9 2.4-4.2.2-1.2 3.3 5.5 2.6-7.7.7-9.5-.3-5.8 1.1 4.8 5.4 6.9 4.3-9.6-3-7.9.3-5.1 2 4.5 3.8-4.9-1-2.1-5-4.2-2.8-1.8.1 3.6 3.7-4.6 3.5 8.1 4.2.4 5.4 2.9 2.9 4.7.5.4 3.5 4.4 3.1-1.9 2.6.5 2.7-3.7 1.4-.5 2-5.3-.8 3.5-7.8-.5-3.6-6.7-3.3-3.8-7.3-3.7-3.7-3.6-1.6.8-4.2-2.9-2.9-11.3-1.4-2.1 1 .5 4.7-4.3 4.7 1.2 1.7 4.7 4.1.1 2.6 5.3.5.8 1.1 5.8 2.9-1 2.8-18.5-6.1-6.6-1.7-12.8-1.6-1.2 1.7 5.9 3.1-2.7 3.6-6.4-3.2-5 2.2-7.6.1-2.1 1.9-5.3-.6 2.5-3.3-3.2-.2-12.3 4.6-7.6 2.6.4 3.5-6 1.2-4-1.9-1.2-3 5-.7-3.6-3-12.2-1.8 4.3 3.4-.8 3.2 4.7 3.3-1.1 3.8-4.6-1.9-4-.3-8 5.4 4.2 4.1-3.2 1.4-11.4-3.5-2.1 2.1 3.3 2.4.2 2.7-3.8-1.4-6-1.7-1.9-5.8-1-2.6-8-4 2.9-.7 20.1 4.2 6.4-1.5 3.7-2.9-1.6-3.6-4-2.6-17.6-6.1-11.6-1.3-7.6-3.2-3.6 1.8-6.4 2.2-3.2.5.4 3.7 7.2 3.7-2.8 4.1 6.4 6.3-1.7 4.8 4.9 4.1-.9 3.7 7.3 3.9-.9 2.9-3.3 3.3-7.9 7.4 5.3 2.8-4.5 3.2.9 1-2.6 3.4 2.5 5.5-1.6 1.9 2.4 1.4 1 2.8 2.1 3.6 5.2 1.5 1 1.4 2.3-.7 4.8 1.4 1 2.9-.6 1.6 3.7 3.9 2.2 1.1-.1 1.1 3.4 1.1 1.7 1.6-1.6 1.3-3.9-.2-.8.6 1.5 2 2 3.9 1.8.2 1-1.4 1.5.3 4.8-.5 3.8 3.4-.9 1.3.7 1.9 4 .2 2.2 2.7.2 1.2 6.6 2.2 3.5-1 3.6 2.9 2.9-.1 7.6 2 .4 1.9-1.3 3.2 1.8 3.4-.3 2.1-4.7.5-2.2 1.7.4 2.8 4.2-1 .4 1.3-6.8 2.6 3.2 2.4-3.2 5.2-3.4 1 5 3.6 6.2 2.4 7.4 5.1.5-.7 4.5 1.1 7.7 1 7.5 2.9 1.1 1.2 2.9-1 5.1 1.3 2.1 2.5 3.5 1.4 1.5.2 4.3 3.8 2.4.4.5-1.5 2.6-2.5-7.3-7.3-.4-4.1-5.9-5.9 3.5-6.3 4.6-1.1 1.4-3.7-2.8-1-.2-3.2-4.2-4.1-3.6.2-5.3-4.3 1.7-4.7-1.7-1.2 2.1-6.8 6 3.6-.7-4.6 8.1-6.6 7.5-.2 11.9 4.3 6.6 2.4 4.3-2.5 7.6-.2 7.3 3.2.8-1.8 6.9.3.2-3-9.4-4.2 3.6-2.9-1.5-1.7 3.9-1.6-5-4.1 1.4-2.1 16.8-2.1 1.7-1.5 10.8-2.2 3.1-2.5 9 1.3 4.3 6.3 4.3-1.5 7 2.1 1.2 3.3 4.4-.4 9.1-5.7-.8 1.9 8.3 4.7 18.1 15.5 1.1-3.3 8.3 3.6 6.2-1.6 3.2 1.1 4.1 3.6 3.9 1.2 3.3 2.6 6-.9 4.3 3.8 1.7-.5 4.7-1 6.6-5.4 5.9-2.9 5.3 1.9 5.1.1 4.7 2.9 5 .2 7.9 1.6 2.4-4.3-4-3.6 1.3-6.4 6.9 2.5 4.8.8 6.6 1.5 3.7 4.6 8.4 2.6 3.9-1.1 5.7-.8 5.4.8 6.5 3 4.9 3.1h4.5l6.7 1 3.6-1.6 5.8-1 4.5-4.4 3.3.7 3.9 2.1 5.5-.5 7.3 2.3 4.4-3.9-1.9-2.7-.1-6.5 1.2-2-2.5-3.3-3.7-1.5 1.7-3 5.1-1.1 6.2-.2 8.5 1.8 5.9 2.3 7.7 6.1 3.8 2.7 4.4 3.7 6.1 6.1 9.9 1.9 8.9 4.5 6 5.8h7.5l2.6-2.5 6.9-1.8 1.3 5.6-.4 2.3 2.8 6.8.6 6-6.8-1.1-2.9 2.2 4.7 5.3 3.8 7.3-2.5.1 1.9 3.1 1.4 1.1-.4-2 4-4.5 5.1 3 3.2-.1 4.4-3.6 1-3.7 2.1-7.1 1.9-7.2-1.3-4.3 1-9-5.2-9.9-5.5-7.3-1.3-6.2-4.7-5.1-12.7-6.7-5.6-.4-.3 3-5.8-1.3-5.7-3.8-8-.7 4.9-14.1 3.5-11.5 13.1-1.8 14.9 1 2.5-2.8 7.9.8 4.3 4.3 6.4-.6 8.4-1.6-7.7-3.5v-9.8l9.1-1.9 12.1 7.1 3.6-6.4-3.2-4.7 4.7-.5 6.5 8.1-2.4 4.6-.8 6 .3 7.5-5.7 1.3 2.8 2.7-.1 3.6 6.4 8.3 16 13.4 10.5 8.8 5.7 4.3 1.6-5.7-4.5-6.2 5.7-1.5-5.4-6.9 5-3.1-4.7-2.6-3.4-5 4.1-.2-9-8.6-6.7-1.4-2.9-2.4-1.1-5.6-3.1-3.9 7 .8 1.3-2.5 4.7 2.2 6.1-4.6 11.4 4-1.7-2.6 2-3.6 1.5-4 3.1-.7 6.5-4.3 9.8 1.2-.9-1.5-3.8-2.3-4.1-1.6-9.1-4.6-8.1-3 6.1.4 2-2.5-32.9-21.9-9.4-2.3-15.7-2.6-7.9.3-15.2-1.4 1.8 2.3 8.5 3.4-2.5 1.8-14.2-4.8-6.8.6-9.2-1.1-7 .2-3.9 1.1-7.2-1.6-5.1-3.8-6.5-2.2-9.2-.9-14.7 1-16.1-4-7.8-3-40.1-3.4-2.1 2.2 9.3 4.8-7.5-.7-1 1.5-9.7-1.6-5 1.4-9.3-2.4 3 5.5-8.9-2.1-10-4.1-.4-2.2-6-3.3-9.8-2.6h-6.1l-9.3-.9 4.7 3.9-17.2-.8-3.9-2.3-13.3-.9-5.3.8-.1 1.3-5.8-3.2-2.3.9-7.2-1.2-5.6-.7 1.1-1.5 6.6-2.8 2.3-1.5-2.4-2.5-5.5-1.9-11.5-2.3-10.8-.1-1.9 1.2-4.1-2.4zm-162.2 31.6l-9.9-4.3-3.1-4.3 3.3-4.9 2.8-5 8.6-4.7 9.8-2.4 11.3-2.4 1.3-1.5-4.2-1.9-6.6.6-4.9 1.8-11.7.9-10.1 3.1-6.8 2.7 2.5 2.2-6.6 4.4 3.9.7-5.4 4.3 1.6 2.8-3.4 1.1 1.9 2.8 7.9 1.4 2.2 2.3 13.4.7 2.2-.4zm314-24.7l-17.9-2.6-10.2-.2-3.4.9 3.4 3.4 12.4 3.2 4.5-1.2 14.2.2-3-3.7zm25.2 2.3l-11.7-1.3-8.2-.7 1.7 1.6 10.3 2 6.8.4 1.1-2zm-12.5 9.5l-2.5-1.4-8.3-1.9-4.1.5-.8 2 1.1.2 8.8.6h5.8zm162.6 12.3l-6-3.6-1.4 2.2 3.5 1.6 3.9-.2zM1084 228.9l-.6-1.5.2-1.7-2.2-.9-5-1.1-6.3 2-.7 2.6 5.9.7 8.7-.1zm589.7 21.8l-7.2-6.2-5.1-6-6.8-5.8-4.9-4-1.3.8 4.4 2.8-1.9 2.8 6.8 8.3 7.8 6 6.4 8.3 2.4 4.6 5.5 6.8 3.8 6 4.6 5.2-.1-4.8 6.5 3.8-3-4.4-9.5-6.3-3.7-9 8.9 2-13.6-10.9z
132	06de8f67-a69a-4d9b-aa75-c7c3fef51860	418d8911-a62b-4686-bf0e-f18b204398d8	M1147.6 579.4l-3.3 1.9-1.4-.6-1.6 1.8-.2 3.8-.8.4-.6 3.5 3.5.5 1.7-3.6 3 .4 1.6-.8.4-3.7-2.3-3.6z
133	4d17fdd5-7d68-4de8-a223-eae455d8d3cc	e3b26362-6759-4612-8863-4785505a679e	M637.4 484.2l.1-1.2-.1-.5-.2.1-.3.4-.4.6-.1.3v.6l.6.4.4-.7z
134	05b85afd-1d8c-4a12-890f-29d40b4c9e1e	ab4bc3a4-7c19-4a94-905c-a7973e0feaff	M1014.1 571.4l.5-.8v-.5l-.3-.5h-.4l-.5.4-.3.4v.3l.1.7.1.3.3.2.5-.5zm4.3-9.2l.2-.4v-.2l-.1-.1-.1-.1-.2.1-.3.5.1.2.2.2.2-.2z
135	11762299-90d8-4daa-8abe-4b142fc6f483	dfffd0b6-a252-421b-94cb-6d44695c5c8c	M1228.7 387l-10.2-.5-16.7-12.7-8.5-4.5-6.7-1.7-.9 1-10.4 3.1 6.1 6.4-1.7 1-.7 2.2-4 .8-1.1 2.3-2.1 2-6.1-1-.5 2.5v2.2l-.6 3.5h2.7l3.2 4.4 3.7 5.1 2.5 4.7 1.7 1.5 1.7 3.3-.2 1.4 2.1 3.7 3 1.3 2.8 2.5 3.6 7v3.8l.9 4.4 4 6.1 2.5 1 4.1 4.4 1.9 5.2 3.2 5.3 3 2.3.6 2.5 1.8 1.9.9 2.8 2.3-2.1-.7-2.7 1.2-3.1 2.4 1.7 1.5-.6 6.4-.2 1 .7 5.4.6 2.1-.3 1.6 2.1 2.5-1 3.5-6.7 5-2.9 15.7-2.4 16.1-6.4 2.6-12.7-2.9-4.5-1 1.3-16.8-3.2-2.6-6.4-.4-1.5-1.2-2.4-1.5.4-1.8-1.2-1-1.6-.9-2.1-1.7-1.8-1-2.1.4-2.1-.6-2.7-4-2.6-1.2-2.3-2.9-1.4-2.7-5.5-3.8.2-1.7-3.1-4.9-.6z
136	32573d25-ff59-4754-84d3-0d3138cc78a8	e98795b2-4086-41b5-bac1-4789d9aee005	M908.9 479.2l-3.6-4.4-3.2-4.7-3.7-1.7-2.6-1.8h-3.1l-2.8 1.4-2.7-.5-2 2-1.3 3.3-2.8 4.4-2.5 1.2 2.7 2.3 2.2 5 6.1-.2 1.3-1.5 1.8-.1 2.1 1.5 1.8.1 1.8-1.1 1.1 1.8-2.4 1.5-2.4-.1-2.4-1.4-2.1 1.5h-1l-1.4.9-5-.1.8 4.9 3-1.1 1.8.2 1.5-.7 10.3.3 2.7.1 4 1.5 1.3-.1.4-.7 3 .5.8-.4.3-2-.4-2.4-2.1-1.8-1.1-3.7-.2-3.9z
137	20313c40-deef-49d1-9c15-7e1865d11e73	aae2ba87-a67d-43bd-8516-e403843d61d9	M1084.8 285.2l-3.2-1.5-.8-1.9-2.9-2.5-3.2-.2-3.7 1.6 1.5 2.4 1.7 1.8-1.7 2.3h1.8l-1 2.7 2.7 2.3-.5 2.9-1.2.3 1.5 1.1.8.8 1.8.7 2 1.2-.4.6 1.2-.5.5-2 .9-.4.8.9 1 .4.8 1 .8.3 1.1 1.1h.8l-.5 1.5-.5.7.2.5 1.7-.4 2.4-.1.7-.9-.6-.7.7-2 1.7-1.9-2.8-2.6-.7-2.3 1.1-1.4-1-1 1.1-1.1-1.4-.7-1.4 1.3-3.1-1.8-.7-2.5z
138	f443e613-3734-413b-ba6b-46b4f6943221	4998e162-96ca-4381-ab19-3dc43922884a	M1288.5 602l-.5-.8-.4.3.2.3.3.2.1.4.3.2v-.6z
139	84afb816-bad1-4620-9b76-7ed66f9d6a9f	d8df4bc3-503b-41ca-987e-423e41ecb52c	M919.4 518.7l-1.5.3v-2.3l-.9-1.7.2-1.8-1.2-2.7-1.5-2.3H910l-1.3 1.2-1.5.2-1 1.4-.7 1.7-3 2.8.7 4.7.9 2.3 2.9 3.5 4.1 2.5 1.5.5 1.3-2 .3-1.9 2.6-3.4 2.6-3z
140	a04ae191-e705-49dc-9b21-88c965594e62	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	M1561 563.7l.1-.2-.2-.2-.3-.1-.5-.2-.6.1-.3.6.9.4.9-.4z
143	0dced16d-dabc-4347-ad39-786cc3b43636	b7f76500-4fa3-457f-aca8-477f05aab728	M1909.1 646.4l-.2-.2-.1-.4h-.3l-.3.1.2.6h.2l.5-.1zm-35.6.8l-.1-.2-.5-.4-1.9-1.3-.4-.1-.1.1-.1.3.1.2.5.1v.1l.3.2.7.2.4.3.1.5.3.1.3.1.4-.2zm32-6.6v-.1l.2-.3-.2-.1-.5-.1-.7.1-.3.2-.2.3h-.2v.2l.1.4.2-.1.2.1.5-.5h.4l.5-.1zm-24.4-2.3l-.1-.2-.2-.1-.9-.7-.5-.2h-.5l-.1.5v.3h.6l.4.2v.6l.2.2v.5l1.2.9.7.4.7.1.4.2.5-.1.5.2.4-.1-.4-.3v-.4l-.5-1.3-.3-.3-.5.1-.5-.2h-.4l-.7-.3zm-.4-4.9l-.6-1.6-.2-.1.1.6.1.4-.1.5-.1.6.2.2.2-.2.4.5V633.4zm-9.8-2.2l-.3-.1-.4.3-.1.3-.1.7v.4l.3.7.3.5.3.3.2.2.9.1 1.7.1.9.4.9.2.4-.1.5-.2.1-.1-.1-.6-.2-.3-.4-.2-.2-.6-.5-.4-.9-.7h-1.6l-.6.1-1.1-1zm2.6-1.8l-.5.2v.3l.4.1.4.2.1.3.2-.1.4.2.2-.3-.4-.5-.4-.3h-.1l-.3-.1zm-5.6.8l.3-.2v-.4h-.3l-.1-.2h-.2l-.3.2-.2.3.1.2h.4l.2.1h.1zm-8.4-2.3l-.1-.2-.3-.2h-.2l-.5.1.1.1.6.3.3.1.1-.2zm3.1.4l.3-.2-.1-.2-.1-.5-.4.7.1.2h.2zm-.5-.9v-.4l-.2-.1.4-.3-.1-.1-.6-.2-.2.2-.2.1-.1.1-.1.1-.1.5.2.4.4.2.6-.5zm-4 .2l-.3-.4.1-.5.2-.1.2-.5-.1-.4-.2.1-.7.6-.1.3.6.8.3.2v-.1zm13-1.3l-.2-.4v-.2l-.3-.2-.2.1-.1.3.1.2.4.3.3-.1zm6-1.2h-.2l-.1.1h-.5l-.1.2.6 1.1-.3.5.4 2.2.4 1.2.8.8v.2l.8.5.6 1.3.2.1.1-.2v-.6l-.5-1.1.1-.8-.2-.3v-.3l-.2-.8-.6-.7-.3-.1-.2-.3.2-.6.2-.2.1-.3-1.3-1.9zm-16.6-.5l-.6-.2-.2-.3v-1l-.6-.3-.3.2-.6.7-.2.4-.5.3-.1.3v.4l.4.1.3-.4.9-.1.3.1v.4l.1.7.3.3.5.2.4.6.1-.3h.2l.2-.4-.3-1.2-.3-.5zm-6.5-.4l.1-.5-.1-.9-.2.1v.2l-.1.4.2.8.1-.1zm3.2-.4l.2-.2v-.9l-.2-.4-.2-.2-.5.1-.4.5v.5l.4.6h.7zm-2.6-1.2l.2-.3.5-.7.1-.3-.5-.2-.4-.5-.4-.2-.3.4v.4l.5.6-.1.4.2.1.1.4.1-.1zm17.5 3.9l-.1-.5-.3-.4.4-.5-2.2-1.9-.3-.2-.4-.1-.5-.4-.5-.1-.5-.4-.2-.3-.6-.4-.6-.8-1.5-.3.1.2.4.4.1.7.5.4.5.6.2.1.2.2.4.5.8.4.8.6.3.1.3.3 1.5.7.5.7.7.5v-.1zm-21.8-9.2l.2-.3-.7-.5-.2.3-.2.5.4.2.5-.2zm9.1 1.5l-.1-.1h-.3l-.4-.2-.7-.8-.2-.3-.2-1-.4-.4-1.4-.8-.8-.8-.7-.2-.2.2v.5l.2.3 1 .9 1.1 1.7 1 1 .8.1h.4v.1l.1.2.5.2.5-.4-.2-.2z
144	846c0fbe-d830-478b-89eb-302532869ac4	98943525-f93f-426f-a3fe-b48bc18c0c52	M1223.4 505.7l-2.6-2.7-1.2-2.6-1.8-1.2-2 3.4-1.1 2.3 2.2 3.5 2.1 3.1 2.2 2.2 18.5 7.6 4.8-.1-15.4 19.1-7.4.3-4.9 4.5-3.6.1-1.5 2-4.8 7.2.2 23.2 3.3 5.3 1.3-1.5 1.3-3.4 6.1-7.7 5.3-4.8 8.3-6.4 5.6-5.1 6.4-8.7 4.7-7.1 4.6-9.3 3.2-8.2 2.5-7.1 1.3-6.8 1.1-2.3-.2-3.4.4-3.7-.2-1.7h-2.1l-2.6 2.2-2.9.6-2.5.9-1.8.2-3.2.2-1.9 1.1-2.8.5-4.8 1.9-6.1.8-5.2 1.6h-2.8z
145	e952274d-9d63-4247-b24b-fdd9ea57d65d	247ff0fd-78ad-4ca4-90f2-f0394a714535	M1148.2 713.7l-2.9-.6-1.9.8-2.6-1.1-2.2-.1-8 4.7-5.2 4.7-2 4.3-1.7 2.4-3 .5-1.2 3-.6 2-3.6 1.5-4.4-.3-2.5-1.8-2.3-.8-2.7 1.5-1.5 3.1-2.7 1.9-2.8 2.8-4 .7-1.1-2.3.7-3.8-3-6.1-1.4-1-1.1 23.6-5 3.2-2.9.5-3.3-1.2-2.4-.5-.8-2.7-2.1-1.8-2.7 3.2 3.5 8.2v.1l2.5 5.3 3.2 6-.2 4.8-1.7 1.2 1.4 4.2-.2 3.8.6 1.7.3-.9 2.1 2.9 1.8.1 2.1 2.3 2.4-.2 3.5-2.4 4.6-1 5.6-2.5 2.2.3 3.3-.8 5.7 1.2 2.7-1.2 3.2 1 .8-1.8 2.7-.3 5.8-2.5 4.3-2.9 4.1-3.8 6.7-6.5 3.4-4.6 1.8-3.2 2.5-3.3 1.2-.9 3.9-3.2 1.6-2.9 1.1-5.2 1.7-4.7h-4.1l-1.3 2.8-3.3.7-3-3.5.1-2.2 1.6-2.4.7-1.8 1.6-.5 2.7 1.2-.4-2.3 1.4-7.1-1.1-4.5-2.2-9zm-20.1 52.8l-2 .6-3.7-4.9 3.2-4 3.1-2.5 2.6-1.3 2.3 2 1.7 1.9-1.9 3.1-1.1 2.1-3.1 1-1.1 2z
146	99f0a516-c2f9-40b0-92e9-844abd61f86b	3ffea3be-1c82-411a-b085-933205f900c7	M1166 508.7l-.7-2.2-2.9-2.5-.8-4.6.5-4.7-2.6-.5-.3 1.5-3.4.3 1.4 1.8.6 3.9-3 3.5-2.7 4.5-2.8.7-4.8-3.7-2.1 1.3-.5 1.9-2.9 1.2-.2 1.3h-5.5l-.8-1.3-4.1-.3-2 1.1-1.5-.5-3-3.7-1-1.8-4 .9-1.5 2.9-1.3 5.7-1.9 1.2-1.7.7 3.8 2.5 3.1 2.6.1 2 3.8 3.4 2.4 2.7 1.5 3.8 4.2 2.5.9 2.1 3.5 5.2 2.5.8 1.5-1.1 2.6.4 3.1-1.3 1.4 2.7 5 4.2 2.3-1.7 3.5 1.4 4.5-1.5 4 .1 3.4-3 3.4-3.8 3.8-4.2-3.5-6.9-2.6-1.5-1-2.5-2.9-3.1-3.4-.5 1.8-3.6 3-.1.8-2-.2-5-.8-.1v-3.1z
147	756120d3-54c8-4cd9-be53-c9e3999de94a	02e5c743-3075-4226-8c1d-ad97dadda3d8	M985 325.7v-.2h-.5l-.3-.4-.1.2-.1.2v.2h.5l.4.1.1-.1zm-.8-1.6h.3l.6-.7v-.3l-.3-.2-1.1.2-.2.3v.3l-.3.1-.1.4.1.2.8.1.2-.4zM967 296l-8.2-.2-4.2.3-5.4-1h-6.8l-6.2-1.1-7.4 4.5 2 2.6-.4 4.4 1.9-1.6 2.1-.9 1.2 3.1h3l.9-.8 3 .2 1.3 3.1-2.4 1.7-.2 4.9-.9.9-.3 3-2.2.5 2 3.8-1.6 4.3 1.8 1.9-.8 1.7-2 2.5.4 2.1 4.8 1 1.4 3.7 2 2.2 2.5.6 2.1-2.5 3.3-2.3 5 .1h6.7l3.8-5 3.9-1.3 1.2-4.2 3-2.9-2-3.7 2-5.1 3.1-3.5.5-2.1 6.6-1.3 4.8-4.2-.3-3.5-6 .8-5.7-2.8-1.9 1.3-9.4-2.8-2-2.4zm26 22.6l.1-.3.1-.2.1-.1-.2-.2v-.1l.2-.2-.2-.1-1.3.4-.7.4-2.1 1.5v.3l.1.2h.4l.2.4.4-.4.3-.1.3.1.3.2.1.6.1.2.6.1.9.4.4-.2.5-.3.2-.6.3-.5.3-.5.3-.4-.1-.4-.3-.1-.3-.1-.5.2-.5-.2zm6-.3l.1-.4v-.1l-.5-.7-.9-.3-1 .1-.1.1v.4l.1.1.6.1 1.6.7h.1z
148	355b6725-a64a-4e0b-86fd-9bbe9558472d	6c6c9e3f-2353-431c-83c4-2c0cc6c42ff6	M1432.2 532.7l2.3-1.8.6-6.6-3-6.6-2.9-4.5-4.1-3.5-1.9 10.3 1.4 9.1 2.8 5.1 4.8-1.5z
149	e53b85ff-3591-4355-9c7b-a0429a117327	ec506881-6436-49fc-b56e-42da02dd7d5b	M629.9 463.2v-.3l-.2-.2h-.3v.5l.2.2.3-.2zm-.5-.7l-.1-.2-.1-.1-.2-.4-.4-.4-.2.1-.1.2v.1l.3.3.4.1.2.4.2-.1z
150	865c27b1-ee2f-4156-ba2b-d04846b578d4	c149c091-51c2-41d7-85a7-7d67bcac4230	M1180.8 468.5l.4-4.2 1.6-2 4-1 2.6-3.6-3.1-2.4-2.2-1.6-2.5-7.6-1.1-6.5 1.1-1.2-2.1-6.2H1114.2l.5 12.7h-6.3v2.7l1.1 25.2-4.8-.4-2.4 4.7-1.4 3.9 1.2 1.5-1.8 1.9.7 2.7-1.4 2.6-.5 2.4 2-.4 1.2 2.5.1 3.7 2.1 1.8v1.6l.7 2.7 3.3 4v2.6l-.8 2.6.3 2 2 1.8.5.3 1.7-.7 1.9-1.2 1.3-5.7 1.5-2.9 4-.9 1 1.8 3 3.7 1.5.5 2-1.1 4.1.3.8 1.3h5.5l.2-1.3 2.9-1.2.5-1.9 2.1-1.3 4.8 3.7 2.8-.7 2.7-4.5 3-3.5-.6-3.9-1.4-1.8 3.4-.3.3-1.5 2.6.5-.5 4.7.8 4.6 2.9 2.5.7 2.2v3.1l.8.1v-.7l1.4-6.7 2.6-1.8.5-2.6 2.3-4.8 3.2-3.2 2.1-6.2.7-5.5-.7-2.5 1.9-9.4z
151	a30129ed-96a5-40bf-83b1-61d9f9443001	e0e0a4c5-9076-4a1e-949f-9dd4521eb0f3	M668 533.8l-4.6.5-.6 1.1-6.7-1.2-1 5.7-3.5 1.6.3 1.5-1.1 3.3 2.4 4.6 1.8.1.7 3.5 3.3 5.6 3.1.5.5-1.3-.9-1.3.5-1.8 2.3.6 2.7-.7 3.2 1.4 1.4-2.7.6-2.9 1-2.8-2.1-3.7-.4-4.4 3.1-5.5-6-1.7z
152	28a5c3d0-cd90-404a-9f47-3bf74088c244	5c3dd764-6824-4689-a3e1-1d8c2dc3bc93	M1077.7 161.1l-1.9-2.2-1.7-8.4-7.2-3.7-5.9-2.7-2.5.3v3.5l-7.9-.9-.6 3.1-4-.1-2.2 3.9-3.4 6.1-5.7 7.9 1.8 1.9-1.3 2.2-4.3-.1-2.3 5.3 1 7.6 3.1 2.9-.9 6.9-3.4 4-1.7 3.3 4.2 8.4 4.4 6.7 2 5.7 5.3-.3 2.2-4.7 5.7.5 2-5.5.6-10 4.6-1.3 3.3-6.6-4.8-3.3-3.6-4 2.1-8.1 7.7-4.9 6.1-4.5-1.2-3.5 3.4-3.9 7-1.5z
153	504458d1-39f8-4154-b834-b6df676a496b	dacd5cdd-8e56-4067-bfd8-febc66a04058	M1024.3 270.6l-5.4-1.9-1 1.4h-4.2l-1.3 1-2.3-.6.2 1.6-3.5 3.5v2.8l2.4-.9 1.8 2.7 2.2 1.3 2.4-.3 2.7-2.1.9 1 2.4-.2.9-2.5 3.8.8 2.1-1.1.3-2.5-2.6-.2-2.3-1.1.7-1.6-.2-1.1z
154	29d03348-f8a9-4b0d-b019-26f2db9d4a54	7073c668-a71d-4cf0-a8dd-71008877f8ca	M1183.5 359.9l11-6.7.9-7.8-1.2-4.7 2.7-1.6 2.1-4.1-5.9 1.1-2.8-.2-5.7 2.5h-4.3l-3-1.2-5.5 1.8-1.9-1.3.1 3.6-1.2 1.5-1.2 1.4-1 2.6 1.1 5 2.4.3 1.2 2.5-2.6 2.4-.9 3.5.3 2.6-.6 1h.1l6.3 2.5 9.6-6.7z
155	3c6ea1cf-7057-4799-a891-9177b632aac6	893ca48d-0871-46b1-b299-4bf7e7c98dfa	M1344.1 315.7l-2.1.2-1.3-1.8.2-2.9-6.4 1.5-.5 4-1.5 3.5-4.4-.3-.6 2.8 4.2 1.6 2.4 4.7-1.3 6.6 1.8.8 3.3-2.1 2.1 1.3.9-3 3.2.1.6-.9-.2-2.6 1.7-2.3 3.2 1.5v2l1.6.3 1 5.4 2.6 2.1 1.5-1.3 2.1-.7 2.5-2.9 3.8.5h5.4l-1.8-3.7-.6-2.5-3.5-1.4-1.6.6-3-5.9-9.5.9-7.1-2-5.4.5-.6-3.7 5.9 1.1 1.4-2z
156	82d7ebc0-0fe2-4a3c-a483-c1a59269812b	1bf315d2-0a2d-4686-9ecb-6d28f8a5b861	M1149.6 578.6l-2 .8 2.3 3.6-.4 3.7-1.6.8.3 2.5 1.2 1.5v2l-1.4 1.4-2.2 3.3-2.1 2.3-.6.1-.3 2.7 1.1.9-.2 2.7 1 2.6-1.3 2.4 4.5 4.3.3 3.9 2.7 6.5.3.2 2.2 1.1 3.5 1.1 3.2 1.9 5.4 1.2 1.1 1.7.4-1.2 2.8 3.4.3 6.7 1.8 2.4v.1l2.1-.3 6.7 1.8 1.4-.8 3.9-.1 2.1-1.9 3.3.1 6.2-2.5 4.6-3.7-2-1.4-2.2-6.3-1.8-3.9.4-3.1-.3-1.9 1.7-3.9-.2-1.6-3.5-2.3-.3-3.6 2.8-7.9-8-6.3-.4-3.7-20.2-13-2.8 2.8-1.9 2.9 2.2 2.2-3.2 1.6-.7-.8-3.2.4-2.5 1.4-1.6-2.4 1.1-4.5.2-3.8-6.2-.1z
157	d4b6565b-010f-4314-87c6-797f4fc721ac	99d1c02c-0a04-4eae-b6cd-403f94e43959	M1562.7 481.4l1.5-2.9-.5-5.4-5.2-5.5-1.3-6.3-4.9-5.2-4.3-.4-.8 2.2-3.2.2-1.8-1.2-5.3 3.8-1-5.7.4-6.7-3.8-.3-.9-3.8-2.6-1.9-3 1.4-2.8 2.8-3.9.3-1.5 6.9-2.2 1.1 3.5 5.6 4.1 4.6 2.9 4.2-1.4 5.6-1.7 1.1 1.7 3.2 4.2 5.1 1 3.5.2 3 2.8 5.8-2.6 5.9-2.2 6.6-1.3 6.1-.3 3.9 1.2 3.6.7-3.8 2.9 3.1 3.2 3.5 1.1 3.2 2.4 2.4.9-1.1 4.7 2.8.6 3.3 3.7-.8 1.7-2.6-3.1-3.3-3.4-.8-3.3-3.6-1.4-5.5-2.6-5.8-3.7-.2-.7-4.6 1.4-5.6 2.2-9.3-.2-7 4.9-.1-.3 5 4.7-.1 5.3 2.9-2.1-7.7 3-5.2 7.1-1.3 5.3 1z
158	4f7aae59-c209-4ae9-96e4-3fc008646f96	1a61eb0b-45a3-4b91-89c2-c22a20676491	M1676.8 631.9l4.9-1.8 6-2.8 2.2-1.7-2-.8-1.8.8-4 .2-4.9 1.4-.8 1.5.5 1.3-.1 1.9z
159	858408f6-e54b-4089-a5f3-d5e7bb9e9193	1a7ba610-72c3-4816-81b5-aad9503a4a9b	M981.7 502.2l-4.9-.1-.4 1.9 2.4 3.3-.1 4.6.6 5.1 1.4 2.3-1.2 5.7.4 3.2 1.5 4 1.2 2.2 4.6-1.3-1.4-4.4.2-14.6-1.1-1.3-.2-3.1-2-2.3-1.7-1.9.7-3.3z
160	7877f772-a380-43d2-ba84-b38681643fbf	85e41f4f-c125-4753-bbed-c2ffc7e1c288	M13.3 707.7l-.2.3v.2l.4.4-.2-.9zm-1.6-.9h-.2l.2-.1-.4-.2h-.4l-.2-.1v-.2l-.2.3.2.3.9.4.3.2.2-.6v-.2l-.3.1v.1h-.1zm2.5-16l.1-.2v-.2l-.3-.1h-.1l-.3.5.1.1.3.2h.1l.1-.3z
161	f5a4e7e5-2be9-430f-8624-46e98b6d6123	06659bc5-9958-457e-ac56-2860917a3d28	M635.4 507.7l.1-.2v-.6l.2-.4-.2-.4-.1-.6.1-.5v-.7l.2-.3.5-.8h-.9l-.6.2-1.1.1-.5.2-.7.1-.4.2.1.1.5.2.2.2.1.2.1.4-.3 1.7-.1.1-.6.1-.2.3-1.4.8.8-.1.9.1 2.4-.1.9-.3zm1.8-6.7l1.2-.5.1-.4h-.2l-.8.3-.6.5v.2l.3-.1z
162	4c73d72a-5931-4e2a-adf8-9fcbdb22af3c	cac7a781-be5d-4c59-b9b8-d8bb65fb1487	M1038 361.4l-2-1-1.5-3-2.8-.1-1.1-3.5 3.4-3.2.5-5.6-1.9-1.6-.1-3 2.5-3.2-.4-1.3-4.4 2.4.1-3.3-3.7-.7-5.6 2.6-1 3.3 1 6.2-1.1 5.3-3.2 3.6.6 4.8 4.5 3.8v1.5l3.4 2.6 2.6 11.3 2.6-1.4.4-2.7-.7-2.6 3.7-2.5 1.5-2 2.6-1.8.1-4.9z
163	22a71094-55e2-4852-86fa-f27db4799a22	fb99fe5c-118c-44d8-97ba-6570cdb7bd33	M1166.6 308.9l-9.7-4.4-8.5.2-5.7 1.7-5.6 4-9.9-.8-1.6 4.8-7.9.2-5.1 6.1 3.6 3-2 5 4.2 3.6 3.7 6.4 5.8-.1 5.4 3.5 3.6-.8.9-2.7 5.7.2 4.6 3.5 8-.7 3.1-3.7 4.6 1.5 3.2-.6-1.7 2.4 2.3 3 1.2-1.4 1.2-1.5-.1-3.6 1.9 1.3 5.5-1.8 3 1.2h4.3l5.7-2.5 2.8.2 5.9-1.1 2.1-1 6.2.9 2.1 1.6 2.3-1.1-3.7-5.2.7-2-2.9-7.3 3.3-1.8-2.4-1.9-4.2-1.5v-3.1l-1.3-2.2-5.6-3-5.4.3-5.5 3.2-4.5-.6-5.8 1-7.8-2.4zm-49.6 4l2-1.9 6.1-.4.7-1.5-4.7-2-.9-2.4-4.5-.8-5 2 2.7 1.6-1.2 3.9-1.1.7.1 1.3 1.9 2.9 3.9-3.4z
164	13310a40-4260-4267-8199-3139bbfc7082	0adc54bf-ff91-4cb0-8571-d89b779f1061	M1325.6 334.2l-.8-4-7.7-2.7-6.2-3.2-4.2-3-7-4.4-4.3-6.4-2-1.2-5.5.3-2.3-1.3-1.9-4.9-7.8-3.3-3.3 3.6-3.8 2.2 1.6 3.1-5.8.1-2.5.3-4.9-4.9-3.8-1.7-5.5 1.3-1.8 2 2.5 4-.5-4.5 3.7-1.6 2.4 3.6 4.6 3.7-4 2-5.3-1.5.1 5.2 3.5.4-.4 4.4 4.5 2.1.7 6.8 1.8 4.5 4.4-1.2 3-3.7 3.5.2 2.1-1.2 3.8.6 6.5 3.3 4.3.7 7.3 5.7 3.9.2 1.6 5.5 5.9 2.4 3.9-.8.4-3 4-.9 2.5-2-.1-5.2 4.1-1.2.3-2.3 2.9 1.7 1.6.2z
165	9ea2aaa4-f87a-47d6-835d-d30796cd1ccf	2b1a33fe-be25-452b-8a1c-c7d5f1dce9c2	M1283.9 408.6l-1.3-2.2-3 3.9-3.7 4.1-3.3 4.3-3.3-.2-4.6-.2-4.2 1-.3-1.7-1 .3.4 1.5 2.6 6.4 16.8 3.2 1-1.3-.1-2.6 1.4-2.6-.3-2.6 2.4-1.3-1.1-.8.1-4.2h2.8l-1.3-5z
166	58a13794-53e1-4f99-93f3-1e350f98f84f	c5ce24da-dd58-4e8e-a5e3-91b478717bb4	M1167.6 545.1l-3.4 3-4-.1-4.5 1.5-3.5-1.4-2.3 1.7-.3 7.5 2.3.8-1.8 2.3-2.2 1.7-2.1 3.3-1.2 3-.3 5.1-1.3 2.4-.1 4.8 1.4.6 3.3-1.9 2-.8 6.2.1-.3-2.5 2.6-3.7 3.5-.9 2.4-1.5 2.9 1.2.3.5v-.3l1.6-2.6 2.7-4.2 2.1-4.7-2.6-7.3-.7-3.2-2.7-4.4z
167	c5e358a8-3943-488b-ad1a-e73571fc71cb	6b63bb5b-0238-4263-bdf4-8064a4fb5c26	M1138.5 241l-4.8.5-1.5-.3-1 1.4-1.8-.2-4.1.3-1.2 1.4.2 3.1-2-.6-4.3.3-1.5-1.5-1.6 1.1-2-.9-3.8-.1-5.6-1.5-5-.5-3.7.2-2.4 1.6-2.2.3 3.1 5.3-.3 1.8-2.3.7-3.8 5.1 1.6 2.8-1.1-.4-1.1 1.7-.7 2.5 2.9 1.7.6 1.6 1.9-1.3 3.2.7h3.2l2.4 1.5 1.6-.9 3.6-.6 1-1.5h2.1l1.1-.9 3.2-.6 3.9 1.9 2 .3 2.5 1.6v2.1l1.9 1.1 1.1 2.6 2 1.5-.2 1 1 .6-1.2.5-3-.2-.6-.9-1 .5.5 1.1-1.1 2-.5 2.1-1.2.7 2.4 1.1 2.2-1 2.4 1.1 3.3-4.6 1.3-3.4 4.5-.8.7 2.4 8 1.5 1.7 1.4-4.5 2.1-.7 1.2 5.8 1.8-.6 2.9 3 1.3 6.3-3.6 5.3-1.1.6-2.2-5.1.4-2.7-1.5-1-3.9 3.9-2.3 4.6-.3 3-2 3.9-.5-.4-2.8 2.2-1.7 4.7-.5.3-2.1-1.8-3.4 1.3-3.2-.4-1.9-7.6-2-2.9.1-3.6-2.9-3.5 1-6.6-2.2-.2-1.2-2.2-2.7-4-.2-.7-1.9.9-1.3-3.8-3.4z
168	651ccb00-c014-4f15-83ce-cacacd83422f	0f433ba9-47e1-4fe6-902c-632bf40355a9	M950 227.5l-4.9-3.7-3.9.3.8 3.2-1.1 3.2 2.9-.1 3.5 1.3 2.7-4.2zm13-24.3l-5.5.5-3.6-.4-3.7 4.8-1.9 6.1 2.2 3 .1 5.8 2.6-2.8 1.4 1.6-1.7 2.7 1 1.6 5.7 1.1h.1l3.1 3.8-.8 3.5-7.1-.6-1 4 2.6 3.3-5.1 1.9 1.3 2.4 7.5 1-4.3 1.3-7.3 6.5 2.5 1.2 3.5-2.3 4.5.7 3.3-2.9 2.2 1.2 8.3-1.7 6.5.1 4.3-3.3-1.9-3.1 2.4-1.8.5-3.9-5.8-1.2-1.3-2.3-2.9-6.9-3.2-1-4.1-7.1-.4-.6-4.8-.4 4.2-5.3 1.3-4.9h-5l-4.7.8 5-6.4z
169	3b371b11-f90c-4f13-8466-368b757de398	d95a4486-5ca4-4500-8b10-211b945552c8	M692.5 787l-2.1-3.7 1.9-3-3.8-4.3-4.8-3.5-6.2-4.1-1.9.2-6.2-4.9-3.4.7-.5 5.1-.3 6.5 1.1 6.3-.9 1.4.4 4.2 3.9 3.5 3.6-.2 5.4 2.7 2.7-.6 4.2 1.2 5.3-3.5 1.6-4z
170	bea4007a-1369-43ad-bde1-23dcca4252d2	0bea6297-7d53-49a7-927e-e5cbc57e3b5a	M116.7 450.7l2-.9 2.5-1.4.2-.4-.9-2.2-.7-.8-.8-.6-1.9-1.1-.4-.1-.4.6v1.3l-1.2 1-.4.7.4 2.3-.6 1.8 1.2.9 1-1.1zm-.6-9.9l.6-.7-1.2-1-1.8-.6-.7.5v.4l.5.5.6 1.4 2-.5zm-3-3.4l-2.6-.2-.6.7 2.9.2.3-.7zm-4.7-.9l-1.1-2.1-.3-.4-1.7.9.1.2.4 1.5 1.8.2.4.1.4-.4zm-8.3-4.2l.3-1.5-1.3-.1-1 .6-.4.5 1.6 1.1.8-.6zm412.1-173.2h-1.6l-1.3 2.4H373.4l-1.6 5.1-2.4 5.1-2.3 1.6 1.1-5.9-5.8-2.1-1.4 1.2-.4 2.9-1.8 5.4-4.2 8.3-4 5.6-4 5.6-5.4 5.8-1.1 4.7-2.8 5.3-3.9 5.2 1 3.4-1.9 5.2 1.5 5.4 1.3 2.2-.8 1.5.4 9 2.5 6.5-.8 3.5 1 1 4.6.7 1.3 1.7 2.8.3-.1 1.9 2.2.7 2.1 3.7-.3 3.2 6.3-.5 7-.7-1 1.3 7.1 3.1 10.7 4.4h15l.8-2.6h9.3l1.3 2.2 2.1 2 2.4 2.8.8 3.3.4 3.5 2.2 1.9 4 1.9 4.8-5 4.4-.1 3.1 2.5 1.6 4.4 1 3.7 2.4 3.6.2 4.5.8 3 3.9 2 3.6 1.4 2.1-.2-.6-2.2.4-3.1 1-4.4 1.9-2.8 3.7-3.1 6-2.7 6.1-4.7 4.9-1.5 3.5-.4 3.5 1.4 4.9-.8 3.3 3.4 3.8.2 2.4-1.2 1.7.9 1.3-.8-.9-1.3.7-2.5-.5-1.7 2.4-1 4.2-.4 4.7.7 6.2-.8 3 1.5 2 3 .9.3 6.1-2.9 1.9 1 3 5.3.8 3.5-2 4.2.4 2.5 1.6 4.9 2 5.5 1.8 1.4.4 2.8 2.6.8 1.7-.8 2-3.9.7-2.5.9-4.3-1.2-7.4.5-2.7-1.5-4.5-.7-5.4.1-4.4 1.8-4.5 3.5-3.8 3.7-3 6.9-4.1 1.3-2.2 3.3-2.3 2.8-.4 4.4-3.8 6-1.9 4.6-4.8.9-6.5.1-2.2-1.4-.4 1.5-6.2-3-2.1 3.2 1v-4.1l1.9-2.7-1 5.3 2 2.5-2.9 4.4.4.2 4.4-5.1 2.4-2.5.6-2.5-.9-1.1-.1-3.5 1.2 1.6 1.1.4-.1 1.6 5.2-4.9 2.5-4.5-1.4-.3 2.1-1.8-.4.8h3.3l7.8-1.9-1.1-1.2-7.9 1.2 4.8-1.8 3.1-.3 2.4-.3 4.1-1.1 2.4.1 3.8-1 1-1.7-1.1-1.4-.2 2.2-2.1-.1-.6-3.3 1.1-3.3 1.4-1.3 3.9-3.7 5.9-1.8 6-2.1 6.3-3-.2-2-2.1-3.5 2.8-8.5-1.5-1.8-3.7 1.1-1.1-1.7-5.5 4.7-3.2 4.9-2.7 2.8-2.5.9-1.7.3-1 1.6h-17l-2.7 1.2-6.7 4.2.2.9-.6 2.4-4.6 2-3.9-.5-4-.2-2.6.7-.3 1.8-.1.6-5.8 3.7-4.5 1.8-2.9.8-3.7 1.7-4 .9-2.5-.3-2.7-1.3 2.7-2.4 2-2.2 3.7-3.4.7-2.5.5-3.5-1.6-.7-4.3 2.8-.9-.1.3-1.5 3.8-2.5 1.6-2.8.7-2.8-2.7-2.4-3.7-1.3-1.7 2.4-1.4.6-2.2 3.1.4-2.1-2.6 1.5-2.1 2-2.6 3.1-1.3 2.6.1 3.8-1.8 4-3.3 3-1.4.9-1.6.7h-1.8l-.3-.4-.1-3.3.7-1.6.7-1.5.6-3 2.5-3.5 2.9-4.3 4.6-4.7h-.7l-5.4 4-.4-.7 2.9-2.3 4.7-4 3.7-.5 4.4-1.3 3.7.7h.1l4.7-.5-1.5-2.5-1.2-.2-1.4-.3-.4-1.7-5.1.5-5 1.4-2.5-2.3-2.5-.8 3.1-3.3-5.3 2-4.9 2.1-4.6 1.5-2.1-2.1-5.5 1.3.4-.9 4.6-2.6 4.7-2.5 5.9-2.1-5.3-1.6-4.4.8-3.8-1.9-4.6-1-3.2-.4-1-1 .8-3.4zm-240.6-46.9l6.9-2.8v-1.8l-2.6-.4-3.4.9-6.4 2.1-2.2 2.7.7 1.6 7-2.3zm-38.7-16.4l2.3-2.3-2.9-.5-5.7 1 .8 1.6 1.6 1.1 3.9-.9zm1.2-22.3l-3.1 2.2.4.5 4.2-.4.3 1.1 1.7 1.2 4.9-1.2 1.2-.6-3.3-.8-1.6-1.5-3.4.6-1.3-1.1zM359 133.3l-4.4-1.1-10.2 2.8-3.2-.3-11 2.3-4.8.6-7.8 2.5-4.8 2.6-8.6 2.5-7.6.1-6.3 2.9 3.2 1.7.7 2.3-.8 2.7 2.3 2.1-1.2 3.5-9.2.2 4.3-2.8h-3.4l-13.1 2.7-9.1 2.3 1 3.3-1.2 2.2 4.5 1.4 6.9-.7 1.8 1.3 2.9-1.3 6.1-1.2h2.7l-5.9 2.1 1.1 1-2.5 2.6-5.5 1.8-2.5-.5-7 2.7-1.8-.9-4.1.4-5.3 3-7.6 3.1-5.8 3.4.3 2.4-4 3.3 1.4 1.4.5 2.7 7.2-1.1.4 2.1-3.3 2.1-3.6 3.5h2.8l7.2-2.3-1.6 2.9 3.6-2.1-.4 3 4.8-2.2.4 1.1 7.2-1.8-6.2 3.4-5.7 4.5-5.7 2.1-2.3 1.2-10.3 3.6-4.9 2.4-6.5.7-8.5 3.3-6.6 1.8-8.1 2.8-.4 1 10-1.7 6-2 6.9-2 6.1-1.7 2.8.5 8.1-2.6 4.5-2.8 10.5-3.1 3.9-2.6 6.6-1.8 7.6-2.5 8.9-4.2-.2-2.9 11.1-4.1 7.4-3.9 9.2-3.2-.4 1.4-6.7 1.8-8.3 5.7-3.2 3.5 6.4-1.3 6.1-1.9 6.5-1.3 2.9-.3 3.5-4.1 6.3-1.2 2.6 2.5 6 2.7 6.7-.5 5.7 2 3.2 1.1 3.3 6.1 3.7 1.7 7.1.2 4.1.4-2.7 5.5 1.6 4.9-3.3 5.2 2.5 1.9.6 2.2 5.1-2.9 3.1-3.7-4.6-3.8 1.5-6.8 1.1-4.2-1.7-2.7-.7-2.4.5-3-6.4 1.9-7.6 3.3-.2-3.9-.6-2.6-2.7-1.6-4.2-.1 35.4-32.4 24.3-20.2-3.5-.7-4.1-1.6-6.5.8-2.2-.7-7.1-.5-6.2-1.6-4.8.5-4.9-.9 2-1.2-6.3-.3-3.3 1 .5-2.4z
171	21a57df2-e3e2-4f7e-9506-823bd2cc2214	19c52566-e35f-44fd-8130-d64562928fe2	M1339.8 303.1l-2.5 1.2-5.4 4.3-.9 4.5h-1.9l-2.3-3-6.6-.2-2.6-5-2.5-.1-1.5-6.2-7.5-4.5-8.6.5-5.7.9-6.5-5.5-4.8-2.3-9.1-4.5-1.1-.5-11.9 3.6 6.2 22.8 5.8-.1-1.6-3.1 3.8-2.2 3.3-3.6 7.8 3.3 1.9 4.9 2.3 1.3 5.5-.3 2 1.2 4.3 6.4 7 4.4 4.2 3 6.2 3.2 7.7 2.7.8 4h2.9l4.3 1.4 1.3-6.6-2.4-4.7-4.2-1.6.6-2.8 4.4.3 1.5-3.5.5-4 6.4-1.5-.2 2.9 1.3 1.8 2.1-.2 4.1.6 5.2-4.5-7.1-3.3-3.2 1.6-4.6-2.3 3.1-4.1-1.8-.6z
172	936a4446-822e-4f35-81f8-a3ca84ad4637	33f94df7-cd4f-487a-aa5c-fb45b65f19d5	M1908.6 676.9l-2.7-3.6-.6 1.7 1.3 2.8 2-.9zm-2-9.7l-2.3-2-.9 4.9.5 1.8 1.2-.4 1.3.8.2-5.1z
173	da770866-8182-4d8f-aa72-8d1497932cf7	3a93a29d-abcc-45af-8915-8e983662c88a	M642 518.9l-2.2-1.5-2.9.2-.7-5.1-4.1-3.2-4.4-.4-1.8-3 4.8-1.9-6.7.1-6.9.4-.2 1.6-3.2 1.9-4.2-.7-3.1-2.9-6 .7-5-.1-.1-2.1-3.5-3.5-3.9-.1-1.7-4.5-2.1 2 .6 3-7.1 2.6v4.8l1.6 2.2-1.5 4.6-2.4.4-1.9-5 2.7-3.7.3-3.3-1.7-2.9 3.3-.8.3-1.5-3.7 1.1-1.6 3.2-2.2 1.8-1.8 2.4-.9 4.5-1.8 3.7 2.9.5.6 2.9 1.1 1.4.4 2.5-.8 2.4.2 1.3 1.3.6 1.3 2.2 7.2-.6 3.2.8 3.8 5.5 2.3-.7 4 .3 3.2-.7 2 1.1-1.2 3.4-1.3 2.1-.5 4.6 1 4.2 1.5 1.9.2 1.5-2.9 3.1 2 1.4 1.4 2.2 1.7 6.4 3 3.4 4.4-.5 1.1-1.9 4.2-1.5 2.3-1 .7-2.7 4.1-1.8-.3-1.4-4.8-.5-.7-4 .3-4.3-2.4-1.6 1-.6 4.2.8 4.4 1.6 1.7-1.5 4-1 6.4-2.4 2.1-2.4-.7-1.8-3.7-4.8 1.6-1.8v-2.9l3.4-1.1 1.5-1.2-1.9-2.3.6-2.3 4.6-3.8z
174	bab8e7c7-36df-4b76-a84c-a410d1ce766b	ec48dda4-e153-4854-9bc3-453263e606b1	M1571.6 435l-5.9-1.6-3-2.6.2-3.7-5.2-1.1-3-2.4-4.1 3.4-5.3.7h-4.3l-2.7 1.5 4 5.1 3.4 5.7 6.8.1 3 5.5-3.3 1.7-1.3 2.3 7.3 3.8 5.7 7.5 4.3 5.6 4.8 4.4 2 4.5-.2 6.4 1.8 4.2.1 7.7-8.9 4.9 2.8 3.8-5.8.5-4.7 2.5 4.5 3.7-1.3 4.3 2.3 4 6.6-5.9 4.1-5.3 6.1-4.1 4.3-4.2-.4-11.2-4-11.7-4.1-5.1-5.6-4-6.4-8.3-5.3-6.7.5-4.4 3.7-6 6.5-5.5z
175	a763102c-f3be-41f7-966b-277e8e8940d5	9da8253b-a4dc-41f8-b8fa-e751b6812191	M1271.5 466.2l-2.1-4.4-5.2-10.5-15.7 2.4-5 2.9-3.5 6.7-2.5 1-1.6-2.1-2.1.3-5.4-.6-1-.7-6.4.2-1.5.6-2.4-1.7-1.2 3.1.7 2.7-2.3 2.1.4 2.7-.6 1.3.7 2.9-1.1.3 1.7 2.6 1.3 4.7 1 1.9v3.4l1.6 3.8 3.9.3 1.8-.9 2.7.2.8-1.7 1.5-.4 1.1-1.7 1.4-.4 4.7-.3 3.5-1.2 3.1-2.7 1.7.4 2.4-.3 4.7-4.5 8.8-3 5.3-2.7v-2.1l.9-2.9 3.9-1.7z
176	0eaf9ad3-e787-4eea-a615-514b8d0edc0d	40fbcdb1-c386-45b7-946f-7e4190dcc02c	M1149.2 626.7l-1.9-.5.4-1.3-1-.3-7.5 1.1-1.6.7-1.6 4.1 1.2 2.8-1.2 7.5-.8 6.4 1.4 1.1 3.9 2.5 1.5-1.2.3 6.9h-4.3l-2.1-3.5-2-2.8-4.3-.8-1.2-3.4-3.4 2-4.5-.9-1.8-2.8-3.5-.6-2.6.1-.3-2-1.9-.1.5 2-.7 3 .9 3-.9 2.4.5 2.2-11.6-.1-.8 20.3 3.6 5.2 3.5 4 4.6-1.5 3.6.4 2.1 1.4v.5l1 .5 6.2.7 1.7.7 1.9-.1 3.2-4.1 5.1-5.3 2-.5.7-2.2 3.3-2.5 4.2-.9-.3-4.5 17.1-5.2-2.9-1.7 1.9-5.9 1.8-2.2-.9-5.3 1.2-5.1 1-1.8-1.2-5.4-2.6-2.8-3.2-1.9-3.5-1.1-2.2-1.1-.3-.2.5 1.1-1 .4-1.2-1.4z
177	5ddaa5ed-0ec7-4328-8e9d-908ba4e9942b	39658cd7-be12-4512-8a90-0b2cc9b2769d	M1148.2 713.7l6.2-7.2 1.6-4.6.9-.6.8-3.7-.8-1.9.5-4.7 1.3-4.4.3-8.1-2.8-2-2.6-.5-1.1-1.6-2.6-1.3-4.6.1-.3-2.4-4.2.9-3.3 2.5-.7 2.2-2 .5-5.1 5.3-3.2 4.1-1.9.1-1.7-.7-6.2-.7 1.9 5.1 1.1 1.1 1.6 3.7 6 7 2.3.7-.1 2.2 1.5 4.1 4.2.9 3.4 2.9 2.2.1 2.6 1.1 1.9-.8 2.9.6z
178	cf4d4ed4-4136-4ed8-8d37-03e64e53b3ff	49ca53d4-0d59-4be8-9724-70b0eff911ce	M1617.8 543.4l2.7 3.3 1.1-2.2 2.7.2.1-4.1.1-3.1-4.6 3.5-2.1 2.4z
179	cb64a419-1f99-4749-89bb-a07ba83ae7cd	52dc85c7-9f30-470a-9de9-09b95bc11e86	M1637.3 331.7l6.2 5.5-3.4 1.1 5.2 6.8 1.1 4.8 2.1 3.5 4.5-.5 3.2-2.7 4.2-1.2.5-3.6-3.4-7.5-3.3-4.2-8.2-7.6.1 1.6-2.1.4-3.5.3-.7 2.9-2.4-.2-.1.6z
180	57f2ceeb-2624-4964-bbc8-cc7d9f5e6bca	34e549be-e921-419a-a64d-2349902ee1e8	M1574.8 481.8l.2-6.4-2-4.5-4.8-4.4-4.3-5.6-5.7-7.5-7.3-3.8 1.3-2.3 3.3-1.7-3-5.5-6.8-.1-3.4-5.7-4-5.1-2.7 1 1.9 7.2-2.9-.1-.7-1.5-4.1 4.1-.8 2.4 2.6 1.9.9 3.8 3.8.3-.4 6.7 1 5.7 5.3-3.8 1.8 1.2 3.2-.2.8-2.2 4.3.4 4.9 5.2 1.3 6.3 5.2 5.5.5 5.4-1.5 2.9 4.9 2.4 2-4.3 5.2 2.3z
181	54b51772-0966-422f-887c-826ef5805324	6b9ca8c2-1096-496b-9aa2-0a0dc3fb4f32	M1094 304.8l-2.8-2-2.4.1-1.7.4-1.1.2-2.9 1-.1 1.2h-.7l-.4 2.1.9 2.6 2.3 1.6 3.3-.6 1.9-1.3 2.8.1.7-1.1 1-.2-.8-4.1z
182	b00c808a-6544-4c09-b6bb-fd806bb05d4a	54824162-df76-4f5e-8783-404687f907f1	M634.5 491.4v-.1h.1v-.2h-.1v.2h-.1v.1h.1zm.7-1.9l.1-.2.1-.1-.1-.1v.1l-.2.1v.2h-.2.1l.1.1.1-.1zm.3-1.1l.3-.2.1-.6-.1-.4h-.2l-.3.1-.2.3-.1.5.4.4.1-.1z
183	c57467ba-80e5-455d-b4ac-da85581f8e57	44344c65-9381-42d7-a573-6a9e38ead0f0	M586.6 492.9l-.1-.1-.3-.6-.3-.3-.1.1-.1.3.3.3.3.4.3.1v-.2z
184	bb69def3-d804-43cb-8030-23957f7d8c36	5cbe7035-cbba-4ba4-9e59-1338db15983a	M630.2 366.8l.4-.6h-.1l-.5.5-.6.2.1.1h.1l.6-.2z
185	0c40fc5e-abd5-4c11-a761-722d20b9d4d1	4fe94a12-77e5-4a49-94c4-6bff7b9f1b2e	M619.2 455.1l.3-.2-.2-.1h-.4l-.3.2.1.1h.5zm1.1-.4l.4-.4-.5.1-.2.2.1.1h.2zm.8-1.8h-.7l.1.1h.3l.3.1v-.2z
186	8cc9652b-faec-4e0d-890f-c13a2616eb7b	b4a2b89a-1d72-4928-becb-eb198ed494be	M879.6 395.2l-.2-.2-.7.5h-.6l.1.2.1.2.7.4.6-1.1zm13.5-2.1v-.1h-.1l-.1.1-1.3-.1-.2.6-.5.4v.7l.5.7.3.1.5.1.7-.4.2-.4.1-.8-.1-.4v-.5zm-9.7.8l.5-.4v-.2l-.1-.3-.5-.3h-.2l-.2.2-.2.4.3.5.2.1h.2zm4.7-2.3l1.2-1v-.3l-1 .1-1.1 1-.3.1-1 .1h-.5l-.4.2.2.3.4 1 .7.9.6-.2.3-.2.4-.6.5-1.4zm11.6 1.3l1.5-.5.3-1 .3-1.1v-.7l-.2-.3h-.5l-.3.2-.1.6-.7 1.3-.5 1.2-.7.6-.7.2.1.1.7.1.8-.7zm-19.7-2l.5-.5.1-.3-.1-.5.2-.2-.1-.4-.3-.4h-.7l-.4.6.6 1.2.1.5h.1zm22.4-2.7l.9-.3.5-.3.1-.9.2-.3-.2-.3-.2.2-.2.4-.6.2-.8.4-.2.3-.2.9.4.1.3-.4z
187	1f7663c7-01f3-47f7-812a-1a9825a438a5	3e77325d-7fea-46ad-a8fa-b2d31056b3ea	M841.4 477.6l.1-.4-.2-.6-.3-.1-.6.4-.1.3.1.3.3.3.3.1.4-.3zm6.3-1.7l.4-.2v-.7l-.1-.3h-.4l-.2.4v.5l.2.3h.1zm-1.4.8l-.5-.9-.3-.1-.6-.7v-.3l-.3-.1V475.2l-.2.5v.5l.4.8.4.2.7.1.4-.6zm3.1-7.8v.5l-.3.7.5.3.3.1.6-.4.2-.5-.1-.3-.3-.3-.3-.1-.1.1-.5-.1zm-6.4-2.5l-1-.1-.6-.2h-.1v.3l.4.8.2-.5.2-.1.8.2.4-.1-.1-.1-.2-.2zm6.7-.2l-.1-.5v-.7h-.2l-.3.2.1.7.1.1.2.5.2-.3zm-11.1-1v-.2l-.3-.5-.3.1-.4.2-.1.3.4.2h.2l.5-.1zm-1.5-.9l.8-.6.2-.3-.2-.5-.5-.1-1.2.6-.1.2.1.3.1.5.2.1.6-.2z
188	d583ed32-ff0d-4f11-8321-ea8fc477780c	8372a0ad-58ad-41f7-af06-dea7df6ef891	M527 449.1l-.1-.3-.1.1v.6h.7l.3-.2h.6l-.1-.2-.8-.1-.1.1-.2.1-.2-.1zm8-2.3l-.1-.1h-.1l-.3.1h-.2l-.1.1-.1.1h.2l.4-.2H535zm.8-.1l.5-.2-.1-.1h-.1l-.1.1h-.1l-.5.3h.2l.2-.1z
189	d9c72a4f-fca6-416d-9f49-909f4e4a5d23	3ba46aea-ed4b-48bc-919d-a93a4d6f1d6e	M595.9 494.9v-.6l-.9-.4v.3l.1.2.3.1.1.2-.1.6.2.3.3-.7z
190	2498c4c7-c06b-43aa-b2e5-9419624b4788	38c4b24f-a7d0-4af2-9d09-724ab4ad9017	M947 186.9v-.3l-.1-.3v-.2h-.1l-.5-.1-.1-.2h-.1v.2l.1.4.5.4.3.2h.1l-.1-.1zm.5-2.1v-.1l-.2-.2-.5-.2-.2-.1-.2.1v.2l.1.1.4.1.4.3h.1l.1-.2zm-2.4-1.9l-.2-.1-.5.1h-.3l.1.3.6.2h.6l.2-.1-.1-.2-.4-.2zm2.5-.5l-.8-.2-.6-.3-1 .1.7 1.1.8.7.4.2V183.7l-.4-.5-.1-.1v-.1l.1-.1h.2l.3.2h.2l.2-.7zm1-.2l-.3-.2-.4-.4v.9h.1l.3.1.3-.4z
191	507b4ee9-d336-4c5b-be3e-530ee2d0fd51	ff772da3-5cb8-4833-a427-2651adf6fbd6	M690.3 902.7l-.1-.3-.4-.2-.2-.1.1.2.1.3.1.2.2.1.2-.2zm5.5-1.3l-.1-.1h-.2l-.1.2.2.3.4.1-.2-.5zm-12.9-1.4l-.1.2-.4.1.2.3.6.4h.4l.1-.3-.1-.6h-.3l-.4-.1zm2.8-2l-.9-.3-.4-.3h-.3l.4.4.1.2.1.2.6.3.6.3.4.3-.1.1-.8.3h-.3l-.2.1.4.2.6-.1.2-.1h.2l.3.1v.2l-.1.2-.2.2-.4.3-.6.4h-.8l-.7.7.9.5.7.3h.9v-.1l.2-.1h.3l.1-.1.2-.4v-.6h.2l.3.1.7-.1.3-.1.6-.9.4-.8.2-.4.3-.2.1-.2.1-.3.3-.2v-.3l-.4-.2-.3-.2-.3.3-.2-.1-.9.3h-.4l-.3-.2-.4-.1-.4.1-.5.5-.8-.2zm.7-.4l.1-.3-.1-.2-.5-.2h-.5l.2.5.2.2h.6zm5.9-.7h-.4l.4.5-.8.8.2.6.3.4.1.2-.1.1-.4.1-.3.1-.2.3-.9.9.2.2-.3.7.2.3.8.7.8.4v-.7l.4-.1.4.2.4-.2-.9-1h.3l2.5.5-.1-.4-.1-.2-.3-.4 1.5-.4.5-.3.2-.3.6-.1.8-.3-.1-.1.1-.3-.4-.2-.5-.1.1-.3.5-.1-.8-.7-.3-.1-1 .1-.3.1v.2l.1.3.3.3.1.2-.2-.1-1.1-.4-.2-.1-.2-.4.2-.1.3.1.1-.3-.4-.3-.4-.1-.9.1-.8-.3z
192	a61b9876-5aa6-44bc-b055-196872b64e0e	472108f0-b6a2-410c-9885-d4fa3b3412bd	M213.2 704.9l-.1-.3-.2-.3-.1.1.1.1.2.3v.2l.1-.1zm9.3-14.7l-.2-.2-.4-.2-.2-.1-.2-.1-.1.1.1.1h.1l.3.2.3.1.2.1v.1l.1-.1zm-24.5-1.1l-.6-.3.1.2.4.2.2.1-.1-.2zm20.5-.2l-.4-.5h-.3l.7.6v-.1zm-21.6-1l-.4-.4-.2-.3-.3-.1.1.1.4.4.3.4.2.1-.1-.2zm-.3-2.1l-.1-.1v-.3l.2-.3.6-.4v-.1l-.2.1-.4.2-.2.2-.1.2-.1.3.1.2.1.1h.2l-.1-.1zm-47.4-1.1l-.2-.6-.3-.5-.8-.1-.5.2-.1.2.1.4.5.7.5.1.8-.1.4.6.2.1.4.1.1-.3-.2-.5-.9-.3zm-2.9-.9l.1-.4-.2-.1h-.5v.2l.1.2.1.1.3.2.1-.2zm-9.7-4.3h.2l-.4-.6-.3-.2V679.5l.3.1.2-.1zm43.9-1.6h-.6l.5.1.4.2-.3-.3zm-.7.1l-.3-.1-.3-.2h-.3l.7.3h.2zm-43.8.1l.1-.2-.1-.1-.4-.2.1.3v.2l.2.1.1-.1zm32.8-2l-.3-.4-.2-.3-.2-.4-.4-.5.1.3.1.2.2.2.2.4.1.2.3.4h.1v-.1zm16.2-1.5l.1-.5h-.2v.5h.1zm-14.4-1.6l-.6-.6h-.1l.1.2.5.5.1.2v-.3zm30.8-33.9l.1-.2v-.2l-.1-.1-.3-.1.1.7.2-.1zm-2.7-3.7l-.1-.2h-.2l-.1.1v.5l.4-.4zm.1-1.6l-.8.5.2.4.4.1.2-.2.8-.1.3-.4-.3.1-.8-.4zm-6.1-1.7l.2-.5-.2-.1-.4.2v.2l.3.4.1-.2zm2.6-3.1l.3-.1v-.1l-.2-.2-.3-.1-.1.1-.1.2.1.3.3-.1zm-2.9-.1l.1-.3v-.2l-.1-.2-.9-.2-.1.1v.4l.2.5h.3l.5-.1z
193	84e71b6b-7019-40fe-89a7-1b1678d8a64f	fef2c7ae-f872-4a71-9c87-0d0727258c26	M681.4 556.2l1.8-4.7 3.5-5.8-.9-2.6-5.8-5.4-4.1-1.5-1.9-.7-3.1 5.5.4 4.4 2.1 3.7-1 2.7-.6 2.9-1.4 2.8 2.4 1.3 1.8-1.8 1.2.3.8 1.8 2.7-.5 2.1-2.4z
194	9226fefe-1e87-4111-86d8-f9ceb2658277	5f5fad3d-69c4-41b1-bc88-d9b8cff77027	M887.4 76.3l-26-.4-11.8.3-5 1.3-11.5-.1-12.7 2.1-1.6 1.7 6.7 2.1-6.2-1.3-4.5-.3-7-1.4-10.6 2.1-2.7-1.2h-10.4l-10.9.6-8.9 1-.2 1.8-5.3.5-14.6 2.9-4.6 1.7 8.1 1.5-2.8 1.6L730 95l-15.5 2.2-2.2 1.7 6.4 2 14.5 1.2-7.5.2-10.9 1.5 3.8 3.1 3 1.5 9.4-.3 10.1-.2 7.6.3 8 2.9-1.4 2.1 3.6 1.9 1.4 5.3 1 3.6 1.4 1.9-7 4.8 2.6 1.3 4.4-.8 2.6 1.8 5.3 3.4-7.5-1.4h-3.8l-3 2.8-1.5 3.6 4.2 1.8 4-.8 2.6-.8 5.5-1.9-2.8 4.2-2.6 2.3-7.1 2-7 6.3 2 2-3.4 4 3.7 5.2-1.5 5 .7 3.7 4.8 7.1.8 5.6 3.1 3.2h8.9l5 4.7 6.5-.3 4.1-5.7 3.5-4.8-.3-4.4 8.6-4.6 3.3-3.7 1.4-3.9 4.7-3.5 6.5-1.3 6.1-1.4 3-.2 10.2-3.9 7.4-5.7 4.8-2.1 4.6-.1 12.5-1.8 12.1-4.3 11.9-4.6-5.5-.3-10.6-.2 5.3-2.8-.5-3.6 4.2 3 2.7 2.1 7.3-1-.6-4.3-4.5-3.1-5-1.3 2.4-1.4 7.2 2.1.5-2.3-4.1-3.4h5.4l5.6-.8 1.7-1.8-4-2.1 8.6-.3-4-4.3 4.1-.5.1-4.2-6.2-2.5 6.4-1.6 5.8-.1-3.6-3.2 1.1-5.1 3.6-2.9 4.9-3.2-8-.2 11.3-.7 2.2-1 14.6-2.9-1.6-1.7-10-.8-16.9 1.5-9.2 1.5 4.5-2.3-2.3-1.4-7 1.2-9.7-1.4-12.1.5-1.4-.7 18.3-.4 12.9-.2 6.6-1.4-19.7-2.9z
195	4e85fdb2-9801-41d7-b71f-a90480044a65	ba5a63e1-7feb-4d40-ae2f-d0a9f2123c0c	M636.4 471.1l.2-.2v-.3l-.2-.3-.2.1-.2.3v.3l.1.1h.3zm-1.9-.8l.2-.2v-1.2l.1-.3-.2-.1-.2-.2-.6-.2-.1.1-.2.3.1 1.5.2.5.2.1.5-.3zm1.6-1.4l.8-.2-.9-.6-.2-.4v-.3l-.4-.3-.2.2-.1.3.1.5-.3.4.1.4.4.1.7-.1z
196	09bf9423-644f-4123-a7bb-f09f05566ed8	ae7c2b6b-a504-4e11-a52c-97175217c0a7	M1604.9 430.9v-.4l-.4-.2h-.3l.1.2.4.5.2-.1zm-1.3 0l-.1-.5.2-.3-.9.3-.1.3v.1l.2.1h.7zm1.6-1.2l-.1-.3-.2-.1-.1-.3-.1-.2-.3-.1-.2-.1h-.4l-.1.1h-.2l-.2.2v.2l-.5.4v.2l.3.2.5-.1.6.2.8.3v-.5l.2-.1z
197	94a5446c-3195-4860-bcb1-d461aeb369ae	8510166b-62a4-475f-8afe-891fe1cb22a0	M1024.4 273.6v-.2l.1-.2-.1-.1-.1-.2-.1-.1v-.2l-.1-.1v-.2l-.1-.1-.2.6v.5l.1.2h.1l.4.1z
198	01f8a12f-04a2-41b5-ba73-e77ffb76e025	07546102-9696-4e5b-80fb-c435267230aa	M638 479.9l-.2-.7-.1-.2-.2-.3.1-.3v-.1h-.2l-.3-.5-.6-.3h-.3l-.2.2v.3l.3.9.2.2.5.2-.4.4v.1l.1.3h.9l.2.3.1-.1.1-.4z
199	dbf9f061-0932-440f-88c3-78f015d979f1	4f7bf3fc-1cdd-42ea-acc1-2325444ea405	M1228.7 654.7v-.3l.2-.5v-.1l.1-.5-.3-.3h-.2l-.2-.3-.3.3.3.5-.1.3-.1.4.1.4.2.2.3-.1z
200	9b20f32a-f406-4244-85ae-6592c78e30b0	adc6de52-b3d9-4448-a7d6-39622cf3261f	M631.8 465.7l-.1-.5h-.1l-.2.4v.3l.3.1.1-.3z
201	68b0a56b-e71b-440b-b1a3-692f12ce30f7	17b783e7-ad5c-473c-8787-aab9c9397fed	M1897.3 716.1v-.3l-.4-.2-.2.5v.1l.2.1h.2l.2-.2zm4.6-7.6l-.1-.1v-.3l.1-.2-.4.2-.6.2.1.8-.1.4.3.1.1.3h.2l.7-.2.3-1.1h-.4l-.2-.1zm-3-1.7l.3-.5.1-.2-.2-.7-.3-.3.3-1-.1-.2-.4-.2-.9.3-.1.2.5.1.2.2-.5.7-.5.1.1.5.2.4.7.2.3.4h.3zm-3.9-2.9l.3-.3.3-.4-.1-.1v-.3l.2-.4.3-.1-.2-.2-.2-.1v.3l-.3.7-.1.3-.5.6h.3zm-12.3-2.9l-.6-.7-.1.2-.1.4v.3l.3.2.1.2-.1.5v.4l.6.9.1.7.3.6.5.5.4.5.8 1.4.2.5.4.3 1 1.2.4.4.4.2.9.7.6.3.3.5.6.3.8.4.1.2v.3l.1.3.5.4.6.3.1.2.1.2.3-.1.3.1.9.7.4-.1h.3l.5-.2.3-.4-.1-1.1-.5-.5-.7-.4-.4-.5-.4-.5-.8-1-1.1-1-.5-.2-.3-.4-.3-.1-.2-.3-.5-.3-.3-.6-.6-.6-.1-.3.1-.3-.1-.3-.4-.3-.2-.5-.2-.3-.4-.2-.7-.4-1.6-1.9-.7-.6-.7.2-.6-.4zm-22-6l.2-.4.1-.8-.2.4-.2 1 .1-.2z
202	03299a99-70c7-4c91-bcdc-79065fb5ca7c	6ed0c70e-c6ab-4148-aae3-fbf474467390	M1166.9 366.1l-2-.9-.7 4.3 1.4.7-1.2.8-.1 1.7 2.4-.8.6-1.9-.4-3.9z
203	483edfd7-9882-43d8-975c-5d84f16028c3	6fda58dd-3eb4-49f9-8f07-8e0c4562675b	M274.2 727.4v-.2l-.1-.2-.2-.1-.1.1.1.2.2.2.1.1v-.1z
204	6882eb90-dc65-402c-b7a3-a1fa5e26baf0	f18ec7fe-184e-4e4b-9ac5-14c5bfbf1fb7	M600.8 457.3v-.1h.1v-.1l.1-.1v-.1h-.5v.2l.2.1v.1h.1zm13.6-.3l.7-.2v-.1l-.4-.1h-.6l-.5.2.1.2h.7zm-3.7-2.2l-.1-.2h-.2l-3.5-.1-1.3-.2-.3.1-.3.1-.1.4-.2.2-.3.2.1.3.1.2.2.4-.1.5-.2 1 .3.2.7-.1.3.1.3.1.4-.1.4-.2.9.1.5-.1.6.3.4-.1.2.1H610.4l.9-.2.8-.5.3-.5.4-.3.6-.4v-.9l-.7-.1-.6-.3-1.1-.1h-.1l.1.2h-.1l-.2-.1z
205	5168324c-f469-4333-a79a-5da51ddf5fe7	e600ef6e-e2fa-42cd-a54e-60cd0a48c98f	M1284 707.9l.2-.4.1-.8-.4-.8-.4-.7-.4-.2-.8-.1-.7.3-.4.6-.2.3.4 1.1.2.3 1.1.6h.5l.8-.2z
206	3e11a8a4-86a4-46e9-b9ba-9ecefc839a17	f873ab5f-e175-4a90-9e0e-1efe1d0880ff	M627.1 457.2l.2.2.3.1.1-.1v-.2h-.6z
207	ca548335-5a7e-4124-8650-b5cab8915879	188c245e-16ba-4c8b-a894-dcfd252e6735	M1150.5 736.6l-2.7-1.2-1.6.5-.7 1.8-1.6 2.4-.1 2.2 3 3.5 3.3-.7 1.3-2.8-.3-2.8-.6-2.9z
208	997b64d5-ddea-4a91-87f3-3487c89bbdc9	1f6e1df0-b5ff-4eb0-89b2-0bd06cf52883	M1642.3 427.2l1.2-10.2.1-3.9-2.9-1.9-3.3 4.8-1.9 6.3 1.5 4.7 4 5.4 1.3-5.2z
209	9162057c-1693-436b-8293-90f8cbc6489b	29c528d3-2b84-4b14-adec-78d0f7a06fc1	M578.7 433.1l-.1.4v.2l.2.1.6-.1.1-.1.2-.1v-.1l-.4.1-.6-.4zm3.6.6l.2-.2-.2-.2-.7-.2-.2.1v.3h.6l.3.3v-.1zm-1.1-.5l-.1-.1-.1-.6h-.5v.2l.1.2h.1l.1.2.3.2.1-.1z
210	776f9472-b40b-4489-9852-c5692ca3b269	cd560671-9a56-4d59-a90b-3fc5876c54a8	M617.9 458.9l-.7.2-.1.4h1.1l.7-.3h-.6l-.4-.3zm.9-3.5l-.5-.1-.2.2.3.1.4-.2zm-1.1.1l-.2-.2-.3-.1-.4.1.5.3.4-.1z
211	563bc0bf-4a08-40d5-b081-bd8f816331f4	7c843d31-a3b7-4fd6-854d-a41fd456ab79	M929.6 396.2h-.8l.1 3.4-3.4.2-1.8 1.5h-2.5l-1.9-.9-4.6.7-1.9 5-1.7.4-2.8 8.1-7.8 6.8-2 8.8-2.3 2.9-.7 2.3-12.4.5h-.1l-.3 2.7 1.2-2.2 21.6.1-.9-9.2 1.4-3.3 5.2-.5.2-16.3 17.9.3.2-9.7.1-1.2v-.4z
\.


--
-- Data for Name: territory; Type: TABLE DATA; Schema: public; Owner: brook
--

COPY public.territory (id, uuid, name) FROM stdin;
1	1965c743-cf9a-4021-9ed1-b9e4e77486a2	andorra
2	2b1a33fe-be25-452b-8a1c-c7d5f1dce9c2	uae
3	793360a3-aa91-4703-acfe-60287e3f9b74	anguilla
4	74718d89-2c74-4664-a9f9-c3bda5884237	french territory of the afars and the issas
5	ca1a8efc-5d84-4e75-9f3b-5d005b9afca5	aland
6	49494a5b-205f-4756-9145-2784c9269a99	barbados
7	437b6b0d-4fe4-4e6a-b869-9aca4351a182	netherlands antilles
8	af123316-5e2b-4453-9908-13434c758d89	metropolitan france
9	b7b802fe-8789-4b6d-b085-7c25a92dab7b	france
10	7fb270a5-06a1-4488-951f-55dcc7e822c0	czechoslovakia
11	c5db5d6b-ebcd-4642-9604-0f1ebf2fdf9d	czech republic
12	2dd507e0-8e57-4924-a57f-8fc2e22555e2	slovakia
13	ac8b13ec-0d98-4fad-852e-a351d68e6a16	myanmar
14	509e1050-f5ab-4d6b-ba04-501765fb9ecf	burma
15	9081511d-8a3b-4372-b828-44afb55b2dc4	yugoslavia
16	ba063fe6-f538-45d8-9450-81c536a1aa29	serbia and montenegro
17	aae2ba87-a67d-43bd-8516-e403843d61d9	serbia
18	6702177a-fbed-4cf3-aa32-22da244beab0	montenegro
19	0f433ba9-47e1-4fe6-902c-632bf40355a9	united kingdom
20	56c6dacf-b4d9-401b-874a-6518da0cd567	england
21	c5bc507e-7bca-4c9d-8d7b-a3441b33dffe	wales
22	e054a323-d773-441e-9cbb-9843a1780b2d	scotland
23	c639dcd9-0e03-4f83-bdba-8a5a921b021a	northern ireland
24	0b48c87c-ddaa-49d2-b736-61d9c44636e0	djibouti
25	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	singapore
26	b33be079-39b7-4a1d-b689-97c224d5fece	afghanistan
27	6c7e4e7d-9bf4-4e47-b2e4-c925f54bcd1a	albania
28	d9b8f8c8-5b5a-41ef-8538-26d822a4c9bd	algeria
29	bf07965f-f874-453e-a725-54c5a1254ee8	angola
30	90de1527-d5a5-446f-a960-eccda43af198	antigua and barbuda
31	78219cc6-d1b2-4193-9da7-e7abc92863ee	argentina
32	f2f3e704-bb03-467a-a1a0-1d56b6faadce	armenia
33	0a3e548d-7e30-426f-840c-07ff9b6772f7	australia
34	e14f7607-8074-4eeb-8b3f-3093575719a4	austria
35	319530a8-8cd2-4dc3-84a6-29ac720c51da	azerbaijan
36	ac6434f1-bbb9-4242-a393-d78d367f034a	bahamas
37	497550d7-f9e9-4f1a-a5e0-8c9019c7bc31	bahrain
38	bb3fa754-b35e-45ee-8d66-fb159c96d821	bangladesh
39	ac612169-1567-4c5e-a203-3987fa26c267	belarus
40	1f4dd261-dc57-49ec-b872-8b1917703616	belgium
41	3e62d48d-717d-4421-91c2-abb059a80576	belize
42	5fbebc32-e410-4faa-94e5-822252f8b499	benin
43	1d58bd18-8519-4e53-8cd1-6a7e93cda614	bhutan
44	546440bf-236c-4f99-bd12-3bba52d50e02	bolivia
45	c103dabb-a386-4a6a-bce5-c0c0fa5f43f6	bosnia and herzegovina
46	ff4c5033-aee4-4325-90cc-1f96ef10bbce	botswana
47	1b558876-4f84-41fb-8215-93143842ba53	brazil
48	49ca53d4-0d59-4be8-9724-70b0eff911ce	brunei darussalam
49	dde93861-da65-40d4-8159-3e67e8d58e02	bulgaria
50	a22c7473-248e-4447-8bc7-1fc51c00ca3e	burkina faso
51	4f0fe689-81e0-4b91-a093-cad33a305482	burundi
52	0b35bd76-e5ef-4a77-bacf-46918e1d9d06	cabo verde
53	723de35c-616a-4b10-b479-c08378f3765b	cambodia
54	526f75ae-3c43-45a3-924e-1d7e11177a68	cameroon
55	e242cbe2-dc75-4807-a7c9-c171d164ec2d	canada
56	2b1aaccb-5846-45c1-8481-12bb8b5e0aa4	central african republic
57	3f759fc5-8287-4acb-b58d-f235c5ef4981	chad
58	c5a755fa-0935-4ec5-a880-3d4854beabfd	chile
59	7178da96-360e-4b0a-ada4-9640c498daf8	china
60	8b58bd46-c2d7-4df7-8871-378dbe921468	colombia
61	48847459-b1b2-4092-9bf0-f0c08b928c74	comoros
62	9982d96a-7b45-4e8a-93c5-83056d6b0fc8	cook islands
63	cf56f0da-daf4-4437-9ad9-4b61bbedc31a	costa rica
64	14730d5f-e0e5-43a8-bc67-ca9f92c8502a	croatia
65	16a55dd1-2e47-489d-830c-3a88aad464a9	cuba
66	f36ec987-ed66-4a88-9157-b1d4a934e515	cyprus
67	31d93d6a-5130-4cfa-87ba-90d971d98d34	ivory coast
68	9ad23145-f384-4a8f-a075-4648d1837d46	north korea
69	196ed632-cc17-4b9f-87cb-cbc9832e8617	congo
70	80b3fc54-1fa6-49c6-ac4c-998b002d754f	dr congo
71	870d8300-9c56-4b34-9447-bcdfedf8454c	denmark
72	a66c6aaf-f010-4056-8928-1653d670edf3	dominica
73	7caae20c-20fa-4ce0-a987-cca304a302b9	dominican republic
74	41fa1fc8-a7c9-4045-ac6a-92fe36c27bd9	ecuador
75	0d0a18fd-d424-4a69-b646-38fffd942dd5	egypt
76	bae2df87-ee9b-4efe-8482-2b05b54ebb11	el salvador
77	43d35de8-4ed4-4bd7-9fce-54d9adcdeec6	equatorial guinea
78	b2db2210-e9b8-4d51-b3c0-ed8e3d6adc9b	eritrea
79	061c7757-87bb-4acc-bfb5-ebb5a4dc9429	estonia
80	646467f2-a7ee-4dc3-8589-902f948694cf	eswatini
81	f76a50d7-c955-4658-a2da-f191b746b434	ethiopia
82	13ba7194-35d8-4666-bc59-4eb69058dc48	faroe islands
83	923566be-1a81-4281-a9f5-fc3d8e59e53e	fiji
84	d322fe64-203a-4eb4-8316-2c6c1af401a3	finland
85	6a95dca7-5bc9-438d-ba51-5cc4603d70a4	gabon
86	81e9890e-9239-4c33-b429-66950b214814	gambia
87	f2e17057-cb16-4fd3-92ef-07a6320c1818	georgia
88	d80301ed-7cdc-4f2c-8093-cfec014b077a	germany
89	53618499-ed33-49f9-aeae-e24d02029f1e	ghana
90	1a76eb8a-5fca-4552-a0dd-9728217998b0	greece
91	aedfe3b8-fc01-41f8-a152-516e139dc8b6	grenada
92	0e291c7e-51a2-466f-94b9-de8d9dec9dd2	guatemala
93	b3e98c98-8a15-45bf-8f86-f26f6a07a425	guinea
94	98fd5d7d-6f4c-434d-bd97-6fabe502db00	guinea-bissau
95	f11d746c-8b82-4fe1-acb0-788067f0071c	guyana
96	99530f46-46c4-4263-bd88-dca23dc0383f	haiti
97	3e33cfe7-603b-4d88-a6e3-f4dcc331d9f2	honduras
98	8287bea9-2349-46e4-9ac0-fb1e799497af	hungary
99	68563b3e-8866-4310-bdce-659b3cc9c2ac	iceland
100	83f3b190-021f-4694-a033-57058c22cbf4	india
101	a3122035-5d20-411c-a94d-17360ed55678	indonesia
102	1baa5d83-2707-4a0d-8f86-45efc106dffd	iran
103	e130f15d-7a37-4ddf-a6b5-e9c1266e128a	iraq
104	48d25a4f-6bcb-4595-bf82-1492334695ec	ireland
105	fc3338b4-47f1-4342-8def-3acabc77a994	israel
106	161a32a0-755e-430b-86dc-8f153f7de9b1	italy
107	96abeca6-c08e-4df8-b22f-2fefc55a8d5b	jamaica
108	8e5a125d-73cb-45c1-a511-f0c65d7448e7	japan
109	c728bbe4-373f-4d0a-9a3f-985679759733	jordan
110	c6a8ea7c-3fed-4a1d-9929-5569db7ab968	kazakhstan
111	e91cae72-f62c-407e-b388-3f3b86f7a0c3	kenya
112	8275007a-70b9-4a04-bcfa-1c23825d4874	kiribati
113	ab2a946c-f1e3-43f5-bbfd-4b54adae333a	kuwait
114	6cec735b-3406-430f-be56-71d96ff8f41e	kyrgyzstan
115	34e549be-e921-419a-a64d-2349902ee1e8	laos
116	85b0fd58-f24b-4249-a31c-46e40023744c	latvia
117	6a6a8869-35f4-4d7f-af9f-c881d3b4bc19	lebanon
118	f7ca89ef-b000-416a-b9f4-6059b2d8a3ca	lesotho
119	e3c9a7c1-e5ec-46aa-be24-13a63b23c24a	liberia
120	a9bc64d6-1f2e-4882-90bc-4930614667da	libya
121	d4d24a30-2184-4fd3-8315-248ddc094526	lithuania
122	a94b35b0-c269-4e9f-9d66-80d8f3081989	luxembourg
123	b7206cc1-2cca-454d-9447-3788640f7b5e	madagascar
124	413fe813-55c0-49e9-8853-47654b4ae73b	malawi
125	d42ac9fd-1e10-4995-8dc1-4d25cee7a022	malaysia
126	2b8d132e-e3b8-4a97-aa78-a265bf65836d	maldives
127	a8c0bf67-69a5-4293-8282-622c6b61962c	mali
128	ca8f94ef-b748-47c8-b040-b996e3cf2581	malta
129	27f40e7e-ab08-4e44-b643-f9546021f2c2	marshall islands
130	a4d1f62b-6131-44de-92fe-975d0a463bc7	mauritania
131	59a60488-bbd7-476a-813e-a92fa901e8e7	mauritius
132	846ec109-79bc-4e46-a303-40e20bcb2f36	mexico
133	0343465d-616b-4419-b3ac-6e358776cb2e	micronesia
134	e1b6cef2-9a2d-441a-96db-2cb815ac9398	monaco
135	b60fe946-71ac-40be-97dc-8ee0b78c3384	mongolia
136	a7462d3b-b094-454a-a09c-08573a566463	morocco
137	95251d34-e411-4cb7-9112-0a1f95b239e0	mozambique
138	dff0e275-70f0-4d4b-9d4a-3b4029ab3cd1	namibia
139	c00f0e5e-a315-4118-b879-8d0a07faa486	nauru
140	52a86412-42e6-499e-a742-a0902ca649b5	nepal
141	649e4cd5-204a-41ae-add6-5c7433d23973	netherlands
142	903625d0-0df4-4537-8370-4c3cda4ffed6	new zealand
143	390d0b06-0892-405b-93f4-8b1b69af9667	nicaragua
144	363bc536-025f-4ef7-95c0-a083bb8f37e6	niger
145	7ce306aa-4c86-4016-93ab-cf3f5c22c621	nigeria
146	25064811-fb8f-487b-a95a-acce0aebdb8e	niue
147	6b9ca8c2-1096-496b-9aa2-0a0dc3fb4f32	north macedonia
148	4f50cb61-60cb-48f5-9c7a-974d9c3840d5	norway
149	7a1e411c-5e2b-4ef6-9561-73a4466af643	oman
150	abc45575-6e5a-49c5-9967-e067a503c8a6	pakistan
151	43e7d908-36ff-47b2-813c-146e89e91aef	palau
152	e32cd55b-2b25-444e-beb4-f86a6e81819b	panama
153	2f5d487b-20b7-47c4-b8fe-378d3c40839a	papua new guinea
154	5091a6a9-aa19-4e48-890a-d0d3ccce88c7	paraguay
155	6fd50499-8698-4764-a9ea-d063e211ae85	peru
156	d29dcef8-e41b-4540-8f88-8849607ad3f3	philippines
157	9a7ad7e0-1e36-4004-9879-568b56d0cf87	poland
158	c2f84d45-aa39-4df1-8a87-e4dd0c5b34a1	portugal
159	90a93353-4714-42fc-8632-09f25bc1312a	qatar
160	52dc85c7-9f30-470a-9de9-09b95bc11e86	south korea
161	6f37afd2-3170-4c9d-8fde-28d6a44eda0d	moldova
162	fdf4338f-fd3a-446b-9688-b28515d38074	romania
163	ae5dee3a-1222-4f42-9f97-470ab88b3b7e	russia
164	418d8911-a62b-4686-bf0e-f18b204398d8	rwanda
165	ec506881-6436-49fc-b56e-42da02dd7d5b	saint kitts and nevis
166	e3b26362-6759-4612-8863-4785505a679e	saint lucia
167	54824162-df76-4f5e-8783-404687f907f1	saint vincent and the grenadines
168	7d76fbc2-43bb-467f-b36b-1b899f3d013a	samoa
169	1bc1c6a9-2028-4dcd-94bf-6d19bea049e6	san marino
170	ab4bc3a4-7c19-4a94-905c-a7973e0feaff	sao tome and principe
171	dfffd0b6-a252-421b-94cb-6d44695c5c8c	saudi arabia
172	e98795b2-4086-41b5-bac1-4789d9aee005	senegal
173	4998e162-96ca-4381-ab19-3dc43922884a	seychelles
174	d8df4bc3-503b-41ca-987e-423e41ecb52c	sierra leone
175	dbc583de-b4de-46ba-aae0-1e8d35054bf3	slovenia
176	b7f76500-4fa3-457f-aca8-477f05aab728	solomon islands
177	98943525-f93f-426f-a3fe-b48bc18c0c52	somalia
178	247ff0fd-78ad-4ca4-90f2-f0394a714535	south africa
179	3ffea3be-1c82-411a-b085-933205f900c7	south sudan
180	02e5c743-3075-4226-8c1d-ad97dadda3d8	spain
181	6c6c9e3f-2353-431c-83c4-2c0cc6c42ff6	sri lanka
182	c149c091-51c2-41d7-85a7-7d67bcac4230	sudan
183	e0e0a4c5-9076-4a1e-949f-9dd4521eb0f3	suriname
184	5c3dd764-6824-4689-a3e1-1d8c2dc3bc93	sweden
185	dacd5cdd-8e56-4067-bfd8-febc66a04058	switzerland
186	7073c668-a71d-4cf0-a8dd-71008877f8ca	syria
187	893ca48d-0871-46b1-b299-4bf7e7c98dfa	tajikistan
188	99d1c02c-0a04-4eae-b6cd-403f94e43959	thailand
189	1a61eb0b-45a3-4b91-89c2-c22a20676491	timor-leste
190	1a7ba610-72c3-4816-81b5-aad9503a4a9b	togo
191	ed22e6e0-5acc-4f0a-9a6a-e85dac1fca31	tokelau
192	85e41f4f-c125-4753-bbed-c2ffc7e1c288	tonga
193	06659bc5-9958-457e-ac56-2860917a3d28	trinidad and tobago
194	cac7a781-be5d-4c59-b9b8-d8bb65fb1487	tunisia
195	fb99fe5c-118c-44d8-97ba-6570cdb7bd33	turkey
196	0adc54bf-ff91-4cb0-8571-d89b779f1061	turkmenistan
197	6596da04-74ae-4968-9776-6a7debe1b0aa	tuvalu
198	c5ce24da-dd58-4e8e-a5e3-91b478717bb4	uganda
199	6b63bb5b-0238-4263-bdf4-8064a4fb5c26	ukraine
200	1bf315d2-0a2d-4686-9ecb-6d28f8a5b861	tanzania
201	0bea6297-7d53-49a7-927e-e5cbc57e3b5a	usa
202	d95a4486-5ca4-4500-8b10-211b945552c8	uruguay
203	19c52566-e35f-44fd-8130-d64562928fe2	uzbekistan
204	33f94df7-cd4f-487a-aa5c-fb45b65f19d5	vanuatu
205	3a93a29d-abcc-45af-8915-8e983662c88a	venezuela
206	ec48dda4-e153-4854-9bc3-453263e606b1	vietnam
207	9da8253b-a4dc-41f8-b8fa-e751b6812191	yemen
208	40fbcdb1-c386-45b7-946f-7e4190dcc02c	zambia
209	39658cd7-be12-4512-8a90-0b2cc9b2769d	zimbabwe
210	44344c65-9381-42d7-a573-6a9e38ead0f0	aruba
211	5cbe7035-cbba-4ba4-9e59-1338db15983a	bermuda
212	4fe94a12-77e5-4a49-94c4-6bff7b9f1b2e	british virgin islands
213	b4a2b89a-1d72-4928-becb-eb198ed494be	canary islands
214	3e77325d-7fea-46ad-a8fa-b2d31056b3ea	cape verde
215	8372a0ad-58ad-41f7-af06-dea7df6ef891	cayman islands
216	3ba46aea-ed4b-48bc-919d-a93a4d6f1d6e	curaco
217	38c4b24f-a7d0-4af2-9d09-724ab4ad9017	faeroe islands
218	ff772da3-5cb8-4833-a427-2651adf6fbd6	falkland islands
219	472108f0-b6a2-410c-9885-d4fa3b3412bd	french polynesia
220	fef2c7ae-f872-4a71-9c87-0d0727258c26	french guiana
221	5f5fad3d-69c4-41b1-bc88-d9b8cff77027	greenland
222	ba5a63e1-7feb-4d40-ae2f-d0a9f2123c0c	guadeloupe
223	ae7c2b6b-a504-4e11-a52c-97175217c0a7	hong kong
224	8510166b-62a4-475f-8afe-891fe1cb22a0	liechtenstein
225	07546102-9696-4e5b-80fb-c435267230aa	martinique
226	4f7bf3fc-1cdd-42ea-acc1-2325444ea405	mayotte
227	adc6de52-b3d9-4448-a7d6-39622cf3261f	montserrat
228	17b783e7-ad5c-473c-8787-aab9c9397fed	new caledonia
229	6ed0c70e-c6ab-4148-aae3-fbf474467390	palestine
230	6fda58dd-3eb4-49f9-8f07-8e0c4562675b	pitcairn islands
231	f18ec7fe-184e-4e4b-9ac5-14c5bfbf1fb7	puerto rico
232	e600ef6e-e2fa-42cd-a54e-60cd0a48c98f	reunion
233	f873ab5f-e175-4a90-9e0e-1efe1d0880ff	sint maarten
234	188c245e-16ba-4c8b-a894-dcfd252e6735	swaziland
235	1f6e1df0-b5ff-4eb0-89b2-0bd06cf52883	taiwan
236	29c528d3-2b84-4b14-adec-78d0f7a06fc1	turks and caicos islands
237	cd560671-9a56-4d59-a90b-3fc5876c54a8	us virgin islands
238	7c843d31-a3b7-4fd6-854d-a41fd456ab79	western sahara
239	6b0038c6-c3a1-4a1c-b721-5bb0a50c8867	abkhazia
240	f2cdea77-ac81-4009-a139-487fed267132	antarctica
241	57781bac-bb12-4862-9e29-a3eb6ebed059	bonaire
242	2c927bd6-e6c1-4aa7-810e-6f544f2137dc	bouvet island
243	d6807de6-9eb7-4470-89e6-785b74a33137	christmas island
244	582d0cef-1fbc-47f5-8574-a2682c0b1e27	cocos islands
245	db372ed2-316b-44eb-854e-861a73d8a364	east timor
246	6692f259-8335-431b-93da-96663a40fefd	european union
247	4579b4bb-57c1-454e-a91c-b545e8f713e4	french southern territories
248	c4d460f0-d8f6-49c2-a75d-076d40c3bf4e	gibraltar
249	dbb53edf-6817-4a18-89b0-f6e2747c95ba	guam
250	99436fc3-8e6d-41af-9a25-f9ff3f9eadc5	guernsey
251	7ebcc568-e95d-4ebd-b55d-9fed5d9b87cb	heard island and mcdonald islands
252	534d150e-315d-40fa-ae9d-6876e3ab6aa1	isle of man
253	e9d06599-c594-4a7f-9e16-2c81897bd5dd	jan mayen
254	242bc52e-221a-4254-b523-8b339182f620	jersey
255	0a0b42b2-ee8d-44cb-8ce1-84effb466438	kosovo
256	be30ad9f-9895-40aa-825f-997c0efddfab	macau
257	adc3c9dd-bfce-48a7-9c4a-767c2de409ae	norfolk island
258	90b92de2-8101-4bce-af13-51bf5f5e6da0	northern mariana islands
259	57ec88b9-c03d-4f44-914b-27c8d2e9169c	saba
260	52ee76db-8c13-4deb-9de4-a3b518a8e9bc	saint barthelemy
261	1c7c18b7-27fa-4852-aff7-6139002c4c9b	saint helena, ascension and tristan da cunha
262	06e8b669-fa86-4cf3-86d2-d0e2e9ab2195	saint martin
263	6668152c-57e0-4e48-b346-ced1c1abd14f	saint pierre and miquelon
264	81df3e25-77eb-49bb-aff1-b722adf0f68c	sint eustatius
265	0c720e46-2f5d-471e-9fc1-dc27bc3629f3	south ossetia
266	cf4779ca-37a6-4f60-bc03-5d760a12c978	svalbard
267	3af87d1b-0507-4bfc-b6a1-e9b91d57fe65	vatican city state
268	077da062-83f7-44a0-9a02-a6db1579d6ea	wallis and futuna
\.


--
-- Data for Name: territory_label; Type: TABLE DATA; Schema: public; Owner: brook
--

COPY public.territory_label (id, uuid, label, territory, the) FROM stdin;
1	966472fb-d2f7-4121-a265-48e97d4464f5	Andorra	1965c743-cf9a-4021-9ed1-b9e4e77486a2	f
2	7db58122-c602-470c-b9ac-c50b372aca72	Principality of Andorra	1965c743-cf9a-4021-9ed1-b9e4e77486a2	t
3	d2740d49-7bf9-4fd1-aa22-50ae06f1f29a	Principality of the Valleys of Andorra	1965c743-cf9a-4021-9ed1-b9e4e77486a2	t
4	a2b4e9b7-c8a0-4a82-9e43-45cdc4973365	United Arab Emirates	2b1a33fe-be25-452b-8a1c-c7d5f1dce9c2	t
5	68ffabb2-50ab-4a9c-98c5-658e5a4d2064	UAE	2b1a33fe-be25-452b-8a1c-c7d5f1dce9c2	t
6	4daef719-ac7d-4a5a-9dc8-d91c2c585d88	Emirates	2b1a33fe-be25-452b-8a1c-c7d5f1dce9c2	t
7	b1bbf571-0aef-4688-bf42-b9d0b0cf0701	French Territory of the Afars and the Issas	74718d89-2c74-4664-a9f9-c3bda5884237	t
8	3eeb8b98-f482-4903-b476-58e595a9c4e6	French Afars and Issas	74718d89-2c74-4664-a9f9-c3bda5884237	t
9	afae6190-5211-42af-b341-ea70c4446d9f	Anguilla	793360a3-aa91-4703-acfe-60287e3f9b74	f
10	dff7f6e7-0450-4ab6-9b9a-ac318f129709	Åland	ca1a8efc-5d84-4e75-9f3b-5d005b9afca5	f
11	f3a2b146-c4c3-4cfe-b27e-5f075bc69543	Åland Islands	ca1a8efc-5d84-4e75-9f3b-5d005b9afca5	t
12	81b12c0a-9efc-43af-8228-ec7fc29f1a92	Barbados	49494a5b-205f-4756-9145-2784c9269a99	f
13	27213d48-2b14-46c6-a96e-0218b635ea46	Netherlands Antilles	437b6b0d-4fe4-4e6a-b869-9aca4351a182	t
14	08de7a95-67c3-4d47-8520-ba060e0e8af7	Dutch Antilles	437b6b0d-4fe4-4e6a-b869-9aca4351a182	t
15	fddc587e-54e4-48a3-89d2-fbdacbd50ed9	Metropolitan France	af123316-5e2b-4453-9908-13434c758d89	f
16	796e5e65-3b48-48fa-9d7f-5105bcba5a35	European France	af123316-5e2b-4453-9908-13434c758d89	f
17	55b9a49f-70d1-4c77-b636-16ed19f13792	Mainland France	af123316-5e2b-4453-9908-13434c758d89	f
18	77720708-a25e-47ce-b625-3e333574446c	French Republic	b7b802fe-8789-4b6d-b085-7c25a92dab7b	t
19	f09b1c16-5de3-4cb2-b074-a3c1cc3498e9	France	b7b802fe-8789-4b6d-b085-7c25a92dab7b	f
20	b84a4818-ecf5-4638-b379-800b385eb8ae	Czechoslovakia	7fb270a5-06a1-4488-951f-55dcc7e822c0	f
21	b7589153-e89a-4799-bfc3-afd0043b4b52	Czecho-Slovakia	7fb270a5-06a1-4488-951f-55dcc7e822c0	f
22	7ac695bb-0d22-4d1f-88ed-82bc68d0b8ce	Czech Republic	c5db5d6b-ebcd-4642-9604-0f1ebf2fdf9d	t
23	2aeafe78-86e2-4121-87cb-4dd02c2fe5db	Czechia	c5db5d6b-ebcd-4642-9604-0f1ebf2fdf9d	f
24	b381a01f-7e55-44ff-becf-d0106c70bee6	Slovakia	2dd507e0-8e57-4924-a57f-8fc2e22555e2	f
25	4f974e65-0edd-4bfd-a8ae-fcc8550ac6b3	Slovak Republic	2dd507e0-8e57-4924-a57f-8fc2e22555e2	t
26	8cbbd94d-33b2-4910-a479-807d52f3c37c	Myanmar	ac8b13ec-0d98-4fad-852e-a351d68e6a16	f
27	71f8b3d1-486c-434d-abec-3d6220483adb	Republic of the Union of Myanmar	ac8b13ec-0d98-4fad-852e-a351d68e6a16	t
28	af31c732-5dc5-4acf-a33e-caa5a7530188	Burma	509e1050-f5ab-4d6b-ba04-501765fb9ecf	f
29	184e6d5a-8808-4e34-9b28-eb29f5cdf68e	Union of Burma	509e1050-f5ab-4d6b-ba04-501765fb9ecf	t
30	7e6ff91d-0d07-4c7f-b9e3-05cd0b43fdb3	Kingdom of Yugoslavia	9081511d-8a3b-4372-b828-44afb55b2dc4	t
31	7ee586ae-bb86-4cb5-bb31-31efd3156968	Yugoslavia	9081511d-8a3b-4372-b828-44afb55b2dc4	f
32	8ba5209d-f3c1-4234-be9a-45e17a816b55	Kingdom of Serbs, Croats and Slovenes	9081511d-8a3b-4372-b828-44afb55b2dc4	t
33	2ae5ae65-d98c-453b-ad7d-e5493d59c683	Serbia and Montenegro	ba063fe6-f538-45d8-9450-81c536a1aa29	f
34	174cbc91-740a-4479-8bd6-ec56ffbae2af	State Union of Serbia and Montenegro	ba063fe6-f538-45d8-9450-81c536a1aa29	t
35	63131144-2a5e-4d93-a36f-95033a505edb	Federal Republic of Yugoslavia	ba063fe6-f538-45d8-9450-81c536a1aa29	t
36	841f1ca8-8e64-414b-bd81-319c536d6ef1	Yugoslavia	ba063fe6-f538-45d8-9450-81c536a1aa29	f
37	75a2ddbd-7b11-4bff-9ca2-64ee4de9bd9a	Montenegro	6702177a-fbed-4cf3-aa32-22da244beab0	f
38	bd018efd-e21e-4b46-996c-60b5f30dedf5	Serbia	aae2ba87-a67d-43bd-8516-e403843d61d9	f
39	e3794db9-1ec2-4013-a465-2ed7d7d96381	Republic of Serbia	aae2ba87-a67d-43bd-8516-e403843d61d9	t
40	3695553f-d123-4bd7-abe9-b00924b44927	United Kingdom	0f433ba9-47e1-4fe6-902c-632bf40355a9	t
41	4d39212e-b7fa-43ee-94e2-d0a8ae0ad3be	United Kingdom of Great Britain and Northern Ireland	0f433ba9-47e1-4fe6-902c-632bf40355a9	t
42	078bd6c9-9d4e-4bc9-87bf-4e13332ac773	England	56c6dacf-b4d9-401b-874a-6518da0cd567	f
43	322d1198-46e1-457c-a139-497b025210c3	Wales	c5bc507e-7bca-4c9d-8d7b-a3441b33dffe	f
44	27759fab-82bd-4161-ad74-ab08627e5af5	Scotland	e054a323-d773-441e-9cbb-9843a1780b2d	f
45	efb6db14-cca5-416d-ad2e-7bd6a7e7f39c	Northern Ireland	c639dcd9-0e03-4f83-bdba-8a5a921b021a	f
46	2c26329e-4aab-4a2e-a9ce-cb64fb3db043	Djibouti	0b48c87c-ddaa-49d2-b736-61d9c44636e0	t
47	a1e0b5dc-ba47-435f-bae9-02e28c45eef2	Republic of Djibouti	0b48c87c-ddaa-49d2-b736-61d9c44636e0	f
50	698a9c73-7e0e-4c14-9a5d-90c31d899eda	Aruba	44344c65-9381-42d7-a573-6a9e38ead0f0	f
51	4032590f-9f5a-418e-8ef8-70cf22b608e1	Bermuda	5cbe7035-cbba-4ba4-9e59-1338db15983a	f
52	632a1730-db03-44b1-8bc3-2987954ce762	British Virgin islands	4fe94a12-77e5-4a49-94c4-6bff7b9f1b2e	t
53	fcb25527-9f4d-4a1e-a322-5da55fd3e75f	Canary islands	b4a2b89a-1d72-4928-becb-eb198ed494be	t
54	d9b40c94-81fa-4b22-b4ba-8e051c3b3b10	Cape Verde	3e77325d-7fea-46ad-a8fa-b2d31056b3ea	f
55	6cc799fd-d80d-43b4-b3b9-47be2e6e67df	Cayman islands	8372a0ad-58ad-41f7-af06-dea7df6ef891	t
56	5b658463-94f0-4949-a36f-8cc7818b5e18	Curaco	3ba46aea-ed4b-48bc-919d-a93a4d6f1d6e	f
57	9d6255ea-3264-409b-8898-7a3c9d159cca	Faeroe islands	38c4b24f-a7d0-4af2-9d09-724ab4ad9017	t
58	8a304963-b3d1-4f8e-8969-d18ef1b9fcd2	Falkland islands	ff772da3-5cb8-4833-a427-2651adf6fbd6	t
59	6e13565c-23bf-4ea7-9989-128380b86680	French Polynesia	472108f0-b6a2-410c-9885-d4fa3b3412bd	f
60	886e9595-ff14-4687-85c7-e2a53a3cf8e6	French Guiana	fef2c7ae-f872-4a71-9c87-0d0727258c26	f
61	1c24ea70-903e-495f-b8dd-93d6c5b3627b	Greenland	5f5fad3d-69c4-41b1-bc88-d9b8cff77027	f
62	fe50eee7-33f1-4f8e-8970-1747316a7ecf	Guadeloupe	ba5a63e1-7feb-4d40-ae2f-d0a9f2123c0c	f
63	5fdc6aa0-f227-4239-bf87-b37258ad8574	Hong Kong	ae7c2b6b-a504-4e11-a52c-97175217c0a7	f
64	9d28f56d-5d57-4d40-8497-42cd81472493	Liechtenstein	8510166b-62a4-475f-8afe-891fe1cb22a0	f
65	e00b2246-31ea-48b8-bdb7-44cc94f04a91	Martinique	07546102-9696-4e5b-80fb-c435267230aa	f
66	cb0144e8-3eab-4107-8c1d-6c6b4b4b6401	Mayotte	4f7bf3fc-1cdd-42ea-acc1-2325444ea405	f
67	50e678bb-2dfa-47fe-8177-195473594107	Montserrat	adc6de52-b3d9-4448-a7d6-39622cf3261f	f
68	da076945-8aa2-4eeb-a35b-d05beeb8ca29	New Caledonia	17b783e7-ad5c-473c-8787-aab9c9397fed	f
69	f0351434-10a7-439e-89df-b1a3017c8fae	Palestine	6ed0c70e-c6ab-4148-aae3-fbf474467390	f
70	59d70527-42bb-4d1a-a74f-a01c656c1b83	Pitcairn islands	6fda58dd-3eb4-49f9-8f07-8e0c4562675b	t
71	51cce0c0-c13d-4aee-954e-89d4fdf30cfc	Puerto Rico	f18ec7fe-184e-4e4b-9ac5-14c5bfbf1fb7	f
72	6258af45-2ce2-48b9-9bed-c56307391208	Reunion	e600ef6e-e2fa-42cd-a54e-60cd0a48c98f	f
73	0bb44753-4600-44f7-a2bd-7aa30574334f	Sint Maarten	f873ab5f-e175-4a90-9e0e-1efe1d0880ff	f
74	0cc1ca5b-8338-4fbb-bef6-fbc8710e2b9d	Swaziland	188c245e-16ba-4c8b-a894-dcfd252e6735	f
75	d42e9a1c-9756-474f-82a6-2a28332fda87	Taiwan	1f6e1df0-b5ff-4eb0-89b2-0bd06cf52883	f
76	d83f4654-70e9-47de-9bd4-e8c2bab35de5	Turks and Caicos islands	29c528d3-2b84-4b14-adec-78d0f7a06fc1	t
77	086a57aa-fd82-4884-be13-f15210793c6b	US Virgin islands	cd560671-9a56-4d59-a90b-3fc5876c54a8	t
78	3bedb04a-e623-45a5-a27f-2b4d6090238a	Western Sahara	7c843d31-a3b7-4fd6-854d-a41fd456ab79	f
80	4f866c76-1ef6-463d-a61c-7380e88a6c5c	Singapore	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	f
81	e53c0edb-97ba-4c88-94e4-11910ee22774	Afghanistan	b33be079-39b7-4a1d-b689-97c224d5fece	f
82	9a355600-6a32-4fb5-8b5a-7b581181dc04	Albania	6c7e4e7d-9bf4-4e47-b2e4-c925f54bcd1a	f
83	c40327e2-4c05-48e3-92de-092ebfb3c7e5	Algeria	d9b8f8c8-5b5a-41ef-8538-26d822a4c9bd	f
84	d8d519c9-02b0-4f4a-9d16-4fdf856cce6c	Angola	bf07965f-f874-453e-a725-54c5a1254ee8	f
85	8e0ec02e-11e7-4921-b2b5-2efc5b1774df	Antigua and Barbuda	90de1527-d5a5-446f-a960-eccda43af198	f
86	ce26d36c-1be3-4dd9-ae0a-388a4ce795ed	Argentina	78219cc6-d1b2-4193-9da7-e7abc92863ee	f
87	bb04de53-8b5a-40f9-9623-b9821b319d02	Armenia	f2f3e704-bb03-467a-a1a0-1d56b6faadce	f
88	b7d18777-4bde-42e2-8b3d-636e9a577c56	Australia	0a3e548d-7e30-426f-840c-07ff9b6772f7	f
89	060b3b14-5b51-4915-91ef-8e2facb22ea5	Austria	e14f7607-8074-4eeb-8b3f-3093575719a4	f
90	7769055f-9f19-44a1-a375-91481cf6d78d	Azerbaijan	319530a8-8cd2-4dc3-84a6-29ac720c51da	f
91	94524a90-29a0-4d3a-9092-ca47a6754b89	Bahamas	ac6434f1-bbb9-4242-a393-d78d367f034a	f
92	e97db14b-e65f-4515-9e24-bcfcda3e0ed4	Bangladesh	bb3fa754-b35e-45ee-8d66-fb159c96d821	f
93	98d757b8-11d5-43c6-98be-90381f569515	Belarus	ac612169-1567-4c5e-a203-3987fa26c267	f
94	2b9f116b-e0f6-409f-8daa-4f8be365692d	Belgium	1f4dd261-dc57-49ec-b872-8b1917703616	f
95	da27c1e2-751a-4bfe-b6c5-e3906f54dc16	Belize	3e62d48d-717d-4421-91c2-abb059a80576	f
96	85b0264b-9d97-44e4-9990-bd890bd848ff	Benin	5fbebc32-e410-4faa-94e5-822252f8b499	f
97	959a1ada-06ed-448e-9341-9641269abe36	Bhutan	1d58bd18-8519-4e53-8cd1-6a7e93cda614	f
98	4e66cbc0-1cb9-460e-ace2-39ab5a405473	Bolivia	546440bf-236c-4f99-bd12-3bba52d50e02	f
99	9e339285-4758-4e84-a201-a877f86340a4	Bosnia and Herzegovina	c103dabb-a386-4a6a-bce5-c0c0fa5f43f6	f
100	bcff2141-b548-4a54-b66c-ffccc7d7a699	Botswana	ff4c5033-aee4-4325-90cc-1f96ef10bbce	f
101	1925677a-6332-4f03-b632-4ba943915ae9	Brazil	1b558876-4f84-41fb-8215-93143842ba53	f
102	2d49fca9-4527-4737-b6bf-294f9d922836	Brunei	49ca53d4-0d59-4be8-9724-70b0eff911ce	f
103	e1418b9f-1dac-40a6-b647-34f1d2ce97f7	Bulgaria	dde93861-da65-40d4-8159-3e67e8d58e02	f
104	538b9236-b1b2-4567-b1f8-cfac65d2ec75	Burkina Faso	a22c7473-248e-4447-8bc7-1fc51c00ca3e	f
105	374159a0-ad09-45f7-bc38-5e4bec2346cf	Burundi	4f0fe689-81e0-4b91-a093-cad33a305482	f
106	02e737cf-367e-47d6-ab3a-f51fd6362bec	Cambodia	723de35c-616a-4b10-b479-c08378f3765b	f
107	97b52f0c-e55e-4144-937f-db19fb62e6bd	Cameroon	526f75ae-3c43-45a3-924e-1d7e11177a68	f
108	24691a29-3195-4af3-80f8-63d18161fd73	Canada	e242cbe2-dc75-4807-a7c9-c171d164ec2d	f
109	634e9e58-0e72-4132-8538-54ec310200c4	Central african republic	2b1aaccb-5846-45c1-8481-12bb8b5e0aa4	f
110	5447dd89-6115-41c7-81f1-02421c21006d	Chad	3f759fc5-8287-4acb-b58d-f235c5ef4981	f
111	22048fb9-6e01-47a3-8da2-93b0871e22ad	Chile	c5a755fa-0935-4ec5-a880-3d4854beabfd	f
112	75478291-fb7b-43ee-be8e-e0adf654b14f	China	7178da96-360e-4b0a-ada4-9640c498daf8	f
113	37d55df4-9b0e-44f5-9267-cfb88b068e2c	Colombia	8b58bd46-c2d7-4df7-8871-378dbe921468	f
114	48877710-0f4c-416a-afc3-dcc8314d5fe0	Comoros	48847459-b1b2-4092-9bf0-f0c08b928c74	f
115	40f9d215-0a81-4a0f-a6d3-669d11598e6c	Costa rica	cf56f0da-daf4-4437-9ad9-4b61bbedc31a	f
116	dee21cac-7c90-4344-94c7-970429413e1f	Croatia	14730d5f-e0e5-43a8-bc67-ca9f92c8502a	f
117	97c59966-11ed-4547-bb83-1acce7f330ec	Cuba	16a55dd1-2e47-489d-830c-3a88aad464a9	f
118	000369c1-b440-4c00-bf74-745d7a86c323	Cyprus	f36ec987-ed66-4a88-9157-b1d4a934e515	f
119	4951211d-439a-470b-80ff-3707178f2e0d	Ivory coast	31d93d6a-5130-4cfa-87ba-90d971d98d34	f
120	a6c900a0-cf46-4237-8fc9-674f093b29f1	North korea	9ad23145-f384-4a8f-a075-4648d1837d46	f
121	eab96b37-4679-47f4-9a65-0f7daa94078c	Congo	196ed632-cc17-4b9f-87cb-cbc9832e8617	f
122	59a6017d-3f86-4c67-ac62-ad33f59a8d9f	Democratic Republic of the Congo	80b3fc54-1fa6-49c6-ac4c-998b002d754f	f
123	0c218611-d523-43b4-8474-62b281e089b3	Denmark	870d8300-9c56-4b34-9447-bcdfedf8454c	f
124	ca35bd16-6a7a-46c2-985b-8020955dca5c	Dominica	a66c6aaf-f010-4056-8928-1653d670edf3	f
125	da2c3a55-e6f0-4b07-b089-0f78a7383b56	Dominican republic	7caae20c-20fa-4ce0-a987-cca304a302b9	f
126	cf11e220-3f9b-4a5a-98d2-3bb4bca2c512	Ecuador	41fa1fc8-a7c9-4045-ac6a-92fe36c27bd9	f
127	ebec51f6-32b3-45cf-9f0b-041346b9a6c1	Egypt	0d0a18fd-d424-4a69-b646-38fffd942dd5	f
128	1ba9faf8-3ca5-4b13-b441-71a60996aaba	El salvador	bae2df87-ee9b-4efe-8482-2b05b54ebb11	f
129	cf3d95c2-0f1e-4866-a750-df7d10be3eb2	Equatorial Guinea	43d35de8-4ed4-4bd7-9fce-54d9adcdeec6	f
130	482611d5-809b-423f-8ada-c49e24f3791e	Eritrea	b2db2210-e9b8-4d51-b3c0-ed8e3d6adc9b	f
131	23266457-2d4e-4a7d-b51c-cefaba41a9dd	Estonia	061c7757-87bb-4acc-bfb5-ebb5a4dc9429	f
132	9f4b6106-65eb-4646-8fd2-6bea74791313	Ethiopia	f76a50d7-c955-4658-a2da-f191b746b434	f
133	c9d3925c-6b34-496a-8f6d-4da570475f2f	Fiji	923566be-1a81-4281-a9f5-fc3d8e59e53e	f
134	665d8084-8e85-48fb-bdf0-79721f4af31b	Finland	d322fe64-203a-4eb4-8316-2c6c1af401a3	f
135	f93e674f-35ca-4077-9089-a2103ae712f5	Gabon	6a95dca7-5bc9-438d-ba51-5cc4603d70a4	f
136	4dadfef1-0673-4c1e-bedb-15c5af1688d8	Gambia	81e9890e-9239-4c33-b429-66950b214814	f
137	9f7460c6-7d82-4c44-bfee-78a5da1cde3d	Georgia	f2e17057-cb16-4fd3-92ef-07a6320c1818	f
138	274fbe79-ab8e-4809-b30e-c2e40054b20a	Germany	d80301ed-7cdc-4f2c-8093-cfec014b077a	f
139	1d7d8203-32a6-4fd2-b91f-a26bec592678	Ghana	53618499-ed33-49f9-aeae-e24d02029f1e	f
140	c99d105b-828e-4a79-9810-e58a246285e3	Greece	1a76eb8a-5fca-4552-a0dd-9728217998b0	f
141	b8b73ae9-c4a6-41dd-91d3-a0906a0fc48d	Grenada	aedfe3b8-fc01-41f8-a152-516e139dc8b6	f
142	4799f7da-df27-43e7-89ab-e5d929691599	Guatemala	0e291c7e-51a2-466f-94b9-de8d9dec9dd2	f
143	7d543c14-6cc9-425c-9054-e5c4f5ae23fe	Guinea	b3e98c98-8a15-45bf-8f86-f26f6a07a425	f
144	d27bda7f-0013-469e-81de-dd57298b88fd	Guinea-Bissau	98fd5d7d-6f4c-434d-bd97-6fabe502db00	f
145	03cf5198-1926-4365-8e35-1885c1ee5caa	Guyana	f11d746c-8b82-4fe1-acb0-788067f0071c	f
146	00042e49-f164-43f7-8f65-9c158cbdb123	Haiti	99530f46-46c4-4263-bd88-dca23dc0383f	f
147	f78dbd39-7f44-4f97-ad9e-54c10834b2be	Honduras	3e33cfe7-603b-4d88-a6e3-f4dcc331d9f2	f
148	002726ef-e97d-47f2-90bd-c5a1dc18f280	Hungary	8287bea9-2349-46e4-9ac0-fb1e799497af	f
149	c1c4d8ea-043f-4cf8-8e63-e9719619aed0	Iceland	68563b3e-8866-4310-bdce-659b3cc9c2ac	f
150	d0ac9ae1-6e8a-4721-98ff-4387319c06da	India	83f3b190-021f-4694-a033-57058c22cbf4	f
151	e15fcc05-139d-402f-989b-e90c86ff3734	Indonesia	a3122035-5d20-411c-a94d-17360ed55678	f
152	d7f0a64c-53d7-4fb7-8173-a7986fb4c296	Iran	1baa5d83-2707-4a0d-8f86-45efc106dffd	f
153	b43565fd-73cb-4478-a34e-6f87286b21d9	Iraq	e130f15d-7a37-4ddf-a6b5-e9c1266e128a	f
154	e7b8acfc-fbe9-4a28-8c34-9f5c6a2b217c	Ireland	48d25a4f-6bcb-4595-bf82-1492334695ec	f
155	7a4183f0-85a7-4bcc-9f14-cc8b75a5e20b	Israel	fc3338b4-47f1-4342-8def-3acabc77a994	f
156	b4819135-6013-4eb5-81d5-4925e028018d	Italy	161a32a0-755e-430b-86dc-8f153f7de9b1	f
157	858a24a3-e9c2-4b9a-8390-f1b5b3db59d7	Jamaica	96abeca6-c08e-4df8-b22f-2fefc55a8d5b	f
158	03ea81fb-e881-4438-968d-b50cae70fd53	Japan	8e5a125d-73cb-45c1-a511-f0c65d7448e7	f
159	94d8dc26-53f4-412d-82f8-e3846495f453	Jordan	c728bbe4-373f-4d0a-9a3f-985679759733	f
160	0bcaaa9d-aa2a-424e-becf-7f956fbad491	Kazakhstan	c6a8ea7c-3fed-4a1d-9929-5569db7ab968	f
161	6789b816-88f5-4160-86cd-2ec8fda80322	Kenya	e91cae72-f62c-407e-b388-3f3b86f7a0c3	f
162	194bbd5d-a73b-4f7e-8e64-da205474c38e	Kuwait	ab2a946c-f1e3-43f5-bbfd-4b54adae333a	f
163	f5f82cbc-5f9f-4136-8be4-9a26a6554f0e	Kyrgyzstan	6cec735b-3406-430f-be56-71d96ff8f41e	f
164	a7fd5a43-28c9-42cc-80c9-32b0e10ad1bd	Laos	34e549be-e921-419a-a64d-2349902ee1e8	f
165	69a15634-957e-4a7d-bff7-a9f71afa1015	Latvia	85b0fd58-f24b-4249-a31c-46e40023744c	f
166	8f5d752d-8add-468e-939f-d4bac703981a	Lebanon	6a6a8869-35f4-4d7f-af9f-c881d3b4bc19	f
167	c3693b92-90e4-436a-9600-65f7175ccf00	Lesotho	f7ca89ef-b000-416a-b9f4-6059b2d8a3ca	f
168	f1ba9cf0-b793-4fe3-ba90-2ff08d5de554	Liberia	e3c9a7c1-e5ec-46aa-be24-13a63b23c24a	f
169	2bc3f10a-8377-4c00-895d-49b71be4dbed	Libya	a9bc64d6-1f2e-4882-90bc-4930614667da	f
170	e457c129-fac5-4ee1-97f7-f38830a03672	Lithuania	d4d24a30-2184-4fd3-8315-248ddc094526	f
171	dff418a6-ccc4-4d59-8e81-12505fc58edf	Luxembourg	a94b35b0-c269-4e9f-9d66-80d8f3081989	f
172	90f178d1-3f1d-4e65-85aa-523b2c84dc2f	Madagascar	b7206cc1-2cca-454d-9447-3788640f7b5e	f
173	9aa76056-445b-41e0-aecb-220b02d26ecd	Malawi	413fe813-55c0-49e9-8853-47654b4ae73b	f
174	d4dd2d29-4fb1-433b-bfda-6ee5eca38284	Malaysia	d42ac9fd-1e10-4995-8dc1-4d25cee7a022	f
175	c8ab9890-2ab4-4807-9d3f-fb27850a042b	Maldives	2b8d132e-e3b8-4a97-aa78-a265bf65836d	f
176	c575a7bb-b6b4-4dc5-a2cf-6dc394974713	Mali	a8c0bf67-69a5-4293-8282-622c6b61962c	f
177	dc3a1518-b65d-4b27-a927-fea02012b9ca	Malta	ca8f94ef-b748-47c8-b040-b996e3cf2581	f
178	d2c766d5-7f53-49f6-92ac-3e4cae0fa93c	Mauritania	a4d1f62b-6131-44de-92fe-975d0a463bc7	f
179	fc0e254b-6dcc-4595-acb2-a81e0df4cbcf	Mauritius	59a60488-bbd7-476a-813e-a92fa901e8e7	f
180	4dd5abea-8f43-424a-8c98-d879b7b3832e	Mexico	846ec109-79bc-4e46-a303-40e20bcb2f36	f
181	9adf9baa-0620-4072-92c2-3ac1a59d82b8	Mongolia	b60fe946-71ac-40be-97dc-8ee0b78c3384	f
182	f0430990-b234-4f76-a769-700ce8e79b60	Morocco	a7462d3b-b094-454a-a09c-08573a566463	f
183	ee986373-f130-4d02-ba60-64202b253d8f	Mozambique	95251d34-e411-4cb7-9112-0a1f95b239e0	f
184	b969fa27-4890-406c-a045-2417edfc6717	Namibia	dff0e275-70f0-4d4b-9d4a-3b4029ab3cd1	f
185	df33deaa-bc51-4529-ae23-ddf9b28f7870	Nauru	c00f0e5e-a315-4118-b879-8d0a07faa486	f
186	0ad9547e-5804-4ee8-b4e8-0f2aef3fe9eb	Nepal	52a86412-42e6-499e-a742-a0902ca649b5	f
187	5448b983-499f-4a17-9e18-09b12bfea9d4	Netherlands	649e4cd5-204a-41ae-add6-5c7433d23973	f
188	f39c89c6-edda-4a7d-ab99-2c340badd328	New Zealand	903625d0-0df4-4537-8370-4c3cda4ffed6	f
189	93a9ff06-8f15-4ac8-a4ee-aec959ffd120	Nicaragua	390d0b06-0892-405b-93f4-8b1b69af9667	f
190	4ba9c632-36f5-44f0-9ce6-7404542f2fe5	Niger	363bc536-025f-4ef7-95c0-a083bb8f37e6	f
191	484cf497-6f06-4c49-9dd5-bb3c82b14388	Nigeria	7ce306aa-4c86-4016-93ab-cf3f5c22c621	f
192	e46c8ce6-7d5f-4f39-b85e-6843392f93c9	North Macedonia	6b9ca8c2-1096-496b-9aa2-0a0dc3fb4f32	f
193	2ff635f1-5efa-4217-abf6-777a31acb9b7	Norway	4f50cb61-60cb-48f5-9c7a-974d9c3840d5	f
194	2d2267af-377d-4b1b-8713-6f8fc9a6a596	Oman	7a1e411c-5e2b-4ef6-9561-73a4466af643	f
195	e17c85ec-65c7-4d79-90a4-684308c21330	Pakistan	abc45575-6e5a-49c5-9967-e067a503c8a6	f
196	8da7a616-b3de-4316-ba70-72842cec6151	Panama	e32cd55b-2b25-444e-beb4-f86a6e81819b	f
197	f34af676-653b-43ac-808a-26fb46cb0be8	Papua New Guinea	2f5d487b-20b7-47c4-b8fe-378d3c40839a	f
198	2c9ac102-ea64-4ebf-b320-32fc4d219f01	Paraguay	5091a6a9-aa19-4e48-890a-d0d3ccce88c7	f
199	78dbb93f-d325-4d88-bd0c-39edd785d582	Peru	6fd50499-8698-4764-a9ea-d063e211ae85	f
200	8720bc7f-b93d-40d0-a1cd-f4b11d63fc77	Philippines	d29dcef8-e41b-4540-8f88-8849607ad3f3	f
201	b4dae8eb-cf5c-4eda-b2f4-17f73903b7a7	Poland	9a7ad7e0-1e36-4004-9879-568b56d0cf87	f
202	8a2f1c0e-9ac3-4392-ad54-7072651efc35	Portugal	c2f84d45-aa39-4df1-8a87-e4dd0c5b34a1	f
203	17a6f9dc-8020-4e7f-9053-7b8cd7425748	Qatar	90a93353-4714-42fc-8632-09f25bc1312a	f
204	e8119a5d-0d1b-41e2-bda1-29c5f603cabc	South Korea	52dc85c7-9f30-470a-9de9-09b95bc11e86	f
205	a493b4aa-a088-42cc-8826-6499390179eb	Moldova	6f37afd2-3170-4c9d-8fde-28d6a44eda0d	f
206	d0ee8f34-d784-45a4-ac29-87ba11141dcc	Romania	fdf4338f-fd3a-446b-9688-b28515d38074	f
207	f4b6d841-d2a3-49f7-9393-1c5e4aefdb59	Russia	ae5dee3a-1222-4f42-9f97-470ab88b3b7e	f
208	3f32180a-f49b-4210-a659-e4a70b5f6279	Rwanda	418d8911-a62b-4686-bf0e-f18b204398d8	f
209	9aba4084-e0ab-4c12-ac38-05945af034f9	Saint Kitts and Nevis	ec506881-6436-49fc-b56e-42da02dd7d5b	f
210	07d41604-f087-49b1-af76-75d63cdee82b	Saint Lucia	e3b26362-6759-4612-8863-4785505a679e	f
211	9f5fa0cc-383c-4fae-ac3f-763be3445631	Saint Vincent and the Grenadines	54824162-df76-4f5e-8783-404687f907f1	f
212	a8c00d41-7259-4c9a-ada8-28e7714962ce	São Tomé and Príncipe	ab4bc3a4-7c19-4a94-905c-a7973e0feaff	f
213	b99811fa-c38b-47f8-b4ca-1b67279c0a1f	Saudi Arabia	dfffd0b6-a252-421b-94cb-6d44695c5c8c	f
214	0badf067-2508-4668-924b-cc92aa43ad55	Senegal	e98795b2-4086-41b5-bac1-4789d9aee005	f
215	b6d1445f-bada-4f70-9ca1-e1ca99937d90	Seychelles	4998e162-96ca-4381-ab19-3dc43922884a	f
216	aec58efa-ec0b-42e4-8100-4b9735252bc6	Sierra leone	d8df4bc3-503b-41ca-987e-423e41ecb52c	f
217	a81679c3-b8ee-4690-a1a6-b8e3dc295afa	Slovenia	dbc583de-b4de-46ba-aae0-1e8d35054bf3	f
218	873201df-0d5d-4e8c-8179-133ce5a8a224	Solomon islands	b7f76500-4fa3-457f-aca8-477f05aab728	f
219	8d0bb20d-7e33-45f2-bb18-6834fbeb3c23	Somalia	98943525-f93f-426f-a3fe-b48bc18c0c52	f
220	44296b60-173a-435f-b308-e189a898002a	South Africa	247ff0fd-78ad-4ca4-90f2-f0394a714535	f
221	3314d5d7-4d9b-4caa-bb5c-ee2f959f9a64	South Sudan	3ffea3be-1c82-411a-b085-933205f900c7	f
222	5ec38c23-27ec-4c31-b7a7-b3fa19c80e73	Spain	02e5c743-3075-4226-8c1d-ad97dadda3d8	f
223	5a418483-51b8-4c12-b526-623d601db24e	Sri Lanka	6c6c9e3f-2353-431c-83c4-2c0cc6c42ff6	f
224	b21e229d-8f0e-466b-8f37-a012a3095c89	Sudan	c149c091-51c2-41d7-85a7-7d67bcac4230	f
225	bc3ce2b4-9fa4-427a-8b15-fee1b800fc52	Suriname	e0e0a4c5-9076-4a1e-949f-9dd4521eb0f3	f
226	fe35e082-01b4-4d9f-ab66-03f0a7bf7f48	Sweden	5c3dd764-6824-4689-a3e1-1d8c2dc3bc93	f
227	8c3e9a2e-00c3-4c22-be70-43cf4ea5dc5f	Switzerland	dacd5cdd-8e56-4067-bfd8-febc66a04058	f
228	187dcaad-bc97-4cfd-901b-2beaaf763e75	Syria	7073c668-a71d-4cf0-a8dd-71008877f8ca	f
229	9cfd567f-c962-4469-8ac7-a83672a18e3a	Tajikistan	893ca48d-0871-46b1-b299-4bf7e7c98dfa	f
230	33fce9e1-1d47-4c40-82ba-f7c370148742	Thailand	99d1c02c-0a04-4eae-b6cd-403f94e43959	f
231	41248720-900b-4e68-8b4f-892cae8c249b	Timor-Leste	1a61eb0b-45a3-4b91-89c2-c22a20676491	f
232	11f1cde7-029d-4fc2-9a82-4126f0e817b1	Togo	1a7ba610-72c3-4816-81b5-aad9503a4a9b	f
233	23fab66b-c3da-4694-addd-9600b1eedf06	Tonga	85e41f4f-c125-4753-bbed-c2ffc7e1c288	f
234	7b5defe1-4702-4ada-9c47-d652d163f72f	Trinidad and Tobago	06659bc5-9958-457e-ac56-2860917a3d28	f
235	4d6e88c5-ce80-4c3a-ab4e-43f201d6c0b7	Tunisia	cac7a781-be5d-4c59-b9b8-d8bb65fb1487	f
236	6174dab7-016a-4914-9fe5-952dcf9cd727	Turkey	fb99fe5c-118c-44d8-97ba-6570cdb7bd33	f
237	a18e23c8-83df-4ff9-8cd9-f5c29fa4bd41	Turkmenistan	0adc54bf-ff91-4cb0-8571-d89b779f1061	f
238	7a2057a3-5fbb-4156-bc38-a49a3eee2916	Uganda	c5ce24da-dd58-4e8e-a5e3-91b478717bb4	f
239	3cf24592-002a-4d6e-9183-8844319a5b5b	Ukraine	6b63bb5b-0238-4263-bdf4-8064a4fb5c26	f
240	14b3b23b-ed7d-40b6-ab58-d1129d63b4f9	Tanzania	1bf315d2-0a2d-4686-9ecb-6d28f8a5b861	f
241	73de65dd-4cd3-4d54-9777-78cb995c31c9	USA	0bea6297-7d53-49a7-927e-e5cbc57e3b5a	f
242	4aa692da-ce8b-4c4e-954d-e040331a672d	Uruguay	d95a4486-5ca4-4500-8b10-211b945552c8	f
243	76deb879-5c60-4c1c-9300-f7aae22d9e0c	Uzbekistan	19c52566-e35f-44fd-8130-d64562928fe2	f
244	61431504-de32-431e-9f41-a7b0d65a8fe6	Vanuatu	33f94df7-cd4f-487a-aa5c-fb45b65f19d5	f
245	803138ab-12cb-4260-b2e1-cd23d25bbff3	Venezuela	3a93a29d-abcc-45af-8915-8e983662c88a	f
246	2a190716-3c8b-4d98-ab13-f406fb38f5ec	Vietnam	ec48dda4-e153-4854-9bc3-453263e606b1	f
247	f8d5c3c9-a91e-4219-a979-fdbfa0a3bdb0	Yemen	9da8253b-a4dc-41f8-b8fa-e751b6812191	f
248	ac606dcc-dc79-4a72-9404-2405baeaa16c	Zambia	40fbcdb1-c386-45b7-946f-7e4190dcc02c	f
249	816af8c5-ab36-4d85-b0d0-ef5e3e4332e8	Zimbabwe	39658cd7-be12-4512-8a90-0b2cc9b2769d	f
\.


--
-- Data for Name: territory_language; Type: TABLE DATA; Schema: public; Owner: brook
--

COPY public.territory_language (id, uuid, territory, language) FROM stdin;
1	799b648f-4d7f-479e-96f7-b1b163ed6a5c	0f433ba9-47e1-4fe6-902c-632bf40355a9	e6611c19-fe1f-4086-8eb1-bb0d5620e5d0
2	45a496f9-6c2d-4cab-b962-fd9b953a5cd3	56c6dacf-b4d9-401b-874a-6518da0cd567	08260f08-1fec-456d-ad5e-660cbc7f1c4c
\.


--
-- Data for Name: territory_reltionship; Type: TABLE DATA; Schema: public; Owner: brook
--

COPY public.territory_reltionship (id, territory, related_territory, relationship) FROM stdin;
1	56c6dacf-b4d9-401b-874a-6518da0cd567	0f433ba9-47e1-4fe6-902c-632bf40355a9	is within
2	c5bc507e-7bca-4c9d-8d7b-a3441b33dffe	0f433ba9-47e1-4fe6-902c-632bf40355a9	is within
3	e054a323-d773-441e-9cbb-9843a1780b2d	0f433ba9-47e1-4fe6-902c-632bf40355a9	is within
4	c639dcd9-0e03-4f83-bdba-8a5a921b021a	0f433ba9-47e1-4fe6-902c-632bf40355a9	is within
\.


--
-- Data for Name: territory_reltionship_type; Type: TABLE DATA; Schema: public; Owner: brook
--

COPY public.territory_reltionship_type (id, name) FROM stdin;
1	is within
2	contains
\.


--
-- Data for Name: territory_top_level_domain; Type: TABLE DATA; Schema: public; Owner: brook
--

COPY public.territory_top_level_domain (id, uuid, territory, top_level_domain) FROM stdin;
1	1d7ebc47-cc48-47f7-aed8-3874079a9222	0f433ba9-47e1-4fe6-902c-632bf40355a9	.ac.uk
2	d952ad7d-581f-40ca-9347-6cd3838c455f	56c6dacf-b4d9-401b-874a-6518da0cd567	.ac.uk
3	2f5778d9-7685-4fec-89c1-d3e6bef05d8f	1965c743-cf9a-4021-9ed1-b9e4e77486a2	.ad
4	e6d7aded-5a83-4508-a302-6c52191b3210	2b1a33fe-be25-452b-8a1c-c7d5f1dce9c2	.ae
5	e3d34272-4330-4e13-b8af-fc58a485eedf	793360a3-aa91-4703-acfe-60287e3f9b74	.ai
6	886bcbbc-bb94-4101-8392-4ea26d138dde	ca1a8efc-5d84-4e75-9f3b-5d005b9afca5	.ax
7	e8abc917-345f-8e56-1945-3822c9269a99	49494a5b-205f-4756-9145-2784c9269a99	.bb
8	07eb7591-8861-4e06-b5bc-3f71dba1cec5	0f433ba9-47e1-4fe6-902c-632bf40355a9	.co.uk
9	556400c9-a3db-4d0b-9246-39b9ff5ea046	56c6dacf-b4d9-401b-874a-6518da0cd567	.co.uk
10	d9a42f94-a385-4c2a-93b8-dc366f7f2f35	c5db5d6b-ebcd-4642-9604-0f1ebf2fdf9d	.cz
11	fed8240b-f034-4545-94cd-457150f68b96	0b48c87c-ddaa-49d2-b736-61d9c44636e0	.dj
12	c6ec0ace-f8bb-46ea-aa14-a2a22d286099	0f433ba9-47e1-4fe6-902c-632bf40355a9	.gov.uk
13	ec051c91-874c-4ac8-aa27-892f4844f42a	56c6dacf-b4d9-401b-874a-6518da0cd567	.gov.uk
14	73df6176-8af9-41ff-9abd-67926b3e4c26	56c6dacf-b4d9-401b-874a-6518da0cd567	.lea.uk
15	d510ad20-7a2c-4433-99fc-e432fcdbb130	0f433ba9-47e1-4fe6-902c-632bf40355a9	.lea.uk
16	1c67dc1d-417e-4751-baa1-9eb4dff94b47	0f433ba9-47e1-4fe6-902c-632bf40355a9	.ltd.uk
17	9422498e-9022-4504-9fc9-9cfa578100fd	56c6dacf-b4d9-401b-874a-6518da0cd567	.ltd.uk
18	558e42b9-f698-4f61-9c81-01b167221ad0	6702177a-fbed-4cf3-aa32-22da244beab0	.me
19	02118959-71af-4832-aa8c-1f49c17a6a0a	0f433ba9-47e1-4fe6-902c-632bf40355a9	.me.uk
20	c32ef975-46fd-4220-a498-728ca4cc6359	56c6dacf-b4d9-401b-874a-6518da0cd567	.me.uk
21	edc188c0-4cd3-45c1-adfb-2a074e003641	ac8b13ec-0d98-4fad-852e-a351d68e6a16	.mm
22	7c31311e-b679-4516-a52a-b583fa2d98d4	0f433ba9-47e1-4fe6-902c-632bf40355a9	.mod.uk
23	864e1ca2-fd8d-405e-afcf-7e44d4ca36a4	56c6dacf-b4d9-401b-874a-6518da0cd567	.mod.uk
24	3e163321-4de7-4927-9305-99f74c230b65	0f433ba9-47e1-4fe6-902c-632bf40355a9	.net.uk
25	a3d11e42-6b08-4aaf-81c6-732e728fba08	56c6dacf-b4d9-401b-874a-6518da0cd567	.net.uk
26	5beaa7ff-eb6a-42fc-bbdf-78616d0f8ed2	0f433ba9-47e1-4fe6-902c-632bf40355a9	.nhs.uk
27	ba43b682-c8da-479a-81ec-792c3a785839	56c6dacf-b4d9-401b-874a-6518da0cd567	.nhs.uk
28	112a58cf-b42c-4250-975c-e81c690a4e7b	0f433ba9-47e1-4fe6-902c-632bf40355a9	.nic.uk
29	eafebf0c-b593-46b7-998c-ff45b72cdb78	56c6dacf-b4d9-401b-874a-6518da0cd567	.nic.uk
30	050749b8-0592-4ca4-84da-244a7bf99568	0f433ba9-47e1-4fe6-902c-632bf40355a9	.org.uk
31	bbfb0884-e4fe-4c33-a65d-a46a61a43369	56c6dacf-b4d9-401b-874a-6518da0cd567	.org.uk
32	21c0a668-0652-4632-89c4-b7b193fb8b58	0f433ba9-47e1-4fe6-902c-632bf40355a9	.parliament.uk
33	2c0d9b15-5de3-4e94-9176-535fefcbcc99	56c6dacf-b4d9-401b-874a-6518da0cd567	.parliament.uk
34	4aa7191e-0d5b-4f6c-848e-03d8188ddec0	0f433ba9-47e1-4fe6-902c-632bf40355a9	.plc.uk
35	745f7be8-1a4d-4494-906a-5956d6d52bc9	56c6dacf-b4d9-401b-874a-6518da0cd567	.plc.uk
36	ab637c93-0e38-4d6e-9a86-841074756509	56c6dacf-b4d9-401b-874a-6518da0cd567	.police.uk
37	de2ff124-b6a5-41bc-96ea-73394a11e84c	0f433ba9-47e1-4fe6-902c-632bf40355a9	.police.uk
38	87a7b553-1ad0-47d7-883e-d2b87eb3eef4	aae2ba87-a67d-43bd-8516-e403843d61d9	.rs
39	15e7c9c6-09d8-4830-bcab-670776aa855e	56c6dacf-b4d9-401b-874a-6518da0cd567	.sch.uk
40	9aed8a8e-f8d1-4b07-92aa-1742881a2cd2	0f433ba9-47e1-4fe6-902c-632bf40355a9	.sch.uk
41	14b0563c-a8af-4e18-a659-d813e6eff221	2dd507e0-8e57-4924-a57f-8fc2e22555e2	.sk
42	3d5bff03-1d56-436e-a1c5-fe349db398b2	0f433ba9-47e1-4fe6-902c-632bf40355a9	.uk
43	cc9165b8-df2b-4a2c-95da-380b8a3bde51	56c6dacf-b4d9-401b-874a-6518da0cd567	.uk
44	0d321f16-df3b-43ff-847d-5e9482cca4c4	9081511d-8a3b-4372-b828-44afb55b2dc4	.yu
\.


--
-- Data for Name: top_level_domain; Type: TABLE DATA; Schema: public; Owner: brook
--

COPY public.top_level_domain (id, name) FROM stdin;
1	.bb
2	.ad
3	.ae
4	.ax
5	.ai
6	.cz
7	.sk
8	.yu
9	.mm
10	.me
11	.rs
12	.co.uk
13	.uk
14	.ac.uk
15	.gov.uk
16	.ltd.uk
17	.mod.uk
18	.me.uk
19	.net.uk
20	.nhs.uk
21	.nic.uk
22	.parliament.uk
23	.org.uk
24	.plc.uk
25	.police.uk
26	.sch.uk
27	.lea.uk
28	.dj
29	.aaa
30	.aarp
31	.abarth
32	.abb
33	.abbott
34	.abbvie
35	.abc
36	.able
37	.abogado
38	.abudhabi
39	.ac
40	.academy
41	.accenture
42	.accountant
43	.accountants
44	.aco
45	.active
46	.actor
47	.adac
48	.ads
49	.adult
50	.co.ae
51	.net.ae
52	.aeg
53	.aero
54	.airport.aero
55	.cargo.aero
56	.charter.aero
57	.aetna
58	.af
59	.com.af
60	.net.af
61	.org.af
62	.afamilycompany
63	.afl
64	.africa
65	.ag
66	.co.ag
67	.com.ag
68	.net.ag
69	.nom.ag
70	.org.ag
71	.agakhan
72	.agency
73	.com.ai
74	.net.ai
75	.off.ai
76	.org.ai
77	.aig
78	.aigo
79	.airbus
80	.airforce
81	.airtel
82	.akdn
83	.al
84	.com.al
85	.net.al
86	.org.al
87	.alfaromeo
88	.alibaba
89	.alipay
90	.allfinanz
91	.allstate
92	.ally
93	.alsace
94	.alstom
95	.am
96	.co.am
97	.com.am
98	.net.am
99	.north.am
100	.org.am
101	.radio.am
102	.south.am
103	.americanexpress
104	.americanfamily
105	.amex
106	.amfam
107	.amica
108	.amsterdam
109	.an
110	.analytics
111	.android
112	.anquan
113	.anz
114	.ao
115	.co.ao
116	.it.ao
117	.og.ao
118	.pb.ao
119	.aol
120	.apartments
121	.app
122	.apple
123	.aq
124	.aquarelle
125	.ar
126	.com.ar
127	.int.ar
128	.net.ar
129	.org.ar
130	.arab
131	.aramco
132	.archi
133	.army
134	.arpa
135	.art
136	.arte
137	.as
138	.asda
139	.asia
140	.associates
141	.at
142	.co.at
143	.or.at
144	.athleta
145	.attorney
146	.au
147	.asn.au
148	.com.au
149	.id.au
150	.info.au
151	.net.au
152	.org.au
153	.auction
154	.audi
155	.audible
156	.audio
157	.auspost
158	.author
159	.auto
160	.autos
161	.avianca
162	.aw
163	.aws
164	.axa
165	.az
166	.biz.az
167	.co.az
168	.com.az
169	.edu.az
170	.gov.az
171	.info.az
172	.int.az
173	.mil.az
174	.name.az
175	.net.az
176	.org.az
177	.pp.az
178	.pro.az
179	.azure
180	.ba
181	.co.ba
182	.baby
183	.baidu
184	.banamex
185	.bananarepublic
186	.band
187	.bank
188	.bar
189	.barcelona
190	.barclaycard
191	.barclays
192	.barefoot
193	.bargains
194	.baseball
195	.basketball
196	.bauhaus
197	.bayern
198	.com.bb
199	.net.bb
200	.org.bb
201	.bbc
202	.bbt
203	.bbva
204	.bcg
205	.bcn
206	.bd
207	.ac.bd
208	.com.bd
209	.net.bd
210	.org.bd
211	.be
212	.beats
213	.beauty
214	.beer
215	.bentley
216	.berlin
217	.best
218	.bestbuy
219	.bet
220	.bf
221	.bg
222	.bh
223	.com.bh
224	.bharti
225	.bi
226	.co.bi
227	.com.bi
228	.edu.bi
229	.info.bi
230	.mo.bi
231	.net.bi
232	.or.bi
233	.org.bi
234	.bible
235	.bid
236	.bike
237	.bing
238	.bingo
239	.bio
240	.biz
241	.auz.biz
242	.bj
243	.com.bj
244	.bl
245	.black
246	.blackfriday
247	.blanco
248	.blockbuster
249	.blog
250	.bloomberg
251	.blue
252	.bm
253	.com.bm
254	.net.bm
255	.org.bm
256	.bms
257	.bmw
258	.bn
259	.com.bn
260	.bnl
261	.bnpparibas
262	.bo
263	.com.bo
264	.net.bo
265	.org.bo
266	.tv.bo
267	.boats
268	.boehringer
269	.bofa
270	.bom
271	.bond
272	.boo
273	.book
274	.booking
275	.boots
276	.bosch
277	.bostik
278	.boston
279	.bot
280	.boutique
281	.box
282	.bq
283	.br
284	.abc.br
285	.adm.br
286	.adv.br
287	.agr.br
288	.am.br
289	.aparecida.br
290	.arq.br
291	.art.br
292	.ato.br
293	.belem.br
294	.bhz.br
295	.bio.br
296	.blog.br
297	.bmd.br
298	.boavista.br
299	.bsb.br
300	.campinas.br
301	.caxias.br
302	.cim.br
303	.cng.br
304	.cnt.br
305	.com.br
306	.coop.br
307	.curitiba.br
308	.ecn.br
309	.eco.br
310	.edu.br
311	.emp.br
312	.eng.br
313	.esp.br
314	.etc.br
315	.eti.br
316	.far.br
317	.flog.br
318	.floripa.br
319	.fm.br
320	.fnd.br
321	.fortal.br
322	.fot.br
323	.foz.br
324	.fst.br
325	.g12.br
326	.ggf.br
327	.gov.br
328	.gru.br
329	.imb.br
330	.ind.br
331	.inf.br
332	.jampa.br
333	.jor.br
334	.lel.br
335	.maceio.br
336	.manaus.br
337	.mat.br
338	.med.br
339	.mil.br
340	.mus.br
341	.natal.br
342	.net.br
343	.nom.br
344	.not.br
345	.ntr.br
346	.odo.br
347	.org.br
348	.palmas.br
349	.poa.br
350	.ppg.br
351	.pro.br
352	.psc.br
353	.psi.br
354	.qsl.br
355	.radio.br
356	.rec.br
357	.recife.br
358	.rio.br
359	.salvador.br
360	.slg.br
361	.srv.br
362	.taxi.br
363	.teo.br
364	.tmp.br
365	.trd.br
366	.tur.br
367	.tv.br
368	.vet.br
369	.vix.br
370	.vlog.br
371	.wiki.br
372	.zlg.br
373	.bradesco
374	.bridgestone
375	.broadway
376	.broker
377	.brother
378	.brussels
379	.bs
380	.com.bs
381	.net.bs
382	.org.bs
383	.bt
384	.com.bt
385	.budapest
386	.bugatti
387	.build
388	.builders
389	.business
390	.buy
391	.buzz
392	.bv
393	.bw
394	.ac.bw
395	.co.bw
396	.net.bw
397	.org.bw
398	.by
399	.com.by
400	.minsk.by
401	.net.by
402	.bz
403	.co.bz
404	.com.bz
405	.net.bz
406	.org.bz
407	.za.bz
408	.bzh
409	.ca
410	.cab
411	.cafe
412	.cal
413	.call
414	.calvinklein
415	.cam
416	.camera
417	.camp
418	.cancerresearch
419	.canon
420	.capetown
421	.capital
422	.capitalone
423	.car
424	.caravan
425	.cards
426	.care
427	.career
428	.careers
429	.cars
430	.cartier
431	.casa
432	.case
433	.caseih
434	.cash
435	.casino
436	.cat
437	.catering
438	.catholic
439	.cba
440	.cbn
441	.cbre
442	.cbs
443	.cc
444	.edu.cc
445	.org.cc
446	.cd
447	.com.cd
448	.net.cd
449	.org.cd
450	.ceb
451	.center
452	.ceo
453	.cern
454	.cf
455	.cfa
456	.cfd
457	.cg
458	.ch
459	.chanel
460	.channel
461	.charity
462	.chase
463	.chat
464	.cheap
465	.chintai
466	.chloe
467	.christmas
468	.chrome
469	.chrysler
470	.church
471	.ci
472	.ac.ci
473	.co.ci
474	.com.ci
475	.ed.ci
476	.edu.ci
477	.go.ci
478	.int.ci
479	.net.ci
480	.or.ci
481	.org.ci
482	.cipriani
483	.circle
484	.cisco
485	.citadel
486	.citi
487	.citic
488	.city
489	.cityeats
490	.ck
491	.co.ck
492	.edu.ck
493	.gov.ck
494	.net.ck
495	.org.ck
496	.cl
497	.claims
498	.cleaning
499	.click
500	.clinic
501	.clinique
502	.clothing
503	.cloud
504	.club
505	.clubmed
506	.cm
507	.co.cm
508	.com.cm
509	.net.cm
510	.cn
511	.ah.cn
512	.bj.cn
513	.com.cn
514	.cq.cn
515	.fj.cn
516	.gd.cn
517	.gs.cn
518	.gx.cn
519	.gz.cn
520	.ha.cn
521	.hb.cn
522	.he.cn
523	.hi.cn
524	.hk.cn
525	.hl.cn
526	.hn.cn
527	.jl.cn
528	.js.cn
529	.jx.cn
530	.ln.cn
531	.mo.cn
532	.net.cn
533	.nm.cn
534	.nx.cn
535	.org.cn
536	.qh.cn
537	.sc.cn
538	.sd.cn
539	.sh.cn
540	.sn.cn
541	.sx.cn
542	.tj.cn
543	.tw.cn
544	.xj.cn
545	.xz.cn
546	.yn.cn
547	.zj.cn
548	.co
549	.com.co
550	.net.co
551	.nom.co
552	.coach
553	.codes
554	.coffee
555	.college
556	.cologne
557	.com
558	.ae.com
559	.africa.com
560	.ar.com
561	.br.com
562	.cn.com
563	.co.com
564	.de.com
565	.eu.com
566	.gb.com
567	.gr.com
568	.hk.com
569	.hu.com
570	.jpn.com
571	.kr.com
572	.mex.com
573	.no.com
574	.nv.com
575	.pty-ltd.com
576	.qc.com
577	.ru.com
578	.sa.com
579	.se.com
580	.uk.com
581	.us.com
582	.uy.com
583	.za.com
584	.comcast
585	.commbank
586	.community
587	.company
588	.compare
589	.computer
590	.comsec
591	.condos
592	.construction
593	.consulting
594	.contact
595	.contractors
596	.cooking
597	.cookingchannel
598	.cool
599	.coop
600	.corsica
601	.country
602	.coupon
603	.coupons
604	.courses
605	.cpa
606	.cr
607	.ac.cr
608	.co.cr
609	.ed.cr
610	.fi.cr
611	.go.cr
612	.or.cr
613	.sa.cr
614	.credit
615	.creditcard
616	.creditunion
617	.cricket
618	.crown
619	.crs
620	.cruise
621	.cruises
622	.csc
623	.cu
624	.com.cu
625	.cuisinella
626	.cv
627	.com.cv
628	.gov.cv
629	.int.cv
630	.net.cv
631	.nome.cv
632	.org.cv
633	.publ.cv
634	.cw
635	.com.cw
636	.net.cw
637	.cx
638	.cy
639	.ac.cy
640	.biz.cy
641	.com.cy
642	.ekloges.cy
643	.gov.cy
644	.ltd.cy
645	.name.cy
646	.net.cy
647	.org.cy
648	.parliament.cy
649	.press.cy
650	.pro.cy
651	.tm.cy
652	.cymru
653	.cyou
654	.co.cz
655	.dabur
656	.dad
657	.dance
658	.data
659	.date
660	.dating
661	.datsun
662	.day
663	.dclk
664	.dds
665	.de
666	.co.de
667	.com.de
668	.deal
669	.dealer
670	.deals
671	.degree
672	.delivery
673	.dell
674	.deloitte
675	.delta
676	.democrat
677	.dental
678	.dentist
679	.desi
680	.design
681	.dev
682	.dhl
683	.diamonds
684	.diet
685	.digital
686	.direct
687	.directory
688	.discount
689	.discover
690	.dish
691	.diy
692	.dk
693	.biz.dk
694	.co.dk
695	.dm
696	.co.dm
697	.com.dm
698	.net.dm
699	.org.dm
700	.dnp
701	.do
702	.art.do
703	.com.do
704	.net.do
705	.org.do
706	.sld.do
707	.web.do
708	.docs
709	.doctor
710	.dodge
711	.dog
712	.doha
713	.domains
714	.doosan
715	.dot
716	.download
717	.drive
718	.dtv
719	.dubai
720	.duck
721	.dunlop
722	.duns
723	.dupont
724	.durban
725	.dvag
726	.dvr
727	.dz
728	.com.dz
729	.earth
730	.eat
731	.ec
732	.com.ec
733	.fin.ec
734	.info.ec
735	.med.ec
736	.net.ec
737	.org.ec
738	.pro.ec
739	.eco
740	.edeka
741	.edu
742	.education
743	.ee
744	.co.ee
745	.com.ee
746	.pri.ee
747	.eg
748	.com.eg
749	.edu.eg
750	.info.eg
751	.name.eg
752	.net.eg
753	.sci.eg
754	.tv.eg
755	.eh
756	.email
757	.emerck
758	.energy
759	.engineer
760	.engineering
761	.enterprises
762	.epost
763	.epson
764	.equipment
765	.er
766	.ericsson
767	.erni
768	.es
769	.com.es
770	.edu.es
771	.gob.es
772	.nom.es
773	.org.es
774	.esq
775	.estate
776	.esurance
777	.et
778	.biz.et
779	.com.et
780	.info.et
781	.name.et
782	.net.et
783	.org.et
784	.etisalat
785	.eu
786	.eurovision
787	.eus
788	.events
789	.everbank
790	.exchange
791	.expert
792	.exposed
793	.express
794	.extraspace
795	.fage
796	.fail
797	.fairwinds
798	.faith
799	.family
800	.fan
801	.fans
802	.farm
803	.farmers
804	.fashion
805	.fast
806	.fedex
807	.feedback
808	.ferrari
809	.ferrero
810	.fi
811	.fiat
812	.fidelity
813	.fido
814	.film
815	.final
816	.finance
817	.financial
818	.fire
819	.firestone
820	.firmdale
821	.fish
822	.fishing
823	.fit
824	.fitness
825	.fj
826	.biz.fj
827	.com.fj
828	.info.fj
829	.name.fj
830	.net.fj
831	.org.fj
832	.pro.fj
833	.fk
834	.co.fk
835	.flickr
836	.flights
837	.flir
838	.florist
839	.flowers
840	.flsmidth
841	.fly
842	.fm
843	.radio.fm
844	.fo
845	.foo
846	.food
847	.foodnetwork
848	.football
849	.ford
850	.forex
851	.forsale
852	.forum
853	.foundation
854	.fox
855	.fr
856	.aeroport.fr
857	.asso.fr
858	.avocat.fr
859	.chambagri.fr
860	.chirurgiens-dentistes.fr
861	.com.fr
862	.experts-comptables.fr
863	.geometre-expert.fr
864	.gouv.fr
865	.medecin.fr
866	.nom.fr
867	.notaires.fr
868	.pharmacien.fr
869	.port.fr
870	.prd.fr
871	.presse.fr
872	.tm.fr
873	.veterinaire.fr
874	.free
875	.fresenius
876	.frl
877	.frogans
878	.frontdoor
879	.frontier
880	.ftr
881	.fujitsu
882	.fujixerox
883	.fun
884	.fund
885	.furniture
886	.futbol
887	.fyi
888	.ga
889	.gal
890	.gallery
891	.gallo
892	.gallup
893	.game
894	.games
895	.gap
896	.garden
897	.gay
898	.gb
899	.gbiz
900	.gd
901	.gdn
902	.ge
903	.com.ge
904	.edu.ge
905	.gov.ge
906	.mil.ge
907	.net.ge
908	.org.ge
909	.pvt.ge
910	.gea
911	.gent
912	.genting
913	.george
914	.gf
915	.gg
916	.co.gg
917	.net.gg
918	.org.gg
919	.ggee
920	.gh
921	.com.gh
922	.edu.gh
923	.org.gh
924	.gi
925	.com.gi
926	.edu.gi
927	.gov.gi
928	.ltd.gi
929	.org.gi
930	.gift
931	.gifts
932	.gives
933	.giving
934	.gl
935	.co.gl
936	.com.gl
1655	.kw
937	.edu.gl
938	.net.gl
939	.org.gl
940	.glade
941	.glass
942	.gle
943	.global
944	.globo
945	.gm
946	.gmail
947	.gmbh
948	.gmo
949	.gmx
950	.gn
951	.ac.gn
952	.com.gn
953	.gov.gn
954	.net.gn
955	.org.gn
956	.godaddy
957	.gold
958	.goldpoint
959	.golf
960	.goo
961	.goodhands
962	.goodyear
963	.goog
964	.google
965	.gop
966	.got
967	.gov
968	.gp
969	.com.gp
970	.mobi.gp
971	.net.gp
972	.org.gp
973	.gq
974	.gr
975	.com.gr
976	.edu.gr
977	.net.gr
978	.org.gr
979	.grainger
980	.graphics
981	.gratis
982	.green
983	.gripe
984	.grocery
985	.group
986	.gs
987	.gt
988	.com.gt
989	.net.gt
990	.org.gt
991	.gu
992	.com.gu
993	.guardian
994	.gucci
995	.guge
996	.guide
997	.guitars
998	.guru
999	.gw
1000	.gy
1001	.co.gy
1002	.com.gy
1003	.net.gy
1004	.hair
1005	.hamburg
1006	.hangout
1007	.haus
1008	.hbo
1009	.hdfc
1010	.hdfcbank
1011	.health
1012	.healthcare
1013	.help
1014	.helsinki
1015	.here
1016	.hermes
1017	.hgtv
1018	.hiphop
1019	.hisamitsu
1020	.hitachi
1021	.hiv
1022	.hk
1023	.com.hk
1024	.edu.hk
1025	.gov.hk
1026	.idv.hk
1027	.inc.hk
1028	.ltd.hk
1029	.net.hk
1030	.org.hk
1031	.公司.hk
1032	.hkt
1033	.hm
1034	.hn
1035	.com.hn
1036	.edu.hn
1037	.net.hn
1038	.org.hn
1039	.hockey
1040	.holdings
1041	.holiday
1042	.homedepot
1043	.homegoods
1044	.homes
1045	.homesense
1046	.honda
1047	.honeywell
1048	.horse
1049	.hospital
1050	.host
1051	.hosting
1052	.hot
1053	.hoteles
1054	.hotels
1055	.hotmail
1056	.house
1057	.how
1058	.hr
1059	.com.hr
1060	.hsbc
1061	.ht
1062	.adult.ht
1063	.art.ht
1064	.asso.ht
1065	.com.ht
1066	.edu.ht
1067	.firm.ht
1068	.info.ht
1069	.net.ht
1070	.org.ht
1071	.perso.ht
1072	.pol.ht
1073	.pro.ht
1074	.rel.ht
1075	.shop.ht
1076	.htc
1077	.hu
1078	.2000.hu
1079	.agrar.hu
1080	.bolt.hu
1081	.casino.hu
1082	.city.hu
1083	.co.hu
1084	.erotica.hu
1085	.erotika.hu
1086	.film.hu
1087	.forum.hu
1088	.games.hu
1089	.hotel.hu
1090	.info.hu
1091	.ingatlan.hu
1092	.jogasz.hu
1093	.konyvelo.hu
1094	.lakas.hu
1095	.media.hu
1096	.news.hu
1097	.org.hu
1098	.priv.hu
1099	.reklam.hu
1100	.sex.hu
1101	.shop.hu
1102	.sport.hu
1103	.suli.hu
1104	.szex.hu
1105	.tm.hu
1106	.tozsde.hu
1107	.utazas.hu
1108	.video.hu
1109	.hughes
1110	.hyatt
1111	.hyundai
1112	.ibm
1113	.icbc
1114	.ice
1115	.icu
1116	.id
1117	.ac.id
1118	.biz.id
1119	.co.id
1120	.my.id
1121	.or.id
1122	.sch.id
1123	.web.id
1124	.ie
1125	.ieee
1126	.ifm
1127	.iinet
1128	.ikano
1129	.il
1130	.ac.il
1131	.co.il
1132	.net.il
1133	.org.il
1134	.im
1135	.ac.im
1136	.co.im
1137	.com.im
1138	.ltd.co.im
1139	.net.im
1140	.org.im
1141	.plc.co.im
1142	.imamat
1143	.imdb
1144	.immo
1145	.immobilien
1146	.in
1147	.co.in
1148	.firm.in
1149	.gen.in
1150	.ind.in
1151	.net.in
1152	.org.in
1153	.inc
1154	.industries
1155	.infiniti
1156	.info
1157	.auz.info
1158	.ing
1159	.ink
1160	.institute
1161	.insurance
1162	.insure
1163	.int
1164	.intel
1165	.international
1166	.intuit
1167	.investments
1168	.io
1169	.ipiranga
1170	.iq
1171	.com.iq
1172	.edu.iq
1173	.ir
1174	.co.ir
1175	.irish
1176	.is
1177	.iselect
1178	.ismaili
1179	.ist
1180	.istanbul
1181	.it
1182	.abr.it
1183	.abruzzo.it
1184	.ag.it
1185	.agrigento.it
1186	.al.it
1187	.alessandria.it
1188	.alto-adige.it
1189	.altoadige.it
1190	.an.it
1191	.ancona.it
1192	.andria-barletta-trani.it
1193	.andria-trani-barletta.it
1194	.andriabarlettatrani.it
1195	.andriatranibarletta.it
1196	.ao.it
1197	.aosta.it
1198	.aoste.it
1199	.ap.it
1200	.aq.it
1201	.aquila.it
1202	.ar.it
1203	.arezzo.it
1204	.ascoli-piceno.it
1205	.ascolipiceno.it
1206	.asti.it
1207	.at.it
1208	.av.it
1209	.avellino.it
1210	.ba.it
1211	.balsan.it
1212	.bari.it
1213	.barletta-trani-andria.it
1214	.barlettatraniandria.it
1215	.bas.it
1216	.basilicata.it
1217	.belluno.it
1218	.benevento.it
1219	.bergamo.it
1220	.bg.it
1221	.bi.it
1222	.biella.it
1223	.bl.it
1224	.bn.it
1225	.bo.it
1226	.bologna.it
1227	.bolzano.it
1228	.bozen.it
1229	.br.it
1230	.brescia.it
1231	.brindisi.it
1232	.bs.it
1233	.bt.it
1234	.bz.it
1235	.ca.it
1236	.cagliari.it
1237	.cal.it
1238	.calabria.it
1239	.caltanissetta.it
1240	.cam.it
1241	.campania.it
1242	.campidano-medio.it
1243	.campidanomedio.it
1244	.campobasso.it
1245	.carbonia-iglesias.it
1246	.carboniaiglesias.it
1247	.carrara-massa.it
1248	.carraramassa.it
1249	.caserta.it
1250	.catania.it
1251	.catanzaro.it
1252	.cb.it
1253	.ce.it
1254	.cesena-forli.it
1255	.cesenaforli.it
1256	.ch.it
1257	.chieti.it
1258	.ci.it
1259	.cl.it
1260	.cn.it
1261	.co.it
1262	.como.it
1263	.cosenza.it
1264	.cr.it
1265	.cremona.it
1266	.crotone.it
1267	.cs.it
1268	.ct.it
1269	.cuneo.it
1270	.cz.it
1271	.dell-ogliastra.it
1272	.dellogliastra.it
1273	.emilia-romagna.it
1274	.emiliaromagna.it
1275	.emr.it
1276	.en.it
1277	.enna.it
1278	.fc.it
1279	.fe.it
1280	.fermo.it
1281	.ferrara.it
1282	.fg.it
1283	.fi.it
1284	.firenze.it
1285	.florence.it
1286	.fm.it
1287	.foggia.it
1288	.forli-cesena.it
1289	.forlicesena.it
1290	.fr.it
1291	.friuli-v-giulia.it
1292	.friuli-ve-giulia.it
1293	.friuli-vegiulia.it
1294	.friuli-venezia-giulia.it
1295	.friuli-veneziagiulia.it
1296	.friuli-vgiulia.it
1297	.friuliv-giulia.it
1298	.friulive-giulia.it
1299	.friulivegiulia.it
1300	.friulivenezia-giulia.it
1301	.friuliveneziagiulia.it
1302	.friulivgiulia.it
1303	.frosinone.it
1304	.fvg.it
1305	.ge.it
1306	.genoa.it
1307	.genova.it
1308	.go.it
1309	.gorizia.it
1310	.gr.it
1311	.grosseto.it
1312	.iglesias-carbonia.it
1313	.iglesiascarbonia.it
1314	.im.it
1315	.imperia.it
1316	.is.it
1317	.isernia.it
1318	.kr.it
1319	.la-spezia.it
1320	.laquila.it
1321	.laspezia.it
1322	.latina.it
1323	.laz.it
1324	.lazio.it
1325	.lc.it
1326	.le.it
1327	.lecce.it
1328	.lecco.it
1329	.li.it
1330	.lig.it
1331	.liguria.it
1332	.livorno.it
1333	.lo.it
1334	.lodi.it
1335	.lom.it
1336	.lombardia.it
1337	.lombardy.it
1338	.lt.it
1339	.lu.it
1340	.lucania.it
1341	.lucca.it
1342	.macerata.it
1343	.mantova.it
1344	.mar.it
1345	.marche.it
1346	.massa-carrara.it
1347	.massacarrara.it
1348	.matera.it
1349	.mb.it
1350	.mc.it
1351	.me.it
1352	.medio-campidano.it
1353	.mediocampidano.it
1354	.messina.it
1355	.mi.it
1356	.milan.it
1357	.milano.it
1358	.mn.it
1359	.mo.it
1360	.modena.it
1361	.mol.it
1362	.molise.it
1363	.monza-brianza.it
1364	.monza-e-della-brianza.it
1365	.monza.it
1366	.monzabrianza.it
1367	.monzaebrianza.it
1368	.monzaedellabrianza.it
1369	.ms.it
1370	.mt.it
1371	.na.it
1372	.naples.it
1373	.napoli.it
1374	.no.it
1375	.novara.it
1376	.nu.it
1377	.nuoro.it
1378	.og.it
1379	.ogliastra.it
1380	.olbia-tempio.it
1381	.olbiatempio.it
1382	.or.it
1383	.oristano.it
1384	.ot.it
1385	.pa.it
1386	.padova.it
1387	.padua.it
1388	.palermo.it
1389	.parma.it
1390	.pavia.it
1391	.pc.it
1392	.pd.it
1393	.pe.it
1394	.perugia.it
1395	.pesaro-urbino.it
1396	.pesarourbino.it
1397	.pescara.it
1398	.pg.it
1399	.pi.it
1400	.piacenza.it
1401	.piedmont.it
1402	.piemonte.it
1403	.pisa.it
1404	.pistoia.it
1405	.pmn.it
1406	.pn.it
1407	.po.it
1408	.pordenone.it
1409	.potenza.it
1410	.pr.it
1411	.prato.it
1412	.pt.it
1413	.pu.it
1414	.pug.it
1415	.puglia.it
1416	.pv.it
1417	.pz.it
1418	.ra.it
1419	.ragusa.it
1420	.ravenna.it
1421	.rc.it
1422	.re.it
1423	.reggio-calabria.it
1424	.reggio-emilia.it
1425	.reggiocalabria.it
1426	.reggioemilia.it
1427	.rg.it
1428	.ri.it
1429	.rieti.it
1430	.rimini.it
1431	.rm.it
1432	.rn.it
1433	.ro.it
1434	.roma.it
1435	.rome.it
1436	.rovigo.it
1437	.sa.it
1438	.salerno.it
1439	.sar.it
1440	.sardegna.it
1441	.sardinia.it
1442	.sassari.it
1443	.savona.it
1444	.si.it
1445	.sic.it
1446	.sicilia.it
1447	.sicily.it
1448	.siena.it
1449	.siracusa.it
1450	.so.it
1451	.sondrio.it
1452	.sp.it
1453	.sr.it
1454	.ss.it
1455	.suedtirol.it
1456	.sv.it
1457	.ta.it
1458	.taa.it
1459	.taranto.it
1460	.te.it
1461	.tempio-olbia.it
1462	.tempioolbia.it
1463	.teramo.it
1464	.terni.it
1465	.tn.it
1466	.to.it
1467	.torino.it
1468	.tos.it
1469	.toscana.it
1470	.tp.it
1471	.tr.it
1472	.trani-andria-barletta.it
1473	.trani-barletta-andria.it
1474	.traniandriabarletta.it
1475	.tranibarlettaandria.it
1476	.trapani.it
1477	.trentino-a-adige.it
1478	.trentino-aadige.it
1479	.trentino-alto-adige.it
1480	.trentino-altoadige.it
1481	.trentino-s-tirol.it
1482	.trentino-stirol.it
1483	.trentino-sud-tirol.it
1484	.trentino-sudtirol.it
1485	.trentino-sued-tirol.it
1486	.trentino-suedtirol.it
1487	.trentino.it
1488	.trentinoa-adige.it
1489	.trentinoaadige.it
1490	.trentinoalto-adige.it
1491	.trentinoaltoadige.it
1492	.trentinos-tirol.it
1493	.trentinosud-tirol.it
1494	.trentinosudtirol.it
1495	.trentinosued-tirol.it
1496	.trentinosuedtirol.it
1497	.trento.it
1498	.treviso.it
1499	.trieste.it
1500	.ts.it
1501	.turin.it
1502	.tuscany.it
1503	.tv.it
1504	.ud.it
1505	.udine.it
1506	.umb.it
1507	.umbria.it
1508	.urbino-pesaro.it
1509	.urbinopesaro.it
1510	.va.it
1511	.val-d-aosta.it
1512	.val-daosta.it
1513	.vald-aosta.it
1514	.valdaosta.it
1515	.valle-d-aosta.it
1516	.valle-daosta.it
1517	.valled-aosta.it
1518	.valledaosta.it
1519	.vao.it
1520	.varese.it
1521	.vb.it
1522	.vc.it
1523	.vda.it
1524	.ve.it
1525	.ven.it
1526	.veneto.it
1527	.venezia.it
1528	.venice.it
1529	.verbania.it
1530	.vercelli.it
1531	.verona.it
1532	.vi.it
1533	.vibo-valentia.it
1534	.vibovalentia.it
1535	.vicenza.it
1536	.viterbo.it
1537	.vr.it
1538	.vs.it
1539	.vt.it
1540	.vv.it
1541	.itau
1542	.itv
1543	.iveco
1544	.iwc
1545	.jaguar
1546	.java
1547	.jcb
1548	.jcp
1549	.je
1550	.co.je
1551	.net.je
1552	.org.je
1553	.jeep
1554	.jetzt
1555	.jewelry
1556	.jio
1557	.jlc
1558	.jll
1559	.jm
1560	.com.jm
1561	.jmp
1562	.jnj
1563	.jo
1564	.com.jo
1565	.edu.jo
1566	.gov.jo
1567	.name.jo
1568	.net.jo
1569	.org.jo
1570	.sch.jo
1571	.jobs
1572	.joburg
1573	.jot
1574	.joy
1575	.jp
1576	.akita.jp
1577	.co.jp
1578	.gr.jp
1579	.kyoto.jp
1580	.ne.jp
1581	.or.jp
1582	.osaka.jp
1583	.saga.jp
1584	.tokyo.jp
1585	.jpmorgan
1586	.jprs
1587	.juegos
1588	.juniper
1589	.kaufen
1590	.kddi
1591	.ke
1592	.ac.ke
1593	.co.ke
1594	.go.ke
1595	.info.ke
1596	.me.ke
1597	.mobi.ke
1598	.ne.ke
1599	.or.ke
1600	.sc.ke
1601	.kerryhotels
1602	.kerrylogistics
1603	.kerryproperties
1604	.kfh
1605	.kg
1606	.com.kg
1607	.net.kg
1608	.org.kg
1609	.kh
1610	.com.kh
1611	.edu.kh
1612	.net.kh
1613	.org.kh
1614	.ki
1615	.biz.ki
1616	.com.ki
1617	.edu.ki
1618	.gov.ki
1619	.info.ki
1620	.mobi.ki
1621	.net.ki
1622	.org.ki
1623	.phone.ki
1624	.tel.ki
1625	.kia
1626	.kim
1627	.kinder
1628	.kindle
1629	.kitchen
1630	.kiwi
1631	.km
1632	.kn
1633	.com.kn
1634	.edu.kn
1635	.gov.kn
1636	.koeln
1637	.komatsu
1638	.kosher
1639	.kp
1640	.kpmg
1641	.kpn
1642	.kr
1643	.ac.kr
1644	.co.kr
1645	.go.kr
1646	.ms.kr
1647	.ne.kr
1648	.or.kr
1649	.pe.kr
1650	.re.kr
1651	.seoul.kr
1652	.krd
1653	.kred
1654	.kuokgroup
1656	.com.kw
1657	.edu.kw
1658	.gov.kw
1659	.net.kw
1660	.org.kw
1661	.ky
1662	.com.ky
1663	.net.ky
1664	.org.ky
1665	.kyoto
1666	.kz
1667	.com.kz
1668	.org.kz
1669	.la
1670	.lacaixa
1671	.ladbrokes
1672	.lamborghini
1673	.lamer
1674	.lancaster
1675	.lancia
1676	.lancome
1677	.land
1678	.landrover
1679	.lanxess
1680	.lasalle
1681	.lat
1682	.latino
1683	.latrobe
1684	.law
1685	.lawyer
1686	.lb
1687	.com.lb
1688	.edu.lb
1689	.gov.lb
1690	.net.lb
1691	.org.lb
1692	.lc
1693	.co.lc
1694	.com.lc
1695	.l.lc
1696	.net.lc
1697	.org.lc
1698	.p.lc
1699	.lds
1700	.lease
1701	.leclerc
1702	.lefrak
1703	.legal
1704	.lego
1705	.lexus
1706	.lgbt
1707	.li
1708	.liaison
1709	.lidl
1710	.life
1711	.lifeinsurance
1712	.lifestyle
1713	.lighting
1714	.like
1715	.lilly
1716	.limited
1717	.limo
1718	.lincoln
1719	.linde
1720	.link
1721	.lipsy
1722	.live
1723	.living
1724	.lixil
1725	.lk
1726	.com.lk
1727	.edu.lk
1728	.org.lk
1729	.llc
1730	.llp
1731	.loan
1732	.loans
1733	.locker
1734	.locus
1735	.loft
1736	.lol
1737	.london
1738	.lotte
1739	.lotto
1740	.love
1741	.lpl
1742	.lplfinancial
1743	.lr
1744	.com.lr
1745	.ls
1746	.co.ls
1747	.org.ls
1748	.lt
1749	.ltd
1750	.ltda
1751	.lu
1752	.lundbeck
1753	.lupin
1754	.luxe
1755	.luxury
1756	.lv
1757	.asn.lv
1758	.com.lv
1759	.conf.lv
1760	.edu.lv
1761	.id.lv
1762	.mil.lv
1763	.net.lv
1764	.org.lv
1765	.ly
1766	.com.ly
1767	.id.ly
1768	.med.ly
1769	.net.ly
1770	.org.ly
1771	.plc.ly
1772	.sch.ly
1773	.ma
1774	.ac.ma
1775	.co.ma
1776	.gov.ma
1777	.net.ma
1778	.org.ma
1779	.press.ma
1780	.macys
1781	.madrid
1782	.maif
1783	.maison
1784	.makeup
1785	.man
1786	.management
1787	.mango
1788	.map
1789	.market
1790	.marketing
1791	.markets
1792	.marriott
1793	.marshalls
1794	.maserati
1795	.mattel
1796	.mba
1797	.mc
1798	.asso.mc
1799	.tm.mc
1800	.mcd
1801	.mcdonalds
1802	.mckinsey
1803	.md
1804	.med
1805	.media
1806	.meet
1807	.melbourne
1808	.meme
1809	.memorial
1810	.men
1811	.menu
1812	.meo
1813	.merckmsd
1814	.metlife
1815	.mf
1816	.mg
1817	.co.mg
1818	.com.mg
1819	.edu.mg
1820	.gov.mg
1821	.mil.mg
1822	.net.mg
1823	.nom.mg
1824	.org.mg
1825	.prd.mg
1826	.tm.mg
1827	.mh
1828	.miami
1829	.microsoft
1830	.mil
1831	.mini
1832	.mint
1833	.mit
1834	.mitsubishi
1835	.mk
1836	.com.mk
1837	.edu.mk
1838	.inf.mk
1839	.name.mk
1840	.net.mk
1841	.org.mk
1842	.ml
1843	.mlb
2764	.sv
1844	.mls
1845	.biz.mm
1846	.com.mm
1847	.net.mm
1848	.org.mm
1849	.per.mm
1850	.mma
1851	.mn
1852	.mo
1853	.com.mo
1854	.edu.mo
1855	.gov.mo
1856	.net.mo
1857	.org.mo
1858	.mobi
1859	.mobile
1860	.mobily
1861	.moda
1862	.moe
1863	.moi
1864	.mom
1865	.monash
1866	.money
1867	.monster
1868	.montblanc
1869	.mopar
1870	.mormon
1871	.mortgage
1872	.moscow
1873	.moto
1874	.motorcycles
1875	.mov
1876	.movie
1877	.movistar
1878	.mp
1879	.mq
1880	.mr
1881	.ms
1882	.co.ms
1883	.com.ms
1884	.org.ms
1885	.msd
1886	.mt
1887	.com.mt
1888	.edu.mt
1889	.net.mt
1890	.org.mt
1891	.mtn
1892	.mtpc
1893	.mtr
1894	.mu
1895	.ac.mu
1896	.co.mu
1897	.com.mu
1898	.net.mu
1899	.nom.mu
1900	.or.mu
1901	.org.mu
1902	.museum
1903	.mutual
1904	.mutuelle
1905	.mv
1906	.com.mv
1907	.mw
1908	.ac.mw
1909	.co.mw
1910	.com.mw
1911	.coop.mw
1912	.edu.mw
1913	.gov.mw
1914	.int.mw
1915	.net.mw
1916	.org.mw
1917	.mx
1918	.com.mx
1919	.edu.mx
1920	.gob.mx
1921	.net.mx
1922	.org.mx
1923	.my
1924	.com.my
1925	.edu.my
1926	.gov.my
1927	.mil.my
1928	.name.my
1929	.net.my
1930	.org.my
1931	.mz
1932	.ac.mz
1933	.co.mz
1934	.edu.mz
1935	.net.mz
1936	.org.mz
1937	.na
1938	.alt.na
1939	.co.na
1940	.com.na
1941	.edu.na
1942	.net.na
1943	.org.na
1944	.nab
1945	.nadex
1946	.nagoya
1947	.name
1948	.nationwide
1949	.natura
1950	.navy
1951	.nba
1952	.nc
1953	.asso.nc
1954	.nom.nc
1955	.ne
1956	.com.ne
1957	.info.ne
1958	.int.ne
1959	.org.ne
1960	.perso.ne
1961	.nec
1962	.net
1963	.auz.net
1964	.gb.net
1965	.hu.net
1966	.in.net
1967	.jp.net
1968	.ru.net
1969	.se.net
1970	.uk.net
1971	.netbank
1972	.netflix
1973	.network
1974	.neustar
1975	.new
1976	.newholland
1977	.news
1978	.next
1979	.nextdirect
1980	.nexus
1981	.nf
1982	.arts.nf
1983	.com.nf
1984	.firm.nf
1985	.info.nf
1986	.net.nf
1987	.org.nf
1988	.other.nf
1989	.per.nf
1990	.rec.nf
1991	.store.nf
1992	.web.nf
1993	.nfl
1994	.ng
1995	.com.ng
1996	.edu.ng
1997	.gov.ng
1998	.i.ng
1999	.lg.gov.ng
2000	.mobi.ng
2001	.name.ng
2002	.net.ng
2003	.org.ng
2004	.sch.ng
2005	.ngo
2006	.nhk
2007	.ni
2008	.ac.ni
2009	.biz.ni
2010	.co.ni
2011	.com.ni
2012	.edu.ni
2013	.gob.ni
2014	.in.ni
2015	.info.ni
2016	.int.ni
2017	.mil.ni
2018	.net.ni
2019	.nom.ni
2020	.org.ni
2021	.web.ni
2022	.nico
2023	.nike
2024	.nikon
2025	.ninja
2026	.nissan
2027	.nissay
2028	.nl
2029	.co.nl
2030	.com.nl
2031	.net.nl
2032	.no
2033	.co.no
2034	.fhs.no
2035	.folkebibl.no
2036	.fylkesbibl.no
2037	.gs.no
2038	.idrett.no
2039	.museum.no
2040	.priv.no
2041	.uenorge.no
2042	.vgs.no
2043	.nokia
2044	.northwesternmutual
2045	.norton
2046	.now
2047	.nowruz
2048	.nowtv
2049	.np
2050	.aero.np
2051	.asia.np
2052	.biz.np
2053	.com.np
2054	.coop.np
2055	.edu.np
2056	.gov.np
2057	.info.np
2058	.mil.np
2059	.mobi.np
2060	.museum.np
2061	.name.np
2062	.net.np
2063	.org.np
2064	.pro.np
2065	.travel.np
2066	.nr
2067	.com.nr
2068	.gov.nr
2069	.nra
2070	.nrw
2071	.ntt
2072	.nu
2073	.co.nu
2074	.nyc
2075	.nz
2076	.ac.nz
2077	.co.net.nz
2078	.co.nz
2079	.geek.nz
2080	.gen.nz
2081	.iwi.nz
2082	.kiwi.nz
2083	.maori.nz
2084	.net.nz
2085	.org.nz
2086	.school.nz
2087	.obi
2088	.observer
2089	.off
2090	.office
2091	.okinawa
2092	.olayan
2093	.olayangroup
2094	.oldnavy
2095	.ollo
2096	.om
2097	.ac.om
2098	.biz.om
2099	.co.om
2100	.com.om
2101	.edu.om
2102	.gov.om
2103	.med.om
2104	.mil.om
2105	.museum.om
2106	.net.om
2107	.org.om
2108	.pro.om
2109	.sch.om
2110	.omega
2111	.one
2112	.ong
2113	.onl
2114	.online
2115	.onyourside
2116	.ooo
2117	.open
2118	.oracle
2119	.orange
2120	.org
2121	.ae.org
2122	.hk.org
2123	.us.org
2124	.organic
2125	.orientexpress
2126	.origins
2127	.osaka
2128	.otsuka
2129	.ott
2130	.ovh
2131	.pa
2132	.abo.pa
2133	.ac.pa
2134	.com.pa
2135	.edu.pa
2136	.gob.pa
2137	.ing.pa
2138	.med.pa
2139	.net.pa
2140	.nom.pa
2141	.org.pa
2142	.sld.pa
2143	.page
2144	.pamperedchef
2145	.panasonic
2146	.panerai
2147	.paris
2148	.pars
2149	.partners
2150	.parts
2151	.party
2152	.passagens
2153	.pay
2154	.pccw
2155	.pe
2156	.com.pe
2157	.gob.pe
2158	.mil.pe
2159	.net.pe
2160	.nom.pe
2161	.org.pe
2162	.pet
2163	.pf
2164	.asso.pf
2165	.com.pf
2166	.edu.pf
2167	.gov.pf
2168	.org.pf
2169	.pfizer
2170	.pg
2171	.ph
2172	.com.ph
2173	.net.ph
2174	.org.ph
2175	.pharmacy
2176	.phd
2177	.philips
2178	.phone
2179	.photo
2180	.photography
2181	.photos
2182	.physio
2183	.piaget
2184	.pics
2185	.pictet
2186	.pictures
2187	.pid
2188	.pin
2189	.ping
2190	.pink
2191	.pioneer
2192	.pizza
2193	.pk
2194	.biz.pk
2195	.com.pk
2196	.net.pk
2197	.org.pk
2198	.web.pk
2199	.pl
2200	.agro.pl
2201	.aid.pl
2202	.atm.pl
2203	.augustow.pl
2204	.auto.pl
2205	.babia-gora.pl
2206	.bedzin.pl
2207	.beskidy.pl
2208	.bialowieza.pl
2209	.bialystok.pl
2210	.bielawa.pl
2211	.bieszczady.pl
2212	.biz.pl
2213	.boleslawiec.pl
2214	.bydgoszcz.pl
2215	.bytom.pl
2216	.cieszyn.pl
2217	.com.pl
2218	.czeladz.pl
2219	.czest.pl
2220	.dlugoleka.pl
2221	.edu.pl
2222	.elblag.pl
2223	.elk.pl
2224	.glogow.pl
2225	.gmina.pl
2226	.gniezno.pl
2227	.gorlice.pl
2228	.grajewo.pl
2229	.gsm.pl
2230	.ilawa.pl
2231	.info.pl
2232	.jaworzno.pl
2233	.jelenia-gora.pl
2234	.jgora.pl
2235	.kalisz.pl
2236	.karpacz.pl
2237	.kartuzy.pl
2238	.kaszuby.pl
2239	.katowice.pl
2240	.kazimierz-dolny.pl
2241	.kepno.pl
2242	.ketrzyn.pl
2243	.klodzko.pl
2244	.kobierzyce.pl
2245	.kolobrzeg.pl
2246	.konin.pl
2247	.konskowola.pl
2248	.kutno.pl
2249	.lapy.pl
2250	.lebork.pl
2251	.legnica.pl
2252	.lezajsk.pl
2253	.limanowa.pl
2254	.lomza.pl
2255	.lowicz.pl
2256	.lubin.pl
2257	.lukow.pl
2258	.mail.pl
2259	.malbork.pl
2260	.malopolska.pl
2261	.mazowsze.pl
2262	.mazury.pl
2263	.media.pl
2264	.miasta.pl
2265	.mielec.pl
2266	.mielno.pl
2267	.mil.pl
2268	.mragowo.pl
2269	.naklo.pl
2270	.net.pl
2271	.nieruchomosci.pl
2272	.nom.pl
2273	.nowaruda.pl
2274	.nysa.pl
2275	.olawa.pl
2276	.olecko.pl
2277	.olkusz.pl
2278	.olsztyn.pl
2279	.opoczno.pl
2280	.opole.pl
2281	.org.pl
2282	.ostroda.pl
2283	.ostroleka.pl
2284	.ostrowiec.pl
2285	.ostrowwlkp.pl
2286	.pc.pl
2287	.pila.pl
2288	.pisz.pl
2289	.podhale.pl
2290	.podlasie.pl
2291	.polkowice.pl
2292	.pomorskie.pl
2293	.pomorze.pl
2294	.powiat.pl
2295	.priv.pl
2296	.prochowice.pl
2297	.pruszkow.pl
2298	.przeworsk.pl
2299	.pulawy.pl
2300	.radom.pl
2301	.rawa-maz.pl
2302	.realestate.pl
2303	.rel.pl
2304	.rybnik.pl
2305	.rzeszow.pl
2306	.sanok.pl
2307	.sejny.pl
2308	.sex.pl
2309	.shop.pl
2310	.sklep.pl
2311	.skoczow.pl
2312	.slask.pl
2313	.slupsk.pl
2314	.sos.pl
2315	.sosnowiec.pl
2316	.stalowa-wola.pl
2317	.starachowice.pl
2318	.stargard.pl
2319	.suwalki.pl
2320	.swidnica.pl
2321	.swiebodzin.pl
2322	.swinoujscie.pl
2323	.szczecin.pl
2324	.szczytno.pl
2325	.szkola.pl
2326	.targi.pl
2327	.tarnobrzeg.pl
2328	.tgory.pl
2329	.tm.pl
2330	.tourism.pl
2331	.travel.pl
2332	.turek.pl
2333	.turystyka.pl
2334	.tychy.pl
2335	.ustka.pl
2336	.walbrzych.pl
2337	.warmia.pl
2338	.warszawa.pl
2339	.waw.pl
2340	.wegrow.pl
2341	.wielun.pl
2342	.wlocl.pl
2343	.wloclawek.pl
2344	.wodzislaw.pl
2345	.wolomin.pl
2346	.wroclaw.pl
2347	.zachpomor.pl
2348	.zagan.pl
2349	.zarow.pl
2350	.zgora.pl
2351	.zgorzelec.pl
2352	.place
2353	.play
2354	.playstation
2355	.plumbing
2356	.plus
2357	.pm
2358	.pn
2359	.co.pn
2360	.net.pn
2361	.org.pn
2362	.pnc
2363	.pohl
2364	.poker
2365	.politie
2366	.porn
2367	.post
2368	.pr
2369	.biz.pr
2370	.com.pr
2371	.info.pr
2372	.isla.pr
2373	.name.pr
2374	.net.pr
2375	.org.pr
2376	.pro.pr
2377	.pramerica
2378	.praxi
2379	.press
2380	.prime
2381	.pro
2382	.aaa.pro
2383	.aca.pro
2384	.acct.pro
2385	.arc.pro
2386	.avocat.pro
2387	.bar.pro
2388	.bus.pro
2389	.chi.pro
2390	.chiro.pro
2391	.cpa.pro
2392	.den.pro
2393	.dent.pro
2394	.eng.pro
2395	.jur.pro
2396	.law.pro
2397	.med.pro
2398	.min.pro
2399	.nur.pro
2400	.nurse.pro
2401	.pharma.pro
2402	.prof.pro
2403	.prx.pro
2404	.recht.pro
2405	.rel.pro
2406	.teach.pro
2407	.vet.pro
2408	.prod
2409	.productions
2410	.prof
2411	.progressive
2412	.promo
2413	.properties
2414	.property
2415	.protection
2416	.pru
2417	.prudential
2418	.ps
2419	.com.ps
2420	.net.ps
2421	.org.ps
2422	.pt
2423	.co.pt
2424	.com.pt
2425	.edu.pt
2426	.org.pt
2427	.pub
2428	.pw
2429	.pwc
2430	.py
2431	.com.py
2432	.coop.py
2433	.edu.py
2434	.gov.py
2435	.mil.py
2436	.net.py
2437	.org.py
2438	.qa
2439	.com.qa
2440	.name.qa
2441	.net.qa
2442	.qpon
2443	.quebec
2444	.quest
2445	.qvc
2446	.racing
2447	.radio
2448	.raid
2449	.re
2450	.read
2451	.realestate
2452	.realtor
2453	.realty
2454	.recipes
2455	.red
2456	.redstone
2457	.redumbrella
2458	.rehab
2459	.reise
2460	.reisen
2461	.reit
2462	.reliance
2463	.ren
2464	.rent
2465	.rentals
2466	.repair
2467	.report
2468	.republican
2469	.rest
2470	.restaurant
2471	.review
2472	.reviews
2473	.rexroth
2474	.rich
2475	.richardli
2476	.ricoh
2477	.rightathome
2478	.ril
2479	.rio
2480	.rip
2481	.rmit
2482	.ro
2483	.arts.ro
2484	.co.ro
2485	.com.ro
2486	.firm.ro
2487	.info.ro
2488	.ne.ro
2489	.nom.ro
2490	.nt.ro
2491	.or.ro
2492	.org.ro
2493	.rec.ro
2494	.sa.ro
2495	.srl.ro
2496	.store.ro
2497	.tm.ro
2498	.www.ro
2499	.rocher
2500	.rocks
2501	.rodeo
2502	.rogers
2503	.room
2504	.ac.rs
2505	.co.rs
2506	.edu.rs
2507	.gov.rs
2508	.in.rs
2509	.org.rs
2510	.rsvp
2511	.ru
2512	.adygeya.ru
2513	.bashkiria.ru
2514	.bir.ru
2515	.cbg.ru
2516	.com.ru
2517	.dagestan.ru
2518	.grozny.ru
2519	.kalmykia.ru
2520	.kustanai.ru
2521	.marine.ru
2522	.mordovia.ru
2523	.msk.ru
2524	.mytis.ru
2525	.nalchik.ru
2526	.net.ru
2527	.nov.ru
2528	.org.ru
2529	.pp.ru
2530	.pyatigorsk.ru
2531	.spb.ru
2532	.vladikavkaz.ru
2533	.vladimir.ru
2534	.rugby
2535	.ruhr
2536	.run
2537	.rw
2538	.ac.rw
2539	.co.rw
2540	.net.rw
2541	.org.rw
2542	.rwe
2543	.ryukyu
2544	.sa
2545	.com.sa
2546	.med.sa
2547	.saarland
2548	.safe
2549	.safety
2550	.sakura
2551	.sale
2552	.salon
2553	.samsclub
2554	.samsung
2555	.sandvik
2556	.sandvikcoromant
2557	.sanofi
2558	.sap
2559	.sapo
2560	.sarl
2561	.sas
2562	.save
2563	.saxo
2564	.sb
2565	.com.sb
2566	.edu.sb
2567	.gov.sb
2568	.net.sb
2569	.org.sb
2570	.sbi
2571	.sbs
2572	.sc
2573	.com.sc
2574	.net.sc
2575	.org.sc
2576	.sca
2577	.scb
2578	.schaeffler
2579	.schmidt
2580	.scholarships
2581	.school
2582	.schule
2583	.schwarz
2584	.science
2585	.scjohnson
2586	.scor
2587	.scot
2588	.sd
2589	.com.sd
2590	.info.sd
2591	.net.sd
2592	.se
2593	.com.se
2594	.tm.se
2595	.search
2596	.seat
2597	.secure
2598	.security
2599	.seek
2600	.select
2601	.sener
2602	.services
2603	.ses
2604	.seven
2605	.sew
2606	.sex
2607	.sexy
2608	.sfr
2609	.sg
2610	.com.sg
2611	.edu.sg
2612	.net.sg
2613	.org.sg
2614	.per.sg
2615	.sh
2616	.shangrila
2617	.sharp
2618	.shaw
2619	.shell
2620	.shia
2621	.shiksha
2622	.shoes
2623	.shop
2624	.shopping
2625	.shouji
2626	.show
2627	.showtime
2628	.shriram
2629	.si
2630	.ae.si
2631	.at.si
2632	.cn.si
2633	.co.si
2634	.de.si
2635	.uk.si
2636	.us.si
2637	.silk
2638	.sina
2639	.singles
2640	.site
2641	.sj
2642	.ski
2643	.skin
2644	.sky
2645	.skype
2646	.sl
2647	.com.sl
2648	.edu.sl
2649	.gov.sl
2650	.net.sl
2651	.org.sl
2652	.sling
2653	.sm
2654	.smart
2655	.smile
2656	.sn
2657	.art.sn
2658	.com.sn
2659	.edu.sn
2660	.org.sn
2661	.perso.sn
2662	.univ.sn
2663	.sncf
2664	.so
2665	.com.so
2666	.net.so
2667	.org.so
2668	.soccer
2669	.social
2670	.softbank
2671	.software
2672	.sohu
2673	.solar
2674	.solutions
2675	.song
2676	.sony
2677	.soy
2678	.space
2679	.spiegel
2680	.sport
2681	.spot
2682	.spreadbetting
2683	.sr
2684	.srl
2685	.srt
2686	.ss
2687	.st
2688	.stada
2689	.staples
2690	.star
2691	.starhub
2692	.statebank
2693	.statefarm
2694	.statoil
2695	.stc
2696	.stcgroup
2697	.stockholm
2698	.storage
2699	.store
2700	.stream
2701	.studio
2702	.study
2703	.style
2704	.su
2705	.abkhazia.su
2706	.adygeya.su
2707	.aktyubinsk.su
2708	.arkhangelsk.su
2709	.armenia.su
2710	.ashgabad.su
2711	.azerbaijan.su
2712	.balashov.su
2713	.bashkiria.su
2714	.bryansk.su
2715	.bukhara.su
2716	.chimkent.su
2717	.dagestan.su
2718	.east-kazakhstan.su
2719	.exnet.su
2720	.georgia.su
2721	.grozny.su
2722	.ivanovo.su
2723	.jambyl.su
2724	.kalmykia.su
2725	.kaluga.su
2726	.karacol.su
2727	.karaganda.su
2728	.karelia.su
2729	.khakassia.su
2730	.krasnodar.su
2731	.kurgan.su
2732	.kustanai.su
2733	.lenug.su
2734	.mangyshlak.su
2735	.mordovia.su
2736	.msk.su
2737	.murmansk.su
2738	.nalchik.su
2739	.navoi.su
2740	.north-kazakhstan.su
2741	.nov.su
2742	.obninsk.su
2743	.penza.su
2744	.pokrovsk.su
2745	.sochi.su
2746	.spb.su
2747	.tashkent.su
2748	.termez.su
2749	.togliatti.su
2750	.troitsk.su
2751	.tselinograd.su
2752	.tula.su
2753	.tuva.su
2754	.vladikavkaz.su
2755	.vladimir.su
2756	.vologda.su
2757	.sucks
2758	.supplies
2759	.supply
2760	.support
2761	.surf
2762	.surgery
2763	.suzuki
2765	.com.sv
2766	.swatch
2767	.swiftcover
2768	.swiss
2769	.sx
2770	.sy
2771	.sydney
2772	.symantec
2773	.systems
2774	.sz
2775	.tab
2776	.taipei
2777	.talk
2778	.taobao
2779	.target
2780	.tatamotors
2781	.tatar
2782	.tattoo
2783	.tax
2784	.taxi
2785	.tc
2786	.com.tc
2787	.net.tc
2788	.org.tc
2789	.pro.tc
2790	.tci
2791	.td
2792	.com.td
2793	.net.td
2794	.org.td
2795	.tourism.td
2796	.tdk
2797	.team
2798	.tech
2799	.technology
2800	.tel
2801	.telecity
2802	.telefonica
2803	.temasek
2804	.tennis
2805	.teva
2806	.tf
2807	.tg
2808	.th
2809	.ac.th
2810	.co.th
2811	.in.th
2812	.or.th
2813	.thd
2814	.theater
2815	.theatre
2816	.tiaa
2817	.tickets
2818	.tienda
2819	.tiffany
2820	.tips
2821	.tires
2822	.tirol
2823	.tj
2824	.ac.tj
2825	.aero.tj
2826	.biz.tj
2827	.co.tj
2828	.com.tj
2829	.coop.tj
2830	.dyn.tj
2831	.edu.tj
2832	.go.tj
2833	.gov.tj
2834	.info.tj
2835	.int.tj
2836	.mil.tj
2837	.museum.tj
2838	.my.tj
2839	.name.tj
2840	.net.tj
2841	.org.tj
2842	.per.tj
2843	.pro.tj
2844	.web.tj
2845	.tjmaxx
2846	.tjx
2847	.tk
2848	.tkmaxx
2849	.tl
2850	.com.tl
2851	.net.tl
2852	.org.tl
2853	.tm
2854	.tmall
2855	.tn
2856	.agrinet.tn
2857	.com.tn
2858	.defense.tn
2859	.edunet.tn
2860	.ens.tn
2861	.fin.tn
2862	.gov.tn
2863	.ind.tn
2864	.info.tn
2865	.intl.tn
2866	.nat.tn
2867	.net.tn
2868	.org.tn
2869	.perso.tn
2870	.rnrt.tn
2871	.rns.tn
2872	.rnu.tn
2873	.tourism.tn
2874	.to
2875	.today
2876	.tokyo
2877	.tools
2878	.top
2879	.toray
2880	.toshiba
2881	.total
2882	.tours
2883	.town
2884	.toyota
2885	.toys
2886	.tp
2887	.tr
2888	.av.tr
2889	.bbs.tr
2890	.biz.tr
2891	.com.tr
2892	.dr.tr
2893	.edu.tr
2894	.gen.tr
2895	.info.tr
2896	.name.tr
2897	.net.tr
2898	.org.tr
2899	.tel.tr
2900	.tv.tr
2901	.web.tr
2902	.trade
2903	.trading
2904	.training
2905	.travel
2906	.travelchannel
2907	.travelers
2908	.travelersinsurance
2909	.trust
2910	.trv
2911	.tt
2912	.biz.tt
2913	.co.tt
2914	.com.tt
2915	.info.tt
2916	.name.tt
2917	.net.tt
2918	.org.tt
2919	.pro.tt
2920	.tube
2921	.tui
2922	.tunes
2923	.tushu
2924	.tv
2925	.tvs
2926	.tw
2927	.club.tw
2928	.com.tw
2929	.ebiz.tw
2930	.game.tw
2931	.idv.tw
2932	.org.tw
2933	.tz
2934	.ac.tz
2935	.co.tz
2936	.hotel.tz
2937	.info.tz
2938	.me.tz
2939	.mobi.tz
2940	.ne.tz
2941	.or.tz
2942	.sc.tz
2943	.tv.tz
2944	.ua
2945	.biz.ua
2946	.cherkassy.ua
2947	.cherkasy.ua
2948	.chernigov.ua
2949	.chernivtsi.ua
2950	.chernovtsy.ua
2951	.ck.ua
2952	.cn.ua
2953	.co.ua
2954	.com.ua
2955	.crimea.ua
2956	.cv.ua
2957	.dn.ua
2958	.dnepropetrovsk.ua
2959	.dnipropetrovsk.ua
2960	.donetsk.ua
2961	.dp.ua
2962	.edu.ua
2963	.gov.ua
2964	.if.ua
2965	.in.ua
2966	.ivano-frankivsk.ua
2967	.kh.ua
2968	.kharkiv.ua
2969	.kharkov.ua
2970	.kherson.ua
2971	.khmelnitskiy.ua
2972	.kiev.ua
2973	.kirovograd.ua
2974	.km.ua
2975	.kr.ua
2976	.ks.ua
2977	.kyiv.ua
2978	.lg.ua
2979	.lt.ua
2980	.lugansk.ua
2981	.lutsk.ua
2982	.lviv.ua
2983	.mk.ua
2984	.net.ua
2985	.nikolaev.ua
2986	.od.ua
2987	.odesa.ua
2988	.odessa.ua
2989	.org.ua
2990	.pl.ua
2991	.poltava.ua
2992	.pp.ua
2993	.rivne.ua
2994	.rovno.ua
2995	.rv.ua
2996	.sebastopol.ua
2997	.sm.ua
2998	.sumy.ua
2999	.te.ua
3000	.ternopil.ua
3001	.uz.ua
3002	.uzhgorod.ua
3003	.vinnica.ua
3004	.vn.ua
3005	.volyn.ua
3006	.yalta.ua
3007	.zaporizhzhe.ua
3008	.zhitomir.ua
3009	.zp.ua
3010	.zt.ua
3011	.ubank
3012	.ubs
3013	.uconnect
3014	.ug
3015	.ac.ug
3016	.co.ug
3017	.com.ug
3018	.go.ug
3019	.ne.ug
3020	.or.ug
3021	.org.ug
3022	.sc.ug
3023	.um
3024	.unicom
3025	.university
3026	.uno
3027	.uol
3028	.ups
3029	.us
3030	.uy
3031	.com.uy
3032	.net.uy
3033	.org.uy
3034	.uz
3035	.biz.uz
3036	.co.uz
3037	.com.uz
3038	.net.uz
3039	.org.uz
3040	.va
3041	.vacations
3042	.vana
3043	.vanguard
3044	.vc
3045	.com.vc
3046	.net.vc
3047	.org.vc
3048	.ve
3049	.co.ve
3050	.com.ve
3051	.info.ve
3052	.net.ve
3053	.org.ve
3054	.web.ve
3055	.vegas
3056	.ventures
3057	.verisign
3058	.vermögensberater
3059	.vermögensberatung
3060	.versicherung
3061	.vet
3062	.vg
3063	.vi
3064	.co.vi
3065	.com.vi
3066	.net.vi
3067	.org.vi
3068	.viajes
3069	.video
3070	.vig
3071	.viking
3072	.villas
3073	.vin
3074	.vip
3075	.virgin
3076	.visa
3077	.vision
3078	.vista
3079	.vistaprint
3080	.viva
3081	.vivo
3082	.vlaanderen
3083	.vn
3084	.ac.vn
3085	.biz.vn
3086	.com.vn
3087	.edu.vn
3088	.gov.vn
3089	.health.vn
3090	.info.vn
3091	.int.vn
3092	.name.vn
3093	.net.vn
3094	.org.vn
3095	.pro.vn
3096	.vodka
3097	.volkswagen
3098	.volvo
3099	.vote
3100	.voting
3101	.voto
3102	.voyage
3103	.vu
3104	.com.vu
3105	.net.vu
3106	.org.vu
3107	.vuelos
3108	.wales
3109	.walmart
3110	.walter
3111	.wang
3112	.wanggou
3113	.warman
3114	.watch
3115	.watches
3116	.weather
3117	.weatherchannel
3118	.webcam
3119	.weber
3120	.website
3121	.wed
3122	.wedding
3123	.weibo
3124	.weir
3125	.wf
3126	.whoswho
3127	.wien
3128	.wiki
3129	.williamhill
3130	.win
3131	.windows
3132	.wine
3133	.winners
3134	.wme
3135	.wolterskluwer
3136	.woodside
3137	.work
3138	.works
3139	.world
3140	.wow
3141	.ws
3142	.com.ws
3143	.edu.ws
3144	.gov.ws
3145	.net.ws
3146	.org.ws
3147	.wtc
3148	.wtf
3149	.xbox
3150	.xerox
3151	.xfinity
3152	.xihuan
3153	.xin
3154	.xperia
3155	.xxx
3156	.xyz
3157	.yachts
3158	.yahoo
3159	.yamaxun
3160	.yandex
3161	.ye
3162	.com.ye
3163	.net.ye
3164	.org.ye
3165	.yodobashi
3166	.yoga
3167	.yokohama
3168	.you
3169	.youtube
3170	.yt
3171	.yun
3172	.za
3173	.co.za
3174	.net.za
3175	.org.za
3176	.web.za
3177	.zappos
3178	.zara
3179	.zero
3180	.zip
3181	.zippo
3182	.zm
3183	.co.zm
3184	.com.zm
3185	.org.zm
3186	.zone
3187	.zuerich
3188	.zw
3189	.co.zw
3190	.δοκιμή
3191	.ελ
3192	.ευ
3193	.бг
3194	.бел
3195	.дети
3196	.ею
3197	.испытание
3198	.католик
3199	.ком
3200	.мкд
3201	.мон
3202	.москва
3203	.онлайн
3204	.орг
3205	.рус
3206	.001.рус
3207	.002.рус
3208	.003.рус
3209	.004.рус
3210	.005.рус
3211	.006.рус
3212	.007.рус
3213	.008.рус
3214	.009.рус
3215	.010.рус
3216	.011.рус
3217	.012.рус
3218	.013.рус
3219	.014.рус
3220	.015.рус
3221	.016.рус
3222	.017.рус
3223	.018.рус
3224	.019.рус
3225	.021.рус
3226	.022.рус
3227	.023.рус
3228	.024.рус
3229	.025.рус
3230	.026.рус
3231	.027.рус
3232	.028.рус
3233	.029.рус
3234	.030.рус
3235	.031.рус
3236	.032.рус
3237	.033.рус
3238	.034.рус
3239	.035.рус
3240	.036.рус
3241	.037.рус
3242	.038.рус
3243	.039.рус
3244	.040.рус
3245	.041.рус
3246	.042.рус
3247	.043.рус
3248	.044.рус
3249	.045.рус
3250	.046.рус
3251	.047.рус
3252	.048.рус
3253	.049.рус
3254	.050.рус
3255	.051.рус
3256	.052.рус
3257	.053.рус
3258	.054.рус
3259	.055.рус
3260	.056.рус
3261	.057.рус
3262	.058.рус
3263	.059.рус
3264	.060.рус
3265	.061.рус
3266	.062.рус
3267	.063.рус
3268	.064.рус
3269	.065.рус
3270	.066.рус
3271	.067.рус
3272	.068.рус
3273	.069.рус
3274	.070.рус
3275	.071.рус
3276	.072.рус
3277	.073.рус
3278	.074.рус
3279	.075.рус
3280	.076.рус
3281	.077.рус
3282	.078.рус
3283	.079.рус
3284	.083.рус
3285	.086.рус
3286	.087.рус
3287	.089.рус
3288	.094.рус
3289	.095.рус
3290	.абакан.рус
3291	.авто.рус
3292	.алм.рус
3293	.алтай.рус
3294	.анадырь.рус
3295	.астана.рус
3296	.астрахань.рус
3297	.ахг.рус
3298	.баку.рус
3299	.барнаул.рус
3300	.бел.рус
3301	.белгород.рус
3302	.биз.рус
3303	.биробиджан.рус
3304	.бишкек.рус
3305	.благовещенск.рус
3306	.бобруйск.рус
3307	.брест.рус
3308	.брянск.рус
3309	.бурятия.рус
3310	.великийновгород.рус
3311	.вильнюс.рус
3312	.витебск.рус
3313	.владивосток.рус
3314	.владикавказ.рус
3315	.владимир.рус
3316	.волга.рус
3317	.волгоград.рус
3318	.вологда.рус
3319	.воронеж.рус
3320	.гомель.рус
3321	.гродно.рус
3322	.грозный.рус
3323	.ект.рус
3324	.ереван.рус
3325	.иваново.рус
3326	.ижевск.рус
3327	.иркутск.рус
3328	.казань.рус
3329	.калининград.рус
3330	.калуга.рус
3331	.кемерово.рус
3332	.киев.рус
3333	.киров.рус
3334	.кишинев.рус
3335	.ком.рус
3336	.коми.рус
3337	.кострома.рус
3338	.краснодар.рус
3339	.красноярск.рус
3340	.крым.рус
3341	.курган.рус
3342	.курск.рус
3343	.кызыл.рус
3344	.липецк.рус
3345	.магадан.рус
3346	.магас.рус
3347	.майкоп.рус
3348	.марийэл.рус
3349	.мариэл.рус
3350	.махачкала.рус
3351	.мед.рус
3352	.минск.рус
3353	.мир.рус
3354	.могилёв.рус
3355	.мск.рус
3356	.мурманск.рус
3357	.нальчик.рус
3358	.нарьян-мар.рус
3359	.нвс.рус
3360	.нн.рус
3361	.новосибирск.рус
3362	.омск.рус
3363	.орг.рус
3364	.оренбург.рус
3365	.орёл.рус
3366	.пенза.рус
3367	.пермь.рус
3368	.петрозаводск.рус
3369	.псков.рус
3370	.пятигорск.рус
3371	.рига.рус
3372	.ростов-на-дону.рус
3373	.рств.рус
3374	.рязань.рус
3375	.салехард.рус
3376	.самара.рус
3377	.саранск.рус
3378	.саратов.рус
3379	.севастополь.рус
3380	.сибирь.рус
3381	.симферополь.рус
3382	.смоленск.рус
3383	.сочи.рус
3384	.спб.рус
3385	.ставрополь.рус
3386	.таллин.рус
3387	.тамбов.рус
3388	.ташкент.рус
3389	.тверь.рус
3390	.томск.рус
3391	.тула.рус
3392	.тур.рус
3393	.тюмень.рус
3394	.ульяновск.рус
3395	.уфа.рус
3396	.хабаровск.рус
3397	.чебоксары.рус
3398	.челябинск.рус
3399	.черкесск.рус
3400	.чита.рус
3401	.элиста.рус
3402	.югра.рус
3403	.я.рус
3404	.якутск.рус
3405	.ярославль.рус
3406	.рф
3407	.ком.рф
3408	.нет.рф
3409	.орг.рф
3410	.сайт
3411	.срб
3412	.ак.срб
3413	.пр.срб
3414	.упр.срб
3415	.укр
3416	.қаз
3417	.հայ
3418	.טעסט
3419	.קום
3420	.آزمایشی
3421	.إختبار
3422	.ابوظبي
3423	.اتصالات
3424	.ارامكو
3425	.الاردن
3426	.البحرين
3427	.الجزائر
3428	.السعودية
3429	.العليان
3430	.المغرب
3431	.امارات
3432	.ایران
3433	.بارت
3434	.بازار
3435	.بيتك
3436	.بھارت
3437	.تونس
3438	.سودان
3439	.سورية
3440	.شبكة
3441	.عراق
3442	.عرب
3443	.عمان
3444	.فلسطين
3445	.قطر
3446	.كاثوليك
3447	.كوم
3448	.مصر
3449	.مليسيا
3450	.موبايلي
3451	.موريتانيا
3452	.موقع
3453	.همراه
3454	.پاكستان
3455	.پاکستان
3456	.ڀارت
3457	.कॉम
3458	.नेट
3459	.परीक्षा
3460	.भारत
3461	.कंपनी.भारत
3462	.भारतम्
3463	.भारोत
3464	.संगठन
3465	.বাংলা
3466	.ভারত
3467	.ভাৰত
3468	.ਭਾਰਤ
3469	.ભારત
3470	.ଭାରତ
3471	.இந்தியா
3472	.இலங்கை
3473	.சிங்கப்பூர்
3474	.பரிட்சை
3475	.భారత్
3476	.ಭಾರತ
3477	.ഭാരതം
3478	.ලංකා
3479	.คอม
3480	.ไทย
3481	.ธุรกิจ.ไทย
3482	.ລາວ
3483	.გე
3484	.みんな
3485	.クラウド
3486	.グーグル
3487	.コム
3488	.ストア
3489	.セール
3490	.テスト
3491	.ファッション
3492	.ポイント
3493	.世界
3494	.中信
3495	.中国
3496	.中國
3497	.中文网
3498	.企业
3499	.佛山
3500	.信息
3501	.健康
3502	.八卦
3503	.公司
3504	.公益
3505	.台湾
3506	.台灣
3507	.商城
3508	.商店
3509	.商标
3510	.嘉里
3511	.嘉里大酒店
3512	.在线
3513	.大众汽车
3514	.大拿
3515	.天主教
3516	.娱乐
3517	.家電
3518	.工行
3519	.广东
3520	.微博
3521	.慈善
3522	.我爱你
3523	.手机
3524	.手表
3525	.招聘
3526	.政务
3527	.政府
3528	.新加坡
3529	.新闻
3530	.时尚
3531	.書籍
3532	.机构
3533	.测试
3534	.淡马锡
3535	.測試
3536	.游戏
3537	.澳門
3538	.点看
3539	.珠宝
3540	.移动
3541	.组织机构
3542	.网址
3543	.网店
3544	.网站
3545	.网络
3546	.联通
3547	.诺基亚
3548	.谷歌
3549	.购物
3550	.通販
3551	.集团
3552	.電訊盈科
3553	.飞利浦
3554	.食品
3555	.餐厅
3556	.香格里拉
3557	.香港
3558	.個人.香港
3559	.公司.香港
3560	.政府.香港
3561	.教育.香港
3562	.組織.香港
3563	.網絡.香港
3564	.닷넷
3565	.닷컴
3566	.삼성
3567	.테스트
3568	.한국
\.


--
-- Data for Name: visa_ease_of_entry; Type: TABLE DATA; Schema: public; Owner: brook
--

COPY public.visa_ease_of_entry (id, name) FROM stdin;
1	not required
3	pre-purchase
4	special requirements
5	unknown
2	on arrival
\.


--
-- Data for Name: visa_type; Type: TABLE DATA; Schema: public; Owner: brook
--

COPY public.visa_type (id, ease, name) FROM stdin;
1	not required	visa not required
2	not required	visa waiver program
3	pre-purchase	evisa
4	pre-purchase	evisitor
5	pre-purchase	e tourist card
6	pre-purchase	electronic travel authority
7	pre-purchase	online visa
8	pre-purchase	visa required
9	pre-purchase	permit required
10	pre-purchase	permission required
11	pre-purchase	electronic entry visa
12	pre-purchase	tourist card required
13	pre-purchase	electronic travel authorization
14	special requirements	special permit required
15	unknown	admission refused
16	not required	right of abode
17	not required	freedom of movement
18	pre-purchase	ttp required
19	pre-purchase	electronic authorisation
20	pre-purchase	travel permit required
21	pre-purchase	pap or rap required
22	pre-purchase	ovir permit required
23	pre-purchase	entry permit required
24	pre-purchase	pre registration required
25	special requirements	restricted area
26	special requirements	special permission required
27	special requirements	access permit required
28	special requirements	special authorisation required
29	special requirements	special permits required
30	special requirements	restricted zone
31	on arrival	visa on arrival
32	on arrival	free visa on arrival
33	on arrival	entry permit on arrival
34	on arrival	visitor permit on arrival
35	on arrival	conditional visa on arrival
36	on arrival	free visitor permit on arrival
37	on arrival	tourist card on arrival
51	on arrival	free entry permit on arrival
\.


--
-- Name: ISO_3166-1_alpha-3_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brook
--

SELECT pg_catalog.setval('public."ISO_3166-1_alpha-3_id_seq"', 22, true);


--
-- Name: ISO_3166-2_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brook
--

SELECT pg_catalog.setval('public."ISO_3166-2_id_seq"', 24, true);


--
-- Name: ISO_3166-2_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brook
--

SELECT pg_catalog.setval('public."ISO_3166-2_types_id_seq"', 6, true);


--
-- Name: ISO_3166-3_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brook
--

SELECT pg_catalog.setval('public."ISO_3166-3_id_seq"', 7, true);


--
-- Name: ISO_3166-3_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brook
--

SELECT pg_catalog.setval('public."ISO_3166-3_types_id_seq"', 3, true);


--
-- Name: demonym_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brook
--

SELECT pg_catalog.setval('public.demonym_id_seq', 320, true);


--
-- Name: language_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brook
--

SELECT pg_catalog.setval('public.language_id_seq', 42, true);


--
-- Name: language_label_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brook
--

SELECT pg_catalog.setval('public.language_label_id_seq', 59, true);


--
-- Name: language_relationship_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brook
--

SELECT pg_catalog.setval('public.language_relationship_id_seq', 45, true);


--
-- Name: language_relationship_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brook
--

SELECT pg_catalog.setval('public.language_relationship_type_id_seq', 1, true);


--
-- Name: passport_travel_requirements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brook
--

SELECT pg_catalog.setval('public.passport_travel_requirements_id_seq', 1426, true);


--
-- Name: svg_path_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brook
--

SELECT pg_catalog.setval('public.svg_path_id_seq', 211, true);


--
-- Name: territory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brook
--

SELECT pg_catalog.setval('public.territory_id_seq', 30, true);


--
-- Name: territory_label_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brook
--

SELECT pg_catalog.setval('public.territory_label_id_seq', 249, true);


--
-- Name: territory_language_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brook
--

SELECT pg_catalog.setval('public.territory_language_id_seq', 2, true);


--
-- Name: territory_reltionship_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brook
--

SELECT pg_catalog.setval('public.territory_reltionship_id_seq', 4, true);


--
-- Name: territory_reltionship_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brook
--

SELECT pg_catalog.setval('public.territory_reltionship_type_id_seq', 2, true);


--
-- Name: territory_top_level_domain_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brook
--

SELECT pg_catalog.setval('public.territory_top_level_domain_id_seq', 48, true);


--
-- Name: top_level_domains_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brook
--

SELECT pg_catalog.setval('public.top_level_domains_id_seq', 28, true);


--
-- Name: visa_ease_of_entry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brook
--

SELECT pg_catalog.setval('public.visa_ease_of_entry_id_seq', 5, true);


--
-- Name: visa_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brook
--

SELECT pg_catalog.setval('public.visa_types_id_seq', 51, true);


--
-- Name: ISO_3166-1_alpha-3 ISO_3166-1_alpha-3_pkey; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public."ISO_3166-1_alpha-3"
    ADD CONSTRAINT "ISO_3166-1_alpha-3_pkey" PRIMARY KEY (id);


--
-- Name: ISO_3166-1_alpha-3 ISO_3166-1_alpha-3_uuid_key; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public."ISO_3166-1_alpha-3"
    ADD CONSTRAINT "ISO_3166-1_alpha-3_uuid_key" UNIQUE (uuid);


--
-- Name: ISO_3166-2 ISO_3166-2_pkey; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public."ISO_3166-2"
    ADD CONSTRAINT "ISO_3166-2_pkey" PRIMARY KEY (id);


--
-- Name: ISO_3166_type ISO_3166-2_types_name_key; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public."ISO_3166_type"
    ADD CONSTRAINT "ISO_3166-2_types_name_key" UNIQUE (name);


--
-- Name: ISO_3166_type ISO_3166-2_types_pkey; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public."ISO_3166_type"
    ADD CONSTRAINT "ISO_3166-2_types_pkey" PRIMARY KEY (id);


--
-- Name: ISO_3166-2 ISO_3166-2_uuid_key; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public."ISO_3166-2"
    ADD CONSTRAINT "ISO_3166-2_uuid_key" UNIQUE (uuid);


--
-- Name: ISO_3166-3 ISO_3166-3_pkey; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public."ISO_3166-3"
    ADD CONSTRAINT "ISO_3166-3_pkey" PRIMARY KEY (id);


--
-- Name: ISO_3166-3_type ISO_3166-3_types_name_key; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public."ISO_3166-3_type"
    ADD CONSTRAINT "ISO_3166-3_types_name_key" UNIQUE (name);


--
-- Name: ISO_3166-3_type ISO_3166-3_types_pkey; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public."ISO_3166-3_type"
    ADD CONSTRAINT "ISO_3166-3_types_pkey" PRIMARY KEY (id);


--
-- Name: ISO_3166-3 ISO_3166-3_uuid_key; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public."ISO_3166-3"
    ADD CONSTRAINT "ISO_3166-3_uuid_key" UNIQUE (uuid);


--
-- Name: demonym demonym_pkey; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.demonym
    ADD CONSTRAINT demonym_pkey PRIMARY KEY (id);


--
-- Name: demonym demonym_uuid_key; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.demonym
    ADD CONSTRAINT demonym_uuid_key UNIQUE (uuid);


--
-- Name: language_label language_label_pkey; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.language_label
    ADD CONSTRAINT language_label_pkey PRIMARY KEY (id);


--
-- Name: language_label language_label_uuid_key; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.language_label
    ADD CONSTRAINT language_label_uuid_key UNIQUE (uuid);


--
-- Name: language language_name_key; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.language
    ADD CONSTRAINT language_name_key UNIQUE (name);


--
-- Name: language language_pkey; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.language
    ADD CONSTRAINT language_pkey PRIMARY KEY (id);


--
-- Name: language_relationship language_relationship_pkey; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.language_relationship
    ADD CONSTRAINT language_relationship_pkey PRIMARY KEY (id);


--
-- Name: language_relationship_type language_relationship_type_name_key; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.language_relationship_type
    ADD CONSTRAINT language_relationship_type_name_key UNIQUE (name);


--
-- Name: language_relationship_type language_relationship_type_pkey; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.language_relationship_type
    ADD CONSTRAINT language_relationship_type_pkey PRIMARY KEY (id);


--
-- Name: language_relationship language_relationship_uuid_key; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.language_relationship
    ADD CONSTRAINT language_relationship_uuid_key UNIQUE (uuid);


--
-- Name: language language_uuid_key; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.language
    ADD CONSTRAINT language_uuid_key UNIQUE (uuid);


--
-- Name: passport_travel_requirements passport_travel_requirements_pkey; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.passport_travel_requirements
    ADD CONSTRAINT passport_travel_requirements_pkey PRIMARY KEY (id);


--
-- Name: passport_travel_requirements passport_travel_requirements_route_key; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.passport_travel_requirements
    ADD CONSTRAINT passport_travel_requirements_route_key UNIQUE (route);


--
-- Name: passport_travel_requirements passport_travel_requirements_uuid_key; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.passport_travel_requirements
    ADD CONSTRAINT passport_travel_requirements_uuid_key UNIQUE (uuid);


--
-- Name: svg_path svg_path_pkey; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.svg_path
    ADD CONSTRAINT svg_path_pkey PRIMARY KEY (id);


--
-- Name: svg_path svg_path_uuid_key; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.svg_path
    ADD CONSTRAINT svg_path_uuid_key UNIQUE (uuid);


--
-- Name: territory_label territory_label_pkey; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.territory_label
    ADD CONSTRAINT territory_label_pkey PRIMARY KEY (id);


--
-- Name: territory_language territory_language_pkey; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.territory_language
    ADD CONSTRAINT territory_language_pkey PRIMARY KEY (id);


--
-- Name: territory_language territory_language_uuid_key; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.territory_language
    ADD CONSTRAINT territory_language_uuid_key UNIQUE (uuid);


--
-- Name: territory territory_name_key; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.territory
    ADD CONSTRAINT territory_name_key UNIQUE (name);


--
-- Name: territory territory_pkey; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.territory
    ADD CONSTRAINT territory_pkey PRIMARY KEY (id);


--
-- Name: territory_reltionship territory_reltionship_pkey; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.territory_reltionship
    ADD CONSTRAINT territory_reltionship_pkey PRIMARY KEY (id);


--
-- Name: territory_reltionship_type territory_reltionship_type_name_key; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.territory_reltionship_type
    ADD CONSTRAINT territory_reltionship_type_name_key UNIQUE (name);


--
-- Name: territory_reltionship_type territory_reltionship_type_pkey; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.territory_reltionship_type
    ADD CONSTRAINT territory_reltionship_type_pkey PRIMARY KEY (id);


--
-- Name: territory_top_level_domain territory_top_level_domain_pkey; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.territory_top_level_domain
    ADD CONSTRAINT territory_top_level_domain_pkey PRIMARY KEY (id);


--
-- Name: territory_top_level_domain territory_top_level_domain_uuid_key; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.territory_top_level_domain
    ADD CONSTRAINT territory_top_level_domain_uuid_key UNIQUE (uuid);


--
-- Name: territory territory_uuid_key; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.territory
    ADD CONSTRAINT territory_uuid_key UNIQUE (uuid);


--
-- Name: top_level_domain top_level_domains_name_key; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.top_level_domain
    ADD CONSTRAINT top_level_domains_name_key UNIQUE (name);


--
-- Name: top_level_domain top_level_domains_pkey; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.top_level_domain
    ADD CONSTRAINT top_level_domains_pkey PRIMARY KEY (id);


--
-- Name: visa_ease_of_entry visa_ease_of_entry_name_key; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.visa_ease_of_entry
    ADD CONSTRAINT visa_ease_of_entry_name_key UNIQUE (name);


--
-- Name: visa_ease_of_entry visa_ease_of_entry_pkey; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.visa_ease_of_entry
    ADD CONSTRAINT visa_ease_of_entry_pkey PRIMARY KEY (id);


--
-- Name: visa_type visa_types_name_key; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.visa_type
    ADD CONSTRAINT visa_types_name_key UNIQUE (name);


--
-- Name: visa_type visa_types_pkey; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.visa_type
    ADD CONSTRAINT visa_types_pkey PRIMARY KEY (id);


--
-- Name: passport_travel_requirements destination_territory; Type: FK CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.passport_travel_requirements
    ADD CONSTRAINT destination_territory FOREIGN KEY (destination_territory) REFERENCES public.territory(uuid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: visa_type ease; Type: FK CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.visa_type
    ADD CONSTRAINT ease FOREIGN KEY (ease) REFERENCES public.visa_ease_of_entry(name) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: language_label language; Type: FK CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.language_label
    ADD CONSTRAINT language FOREIGN KEY (language) REFERENCES public.language(uuid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: territory_language language; Type: FK CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.territory_language
    ADD CONSTRAINT language FOREIGN KEY (language) REFERENCES public.language(uuid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: language_relationship language_relationship_language_fkey; Type: FK CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.language_relationship
    ADD CONSTRAINT language_relationship_language_fkey FOREIGN KEY (language) REFERENCES public.language(uuid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: language_relationship language_relationship_related_language_fkey; Type: FK CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.language_relationship
    ADD CONSTRAINT language_relationship_related_language_fkey FOREIGN KEY (related_language) REFERENCES public.language(uuid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: passport_travel_requirements passport_territory; Type: FK CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.passport_travel_requirements
    ADD CONSTRAINT passport_territory FOREIGN KEY (passport_territory) REFERENCES public.territory(uuid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: ISO_3166-3 previous_territory; Type: FK CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public."ISO_3166-3"
    ADD CONSTRAINT previous_territory FOREIGN KEY (previous_territory) REFERENCES public.territory(uuid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: territory_reltionship related_territory; Type: FK CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.territory_reltionship
    ADD CONSTRAINT related_territory FOREIGN KEY (related_territory) REFERENCES public.territory(uuid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: territory_reltionship relationship; Type: FK CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.territory_reltionship
    ADD CONSTRAINT relationship FOREIGN KEY (relationship) REFERENCES public.territory_reltionship_type(name) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: territory_language teritorry; Type: FK CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.territory_language
    ADD CONSTRAINT teritorry FOREIGN KEY (territory) REFERENCES public.territory(uuid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: territory_label territory; Type: FK CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.territory_label
    ADD CONSTRAINT territory FOREIGN KEY (territory) REFERENCES public.territory(uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ISO_3166-2 territory; Type: FK CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public."ISO_3166-2"
    ADD CONSTRAINT territory FOREIGN KEY (territory) REFERENCES public.territory(uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ISO_3166-1_alpha-3 territory; Type: FK CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public."ISO_3166-1_alpha-3"
    ADD CONSTRAINT territory FOREIGN KEY (territory) REFERENCES public.territory(uuid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: territory_top_level_domain territory; Type: FK CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.territory_top_level_domain
    ADD CONSTRAINT territory FOREIGN KEY (territory) REFERENCES public.territory(uuid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: ISO_3166-3 territory; Type: FK CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public."ISO_3166-3"
    ADD CONSTRAINT territory FOREIGN KEY (territory) REFERENCES public.territory(uuid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: demonym territory; Type: FK CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.demonym
    ADD CONSTRAINT territory FOREIGN KEY (territory) REFERENCES public.territory(uuid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: territory_reltionship territory; Type: FK CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.territory_reltionship
    ADD CONSTRAINT territory FOREIGN KEY (territory) REFERENCES public.territory(uuid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: svg_path territory; Type: FK CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.svg_path
    ADD CONSTRAINT territory FOREIGN KEY (territory) REFERENCES public.territory(uuid) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: territory_top_level_domain top_level_domain; Type: FK CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.territory_top_level_domain
    ADD CONSTRAINT top_level_domain FOREIGN KEY (top_level_domain) REFERENCES public.top_level_domain(name) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: ISO_3166-2 type; Type: FK CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public."ISO_3166-2"
    ADD CONSTRAINT type FOREIGN KEY (type) REFERENCES public."ISO_3166_type"(name) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: ISO_3166-1_alpha-3 type; Type: FK CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public."ISO_3166-1_alpha-3"
    ADD CONSTRAINT type FOREIGN KEY (type) REFERENCES public."ISO_3166_type"(name) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: ISO_3166-3 type; Type: FK CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public."ISO_3166-3"
    ADD CONSTRAINT type FOREIGN KEY (type) REFERENCES public."ISO_3166-3_type"(name) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: language_relationship type; Type: FK CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.language_relationship
    ADD CONSTRAINT type FOREIGN KEY (type) REFERENCES public.language_relationship_type(name) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: passport_travel_requirements visa_type; Type: FK CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.passport_travel_requirements
    ADD CONSTRAINT visa_type FOREIGN KEY (visa_type) REFERENCES public.visa_type(name) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: brook
--

GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

