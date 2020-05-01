--
-- PostgreSQL database dump
--

-- Dumped from database version 12.1
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
-- Name: passport_travel_requirements; Type: TABLE; Schema: public; Owner: brook
--

CREATE TABLE public.passport_travel_requirements (
    id integer NOT NULL,
    passport_territory character(36) NOT NULL,
    destination_territory character(36) NOT NULL,
    visa_type text NOT NULL,
    stay_length interval,
    notes text
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
1	b3ba2a45-11e0-48b8-beaa-2f7f50eef574	british	0f433ba9-47e1-4fe6-902c-632bf40355a9
2	c9e05c05-98e9-4286-8164-1a616ed2b80d	english	56c6dacf-b4d9-401b-874a-6518da0cd567
3	e8d2a15d-fd73-4888-8777-6f71e6995674	welsh	c5bc507e-7bca-4c9d-8d7b-a3441b33dffe
4	207245e1-5b61-48e9-8545-fe402145a27e	scottish	e054a323-d773-441e-9cbb-9843a1780b2d
5	27741afe-5c72-4f22-90bd-e44b7e6b3a61	irish	c639dcd9-0e03-4f83-bdba-8a5a921b021a
6	58d7a8a7-1e3d-49e1-ab32-784ccba9e2f1	englishman	56c6dacf-b4d9-401b-874a-6518da0cd567
7	436b7f81-717c-4d20-80b7-46cad96cb22d	englishwoman	56c6dacf-b4d9-401b-874a-6518da0cd567
8	3c100302-b847-4efa-bc35-897cf4c41227	northern irish	c639dcd9-0e03-4f83-bdba-8a5a921b021a
9	7e0c3d1b-daf2-4e1a-a5b9-6253edc2ae8b	ulsterman	c639dcd9-0e03-4f83-bdba-8a5a921b021a
10	a0df2404-6546-47f1-906d-7fdf5b360fe6	scot	e054a323-d773-441e-9cbb-9843a1780b2d
11	3f9857cc-3a63-48e0-812d-0c3c9ddfd973	jock	e054a323-d773-441e-9cbb-9843a1780b2d
12	800ca7a5-9063-454f-a59e-5b412f2acd04	taff	c5bc507e-7bca-4c9d-8d7b-a3441b33dffe
13	0d7b2fa8-0fb6-436f-a428-4c6c040022cb	briton	0f433ba9-47e1-4fe6-902c-632bf40355a9
14	bdd075e7-dd35-4547-85c4-0f48a52088ca	welshman	c5bc507e-7bca-4c9d-8d7b-a3441b33dffe
15	3a19039f-deed-4fda-847c-ffa1b6198ec4	welshwoman	c5bc507e-7bca-4c9d-8d7b-a3441b33dffe
16	b26d644e-d0e9-4650-b6f4-d5f68363660d	emirati	2b1a33fe-be25-452b-8a1c-c7d5f1dce9c2
17	279b5903-2940-4495-bfbd-eee3898f585a	emiri	2b1a33fe-be25-452b-8a1c-c7d5f1dce9c2
18	fd243454-e829-4373-8624-1771a4364ead	emirian	2b1a33fe-be25-452b-8a1c-c7d5f1dce9c2
19	356d38ae-505a-40b4-acd0-894c0e5f4e75	djiboutian	0b48c87c-ddaa-49d2-b736-61d9c44636e0
20	495d9f9d-86e1-4fa7-bc9b-9913e0b3cd34	french	af123316-5e2b-4453-9908-13434c758d89
21	6e667ab8-4da7-420d-a1b8-303af1aaba26	frenchman	af123316-5e2b-4453-9908-13434c758d89
22	91b60f51-2046-4bb6-ac92-4b7cbafa3a5e	frenchwoman	af123316-5e2b-4453-9908-13434c758d89
23	6c5dea9f-4aa8-4b5e-a501-0b18c9c04a4e	french	b7b802fe-8789-4b6d-b085-7c25a92dab7b
24	77fb47e5-04db-4b7f-9597-64e9338d7c72	frenchman	b7b802fe-8789-4b6d-b085-7c25a92dab7b
25	ed2f50c6-b9ed-4d1f-b8e5-564abadc15fd	frenchwoman	b7b802fe-8789-4b6d-b085-7c25a92dab7b
26	161e0e54-0bf3-4fb6-b4cf-a855c0ba0e98	french	74718d89-2c74-4664-a9f9-c3bda5884237
27	ce75c613-6e6a-4e95-869a-04e281b67bb6	frenchman	74718d89-2c74-4664-a9f9-c3bda5884237
28	aeb76459-d865-4d90-8ca5-c76dea8a819e	frenchwoman	74718d89-2c74-4664-a9f9-c3bda5884237
29	e8f46495-e6ea-4850-a55a-1dd91ec2be29	czechoslovak	7fb270a5-06a1-4488-951f-55dcc7e822c0
30	caf65208-5ec1-42c7-95e5-5682a1da7b5a	czech	c5db5d6b-ebcd-4642-9604-0f1ebf2fdf9d
31	f8fab8b6-4ee8-47d6-8ad7-d0e27469c606	slovak	2dd507e0-8e57-4924-a57f-8fc2e22555e2
32	5df8d172-e242-47d1-9372-60785a5c9631	slovakian	2dd507e0-8e57-4924-a57f-8fc2e22555e2
33	2800e8cb-24d4-4d7a-866f-1e847cbd7525	burmese	ac8b13ec-0d98-4fad-852e-a351d68e6a16
34	621c55e4-4f56-4454-b6a8-a5c30e61c107	myanma	ac8b13ec-0d98-4fad-852e-a351d68e6a16
35	bacaefdc-227d-4c6b-beaa-5a38bada63ed	burmese	509e1050-f5ab-4d6b-ba04-501765fb9ecf
36	23dc8a1a-b3fa-4c7a-b8fc-7424b2df9b53	yugoslav	9081511d-8a3b-4372-b828-44afb55b2dc4
37	a5c375d1-4410-4141-849e-903d951e6dc4	yugoslavian	9081511d-8a3b-4372-b828-44afb55b2dc4
38	c1f7c4be-dc1b-43be-93cd-24731a642657	yugoslav	ba063fe6-f538-45d8-9450-81c536a1aa29
39	b3eefcad-2f2a-4425-a396-d3fa04feba7c	montenegrin	6702177a-fbed-4cf3-aa32-22da244beab0
40	3d706acf-d160-46bc-862c-22747e26bc7f	serbian	aae2ba87-a67d-43bd-8516-e403843d61d9
41	4a36669f-0418-4e7e-bb72-b1c15bf492e2	serb	aae2ba87-a67d-43bd-8516-e403843d61d9
42	ed585472-537b-45d7-8a59-39c127c36a87	netherlands antillean	437b6b0d-4fe4-4e6a-b869-9aca4351a182
43	e96ac471-3cb3-41a8-ab19-288f7b832bb9	barbadian	49494a5b-205f-4756-9145-2784c9269a99
44	234ec32a-0510-4f44-8de1-19867849107a	dutch antillean	437b6b0d-4fe4-4e6a-b869-9aca4351a182
45	f49c08f7-07e3-4a6a-ae4c-5fd6d538428a	andorran	1965c743-cf9a-4021-9ed1-b9e4e77486a2
\.


--
-- Data for Name: passport_travel_requirements; Type: TABLE DATA; Schema: public; Owner: brook
--

COPY public.passport_travel_requirements (id, passport_territory, destination_territory, visa_type, stay_length, notes) FROM stdin;
1	0f433ba9-47e1-4fe6-902c-632bf40355a9	1965c743-cf9a-4021-9ed1-b9e4e77486a2	visa not required	90 days	\N
2	0f433ba9-47e1-4fe6-902c-632bf40355a9	2b1a33fe-be25-452b-8a1c-c7d5f1dce9c2	free visa on arrival	30 days	\N
3	0f433ba9-47e1-4fe6-902c-632bf40355a9	793360a3-aa91-4703-acfe-60287e3f9b74	visa not required	3 mons	\N
4	0f433ba9-47e1-4fe6-902c-632bf40355a9	ca1a8efc-5d84-4e75-9f3b-5d005b9afca5	freedom of movement	\N	\N
5	0f433ba9-47e1-4fe6-902c-632bf40355a9	49494a5b-205f-4756-9145-2784c9269a99	visa not required	6 mons	\N
6	0f433ba9-47e1-4fe6-902c-632bf40355a9	c5db5d6b-ebcd-4642-9604-0f1ebf2fdf9d	visa not required	\N	\N
7	0f433ba9-47e1-4fe6-902c-632bf40355a9	2dd507e0-8e57-4924-a57f-8fc2e22555e2	visa not required	\N	\N
8	0f433ba9-47e1-4fe6-902c-632bf40355a9	ac8b13ec-0d98-4fad-852e-a351d68e6a16	evisa	28 days	eVisa holders must arrive via Yangon, Nay Pyi Taw or Mandalay airports or via land border crossings with Thailand — Tachileik, Myawaddy and Kawthaung or India — Rih Khaw Dar and Tamu.\n\neVisa available for both tourism (allowed stay is 28 days) or business purposes (allowed stay is 70 days).
9	0f433ba9-47e1-4fe6-902c-632bf40355a9	6702177a-fbed-4cf3-aa32-22da244beab0	visa not required	90 days	Must register with the local police station (either through a tourist organisation or at hotel reception) within 24 hours of arrival.
10	0f433ba9-47e1-4fe6-902c-632bf40355a9	aae2ba87-a67d-43bd-8516-e403843d61d9	visa not required	90 days	\N
11	0f433ba9-47e1-4fe6-902c-632bf40355a9	0b48c87c-ddaa-49d2-b736-61d9c44636e0	evisa	31 days	\N
\.


--
-- Data for Name: svg_path; Type: TABLE DATA; Schema: public; Owner: brook
--

COPY public.svg_path (id, uuid, territory, path) FROM stdin;
1	2dffdc3c-4b48-40eb-8dd9-13751ab729c3	b33be079-39b7-4a1d-b689-97c224d5fece	m 1369.9,333.8 -5.4,0 -3.8,-0.5 -2.5,2.9 -2.1,0.7 -1.5,1.3 -2.6,-2.1 -1,-5.4 -1.6,-0.3 0,-2 -3.2,-1.5 -1.7,2.3 0.2,2.6 -0.6,0.9 -3.2,-0.1 -0.9,3 -2.1,-1.3 -3.3,2.1 -1.8,-0.8 -4.3,-1.4 -2.9,0 -1.6,-0.2 -2.9,-1.7 -0.3,2.3 -4.1,1.2 0.1,5.2 -2.5,2 -4,0.9 -0.4,3 -3.9,0.8 -5.9,-2.4 -0.5,8 -0.5,4.7 2.5,0.9 -1.6,3.5 2.7,5.1 1.1,4 4.3,1.1 1.1,4 -3.9,5.8 9.6,3.2 5.3,-0.9 3.3,0.8 0.9,-1.4 3.8,0.5 6.6,-2.6 -0.8,-5.4 2.3,-3.6 4,0 0.2,-1.7 4,-0.9 2.1,0.6 1.7,-1.8 -1.1,-3.8 1.5,-3.8 3,-1.6 -3,-4.2 5.1,0.2 0.9,-2.3 -0.8,-2.5 2,-2.7 -1.4,-3.2 -1.9,-2.8 2.4,-2.8 5.3,-1.3 5.8,-0.8 2.4,-1.2 2.8,-0.7 -1.4,-1.9 z
2	014172a2-3c5e-43a0-bdb2-242efecc7b3d	6c7e4e7d-9bf4-4e47-b2e4-c925f54bcd1a	m 1077.5,300.5 -2,3.1 0.5,1.9 0,0 1,1 -0.5,1.9 -0.1,4.3 0.7,3 3,2.1 0.2,1.4 1,0.4 2.1,-3 0.1,-2.1 1.6,-0.9 0,-1.6 -2.3,-1.6 -0.9,-2.6 0.4,-2.1 0,0 -0.5,-2.3 -1.3,-0.6 -1.3,-1.6 -1.3,0.5 -0.4,-1.2 z
3	1e143a00-c410-4629-8f94-82d126dd3f68	d9b8f8c8-5b5a-41ef-8538-26d822a4c9bd	m 1021,336.9 -3.6,0.4 -2.2,-1.5 -5.6,0 -4.9,2.6 -2.7,-1 -8.7,0.5 -8.9,1.2 -5,2 -3.4,2.6 -5.7,1.2 -5.1,3.5 2,4.1 0.3,3.9 1.8,6.7 1.4,1.4 -1,2.5 -7,1 -2.5,2.4 -3.1,0.5 -0.3,4.7 -6.3,2.5 -2.1,3.2 -4.4,1.7 -5.4,1 -8.9,4.7 -0.1,7.5 0,0.4 -0.1,1.2 20.3,15.5 18.4,13.9 18.6,13.8 1.3,3 3.4,1.8 2.6,1.1 0.1,4 6.1,-0.6 7.8,-2.8 15.8,-12.5 18.6,-12.2 -2.5,-4 -4.3,-2.9 -2.6,1.2 -2,-3.6 -0.2,-2.7 -3.4,-4.7 2.1,-2.6 -0.5,-4 0.6,-3.5 -0.5,-2.9 0.9,-5.2 -0.4,-3 -1.9,-5.6 -2.6,-11.3 -3.4,-2.6 0,-1.5 -4.5,-3.8 -0.6,-4.8 3.2,-3.6 1.1,-5.3 -1,-6.2 1,-3.3 z
4	290f878e-7aa3-4794-a762-4ba9fb903e62	1965c743-cf9a-4021-9ed1-b9e4e77486a2	m 985.4,301.7 0.1,-0.2 0.1,-0.2 0,-0.1 -0.2,-0.1 -0.7,-0.2 -0.3,-0.1 -0.2,0.1 -0.2,0.2 -0.1,0.3 0.1,0.1 0,0.2 0,0.2 0.1,0.2 0.2,0 0.2,0 0.3,-0.1 0.5,-0.3 0.1,0 z
5	3992b982-2f75-4c31-97c2-3b0959e51d37	bf07965f-f874-453e-a725-54c5a1254ee8	m 1068.3,609.6 -16.6,-0.1 -1.9,0.7 -1.7,-0.1 -2.3,0.9 -0.5,1.2 2.8,4 1.1,4.3 1.6,6.1 -1.7,2.6 -0.3,1.3 1.3,3.8 1.5,3.9 1.6,2.2 0.3,3.6 -0.7,4.8 -1.8,2.8 -3.3,4.2 -1.3,2.6 -1.9,5.7 -0.3,2.7 -2,5.9 -0.9,5.5 0.5,4 2.7,-1.2 3.3,-1 3.6,0.1 3.2,2.9 0.9,-0.4 22.5,-0.3 3.7,3 13.4,0.9 10.3,-2.5 -3.5,-4 -3.6,-5.2 0.8,-20.3 11.6,0.1 -0.5,-2.2 0.9,-2.4 -0.9,-3 0.7,-3 -0.5,-2 -2.6,-0.4 -3.5,1 -2.4,-0.2 -1.4,0.6 0.5,-7.6 -1.9,-2.3 -0.3,-4 0.9,-3.8 -1.2,-2.4 0,-4 -6.8,0 0.5,-2.3 -2.9,0 -0.3,1.1 -3.4,0.3 -1.5,3.7 -0.9,1.6 -3,-0.9 -1.9,0.9 -3.7,0.5 -2.1,-3.3 -1.3,-2.1 -1.6,-3.8 -1.3,-4.7 z m -21.8,-1.3 0.2,-2.7 0.9,-1.7 2,-1.3 -2,-2.2 -1.8,1.1 -2.2,2.7 1.4,4.8 1.5,-0.7 z
6	63de0a20-90a7-45f5-ac4c-a35f4270a83a	793360a3-aa91-4703-acfe-60287e3f9b74	m 627.9,456.2 0.1,-0.2 -0.2,-0.1 -0.8,0.5 0,0.1 0.9,-0.3 z
7	8f398793-99ed-494f-b8a6-dafd05e64407	90de1527-d5a5-446f-a960-eccda43af198	m 634.3,463.8 0.2,-0.1 0,-0.1 0,-0.2 -0.1,-0.1 -0.1,-0.2 -0.4,-0.2 -0.5,0.5 0,0.2 0.1,0.3 0.6,0.1 0.2,-0.2 z m 0.2,-3.5 0,-0.5 -0.1,-0.2 -0.3,0 -0.1,-0.1 -0.1,0 -0.1,0.1 0.1,0.6 0.5,0.3 0.1,-0.2 z
8	5bf1931c-1ff3-45a9-b38e-c9111a3d42ad	78219cc6-d1b2-4193-9da7-e7abc92863ee	m 669.8,920.7 0.9,-3 -7.3,-1.5 -7.7,-3.6 -4.3,-4.6 -3,-2.8 5.9,13.5 5,0 2.9,0.2 3.3,2.1 4.3,-0.3 z m -50.4,-208.1 -7.4,-1.5 -4,5.7 0.9,1.6 -1.1,6.6 -5.6,3.2 1.6,10.6 -0.9,2 2,2.5 -3.2,4 -2.6,5.9 -0.9,5.8 1.7,6.2 -2.1,6.5 4.9,10.9 1.6,1.2 1.3,5.9 -1.6,6.2 1.4,5.4 -2.9,4.3 1.5,5.9 3.3,6.3 -2.5,2.4 0.3,5.7 0.7,6.4 3.3,7.6 -1.6,1.2 3.6,7.1 3.1,2.3 -0.8,2.6 2.8,1.3 1.3,2.3 -1.8,1.1 1.8,3.7 1.1,8.2 -0.7,5.3 1.8,3.2 -0.1,3.9 -2.7,2.7 3.1,6.6 2.6,2.2 3.1,-0.4 1.8,4.6 3.5,3.6 12,0.8 4.8,0.9 2.2,0.4 -4.7,-3.6 -4.1,-6.3 0.9,-2.9 3.5,-2.5 0.5,-7.2 4.7,-3.5 -0.2,-5.6 -5.2,-1.3 -6.4,-4.5 -0.1,-4.7 2.9,-3.1 4.7,-0.1 0.2,-3.3 -1.2,-6.1 2.9,-3.9 4.1,-1.9 -2.5,-3.2 -2.2,2 -4,-1.9 -2.5,-6.2 1.5,-1.6 5.6,2.3 5,-0.9 2.5,-2.2 -1.8,-3.1 -0.1,-4.8 -2,-3.8 5.8,0.6 10.2,-1.3 6.9,-3.4 3.3,-8.3 -0.3,-3.2 -3.9,-2.8 -0.1,-4.5 -7.8,-5.5 -0.3,-3.3 -0.4,-4.2 0.9,-1.4 -1.1,-6.3 0.3,-6.5 0.5,-5.1 5.9,-8.6 5.3,-6.2 3.3,-2.6 4.2,-3.5 -0.5,-5.1 -3.1,-3.7 -2.6,1.2 -0.3,5.7 -4.3,4.8 -4.2,1.1 -6.2,-1 -5.7,-1.8 4.2,-9.6 -1.1,-2.8 -5.9,-2.5 -7.2,-4.7 -4.6,-1 -11.2,-10.4 -1,-1.3 -6.3,-0.3 -1.6,5.1 -3.7,-4.6 z
9	5c86e876-91fb-4233-8177-4c3af1ef612f	f2f3e704-bb03-467a-a1a0-1d56b6faadce	m 1219,325.1 -0.9,-4.4 -2.5,-1.1 -2.5,-1.7 1,-2 -3.1,-2.2 0.7,-1.5 -2.2,-1.1 -1.4,-1.7 -6.9,1 1.3,2.2 0,3.1 4.2,1.5 2.4,1.9 1,-0.2 1.8,1.7 2.3,0 0.2,1 2.8,3.7 1.8,-0.2 z
10	dc4231f1-79a7-44d0-8557-8aa6d9caf0f1	0a3e548d-7e30-426f-840c-07ff9b6772f7	m 1726.7,832 -3,-0.5 -1.9,2.9 -0.6,5.4 -2.1,4 -0.5,5.3 3,0.2 0.8,0.3 6.6,-4.3 0.6,1.7 4,-4.9 3.2,-2.2 4.5,-7.3 -2.8,-0.5 -4.8,1.2 -3.4,0.9 -3.6,-2.2 z m 50.1,-172.3 0.5,-2.3 0.1,-3.6 -1.6,-3.2 0.1,-2.7 -1.3,-0.8 0.1,-3.9 -1.2,-3.2 -2.3,2.4 -0.4,1.8 -1.5,3.5 -1.8,3.4 0.6,2.1 -1.2,1.3 -1.5,4.8 0.1,3.7 -0.7,1.8 0.3,3.1 -2.6,5 -1.3,3.5 -1.7,2.9 -1.7,3.4 -4.1,2.1 -4.9,-2.1 -0.5,-2 -2.5,-1.6 -1.6,0 -3.3,-3.8 -2.5,-2.2 -3.9,-2 -3.9,-3.5 -0.1,-1.8 2.5,-3.1 2.1,-3.2 -0.3,-2.6 1.9,-0.2 2.5,-2.5 2,-3.4 -2.2,-3.2 -1.5,1.2 -2,-0.5 -3.5,1.8 -3.2,-2 -1.7,0.7 -4.5,-1.6 -2.7,-2.7 -3.5,-1.5 -3.1,0.9 3.9,2.1 -0.3,3.2 -4.8,1.2 -2.8,-0.7 -3.6,2.2 -2.9,3.7 0.6,1.5 -2.7,1.7 -3.4,5.1 0.6,3.5 -3.4,-0.6 -3.5,0 -2.5,-3.8 -3.7,-2.9 -2.8,0.8 -2.6,0.9 -0.3,1.6 -2.4,-0.7 -0.3,1.8 -3,1.1 -1.7,2.5 -3.5,3.1 -1.4,4.8 -2.3,-1.3 -2.2,3.1 1.5,3 -2.6,1.2 -1.4,-5.5 -4.8,5.4 -0.8,3.5 -0.7,2.5 -3.8,3.3 -2,3.4 -3.5,2.8 -6.1,1.9 -3.1,-0.2 -1.5,0.6 -1.1,1.4 -3.5,0.7 -4.7,2.4 -1.4,-0.8 -2.6,0.5 -4.6,2.3 -3.2,2.7 -4.8,2.1 -3.1,4.4 0.4,-4.8 -3.1,4.6 -0.1,3.7 -1.3,3.2 -1.5,1.5 -1.3,3.7 0.9,1.9 0.1,2 1.6,5 -0.7,3.3 -1,-2.5 -2.3,-1.8 0.4,5.9 -1.7,-2.8 0.1,2.8 1.8,5 -0.6,5 1.7,2.5 -0.4,1.9 0.9,4.1 -1.3,3.6 -0.3,3.6 0.7,6.5 -0.7,3.7 -2.2,4.4 -0.6,2.3 -1.5,1.5 -2.9,0.8 -1.5,3.7 2.4,1.2 4,4.1 3.6,0 3.8,0.3 3.3,-2.1 3.4,-1.8 1.4,0.3 4.5,-3.4 3.8,-0.3 4.1,-0.7 4.2,1.2 3.6,-0.6 4.6,-0.2 3,-2.6 2.3,-3.3 5.2,-1.5 6.9,-3.2 5,0.4 6.9,-2.1 7.8,-2.3 9.8,-0.6 4,3.1 3.7,0.2 5.3,3.8 -1.6,1.5 1.8,2.4 1.3,4.6 -1.6,3.4 2.9,2.6 4.3,-5.1 4.3,-2.1 6.7,-5.5 -1.6,4.7 -3.4,3.2 -2.5,3.7 -4.4,3.5 5.2,-1.2 4.7,-4.4 -0.9,4.8 -3.2,3.1 4.7,0.8 1.3,2.6 -0.4,3.3 -1.5,4.9 1.4,4 4,1.9 2.8,0.4 2.4,1 3.5,1.8 7.2,-4.7 3.5,-1.2 -2.7,3.4 2.6,1.1 2.7,2.8 4.7,-2.7 3.8,-2.5 6.3,-2.7 6,-0.2 4.2,-2.3 0.9,-2 3,-4.5 3.9,-4.8 3.6,-3.2 4.4,-5.6 3.3,-3.1 4.4,-5 5.4,-3.1 5,-5.8 3.1,-4.5 1.4,-3.6 3.8,-5.7 2.1,-2.9 2.5,-5.7 -0.7,-5.4 1.7,-3.9 1.1,-3.7 0,-5.1 -2.8,-5.1 -1.9,-2.5 -2.9,-3.9 0.7,-6.7 -1.5,1 -1.6,-2.8 -2.5,1.4 -0.6,-6.9 -2.2,-4 1,-1.5 -3.1,-2.8 -3.2,-3 -5.3,-3.3 -0.9,-4.3 1.3,-3.3 -0.4,-5.5 -1.3,-0.7 -0.2,-3.2 -0.2,-5.5 1.1,-2.8 -2.3,-2.5 -1.4,-2.7 -3.9,2.4 -1.2,-5 z
11	04fbc0b9-84d3-4248-b45d-4c708b903cdf	e14f7607-8074-4eeb-8b3f-3093575719a4	m 1060.2,264 -2.3,-1.2 -2.3,0.3 -4,-1.9 -1.7,0.5 -2.6,2.5 -3.8,-2 -1.5,2.9 -1.7,0.8 1,4 -0.4,1.1 -1.7,-1.3 -2.4,-0.2 -3.4,1.2 -4.4,-0.3 -0.6,1.6 -2.6,-1.7 -1.5,0.3 0.2,1.1 -0.7,1.6 2.3,1.1 2.6,0.2 3.1,0.9 0.5,-1.2 4.8,-1.1 1.3,2.2 7.2,1.6 4.2,0.4 2.4,-1.4 4.3,-0.1 0.9,-1.1 1.3,-4 -1.1,-1.3 2.8,0 0.2,-2.6 -0.7,-2.1 0.3,-0.8 z
12	fad59fba-d0e5-4341-b728-3a94d92ef2d1	319530a8-8cd2-4dc3-84a6-29ac720c51da	m 1210.1,318.9 -1,0.2 1.2,2.4 3.2,2.9 3.7,0.9 -2.8,-3.7 -0.2,-1 -2.3,0 -1.8,-1.7 z m 10.4,-9.3 -4.3,-3.8 -1.5,-0.2 -1.1,0.9 3.2,3.4 -0.6,0.7 -2.8,-0.4 -4.2,-1.8 -1.1,1 1.4,1.7 2.2,1.1 -0.7,1.5 3.1,2.2 -1,2 2.5,1.7 2.5,1.1 0.9,4.4 5.3,-4.7 1.9,-0.5 1.9,1.9 -1.2,3.1 3.8,3.4 1.3,-0.3 -0.8,-3.2 1.7,-1.5 0.4,-2.2 -0.1,-5 4.2,-0.5 -2,-1.7 -2.5,-0.2 -3.5,-4.5 -3.4,-3.2 0,0 -2.6,2.5 -0.5,1.5 -2.4,-0.4 z
13	e8561dbe-f1d3-4e1a-b94c-5b2b3c0ed0e4	ac6434f1-bbb9-4242-a393-d78d367f034a	m 574.4,437.3 0.2,-0.6 -0.3,-0.1 -0.5,0.7 -0.6,0.3 -0.3,0 -0.7,-0.3 -0.5,0 -0.4,0.5 -0.6,0.1 0.1,0.1 0,0.2 -0.2,0.3 0,0.2 0.1,0.3 1.5,-0.1 1.3,-0.2 0.7,-0.9 0.2,-0.5 z m 0.8,-2 -0.4,-0.3 -0.4,0.3 0.1,0.3 0.7,-0.3 z m 0,-5.8 -0.4,-0.2 -0.3,0.5 0.3,0.1 0.7,-0.1 0.5,0.1 0.5,0.4 0.3,-0.2 -0.1,-0.1 -0.4,-0.3 -0.6,-0.1 -0.2,0 -0.3,-0.1 z m -6.6,1.3 0.7,-0.6 0.7,-0.3 0.9,-1.1 -0.1,-0.9 0.2,-0.4 -0.6,0.1 -0.1,0.3 -0.1,0.3 0.3,0.4 0,0.2 -0.2,0.4 -0.3,0.1 -0.1,0.2 -0.3,0.1 -0.4,0.5 -0.8,0.6 -0.2,0.3 0.4,-0.2 z m 1.2,-3.2 -0.6,-0.2 -0.2,-0.4 -0.4,-0.1 -0.1,0.2 0,0.2 0.1,0.4 0.2,-0.1 0.8,0.4 0.4,-0.3 -0.2,-0.1 z m -4.1,-1.1 0,-0.7 -0.4,-0.5 -0.6,-0.4 -0.1,-1.2 -0.3,-0.7 -0.2,-0.6 -0.4,-0.8 0,0.5 0.1,0.1 0.1,0.6 0.4,0.9 0.1,0.4 -0.1,0.4 -0.4,0.1 -0.1,0.2 0.5,0.3 0.8,0.3 0.5,1.3 0.1,-0.2 z m -4.1,-3.5 -0.5,-0.3 -0.2,-0.3 -0.7,-0.7 -0.3,-0.1 -0.2,0.4 0.4,0.1 0.9,0.7 0.4,0.2 0.2,0 z m 7.3,-4 -0.1,-0.3 -0.1,0 -0.3,0.1 -0.3,0.9 0.3,0 0.5,-0.7 z m -17.6,-1.1 -0.2,-0.3 -0.3,0.2 -0.5,0 -0.2,0.1 -0.4,0 -0.3,0.2 0.4,0.8 0.3,0.3 0.1,1 0.2,0.1 -0.1,0.7 1.1,0.1 0.4,-0.8 0,-0.3 0,-0.1 0,-0.2 0,-0.2 0,-0.9 -0.3,-0.5 -0.4,0.6 -0.4,-0.3 0.6,-0.4 0,-0.1 z m 12.9,0.3 -1,-1.4 0,-0.2 -0.5,-1.5 -0.3,-0.1 -0.1,0.1 -0.1,0.2 0.4,0.4 0,0.4 0.3,0.2 0.4,1.1 0.4,0.4 -0.1,0.3 -0.4,0.3 -0.1,0.2 0.1,0 0.6,-0.1 0.4,0 0,-0.3 z m -10.5,-5.2 0.5,-0.2 0,0 -0.3,-0.2 -0.7,0 -0.4,0.1 -0.2,0.2 0.1,0.1 0.4,0.1 0.6,-0.1 z m -2.4,2 -0.5,-0.6 -0.3,-0.9 -0.2,-0.4 0.1,-0.5 -0.3,-0.4 -0.6,-0.4 -0.3,0.1 0.1,1.1 -0.2,0.6 -0.8,1.1 0.1,0.4 0,0 0.1,0.2 -0.5,0.4 0,-0.3 -0.6,0.1 0.3,0.5 0.6,0.4 0.3,0.1 0.3,-0.2 0,0.5 0.3,0.4 0.1,0.4 0.3,-0.3 0.6,-0.2 0.2,-0.2 0.7,-0.4 0,-0.2 0.1,-0.6 0.1,-0.7 z m 6.7,-5 -0.3,-0.5 -0.1,0.1 -0.1,0.4 -0.3,0.4 0.5,-0.1 0.4,0.1 0.6,0.5 0.7,0.2 0.3,0.6 0.6,0.6 0,0.6 -0.4,0.6 -0.1,0.7 -0.6,0.1 0.1,0.1 0.3,0.3 0.1,0.4 0.2,0.2 0,-0.7 0.3,-0.8 0.4,-1.3 -0.1,-0.3 -0.3,-0.3 -0.7,-0.9 -0.7,-0.3 -0.8,-0.7 z m -8.8,-7.9 -0.5,-0.4 -0.2,0.4 0,0.1 -0.1,0.3 -0.5,0.4 -0.5,0.1 -0.7,-0.6 -0.2,-0.1 0.8,1.1 0.3,0.1 0.4,0 0.9,-0.3 1.6,-0.5 1.7,-0.2 0.1,-0.2 -0.1,-0.3 -0.8,0.2 -1,-0.1 -0.2,0.2 -0.4,0 -0.6,-0.2 z m 6.1,5.2 0.2,-0.3 0.4,-1.8 0.8,-0.6 0.1,-1.2 -0.5,-0.5 -0.4,-0.2 -0.1,-0.2 0.1,-0.2 -0.2,-0.1 -0.3,-0.2 -0.4,-0.6 -0.4,-0.4 -0.7,-0.1 -0.6,-0.1 -0.4,-0.1 -0.5,0.3 0.8,0 1.5,0.3 0.7,1.5 0.5,0.4 0.1,0.4 -0.2,0.4 0,0.4 -0.3,0.5 -0.1,0.8 -0.3,0.4 -0.7,0.5 0.4,0.2 0.3,0.6 0.2,-0.1 z
44	da04bc7f-d947-4475-a917-a306014f04bc	0b48c87c-ddaa-49d2-b736-61d9c44636e0	m 1217.8,499.2 -2.5,-1.7 3.1,-1.5 0.1,-2.7 -1.4,-1.9 -1.6,1.5 -2.4,-0.5 -1.9,2.8 -1.8,3 0.5,1.7 0.2,2 3.1,0.1 1.3,-0.5 1.3,1.1 2,-3.4 z
14	bbec18dc-74ab-4f0a-b76a-8d6f45dbef92	bb3fa754-b35e-45ee-8d66-fb159c96d821	m 1486.5,431.9 -4.5,-10.1 -1.5,0.1 -0.2,4 -3.5,-3.3 1.1,-3.6 2.4,-0.4 1.6,-5.3 -3.4,-1.1 -5,0.1 -5.4,-0.9 -1.2,-4.4 -2.7,-0.4 -4.8,-2.7 -1.2,4.3 4.6,3.4 -3.1,2.4 -0.8,2.3 3.7,1.7 -0.4,3.8 2.6,4.8 1.6,5.2 2.2,0.6 1.7,0.7 0.6,-1.2 2.5,1.3 1.3,-3.5 -0.9,-2.6 5.1,0.2 2.8,3.7 1.5,3.1 0.8,3.2 2,3.3 -1.1,-5.1 2.1,1 -0.5,-4.6 z
15	68f5e4de-a112-46db-b0fa-d130467224c6	49494a5b-205f-4756-9145-2784c9269a99	m 644.9,488.9 0.4,-0.4 -0.3,-0.3 -0.6,-0.8 -0.3,0.1 0,1 0.1,0.3 0.5,0.3 0.2,-0.2 z
16	27c68363-bf22-4d1d-8a2c-3ecb3b281642	ac612169-1567-4c5e-a203-3987fa26c267	m 1112.8,219.4 -5.2,-1.5 -4.6,2.3 -2.6,1 0.9,2.6 -3.5,2 -0.5,3.4 -4.8,2.2 -4.6,0 0.6,2.7 1.7,2.3 0.3,2.4 -2.7,1.2 1.9,2.9 0.5,2.7 2.2,-0.3 2.4,-1.6 3.7,-0.2 5,0.5 5.6,1.5 3.8,0.1 2,0.9 1.6,-1.1 1.5,1.5 4.3,-0.3 2,0.6 -0.2,-3.1 1.2,-1.4 4.1,-0.3 0,0 -2,-3.9 -1.5,-2 0.8,-0.6 3.9,0.2 1.6,-1.3 -1.7,-1.6 -3.4,-1.1 0.1,-1.1 -2.2,-1.1 -3.7,-3.9 0.6,-1.6 -1,-2.9 -4.8,-1.4 -2.3,0.7 -1,-1.4 z
17	57f5ae19-bc0e-4a62-950b-19c26ff53f1f	1f4dd261-dc57-49ec-b872-8b1917703616	m 1000.7,246.2 -4.4,1.3 -3.6,-0.5 0,0 -3.8,1.2 0.7,2.2 2.2,0.1 2.4,2.4 3.4,2.9 2.5,-0.4 4.4,2.8 0.4,-3.5 1.3,-0.2 0.4,-4.2 -2.8,-1.4 -3.1,-2.7 z
18	d2b654fe-248e-499b-8d28-b03815ed5ca1	3e62d48d-717d-4421-91c2-abb059a80576	m 482.5,471.1 1.4,-2.2 1,-0.2 1.3,-1.7 1,-3.2 -0.3,-0.6 0.9,-2.3 -0.4,-1 1.3,-2.7 0.3,-1.8 -1.1,0 0.1,-0.9 -1,0 -2.5,3.9 -0.9,-0.8 -0.7,0.3 -0.1,1 -0.7,5 -1.2,7.2 1.6,0 z
19	f9aa6ed6-64c4-4e7d-99a5-1b1bfb547dc9	5fbebc32-e410-4faa-94e5-822252f8b499	m 996.9,498 -4.3,-3.7 -2,0 -1.9,1.9 -1.2,1.9 -2.7,0.6 -1.2,2.8 -1.9,0.7 -0.7,3.3 1.7,1.9 2,2.3 0.2,3.1 1.1,1.3 -0.2,14.6 1.4,4.4 4.6,-0.8 0.3,-10.2 -0.1,-4.1 1,-4 1.7,-1.9 2.7,-4 -0.6,-1.7 1.1,-2.5 -1.2,-3.8 0.2,-2.1 z
20	6d722273-3cfa-4dfd-8436-9c2f2942daea	1d58bd18-8519-4e53-8cd1-6a7e93cda614	m 1474.7,395.5 -2.7,-1.8 -2.9,-0.1 -4.2,-1.5 -2.6,1.6 -2.6,4.8 0.3,1.2 5.5,2.5 3.2,-1 4.7,0.4 4.4,-0.2 -0.4,-3.9 -2.7,-2 z
21	b0c47e57-30b3-4af5-ac18-eb23e580d4f1	546440bf-236c-4f99-bd12-3bba52d50e02	m 655.7,700.5 1.6,-1.3 -0.8,-3.6 1.3,-2.8 0.5,-5 -1.6,-4 -3.2,-1.7 -0.8,-2.6 0.6,-3.6 -10.7,-0.3 -2.7,-7.4 1.6,-0.1 -0.3,-2.8 -1.2,-1.8 -0.5,-3.7 -3.3,-1.9 -3.5,0.1 -2.5,-1.9 -3.8,-1.2 -2.4,-2.4 -6.3,-1 -6.4,-5.7 0.3,-4.3 -0.9,-2.5 0.4,-4.7 -7.3,1.1 -2.8,2.3 -4.8,2.6 -1.1,1.9 -2.9,0.2 -4.2,-0.6 5.5,10.3 -1.1,2.1 0.1,4.5 0.3,5.4 -1.9,3.2 1.2,2.4 -1.1,2.1 2.8,5.3 -2.8,6.9 3.1,4.3 1.2,4.6 3.2,2.7 -1.1,6.2 3.7,7.1 3.1,8.8 3.8,-0.9 4,-5.7 7.4,1.5 3.7,4.6 1.6,-5.1 6.3,0.3 1,1.3 1.5,-7.6 -0.2,-3.4 2.1,-5.6 9.5,-1.9 5.1,0.1 5.4,3.3 0.3,1.9 z
22	e4f82956-d0b8-4ab7-8c0c-afce1d49747b	c103dabb-a386-4a6a-bce5-c0c0fa5f43f6	m 1062.2,284.9 -2.3,0.1 -1,1.3 -1.9,-1.4 -0.9,2.5 2.7,2.9 1.3,1.9 2.5,2.3 2,1.4 2.2,2.5 4.7,2.4 0.4,-3.4 1.5,-1.4 0.9,-0.6 1.2,-0.3 0.5,-2.9 -2.7,-2.3 1,-2.7 -1.8,0 0,0 -2.4,-1.4 -3.5,0.1 -4.4,-1 z
23	6b68e101-0fa8-4ef6-8f33-d4c21093718a	ff4c5033-aee4-4325-90cc-1f96ef10bbce	m 1116.7,685 -1,-0.5 -3.2,1.5 -1.6,0 -3.7,2.5 -2,-2.6 -8.6,2.2 -4.1,0.2 -0.9,22.7 -5.4,0.2 -0.6,18.5 1.4,1 3,6.1 -0.7,3.8 1.1,2.3 4,-0.7 2.8,-2.8 2.7,-1.9 1.5,-3.1 2.7,-1.5 2.3,0.8 2.5,1.8 4.4,0.3 3.6,-1.5 0.6,-2 1.2,-3 3,-0.5 1.7,-2.4 2,-4.3 5.2,-4.7 8,-4.7 -3.4,-2.9 -4.2,-0.9 -1.5,-4.1 0.1,-2.2 -2.3,-0.7 -6,-7 -1.6,-3.7 -1.1,-1.1 -1.9,-5.1 z
24	3dc54d56-4d38-4cbd-a03a-729568601d10	1b558876-4f84-41fb-8215-93143842ba53	m 659,560.1 -1.4,0.2 -3.1,-0.5 -1.8,1.7 -2.6,1.1 -1.7,0.2 -0.7,1.3 -2.7,-0.3 -3.5,-3 -0.3,-2.9 -1.4,-3.3 1,-5.4 1.6,-2.2 -1.2,-3 -1.9,-0.9 0.8,-2.8 -1.3,-1.5 -2.9,0.3 0.7,1.8 -2.1,2.4 -6.4,2.4 -4,1 -1.7,1.5 -4.4,-1.6 -4.2,-0.8 -1,0.6 2.4,1.6 -0.3,4.3 0.7,4 4.8,0.5 0.3,1.4 -4.1,1.8 -0.7,2.7 -2.3,1 -4.2,1.5 -1.1,1.9 -4.4,0.5 -3,-3.4 -1.1,0.8 -1,-3.8 -1.6,-2 -1.9,2.2 -10.9,-0.1 0,3.9 3.3,0.7 -0.2,2.4 -1.1,-0.6 -3.2,1 0,4.6 2.5,2.4 0.9,3.6 -0.1,2.8 -2.2,17.4 -5.1,-0.3 -0.7,1 -4.6,1.2 -6.2,4.3 -0.4,3 -1.3,2.2 0.7,3.4 -3.3,1.9 0.1,2.7 -1.5,1.1 2.6,5.8 3.3,3.8 -1,2.8 3.7,0.3 2.3,3.4 4.9,0.2 4.4,-3.8 0.2,9.7 2.6,0.7 3,-1.1 4.2,0.6 2.9,-0.2 1.1,-1.9 4.8,-2.6 2.8,-2.3 7.3,-1.1 -0.4,4.7 0.9,2.5 -0.3,4.3 6.4,5.7 6.3,1 2.4,2.4 3.8,1.2 2.5,1.9 3.5,-0.1 3.3,1.9 0.5,3.7 1.2,1.8 0.3,2.8 -1.6,0.1 2.7,7.4 10.7,0.3 -0.6,3.6 0.8,2.6 3.2,1.7 1.6,4 -0.5,5 -1.3,2.8 0.8,3.6 -1.6,1.3 1.9,3.6 0.4,8.6 6,1.2 2.1,-1.2 3.9,1.7 1.2,1.9 1,5.8 0.9,2.5 2,0.3 2,-1.1 2.1,1.2 0.3,3.5 -0.3,3.8 -0.7,3.6 2.6,-1.2 3.1,3.7 0.5,5.1 -4.2,3.5 -3.3,2.6 -5.3,6.2 -5.9,8.6 3.4,-0.7 6.2,4.9 1.9,-0.2 6.2,4.1 4.8,3.5 3.8,4.3 -1.9,3 2.1,3.7 2.9,-3.7 1.5,-6 3.2,-3 3.9,-5 4.5,-11.2 3.4,-3.5 0.8,-3.1 0.3,-6.4 -1.3,-3.5 0.3,-4.8 4.1,-6.3 6,-5.1 6,-1.8 3.6,-2.9 8.5,-2.4 5.9,0 1.1,-3.8 4.2,-2.8 0.6,-6.5 5.1,-8.3 0.5,-8.5 1.6,-2.6 0.3,-4.1 1.1,-9.9 -1,-11.9 1.4,-4.7 1.4,-0.1 3.9,-5.5 3.3,-7.2 7.7,-8.8 2.7,-4.2 2,-10.5 -1,-3.9 -2,-8.1 -2.1,-2 -4.8,-0.2 -4.3,-1.9 -7.3,-7.1 -8.4,-5.3 -8.4,0.3 -10.9,-3.4 -6.5,2 0.8,-3.5 -2.7,-3.8 -9.4,-3.8 -7.1,-2.3 -4.2,4.1 -0.3,-6.3 -9.9,-1 -1.7,-2 4.2,-5.2 -0.1,-4.4 -3,-1 -3,-11.2 -1.3,-3.5 -1.9,0.3 -3.5,5.8 -1.8,4.7 -2.1,2.4 -2.7,0.5 -0.8,-1.8 -1.2,-0.3 -1.8,1.8 -2.4,-1.3 -3.2,-1.4 -2.7,0.7 -2.3,-0.6 -0.5,1.8 0.9,1.3 -0.5,1.3 -3.1,-0.5 z
25	7aed4496-ade5-4d53-b6fc-b499ed86a45f	dde93861-da65-40d4-8159-3e67e8d58e02	m 1121.6,294.3 -3,-0.7 -4,-2.2 -5.8,1.4 -2.3,1.6 -7.5,-0.3 -4,-1 -1.9,0.5 -1.8,-2.6 -1.1,1.4 0.7,2.3 2.8,2.6 -1.7,1.9 -0.7,2 0.6,0.7 -0.7,0.9 2.8,2 0.8,4.1 3.8,0.2 3.9,-1.7 3.9,2.1 4.6,-0.6 -0.3,-3 5,-2 4.5,0.8 -2.1,-3.5 1.3,-4.4 2.2,-2.5 z
26	0ab17fe4-81ef-4288-8e46-6790615cb877	a22c7473-248e-4447-8bc7-1fc51c00ca3e	m 978.8,477.2 -3.6,0 -1.4,-1.2 -3,0.9 -5.2,2.6 -1.1,2 -4.3,2.9 -0.8,1.6 -2.3,1.3 -2.7,-0.9 -1.6,1.6 -0.8,4.4 -4.5,5.2 0.2,2.2 -1.6,2.7 0.4,3.7 2.5,1.4 1,2.1 2.5,1.3 1.9,-1.6 2.7,-0.2 3.8,1.6 -0.8,-4.8 0.2,-3.6 9.7,-0.3 2.4,0.5 1.8,-1 2.6,0.5 4.9,0.1 1.9,-0.7 1.2,-2.8 2.7,-0.6 1.2,-1.9 0.1,-4.4 -6.4,-1.4 -0.2,-3.1 -3.1,-4.1 -0.8,-2.9 0.5,-3.1 z
27	00d31483-3064-418f-abf4-81eecbb6ef41	4f0fe689-81e0-4b91-a093-cad33a305482	m 1148.2,590 -0.3,-2.5 0,0 -3,-0.4 -1.7,3.6 -3.5,-0.5 1.4,2.9 0.1,1.1 2,6.1 -0.1,0.3 0.6,-0.1 2.1,-2.3 2.2,-3.3 1.4,-1.4 0,-2 -1.2,-1.5 z
28	e986e333-2f29-4abf-ba73-01975e9357aa	723de35c-616a-4b10-b479-c08378f3765b	m 1574.8,481.8 -5.2,-2.3 -2,4.3 -4.9,-2.4 -5.3,-1 -7.1,1.3 -3,5.2 2.1,7.7 3.4,6.6 2.6,3.3 4.7,0.9 4.7,-2.5 5.8,-0.5 -2.8,-3.8 8.9,-4.9 -0.1,-7.7 -1.8,-4.2 z
29	5a53a786-f37f-4aa6-8068-a267db13ca13	526f75ae-3c43-45a3-924e-1d7e11177a68	m 1060.1,502.9 0.2,-4.3 -0.5,-4.2 -2.2,-4.1 -1.6,0.4 -0.2,2 2.3,2.6 -0.6,1.1 -0.3,2.1 -4.6,5 -1.5,4 -0.7,3.3 -1.2,1.4 -1.1,4.5 -3,2.6 -0.8,3.2 -1.2,2.6 -0.5,2.6 -3.9,2.2 -3.2,-2.6 -2.1,0.1 -3.3,3.7 -1.6,0.1 -2.7,6.1 -1.4,4.5 0,1.8 1.4,0.9 1.1,2.8 2.6,1.1 2.2,4.2 -0.8,5 9.2,0.2 2.6,-0.4 3.4,0.8 3.4,-0.8 0.7,0.3 7.1,0.3 4.5,1.7 4.5,1.5 0.4,-3.5 -0.6,-1.8 -0.3,-2.9 -2.6,-2.1 -2.1,-3.2 -0.5,-2.3 -2.6,-3.3 0.4,-1.9 -0.6,-2.7 0.4,-5 1.4,-1.1 2.7,-6.5 0.9,-1.7 -1.8,-4.4 -0.8,-2.6 -2.5,-1.1 -3.3,-3.7 1.2,-3 2.5,0.6 1.6,-0.4 3.1,0.1 -3.1,-5.8 z
30	6cb48d99-4896-4346-8720-65c09e566f2b	e242cbe2-dc75-4807-a7c9-c171d164ec2d	m 659,276.7 -0.7,-3 -2.5,1.9 0.5,2.1 5.6,2.6 1.9,-0.4 3.3,-2.5 -4.7,0.1 -3.4,-0.8 z m 14.4,-15.9 0.2,-1.1 -4.1,-2.6 -5.9,-1.6 -1.9,0.6 3.5,2.9 5.7,1.9 2.5,-0.1 z m -305.3,3.7 0.2,-3.4 -3.2,-2.6 -0.4,-2.9 -0.1,-2.1 -4.1,-0.7 -2.4,-0.9 -4.1,-1.4 -1.4,1.5 -0.6,3.3 4.3,1.1 -0.4,1.8 2.9,2.2 0,2.2 6.3,2.8 3,-0.9 z m 336.1,-13.5 3.9,-3.8 1.4,-1.7 -2.1,-0.3 -4.9,2.2 -4.2,3.5 -8.1,9.8 -5.3,3.7 1.6,1.7 -3.8,2.2 0.2,1.9 9.6,0.1 5.4,-0.3 4.4,1.5 -4.4,2.9 2.9,0.2 7.3,-5.4 1.2,0.8 -2.5,5.1 3,1.2 2.3,-0.2 3.5,-5.5 -0.5,-3.9 0.3,-3.3 -3.7,1.1 2.8,-4.6 -4.3,-1.9 -2.7,1.5 -3.9,-1.7 2.4,-2.1 -2.9,-1.3 -3.8,2 4.9,-5.4 z m -356.8,-21.2 -1.9,2 -1.4,2.6 0.9,1.9 -0.6,2.8 0.7,2.8 1.9,0 -0.2,-4.9 7.1,-6.9 -4.9,0.5 -1.6,-0.8 z m 280.9,-47 -0.4,-1.2 -1.7,-0.1 -2.8,1.7 -0.4,0.4 0.1,1.7 1.7,0.5 3.5,-3 z m -9.6,-3.2 0.8,-1.1 -6,-0.1 -4.9,2.7 0,1.5 3,0.2 7.1,-3.2 z m -3.1,-16.6 -2.7,-0.5 -5,5.2 -3.6,4.4 -5.7,2.8 6.3,-0.6 -0.8,3.4 8.2,-3 6.2,-3 0.8,2.6 5.9,1.3 4.9,-1.8 -1.9,-1.8 -3.4,0.4 1.3,-2.7 -3.7,-1.7 -3.4,-1.9 -1.5,-1.5 -2.8,0.9 0.9,-2.5 z m 44.6,-8.2 3.7,-1.7 1,-0.7 1.4,-2.3 -2.3,-1.5 -4.2,0.7 -3.8,3.1 -0.7,2.6 4.9,-0.2 z m -73.8,-10.7 -0.8,-2 -0.3,-1 -1.6,-1 -3,-1.5 -4.9,2.3 -5,1.7 3.5,2.4 3.8,-0.6 4.1,1.6 4.2,-1.9 z m 22.4,-2.1 -6.6,-1 5.7,-2.6 -0.4,-6 -1.9,-2.3 -4.5,-0.8 -8.1,3.8 -5.5,5.8 2.9,2.1 1.6,3.3 -6.3,5.5 -3.2,-0.2 -6.2,4.4 4.2,-5.2 -4.8,-1.8 -4.5,0.9 -2.4,3.4 -5.9,-0.1 -7.2,0.8 -5.1,-2.4 -5,0.4 -1.5,-2.9 -2.1,-1.3 -3.8,0.5 -5.2,0.3 -4.4,1.8 2,2.3 -7,2.8 -1.4,-3.3 -4.4,1 -11.8,0.6 -6.4,-1.2 8.5,-2.6 -2.8,-2.8 -4.4,0.4 -4.7,-1 -7.5,-1.9 -3.8,-2.3 -4.5,-0.3 -3.3,1.6 -5.9,0.9 3.9,-4.1 -9.4,3.6 -1.4,-4.7 -2.1,-0.6 -3.8,2.5 -4.5,1.2 -0.2,-2.2 -8.2,1.4 -8.8,2.3 -5.2,-0.6 -7,1.6 -6.2,2.3 -3.7,-0.5 -3.3,-2.6 -5.9,-1.3 0,0 -24.3,20.2 -35.4,32.4 4.2,0.1 2.7,1.6 0.6,2.6 0.2,3.9 7.6,-3.3 6.4,-1.9 -0.5,3 0.7,2.4 1.7,2.7 -1.1,4.2 -1.5,6.8 4.6,3.8 -3.1,3.7 -5.1,2.9 0,0 -2.5,3.1 2.1,4.4 -3.1,4.9 4.1,2.6 -3.6,3.7 -1.3,5.5 6.9,2.5 1.6,2.7 5.4,6.1 0.7,0 13.9,0 14.6,0 4.8,0 15,0 14.5,0 14.7,0 14.8,0 16.7,0 16.8,0 10.1,0 1.3,-2.4 1.6,0 -0.8,3.4 1,1 3.2,0.4 4.6,1 3.8,1.9 4.4,-0.8 5.3,1.6 0,0 3.2,-2.4 3.2,-1 1.8,-1.5 1.5,-0.8 4,1.2 3.3,0.2 0.8,0.8 0.1,3.5 5.2,1 -1.7,1.7 1.2,1.9 -1.9,2.3 1.8,0.8 -1.9,2.1 0,0 1.2,0.2 1.3,-0.9 0.5,1.4 3.4,0.7 3.8,0.1 3.8,0.6 4,1.2 0.8,2 1.4,4.7 -2.4,2 -3.8,-0.8 -1,-3.8 -0.9,3.9 -3.8,3.4 -0.8,2.9 -1.1,1.7 -4.1,2 0,0 -3.7,3.4 -2,2.2 2.7,0.4 4.5,-2 2.9,-1.7 1.6,-0.3 2.6,0.6 1.7,-0.9 2.8,-0.8 4.7,-0.8 0,0 0,0 0.3,-1.8 -0.3,0.1 -1.7,0.3 -1.8,-0.6 2.3,-2.1 1.9,-0.7 3.9,-0.9 4.6,-0.9 1.8,1.2 1.9,-1.4 1.9,-0.8 0.9,0.4 0.1,0.1 6.7,-4.2 2.7,-1.2 7.7,0 9.3,0 1,-1.6 1.7,-0.3 2.5,-0.9 2.7,-2.8 3.2,-4.9 5.5,-4.7 1.1,1.7 3.7,-1.1 1.5,1.8 -2.8,8.5 2.1,3.5 5.9,-0.8 8.1,-0.2 -10.4,5.1 -1.5,5.2 3.7,0.5 7.1,-4.5 5.8,-2.4 12.2,-3.7 7.5,-4.1 -2.6,-2.2 1,-4.5 -7.1,7 -8.6,0.8 -5.5,-3.1 -0.1,-4.6 0.6,-6.8 6.1,-4.1 -3.3,-3.1 -7.6,0.6 -12.1,5.2 -10.9,8.2 -4.6,1 7.8,-5.7 10.1,-8.3 7.2,-2.7 5.7,-4.4 5.2,-0.5 7.3,0.1 10,1.3 8.6,-1 7.8,-5.1 8.7,-2.2 4.2,-2.1 4.2,-2.3 2,-6.8 -1.1,-2.3 -3.4,-0.8 0,-5.1 -2.3,-1.9 -6.9,-1.6 -2.8,-3.4 -4.8,-3.4 3.4,-3.7 -2,-7.1 -2.6,-7.5 -1,-5.2 -4.3,2.7 -7.4,6.5 -8.1,3.2 -1.6,-3.4 -3.7,-1 2.2,-7.3 2.6,-4.9 -7.7,-0.5 -0.1,-2.2 -3.6,-3.3 -3,-2 -4.5,1.5 -4.2,-0.5 -6.6,-1.6 -3.9,1.3 -3.8,9 -1,5.3 -8.8,6.1 3.1,4.5 0.5,5 -1.7,4 -4.7,4.1 -7.5,4.2 -9,2.8 1.7,3.2 -2.2,9.6 -5.6,6.3 -4.6,1.9 -4.4,-5.8 -0.1,-6.8 1.7,-6 3.6,-5.2 -4.8,-0.6 -7.5,-0.4 -3.6,-2.5 -4.8,-1.6 -1.7,-2.9 -3.3,-2.2 -7,-2.6 -7.1,1.2 0.7,-4.5 1.5,-5.5 -6,-1 4.9,-6.8 4.9,-4.6 9.4,-6.5 8.6,-4.6 5.6,-0.7 2.9,-3.7 5.1,-2.4 6.4,-0.4 7.7,-3.8 2.9,-2.4 7.4,-4.7 3.2,-2.8 3.2,1.7 6.5,-0.9 10.8,-3.8 2.3,-2.7 -0.8,-2.9 5,-2.9 1.7,-2.7 -3.5,-2.6 -5.4,-0.8 -5.5,-0.4 -4.6,5.9 -6.5,4.6 -7.2,4 -1.3,-3.7 4.2,-4 -2.2,-3.5 -8.7,4.2 4.3,-5.5 z m -75.5,-18.9 -2.8,-1 -14.1,3.2 -5.1,2 -7.8,3.9 5.4,1.4 6.2,-0.1 -11.5,2.1 0,1.9 5.6,0.1 9,-0.4 6.5,1.2 -6.2,1 -5.5,-0.3 -7.1,0.9 -3.3,0.6 0.6,4.2 4.2,-0.6 4.1,1.5 -0.3,2.5 7.8,-0.5 11.2,-0.8 9.4,-1.8 5,-0.4 5.7,1.5 6.7,0.8 3.1,-1.9 -0.7,-2.1 7,-0.4 2.6,-2.4 -5,-2.5 -4.2,-2.6 2.4,-3.6 2.7,-5.1 -2.2,-2 -3,-0.9 -4.2,0.8 -2.8,5.3 -4.3,2.1 2.2,-5.1 -1.7,-1.7 -7.3,2.7 -2.6,-2.6 -10.4,1.5 4.7,-2.4 z m 39.1,-1.5 -1.7,-1.1 -5.4,0.2 -2.1,0.7 2.2,3.6 7,-3.4 z m 107.7,1.6 -4.4,-2.8 -8.4,-0.5 -2.1,0.3 -1.7,1.8 2,2.8 0.9,0.3 4.8,-0.7 4.1,0.1 4.1,0.1 0.7,-1.4 z m -39.4,-0.3 5.7,-3.2 -11.2,1.3 -5.8,2.1 -7.1,4.6 -3.3,5.2 5.6,0.1 -6.1,2.3 1.8,1.9 5.9,0.8 7.3,1.5 13.8,1.2 7.9,-0.6 3.2,-1.6 2,1.8 3.3,0.3 2,3.3 -3.5,1.4 7.1,1.8 4.6,2.6 0.5,1.9 -0.4,2.4 -8.6,5.4 -3.2,2.7 0.2,2 -9.2,0.7 -8,0.1 -5.4,4.2 2.4,1.9 13,-0.9 0.9,-1.6 4.7,2.7 4.7,2.9 -2.4,1.6 3.8,2.8 7.6,3.3 10.7,2.3 0.3,-2 -2.8,-3.5 -3.5,-4.9 8.5,4.6 4.7,1.5 3.6,-4.1 0,-5.6 -1,-1.5 -4.4,-2.5 -2.7,-3.3 2.3,-3.2 5.8,-0.7 3.8,5.4 4,2.4 10.7,-6.5 3.3,-3.9 -6.4,-0.3 -3.2,-5.1 -5.9,-1.2 -7.7,-3.5 9,-2.5 -0.8,-5 -2.2,-2.1 -8.3,-2.1 -1.9,-3.3 -8.2,1.2 1.1,-2.3 -3.6,-2.5 -6.8,-2.6 -5.2,2.1 -9,1.5 3.3,-3.4 -2.3,-5.3 -11.6,2.1 -7.1,4.1 -0.3,-3.2 z m -50,-3.4 -7.1,2.4 0.9,3.4 -7.4,-0.7 -1.7,1.7 5.8,3.9 0.9,2 3.4,0.5 8.4,-2 5.1,-4.7 -3.8,-2.2 6,-2.4 0.5,-1.5 -7.5,0.6 -3.5,-1 z m 22.3,5.4 5.6,-1 10,-4.5 -6.1,-1.2 -7.8,-0.2 -5.2,1.4 -4.2,2.1 -2.5,2.6 -1.8,4.5 4.3,0.2 7.7,-3.9 z m -114.7,7.2 2.6,-2.3 9.1,-3.6 13.8,-3.6 6.4,-1.3 -1.6,-2.1 -1.9,-1.5 -9.4,-0.2 -4.1,-1.1 -14,0.8 -0.3,3.1 -7.6,3.3 -7.4,3.8 -4.3,2.2 5.9,2.7 -0.6,2.3 13.4,-2.5 z m 124.1,-18.3 0.3,-1.6 -1.4,-1.7 -6.9,1.3 -4.4,2.2 3.2,1.3 5.1,0.4 4.1,-1.9 z m -8.7,-8.6 -1.1,0.7 -4.8,-0.3 -7.6,1.6 -3.8,-0.1 -4.3,3.8 6.6,-0.4 -3.4,2.9 3.2,0.8 6.8,-0.5 5.8,-3.7 2.8,-2.5 -0.2,-2.3 z m -39.1,2.5 1.8,-2.3 -3.1,-0.5 -5.7,1.7 -0.7,4.7 -6.1,-0.4 -2.8,-2.9 -8.2,-1.6 -5.4,1.4 -11.6,4.8 4.1,0.8 17.8,-0.5 -10.6,2.2 -1.5,1.6 5.9,-0.1 12.2,-2.2 13.8,-0.8 5.1,-2.3 2.3,-2.4 -3.7,-0.2 -4.3,0.8 0.7,-1.8 z m 55.2,-4.3 -7.1,-0.3 -3.8,2 2.6,1.5 7,0.6 1.4,2.1 -2.2,2.4 -1.5,2.8 8.5,1.6 5.5,0.6 8,-0.1 11.6,-0.8 4.3,0.6 6.7,-1 3.5,-1.4 1,-2 -2.3,-1.9 -5.8,-0.3 -8,0.4 -7,1.1 -5.1,-0.4 -4.8,-0.3 -1.2,-1.1 -3.1,-1.1 2.8,-1.9 -1.4,-1.6 -7.3,0.1 -2.3,-1.6 z m -75,-2.6 -6,0.7 -5.5,-0.1 -12.1,3.1 -11.6,3.7 0,0 3.6,1 7,-0.7 9.8,-2.1 3.8,-0.3 5.2,-1.6 5.8,-3.7 z m 80.5,0.6 1,-0.5 -1.5,-0.9 -7.2,-0.1 -0.6,1.3 6.4,0.3 1.9,-0.1 z m -58.4,-0.8 3.2,-1.4 -4.1,-0.8 -5.9,0.5 -5.1,1.5 3.3,1.5 8.6,-1.3 z m 7.8,-4.2 -3.3,-0.9 -1.6,-0.2 -5.7,1.3 -1,0.7 6,0 5.6,-0.9 z m 46.4,2.5 3,-1.7 -2.3,-1.6 -1.7,-0.3 -4.4,-0.1 -2.1,1.8 -0.7,1.8 1.6,1.1 6.6,-1 z m -13.7,-1.2 0.1,-2.2 -7.4,-1.7 -6.1,-0.6 -2.1,1.7 2.8,1.1 -5.3,1.4 7.7,0.2 4,1.5 5.2,0.5 1.1,-1.9 z m 53.7,-6.1 0.6,-2.8 -4.7,-0.8 -4.7,-0.9 -1.6,-2.2 -8.2,0.2 0.3,0.9 -3.9,0.3 -4.1,1.3 -4.9,1.9 -0.3,1.9 2,1.5 6.5,0 -4.3,1.2 -2.1,1.6 1.6,1.9 6.7,0.6 6.8,-0.4 10.5,-3.4 6.4,-1.3 -2.6,-1.5 z m 78.5,-13.8 -7,-0.2 -6.9,-0.3 -10.2,0.6 -1.4,-0.4 -10.3,0.2 -6.4,0.4 -5.1,0.6 -5,2 -2.3,-1 -3.9,-0.2 -6.7,1.4 -7.4,0.6 -4.1,0.1 -6,0.8 -1.1,1.3 2.5,1.2 0.8,1.6 4.4,1.5 12.4,-0.3 7.2,0.5 -7.2,1.5 -2.2,-0.4 -9.3,-0.2 -1.1,2.2 3,1.7 -2.8,1.6 -7.5,1.1 -4.9,1.7 4.8,0.9 1.7,3 -7.5,-2 -2.5,0.3 -2,3.4 -8,1.1 -2,2.3 6.7,0.3 4.9,0.6 11.7,-0.8 8.4,1.4 12.6,-3 1,-1.1 -6.4,0.2 0.5,-1.1 6.5,-1.4 3.6,-1.9 6.8,-1.3 5,-1.6 -0.8,-2.2 3.3,-0.8 -4.3,-0.6 11.1,-0.4 3.2,-0.9 7.9,-0.8 9.3,-3.5 6.8,-1.1 10.3,-2.5 -7.4,0 3.9,-0.9 9,-0.8 9.7,-1.6 1.1,-1.1 -5.2,-1 -6.7,-0.4 -8.5,-0.3 z
43	ae20d3f4-00cf-4231-a1bc-ea761ee3ba71	870d8300-9c56-4b34-9447-bcdfedf8454c	m 1035.9,221.2 -1.7,-3 -6.7,2 0.9,2.5 5.1,3.4 2.4,-4.9 z m -8.6,-5.1 -2.6,-0.9 -0.7,-1.6 1.3,-2 -0.1,-3 -3.6,1.6 -1.5,1.7 -4,0.4 -1.2,1.7 -0.7,1.6 0.4,6.1 2.1,3.4 3.6,0.8 3,-0.9 -1.5,-3 3.1,-4.3 1.4,0.7 1,-2.3 z
31	64c30568-8630-430d-93b1-420b667b3f7d	2b1aaccb-5846-45c1-8481-12bb8b5e0aa4	m 1110.5,517.3 -0.5,-0.3 -2,-1.8 -0.3,-2 0.8,-2.6 0,-2.6 -3.3,-4 -0.7,-2.7 -3.5,1.1 -2.8,2.5 -4,7 -5.2,2.9 -5.4,-0.4 -1.6,0.6 0.6,2.3 -2.9,2.2 -2.3,2.5 -7.1,2.4 -1.4,-1.4 -0.9,-0.2 -1,1.7 -4.7,0.4 -2.7,6.5 -1.4,1.1 -0.4,5 0.6,2.7 -0.4,1.9 2.6,3.3 0.5,2.3 2.1,3.2 2.6,2.1 0.3,2.9 0.6,1.8 2.9,-5.9 3.3,-3.4 3.8,1.1 3.6,0.4 0.5,-4.5 2.2,-3.2 3,-2 4.6,2.1 3.6,2.4 4.1,0.6 4.2,1.2 1.6,-3.8 0.8,-0.5 2.6,0.6 6.2,-3.1 2.2,1.3 1.8,-0.2 0.9,-1.5 2,-0.6 4.3,0.7 3.6,0.1 1.8,-0.6 -0.9,-2.1 -4.2,-2.5 -1.5,-3.8 -2.4,-2.7 -3.8,-3.4 -0.1,-2 -3.1,-2.6 -3.8,-2.5 z
32	d5c499f8-e668-4d6a-9b99-176279ac51c3	3f759fc5-8287-4acb-b58d-f235c5ef4981	m 1108.4,447.6 -22.4,-12.2 -22.3,-12.2 -5.4,3.5 1.6,9.9 2,1.6 0.2,2.1 2.3,2.2 -1.1,2.7 -1.8,12.9 -0.2,8.3 -6.9,6 -2.3,8.4 2.4,2.3 0,4.1 3.6,0.2 -0.5,2.9 2.2,4.1 0.5,4.2 -0.2,4.3 3.1,5.8 -3.1,-0.1 -1.6,0.4 -2.5,-0.6 -1.2,3 3.3,3.7 2.5,1.1 0.8,2.6 1.8,4.4 -0.9,1.7 4.7,-0.4 1,-1.7 0.9,0.2 1.4,1.4 7.1,-2.4 2.3,-2.5 2.9,-2.2 -0.6,-2.3 1.6,-0.6 5.4,0.4 5.2,-2.9 4,-7 2.8,-2.5 3.5,-1.1 0,-1.6 -2.1,-1.8 -0.1,-3.7 -1.2,-2.5 -2,0.4 0.5,-2.4 1.4,-2.6 -0.7,-2.7 1.8,-1.9 -1.2,-1.5 1.4,-3.9 2.4,-4.7 4.8,0.4 -1.1,-25.2 z
33	6309ccb8-f591-4b55-8477-d8708214c7b1	c5a755fa-0935-4ec5-a880-3d4854beabfd	m 648.4,905.2 -3.7,-0.7 -3.3,2.5 0.2,4.1 -1.2,2.8 -7.2,-2.2 -8.6,-4 -4.5,-1.3 9.7,6.8 6.3,3.2 7.5,3.4 5.3,0.9 4.3,1.8 3,0.5 2.3,0.1 3.2,-1.8 0.5,-2.4 -2.9,-0.2 -5,0 -5.9,-13.5 z m -47.3,-196.3 -3.7,-7.1 1.1,-6.2 -3.2,-2.7 -1.2,-4.6 -3.1,-4.3 -1.2,3.3 -2.7,1.6 2.1,9 1.5,10.4 -0.1,14.2 0,13.2 0.9,12.3 -1.9,7.8 2.1,7.8 -0.5,5.3 3.2,9.5 -0.1,9.5 -1.2,10.2 -0.6,10.5 -2.1,0.2 2.4,7.3 3.3,6.3 -1.1,4.3 1.9,11.6 1.5,8.8 3.5,0.9 -1.1,-7.7 4,1.6 1.8,12.7 -6.4,-2.1 2,10.2 -2.7,5.5 8.2,1.8 -3.4,4.8 0.2,6 5,10.6 4.2,4.1 0.2,3.6 3.3,3.8 7.5,3.5 0,0 7.4,4.2 6.2,2 2,-0.1 -1.8,-5.7 3.4,-2.2 1.7,-1.5 4.2,0 -4.8,-0.9 -12,-0.8 -3.5,-3.6 -1.8,-4.6 -3.1,0.4 -2.6,-2.2 -3.1,-6.6 2.7,-2.7 0.1,-3.9 -1.8,-3.2 0.7,-5.3 -1.1,-8.2 -1.8,-3.7 1.8,-1.1 -1.3,-2.3 -2.8,-1.3 0.8,-2.6 -3.1,-2.3 -3.6,-7.1 1.6,-1.2 -3.3,-7.6 -0.7,-6.4 -0.3,-5.7 2.5,-2.4 -3.3,-6.3 -1.5,-5.9 2.9,-4.3 -1.4,-5.4 1.6,-6.2 -1.3,-5.9 -1.6,-1.2 -4.9,-10.9 2.1,-6.5 -1.7,-6.2 0.9,-5.8 2.6,-5.9 3.2,-4 -2,-2.5 0.9,-2 -1.6,-10.6 5.6,-3.2 1.1,-6.6 -0.9,-1.6 -3.8,0.9 -3.1,-8.8 z
34	df7c923d-cd2b-42c0-8cbe-9a385396635b	7178da96-360e-4b0a-ada4-9640c498daf8	m 1587.2,453.3 0.6,-3.6 2,-2.8 -1.6,-2.5 -3.2,-0.1 -5.8,1.8 -2.2,2.8 1,5.5 4.9,2 4.3,-3.1 z m 13.2,-196.5 -6.1,-6.1 -4.4,-3.7 -3.8,-2.7 -7.7,-6.1 -5.9,-2.3 -8.5,-1.8 -6.2,0.2 -5.1,1.1 -1.7,3 3.7,1.5 2.5,3.3 -1.2,2 0.1,6.5 1.9,2.7 -4.4,3.9 -7.3,-2.3 0.6,4.6 0.3,6.2 2.7,2.6 2.4,-0.8 5.4,1 2.5,-2.3 5.1,2 7.2,4.3 0.7,2.2 -4.3,-0.7 -6.8,0.8 -2.4,1.8 -1.4,4.1 -6.3,2.4 -3.1,3.3 -5.9,-1.3 -3.2,-0.5 -0.4,4 2.9,2.3 1.9,2.1 -2.5,2 -1.9,3.3 -4.9,2.2 -7.5,0.2 -7.2,2.2 -4.4,3.3 -3.2,-2 -6.2,0.1 -9.3,-3.8 -5.5,-0.9 -6.4,0.8 -11.2,-1.3 -5.5,0.1 -4.7,-3.6 -4.9,-5.7 -3.4,-0.7 -7.9,-3.8 -7.2,-0.9 -6.4,-1 -3,-2.7 -1.3,-7.3 -5.8,-5 -8.1,-2.3 -5.7,-3.3 -3.3,-4.4 -1.7,0.5 -1.8,4.2 -3.8,0.6 2.5,6.2 -1.6,2.8 -10.7,-2 1,11.1 -2,1.4 -9,2.4 8.7,10.7 -2.9,1.6 1.7,3.5 -0.2,1.4 -6.8,3.4 -1,2.4 -6.4,0.8 -0.6,4 -5.7,-0.9 -3.2,1.2 -4,3 1.1,1.5 -1,1.5 3,5.9 1.6,-0.6 3.5,1.4 0.6,2.5 1.8,3.7 1.4,1.9 4.7,3 2.9,5 9.4,2.6 7.6,7.5 0.8,5.2 3,3.3 0.6,3.3 -4.1,-0.9 3.2,7 6.2,4 8.5,4.4 1.9,-1.5 4.7,2 6.4,4.1 3.2,0.9 2.5,3.1 4.5,1.2 5,2.8 6.4,1.5 6.5,0.6 3,-1.4 1.5,5.1 2.6,-4.8 2.6,-1.6 4.2,1.5 2.9,0.1 2.7,1.8 4.2,-0.8 3.9,-4.8 5.3,-4 4.9,1.5 3.2,-2.6 3.5,3.9 -1.2,2.7 6.1,0.9 3,-0.4 2.7,3.7 2.7,1.5 1.3,4.9 0.8,5.3 -4.1,5.3 0.7,7.5 5.6,-1 2.3,5.8 3.7,1.3 -0.8,5.2 4.5,2.4 2.5,1.2 3.8,-1.8 0.6,2.6 0.7,1.5 2.9,0.1 -1.9,-7.2 2.7,-1 2.7,-1.5 4.3,0 5.3,-0.7 4.1,-3.4 3,2.4 5.2,1.1 -0.2,3.7 3,2.6 5.9,1.6 2.4,-1 7.7,2 -0.9,2.5 2.2,4.6 3,-0.4 0.8,-6.7 5.6,-0.9 7.2,-3.2 2.5,-3.2 2.3,2.1 2.8,-2.9 6.1,-0.7 6.6,-5.3 6.3,-5.9 3.3,-7.6 2.3,-8.4 2.1,-6.9 2.8,-0.5 -0.1,-5.1 -0.8,-5.1 -3.8,-2 -2.5,-3.4 2.8,-1.7 -1.6,-4.7 -5.4,-4.9 -5.4,-5.8 -4.6,-6.3 -7.1,-3.5 0.9,-4.6 3.8,-3.2 1,-3.5 6.7,-1.8 -2.4,-3.4 -3.4,-0.2 -5.8,-2.5 -3.9,4.6 -4.9,-1.9 -1.5,-2.9 -4.7,-1 -4.7,-4.4 1.2,-3 5,-0.3 1.2,-4.1 3.6,-4.4 3.4,-2.2 4.4,3.3 -1.9,4.2 2.3,2.5 -1.4,3 4.8,-1.8 2.4,-2.9 6.3,-1.9 2.1,-4 3.8,-3.4 1,-4.4 3.6,2 4.6,0.2 -2.7,-3.3 6.3,-2.6 -0.1,-3.5 5.5,3.6 0,0 -1.9,-3.1 2.5,-0.1 -3.8,-7.3 -4.7,-5.3 2.9,-2.2 6.8,1.1 -0.6,-6 -2.8,-6.8 0.4,-2.3 -1.3,-5.6 -6.9,1.8 -2.6,2.5 -7.5,0 -6,-5.8 -8.9,-4.5 -9.9,-1.9 z
35	192e2e8b-db3a-49ab-8a9c-3ecda28c49e6	8b58bd46-c2d7-4df7-8871-378dbe921468	m 578.3,497.2 1.2,-2.1 -1.3,-1.7 -2,-0.4 -2.9,3.1 -2.3,1.4 -4.6,3.2 -4.3,-0.5 -0.5,1.3 -3.6,0.1 -3.3,3 -1.4,5.4 -0.1,2.1 -2.4,0.7 -4.4,4.4 -2.9,-0.2 -0.7,0.9 1.1,3.8 -1.1,1.9 -1.8,-0.5 -0.9,3.1 2.2,3.4 0.6,5.4 -1.2,1.6 1.1,5.9 -1.2,3.7 2,1.5 -2.2,3.3 -2.5,4 -2.8,0.4 -1.4,2.3 0.2,3.2 -2.1,0.5 0.8,2 5.6,3.6 1,-0.1 1.4,2.7 4.7,0.9 1.6,-1 2.8,2.1 2.4,1.5 1.5,-0.6 3.7,3 1.8,3 2.7,1.7 3.4,6.7 4.2,0.8 3,-1.7 2.1,1.1 3.3,-0.6 4.4,3 -3.5,6.5 1.7,0.1 2.9,3.4 2.2,-17.4 0.1,-2.8 -0.9,-3.6 -2.5,-2.4 0,-4.6 3.2,-1 1.1,0.6 0.2,-2.4 -3.3,-0.7 0,-3.9 10.9,0.1 1.9,-2.2 1.6,2 1,3.8 1.1,-0.8 -1.7,-6.4 -1.4,-2.2 -2,-1.4 2.9,-3.1 -0.2,-1.5 -1.5,-1.9 -1,-4.2 0.5,-4.6 1.3,-2.1 1.2,-3.4 -2,-1.1 -3.2,0.7 -4,-0.3 -2.3,0.7 -3.8,-5.5 -3.2,-0.8 -7.2,0.6 -1.3,-2.2 -1.3,-0.6 -0.2,-1.3 0.8,-2.4 -0.4,-2.5 -1.1,-1.4 -0.6,-2.9 -2.9,-0.5 1.8,-3.7 0.9,-4.5 1.8,-2.4 2.2,-1.8 1.6,-3.2 3.7,-1.1 z
36	8d430460-3c9c-48e2-86b6-6529aa9ba773	48847459-b1b2-4092-9bf0-f0c08b928c74	m 1221.1,650.5 -0.4,-0.4 -0.4,0 0,0.2 0.1,0.4 1.1,0.2 -0.4,-0.4 z m 3.9,-1.5 -0.1,0 -0.2,0.1 -0.1,0.2 -0.1,0.3 -0.3,0 -0.2,0 -0.4,0 0.8,0.5 0.5,0.5 0.2,0.2 0.1,-0.2 0.1,-0.7 -0.3,-0.9 z m -5.6,-1.1 0.2,-0.3 -0.2,-0.7 -0.4,-0.8 0.1,-1.4 -0.2,-0.2 -0.3,0 -0.1,0.1 -0.1,0.3 -0.3,2 0.4,0.6 0.3,0.1 0.5,0.4 0.1,-0.1 z
37	a83767ad-4c34-42d7-a425-78a18e7461ad	196ed632-cc17-4b9f-87cb-cbc9832e8617	m 1080.3,549.9 -3.6,-0.4 -3.8,-1.1 -3.3,3.4 -2.9,5.9 -0.4,3.5 -4.5,-1.5 -4.5,-1.7 -7.1,-0.3 -0.4,2.8 1.5,3.3 4.2,-0.5 1.4,1.2 -2.4,7.4 2.7,3.8 0.6,4.9 -0.8,4.3 -1.7,3 -4.9,-0.3 -3,-3 -0.5,2.8 -3.8,0.8 -1.9,1.6 2.1,4.2 -4.3,3.5 4.6,6.7 2.2,-2.7 1.8,-1.1 2,2.2 1.5,0.6 1.9,-2.4 3.1,0.1 0.4,1.8 2,1.1 3.4,-4 3.3,-3.1 1.4,-2 -0.2,-5.3 2.5,-6.2 2.6,-3.2 3.7,-3.1 0.6,-2 0.2,-2.4 0.9,-2.2 -0.3,-3.6 0.7,-5.6 1.1,-4 1.6,-3.4 0.3,-3.8 z
38	9a6b0249-385f-4b5a-9e2b-f862c1bd604b	cf56f0da-daf4-4437-9ad9-4b61bbedc31a	m 509.1,502.6 -1.4,1.3 -1.7,-0.4 -0.8,-1.3 -1.7,-0.5 -1.4,0.8 -3.5,-1.7 -0.9,0.8 -1.4,1.2 1.5,0.9 -0.9,2 -0.1,2 0.7,1.3 1.7,0.6 1.2,1.8 1.2,-1.6 -0.3,-1.8 1.4,1.1 0.3,1.9 1.9,0.8 2.1,1.3 1.5,1.5 0.1,1.4 -0.7,1.1 1.1,1.3 2.9,1.4 0.4,-1.2 0.5,-1.3 -0.1,-1.2 0.8,-0.7 -1.1,-1 0.1,-2.5 2.2,-0.6 -2.4,-2.7 -2,-2.6 -1.2,-3.4 z
39	3d4110dd-b128-4d66-9900-410edf1fa1ae	14730d5f-e0e5-43a8-bc67-ca9f92c8502a	m 1065,280.4 -4,-2.6 -1.6,-0.8 -3.9,1.7 -0.3,2.5 -1.7,0.6 0.2,1.7 -2,-0.1 -1.8,-1 -0.8,1 -3.5,-0.2 -0.2,0.1 0,2.2 1.7,2 1.3,-2.6 3.3,1 0.3,2 2.5,2.6 -1,0.5 4.6,4.5 4.8,1.8 3.1,2.2 5,2.3 0,0 0.5,-1 -4.7,-2.4 -2.2,-2.5 -2,-1.4 -2.5,-2.3 -1.3,-1.9 -2.7,-2.9 0.9,-2.5 1.9,1.4 1,-1.3 2.3,-0.1 4.4,1 3.5,-0.1 2.4,1.4 0,0 1.7,-2.3 -1.7,-1.8 -1.5,-2.4 0,0 -1.8,0.9 -4.2,-1.2 z
40	f4bd136c-7894-4d10-90c8-6b6b7e66431d	16a55dd1-2e47-489d-830c-3a88aad464a9	m 539,427.3 -4.9,-2.1 -4.3,-0.1 -4.7,-0.5 -1.4,0.7 -4.2,0.6 -3,1.3 -2.7,1.4 -1.5,2.3 -3.1,2 2.2,0.6 2.9,-0.7 0.9,-1.6 2.3,-0.1 4.4,-3.3 5.4,0.3 -2.3,1.6 1.8,1.3 7,1 1.5,1.3 4.9,1.7 3.2,-0.2 0.8,3.6 1.7,1.8 3.5,0.4 2.1,1.7 -4.1,3.5 7.9,-0.6 3.8,0.5 3.7,-0.3 3.8,-0.8 0.8,-1.5 -3.9,-2.6 -4,-0.3 0.6,-1.7 -3.1,-1.3 -1.9,0 -3,-2.8 -4.2,-4 -1.8,-1.5 -5.2,0.8 -1.9,-2.4 z
41	b03ab799-2b41-447f-9b75-2f9627247f3c	f36ec987-ed66-4a88-9157-b1d4a934e515	m 1149.9,348.4 -0.3,-0.1 -0.5,0.2 -0.4,0.4 -0.4,0.3 -0.5,-0.3 0.2,0.9 0.6,1.1 0.2,0.3 0.3,0.2 1.1,0.3 0.3,0 0.6,0 0.2,0.1 0.2,0.4 0.4,0 0,-0.1 0,-0.3 0.2,-0.2 0.3,-0.2 0.3,0 0.6,-0.1 0.6,-0.2 0.5,-0.4 0.9,-1 0.3,0 0.3,0 0.6,0 0.6,-0.1 -0.2,-0.4 -0.1,-0.1 -0.4,-0.5 -0.2,-0.4 0.1,-0.6 2.5,-1.9 0.5,-0.5 -0.8,0.2 -0.6,0.4 -0.4,0.2 -0.7,0.4 -2.3,0.8 -0.8,0.1 -0.8,0 -1,-0.1 -0.9,-0.2 0,0.7 -0.2,0.6 -0.6,0.2 -0.3,-0.1 z
42	ecacd104-b833-489e-8480-e83caccc5d90	c5db5d6b-ebcd-4642-9604-0f1ebf2fdf9d	m 1049.4,248.5 -2.1,0.6 -1.4,-0.7 -1.1,1.2 -3.4,1.2 -1.7,1.5 -3.4,1.3 1,1.9 0.7,2.6 2.6,1.5 2.9,2.6 3.8,2 2.6,-2.5 1.7,-0.5 4,1.9 2.3,-0.3 2.3,1.2 0.6,-1.4 2.2,0.1 1.6,-0.6 0.1,-0.6 0.9,-0.3 0.2,-1.4 1.1,-0.3 0.6,-1.1 1.5,0 -2.6,-3.1 -3.6,-0.3 -0.7,-2 -3.4,-0.6 -0.6,1.5 -2.7,-1.2 0.1,-1.7 -3.7,-0.6 -2.4,-1.9 z
45	20d72a9e-a97a-4cf6-8b0b-9203bce45ce2	a66c6aaf-f010-4056-8928-1653d670edf3	m 635.8,475.1 0.3,-0.7 -0.1,-1 -0.2,-0.4 -0.8,-0.3 0,0.2 -0.1,0.5 0.3,0.8 0.1,1.1 0.5,-0.2 z
46	401ba406-74e0-45db-b529-bdf52f493928	7caae20c-20fa-4ce0-a987-cca304a302b9	m 579.6,457.4 0,1.8 1.4,1 2.6,-4.4 2,-0.9 0.6,1.6 2.2,-0.4 1.1,-1.2 1.8,0.3 2.6,-0.2 2.5,1.3 2.3,-2.6 -2.5,-2.3 -2.4,-0.2 0.3,-1.9 -3,0.1 -0.8,-2.2 -1.4,0.1 -3.1,-1.6 -4.4,-0.1 -0.8,1.1 0.2,3.5 -0.7,2.4 -1.5,1.1 1.2,1.9 -0.2,1.8 z
47	5108dd92-d183-4bae-8613-de41d506e404	80b3fc54-1fa6-49c6-ac4c-998b002d754f	m 1124.9,539.4 -4.3,-0.7 -2,0.6 -0.9,1.5 -1.8,0.2 -2.2,-1.3 -6.2,3.1 -2.6,-0.6 -0.8,0.5 -1.6,3.8 -4.2,-1.2 -4.1,-0.6 -3.6,-2.4 -4.6,-2.1 -3,2 -2.2,3.2 -0.5,4.5 -0.3,3.8 -1.6,3.4 -1.1,4 -0.7,5.6 0.3,3.6 -0.9,2.2 -0.2,2.4 -0.6,2 -3.7,3.1 -2.6,3.2 -2.5,6.2 0.2,5.3 -1.4,2 -3.3,3.1 -3.4,4 -2,-1.1 -0.4,-1.8 -3.1,-0.1 -1.9,2.4 -1.5,-0.6 -2,1.3 -0.9,1.7 -0.2,2.7 -1.5,0.7 0.8,2 2.3,-0.9 1.7,0.1 1.9,-0.7 16.6,0.1 1.3,4.7 1.6,3.8 1.3,2.1 2.1,3.3 3.7,-0.5 1.9,-0.9 3,0.9 0.9,-1.6 1.5,-3.7 3.4,-0.3 0.3,-1.1 2.9,0 -0.5,2.3 6.8,0 0,4 1.2,2.4 -0.9,3.8 0.3,4 1.9,2.3 -0.5,7.6 1.4,-0.6 2.4,0.2 3.5,-1 2.6,0.4 1.9,0.1 0.3,2 2.6,-0.1 3.5,0.6 1.8,2.8 4.5,0.9 3.4,-2 1.2,3.4 4.3,0.8 2,2.8 2.1,3.5 4.3,0 -0.3,-6.9 -1.5,1.2 -3.9,-2.5 -1.4,-1.1 0.8,-6.4 1.2,-7.5 -1.2,-2.8 1.6,-4.1 1.6,-0.7 7.5,-1.1 1,0.3 0.2,-1.1 -1.5,-1.7 -0.7,-3.5 -3.4,-3.5 -1.8,-4.5 1,-2.7 -1.5,-3.6 1.1,-10.2 0.1,0.1 -0.1,-1.1 -1.4,-2.9 0.6,-3.5 0.8,-0.4 0.2,-3.8 1.6,-1.8 0.1,-4.8 1.3,-2.4 0.3,-5.1 1.2,-3 2.1,-3.3 2.2,-1.7 1.8,-2.3 -2.3,-0.8 0.3,-7.5 0,0 -5,-4.2 -1.4,-2.7 -3.1,1.3 -2.6,-0.4 -1.5,1.1 -2.5,-0.8 -3.5,-5.2 -1.8,0.6 -3.6,-0.1 z
48	1ec96175-b401-436e-b909-1167c5add211	41fa1fc8-a7c9-4045-ac6a-92fe36c27bd9	m 553.1,573.1 -2.4,-1.5 -2.8,-2.1 -1.6,1 -4.7,-0.9 -1.4,-2.7 -1,0.1 -5.6,-3.6 -3.9,2.5 -3.1,1.4 0.4,2.6 -2.2,4.1 -1,3.9 -1.9,1 1,5.8 -1.1,1.8 3.4,2.7 2.1,-2.9 1.3,2.8 -2.9,4.7 0.7,2.7 -1.5,1.5 0.2,2.3 2.3,-0.5 2.3,0.7 2.5,3.2 3.1,-2.6 0.9,-4.3 3.3,-5.5 6.7,-2.5 6,-6.7 1.7,-4.1 -0.8,-4.9 z
49	aedaac41-77b0-407c-b5ac-39f416b4c7bb	0d0a18fd-d424-4a69-b646-38fffd942dd5	m 1129.7,374.8 -5.5,-1.9 -5.3,-1.7 -7.1,0.2 -1.8,3 1.1,2.7 -1.2,3.9 2,5.1 1.3,22.7 1,23.4 22.1,0 21.4,0 21.8,0 -1,-1.3 -6.8,-5.7 -0.4,-4.2 1,-1.1 -5.3,-7 -2,-3.6 -2.3,-3.5 -4.8,-9.9 -3.9,-6.4 -2.8,-6.7 0.5,-0.6 4.6,9.1 2.7,2.9 2,2 1.2,-1.1 1.2,-3.3 0.7,-4.8 1.3,-2.5 -0.7,-1.7 -3.9,-9.2 0,0 -2.5,1.6 -4.2,-0.4 -4.4,-1.5 -1.1,2.1 -1.7,-3.2 -3.9,-0.8 -4.7,0.6 -2.1,1.8 -3.9,2 -2.6,-1 z
50	1de6ba26-9f55-49fd-8d6d-12c1dab4cbea	bae2df87-ee9b-4efe-8482-2b05b54ebb11	m 487.2,487 0.6,-2.5 -0.7,-0.7 -1.1,-0.5 -2.5,0.8 -0.1,-0.9 -1.6,-1 -1.1,-1.3 -1.5,-0.5 -1.4,0.4 0.2,0.7 -1.1,0.7 -2.1,1.6 -0.2,1 1.4,1.3 3.1,0.4 2.2,1.3 1.9,0.6 3.3,0.1 0.7,-1.5 z
51	907d73c0-7ac7-40d8-97a8-f6beea1a4f4a	43d35de8-4ed4-4bd7-9fce-54d9adcdeec6	m 1040.1,557.8 -9.2,-0.2 -1.9,7.2 1,0.9 1.9,-0.3 8.2,0 0,-7.6 z
52	b0b55df8-74e3-48df-8a8b-de07322a085d	b2db2210-e9b8-4d51-b3c0-ed8e3d6adc9b	m 1198.1,474 -3.2,-3.1 -1.8,-5.9 -3.7,-7.3 -2.6,3.6 -4,1 -1.6,2 -0.4,4.2 -1.9,9.4 0.7,2.5 6.5,1.3 1.5,-4.7 3.5,2.9 3.2,-1.5 1.4,1.3 3.9,0.1 4.9,2.5 1.6,2.2 2.5,2.1 2.5,3.7 2,2.1 2.4,0.5 1.6,-1.5 -2.8,-1.9 -1.9,-2.2 -3.2,-3.7 -3.2,-3.6 -7.9,-6 z
53	40f1c65a-544a-407e-9569-a1723f4fcc24	061c7757-87bb-4acc-bfb5-ebb5a4dc9429	m 1093.2,197.5 -5.5,0.9 -5.4,1.6 0.9,3.4 3.3,2.1 1.5,-0.8 0.1,3.5 3.7,-1 2.1,0.7 4.4,2.2 3.8,0 1.6,-1.9 -2.5,-5.5 2.6,-3.4 -0.9,-1 0,0 -4.6,0.2 -5.1,-1 z
54	a873e5b1-fe19-4da3-a6cf-fbe471364955	f76a50d7-c955-4658-a2da-f191b746b434	m 1187.6,477 -1.5,4.7 -6.5,-1.3 -0.7,5.5 -2.1,6.2 -3.2,3.2 -2.3,4.8 -0.5,2.6 -2.6,1.8 -1.4,6.7 0,0.7 0.2,5 -0.8,2 -3,0.1 -1.8,3.6 3.4,0.5 2.9,3.1 1,2.5 2.6,1.5 3.5,6.9 2.9,1.1 0,3.6 2,2.1 3.9,0 7.2,5.4 1.8,0 1.3,-0.1 1.2,0.7 3.8,0.5 1.6,-2.7 5.1,-2.6 2.3,2.1 3.8,0 1.5,-2 3.6,-0.1 4.9,-4.5 7.4,-0.3 15.4,-19.1 -4.8,0.1 -18.5,-7.6 -2.2,-2.2 -2.1,-3.1 -2.2,-3.5 1.1,-2.3 -1.3,-1.1 -1.3,0.5 -3.1,-0.1 -0.2,-2 -0.5,-1.7 1.8,-3 1.9,-2.8 -2,-2.1 -2.5,-3.7 -2.5,-2.1 -1.6,-2.2 -4.9,-2.5 -3.9,-0.1 -1.4,-1.3 -3.2,1.5 -3.5,-2.9 z
55	6af2dde8-4b27-419a-b5bf-827f3f7986b6	923566be-1a81-4281-a9f5-fc3d8e59e53e	m 1976.7,674.4 -3.7,2 -1.9,0.3 -3.1,1.3 0.2,2.4 3.9,-1.3 3.9,-1.6 0.7,-3.1 z m -11,8.1 -1.6,1 -2.3,-0.8 -2.7,2.2 -0.2,2.8 2.9,0.8 3.6,-0.9 1.8,-3.3 -1.5,-1.8 z
56	b60a5dc2-5996-4a5d-aaa7-4d0347874bc8	d322fe64-203a-4eb4-8316-2c6c1af401a3	m 1093.4,144.4 0.8,-3.8 -5.7,-2.1 -5.8,1.8 -1.1,3.9 -3.4,2.4 -4.7,-1.3 -5.3,0.3 -5.1,-2.9 -2.1,1.4 5.9,2.7 7.2,3.7 1.7,8.4 1.9,2.2 6.4,2.6 0.9,2.3 -2.6,1.2 -8.7,6.1 -3.3,3.6 -1.5,3.3 2.9,5.2 -0.1,5.7 4.7,1.9 3.1,3.1 7.1,-1.2 7.5,-2.1 8,-0.5 0,0 7.9,-7.4 3.3,-3.3 0.9,-2.9 -7.3,-3.9 0.9,-3.7 -4.9,-4.1 1.7,-4.8 -6.4,-6.3 2.8,-4.1 -7.2,-3.7 -0.4,-3.7 z
57	3ee30f00-52e0-4bf9-84f8-ffea4778bab4	b7b802fe-8789-4b6d-b085-7c25a92dab7b	m 1025.7,303.8 -1.1,-5.2 -3.2,2.3 -1,2.3 1.4,4.2 2.4,1.2 1.5,-4.8 z m -31.5,-50.9 -2.4,-2.4 -2.2,-0.1 -0.7,-2.2 -4.3,1.2 -1.4,5.1 -11.3,4.8 -4.6,-2.6 1.4,7 -8.2,-1.6 -6.4,1.3 0.4,4.6 7.5,2.4 3.6,3.1 5.1,6.5 -1,12.3 -2.7,3.7 2,2.4 9.4,2.8 1.9,-1.3 5.7,2.8 6,-0.8 0.5,-3.7 7.4,-2 10,1.6 4.5,-3.4 0.5,-2.7 -2.7,-0.8 -1.5,-4.8 1.7,-1.8 -1.6,-2.4 0.2,-1.7 -1.8,-2.7 -2.4,0.9 0,-2.8 3.5,-3.5 -0.2,-1.6 2.3,0.6 1.3,-1 0.5,-4.5 2.3,-4.2 -7.1,-1.2 -2.4,-1.6 -1.4,0.1 -1.1,-0.5 -4.4,-2.8 -2.5,0.4 -3.4,-2.9 z
58	56421cb7-aaf9-48c6-84a0-35eba399ae67	6a95dca7-5bc9-438d-ba51-5cc4603d70a4	m 1050.2,557.7 -0.7,-0.3 -3.4,0.8 -3.4,-0.8 -2.6,0.4 0,7.6 -8.2,0 -1.9,0.3 -1.1,4.8 -1.3,4.6 -1.3,2 -0.2,2.1 3.4,6.6 3.7,5.3 5.8,6.4 4.3,-3.5 -2.1,-4.2 1.9,-1.6 3.8,-0.8 0.5,-2.8 3,3 4.9,0.3 1.7,-3 0.8,-4.3 -0.6,-4.9 -2.7,-3.8 2.4,-7.4 -1.4,-1.2 -4.2,0.5 -1.5,-3.3 0.4,-2.8 z
59	01035583-ce05-4b15-af1c-3f8f0533e2f8	81e9890e-9239-4c33-b429-66950b214814	m 882.8,488.5 5,0.1 1.4,-0.9 1,0 2.1,-1.5 2.4,1.4 2.4,0.1 2.4,-1.5 -1.1,-1.8 -1.8,1.1 -1.8,-0.1 -2.1,-1.5 -1.8,0.1 -1.3,1.5 -6.1,0.2 -0.7,2.8 z
60	7c8da5d6-22b4-4b3a-a05c-c85061c397df	f2e17057-cb16-4fd3-92ef-07a6320c1818	m 1200,300.2 -7.5,-2.9 -7.7,-1 -4.5,-1.1 -0.5,0.7 2.2,1.9 3,0.7 3.4,2.3 2.1,4.2 -0.3,2.7 5.4,-0.3 5.6,3 6.9,-1 1.1,-1 4.2,1.8 2.8,0.4 0.6,-0.7 -3.2,-3.4 1.1,-0.9 -3.5,-1.4 -2.1,-2.5 -5.1,-1.3 -2.9,1 -1.1,-1.2 z
61	10059cf8-1a63-4e14-a928-79c96003798b	d80301ed-7cdc-4f2c-8093-cfec014b077a	m 1043.6,232.3 -2.4,-1.9 -5.5,-2.4 -2.5,1.7 -4.7,1.1 -0.1,-2.1 -4.9,-1.4 -0.2,-2.3 -3,0.9 -3.6,-0.8 0.4,3.4 1.2,2.2 -3,3 -1,-1.3 -3.9,0.3 -0.9,1.3 1,2 -1,5.6 -1.1,2.3 -2.9,0 1.1,6.4 -0.4,4.2 1,1.4 -0.2,2.7 2.4,1.6 7.1,1.2 -2.3,4.2 -0.5,4.5 4.2,0 1,-1.4 5.4,1.9 1.5,-0.3 2.6,1.7 0.6,-1.6 4.4,0.3 3.4,-1.2 2.4,0.2 1.7,1.3 0.4,-1.1 -1,-4 1.7,-0.8 1.5,-2.9 -2.9,-2.6 -2.6,-1.5 -0.7,-2.6 -1,-1.9 3.4,-1.3 1.7,-1.5 3.4,-1.2 1.1,-1.2 1.4,0.7 2.1,-0.6 -2.3,-3.9 0.1,-2.1 -1.4,-3.3 -2,-2.2 1.2,-1.6 -1.4,-3.1 z
62	3ee9477d-cfce-42fa-bd74-94f59a295bad	53618499-ed33-49f9-aeae-e24d02029f1e	m 976.8,502.1 -2.6,-0.5 -1.8,1 -2.4,-0.5 -9.7,0.3 -0.2,3.6 0.8,4.8 1.4,9.1 -2.3,5.3 -1.5,7.2 2.4,5.5 -0.2,2.5 5,1.8 5,-1.9 3.2,-2.1 8.7,-3.8 -1.2,-2.2 -1.5,-4 -0.4,-3.2 1.2,-5.7 -1.4,-2.3 -0.6,-5.1 0.1,-4.6 -2.4,-3.3 0.4,-1.9 z
77	d9cb4c2a-f88f-49be-b1e8-eb30b62f0907	48d25a4f-6bcb-4595-bf82-1492334695ec	m 947.3,231.7 -3.5,-1.3 -2.9,0.1 1.1,-3.2 -0.8,-3.2 -3.7,2.8 -6.7,4.7 2.1,6.1 -4.2,6.4 6.7,0.9 8.7,-3.6 3.9,-5.4 -0.7,-4.3 z
63	ad60bcb9-e524-4ef1-b096-a015aeadb964	1a76eb8a-5fca-4552-a0dd-9728217998b0	m 1101.9,344.9 -0.8,2.8 6.6,1.2 0,1.1 7.6,-0.6 0.5,-1.9 -2.8,0.8 0,-1.1 -3.9,-0.5 -4.1,0.4 -3.1,-2.2 z m 11.5,-37.4 -2.7,-1.6 0.3,3 -4.6,0.6 -3.9,-2.1 -3.9,1.7 -3.8,-0.2 -1,0.2 -0.7,1.1 -2.8,-0.1 -1.9,1.3 -3.3,0.6 0,1.6 -1.6,0.9 -0.1,2.1 -2.1,3 0.5,1.9 2.9,3.6 2.3,3 1.3,4.3 2.3,5.1 4.6,2.9 3.4,-0.1 -2.4,-5.7 3.3,-0.7 -1.9,-3.3 5,1.7 -0.4,-3.7 -2.7,-1.8 -3.2,-3 1.8,-1.4 -2.8,-3 -1.6,-3.8 0.9,-1.3 3,3.2 2.9,0 2.5,-1 -3.9,-3.6 6.1,-1.6 2.7,0.6 3.2,0.2 1.1,-0.7 1.2,-3.9 z
64	0565b2b7-a1ad-47f2-91ce-87f110d35765	aedfe3b8-fc01-41f8-a152-516e139dc8b6	m 632.1,495.7 0.5,-0.2 0.2,-1.1 -0.3,-0.1 -0.3,0.3 -0.3,0.5 0,0.4 -0.2,0.3 0.4,-0.1 z
65	8231e540-d619-4ed4-91b4-d250951f8f94	0e291c7e-51a2-466f-94b9-de8d9dec9dd2	m 482.8,458.9 -5.1,-0.1 -5.2,0 -0.4,3.6 -2.6,0 1.8,2.1 1.9,1.5 0.5,1.4 0.8,0.4 -0.4,2.1 -7.1,0 -3.3,5.2 0.7,1.2 -0.8,1.5 -0.4,1.9 2.7,2.6 2.5,1.3 3.4,0.1 2.8,1.1 0.2,-1 2.1,-1.6 1.1,-0.7 -0.2,-0.7 1.4,-0.4 1.3,-1.6 -0.3,-1.3 0.5,-1.2 2.8,-1.8 2.8,-2.4 -1.5,-0.8 -0.6,0.9 -1.7,-1.1 -1.6,0 1.2,-7.2 0.7,-5 z
66	b132dc95-978f-4486-9873-0699ffc072f1	98fd5d7d-6f4c-434d-bd97-6fabe502db00	m 900.2,492.1 -10.3,-0.3 -1.5,0.7 -1.8,-0.2 -3,1.1 0.3,1.3 1.7,1.4 0,0.9 1.2,1.8 2.4,0.5 2.9,2.6 2.6,-3.1 1.7,0.1 1.4,-1 1.3,0 0.8,-0.9 -0.4,-2.1 0.6,-0.7 0.1,-2.1 z
67	9587f5fd-8609-4be8-b425-e96289e5d788	b3e98c98-8a15-45bf-8f86-f26f6a07a425	m 912.4,493 -0.8,0.4 -3,-0.5 -0.4,0.7 -1.3,0.1 -4,-1.5 -2.7,-0.1 -0.1,2.1 -0.6,0.7 0.4,2.1 -0.8,0.9 -1.3,0 -1.4,1 -1.7,-0.1 -2.6,3.1 1.6,1.1 0.8,1.4 0.7,2.8 1.3,1.2 1.5,0.9 2.1,2.5 2.4,3.7 3,-2.8 0.7,-1.7 1,-1.4 1.5,-0.2 1.3,-1.2 4.5,0 1.5,2.3 1.2,2.7 -0.2,1.8 0.9,1.7 0,2.3 1.5,-0.3 1.2,-0.2 1.5,-0.7 2.3,3.9 -0.4,2.6 1.1,1.3 1.6,0.1 1.1,-2.6 1.6,0.2 0.9,0 0.3,-2.8 -0.4,-1.2 0.6,-0.9 2,-0.8 -1.3,-5.1 -1.3,-2.6 0.5,-2.2 1.1,-0.5 -1.7,-1.8 0.3,-1.9 -0.7,-0.7 -1.2,0.6 0.2,-2.1 1.2,-1.6 -2.3,-2.7 -0.6,-1.7 -1.3,-1.4 -1.1,-0.2 -1.3,0.9 -1.8,0.8 -1.6,1.4 -2.4,-0.5 -1.5,-1.6 -0.9,-0.2 -1.5,0.8 -0.9,0 -0.3,-2.3 z
68	637737e0-2131-4948-aea8-75354f7ae559	f11d746c-8b82-4fe1-acb0-788067f0071c	m 656.1,534.2 -2.1,-2.3 -2.9,-3.1 -2.1,-0.1 -0.1,-3.3 -3.3,-4.1 -3.6,-2.4 -4.6,3.8 -0.6,2.3 1.9,2.3 -1.5,1.2 -3.4,1.1 0,2.9 -1.6,1.8 3.7,4.8 2.9,-0.3 1.3,1.5 -0.8,2.8 1.9,0.9 1.2,3 -1.6,2.2 -1,5.4 1.4,3.3 0.3,2.9 3.5,3 2.7,0.3 0.7,-1.3 1.7,-0.2 2.6,-1.1 1.8,-1.7 3.1,0.5 1.4,-0.2 -3.3,-5.6 -0.7,-3.5 -1.8,-0.1 -2.4,-4.6 1.1,-3.3 -0.3,-1.5 3.5,-1.6 1,-5.7 z
69	db111182-967f-4e2d-85d0-391ecf33da28	99530f46-46c4-4263-bd88-dca23dc0383f	m 580.6,446.7 -4.6,-1 -3.4,-0.2 -1.4,1.7 3.4,1 -0.3,2.4 2.2,2.8 -2.1,1.4 -4.2,-0.5 -5,-0.9 -0.7,2.1 2.8,1.9 2.7,-1.1 3.3,0.4 2.7,-0.4 3.6,1.1 0.2,-1.8 -1.2,-1.9 1.5,-1.1 0.7,-2.4 -0.2,-3.5 z
70	cf9d56f8-5f73-4d5a-8b5a-57c5b1f0807a	3e33cfe7-603b-4d88-a6e3-f4dcc331d9f2	m 514.1,476.8 -1.3,-1.8 -1.9,-1 -1.5,-1.4 -1.6,-1.2 -0.8,-0.1 -2.5,-0.9 -1.1,0.5 -1.5,0.2 -1.3,-0.4 -1.7,-0.4 -0.8,0.7 -1.8,0.7 -2.6,0.2 -2.5,-0.6 -0.9,0.4 -0.5,-0.6 -1.6,0.1 -1.3,1.1 -0.6,-0.2 -2.8,2.4 -2.8,1.8 -0.5,1.2 0.3,1.3 -1.3,1.6 1.5,0.5 1.1,1.3 1.6,1 0.1,0.9 2.5,-0.8 1.1,0.5 0.7,0.7 -0.6,2.5 1.7,0.6 0.7,2 1.8,-0.3 0.8,-1.5 0.8,0 0.2,-3.1 1.3,-0.2 1.2,0 1.4,-1.7 1.5,1.3 0.6,-0.8 1.1,-0.7 2.1,-1.8 0.3,-1.3 0.5,0.1 0.8,-1.5 0.6,-0.2 0.9,0.9 1.1,0.3 1.3,-0.8 1.4,0 2,-0.8 0.9,-0.9 1.9,0.2 z
71	41e82432-5bb2-4c9d-917f-576bc3060116	8287bea9-2349-46e4-9ac0-fb1e799497af	m 1079.1,263.8 -1.6,0.4 -1,1.5 -2.2,0.7 -0.6,-0.4 -2.3,1 -1.9,0.2 -0.3,1.2 -4.1,0.8 -1.9,-0.7 -2.6,-1.6 -0.2,2.6 -2.8,0 1.1,1.3 -1.3,4 0.8,0.1 1.2,2.1 1.6,0.8 4,2.6 4.2,1.2 1.8,-0.9 0,0 3.7,-1.6 3.2,0.2 3.8,-1.1 2.6,-4.3 1.9,-4.2 2.9,-1.3 -0.6,-1.6 -2.9,-1.7 -1,0.6 -5.5,-1.9 z
72	aa9ec671-1ab5-4aa2-8393-bcc8c189a187	68563b3e-8866-4310-bdce-659b3cc9c2ac	m 915.7,158.6 -6.9,-0.4 -7.3,2.9 -5.1,-1.5 -6.9,3 -5.9,-3.8 -6.5,0.8 -3.6,3.7 8.7,1.3 -0.1,1.6 -7.8,1.1 8.8,2.7 -4.6,2.5 11.7,1.8 5.6,0.8 3.9,-1 12.9,-3.9 6.1,-4.2 -4.4,-3.8 1.4,-3.6 z
73	5e63b010-458a-43cb-9776-1fb93f7f42ff	83f3b190-021f-4694-a033-57058c22cbf4	m 1414.1,380.1 -8.5,-4.4 -6.2,-4 -3.2,-7 4.1,0.9 -0.6,-3.3 -3,-3.3 -0.8,-5.2 -7.6,-7.5 -3.7,5.4 -5.7,1 -8.5,-1.6 -1.9,2.8 3.2,5.6 2.9,4.3 5,3.1 -3.7,3.7 1,4.5 -3.9,6.3 -2.1,6.5 -4.5,6.7 -6.4,-0.5 -4.9,6.6 4,2.9 1.3,4.9 3.5,3.2 1.8,5.5 -12,0 -3.2,4.2 7.1,5.4 1.9,2.5 -2.4,2.3 8,7.7 4,0.8 7.6,-3.8 1.7,5.9 0.8,7.8 2.5,8.1 3.6,12.3 5.8,8.8 1.3,3.9 2,8 3.4,6.1 2.2,3 2.5,6.4 3.1,8.9 5.5,6 2.2,-1.8 1.7,-4.4 5,-1.8 -1.8,-2.1 2.2,-4.8 2.9,-0.3 -0.7,-10.8 1.9,-6.1 -0.7,-5.3 -1.9,-8.2 1.2,-4.9 2.5,-0.3 4.8,-2.3 2.6,-1.6 -0.3,-2.9 5,-4.2 3.7,-4 5.3,-7.5 7.4,-4.2 2.4,-3.8 -0.9,-4.8 6.6,-1.3 3.7,0.1 0.5,-2.4 -1.6,-5.2 -2.6,-4.8 0.4,-3.8 -3.7,-1.7 0.8,-2.3 3.1,-2.4 -4.6,-3.4 1.2,-4.3 4.8,2.7 2.7,0.4 1.2,4.4 5.4,0.9 5,-0.1 3.4,1.1 -1.6,5.3 -2.4,0.4 -1.1,3.6 3.5,3.3 0.2,-4 1.5,-0.1 4.5,10.1 2.4,-1.5 -0.9,-2.7 0.9,-2.1 -0.9,-6.6 4.6,1.4 1.5,-5.2 -0.3,-3.1 2.1,-5.4 -0.9,-3.6 6.1,-4.4 4.1,1.1 -1.3,-3.9 1.6,-1.2 -0.9,-2.4 -6.1,-0.9 1.2,-2.7 -3.5,-3.9 -3.2,2.6 -4.9,-1.5 -5.3,4 -3.9,4.8 -4.2,0.8 2.7,2 0.4,3.9 -4.4,0.2 -4.7,-0.4 -3.2,1 -5.5,-2.5 -0.3,-1.2 -1.5,-5.1 -3,1.4 0.1,2.7 1.5,4.1 -0.1,2.5 -4.6,0.1 -6.8,-1.5 -4.3,-0.6 -3.8,-3.2 -7.6,-0.9 -7.7,-3.5 -5.8,-3.1 -5.7,-2.5 0.9,-5.9 2.8,-2.9 z
74	8675cde0-7eba-487d-a86e-cbfe2ee73018	a3122035-5d20-411c-a94d-17360ed55678	m 1651.9,637.3 0.5,-1.7 -1.8,-1.9 -2.8,-2 -5.3,1.3 7,4.4 2.4,-0.1 z m 20.9,-0.6 4,-4.8 0.1,-1.9 -0.5,-1.3 -5.7,2.6 -2.8,3.9 -0.7,2.1 0.6,0.8 5,-1.4 z m -35.6,-13 -1.6,2.2 -3.1,0.1 -2.2,3.6 3,0.1 3.9,-0.9 6.6,-1.2 -1.2,-2.8 -3.5,0.6 -1.9,-1.7 z m 28.1,0 -5.2,2.3 -3.8,0.5 -3.4,-1.9 -4.5,1.3 -0.2,2.3 7.4,0.8 8.6,-1.8 1.1,-3.5 z m -79.5,-8.4 -0.7,-2.3 -2.3,-0.5 -4.4,-2.4 -6.8,-0.4 -4.1,6.1 5.1,0.4 0.8,2.8 10,2.6 2.4,-0.8 4.1,0.6 6.3,2.4 5.2,1.2 5.8,0.5 5.1,-0.2 5.9,2.5 6.6,-2.4 -6.6,-3.8 -8.3,-1.1 -1.8,-4.1 -10.3,-3.1 -1.3,2.6 -10.7,-0.6 z m 146.6,-3.6 0.2,-3 -1.2,-1.9 -1.3,2.2 -1.2,2.2 0.3,4.8 3.2,-4.3 z m -41,-17.5 -1.4,-2.1 -5.7,0.3 1,2.7 3.9,1.2 2.2,-2.1 z m 18.1,-2.4 -6.1,-1.8 -6.9,0.3 -1.5,3.5 3.9,0.2 3.2,-0.4 4.6,0.5 4.7,2.6 -1.9,-4.9 z m 21,-12.3 -0.8,-2.4 -9,-2.6 -2.9,2.1 -7.6,1.5 2.3,3.2 5,1.2 2.1,3.7 8.3,0.1 0.4,1.6 -4,-0.1 -6.2,2.3 4.2,3.1 -0.1,2.8 1.2,2.3 2.1,-0.5 1.8,-3.1 8.2,5.9 4.6,0.5 10.6,5.4 2.3,5.3 1,6.9 -3.7,1.8 -2.8,5.2 7.1,-0.2 1.6,-1.8 5.5,1.3 4.6,5.2 1.5,-20.8 1,-20.7 -6,-1.2 -4.1,-2.3 -4.7,-2.2 -5,0 -6.6,3.8 -4.9,6.8 -5.7,-3.8 -1.3,-10.3 z m -50,-16.4 -1,-1.4 -5.5,4.6 -6.5,0.3 -7.1,-0.9 -4.4,-1.9 -4.7,4.8 -1.2,2.6 -2.9,9.6 -0.9,5 -2.4,4.2 1.6,4.3 2.3,0.1 0.6,6.1 -1.9,5.9 2.3,1.9 3.6,-1 0.3,-9.1 -0.2,-7.4 3.8,-1.9 -0.7,6.2 3.9,3.7 -0.8,2.5 1.3,1.7 5.6,-2.4 -3,5.2 2.1,2.2 3.1,-1.9 0.3,-4.1 -4.7,-7.4 1.1,-2.2 -5.1,-8.1 5,-2.5 2.6,-3.7 2.4,0.9 0.5,-2.9 -10.5,2.1 -3.1,2.9 -5,-5.6 0.9,-4.8 4.9,-1 9.3,-0.3 5.4,1.3 4.3,-1.3 4.4,-6.3 z m 19.4,1.9 -0.6,-2.6 -3.3,-0.6 -0.5,-3.5 -1.8,2.3 -1,5.1 1.7,8.2 2.2,4 1.6,-0.8 -2.3,-3.3 0.9,-3.9 2.9,0.6 0.2,-5.5 z m -60.9,-4.5 0.9,-2.9 -4.3,-6 3,-5.8 -5,-1 -6.4,0 -1.7,7.2 -2,2.2 -2.7,8.9 -4.5,1.3 -5.4,-1.8 -2.7,0.6 -3.2,3.2 -3.6,-0.4 -3.6,1.2 -3.9,-3.5 -1,-4.3 -3.3,4.2 -0.6,5.9 0.8,5.6 2.6,5.4 2.8,1.8 0.7,8.5 4.6,0.8 3.6,-0.4 2,3.1 6.7,-2.3 2.8,2 4,0.4 2,3.9 6.5,-2.9 0.8,2.3 2.5,-9.7 0.3,-6.4 5.5,-4.3 -0.2,-5.8 1.8,-4.3 6.7,-0.8 -6.5,-5.9 z m -68.7,48.9 0.7,-9.8 1.7,-8 -2.6,-4 -4.1,-0.5 -1.9,-3.6 -0.9,-4.4 -2,-0.2 -3.2,-2.2 2.3,-5.2 -4.3,-2.9 -3.3,-5.3 -4.8,-4.4 -5.7,-0.1 -5.5,-6.8 -3.2,-2.7 -4.5,-4.3 -5.2,-6.2 -8.8,-1.2 -3.6,-0.3 0.6,3.2 6.1,7 4.4,3.6 3.1,5.5 5.1,4 2.2,4.9 1.7,5.5 4.9,5.3 4.1,8.9 2.7,4.8 4.1,5.2 2.2,3.8 7,5.2 4.5,5.3 6.2,-0.1 z
75	7f2de6fa-7b08-48d0-8acf-76f623266258	1baa5d83-2707-4a0d-8f86-45efc106dffd	m 1213.5,324.4 -3.2,-2.9 -1.2,-2.4 -3.3,1.8 2.9,7.3 -0.7,2 3.7,5.2 0,0 4.7,7.8 3.7,1.9 1,3.8 -2.3,2.2 -0.5,5 4.6,6.1 7,3.4 3.5,4.9 -0.2,4.6 1.7,0 0.5,3.3 3.4,3.4 1.7,-2.5 3.7,2.1 2.8,-1 5.1,8.4 4.3,6.1 5.5,1.8 6.1,4.9 6.9,2.1 5.1,-3.1 4,-1.1 2.8,1.1 3.2,7.8 6.3,0.8 6.1,1.5 10.5,1.9 1.2,-7.4 7.4,-3.3 -0.9,-2.9 -2.7,-1 -1,-5.7 -5.6,-2.7 -2.8,-3.9 -3.2,-3.3 3.9,-5.8 -1.1,-4 -4.3,-1.1 -1.1,-4 -2.7,-5.1 1.6,-3.5 -2.5,-0.9 0.5,-4.7 0.5,-8 -1.6,-5.5 -3.9,-0.2 -7.3,-5.7 -4.3,-0.7 -6.5,-3.3 -3.8,-0.6 -2.1,1.2 -3.5,-0.2 -3,3.7 -4.4,1.2 -0.2,1.6 -7.9,1.7 -7.6,-1.1 -4.3,-3.3 -5.2,-1.3 -2.5,-4.8 -1.3,0.3 -3.8,-3.4 1.2,-3.1 -1.9,-1.9 -1.9,0.5 -5.3,4.7 -1.8,0.2 -3.7,-0.9 z
76	58e32b10-a8fd-4c57-93bf-61b9b2b96bab	e130f15d-7a37-4ddf-a6b5-e9c1266e128a	m 1207.3,334.9 -6.2,-0.9 -2.1,1 -2.1,4.1 -2.7,1.6 1.2,4.7 -0.9,7.8 -11,6.7 3.1,7.7 6.7,1.7 8.5,4.5 16.7,12.7 10.2,0.5 3.2,-6.1 3.7,0.5 3.2,0.4 -3.4,-3.4 -0.5,-3.3 -1.7,0 0.2,-4.6 -3.5,-4.9 -7,-3.4 -4.6,-6.1 0.5,-5 2.3,-2.2 -1,-3.8 -3.7,-1.9 -4.7,-7.8 0,0 -2.3,1.1 -2.1,-1.6 z
78	a6169fdf-f321-4788-9ba2-1529f6baafb1	fc3338b4-47f1-4342-8def-3acabc77a994	m 1167.8,360.5 -1.4,0.1 -0.4,1.1 -1.8,0 -0.1,0.1 -0.6,1.6 -0.6,4.8 -1.1,2.9 0.4,0.4 -1.4,2.1 0,0 3.9,9.2 0.7,1.7 1.7,-10.2 -0.4,-2.4 -2.4,0.8 0.1,-1.7 1.2,-0.8 -1.4,-0.7 0.7,-4.3 2,0.9 0.7,-2 -0.1,0 0.6,-1 -0.3,-2.6 z
79	6f16f81e-a2f6-44ad-bec2-45c3f31fa105	161a32a0-755e-430b-86dc-8f153f7de9b1	m 1057.8,328.6 -4,0.5 -5.2,0.7 -6.2,-0.6 -0.6,3.4 7.5,3.3 2.7,0.7 4.2,2.4 0.9,-3.3 -0.9,-2 1.6,-5.1 z m -33.7,-18.9 -2.5,1.9 -2.8,-0.3 1.3,3.6 0.4,7.6 2.1,1.7 2,-2.1 2.4,0.4 0.4,-8.4 -3.3,-4.4 z m 14.3,-34.3 -1.3,-2.2 -4.8,1.1 -0.5,1.2 -3.1,-0.9 -0.3,2.5 -2.1,1.1 -3.8,-0.8 -0.9,2.5 -2.4,0.2 -0.9,-1 -2.7,2.1 -2.4,0.3 -2.2,-1.3 -0.2,1.7 1.6,2.4 -1.7,1.8 1.5,4.8 2.7,0.8 -0.5,2.7 2.1,-0.5 2.8,-2.8 2.3,-0.9 4.2,2.1 2.6,0.7 1.9,6 3.6,3.6 4.9,4 4.2,2.8 3.9,0.4 2.3,2.5 3.4,1.2 1.7,2.7 2.2,0.8 1.8,3.2 2.3,3.7 -1.1,1.3 -0.8,3.5 0.1,2 2.1,-0.5 2.5,-5.6 2.1,-0.4 0.4,-3.3 -3.9,-2.3 1.9,-4.1 4.5,1 3.1,3 0.8,-2.3 -0.6,-1.2 -4.7,-3.2 -3.9,-1.9 -4.8,-2.3 1.4,-1.2 -1.4,-1.4 -4,0.1 -6,-5 -2.9,-5.1 -4.9,-3.1 -1.9,-3.1 0.5,-1.8 -0.4,-3 3.9,-2.2 4.1,0.9 -1.4,-2.7 0.3,-3 -7.2,-1.6 z
80	60ab4beb-0e9a-45f7-9a95-6afcd08ce9f9	31d93d6a-5130-4cfa-87ba-90d971d98d34	m 946.5,506.2 -2.3,0.9 -1.3,0.8 -0.9,-2.7 -1.6,0.7 -1,-0.1 -1,1.9 -4.3,-0.1 -1.6,-1 -0.7,0.6 -1.1,0.5 -0.5,2.2 1.3,2.6 1.3,5.1 -2,0.8 -0.6,0.9 0.4,1.2 -0.3,2.8 -0.9,0 -0.3,1.8 0.6,3.1 -1.2,2.8 1.6,1.8 1.8,0.4 2.3,2.7 0.2,2.5 -0.5,0.8 -0.5,5.2 1.1,0.2 5.6,-2.4 3.9,-1.8 6.6,-1.1 3.6,-0.1 3.9,1.3 2.6,-0.1 0.2,-2.5 -2.4,-5.5 1.5,-7.2 2.3,-5.3 -1.4,-9.1 -3.8,-1.6 -2.7,0.2 -1.9,1.6 -2.5,-1.3 -1,-2.1 -2.5,-1.4 z
81	454df98c-8158-40f5-bfd2-c5310bbf9fb6	96abeca6-c08e-4df8-b22f-2fefc55a8d5b	m 550.7,458.5 3.9,-0.1 -0.8,-1.8 -2.7,-1.5 -3.7,-0.6 -1.2,-0.2 -2.4,0.4 -0.8,1.5 2.9,2.3 3,1 1.8,-1 z
82	83d69b0f-ed2b-4bc1-972a-f7157087e7b1	8e5a125d-73cb-45c1-a511-f0c65d7448e7	m 1692.5,354.9 -4.5,-1.3 -1.1,2.7 -3.3,-0.8 -1.3,3.8 1.2,3 4.2,1.8 -0.1,-3.7 2.1,-1.5 3.1,2.1 1.3,-3.9 -1.6,-2.2 z m 24.4,-19.3 -3.6,-6.7 1.3,-6.4 -2.8,-5.2 -8.1,-8.7 -4.8,1.2 0.2,3.9 5.1,7.1 1,7.9 -1.7,2.5 -4.5,6.5 -5,-3.1 0,11.5 -6.3,-1.3 -9.6,1.9 -1.9,4.4 -3.9,3.3 -1.1,4 -4.3,2 4,4.3 4.1,1.9 0.9,5.7 3.5,2.5 2.5,-2.7 -0.8,-10.8 -7.3,-4.7 6.1,-0.1 5,-3 8.6,-1.4 2.4,4.8 4.6,2.4 4.4,-7.3 9.1,-0.4 5.4,-3 0.6,-4.6 -2.5,-3.2 -0.6,-5.2 z m -11.8,-44.2 -5.3,-2.1 -10.4,-6.4 1.9,4.8 4.3,8.5 -5.2,0.4 0.6,4.7 4.6,6.1 5.7,0 -1.6,-6.8 10.8,4.2 0.4,-6.1 6.4,-1.7 -6,-6.9 -1.7,2.6 -4.5,-1.3 z
83	19f2a1f2-4bf3-482e-8f2e-0ee950a18fe9	c728bbe4-373f-4d0a-9a3f-985679759733	m 1186.6,367.6 -3.1,-7.7 -9.6,6.7 -6.3,-2.5 -0.7,2 0.4,3.9 -0.6,1.9 0.4,2.4 -1.7,10.2 0.3,0.9 6.1,1 2.1,-2 1.1,-2.3 4,-0.8 0.7,-2.2 1.7,-1 -6.1,-6.4 10.4,-3.1 0.9,-1 z
84	92482d61-2979-4f42-bcb9-e45953890383	c6a8ea7c-3fed-4a1d-9929-5569db7ab968	m 1308.8,223.8 -9,-1.3 -3.1,2.5 -10.8,2.2 -1.7,1.5 -16.8,2.1 -1.4,2.1 5,4.1 -3.9,1.6 1.5,1.7 -3.6,2.9 9.4,4.2 -0.2,3 -6.9,-0.3 -0.8,1.8 -7.3,-3.2 -7.6,0.2 -4.3,2.5 -6.6,-2.4 -11.9,-4.3 -7.5,0.2 -8.1,6.6 0.7,4.6 -6,-3.6 -2.1,6.8 1.7,1.2 -1.7,4.7 5.3,4.3 3.6,-0.2 4.2,4.1 0.2,3.2 2.8,1 4.4,-1.3 5,-2.7 4.7,1.5 4.9,-0.3 1.9,3.9 0.6,6 -4.6,-0.9 -4,1 0.9,4.5 -5,-0.6 0.6,2 3.2,1.6 3.7,5.5 6.4,2.1 1.5,2.1 -0.7,2.6 0.7,1.5 1.8,-2 5.5,-1.3 3.8,1.7 4.9,4.9 2.5,-0.3 -6.2,-22.8 11.9,-3.6 1.1,0.5 9.1,4.5 4.8,2.3 6.5,5.5 5.7,-0.9 8.6,-0.5 7.5,4.5 1.5,6.2 2.5,0.1 2.6,5 6.6,0.2 2.3,3 1.9,0 0.9,-4.5 5.4,-4.3 2.5,-1.2 0.3,-2.7 3.1,-0.8 9.1,2.1 -0.5,-3.6 2.5,-1.3 8.1,2.6 1.6,-0.7 8.6,0.2 7.8,0.6 3.3,2.2 3.5,0.9 -1.7,-3.5 2.9,-1.6 -8.7,-10.7 9,-2.4 2,-1.4 -1,-11.1 10.7,2 1.6,-2.8 -2.5,-6.2 3.8,-0.6 1.8,-4.2 -4.3,-3.8 -6,0.9 -3.3,-2.6 -3.9,-1.2 -4.1,-3.6 -3.2,-1.1 -6.2,1.6 -8.3,-3.6 -1.1,3.3 -18.1,-15.5 -8.3,-4.7 0.8,-1.9 -9.1,5.7 -4.4,0.4 -1.2,-3.3 -7,-2.1 -4.3,1.5 -4.3,-6.3 z
85	0cb41121-15fa-47cf-b1fe-a0bdba3da66b	e91cae72-f62c-407e-b388-3f3b86f7a0c3	m 1211.7,547.2 -3.8,0 -2.3,-2.1 -5.1,2.6 -1.6,2.7 -3.8,-0.5 -1.2,-0.7 -1.3,0.1 -1.8,0 -7.2,-5.4 -3.9,0 -2,-2.1 0,-3.6 -2.9,-1.1 -3.8,4.2 -3.4,3.8 2.7,4.4 0.7,3.2 2.6,7.3 -2.1,4.7 -2.7,4.2 -1.6,2.6 0,0.3 1.4,2.4 -0.4,4.7 20.2,13 0.4,3.7 8,6.3 2.2,-2.1 1.2,-4.2 1.8,-2.6 0.9,-4.5 2.1,-0.4 1.4,-2.7 4,-2.5 -3.3,-5.3 -0.2,-23.2 4.8,-7.2 z
86	bc0d7ea0-c655-4fd0-9bd9-15424770306e	ab2a946c-f1e3-43f5-bbfd-4b54adae333a	m 1235.6,381.4 -3.7,-0.5 -3.2,6.1 4.9,0.6 1.7,3.1 3.8,-0.2 -2.4,-4.8 0.3,-1.5 -1.4,-2.8 z
87	1494d5eb-d1a9-4684-99d7-04804cc364ad	6cec735b-3406-430f-be56-71d96ff8f41e	m 1387.2,302.6 -3.5,-0.9 -3.3,-2.2 -7.8,-0.6 -8.6,-0.2 -1.6,0.7 -8.1,-2.6 -2.5,1.3 0.5,3.6 -9.1,-2.1 -3.1,0.8 -0.3,2.7 1.8,0.6 -3.1,4.1 4.6,2.3 3.2,-1.6 7.1,3.3 -5.2,4.5 -4.1,-0.6 -1.4,2 -5.9,-1.1 0.6,3.7 5.4,-0.5 7.1,2 9.5,-0.9 1,-1.5 -1.1,-1.5 4,-3 3.2,-1.2 5.7,0.9 0.6,-4 6.4,-0.8 1,-2.4 6.8,-3.4 0.2,-1.4 z
88	f4b1dbba-e19b-4c38-bc53-632027c62a0a	85b0fd58-f24b-4249-a31c-46e40023744c	m 1102.1,210.1 -3.8,0 -4.4,-2.2 -2.1,-0.7 -3.7,1 -0.2,4.6 -3.6,0.1 -4.4,-4.5 -4,2.1 -1.7,3.7 0.5,4.5 5,-1.9 7.9,0.4 4.4,-0.6 0.9,1.3 2.5,0.4 5,2.9 2.6,-1 4.6,-2.3 -2.1,-3.6 -1,-2.8 -2.4,-1.4 z
89	c1c212c4-4642-4fd8-9ec4-d4af78661626	6a6a8869-35f4-4d7f-af9f-c881d3b4bc19	m 1167.8,360.5 0.9,-3.5 2.6,-2.4 -1.2,-2.5 -2.4,-0.3 -0.1,0.2 -2.1,4.5 -1.3,5.2 1.8,0 0.4,-1.1 1.4,-0.1 z
90	9e7a9a17-2460-4ee4-8d80-cf6b8bb65908	f7ca89ef-b000-416a-b9f4-6059b2d8a3ca	m 1128.1,766.5 1.1,-2 3.1,-1 1.1,-2.1 1.9,-3.1 -1.7,-1.9 -2.3,-2 -2.6,1.3 -3.1,2.5 -3.2,4 3.7,4.9 2,-0.6 z
91	a7c9fbf6-be01-4dc8-92a9-5b89855abc12	e3c9a7c1-e5ec-46aa-be24-13a63b23c24a	m 929.4,523.3 -1.6,-0.2 -1.1,2.6 -1.6,-0.1 -1.1,-1.3 0.4,-2.6 -2.3,-3.9 -1.5,0.7 -1.2,0.2 -2.6,3 -2.6,3.4 -0.3,1.9 -1.3,2 3.7,4.1 4.8,3.5 5.1,4.8 5.7,3.1 1.5,-0.1 0.5,-5.2 0.5,-0.8 -0.2,-2.5 -2.3,-2.7 -1.8,-0.4 -1.6,-1.8 1.2,-2.8 -0.6,-3.1 0.3,-1.8 z
92	08f21efd-f287-4518-a482-043292e35f4f	a9bc64d6-1f2e-4882-90bc-4930614667da	m 1111.8,371.4 -1.5,-2.1 -5.4,-0.8 -1.8,-1.1 -2,0 -2,-2.8 -7.3,-1.3 -3.6,0.8 -3.7,3 -1.5,3.1 1.5,4.8 -2.4,3 -2.5,1.6 -5.9,-3.1 -7.7,-2.7 -4.9,-1.2 -2.8,-5.7 -7.2,-2.8 -4.5,-1.1 -2.2,0.6 -6.4,-2.2 -0.1,4.9 -2.6,1.8 -1.5,2 -3.7,2.5 0.7,2.6 -0.4,2.7 -2.6,1.4 1.9,5.6 0.4,3 -0.9,5.2 0.5,2.9 -0.6,3.5 0.5,4 -2.1,2.6 3.4,4.7 0.2,2.7 2,3.6 2.6,-1.2 4.3,2.9 2.5,4 8.8,2.8 3.1,3.5 3.9,-2.4 5.4,-3.5 22.3,12.2 22.4,12.2 0,-2.7 6.3,0 -0.5,-12.7 -1,-23.4 -1.3,-22.7 -2,-5.1 1.2,-3.9 -1.1,-2.7 1.8,-3 z
93	b6adbc40-2a0a-45bd-a3bf-11be8d0e4a59	d4d24a30-2184-4fd3-8315-248ddc094526	m 1100.4,221.2 -5,-2.9 -2.5,-0.4 -0.9,-1.3 -4.4,0.6 -7.9,-0.4 -5,1.9 1.7,5 5,1.1 2.2,0.9 -0.2,1.7 0.6,1.5 2.5,0.6 1.4,1.9 4.6,0 4.8,-2.2 0.5,-3.4 3.5,-2 -0.9,-2.6 z
94	2a95ef6e-252d-4bfc-937e-84c58021b835	a94b35b0-c269-4e9f-9d66-80d8f3081989	m 1007,258.6 0.2,-2.7 -1,-1.4 -1.3,0.2 -0.4,3.5 1.1,0.5 1.4,-0.1 z
95	84b0977e-867d-43a9-801e-f364c3f40c89	b7206cc1-2cca-454d-9447-3788640f7b5e	m 1255.7,658.4 -1.1,-4.2 -1.4,-2.7 -1.8,-2.7 -2,2.8 -0.3,3.8 -3.3,4.5 -2.3,-0.8 0.6,2.7 -1.8,3.2 -4.8,3.9 -3.4,3.7 -2.4,0 -2.2,1.2 -3.1,1.3 -2.8,0.2 -1,4.1 -2.2,3.5 0.1,5.9 0.8,4 1.1,3 -0.8,4.1 -2.9,4.8 -0.2,2.1 -2.6,1.1 -1.3,4.6 0.2,4.6 1.6,5 -0.1,5.7 1.2,3.3 4.2,2.3 3,1.7 5,-2.7 4.6,-1.5 3.1,-7.4 2.8,-8.9 4.3,-12 3.3,-8.8 2.7,-7.4 0.8,-5.4 1.6,-1.5 0.7,-2.7 -0.8,-4.7 1.2,-1.9 1.6,3.8 1.1,-1.9 0.8,-3.1 -1.3,-2.9 -0.5,-7.7 z
96	12eb7b56-0fbf-4213-a18a-56fca4c62c42	413fe813-55c0-49e9-8853-47654b4ae73b	m 1169.2,661.5 0.1,-2.3 -1.2,-1.9 0.1,-2.8 -1.5,-4.7 1.7,-3.5 -0.1,-7.7 -1.9,-4.1 0.2,-0.7 0,0 -1.1,-1.7 -5.4,-1.2 2.6,2.8 1.2,5.4 -1,1.8 -1.2,5.1 0.9,5.3 -1.8,2.2 -1.9,5.9 2.9,1.7 3,3 1.6,-0.6 2.1,1.6 0.3,2.6 -1.3,2.9 0.2,4.5 3.4,4 1.9,-4.5 2.5,-1.3 -0.1,-8.2 -2.2,-4.6 -1.9,-2 -0.3,0 0,0.8 1.1,0.3 1,3.4 -0.2,0.8 -1.9,-2.5 -1,1.6 -0.8,-1.4 z
97	b0a00a30-f30a-4957-b380-4a0fdf25b169	d42ac9fd-1e10-4995-8dc1-4d25cee7a022	m 1543.6,532.7 -4.7,-2.8 -0.9,1.1 1.4,2.7 -0.4,4.7 2.1,3.4 1,5.3 3.4,4.3 0.8,3.2 6.7,5 5.4,4.8 4,-0.5 0.1,-2.1 -2.3,-5.6 -2.1,-1.8 -0.5,-3.8 -0.6,-2.1 0.5,-2.9 -0.5,-4.3 -2.6,-4.3 -3.5,-3.8 -1.3,-0.6 -1.7,2.6 -3.7,0.8 -0.6,-3.3 z m 99,11 -1.2,-3.1 3.8,-0.4 0.3,-2.4 -4.8,-2 -3.8,-1.7 -0.4,-2.8 -3.1,-3.2 -2.3,0 -2.5,5 -4.1,4.4 -0.1,3.1 -0.1,4.1 -2.7,-0.2 -1.1,2.2 -2.7,-3.3 -2.6,4 -3.8,5 -6.7,1.4 -2.4,1.2 -0.9,5.4 -4.4,1.2 -4.1,-2.2 1,4.3 3.9,3.5 3.6,-1.2 3.6,0.4 3.2,-3.2 2.7,-0.6 5.4,1.8 4.5,-1.3 2.7,-8.9 2,-2.2 1.7,-7.2 6.4,0 5,1 4,-2.1 z
98	8e86cb0a-db55-4f43-a668-6d4b89b981fe	2b8d132e-e3b8-4a97-aa78-a265bf65836d	m 1389.1,551.6 0.1,-0.1 0,-0.2 -0.1,-0.1 -0.1,0 -0.1,0.2 0,0.1 0,0.1 0.2,0 z m 0.3,-5.9 0.1,-0.2 0,-0.1 0,-0.1 0,-0.1 0,-0.1 -0.1,0.1 -0.1,0.2 0,0.1 -0.1,0.1 0,0.1 0.1,0 0.1,0 z
99	18f2821b-6c13-43bd-91e1-03bce50fc09d	a8c0bf67-69a5-4293-8282-622c6b61962c	m 1000.3,450.3 -6.1,0.6 -0.1,-4 -2.6,-1.1 -3.4,-1.8 -1.3,-3 -18.6,-13.8 -18.4,-13.9 -8.4,0.1 2.4,27.4 2.4,27.5 1,0.8 -1.3,4.4 -22.3,0.1 -0.9,1.4 -2.1,-0.4 -3.2,1.3 -3.8,-1.8 -1.8,0.2 -1,3.7 -1.9,1.2 0.2,3.9 1.1,3.7 2.1,1.8 0.4,2.4 -0.3,2 0.3,2.3 0.9,0 1.5,-0.8 0.9,0.2 1.5,1.6 2.4,0.5 1.6,-1.4 1.8,-0.8 1.3,-0.9 1.1,0.2 1.3,1.4 0.6,1.7 2.3,2.7 -1.2,1.6 -0.2,2.1 1.2,-0.6 0.7,0.7 -0.3,1.9 1.7,1.8 0.7,-0.6 1.6,1 4.3,0.1 1,-1.9 1,0.1 1.6,-0.7 0.9,2.7 1.3,-0.8 2.3,-0.9 -0.4,-3.7 1.6,-2.7 -0.2,-2.2 4.5,-5.2 0.8,-4.4 1.6,-1.6 2.7,0.9 2.3,-1.3 0.8,-1.6 4.3,-2.9 1.1,-2 5.2,-2.6 3,-0.9 1.4,1.2 3.6,0 3.6,-0.3 2,-2.2 7.6,-0.6 4.9,-1 0.5,-3.9 3,-4.3 -0.1,-14.6 z
100	eef8592e-f1ce-4bd8-87dd-539d839df98e	ca8f94ef-b748-47c8-b040-b996e3cf2581	m 1053.6,344 -0.2,-0.2 -0.5,-0.5 -0.5,-0.1 0.1,0.6 0.4,0.4 0.5,0 0.2,-0.2 z m -1.4,-1.2 0,0 0,-0.2 -0.3,-0.1 -0.4,0.1 0.1,0.1 0.3,0.2 0.3,-0.1 z
101	a9fea452-37ce-4044-8666-8f4defd1ff08	a4d1f62b-6131-44de-92fe-975d0a463bc7	m 949.8,413.3 -20.3,-15.5 -0.2,9.7 -17.9,-0.3 -0.2,16.3 -5.2,0.5 -1.4,3.3 0.9,9.2 -21.6,-0.1 -1.2,2.2 2.8,2.7 1.4,3 -0.7,3.2 0.6,3.2 0.5,6.3 -0.8,5.9 -1.7,3.2 0.4,3.4 2,-2 2.7,0.5 2.8,-1.4 3.1,0 2.6,1.8 3.7,1.7 3.2,4.7 3.6,4.4 1.9,-1.2 1,-3.7 1.8,-0.2 3.8,1.8 3.2,-1.3 2.1,0.4 0.9,-1.4 22.3,-0.1 1.3,-4.4 -1,-0.8 -2.4,-27.5 -2.4,-27.4 8.4,-0.1 z
102	d20dd929-321c-4ceb-a8a8-4c88dba5ef90	59a60488-bbd7-476a-813e-a92fa901e8e7	m 1294.7,702.5 0.3,-0.3 0.2,-0.4 0.3,-0.3 0.1,-0.7 -0.2,-0.8 -0.4,-0.7 -0.5,0.1 -0.3,0.4 -0.2,0.5 -0.5,0.3 -0.1,0.3 -0.2,0.7 -0.1,0.4 -0.2,0.1 0,0.2 0.3,0.3 0.8,0.1 0.7,-0.2 z
103	86f01942-b930-4225-b488-1ca4b8ca71b2	846ec109-79bc-4e46-a303-40e20bcb2f36	m 444.4,407.8 -3.6,-1.4 -3.9,-2 -0.8,-3 -0.2,-4.5 -2.4,-3.6 -1,-3.7 -1.6,-4.4 -3.1,-2.5 -4.4,0.1 -4.8,5 -4,-1.9 -2.2,-1.9 -0.4,-3.5 -0.8,-3.3 -2.4,-2.8 -2.1,-2 -1.3,-2.2 -9.3,0 -0.8,2.6 -4.3,0 -10.7,0 -10.7,-4.4 -7.1,-3.1 1,-1.3 -7,0.7 -6.3,0.5 0.2,5.7 0.7,5.1 0.7,4.1 0.8,4 2.6,1.8 2.9,4.5 -1,2.9 -2.7,2.3 -2.1,-0.3 -0.6,0.5 2.3,3.7 2.9,1.5 1,1.7 0.9,-0.9 3.1,2.9 2.1,2 0.1,3.4 -1.2,4.7 2.5,1.6 3.3,3.1 2.9,3.6 0.7,3.9 1,0 2.7,-2.3 0.4,-1.2 -1.5,-2.8 -1.6,-2.9 -2.6,-0.2 0.4,-3.4 -0.9,-3 -1,-2.8 -0.5,-5.9 -2.6,-3.2 -0.6,-2.3 -1.2,-1.6 0,-4.1 -1,0.1 -0.1,-2.2 -0.7,-0.5 -0.4,-1.4 -2.7,-4.4 -1.1,-2.6 1,-4.8 0.1,-3 1.8,-2.6 2.4,1.7 1.9,-0.2 3.1,2.5 -0.9,2.4 0.4,4.9 1.5,4.7 -0.4,2 1.7,3.1 2.3,3.4 2.7,0.5 0.3,4.4 2.4,3.1 2.5,1.5 -1.8,4 0.7,1.5 4.1,2.6 1.9,4 4.5,4.9 3.8,6.4 1.3,3.2 0,2.5 1.4,2.9 -0.3,2.2 -1.6,1.6 0.3,1.8 -1.9,0.7 0.8,3.1 2.2,4 5.3,3.6 1.9,2.9 5.4,2 3,0.4 1.2,1.7 4.2,3 5.9,3 4,0.9 4.8,2.9 4,1.2 3.7,1.7 2.9,-0.7 4.8,-2.4 3.1,-0.4 4.4,1.6 2.6,2.1 5.5,6.9 0.4,-1.9 0.8,-1.5 -0.7,-1.2 3.3,-5.2 7.1,0 0.4,-2.1 -0.8,-0.4 -0.5,-1.4 -1.9,-1.5 -1.8,-2.1 2.6,0 0.4,-3.6 5.2,0 5.1,0.1 0.1,-1 0.7,-0.3 0.9,0.8 2.5,-3.9 1,0 1.2,-0.1 1.2,1.6 2,-5 1.2,-2.7 -0.9,-1.1 1.8,-3.9 3.5,-3.8 0.6,-3.1 -1.2,-1.3 -3.4,0.5 -4.8,-0.2 -6,1.5 -4,1.7 -1.2,1.8 -1.2,5.4 -1.8,3.7 -3.9,2.6 -3.6,1.1 -4.3,1.1 -4.3,0.6 -5.1,1.8 -1.9,-2.6 -5.6,-1.7 -1.8,-3.2 -0.7,-3.6 -3,-4.7 -0.4,-5 -1.2,-3.1 -0.5,-3.4 1.1,-3.1 1.8,-8.6 1.8,-4.5 3.1,-5.6 -2.1,0.2 z
104	0e7d49a6-0af8-4b4e-b3d5-59664cd320d6	6f37afd2-3170-4c9d-8fde-28d6a44eda0d	m 1118.5,283.3 1.2,-0.7 0.5,-2.1 1.1,-2 -0.5,-1.1 1,-0.5 0.6,0.9 3,0.2 1.2,-0.5 -1,-0.6 0.2,-1 -2,-1.5 -1.1,-2.6 -1.9,-1.1 0,-2.1 -2.5,-1.6 -2,-0.3 -3.9,-1.9 -3.2,0.6 -1.1,0.9 1.6,0.6 1.8,1.9 1.9,2.6 3.4,3.7 0.6,2.7 -0.2,2.7 1.3,2.8 z
105	f72bca3f-dd05-4a75-abbd-f8c3e94f8763	b60fe946-71ac-40be-97dc-8ee0b78c3384	m 1473.7,252.1 -3.7,-4.6 -6.6,-1.5 -4.8,-0.8 -6.9,-2.5 -1.3,6.4 4,3.6 -2.4,4.3 -7.9,-1.6 -5,-0.2 -4.7,-2.9 -5.1,-0.1 -5.3,-1.9 -5.9,2.9 -6.6,5.4 -4.7,1 3.3,4.4 5.7,3.3 8.1,2.3 5.8,5 1.3,7.3 3,2.7 6.4,1 7.2,0.9 7.9,3.8 3.4,0.7 4.9,5.7 4.7,3.6 5.5,-0.1 11.2,1.3 6.4,-0.8 5.5,0.9 9.3,3.8 6.2,-0.1 3.2,2 4.4,-3.3 7.2,-2.2 7.5,-0.2 4.9,-2.2 1.9,-3.3 2.5,-2 -1.9,-2.1 -2.9,-2.3 0.4,-4 3.2,0.5 5.9,1.3 3.1,-3.3 6.3,-2.4 1.4,-4.1 2.4,-1.8 6.8,-0.8 4.3,0.7 -0.7,-2.2 -7.2,-4.3 -5.1,-2 -2.5,2.3 -5.4,-1 -2.4,0.8 -2.7,-2.6 -0.3,-6.2 -0.6,-4.6 -5.5,0.5 -3.9,-2.1 -3.3,-0.7 -4.5,4.4 -5.8,1 -3.6,1.6 -6.7,-1 -4.5,0 -4.9,-3.1 -6.5,-3 -5.4,-0.8 -5.7,0.8 -3.9,1.1 -8.4,-2.6 z
106	e7b6ec02-07b9-45af-998a-befc95ed4eb0	6702177a-fbed-4cf3-aa32-22da244beab0	m 1080,299.8 0.4,-0.6 -2,-1.2 -1.8,-0.7 -0.8,-0.8 -1.5,-1.1 -0.9,0.6 -1.5,1.4 -0.4,3.4 -0.5,1 0,0 2.3,1.2 1.6,2.1 1.1,0.4 0,0 -0.5,-1.9 2,-3.1 0.4,1.2 1.3,-0.5 0.8,-1.4 z
107	e2b4b837-f9f5-49de-a783-da635a0708df	a7462d3b-b094-454a-a09c-08573a566463	m 965.2,348.4 -2.3,-0.1 -5.5,-1.4 -5,0.4 -3.1,-2.7 -3.9,0 -1.8,3.9 -3.7,6.7 -4,2.6 -5.4,2.9 -3.5,4.3 -0.9,3.4 -2.1,5.4 1.1,7.9 -4.7,5.3 -2.7,1.7 -4.4,4.4 -5.1,0.7 -2.8,2.4 -0.1,0.1 -3.6,6.5 -3.7,2.3 -2.1,4 -0.2,3.3 -1.6,3.8 -1.9,1 -3.1,4 -2,4.5 0.3,2.2 -1.9,3.3 -2.2,1.7 -0.3,3 0.1,0 12.4,-0.5 0.7,-2.3 2.3,-2.9 2,-8.8 7.8,-6.8 2.8,-8.1 1.7,-0.4 1.9,-5 4.6,-0.7 1.9,0.9 2.5,0 1.8,-1.5 3.4,-0.2 -0.1,-3.4 0,0 0.8,0 0.1,-7.5 8.9,-4.7 5.4,-1 4.4,-1.7 2.1,-3.2 6.3,-2.5 0.3,-4.7 3.1,-0.5 2.5,-2.4 7,-1 1,-2.5 -1.4,-1.4 -1.8,-6.7 -0.3,-3.9 -2,-4.1 z
108	2c5c6b54-f40a-4740-99e3-ed4331d7e28b	95251d34-e411-4cb7-9112-0a1f95b239e0	m 1203,640.7 -0.8,-2.9 0,0 0,0 -4.6,3.7 -6.2,2.5 -3.3,-0.1 -2.1,1.9 -3.9,0.1 -1.4,0.8 -6.7,-1.8 -2.1,0.3 -1.6,6 0.7,7.3 0.3,0 1.9,2 2.2,4.6 0.1,8.2 -2.5,1.3 -1.9,4.5 -3.4,-4 -0.2,-4.5 1.3,-2.9 -0.3,-2.6 -2.1,-1.6 -1.6,0.6 -3,-3 -17.1,5.2 0.3,4.5 0.3,2.4 4.6,-0.1 2.6,1.3 1.1,1.6 2.6,0.5 2.8,2 -0.3,8.1 -1.3,4.4 -0.5,4.7 0.8,1.9 -0.8,3.7 -0.9,0.6 -1.6,4.6 -6.2,7.2 2.2,9 1.1,4.5 -1.4,7.1 0.4,2.3 0.6,2.9 0.3,2.8 4.1,0 0.7,-3.3 -1.4,-0.5 -0.3,-2.6 2.6,-2.4 6.8,-3.4 4.6,-2.2 2.5,-2.3 0.9,-2.6 -1.2,-1.1 1.1,-3 0.5,-6.2 -1,0.3 0,-1.9 -0.8,-3.7 -2.4,-4.8 0.7,-4.6 2.3,-1.4 4.1,-4.6 2.2,-1.1 6.7,-6.8 6.4,-3.1 5.2,-2.5 3.7,-3.9 2.4,-4.4 1.9,-4.6 -0.9,-3.1 0.2,-9.9 -0.4,-5.6 0.4,-6.3 z
141	72dd1a0c-10de-4138-8c89-3bc64ab31697	2dd507e0-8e57-4924-a57f-8fc2e22555e2	m 1087.4,260.9 -4.9,-2.3 -3.4,0.8 -2.4,-0.6 -2.8,1.3 -2.7,-2.2 -1.9,0.9 -0.3,-0.4 -1.5,0 -0.6,1.1 -1.1,0.3 -0.2,1.4 -0.9,0.3 -0.1,0.6 -1.6,0.6 -2.2,-0.1 -0.6,1.4 -0.3,0.8 0.7,2.1 2.6,1.6 1.9,0.7 4.1,-0.8 0.3,-1.2 1.9,-0.2 2.3,-1 0.6,0.4 2.2,-0.7 1,-1.5 1.6,-0.4 5.5,1.9 1,-0.6 0.7,-2.5 1.1,-1.7 z
109	b9761f4c-55b7-41dd-8a4a-ee7e8875a6fa	ac8b13ec-0d98-4fad-852e-a351d68e6a16	m 1533.9,435.8 -0.6,-2.6 -3.8,1.8 -2.5,-1.2 -4.5,-2.4 0.8,-5.2 -3.7,-1.3 -2.3,-5.8 -5.6,1 -0.7,-7.5 4.1,-5.3 -0.8,-5.3 -1.3,-4.9 -2.7,-1.5 -2.7,-3.7 -3,0.4 0.9,2.4 -1.6,1.2 1.3,3.9 -4.1,-1.1 -6.1,4.4 0.9,3.6 -2.1,5.4 0.3,3.1 -1.5,5.2 -4.6,-1.4 0.9,6.6 -0.9,2.1 0.9,2.7 -2.4,1.5 0.5,4.6 -2.1,-1 1.1,5.1 4.6,5.2 3.4,0.9 -0.4,2.2 5.4,7.4 1.9,5.9 -0.9,7.9 3.6,1.5 3.2,0.6 5.8,-4.6 3.2,-3.1 3.1,5.2 2,8.1 2.6,7.6 2.6,3.3 0.2,6.9 2.2,3.8 -1.3,4.8 0.9,4.8 2.2,-6.6 2.6,-5.9 -2.8,-5.8 -0.2,-3 -1,-3.5 -4.2,-5.1 -1.7,-3.2 1.7,-1.1 1.4,-5.6 -2.9,-4.2 -4.1,-4.6 -3.5,-5.6 2.2,-1.1 1.5,-6.9 3.9,-0.3 2.8,-2.8 3,-1.4 0.8,-2.4 4.1,-4.1 z
110	ca116692-d003-45f6-ade9-86154e19ea90	dff0e275-70f0-4d4b-9d4a-3b4029ab3cd1	m 1105.4,683.7 -10.3,2.5 -13.4,-0.9 -3.7,-3 -22.5,0.3 -0.9,0.4 -3.2,-2.9 -3.6,-0.1 -3.3,1 -2.7,1.2 0.2,4.9 4.4,6.2 1.1,4 2.8,7.7 2.7,5.2 2.1,2.6 0.6,3.5 0,7.6 1.6,9.8 1.2,4.6 1,6.2 1.9,4.7 3.9,4.8 2.7,-3.2 2.1,1.8 0.8,2.7 2.4,0.5 3.3,1.2 2.9,-0.5 5,-3.2 1.1,-23.6 0.6,-18.5 5.4,-0.2 0.9,-22.7 4.1,-0.2 8.6,-2.2 2,2.6 3.7,-2.5 1.6,0 3.2,-1.5 0,-0.5 -2.1,-1.4 -3.6,-0.4 -4.6,1.5 z
111	6416d2cb-10e6-413e-8f35-b68863afa509	c00f0e5e-a315-4118-b879-8d0a07faa486	m 1915,575.5 0,-0.2 -0.1,0 -0.1,0 -0.1,0.2 0.1,0.1 0.1,0.1 0.1,-0.2 z
112	954bfedd-da76-45fb-a02e-ad9e50679b83	52a86412-42e6-499e-a742-a0902ca649b5	m 1455.2,394.8 -6.5,-0.6 -6.4,-1.5 -5,-2.8 -4.5,-1.2 -2.5,-3.1 -3.2,-0.9 -6.4,-4.1 -4.7,-2 -1.9,1.5 -2.8,2.9 -0.9,5.9 5.7,2.5 5.8,3.1 7.7,3.5 7.6,0.9 3.8,3.2 4.3,0.6 6.8,1.5 4.6,-0.1 0.1,-2.5 -1.5,-4.1 -0.1,-2.7 z
113	25fd2e5b-f429-4623-9ac1-62c3bfeb5a1e	649e4cd5-204a-41ae-add6-5c7433d23973	m 1005.5,243.9 2.9,0 1.1,-2.3 1,-5.6 -1,-2 -3.9,-0.2 -6.5,2.6 -3.9,8.9 -2.5,1.7 0,0 3.6,0.5 4.4,-1.3 3.1,2.7 2.8,1.4 -1.1,-6.4 z
114	b626ffec-fbc4-4e33-83ba-72ed366c0da4	903625d0-0df4-4537-8370-4c3cda4ffed6	m 1868.6,832.8 0.9,-2.6 -5.8,2.9 -3.4,3.4 -3.2,1.6 -5.9,4.6 -5.6,3.2 -7,3.2 -5.5,2.4 -4.3,1.1 -11.3,6.1 -6.4,4.6 -1.1,2.3 5.1,0.4 1.5,2.1 4.5,0.1 4,-1.8 6.3,-2.8 8.1,-6.2 4.7,-4.1 6.2,-2.3 4,-0.1 0.6,-2.9 4.6,-2.5 7,-4.5 4.2,-2.9 2.1,-2.6 0.5,-2.6 -5.6,2.5 0.8,-2.6 z m 28.8,-30.5 1.9,-5.7 -3.1,-1.7 -0.8,-3.6 -2.3,0.5 -0.4,4.6 0.8,5.7 0.9,2.7 -0.9,1.1 -0.6,4.4 -2.4,4.1 -4.2,5 -5.3,2.2 -1.7,2.4 3.7,2.5 -0.8,3.5 -6.9,5.1 1.4,0.9 -0.4,1.6 5.9,-2.5 5.9,-4.2 4.5,-3.4 1.6,-1.2 1.5,-2.7 2.8,-2 3.8,0.2 4.2,-3.8 5.1,-5.7 -2.1,-0.8 -4.6,2.5 -3.2,-0.5 -2.9,-2.1 2.3,-4.9 -1.2,-1.8 -2.9,4.4 0.4,-6.8 z
115	414634bb-dcf7-455a-beb1-12eebbb7b5e2	390d0b06-0892-405b-93f4-8b1b69af9667	m 514.1,476.8 -1.9,-0.2 -0.9,0.9 -2,0.8 -1.4,0 -1.3,0.8 -1.1,-0.3 -0.9,-0.9 -0.6,0.2 -0.8,1.5 -0.5,-0.1 -0.3,1.3 -2.1,1.8 -1.1,0.7 -0.6,0.8 -1.5,-1.3 -1.4,1.7 -1.2,0 -1.3,0.2 -0.2,3.1 -0.8,0 -0.8,1.5 -1.8,0.3 -0.4,0.4 -0.9,-1 -0.7,1 2.6,2.9 2.2,2 1,2.1 2.5,2.6 1.8,2 0.9,-0.8 3.5,1.7 1.4,-0.8 1.7,0.5 0.8,1.3 1.7,0.4 1.4,-1.3 -0.8,-1.1 -0.1,-1.7 1.2,-1.6 -0.2,-1.7 0.7,-2.7 0.9,-0.7 0.1,-2.8 -0.2,-1.7 0.4,-2.8 0.9,-2.5 1.4,-2.2 -0.3,-2.3 0.4,-1.4 0.6,-0.6 z
116	2fc0a597-e659-420e-b6b8-cd81142d29c5	363bc536-025f-4ef7-95c0-a083bb8f37e6	m 1051.3,425.6 -8.8,-2.8 -18.6,12.2 -15.8,12.5 -7.8,2.8 0.1,14.6 -3,4.3 -0.5,3.9 -4.9,1 -7.6,0.6 -2,2.2 -3.6,0.3 -0.5,3.1 0.8,2.9 3.1,4.1 0.2,3.1 6.4,1.4 -0.1,4.4 1.9,-1.9 2,0 4.3,3.7 0.3,-5.7 1.6,-2.6 0.8,-3.6 1.4,-1.4 6,-0.8 5.6,2.4 2.1,2.4 2.9,0.1 2.6,-1.5 6.8,3.3 2.8,-0.2 3.3,-2.7 3.3,0.2 1.6,-0.9 3,0.4 4.3,1.8 4.3,-3.5 1.3,0.2 3.9,7 1,-0.2 0.2,-2 1.6,-0.4 0.5,-2.9 -3.6,-0.2 0,-4.1 -2.4,-2.3 2.3,-8.4 6.9,-6 0.2,-8.3 1.8,-12.9 1.1,-2.7 -2.3,-2.2 -0.2,-2.1 -2,-1.6 -1.6,-9.9 -3.9,2.4 -3.1,-3.5 z
117	0a904f24-0a6d-48e9-b894-bcaa49849b1e	7ce306aa-4c86-4016-93ab-cf3f5c22c621	m 1055.8,492.7 -1,0.2 -3.9,-7 -1.3,-0.2 -4.3,3.5 -4.3,-1.8 -3,-0.4 -1.6,0.9 -3.3,-0.2 -3.3,2.7 -2.8,0.2 -6.8,-3.3 -2.6,1.5 -2.9,-0.1 -2.1,-2.4 -5.6,-2.4 -6,0.8 -1.4,1.4 -0.8,3.6 -1.6,2.6 -0.3,5.7 -0.2,2.1 1.2,3.8 -1.1,2.5 0.6,1.7 -2.7,4 -1.7,1.9 -1,4 0.1,4.1 -0.3,10.2 4.9,0 4.3,0 3.9,4.2 1.9,4.6 3,3.9 4.5,0.2 2.2,-1.4 2.1,0.3 5.8,-2.3 1.4,-4.5 2.7,-6.1 1.6,-0.1 3.3,-3.7 2.1,-0.1 3.2,2.6 3.9,-2.2 0.5,-2.6 1.2,-2.6 0.8,-3.2 3,-2.6 1.1,-4.5 1.2,-1.4 0.7,-3.3 1.5,-4 4.6,-5 0.3,-2.1 0.6,-1.1 -2.3,-2.6 z
118	e5f423d7-6d28-4c81-b0f8-9f4e35d020f2	9ad23145-f384-4a8f-a075-4648d1837d46	m 1644.7,302.3 0,0 -5.5,-3.6 0.1,3.5 -6.3,2.6 2.7,3.3 -4.6,-0.2 -3.6,-2 -1,4.4 -3.8,3.4 -2.1,4 3.3,1.7 3.4,0.7 0.8,1 0.4,3.5 1.1,1.2 -0.9,0.7 -0.1,2.9 1.9,1 1.6,0.6 0.8,1.2 1.3,-0.5 0,-1.3 3.1,1.3 0.1,-0.6 2.4,0.2 0.7,-2.9 3.5,-0.3 2.1,-0.4 -0.1,-1.6 -4.3,-2.8 -2.6,-1 0.2,-0.7 -1.2,-2.8 1.3,-1.7 2.9,-1 1,-1.9 0.3,-1.1 1.9,-1.4 -2.8,-4.5 0.3,-2.1 0.9,-2 2.2,0.3 0,0 0,0 0,0 -1.4,-1.1 z
119	f0097c8b-3992-4e51-a248-47e60611d0ac	4f50cb61-60cb-48f5-9c7a-974d9c3840d5	m 1088.8,133.1 -6.9,1.1 -7.3,-0.3 -5.1,4.4 -6.7,-0.3 -8.5,2.3 -10.1,6.8 -6.4,4 -8.8,10.7 -7.1,7.8 -8.1,5.8 -11.2,4.8 -3.9,3.6 1.9,13.4 1.9,6.3 6.4,3 6,-1.4 8.5,-6.8 3.3,3.6 1.7,-3.3 3.4,-4 0.9,-6.9 -3.1,-2.9 -1,-7.6 2.3,-5.3 4.3,0.1 1.3,-2.2 -1.8,-1.9 5.7,-7.9 3.4,-6.1 2.2,-3.9 4,0.1 0.6,-3.1 7.9,0.9 0,-3.5 2.5,-0.3 2.1,-1.4 5.1,2.9 5.3,-0.3 4.7,1.3 3.4,-2.4 1.1,-3.9 5.8,-1.8 5.7,2.1 -0.8,3.8 3.2,-0.5 6.4,-2.2 0,0 -5.4,-3.3 4.8,-1.4 -13.6,-3.9 z m -22.6,-33.3 -5.6,-1 -1.9,-1.7 -7.2,0.9 2.6,1.5 -2.2,1.2 6.7,1.1 7.6,-2 z m -25.4,-8.3 -4.8,-1.6 -5.1,0.2 -1,1.5 -5,0 -2.2,-1.5 -9.3,1.6 3.2,3.5 7.6,3.8 5.7,1.4 -3,1.7 8.4,2.9 4.4,-0.2 0.9,-3.9 3,-0.9 1.2,-3.4 8.5,-1.8 -12.5,-3.3 z m 24.2,-3.1 -9.1,-1 -3.2,1.2 -5.3,-1 -10.4,1.2 4.3,2 5.1,0 0.9,1.3 10.6,0.7 10.1,-0.5 4.3,-2.4 -7.3,-1.5 z
120	21702931-5633-4495-9e6c-5da4a33963dc	7a1e411c-5e2b-4ef6-9561-73a4466af643	m 1301,437.8 2.1,-2 0.8,-1.8 1.6,-3.8 -0.1,-1.4 -2.1,-0.8 -1.6,-2.1 -2.9,-3.7 -3.3,-1.1 -4.1,-0.9 -3.3,-2.3 -2.9,-4.3 -2.8,0 -0.1,4.2 1.1,0.8 -2.4,1.3 0.3,2.6 -1.4,2.6 0.1,2.6 2.9,4.5 -2.6,12.7 -16.1,6.4 5.2,10.5 2.1,4.4 2.5,-0.3 3.6,-2.2 3.1,0.6 2.5,-1.8 -0.2,-2.5 2.1,-1.6 3.4,0 1.2,-1.3 0.2,-3.1 3.3,-2.4 2.6,0 0.4,-0.8 -1,-4.2 0.6,-3.2 1,-1.5 2.5,0.3 1.7,-4.4 z m -16.6,-30.4 0.2,-2.6 -0.7,-0.6 -1.3,2.2 1.3,2.2 0.5,-1.2 z
121	2e6d65af-77e2-45b9-8a33-97efbb7ffeaf	abc45575-6e5a-49c5-9967-e067a503c8a6	m 1388.3,346.3 -9.4,-2.6 -2.9,-5 -4.7,-3 -2.8,0.7 -2.4,1.2 -5.8,0.8 -5.3,1.3 -2.4,2.8 1.9,2.8 1.4,3.2 -2,2.7 0.8,2.5 -0.9,2.3 -5.1,-0.2 3,4.2 -3,1.6 -1.5,3.8 1.1,3.8 -1.7,1.8 -2.1,-0.6 -4,0.9 -0.2,1.7 -4,0 -2.3,3.6 0.8,5.4 -6.6,2.6 -3.8,-0.5 -0.9,1.4 -3.3,-0.8 -5.3,0.9 -9.6,-3.2 3.2,3.3 2.8,3.9 5.6,2.7 1,5.7 2.7,1 0.9,2.9 -7.4,3.3 -1.2,7.4 7.6,-0.9 8.9,-0.1 9.9,-1.2 4.9,4.8 2.1,4.6 4.2,1.6 3.2,-4.2 12,0 -1.8,-5.5 -3.5,-3.2 -1.3,-4.9 -4,-2.9 4.9,-6.6 6.4,0.5 4.5,-6.7 2.1,-6.5 3.9,-6.3 -1,-4.5 3.7,-3.7 -5,-3.1 -2.9,-4.3 -3.2,-5.6 1.9,-2.8 8.5,1.6 5.7,-1 3.7,-5.4 z
122	7254f33d-39b6-40fb-ba58-f8786798bed5	e32cd55b-2b25-444e-beb4-f86a6e81819b	m 543.5,517 -2,-1.8 -1.7,-1.9 -2.5,-1.1 -3.1,-0.2 0.3,-0.6 -3.1,-0.4 -2,1.9 -3.5,1.3 -2.5,1.6 -2.7,0.5 -1.5,-1.6 -0.5,0.5 -2.3,-0.3 0.2,-1.3 -1.9,-2.3 -2.2,0.6 -0.1,2.5 1.1,1 -0.8,0.7 0.1,1.2 -0.5,1.3 -0.4,1.2 0.6,1 0.3,-1.4 2.4,0 1.4,0.7 2.3,0.5 1,2.5 1.8,0.4 0.8,-1.1 0.8,3.8 2.6,-0.3 0.9,-0.9 1.5,-0.9 -2.5,-3.4 0.6,-1.3 1.3,-0.3 2.3,-1.6 1.2,-2.2 2.5,-0.4 2.7,1.8 1,2.1 1.4,0.4 -1.5,1.7 1,3.5 1.8,1.8 0.9,-3.1 1.8,0.5 1.1,-1.9 -1.1,-3.8 0.7,-0.9 z
142	704a1679-ef82-46ad-bf2f-15c778a4c837	dbc583de-b4de-46ba-aae0-1e8d35054bf3	m 1059.4,277 -1.2,-2.1 -0.8,-0.1 -0.9,1.1 -4.3,0.1 -2.4,1.4 -4.2,-0.4 -0.3,3 1.4,2.7 -1.1,0.5 3.5,0.2 0.8,-1 1.8,1 2,0.1 -0.2,-1.7 1.7,-0.6 0.3,-2.5 3.9,-1.7 z
123	88031d88-8542-430b-a22b-55bb21b88f3c	2f5d487b-20b7-47c4-b8fe-378d3c40839a	m 1850.7,615.6 0.9,-1.8 -2.4,-2.2 -2.5,-4 -1.6,-1.5 -0.5,-1.9 -0.8,0.7 0.9,4.8 2.2,4 2.2,2.5 1.6,-0.6 z m -21.2,-8.6 2.1,-3.9 0.4,-3.5 -1.1,-1 -3.4,0.1 0.4,3.7 -3.3,2.3 -1.7,2.2 -3.2,0.5 -0.4,-3.4 -0.8,0.1 -1,3.1 -3.1,0.5 -5,-0.9 -0.6,1.9 3.1,1.8 4.5,1.9 2.9,0 3,-1.5 3.2,-1.6 1,-1.8 3,-0.5 z m -27.8,12.2 -0.9,-4.3 5.2,-0.7 -1.1,-3.3 -9.1,-4 -0.6,-3.7 -2.9,-3.2 -3.7,-3.3 -10.2,-3.6 -9.6,-4.4 -1,20.7 -1.5,20.8 5.7,0.2 3.1,1.1 4.6,-2.2 -0.3,-4.7 3.6,-2.1 4.9,-1.8 7,2.8 2.4,5.6 2.9,3.5 3.9,4 5.5,1 4.8,0.7 1.1,1.6 3.8,-0.4 0.8,-1.8 -5.6,-2.7 1.8,-1.2 -4.2,-1.1 0.5,-2.8 -3.2,0.2 -3,-6.8 -4.7,-4.1 z m 34.7,-18.4 -0.5,-3.3 -2,-2.1 -2.1,-2.6 -2.3,-1.5 -1.9,-1.4 -2.9,-1.8 -1.6,1.5 3.9,1.9 3.1,2.7 2.4,2.1 1.2,2.4 0.8,3.8 1.9,-1.7 z
124	e03a599b-91ec-48b9-b223-5c56e012aa17	5091a6a9-aa19-4e48-890a-d0d3ccce88c7	m 655.7,700.5 -0.3,-1.9 -5.4,-3.3 -5.1,-0.1 -9.5,1.9 -2.1,5.6 0.2,3.4 -1.5,7.6 11.2,10.4 4.6,1 7.2,4.7 5.9,2.5 1.1,2.8 -4.2,9.6 5.7,1.8 6.2,1 4.2,-1.1 4.3,-4.8 0.3,-5.7 0.7,-3.6 0.3,-3.8 -0.3,-3.5 -2.1,-1.2 -2,1.1 -2,-0.3 -0.9,-2.5 -1,-5.8 -1.2,-1.9 -3.9,-1.7 -2.1,1.2 -6,-1.2 -0.4,-8.6 -1.9,-3.6 z
125	f7de8386-afec-4831-839c-51d1fbea620a	6fd50499-8698-4764-a9ea-d063e211ae85	m 584.3,599.5 -2.9,-3.4 -1.7,-0.1 3.5,-6.5 -4.4,-3 -3.3,0.6 -2.1,-1.1 -3,1.7 -4.2,-0.8 -3.4,-6.7 -2.7,-1.7 -1.8,-3 -3.7,-3 -1.5,0.6 0.8,4.9 -1.7,4.1 -6,6.7 -6.7,2.5 -3.3,5.5 -0.9,4.3 -3.1,2.6 -2.5,-3.2 -2.3,-0.7 -2.3,0.5 -0.2,-2.3 1.5,-1.5 -0.7,-2.7 -4.4,4 -1.6,4.5 3,6.1 -1.7,2.8 4.1,2.6 4.5,4.1 2,4.7 2.4,2.9 6,12.7 6.2,11.7 5.4,8.4 -0.8,1.8 2.8,5.3 4.6,3.9 10.7,6.9 11.6,6.4 0.7,2.6 5.9,3.7 2.7,-1.6 1.2,-3.3 2.8,-6.9 -2.8,-5.3 1.1,-2.1 -1.2,-2.4 1.9,-3.2 -0.3,-5.4 -0.1,-4.5 1.1,-2.1 -5.5,-10.3 -3,1.1 -2.6,-0.7 -0.2,-9.7 -4.4,3.8 -4.9,-0.2 -2.3,-3.4 -3.7,-0.3 1,-2.8 -3.3,-3.8 -2.6,-5.8 1.5,-1.1 -0.1,-2.7 3.3,-1.9 -0.7,-3.4 1.3,-2.2 0.4,-3 6.2,-4.3 4.6,-1.2 0.7,-1 5.1,0.3 z
126	89adfd96-c980-4a3a-afde-2c5b2130a521	d29dcef8-e41b-4540-8f88-8849607ad3f3	m 1684.6,518.6 -0.6,-2.3 -0.8,-3.2 -4.8,-3 0.8,4.9 -3.9,0.2 -0.7,2.8 -4.2,1.7 -2.2,-2.8 -2.8,2.4 -3.4,1.7 -1.9,5.4 1.1,1.9 3.9,-3.6 2.7,0.3 1.5,-2.7 3.8,3 -1.5,3.1 1.9,4.6 6.8,3.7 1.4,-3 -2.1,-4.7 2.4,-3.2 2.5,6.4 1.5,-5.8 -0.6,-3.5 -0.8,-4.3 z m -14.5,-11.8 0,-6.1 -3.6,6.1 0.5,-4.2 -3,0.3 -0.3,4 -1.2,1.8 -1,1.7 3.8,4.4 1.6,-1.9 1.4,-4 1.8,-2.1 z m -30.1,6.1 2.6,-4.4 3.4,-3.5 -1.5,-5.2 -2.4,6.3 -2.9,4.4 -3.8,4 -2.4,4.4 7,-6 z m 17.4,-16.4 1.2,3 -0.1,3.3 0.5,2.9 3.3,-1.9 2.4,-2.7 -0.2,-2.6 -3.6,0 -3.5,-2 z m 20,-1.7 -1.8,-2.4 -5.4,-0.1 4,4.8 0.3,2.4 -3.3,-0.5 1.2,3.9 1.7,0.3 0.7,4.5 2.5,-1.4 -1.7,-4 -0.4,-2.1 4.5,1.7 -2.3,-7.1 z m -22.9,-5.8 -2.2,-2.3 -4.8,-0.2 3.4,4.8 2.8,3.2 0.8,-5.5 z m -6.4,-34.6 -3.3,0 -0.9,5.8 1.1,9.9 -2.6,-2 1.2,6 1.2,2.8 3.3,3.7 0.4,-2.3 1.8,1.4 -1.5,1.7 0.1,2.6 2.9,1.4 5,-0.9 4,3.8 1.1,-2.4 2.5,3.4 4.8,3.1 0.2,-2.9 -2,-1.6 0.1,-3.4 -7.5,-3.6 -2.3,0.8 -3.1,-0.7 -2,-5.1 0.1,-5.1 3,-2.1 0.6,-5.3 -2.7,-4.6 0.4,-2.6 -0.7,-1.6 -1.5,1.6 -3.7,-1.8 z
127	b8ae68de-7374-4e24-bfe2-6d02d8aec2f1	9a7ad7e0-1e36-4004-9879-568b56d0cf87	m 1069.4,228.3 -4.6,-0.1 -0.5,-1.4 -4.8,-1.1 -5.7,2.1 -7.1,2.8 -3.1,1.7 1.4,3.1 -1.2,1.6 2,2.2 1.4,3.3 -0.1,2.1 2.3,3.9 2.4,1.9 3.7,0.6 -0.1,1.7 2.7,1.2 0.6,-1.5 3.4,0.6 0.7,2 3.6,0.3 2.6,3.1 0.3,0.4 1.9,-0.9 2.7,2.2 2.8,-1.3 2.4,0.6 3.4,-0.8 4.9,2.3 1.1,0.4 -1.6,-2.8 3.8,-5.1 2.3,-0.7 0.3,-1.8 -3.1,-5.3 -0.5,-2.7 -1.9,-2.9 2.7,-1.2 -0.3,-2.4 -1.7,-2.3 -0.6,-2.7 -1.4,-1.9 -2.5,-0.6 -8.7,0.1 -5.9,-0.7 z
128	748be0fb-681e-4c01-93ab-a60f5da3dad6	c2f84d45-aa39-4df1-8a87-e4dd0c5b34a1	m 937.6,335.9 -0.4,-2.1 2,-2.5 0.8,-1.7 -1.8,-1.9 1.6,-4.3 -2,-3.8 2.2,-0.5 0.3,-3 0.9,-0.9 0.2,-4.9 2.4,-1.7 -1.3,-3.1 -3,-0.2 -0.9,0.8 -3,0 -1.2,-3.1 -2.1,0.9 -1.9,1.6 0.1,2.1 0.9,2.2 0.1,2.7 -1.3,3.8 -0.4,2.5 -2.2,2.3 -0.6,4.2 1.2,2.4 2.3,0.6 0.4,4 -1,5.1 2.8,-0.7 2.7,0.9 2.2,-1.7 z
129	85711358-fabd-423f-96b9-7b1976f99e2f	90a93353-4714-42fc-8632-09f25bc1312a	m 1258,415.5 0.8,-3.8 -0.5,-3.7 -1.9,-2 -1.4,0.7 -1.1,3.3 0.8,4.7 1.8,1.2 1.5,-0.4 z
130	e2222ef4-8fb2-4e78-8ae9-d897241bc18d	fdf4338f-fd3a-446b-9688-b28515d38074	m 1108.1,266.3 -2.1,0 -1,1.5 -3.6,0.6 -1.6,0.9 -2.4,-1.5 -3.2,0 -3.2,-0.7 -1.9,1.3 -2.9,1.3 -1.9,4.2 -2.6,4.3 -3.8,1.1 2.9,2.5 0.8,1.9 3.2,1.5 0.7,2.5 3.1,1.8 1.4,-1.3 1.4,0.7 -1.1,1.1 1,1 1.8,2.6 1.9,-0.5 4,1 7.5,0.3 2.3,-1.6 5.8,-1.4 4,2.2 3,0.7 0.4,-7.4 1.6,0.5 2.3,-1.3 -0.4,-1.6 -2.4,-1.1 -2.2,1 -2.4,-1.1 -1.3,-2.8 0.2,-2.7 -0.6,-2.7 -3.4,-3.7 -1.9,-2.6 -1.8,-1.9 -1.6,-0.6 z
131	389d713c-2ee8-4d87-b7d6-ad0221ee998b	ae5dee3a-1222-4f42-9f97-470ab88b3b7e	m 1332.3,95.1 -4.5,-4 -13.6,-4.1 -9.4,-2.1 -6.2,0.9 -5.3,2.9 5.8,0.8 6.6,3.2 8,1.7 11.5,1.3 7.1,-0.6 z m -178.7,-7.3 0.9,-0.6 -5.7,-0.9 -2.8,0.7 -1.3,1 -1.5,-1.2 -5.2,0.1 -6.2,0.8 7.7,0.1 -1.1,1.3 4.4,1 3.6,-0.7 0.1,-0.7 2.9,-0.3 4.2,-0.6 z m 200.5,9.9 -1.5,-1.8 -12.5,-2.6 -3,-0.3 -2.2,0.5 1.2,6 18,-1.8 z m 15.2,6.3 -9.2,-0.7 3.4,-1.2 -8.2,-1.5 -6.1,1.9 -1,2 1.5,2.1 -6.9,-0.1 -5.3,2.6 -4.3,-1.1 -9.3,0.5 0.3,1.3 -9.2,0.7 -4.9,2.4 -4.2,0.2 -1.2,3.3 5.5,2.6 -7.7,0.7 -9.5,-0.3 -5.8,1.1 4.8,5.4 6.9,4.3 -9.6,-3 -7.9,0.3 -5.1,2 4.5,3.8 -4.9,-1 -2.1,-5 -4.2,-2.8 -1.8,0.1 3.6,3.7 -4.6,3.5 8.1,4.2 0.4,5.4 2.9,2.9 4.7,0.5 0.4,3.5 4.4,3.1 -1.9,2.6 0.5,2.7 -3.7,1.4 -0.5,2 -5.3,-0.8 3.5,-7.8 -0.5,-3.6 -6.7,-3.3 -3.8,-7.3 -3.7,-3.7 -3.6,-1.6 0.8,-4.2 -2.9,-2.9 -11.3,-1.4 -2.1,1 0.5,4.7 -4.3,4.7 1.2,1.7 4.7,4.1 0.1,2.6 5.3,0.5 0.8,1.1 5.8,2.9 -1,2.8 -18.5,-6.1 -6.6,-1.7 -12.8,-1.6 -1.2,1.7 5.9,3.1 -2.7,3.6 -6.4,-3.2 -5,2.2 -7.6,0.1 -2.1,1.9 -5.3,-0.6 2.5,-3.3 -3.2,-0.2 -12.3,4.6 -7.6,2.6 0.4,3.5 -6,1.2 -4,-1.9 -1.2,-3 5,-0.7 -3.6,-3 -12.2,-1.8 4.3,3.4 -0.8,3.2 4.7,3.3 -1.1,3.8 -4.6,-1.9 -4,-0.3 -8,5.4 4.2,4.1 -3.2,1.4 -11.4,-3.5 -2.1,2.1 3.3,2.4 0.2,2.7 -3.8,-1.4 -6,-1.7 -1.9,-5.8 -1,-2.6 -8,-4 2.9,-0.7 20.1,4.2 6.4,-1.5 3.7,-2.9 -1.6,-3.6 -4,-2.6 -17.6,-6.1 -11.6,-1.3 -7.6,-3.2 -3.6,1.8 0,0 -6.4,2.2 -3.2,0.5 0.4,3.7 7.2,3.7 -2.8,4.1 6.4,6.3 -1.7,4.8 4.9,4.1 -0.9,3.7 7.3,3.9 -0.9,2.9 -3.3,3.3 -7.9,7.4 0,0 5.3,2.8 -4.5,3.2 0,0 0.9,1 -2.6,3.4 2.5,5.5 -1.6,1.9 2.4,1.4 1,2.8 2.1,3.6 5.2,1.5 1,1.4 2.3,-0.7 4.8,1.4 1,2.9 -0.6,1.6 3.7,3.9 2.2,1.1 -0.1,1.1 3.4,1.1 1.7,1.6 -1.6,1.3 -3.9,-0.2 -0.8,0.6 1.5,2 2,3.9 0,0 1.8,0.2 1,-1.4 1.5,0.3 4.8,-0.5 3.8,3.4 -0.9,1.3 0.7,1.9 4,0.2 2.2,2.7 0.2,1.2 6.6,2.2 3.5,-1 3.6,2.9 2.9,-0.1 7.6,2 0.4,1.9 -1.3,3.2 1.8,3.4 -0.3,2.1 -4.7,0.5 -2.2,1.7 0.4,2.8 4.2,-1 0.4,1.3 -6.8,2.6 3.2,2.4 -3.2,5.2 -3.4,1 5,3.6 6.2,2.4 7.4,5.1 0.5,-0.7 4.5,1.1 7.7,1 7.5,2.9 1.1,1.2 2.9,-1 5.1,1.3 2.1,2.5 3.5,1.4 1.5,0.2 4.3,3.8 2.4,0.4 0.5,-1.5 2.6,-2.5 0,0 -7.3,-7.3 -0.4,-4.1 -5.9,-5.9 3.5,-6.3 4.6,-1.1 1.4,-3.7 -2.8,-1 -0.2,-3.2 -4.2,-4.1 -3.6,0.2 -5.3,-4.3 1.7,-4.7 -1.7,-1.2 2.1,-6.8 6,3.6 -0.7,-4.6 8.1,-6.6 7.5,-0.2 11.9,4.3 6.6,2.4 4.3,-2.5 7.6,-0.2 7.3,3.2 0.8,-1.8 6.9,0.3 0.2,-3 -9.4,-4.2 3.6,-2.9 -1.5,-1.7 3.9,-1.6 -5,-4.1 1.4,-2.1 16.8,-2.1 1.7,-1.5 10.8,-2.2 3.1,-2.5 9,1.3 4.3,6.3 4.3,-1.5 7,2.1 1.2,3.3 4.4,-0.4 9.1,-5.7 -0.8,1.9 8.3,4.7 18.1,15.5 1.1,-3.3 8.3,3.6 6.2,-1.6 3.2,1.1 4.1,3.6 3.9,1.2 3.3,2.6 6,-0.9 4.3,3.8 1.7,-0.5 4.7,-1 6.6,-5.4 5.9,-2.9 5.3,1.9 5.1,0.1 4.7,2.9 5,0.2 7.9,1.6 2.4,-4.3 -4,-3.6 1.3,-6.4 6.9,2.5 4.8,0.8 6.6,1.5 3.7,4.6 8.4,2.6 3.9,-1.1 5.7,-0.8 5.4,0.8 6.5,3 4.9,3.1 4.5,0 6.7,1 3.6,-1.6 5.8,-1 4.5,-4.4 3.3,0.7 3.9,2.1 5.5,-0.5 7.3,2.3 4.4,-3.9 -1.9,-2.7 -0.1,-6.5 1.2,-2 -2.5,-3.3 -3.7,-1.5 1.7,-3 5.1,-1.1 6.2,-0.2 8.5,1.8 5.9,2.3 7.7,6.1 3.8,2.7 4.4,3.7 6.1,6.1 9.9,1.9 8.9,4.5 6,5.8 7.5,0 2.6,-2.5 6.9,-1.8 1.3,5.6 -0.4,2.3 2.8,6.8 0.6,6 -6.8,-1.1 -2.9,2.2 4.7,5.3 3.8,7.3 -2.5,0.1 1.9,3.1 0,0 1.4,1.1 0,0 0,0 0,0 -0.4,-2 4,-4.5 5.1,3 3.2,-0.1 4.4,-3.6 1,-3.7 2.1,-7.1 1.9,-7.2 -1.3,-4.3 1,-9 -5.2,-9.9 -5.5,-7.3 -1.3,-6.2 -4.7,-5.1 -12.7,-6.7 -5.6,-0.4 -0.3,3 -5.8,-1.3 -5.7,-3.8 -8,-0.7 4.9,-14.1 3.5,-11.5 13.1,-1.8 14.9,1 2.5,-2.8 7.9,0.8 4.3,4.3 6.4,-0.6 8.4,-1.6 -7.7,-3.5 0,-9.8 9.1,-1.9 12.1,7.1 3.6,-6.4 -3.2,-4.7 4.7,-0.5 6.5,8.1 -2.4,4.6 -0.8,6 0.3,7.5 -5.7,1.3 2.8,2.7 -0.1,3.6 6.4,8.3 16,13.4 10.5,8.8 5.7,4.3 1.6,-5.7 -4.5,-6.2 5.7,-1.5 -5.4,-6.9 5,-3.1 -4.7,-2.6 -3.4,-5 4.1,-0.2 -9,-8.6 -6.7,-1.4 -2.9,-2.4 -1.1,-5.6 -3.1,-3.9 7,0.8 1.3,-2.5 4.7,2.2 6.1,-4.6 11.4,4 -1.7,-2.6 2,-3.6 1.5,-4 3.1,-0.7 6.5,-4.3 9.8,1.2 -0.9,-1.5 -3.8,-2.3 -4.1,-1.6 -9.1,-4.6 -8.1,-3 6.1,0.4 2,-2.5 0,0 -32.9,-21.9 -9.4,-2.3 -15.7,-2.6 -7.9,0.3 -15.2,-1.4 1.8,2.3 8.5,3.4 -2.5,1.8 -14.2,-4.8 -6.8,0.6 -9.2,-1.1 -7,0.2 -3.9,1.1 -7.2,-1.6 -5.1,-3.8 -6.5,-2.2 -9.2,-0.9 -14.7,1 -16.1,-4 -7.8,-3 -40.1,-3.4 -2.1,2.2 9.3,4.8 -7.5,-0.7 -1,1.5 -9.7,-1.6 -5,1.4 -9.3,-2.4 3,5.5 -8.9,-2.1 -10,-4.1 -0.4,-2.2 -6,-3.3 -9.8,-2.6 -6.1,0 -9.3,-0.9 4.7,3.9 -17.2,-0.8 -3.9,-2.3 -13.3,-0.9 -5.3,0.8 -0.1,1.3 -5.8,-3.2 -2.3,0.9 -7.2,-1.2 -5.6,-0.7 1.1,-1.5 6.6,-2.8 2.3,-1.5 -2.4,-2.5 -5.5,-1.9 -11.5,-2.3 -10.8,-0.1 -1.9,1.2 -4.1,-2.4 z m -162.2,31.6 -9.9,-4.3 -3.1,-4.3 3.3,-4.9 2.8,-5 8.6,-4.7 9.8,-2.4 11.3,-2.4 1.3,-1.5 -4.2,-1.9 -6.6,0.6 -4.9,1.8 -11.7,0.9 -10.1,3.1 -6.8,2.7 2.5,2.2 -6.6,4.4 3.9,0.7 -5.4,4.3 1.6,2.8 -3.4,1.1 1.9,2.8 7.9,1.4 2.2,2.3 13.4,0.7 2.2,-0.4 z m 314,-24.7 -17.9,-2.6 -10.2,-0.2 -3.4,0.9 3.4,3.4 12.4,3.2 4.5,-1.2 14.2,0.2 -3,-3.7 z m 25.2,2.3 -11.7,-1.3 -8.2,-0.7 1.7,1.6 10.3,2 6.8,0.4 1.1,-2 z m -12.5,9.5 -2.5,-1.4 -8.3,-1.9 -4.1,0.5 -0.8,2 1.1,0.2 8.8,0.6 5.8,0 z m 162.6,12.3 -6,-3.6 -1.4,2.2 3.5,1.6 3.9,-0.2 z m -612.4,93.9 -0.6,-1.5 0.2,-1.7 -2.2,-0.9 -5,-1.1 -6.3,2 -0.7,2.6 5.9,0.7 8.7,-0.1 z m 589.7,21.8 -7.2,-6.2 -5.1,-6 -6.8,-5.8 -4.9,-4 -1.3,0.8 4.4,2.8 -1.9,2.8 6.8,8.3 7.8,6 6.4,8.3 2.4,4.6 5.5,6.8 3.8,6 4.6,5.2 -0.1,-4.8 6.5,3.8 -3,-4.4 -9.5,-6.3 -3.7,-9 8.9,2 -13.6,-10.9 z
132	06de8f67-a69a-4d9b-aa75-c7c3fef51860	418d8911-a62b-4686-bf0e-f18b204398d8	m 1147.6,579.4 -3.3,1.9 -1.4,-0.6 -1.6,1.8 -0.2,3.8 -0.8,0.4 -0.6,3.5 3.5,0.5 1.7,-3.6 3,0.4 0,0 1.6,-0.8 0.4,-3.7 -2.3,-3.6 z
133	4d17fdd5-7d68-4de8-a223-eae455d8d3cc	e3b26362-6759-4612-8863-4785505a679e	m 637.4,484.2 0.1,-1.2 -0.1,-0.5 -0.2,0.1 -0.3,0.4 -0.4,0.6 -0.1,0.3 0,0.6 0.6,0.4 0.4,-0.7 z
134	05b85afd-1d8c-4a12-890f-29d40b4c9e1e	ab4bc3a4-7c19-4a94-905c-a7973e0feaff	m 1014.1,571.4 0.5,-0.8 0,-0.5 -0.3,-0.5 -0.4,0 -0.5,0.4 -0.3,0.4 0,0.3 0.1,0.7 0.1,0.3 0.3,0.2 0.5,-0.5 z m 4.3,-9.2 0.2,-0.4 0,-0.2 -0.1,-0.1 -0.1,-0.1 -0.2,0.1 -0.3,0.5 0.1,0.2 0.2,0.2 0.2,-0.2 z
135	11762299-90d8-4daa-8abe-4b142fc6f483	dfffd0b6-a252-421b-94cb-6d44695c5c8c	m 1228.7,387 -10.2,-0.5 -16.7,-12.7 -8.5,-4.5 -6.7,-1.7 -0.9,1 -10.4,3.1 6.1,6.4 -1.7,1 -0.7,2.2 -4,0.8 -1.1,2.3 -2.1,2 -6.1,-1 -0.5,2.5 0,2.2 -0.6,3.5 2.7,0 3.2,4.4 3.7,5.1 2.5,4.7 1.7,1.5 1.7,3.3 -0.2,1.4 2.1,3.7 3,1.3 2.8,2.5 3.6,7 0,3.8 0.9,4.4 4,6.1 2.5,1 4.1,4.4 1.9,5.2 3.2,5.3 3,2.3 0.6,2.5 1.8,1.9 0.9,2.8 2.3,-2.1 -0.7,-2.7 1.2,-3.1 2.4,1.7 1.5,-0.6 6.4,-0.2 1,0.7 5.4,0.6 2.1,-0.3 1.6,2.1 2.5,-1 3.5,-6.7 5,-2.9 15.7,-2.4 16.1,-6.4 2.6,-12.7 -2.9,-4.5 -1,1.3 -16.8,-3.2 -2.6,-6.4 -0.4,-1.5 -1.2,-2.4 -1.5,0.4 -1.8,-1.2 -1,-1.6 -0.9,-2.1 -1.7,-1.8 -1,-2.1 0.4,-2.1 -0.6,-2.7 -4,-2.6 -1.2,-2.3 -2.9,-1.4 -2.7,-5.5 -3.8,0.2 -1.7,-3.1 -4.9,-0.6 z
136	32573d25-ff59-4754-84d3-0d3138cc78a8	e98795b2-4086-41b5-bac1-4789d9aee005	m 908.9,479.2 -3.6,-4.4 -3.2,-4.7 -3.7,-1.7 -2.6,-1.8 -3.1,0 -2.8,1.4 -2.7,-0.5 -2,2 -1.3,3.3 -2.8,4.4 -2.5,1.2 2.7,2.3 2.2,5 6.1,-0.2 1.3,-1.5 1.8,-0.1 2.1,1.5 1.8,0.1 1.8,-1.1 1.1,1.8 -2.4,1.5 -2.4,-0.1 -2.4,-1.4 -2.1,1.5 -1,0 -1.4,0.9 -5,-0.1 0.8,4.9 3,-1.1 1.8,0.2 1.5,-0.7 10.3,0.3 2.7,0.1 4,1.5 1.3,-0.1 0.4,-0.7 3,0.5 0.8,-0.4 0.3,-2 -0.4,-2.4 -2.1,-1.8 -1.1,-3.7 -0.2,-3.9 z
137	20313c40-deef-49d1-9c15-7e1865d11e73	aae2ba87-a67d-43bd-8516-e403843d61d9	m 1084.8,285.2 -3.2,-1.5 -0.8,-1.9 -2.9,-2.5 -3.2,-0.2 -3.7,1.6 0,0 1.5,2.4 1.7,1.8 -1.7,2.3 0,0 1.8,0 -1,2.7 2.7,2.3 -0.5,2.9 -1.2,0.3 1.5,1.1 0.8,0.8 1.8,0.7 2,1.2 -0.4,0.6 1.2,-0.5 0.5,-2 0.9,-0.4 0.8,0.9 1,0.4 0.8,1 0.8,0.3 1.1,1.1 0.8,0 -0.5,1.5 -0.5,0.7 0.2,0.5 1.7,-0.4 2.4,-0.1 0.7,-0.9 -0.6,-0.7 0.7,-2 1.7,-1.9 -2.8,-2.6 -0.7,-2.3 1.1,-1.4 -1,-1 1.1,-1.1 -1.4,-0.7 -1.4,1.3 -3.1,-1.8 -0.7,-2.5 z
138	f443e613-3734-413b-ba6b-46b4f6943221	4998e162-96ca-4381-ab19-3dc43922884a	m 1288.5,602 -0.5,-0.8 -0.4,0.3 0.2,0.3 0.3,0.2 0.1,0.4 0.3,0.2 0,-0.6 z
139	84afb816-bad1-4620-9b76-7ed66f9d6a9f	d8df4bc3-503b-41ca-987e-423e41ecb52c	m 919.4,518.7 -1.5,0.3 0,-2.3 -0.9,-1.7 0.2,-1.8 -1.2,-2.7 -1.5,-2.3 -4.5,0 -1.3,1.2 -1.5,0.2 -1,1.4 -0.7,1.7 -3,2.8 0.7,4.7 0.9,2.3 2.9,3.5 4.1,2.5 1.5,0.5 1.3,-2 0.3,-1.9 2.6,-3.4 2.6,-3 z
140	a04ae191-e705-49dc-9b21-88c965594e62	6e83ec38-7e2d-4c2d-8a9d-6991d4e876db	m 1561,563.7 0.1,-0.2 -0.2,-0.2 -0.3,-0.1 -0.5,-0.2 -0.6,0.1 -0.3,0.6 0.9,0.4 0.9,-0.4 z
143	0dced16d-dabc-4347-ad39-786cc3b43636	b7f76500-4fa3-457f-aca8-477f05aab728	m 1909.1,646.4 -0.2,-0.2 -0.1,-0.4 -0.3,0 -0.3,0.1 0.2,0.6 0.2,0 0.5,-0.1 z m -35.6,0.8 -0.1,-0.2 -0.5,-0.4 -1.9,-1.3 -0.4,-0.1 -0.1,0.1 -0.1,0.3 0.1,0.2 0.5,0.1 0,0.1 0.3,0.2 0.7,0.2 0.4,0.3 0.1,0.5 0.3,0.1 0.3,0.1 0.4,-0.2 z m 32,-6.6 0,-0.1 0.2,-0.3 -0.2,-0.1 -0.5,-0.1 -0.7,0.1 -0.3,0.2 -0.2,0.3 -0.2,0 0,0.2 0.1,0.4 0.2,-0.1 0.2,0.1 0.5,-0.5 0.3,0 0.1,0 0.5,-0.1 z m -24.4,-2.3 -0.1,-0.2 -0.2,-0.1 -0.9,-0.7 -0.5,-0.2 -0.5,0 -0.1,0.5 0,0.3 0.6,0 0.4,0.2 0,0.6 0.2,0.2 0,0.5 1.2,0.9 0.7,0.4 0.7,0.1 0.4,0.2 0.5,-0.1 0.5,0.2 0.4,-0.1 -0.4,-0.3 0,-0.4 -0.5,-1.3 -0.3,-0.3 -0.5,0.1 -0.5,-0.2 -0.4,0 -0.7,-0.3 z m -0.4,-4.9 -0.6,-1.6 -0.2,-0.1 0.1,0.6 0.1,0.4 -0.1,0.5 -0.1,0.6 0.2,0.2 0.2,-0.2 0.4,0.5 0,-0.2 0,-0.7 z m -9.8,-2.2 -0.3,-0.1 -0.4,0.3 -0.1,0.3 -0.1,0.7 0,0.4 0.3,0.7 0.3,0.5 0.3,0.3 0.2,0.2 0.9,0.1 1.7,0.1 0.9,0.4 0.9,0.2 0.4,-0.1 0.5,-0.2 0.1,-0.1 -0.1,-0.6 -0.2,-0.3 -0.4,-0.2 -0.2,-0.6 -0.5,-0.4 -0.9,-0.7 -1.6,0 -0.6,0.1 -1.1,-1 z m 2.6,-1.8 -0.5,0.2 0,0.3 0.4,0.1 0.4,0.2 0.1,0.3 0,0 0.2,-0.1 0.4,0.2 0.2,-0.3 -0.4,-0.5 -0.4,-0.3 -0.1,0 -0.3,-0.1 z m -5.6,0.8 0.3,-0.2 0,-0.4 -0.3,0 -0.1,-0.2 -0.2,0 -0.3,0.2 -0.2,0.3 0.1,0.2 0.4,0 0.2,0.1 0.1,0 z m -8.4,-2.3 -0.1,-0.2 -0.3,-0.2 -0.2,0 -0.5,0.1 0.1,0.1 0.6,0.3 0.3,0.1 0.1,-0.2 z m 3.1,0.4 0.3,-0.2 -0.1,-0.2 -0.1,-0.5 -0.4,0.7 0.1,0.2 0.2,0 z m -0.5,-0.9 0,-0.2 0,-0.2 -0.2,-0.1 0.4,-0.3 -0.1,-0.1 -0.6,-0.2 -0.2,0.2 -0.2,0.1 -0.1,0.1 -0.1,0.1 -0.1,0.5 0.2,0.4 0.4,0.2 0.6,-0.5 z m -4,0.2 -0.3,-0.4 0.1,-0.5 0.2,-0.1 0.2,-0.5 -0.1,-0.4 -0.2,0.1 -0.7,0.6 -0.1,0.3 0.6,0.8 0.3,0.2 0,-0.1 z m 13,-1.3 -0.2,-0.4 0,-0.2 -0.3,-0.2 -0.2,0.1 -0.1,0.3 0.1,0.2 0.4,0.3 0.3,-0.1 z m 6,-1.2 -0.2,0 -0.1,0.1 -0.2,0 -0.3,0 -0.1,0.2 0.6,1.1 -0.3,0.5 0.4,2.2 0.4,1.2 0.8,0.8 0,0.2 0.8,0.5 0.6,1.3 0.2,0.1 0.1,-0.2 0,-0.6 -0.5,-1.1 0.1,-0.8 -0.2,-0.3 0,-0.3 -0.2,-0.8 -0.6,-0.7 -0.3,-0.1 -0.2,-0.3 0.2,-0.6 0.2,-0.2 0.1,-0.3 -1.3,-1.9 z m -16.6,-0.5 -0.6,-0.2 -0.2,-0.3 0,-1 -0.6,-0.3 -0.3,0.2 -0.6,0.7 -0.2,0.4 -0.5,0.3 -0.1,0.3 0,0.4 0.4,0.1 0.3,-0.4 0.9,-0.1 0.3,0.1 0,0.4 0.1,0.7 0.3,0.3 0.5,0.2 0.4,0.6 0.1,-0.3 0.2,0 0.2,-0.4 -0.3,-1.2 -0.3,-0.5 z m -6.5,-0.4 0.1,-0.5 -0.1,-0.9 -0.2,0.1 0,0.2 -0.1,0.4 0.2,0.8 0.1,-0.1 z m 3.2,-0.4 0.2,-0.2 0,-0.4 0,-0.5 -0.2,-0.4 -0.2,-0.2 -0.5,0.1 -0.4,0.5 0,0.5 0.4,0.6 0.6,0 0.1,0 z m -2.6,-1.2 0.2,-0.3 0.5,-0.7 0.1,-0.3 -0.5,-0.2 -0.4,-0.5 -0.4,-0.2 -0.3,0.4 0,0.4 0.5,0.6 -0.1,0.4 0.2,0.1 0.1,0.4 0.1,-0.1 z m 17.5,3.9 -0.1,-0.5 -0.3,-0.4 0.4,-0.5 -2.2,-1.9 -0.3,-0.2 -0.4,-0.1 -0.5,-0.4 -0.5,-0.1 -0.5,-0.4 -0.2,-0.3 -0.6,-0.4 -0.6,-0.8 -1.5,-0.3 0.1,0.2 0.4,0.4 0.1,0.7 0.5,0.4 0.5,0.6 0.2,0.1 0.2,0.2 0.4,0.5 0.8,0.4 0.8,0.6 0.3,0.1 0.3,0.3 1.5,0.7 0.5,0.7 0.7,0.5 0,-0.1 z m -21.8,-9.2 0.2,-0.3 -0.7,-0.5 -0.2,0.3 -0.2,0.5 0.4,0.2 0.5,-0.2 z m 9.1,1.5 -0.1,-0.1 -0.3,0 -0.4,-0.2 -0.7,-0.8 -0.2,-0.3 -0.2,-1 -0.4,-0.4 -1.4,-0.8 -0.8,-0.8 -0.7,-0.2 -0.2,0.2 0,0.5 0.2,0.3 1,0.9 1.1,1.7 1,1 0.8,0.1 0.4,0 0,0.1 0.1,0.2 0.5,0.2 0.5,-0.4 -0.2,-0.2 z
144	846c0fbe-d830-478b-89eb-302532869ac4	98943525-f93f-426f-a3fe-b48bc18c0c52	m 1223.4,505.7 -2.6,-2.7 -1.2,-2.6 -1.8,-1.2 -2,3.4 -1.1,2.3 2.2,3.5 2.1,3.1 2.2,2.2 18.5,7.6 4.8,-0.1 -15.4,19.1 -7.4,0.3 -4.9,4.5 -3.6,0.1 -1.5,2 -4.8,7.2 0.2,23.2 3.3,5.3 1.3,-1.5 1.3,-3.4 6.1,-7.7 5.3,-4.8 8.3,-6.4 5.6,-5.1 6.4,-8.7 4.7,-7.1 4.6,-9.3 3.2,-8.2 2.5,-7.1 1.3,-6.8 1.1,-2.3 -0.2,-3.4 0.4,-3.7 -0.2,-1.7 -2.1,0 -2.6,2.2 -2.9,0.6 -2.5,0.9 -1.8,0.2 0,0 -3.2,0.2 -1.9,1.1 -2.8,0.5 -4.8,1.9 -6.1,0.8 -5.2,1.6 -2.8,0 z
145	e952274d-9d63-4247-b24b-fdd9ea57d65d	247ff0fd-78ad-4ca4-90f2-f0394a714535	m 1148.2,713.7 -2.9,-0.6 -1.9,0.8 -2.6,-1.1 -2.2,-0.1 -8,4.7 -5.2,4.7 -2,4.3 -1.7,2.4 -3,0.5 -1.2,3 -0.6,2 -3.6,1.5 -4.4,-0.3 -2.5,-1.8 -2.3,-0.8 -2.7,1.5 -1.5,3.1 -2.7,1.9 -2.8,2.8 -4,0.7 -1.1,-2.3 0.7,-3.8 -3,-6.1 -1.4,-1 -1.1,23.6 -5,3.2 -2.9,0.5 -3.3,-1.2 -2.4,-0.5 -0.8,-2.7 -2.1,-1.8 -2.7,3.2 3.5,8.2 0,0.1 2.5,5.3 3.2,6 -0.2,4.8 -1.7,1.2 1.4,4.2 -0.2,3.8 0.6,1.7 0.3,-0.9 2.1,2.9 1.8,0.1 2.1,2.3 2.4,-0.2 3.5,-2.4 4.6,-1 5.6,-2.5 2.2,0.3 3.3,-0.8 5.7,1.2 2.7,-1.2 3.2,1 0.8,-1.8 2.7,-0.3 5.8,-2.5 4.3,-2.9 4.1,-3.8 6.7,-6.5 3.4,-4.6 1.8,-3.2 2.5,-3.3 1.2,-0.9 3.9,-3.2 1.6,-2.9 1.1,-5.2 1.7,-4.7 -4.1,0 -1.3,2.8 -3.3,0.7 -3,-3.5 0.1,-2.2 1.6,-2.4 0.7,-1.8 1.6,-0.5 2.7,1.2 -0.4,-2.3 1.4,-7.1 -1.1,-4.5 -2.2,-9 z m -20.1,52.8 -2,0.6 -3.7,-4.9 3.2,-4 3.1,-2.5 2.6,-1.3 2.3,2 1.7,1.9 -1.9,3.1 -1.1,2.1 -3.1,1 -1.1,2 z
146	99f0a516-c2f9-40b0-92e9-844abd61f86b	3ffea3be-1c82-411a-b085-933205f900c7	m 1166,508.7 -0.7,-2.2 -2.9,-2.5 -0.8,-4.6 0.5,-4.7 -2.6,-0.5 -0.3,1.5 -3.4,0.3 1.4,1.8 0.6,3.9 -3,3.5 -2.7,4.5 -2.8,0.7 -4.8,-3.7 -2.1,1.3 -0.5,1.9 -2.9,1.2 -0.2,1.3 -5.5,0 -0.8,-1.3 -4.1,-0.3 -2,1.1 -1.5,-0.5 -3,-3.7 -1,-1.8 -4,0.9 -1.5,2.9 -1.3,5.7 -1.9,1.2 -1.7,0.7 3.8,2.5 3.1,2.6 0.1,2 3.8,3.4 2.4,2.7 1.5,3.8 4.2,2.5 0.9,2.1 3.5,5.2 2.5,0.8 1.5,-1.1 2.6,0.4 3.1,-1.3 1.4,2.7 5,4.2 0,0 2.3,-1.7 3.5,1.4 4.5,-1.5 4,0.1 3.4,-3 3.4,-3.8 3.8,-4.2 -3.5,-6.9 -2.6,-1.5 -1,-2.5 -2.9,-3.1 -3.4,-0.5 1.8,-3.6 3,-0.1 0.8,-2 -0.2,-5 -0.8,-0.1 0,-3.1 z
147	756120d3-54c8-4cd9-be53-c9e3999de94a	02e5c743-3075-4226-8c1d-ad97dadda3d8	m 985,325.7 0,-0.2 -0.5,0 -0.3,-0.4 -0.1,0.2 -0.1,0.2 0,0.2 0.5,0 0.4,0.1 0.1,-0.1 z m -0.8,-1.6 0.3,0 0.6,-0.7 0,-0.3 -0.3,-0.2 -1.1,0.2 -0.2,0.3 0,0.3 -0.3,0.1 -0.1,0.4 0.1,0.2 0.8,0.1 0.2,-0.4 z M 967,296 l -8.2,-0.2 -4.2,0.3 -5.4,-1 -6.8,0 -6.2,-1.1 -7.4,4.5 2,2.6 -0.4,4.4 1.9,-1.6 2.1,-0.9 1.2,3.1 3,0 0.9,-0.8 3,0.2 1.3,3.1 -2.4,1.7 -0.2,4.9 -0.9,0.9 -0.3,3 -2.2,0.5 2,3.8 -1.6,4.3 1.8,1.9 -0.8,1.7 -2,2.5 0.4,2.1 4.8,1 1.4,3.7 2,2.2 2.5,0.6 2.1,-2.5 3.3,-2.3 5,0.1 6.7,0 3.8,-5 3.9,-1.3 1.2,-4.2 3,-2.9 -2,-3.7 2,-5.1 3.1,-3.5 0.5,-2.1 6.6,-1.3 4.8,-4.2 -0.3,-3.5 -6,0.8 -5.7,-2.8 -1.9,1.3 -9.4,-2.8 -2,-2.4 z m 26,22.6 0.1,-0.3 0.1,-0.2 0.1,-0.1 -0.2,-0.2 0,-0.1 0.2,-0.2 -0.2,-0.1 -1.3,0.4 -0.7,0.4 -2.1,1.5 0,0.3 0.1,0.2 0.4,0 0.2,0.4 0.4,-0.4 0.3,-0.1 0.3,0.1 0.3,0.2 0.1,0.6 0.1,0.2 0.6,0.1 0.9,0.4 0.4,-0.2 0.5,-0.3 0.2,-0.6 0.3,-0.5 0.3,-0.5 0.3,-0.4 -0.1,-0.4 -0.3,-0.1 -0.3,-0.1 -0.5,0.2 -0.5,-0.2 z m 6,-0.3 0.1,-0.4 0,-0.1 -0.5,-0.7 -0.9,-0.3 -1,0.1 -0.1,0.1 0,0.4 0.1,0.1 0.6,0.1 1.6,0.7 0.1,0 z
148	355b6725-a64a-4e0b-86fd-9bbe9558472d	6c6c9e3f-2353-431c-83c4-2c0cc6c42ff6	m 1432.2,532.7 2.3,-1.8 0.6,-6.6 -3,-6.6 -2.9,-4.5 -4.1,-3.5 -1.9,10.3 1.4,9.1 2.8,5.1 4.8,-1.5 z
149	e53b85ff-3591-4355-9c7b-a0429a117327	ec506881-6436-49fc-b56e-42da02dd7d5b	m 629.9,463.2 0,-0.3 -0.2,-0.2 -0.3,0 0,0.5 0.2,0.2 0.3,-0.2 z m -0.5,-0.7 -0.1,-0.2 -0.1,-0.1 -0.2,-0.4 -0.4,-0.4 -0.2,0.1 -0.1,0.2 0,0.1 0,0 0.3,0.3 0.4,0.1 0.2,0.4 0.2,-0.1 z
150	865c27b1-ee2f-4156-ba2b-d04846b578d4	c149c091-51c2-41d7-85a7-7d67bcac4230	m 1180.8,468.5 0.4,-4.2 1.6,-2 4,-1 2.6,-3.6 -3.1,-2.4 -2.2,-1.6 -2.5,-7.6 -1.1,-6.5 1.1,-1.2 -2.1,-6.2 -21.8,0 -21.4,0 -22.1,0 0.5,12.7 -6.3,0 0,2.7 1.1,25.2 -4.8,-0.4 -2.4,4.7 -1.4,3.9 1.2,1.5 -1.8,1.9 0.7,2.7 -1.4,2.6 -0.5,2.4 2,-0.4 1.2,2.5 0.1,3.7 2.1,1.8 0,1.6 0.7,2.7 3.3,4 0,2.6 -0.8,2.6 0.3,2 2,1.8 0.5,0.3 1.7,-0.7 1.9,-1.2 1.3,-5.7 1.5,-2.9 4,-0.9 1,1.8 3,3.7 1.5,0.5 2,-1.1 4.1,0.3 0.8,1.3 5.5,0 0.2,-1.3 2.9,-1.2 0.5,-1.9 2.1,-1.3 4.8,3.7 2.8,-0.7 2.7,-4.5 3,-3.5 -0.6,-3.9 -1.4,-1.8 3.4,-0.3 0.3,-1.5 2.6,0.5 -0.5,4.7 0.8,4.6 2.9,2.5 0.7,2.2 0,3.1 0.8,0.1 0,-0.7 1.4,-6.7 2.6,-1.8 0.5,-2.6 2.3,-4.8 3.2,-3.2 2.1,-6.2 0.7,-5.5 -0.7,-2.5 1.9,-9.4 z
151	a30129ed-96a5-40bf-83b1-61d9f9443001	e0e0a4c5-9076-4a1e-949f-9dd4521eb0f3	m 668,533.8 -4.6,0.5 -0.6,1.1 -6.7,-1.2 -1,5.7 -3.5,1.6 0.3,1.5 -1.1,3.3 2.4,4.6 1.8,0.1 0.7,3.5 3.3,5.6 3.1,0.5 0.5,-1.3 -0.9,-1.3 0.5,-1.8 2.3,0.6 2.7,-0.7 3.2,1.4 1.4,-2.7 0.6,-2.9 1,-2.8 -2.1,-3.7 -0.4,-4.4 3.1,-5.5 -6,-1.7 z
152	28a5c3d0-cd90-404a-9f47-3bf74088c244	5c3dd764-6824-4689-a3e1-1d8c2dc3bc93	m 1077.7,161.1 -1.9,-2.2 -1.7,-8.4 -7.2,-3.7 -5.9,-2.7 -2.5,0.3 0,3.5 -7.9,-0.9 -0.6,3.1 -4,-0.1 -2.2,3.9 -3.4,6.1 -5.7,7.9 1.8,1.9 -1.3,2.2 -4.3,-0.1 -2.3,5.3 1,7.6 3.1,2.9 -0.9,6.9 -3.4,4 -1.7,3.3 4.2,8.4 4.4,6.7 2,5.7 5.3,-0.3 2.2,-4.7 5.7,0.5 2,-5.5 0.6,-10 4.6,-1.3 3.3,-6.6 -4.8,-3.3 -3.6,-4 2.1,-8.1 7.7,-4.9 6.1,-4.5 -1.2,-3.5 3.4,-3.9 7,-1.5 z
153	504458d1-39f8-4154-b834-b6df676a496b	dacd5cdd-8e56-4067-bfd8-febc66a04058	m 1024.3,270.6 -5.4,-1.9 -1,1.4 -4.2,0 -1.3,1 -2.3,-0.6 0.2,1.6 -3.5,3.5 0,2.8 2.4,-0.9 1.8,2.7 2.2,1.3 2.4,-0.3 2.7,-2.1 0.9,1 2.4,-0.2 0.9,-2.5 3.8,0.8 2.1,-1.1 0.3,-2.5 -2.6,-0.2 -2.3,-1.1 0.7,-1.6 -0.2,-1.1 z
154	29d03348-f8a9-4b0d-b019-26f2db9d4a54	7073c668-a71d-4cf0-a8dd-71008877f8ca	m 1183.5,359.9 11,-6.7 0.9,-7.8 -1.2,-4.7 2.7,-1.6 2.1,-4.1 -5.9,1.1 -2.8,-0.2 -5.7,2.5 -4.3,0 -3,-1.2 -5.5,1.8 -1.9,-1.3 0.1,3.6 -1.2,1.5 -1.2,1.4 -1,2.6 1.1,5 2.4,0.3 1.2,2.5 -2.6,2.4 -0.9,3.5 0.3,2.6 -0.6,1 0.1,0 6.3,2.5 9.6,-6.7 z
155	3c6ea1cf-7057-4799-a891-9177b632aac6	893ca48d-0871-46b1-b299-4bf7e7c98dfa	m 1344.1,315.7 -2.1,0.2 -1.3,-1.8 0.2,-2.9 -6.4,1.5 -0.5,4 -1.5,3.5 -4.4,-0.3 -0.6,2.8 4.2,1.6 2.4,4.7 -1.3,6.6 1.8,0.8 3.3,-2.1 2.1,1.3 0.9,-3 3.2,0.1 0.6,-0.9 -0.2,-2.6 1.7,-2.3 3.2,1.5 0,2 1.6,0.3 1,5.4 2.6,2.1 1.5,-1.3 2.1,-0.7 2.5,-2.9 3.8,0.5 5.4,0 -1.8,-3.7 -0.6,-2.5 -3.5,-1.4 -1.6,0.6 -3,-5.9 -9.5,0.9 -7.1,-2 -5.4,0.5 -0.6,-3.7 5.9,1.1 1.4,-2 z
156	82d7ebc0-0fe2-4a3c-a483-c1a59269812b	1bf315d2-0a2d-4686-9ecb-6d28f8a5b861	m 1149.6,578.6 -2,0.8 2.3,3.6 -0.4,3.7 -1.6,0.8 0,0 0.3,2.5 1.2,1.5 0,2 -1.4,1.4 -2.2,3.3 -2.1,2.3 -0.6,0.1 -0.3,2.7 1.1,0.9 -0.2,2.7 1,2.6 -1.3,2.4 4.5,4.3 0.3,3.9 2.7,6.5 0,0 0.3,0.2 2.2,1.1 3.5,1.1 3.2,1.9 5.4,1.2 1.1,1.7 0,0 0.4,-1.2 2.8,3.4 0.3,6.7 1.8,2.4 0,0.1 2.1,-0.3 6.7,1.8 1.4,-0.8 3.9,-0.1 2.1,-1.9 3.3,0.1 6.2,-2.5 4.6,-3.7 0,0 -2,-1.4 -2.2,-6.3 -1.8,-3.9 0.4,-3.1 -0.3,-1.9 1.7,-3.9 -0.2,-1.6 -3.5,-2.3 -0.3,-3.6 2.8,-7.9 -8,-6.3 -0.4,-3.7 -20.2,-13 0,0 -2.8,2.8 -1.9,2.9 2.2,2.2 -3.2,1.6 -0.7,-0.8 -3.2,0.4 -2.5,1.4 -1.6,-2.4 1.1,-4.5 0.2,-3.8 0,0 0,0 -6.2,-0.1 z
157	d4b6565b-010f-4314-87c6-797f4fc721ac	99d1c02c-0a04-4eae-b6cd-403f94e43959	m 1562.7,481.4 1.5,-2.9 -0.5,-5.4 -5.2,-5.5 -1.3,-6.3 -4.9,-5.2 -4.3,-0.4 -0.8,2.2 -3.2,0.2 -1.8,-1.2 -5.3,3.8 -1,-5.7 0.4,-6.7 -3.8,-0.3 -0.9,-3.8 -2.6,-1.9 -3,1.4 -2.8,2.8 -3.9,0.3 -1.5,6.9 -2.2,1.1 3.5,5.6 4.1,4.6 2.9,4.2 -1.4,5.6 -1.7,1.1 1.7,3.2 4.2,5.1 1,3.5 0.2,3 2.8,5.8 -2.6,5.9 -2.2,6.6 -1.3,6.1 -0.3,3.9 1.2,3.6 0.7,-3.8 2.9,3.1 3.2,3.5 1.1,3.2 2.4,2.4 0.9,-1.1 4.7,2.8 0.6,3.3 3.7,-0.8 1.7,-2.6 -3.1,-3.3 -3.4,-0.8 -3.3,-3.6 -1.4,-5.5 -2.6,-5.8 -3.7,-0.2 -0.7,-4.6 1.4,-5.6 2.2,-9.3 -0.2,-7 4.9,-0.1 -0.3,5 4.7,-0.1 5.3,2.9 -2.1,-7.7 3,-5.2 7.1,-1.3 5.3,1 z
158	4f7aae59-c209-4ae9-96e4-3fc008646f96	1a61eb0b-45a3-4b91-89c2-c22a20676491	m 1676.8,631.9 4.9,-1.8 6,-2.8 2.2,-1.7 -2,-0.8 -1.8,0.8 -4,0.2 -4.9,1.4 -0.8,1.5 0.5,1.3 -0.1,1.9 z
159	858408f6-e54b-4089-a5f3-d5e7bb9e9193	1a7ba610-72c3-4816-81b5-aad9503a4a9b	m 981.7,502.2 -4.9,-0.1 -0.4,1.9 2.4,3.3 -0.1,4.6 0.6,5.1 1.4,2.3 -1.2,5.7 0.4,3.2 1.5,4 1.2,2.2 4.6,-1.3 -1.4,-4.4 0.2,-14.6 -1.1,-1.3 -0.2,-3.1 -2,-2.3 -1.7,-1.9 0.7,-3.3 z
160	7877f772-a380-43d2-ba84-b38681643fbf	85e41f4f-c125-4753-bbed-c2ffc7e1c288	m 13.3,707.7 0,0 -0.2,0.3 0,0.2 0.4,0.4 -0.2,-0.9 z m -1.6,-0.9 -0.2,0 0.2,-0.1 -0.4,-0.2 -0.4,0 -0.2,-0.1 0,-0.2 -0.2,0.3 0.2,0.3 0.9,0.4 0.3,0.2 0.2,-0.6 0,-0.2 -0.3,0.1 0,0.1 -0.1,0 z m 2.5,-16 0.1,-0.2 0,-0.2 -0.3,-0.1 -0.1,0 -0.3,0.5 0.1,0.1 0.3,0.2 0.1,0 0.1,-0.3 z
161	f5a4e7e5-2be9-430f-8624-46e98b6d6123	06659bc5-9958-457e-ac56-2860917a3d28	m 635.4,507.7 0.1,-0.2 0,-0.6 0.2,-0.4 -0.2,-0.4 -0.1,-0.6 0.1,-0.5 0,-0.7 0.2,-0.3 0.5,-0.8 -0.9,0 -0.6,0.2 -1.1,0.1 -0.5,0.2 -0.7,0.1 -0.4,0.2 0.1,0.1 0.5,0.2 0.2,0.2 0.1,0.2 0.1,0.4 -0.3,1.7 -0.1,0.1 -0.6,0.1 -0.2,0.3 -1.4,0.8 0.8,-0.1 0.9,0.1 2.4,-0.1 0.9,-0.3 z m 1.8,-6.7 1.2,-0.5 0.1,-0.4 -0.2,0 -0.8,0.3 -0.6,0.5 0,0.2 0.3,-0.1 z
162	4c73d72a-5931-4e2a-adf8-9fcbdb22af3c	cac7a781-be5d-4c59-b9b8-d8bb65fb1487	m 1038,361.4 -2,-1 -1.5,-3 -2.8,-0.1 -1.1,-3.5 3.4,-3.2 0.5,-5.6 -1.9,-1.6 -0.1,-3 2.5,-3.2 -0.4,-1.3 -4.4,2.4 0.1,-3.3 -3.7,-0.7 -5.6,2.6 -1,3.3 1,6.2 -1.1,5.3 -3.2,3.6 0.6,4.8 4.5,3.8 0,1.5 3.4,2.6 2.6,11.3 2.6,-1.4 0.4,-2.7 -0.7,-2.6 3.7,-2.5 1.5,-2 2.6,-1.8 0.1,-4.9 z
163	22a71094-55e2-4852-86fa-f27db4799a22	fb99fe5c-118c-44d8-97ba-6570cdb7bd33	m 1166.6,308.9 -9.7,-4.4 -8.5,0.2 -5.7,1.7 -5.6,4 -9.9,-0.8 -1.6,4.8 -7.9,0.2 -5.1,6.1 3.6,3 -2,5 4.2,3.6 3.7,6.4 5.8,-0.1 5.4,3.5 3.6,-0.8 0.9,-2.7 5.7,0.2 4.6,3.5 8,-0.7 3.1,-3.7 4.6,1.5 3.2,-0.6 -1.7,2.4 2.3,3 1.2,-1.4 1.2,-1.5 -0.1,-3.6 1.9,1.3 5.5,-1.8 3,1.2 4.3,0 5.7,-2.5 2.8,0.2 5.9,-1.1 2.1,-1 6.2,0.9 2.1,1.6 2.3,-1.1 0,0 -3.7,-5.2 0.7,-2 -2.9,-7.3 3.3,-1.8 -2.4,-1.9 -4.2,-1.5 0,-3.1 -1.3,-2.2 -5.6,-3 -5.4,0.3 -5.5,3.2 -4.5,-0.6 -5.8,1 -7.8,-2.4 z m -49.6,4 2,-1.9 6.1,-0.4 0.7,-1.5 -4.7,-2 -0.9,-2.4 -4.5,-0.8 -5,2 2.7,1.6 -1.2,3.9 -1.1,0.7 0.1,1.3 1.9,2.9 3.9,-3.4 z
164	13310a40-4260-4267-8199-3139bbfc7082	0adc54bf-ff91-4cb0-8571-d89b779f1061	m 1325.6,334.2 -0.8,-4 -7.7,-2.7 -6.2,-3.2 -4.2,-3 -7,-4.4 -4.3,-6.4 -2,-1.2 -5.5,0.3 -2.3,-1.3 -1.9,-4.9 -7.8,-3.3 -3.3,3.6 -3.8,2.2 1.6,3.1 -5.8,0.1 -2.5,0.3 -4.9,-4.9 -3.8,-1.7 -5.5,1.3 -1.8,2 2.5,4 -0.5,-4.5 3.7,-1.6 2.4,3.6 4.6,3.7 -4,2 -5.3,-1.5 0.1,5.2 3.5,0.4 -0.4,4.4 4.5,2.1 0.7,6.8 1.8,4.5 4.4,-1.2 3,-3.7 3.5,0.2 2.1,-1.2 3.8,0.6 6.5,3.3 4.3,0.7 7.3,5.7 3.9,0.2 1.6,5.5 5.9,2.4 3.9,-0.8 0.4,-3 4,-0.9 2.5,-2 -0.1,-5.2 4.1,-1.2 0.3,-2.3 2.9,1.7 1.6,0.2 z
165	9ea2aaa4-f87a-47d6-835d-d30796cd1ccf	2b1a33fe-be25-452b-8a1c-c7d5f1dce9c2	m 1283.9,408.6 -1.3,-2.2 -3,3.9 -3.7,4.1 -3.3,4.3 -3.3,-0.2 -4.6,-0.2 -4.2,1 -0.3,-1.7 -1,0.3 0.4,1.5 2.6,6.4 16.8,3.2 1,-1.3 -0.1,-2.6 1.4,-2.6 -0.3,-2.6 2.4,-1.3 -1.1,-0.8 0.1,-4.2 2.8,0 -1.3,-5 z
166	58a13794-53e1-4f99-93f3-1e350f98f84f	c5ce24da-dd58-4e8e-a5e3-91b478717bb4	m 1167.6,545.1 -3.4,3 -4,-0.1 -4.5,1.5 -3.5,-1.4 -2.3,1.7 0,0 -0.3,7.5 2.3,0.8 -1.8,2.3 -2.2,1.7 -2.1,3.3 -1.2,3 -0.3,5.1 -1.3,2.4 -0.1,4.8 1.4,0.6 3.3,-1.9 2,-0.8 6.2,0.1 0,0 -0.3,-2.5 2.6,-3.7 3.5,-0.9 2.4,-1.5 2.9,1.2 0.3,0.5 0,-0.3 1.6,-2.6 2.7,-4.2 2.1,-4.7 -2.6,-7.3 -0.7,-3.2 -2.7,-4.4 z
167	c5e358a8-3943-488b-ad1a-e73571fc71cb	6b63bb5b-0238-4263-bdf4-8064a4fb5c26	m 1138.5,241 -4.8,0.5 -1.5,-0.3 -1,1.4 -1.8,-0.2 0,0 -4.1,0.3 -1.2,1.4 0.2,3.1 -2,-0.6 -4.3,0.3 -1.5,-1.5 -1.6,1.1 -2,-0.9 -3.8,-0.1 -5.6,-1.5 -5,-0.5 -3.7,0.2 -2.4,1.6 -2.2,0.3 3.1,5.3 -0.3,1.8 -2.3,0.7 -3.8,5.1 1.6,2.8 -1.1,-0.4 -1.1,1.7 -0.7,2.5 2.9,1.7 0.6,1.6 1.9,-1.3 3.2,0.7 3.2,0 2.4,1.5 1.6,-0.9 3.6,-0.6 1,-1.5 2.1,0 1.1,-0.9 3.2,-0.6 3.9,1.9 2,0.3 2.5,1.6 0,2.1 1.9,1.1 1.1,2.6 2,1.5 -0.2,1 1,0.6 -1.2,0.5 -3,-0.2 -0.6,-0.9 -1,0.5 0.5,1.1 -1.1,2 -0.5,2.1 -1.2,0.7 2.4,1.1 2.2,-1 2.4,1.1 3.3,-4.6 1.3,-3.4 4.5,-0.8 0.7,2.4 8,1.5 1.7,1.4 -4.5,2.1 -0.7,1.2 5.8,1.8 -0.6,2.9 3,1.3 6.3,-3.6 5.3,-1.1 0.6,-2.2 -5.1,0.4 -2.7,-1.5 -1,-3.9 3.9,-2.3 4.6,-0.3 3,-2 3.9,-0.5 -0.4,-2.8 2.2,-1.7 4.7,-0.5 0.3,-2.1 -1.8,-3.4 1.3,-3.2 -0.4,-1.9 -7.6,-2 -2.9,0.1 -3.6,-2.9 -3.5,1 -6.6,-2.2 -0.2,-1.2 -2.2,-2.7 -4,-0.2 -0.7,-1.9 0.9,-1.3 -3.8,-3.4 z
168	651ccb00-c014-4f15-83ce-cacacd83422f	0f433ba9-47e1-4fe6-902c-632bf40355a9	m 950,227.5 -4.9,-3.7 -3.9,0.3 0.8,3.2 -1.1,3.2 2.9,-0.1 3.5,1.3 2.7,-4.2 z m 13,-24.3 -5.5,0.5 -3.6,-0.4 -3.7,4.8 -1.9,6.1 2.2,3 0.1,5.8 2.6,-2.8 1.4,1.6 -1.7,2.7 1,1.6 5.7,1.1 0.1,0 3.1,3.8 -0.8,3.5 0,0 -7.1,-0.6 -1,4 2.6,3.3 -5.1,1.9 1.3,2.4 7.5,1 0,0 -4.3,1.3 -7.3,6.5 2.5,1.2 3.5,-2.3 4.5,0.7 3.3,-2.9 2.2,1.2 8.3,-1.7 6.5,0.1 4.3,-3.3 -1.9,-3.1 2.4,-1.8 0.5,-3.9 -5.8,-1.2 -1.3,-2.3 -2.9,-6.9 -3.2,-1 -4.1,-7.1 -0.4,-0.6 -4.8,-0.4 4.2,-5.3 1.3,-4.9 -5,0 -4.7,0.8 5,-6.4 z
169	3b371b11-f90c-4f13-8466-368b757de398	d95a4486-5ca4-4500-8b10-211b945552c8	m 692.5,787 -2.1,-3.7 1.9,-3 -3.8,-4.3 -4.8,-3.5 -6.2,-4.1 -1.9,0.2 -6.2,-4.9 -3.4,0.7 -0.5,5.1 -0.3,6.5 1.1,6.3 -0.9,1.4 0.4,4.2 3.9,3.5 3.6,-0.2 5.4,2.7 2.7,-0.6 4.2,1.2 5.3,-3.5 1.6,-4 z
170	bea4007a-1369-43ad-bde1-23dcca4252d2	0bea6297-7d53-49a7-927e-e5cbc57e3b5a	m 116.7,450.7 2,-0.9 2.5,-1.4 0.2,-0.4 -0.9,-2.2 -0.7,-0.8 -0.8,-0.6 -1.9,-1.1 -0.4,-0.1 -0.4,0.6 0,1.3 -1.2,1 -0.4,0.7 0.4,2.3 -0.6,1.8 1.2,0.9 1,-1.1 z m -0.6,-9.9 0.6,-0.7 -1.2,-1 -1.8,-0.6 -0.7,0.5 0,0.4 0.5,0.5 0.6,1.4 2,-0.5 z m -3,-3.4 -2.6,-0.2 -0.6,0.7 2.9,0.2 0.3,-0.7 z m -4.7,-0.9 -1.1,-2.1 -0.3,-0.4 -1.7,0.9 0.1,0.2 0.4,1.5 1.8,0.2 0.4,0.1 0.4,-0.4 z m -8.3,-4.2 0.3,-1.5 -1.3,-0.1 -1,0.6 -0.4,0.5 1.6,1.1 0.8,-0.6 z m 412.1,-173.2 -1.6,0 -1.3,2.4 -10.1,0 -16.8,0 -16.7,0 -14.8,0 -14.7,0 -14.5,0 -15,0 -4.8,0 -14.6,0 -13.9,0 -1.6,5.1 -2.4,5.1 -2.3,1.6 1.1,-5.9 -5.8,-2.1 -1.4,1.2 -0.4,2.9 -1.8,5.4 -4.2,8.3 -4,5.6 -4,5.6 -5.4,5.8 -1.1,4.7 -2.8,5.3 -3.9,5.2 1,3.4 -1.9,5.2 1.5,5.4 1.3,2.2 -0.8,1.5 0.4,9 2.5,6.5 -0.8,3.5 1,1 4.6,0.7 1.3,1.7 2.8,0.3 -0.1,1.9 2.2,0.7 2.1,3.7 -0.3,3.2 6.3,-0.5 7,-0.7 -1,1.3 7.1,3.1 10.7,4.4 10.7,0 4.3,0 0.8,-2.6 9.3,0 1.3,2.2 2.1,2 2.4,2.8 0.8,3.3 0.4,3.5 2.2,1.9 4,1.9 4.8,-5 4.4,-0.1 3.1,2.5 1.6,4.4 1,3.7 2.4,3.6 0.2,4.5 0.8,3 3.9,2 3.6,1.4 2.1,-0.2 -0.6,-2.2 0.4,-3.1 1,-4.4 1.9,-2.8 3.7,-3.1 6,-2.7 6.1,-4.7 4.9,-1.5 3.5,-0.4 3.5,1.4 4.9,-0.8 3.3,3.4 3.8,0.2 2.4,-1.2 1.7,0.9 1.3,-0.8 -0.9,-1.3 0.7,-2.5 -0.5,-1.7 2.4,-1 4.2,-0.4 4.7,0.7 6.2,-0.8 3,1.5 2,3 0.9,0.3 6.1,-2.9 1.9,1 3,5.3 0.8,3.5 -2,4.2 0.4,2.5 1.6,4.9 2,5.5 1.8,1.4 0.4,2.8 2.6,0.8 1.7,-0.8 2,-3.9 0.7,-2.5 0.9,-4.3 -1.2,-7.4 0.5,-2.7 -1.5,-4.5 -0.7,-5.4 0.1,-4.4 1.8,-4.5 3.5,-3.8 3.7,-3 6.9,-4.1 1.3,-2.2 3.3,-2.3 2.8,-0.4 4.4,-3.8 6,-1.9 4.6,-4.8 0.9,-6.5 0.1,-2.2 -1.4,-0.4 1.5,-6.2 -3,-2.1 3.2,1 0,-4.1 1.9,-2.7 -1,5.3 2,2.5 -2.9,4.4 0.4,0.2 4.4,-5.1 2.4,-2.5 0.6,-2.5 -0.9,-1.1 -0.1,-3.5 1.2,1.6 1.1,0.4 -0.1,1.6 5.2,-4.9 2.5,-4.5 -1.4,-0.3 2.1,-1.8 -0.4,0.8 3.3,0 7.8,-1.9 -1.1,-1.2 -7.9,1.2 4.8,-1.8 3.1,-0.3 2.4,-0.3 4.1,-1.1 2.4,0.1 3.8,-1 1,-1.7 -1.1,-1.4 -0.2,2.2 -2.1,-0.1 -0.6,-3.3 1.1,-3.3 1.4,-1.3 3.9,-3.7 5.9,-1.8 6,-2.1 6.3,-3 -0.2,-2 -2.1,-3.5 2.8,-8.5 -1.5,-1.8 -3.7,1.1 -1.1,-1.7 -5.5,4.7 -3.2,4.9 -2.7,2.8 -2.5,0.9 -1.7,0.3 -1,1.6 -9.3,0 -7.7,0 -2.7,1.2 -6.7,4.2 0.2,0.9 -0.6,2.4 -4.6,2 -3.9,-0.5 -4,-0.2 -2.6,0.7 -0.3,1.8 0,0 -0.1,0.6 -5.8,3.7 -4.5,1.8 -2.9,0.8 -3.7,1.7 -4,0.9 -2.5,-0.3 -2.7,-1.3 2.7,-2.4 0,0 2,-2.2 3.7,-3.4 0,0 0,0 0.7,-2.5 0.5,-3.5 -1.6,-0.7 -4.3,2.8 -0.9,-0.1 0.3,-1.5 3.8,-2.5 1.6,-2.8 0.7,-2.8 -2.7,-2.4 -3.7,-1.3 -1.7,2.4 -1.4,0.6 -2.2,3.1 0.4,-2.1 -2.6,1.5 -2.1,2 -2.6,3.1 -1.3,2.6 0.1,3.8 -1.8,4 -3.3,3 -1.4,0.9 -1.6,0.7 -1.8,0 -0.3,-0.4 -0.1,-3.3 0.7,-1.6 0.7,-1.5 0.6,-3 2.5,-3.5 2.9,-4.3 4.6,-4.7 -0.7,0 -5.4,4 -0.4,-0.7 2.9,-2.3 4.7,-4 3.7,-0.5 4.4,-1.3 3.7,0.7 0.1,0 4.7,-0.5 -1.5,-2.5 0,0 -1.2,-0.2 0,0 0,0 -1.4,-0.3 -0.4,-1.7 -5.1,0.5 -5,1.4 -2.5,-2.3 -2.5,-0.8 3.1,-3.3 -5.3,2 -4.9,2.1 -4.6,1.5 -2.1,-2.1 -5.5,1.3 0.4,-0.9 4.6,-2.6 4.7,-2.5 5.9,-2.1 0,0 0,0 -5.3,-1.6 -4.4,0.8 -3.8,-1.9 -4.6,-1 -3.2,-0.4 -1,-1 0.8,-3.4 z m -240.6,-46.9 6.9,-2.8 0,-1.8 -2.6,-0.4 -3.4,0.9 -6.4,2.1 -2.2,2.7 0.7,1.6 7,-2.3 z m -38.7,-16.4 2.3,-2.3 -2.9,-0.5 -5.7,1 0.8,1.6 1.6,1.1 3.9,-0.9 z m 1.2,-22.3 -3.1,2.2 0.4,0.5 4.2,-0.4 0.3,1.1 1.7,1.2 4.9,-1.2 1.2,-0.6 -3.3,-0.8 -1.6,-1.5 -3.4,0.6 -1.3,-1.1 z m 124.9,-40.2 -4.4,-1.1 -10.2,2.8 -3.2,-0.3 -11,2.3 -4.8,0.6 -7.8,2.5 -4.8,2.6 -8.6,2.5 -7.6,0.1 -6.3,2.9 3.2,1.7 0.7,2.3 -0.8,2.7 2.3,2.1 -1.2,3.5 -9.2,0.2 4.3,-2.8 -3.4,0 -13.1,2.7 -9.1,2.3 1,3.3 -1.2,2.2 4.5,1.4 6.9,-0.7 1.8,1.3 2.9,-1.3 6.1,-1.2 2.7,0 -5.9,2.1 1.1,1 -2.5,2.6 -5.5,1.8 -2.5,-0.5 -7,2.7 -1.8,-0.9 -4.1,0.4 -5.3,3 -7.6,3.1 -5.8,3.4 0.3,2.4 -4,3.3 1.4,1.4 0.5,2.7 7.2,-1.1 0.4,2.1 -3.3,2.1 -3.6,3.5 2.8,0 7.2,-2.3 -1.6,2.9 3.6,-2.1 -0.4,3 4.8,-2.2 0.4,1.1 7.2,-1.8 -6.2,3.4 -5.7,4.5 -5.7,2.1 -2.3,1.2 -10.3,3.6 -4.9,2.4 -6.5,0.7 -8.5,3.3 -6.6,1.8 -8.1,2.8 -0.4,1 10,-1.7 6,-2 6.9,-2 6.1,-1.7 2.8,0.5 8.1,-2.6 4.5,-2.8 10.5,-3.1 3.9,-2.6 6.6,-1.8 7.6,-2.5 8.9,-4.2 -0.2,-2.9 11.1,-4.1 7.4,-3.9 9.2,-3.2 -0.4,1.4 -6.7,1.8 -8.3,5.7 -3.2,3.5 6.4,-1.3 6.1,-1.9 6.5,-1.3 2.9,-0.3 3.5,-4.1 6.3,-1.2 2.6,2.5 6,2.7 6.7,-0.5 5.7,2 3.2,1.1 3.3,6.1 3.7,1.7 7.1,0.2 4.1,0.4 -2.7,5.5 1.6,4.9 -3.3,5.2 2.5,1.9 0.6,2.2 0,0 5.1,-2.9 3.1,-3.7 -4.6,-3.8 1.5,-6.8 1.1,-4.2 -1.7,-2.7 -0.7,-2.4 0.5,-3 -6.4,1.9 -7.6,3.3 -0.2,-3.9 -0.6,-2.6 -2.7,-1.6 -4.2,-0.1 35.4,-32.4 24.3,-20.2 0,0 0,0 -3.5,-0.7 -4.1,-1.6 -6.5,0.8 -2.2,-0.7 -7.1,-0.5 -6.2,-1.6 -4.8,0.5 -4.9,-0.9 2,-1.2 -6.3,-0.3 -3.3,1 0.5,-2.4 z
171	21a57df2-e3e2-4f7e-9506-823bd2cc2214	19c52566-e35f-44fd-8130-d64562928fe2	m 1339.8,303.1 -2.5,1.2 -5.4,4.3 -0.9,4.5 -1.9,0 -2.3,-3 -6.6,-0.2 -2.6,-5 -2.5,-0.1 -1.5,-6.2 -7.5,-4.5 -8.6,0.5 -5.7,0.9 -6.5,-5.5 -4.8,-2.3 -9.1,-4.5 -1.1,-0.5 -11.9,3.6 6.2,22.8 5.8,-0.1 -1.6,-3.1 3.8,-2.2 3.3,-3.6 7.8,3.3 1.9,4.9 2.3,1.3 5.5,-0.3 2,1.2 4.3,6.4 7,4.4 4.2,3 6.2,3.2 7.7,2.7 0.8,4 2.9,0 4.3,1.4 1.3,-6.6 -2.4,-4.7 -4.2,-1.6 0.6,-2.8 4.4,0.3 1.5,-3.5 0.5,-4 6.4,-1.5 -0.2,2.9 1.3,1.8 2.1,-0.2 4.1,0.6 5.2,-4.5 -7.1,-3.3 -3.2,1.6 -4.6,-2.3 3.1,-4.1 -1.8,-0.6 z
172	936a4446-822e-4f35-81f8-a3ca84ad4637	33f94df7-cd4f-487a-aa5c-fb45b65f19d5	m 1908.6,676.9 -2.7,-3.6 -0.6,1.7 1.3,2.8 2,-0.9 z m -2,-9.7 -2.3,-2 -0.9,4.9 0.5,1.8 1.2,-0.4 1.3,0.8 0.2,-5.1 z
173	da770866-8182-4d8f-aa72-8d1497932cf7	3a93a29d-abcc-45af-8915-8e983662c88a	m 642,518.9 -2.2,-1.5 -2.9,0.2 -0.7,-5.1 -4.1,-3.2 -4.4,-0.4 -1.8,-3 4.8,-1.9 -6.7,0.1 -6.9,0.4 -0.2,1.6 -3.2,1.9 -4.2,-0.7 -3.1,-2.9 -6,0.7 -5,-0.1 -0.1,-2.1 -3.5,-3.5 -3.9,-0.1 -1.7,-4.5 -2.1,2 0.6,3 -7.1,2.6 0,4.8 1.6,2.2 -1.5,4.6 -2.4,0.4 -1.9,-5 2.7,-3.7 0.3,-3.3 -1.7,-2.9 3.3,-0.8 0.3,-1.5 -3.7,1.1 -1.6,3.2 -2.2,1.8 -1.8,2.4 -0.9,4.5 -1.8,3.7 2.9,0.5 0.6,2.9 1.1,1.4 0.4,2.5 -0.8,2.4 0.2,1.3 1.3,0.6 1.3,2.2 7.2,-0.6 3.2,0.8 3.8,5.5 2.3,-0.7 4,0.3 3.2,-0.7 2,1.1 -1.2,3.4 -1.3,2.1 -0.5,4.6 1,4.2 1.5,1.9 0.2,1.5 -2.9,3.1 2,1.4 1.4,2.2 1.7,6.4 3,3.4 4.4,-0.5 1.1,-1.9 4.2,-1.5 2.3,-1 0.7,-2.7 4.1,-1.8 -0.3,-1.4 -4.8,-0.5 -0.7,-4 0.3,-4.3 -2.4,-1.6 1,-0.6 4.2,0.8 4.4,1.6 1.7,-1.5 4,-1 6.4,-2.4 2.1,-2.4 -0.7,-1.8 -3.7,-4.8 1.6,-1.8 0,-2.9 3.4,-1.1 1.5,-1.2 -1.9,-2.3 0.6,-2.3 4.6,-3.8 z
174	bab8e7c7-36df-4b76-a84c-a410d1ce766b	ec48dda4-e153-4854-9bc3-453263e606b1	m 1571.6,435 -5.9,-1.6 -3,-2.6 0.2,-3.7 -5.2,-1.1 -3,-2.4 -4.1,3.4 -5.3,0.7 -4.3,0 -2.7,1.5 4,5.1 3.4,5.7 6.8,0.1 3,5.5 -3.3,1.7 -1.3,2.3 7.3,3.8 5.7,7.5 4.3,5.6 4.8,4.4 2,4.5 -0.2,6.4 1.8,4.2 0.1,7.7 -8.9,4.9 2.8,3.8 -5.8,0.5 -4.7,2.5 4.5,3.7 -1.3,4.3 2.3,4 6.6,-5.9 4.1,-5.3 6.1,-4.1 4.3,-4.2 -0.4,-11.2 -4,-11.7 -4.1,-5.1 -5.6,-4 -6.4,-8.3 -5.3,-6.7 0.5,-4.4 3.7,-6 6.5,-5.5 z
175	a763102c-f3be-41f7-966b-277e8e8940d5	9da8253b-a4dc-41f8-b8fa-e751b6812191	m 1271.5,466.2 -2.1,-4.4 -5.2,-10.5 -15.7,2.4 -5,2.9 -3.5,6.7 -2.5,1 -1.6,-2.1 -2.1,0.3 -5.4,-0.6 -1,-0.7 -6.4,0.2 -1.5,0.6 -2.4,-1.7 -1.2,3.1 0.7,2.7 -2.3,2.1 0.4,2.7 -0.6,1.3 0.7,2.9 -1.1,0.3 1.7,2.6 1.3,4.7 1,1.9 0,3.4 1.6,3.8 3.9,0.3 1.8,-0.9 2.7,0.2 0.8,-1.7 1.5,-0.4 1.1,-1.7 1.4,-0.4 4.7,-0.3 3.5,-1.2 3.1,-2.7 1.7,0.4 2.4,-0.3 4.7,-4.5 8.8,-3 5.3,-2.7 0,-2.1 0.9,-2.9 3.9,-1.7 z
176	0eaf9ad3-e787-4eea-a615-514b8d0edc0d	40fbcdb1-c386-45b7-946f-7e4190dcc02c	m 1149.2,626.7 -1.9,-0.5 0.4,-1.3 -1,-0.3 -7.5,1.1 -1.6,0.7 -1.6,4.1 1.2,2.8 -1.2,7.5 -0.8,6.4 1.4,1.1 3.9,2.5 1.5,-1.2 0.3,6.9 -4.3,0 -2.1,-3.5 -2,-2.8 -4.3,-0.8 -1.2,-3.4 -3.4,2 -4.5,-0.9 -1.8,-2.8 -3.5,-0.6 -2.6,0.1 -0.3,-2 -1.9,-0.1 0.5,2 -0.7,3 0.9,3 -0.9,2.4 0.5,2.2 -11.6,-0.1 -0.8,20.3 3.6,5.2 3.5,4 4.6,-1.5 3.6,0.4 2.1,1.4 0,0.5 1,0.5 6.2,0.7 1.7,0.7 1.9,-0.1 3.2,-4.1 5.1,-5.3 2,-0.5 0.7,-2.2 3.3,-2.5 4.2,-0.9 -0.3,-4.5 17.1,-5.2 -2.9,-1.7 1.9,-5.9 1.8,-2.2 -0.9,-5.3 1.2,-5.1 1,-1.8 -1.2,-5.4 -2.6,-2.8 -3.2,-1.9 -3.5,-1.1 -2.2,-1.1 -0.3,-0.2 0,0 0.5,1.1 -1,0.4 -1.2,-1.4 z
177	5ddaa5ed-0ec7-4328-8e9d-908ba4e9942b	39658cd7-be12-4512-8a90-0b2cc9b2769d	m 1148.2,713.7 6.2,-7.2 1.6,-4.6 0.9,-0.6 0.8,-3.7 -0.8,-1.9 0.5,-4.7 1.3,-4.4 0.3,-8.1 -2.8,-2 -2.6,-0.5 -1.1,-1.6 -2.6,-1.3 -4.6,0.1 -0.3,-2.4 -4.2,0.9 -3.3,2.5 -0.7,2.2 -2,0.5 -5.1,5.3 -3.2,4.1 -1.9,0.1 -1.7,-0.7 -6.2,-0.7 1.9,5.1 1.1,1.1 1.6,3.7 6,7 2.3,0.7 -0.1,2.2 1.5,4.1 4.2,0.9 3.4,2.9 2.2,0.1 2.6,1.1 1.9,-0.8 2.9,0.6 z
178	cf4d4ed4-4136-4ed8-8d37-03e64e53b3ff	49ca53d4-0d59-4be8-9724-70b0eff911ce	m 1617.8,543.4 2.7,3.3 1.1,-2.2 2.7,0.2 0.1,-4.1 0.1,-3.1 -4.6,3.5 -2.1,2.4 z
179	cb64a419-1f99-4749-89bb-a07ba83ae7cd	52dc85c7-9f30-470a-9de9-09b95bc11e86	m 1637.3,331.7 6.2,5.5 -3.4,1.1 5.2,6.8 1.1,4.8 2.1,3.5 4.5,-0.5 3.2,-2.7 4.2,-1.2 0.5,-3.6 -3.4,-7.5 -3.3,-4.2 -8.2,-7.6 0.1,1.6 -2.1,0.4 -3.5,0.3 -0.7,2.9 -2.4,-0.2 -0.1,0.6 z
180	57f2ceeb-2624-4964-bbc8-cc7d9f5e6bca	34e549be-e921-419a-a64d-2349902ee1e8	m 1574.8,481.8 0.2,-6.4 -2,-4.5 -4.8,-4.4 -4.3,-5.6 -5.7,-7.5 -7.3,-3.8 1.3,-2.3 3.3,-1.7 -3,-5.5 -6.8,-0.1 -3.4,-5.7 -4,-5.1 -2.7,1 1.9,7.2 -2.9,-0.1 -0.7,-1.5 -4.1,4.1 -0.8,2.4 2.6,1.9 0.9,3.8 3.8,0.3 -0.4,6.7 1,5.7 5.3,-3.8 1.8,1.2 3.2,-0.2 0.8,-2.2 4.3,0.4 4.9,5.2 1.3,6.3 5.2,5.5 0.5,5.4 -1.5,2.9 4.9,2.4 2,-4.3 5.2,2.3 z
181	54b51772-0966-422f-887c-826ef5805324	6b9ca8c2-1096-496b-9aa2-0a0dc3fb4f32	m 1094,304.8 -2.8,-2 -2.4,0.1 -1.7,0.4 -1.1,0.2 -2.9,1 -0.1,1.2 -0.7,0 0,0 -0.4,2.1 0.9,2.6 2.3,1.6 3.3,-0.6 1.9,-1.3 2.8,0.1 0.7,-1.1 1,-0.2 -0.8,-4.1 z
182	b00c808a-6544-4c09-b6bb-fd806bb05d4a	54824162-df76-4f5e-8783-404687f907f1	m 634.5,491.4 0,0 0,-0.1 0.1,0 0,-0.1 0,0 0,-0.1 -0.1,0 0,0.1 0,0 0,0.1 -0.1,0 0,0.1 0,0 0,0 0.1,0 z m 0.7,-1.9 0.1,-0.2 0.1,-0.1 0,0 0,0 -0.1,-0.1 0,0 0,0.1 -0.2,0.1 0,0 0,0.1 0,0 0,0.1 -0.1,0 -0.1,0 0,0 0.1,0 0,0 0.1,0.1 0,0 0,0 0,0 0.1,-0.1 z m 0.3,-1.1 0.3,-0.2 0.1,-0.6 -0.1,-0.4 -0.2,0 -0.3,0.1 -0.2,0.3 -0.1,0.5 0.4,0.4 0.1,-0.1 z
183	c57467ba-80e5-455d-b4ac-da85581f8e57	44344c65-9381-42d7-a573-6a9e38ead0f0	m 586.6,492.9 -0.1,-0.1 -0.3,-0.6 -0.3,-0.3 -0.1,0.1 -0.1,0.3 0.3,0.3 0.3,0.4 0.3,0.1 0,-0.2 z
184	bb69def3-d804-43cb-8030-23957f7d8c36	5cbe7035-cbba-4ba4-9e59-1338db15983a	m 630.2,366.8 0.4,-0.6 -0.1,0 -0.5,0.5 -0.6,0.2 0.1,0.1 0.1,0 0.6,-0.2 z
185	0c40fc5e-abd5-4c11-a761-722d20b9d4d1	4fe94a12-77e5-4a49-94c4-6bff7b9f1b2e	m 619.2,455.1 0.3,-0.2 -0.2,-0.1 -0.4,0 -0.3,0.2 0.1,0.1 0.5,0 z m 1.1,-0.4 0.4,-0.4 -0.5,0.1 -0.2,0.2 0.1,0.1 0.1,0 0.1,0 z m 0.8,-1.8 -0.2,0 -0.5,0 0,0 0.1,0.1 0.3,0 0.3,0.1 0,0 0,-0.2 z
186	8cc9652b-faec-4e0d-890f-c13a2616eb7b	b4a2b89a-1d72-4928-becb-eb198ed494be	m 879.6,395.2 -0.2,-0.2 -0.7,0.5 -0.6,0 0.1,0.2 0.1,0.2 0.7,0.4 0.6,-1.1 z m 13.5,-2.1 0,-0.1 -0.1,0 -0.1,0.1 -1.3,-0.1 -0.2,0.6 -0.5,0.4 0,0.7 0.5,0.7 0.3,0.1 0.5,0.1 0.7,-0.4 0.2,-0.4 0.1,-0.8 -0.1,-0.4 0,-0.5 z m -9.7,0.8 0.5,-0.4 0,-0.2 -0.1,-0.3 -0.5,-0.3 -0.2,0 -0.2,0.2 -0.2,0.4 0.3,0.5 0.2,0.1 0.2,0 z m 4.7,-2.3 1.2,-1 0,-0.3 -1,0.1 -1.1,1 -0.3,0.1 -1,0.1 -0.5,0 -0.4,0.2 0.2,0.3 0.4,1 0.7,0.9 0.6,-0.2 0.3,-0.2 0.4,-0.6 0.5,-1.4 z m 11.6,1.3 1.5,-0.5 0.3,-1 0.3,-1.1 0,-0.7 -0.2,-0.3 -0.1,0 -0.4,0 -0.3,0.2 -0.1,0.6 -0.7,1.3 -0.5,1.2 -0.7,0.6 -0.7,0.2 0.1,0.1 0.7,0.1 0.8,-0.7 z m -19.7,-2 0.5,-0.5 0.1,-0.3 -0.1,-0.5 0.2,-0.2 -0.1,-0.4 -0.3,-0.4 -0.7,0 -0.4,0.6 0.6,1.2 0.1,0.5 0.1,0 z m 22.4,-2.7 0.9,-0.3 0.5,-0.3 0.1,-0.9 0.2,-0.3 -0.2,-0.3 -0.2,0.2 -0.2,0.4 -0.6,0.2 -0.8,0.4 -0.2,0.3 -0.2,0.9 0.4,0.1 0.3,-0.4 z
187	1f7663c7-01f3-47f7-812a-1a9825a438a5	3e77325d-7fea-46ad-a8fa-b2d31056b3ea	m 841.4,477.6 0.1,-0.4 -0.2,-0.6 -0.3,-0.1 -0.6,0.4 -0.1,0.3 0.1,0.3 0.3,0.3 0.3,0.1 0.4,-0.3 z m 6.3,-1.7 0.4,-0.2 0,-0.7 -0.1,-0.3 -0.4,0 -0.2,0.4 0,0.1 0,0.4 0.2,0.3 0.1,0 z m -1.4,0.8 -0.5,-0.9 -0.3,-0.1 -0.6,-0.7 0,-0.3 -0.3,-0.1 0,0.2 0,0.4 -0.2,0.5 0,0.5 0.4,0.8 0.4,0.2 0.7,0.1 0.4,-0.6 z m 3.1,-7.8 0,0.5 -0.3,0.7 0.5,0.3 0.3,0.1 0.6,-0.4 0.2,-0.5 -0.1,-0.3 -0.3,-0.3 -0.3,-0.1 -0.1,0.1 -0.5,-0.1 z m -6.4,-2.5 -1,-0.1 -0.6,-0.2 -0.1,0 0,0.3 0.4,0.8 0.2,-0.5 0.2,-0.1 0.8,0.2 0.4,-0.1 -0.1,-0.1 -0.2,-0.2 z m 6.7,-0.2 -0.1,-0.5 0,-0.7 -0.2,0 -0.3,0.2 0.1,0.7 0.1,0.1 0.2,0.5 0.2,-0.3 z m -11.1,-1 0,-0.2 -0.3,-0.5 -0.3,0.1 -0.4,0.2 -0.1,0.3 0.4,0.2 0.2,0 0.5,-0.1 z m -1.5,-0.9 0.8,-0.6 0.2,-0.3 -0.2,-0.5 -0.5,-0.1 -1.2,0.6 -0.1,0.2 0.1,0.3 0.1,0.5 0.2,0.1 0.6,-0.2 z
188	d583ed32-ff0d-4f11-8321-ea8fc477780c	8372a0ad-58ad-41f7-af06-dea7df6ef891	m 527,449.1 -0.1,-0.3 -0.1,0.1 0,0.6 0.5,0 0.2,0 0.3,-0.2 0.6,0 -0.1,-0.2 -0.8,-0.1 -0.1,0.1 -0.2,0.1 -0.2,-0.1 z m 8,-2.3 0,0 -0.1,-0.1 -0.1,0 -0.3,0.1 -0.1,0 -0.1,0 -0.1,0.1 -0.1,0.1 0.2,0 0.4,-0.2 0.2,0 0.1,0 z m 0.8,-0.1 0.5,-0.2 0,0 -0.1,-0.1 -0.1,0 -0.1,0.1 -0.1,0 -0.5,0.3 0.2,0 0.2,-0.1 z
189	d9c72a4f-fca6-416d-9f49-909f4e4a5d23	3ba46aea-ed4b-48bc-919d-a93a4d6f1d6e	m 595.9,494.9 0,-0.6 -0.9,-0.4 0,0.3 0.1,0.2 0.3,0.1 0.1,0.2 -0.1,0.6 0.2,0.3 0.3,-0.7 z
190	2498c4c7-c06b-43aa-b2e5-9419624b4788	38c4b24f-a7d0-4af2-9d09-724ab4ad9017	m 947,186.9 0,-0.3 -0.1,-0.3 0,-0.2 -0.1,0 -0.5,-0.1 -0.1,-0.2 -0.1,0 0,0.2 0.1,0.4 0.5,0.4 0.3,0.2 0.1,0 -0.1,-0.1 z m 0.5,-2.1 0,-0.1 -0.2,-0.2 -0.5,-0.2 -0.2,-0.1 -0.2,0.1 0,0.2 0.1,0.1 0.4,0.1 0.4,0.3 0.1,0 0.1,-0.2 z m -2.4,-1.9 -0.2,-0.1 -0.5,0.1 -0.3,0 0.1,0.3 0.6,0.2 0.3,0 0.3,0 0.2,-0.1 -0.1,-0.2 -0.4,-0.2 z m 2.5,-0.5 -0.8,-0.2 -0.6,-0.3 -1,0.1 0.7,1.1 0.8,0.7 0.4,0.2 0,-0.1 0,-0.2 -0.4,-0.5 -0.1,-0.1 0,-0.1 0.1,-0.1 0.2,0 0.3,0.2 0.2,0 0.2,-0.7 z m 1,-0.2 -0.3,-0.2 -0.4,-0.4 0,0.5 0,0.3 0,0.1 0.1,0 0.3,0.1 0.3,-0.4 z
191	507b4ee9-d336-4c5b-be3e-530ee2d0fd51	ff772da3-5cb8-4833-a427-2651adf6fbd6	m 690.3,902.7 -0.1,-0.3 -0.4,-0.2 -0.2,-0.1 0.1,0.2 0.1,0.3 0.1,0.2 0.2,0.1 0.2,-0.2 z m 5.5,-1.3 -0.1,-0.1 -0.2,0 -0.1,0.2 0.2,0.3 0.4,0.1 -0.2,-0.5 z m -12.9,-1.4 -0.1,0.2 -0.4,0.1 0.2,0.3 0.6,0.4 0.4,0 0.1,-0.3 -0.1,-0.6 -0.3,0 -0.4,-0.1 z m 2.8,-2 -0.9,-0.3 -0.4,-0.3 -0.3,0 0.4,0.4 0.1,0.2 0.1,0.2 0.6,0.3 0.6,0.3 0.4,0.3 -0.1,0.1 -0.8,0.3 -0.3,0 -0.2,0.1 0.4,0.2 0.6,-0.1 0.2,-0.1 0.2,0 0.3,0.1 0,0.2 -0.1,0.2 -0.2,0.2 -0.4,0.3 -0.6,0.4 -0.8,0 -0.7,0.7 0.9,0.5 0.7,0.3 0.9,0 0,-0.1 0.2,-0.1 0.3,0 0.1,-0.1 0.2,-0.4 0,-0.6 0.2,0 0.3,0.1 0.7,-0.1 0.3,-0.1 0.6,-0.9 0.4,-0.8 0.2,-0.4 0.3,-0.2 0.1,-0.2 0.1,-0.3 0.3,-0.2 0,-0.3 -0.4,-0.2 -0.3,-0.2 -0.3,0.3 -0.2,-0.1 -0.9,0.3 -0.4,0 -0.3,-0.2 -0.4,-0.1 -0.4,0.1 -0.5,0.5 -0.8,-0.2 z m 0.7,-0.4 0.1,-0.3 -0.1,-0.2 -0.5,-0.2 -0.5,0 0.2,0.5 0.2,0.2 0.6,0 z m 5.9,-0.7 -0.4,0 0.4,0.5 -0.8,0.8 0.2,0.6 0.3,0.4 0.1,0.2 -0.1,0.1 -0.4,0.1 -0.3,0.1 -0.2,0.3 -0.9,0.9 0.2,0.2 -0.3,0.7 0.2,0.3 0.8,0.7 0.8,0.4 0,-0.7 0.4,-0.1 0.4,0.2 0.4,-0.2 -0.9,-1 0.3,0 2.5,0.5 -0.1,-0.4 -0.1,-0.2 -0.3,-0.4 1.5,-0.4 0.5,-0.3 0.2,-0.3 0.6,-0.1 0.8,-0.3 -0.1,-0.1 0.1,-0.3 -0.4,-0.2 -0.5,-0.1 0.1,-0.3 0.5,-0.1 -0.8,-0.7 -0.3,-0.1 -1,0.1 -0.3,0.1 0,0.2 0.1,0.3 0.3,0.3 0.1,0.2 -0.2,-0.1 -1.1,-0.4 -0.2,-0.1 -0.2,-0.4 0.2,-0.1 0.3,0.1 0.1,-0.3 -0.4,-0.3 -0.4,-0.1 -0.9,0.1 -0.8,-0.3 z
192	a61b9876-5aa6-44bc-b055-196872b64e0e	472108f0-b6a2-410c-9885-d4fa3b3412bd	m 213.2,704.9 -0.1,-0.3 -0.2,-0.3 -0.1,0.1 0.1,0.1 0.2,0.3 0,0.2 0.1,-0.1 z m 9.3,-14.7 -0.2,-0.2 -0.4,-0.2 -0.2,-0.1 -0.2,-0.1 -0.1,0.1 0.1,0.1 0.1,0 0.3,0.2 0.3,0.1 0.2,0.1 0,0.1 0.1,-0.1 z m -24.5,-1.1 -0.6,-0.3 0.1,0.2 0.4,0.2 0.2,0.1 -0.1,-0.2 z m 20.5,-0.2 -0.4,-0.5 -0.3,0 0.7,0.6 0,-0.1 z m -21.6,-1 -0.4,-0.4 -0.2,-0.3 -0.3,-0.1 0.1,0.1 0.4,0.4 0.3,0.4 0.2,0.1 -0.1,-0.2 z m -0.3,-2.1 -0.1,-0.1 0,0 0,-0.3 0.2,-0.3 0.6,-0.4 0,-0.1 0,0 -0.2,0.1 -0.4,0.2 -0.2,0.2 -0.1,0.2 -0.1,0.3 0.1,0.2 0.1,0.1 0.2,0 -0.1,-0.1 z m -47.4,-1.1 -0.2,-0.6 -0.3,-0.5 -0.8,-0.1 -0.5,0.2 -0.1,0.2 0.1,0.4 0.5,0.7 0.5,0.1 0.8,-0.1 0.4,0.6 0.2,0.1 0.4,0.1 0.1,-0.3 -0.2,-0.5 -0.9,-0.3 z m -2.9,-0.9 0.1,-0.4 -0.2,-0.1 -0.5,0 0,0.2 0.1,0.2 0.1,0.1 0.3,0.2 0.1,-0.2 z m -9.7,-4.3 0.2,0 -0.4,-0.6 -0.3,-0.2 0,0.1 0,0.7 0.3,0.1 0.2,-0.1 z m 43.9,-1.6 -0.2,0 -0.3,0 -0.1,0 0.5,0.1 0.4,0.2 -0.3,-0.3 z m -0.7,0.1 -0.3,-0.1 -0.3,-0.2 -0.3,0 0.7,0.3 0.2,0 z m -43.8,0.1 0.1,-0.2 -0.1,-0.1 -0.4,-0.2 0.1,0.3 0,0.2 0.2,0.1 0.1,-0.1 z m 32.8,-2 -0.3,-0.4 -0.2,-0.3 -0.2,-0.4 -0.4,-0.5 0.1,0.3 0.1,0.2 0.2,0.2 0.2,0.4 0.1,0.2 0.3,0.4 0.1,0 0,-0.1 z m 16.2,-1.5 0.1,-0.5 -0.2,0 0,0.5 0.1,0 z m -14.4,-1.6 -0.6,-0.6 -0.1,0 0.1,0.2 0.5,0.5 0.1,0.2 0,-0.3 z m 30.8,-33.9 0.1,-0.2 0,-0.2 -0.1,-0.1 -0.3,-0.1 0.1,0.7 0.2,-0.1 z m -2.7,-3.7 -0.1,-0.2 -0.2,0 -0.1,0.1 0,0.5 0.4,-0.4 z m 0.1,-1.6 -0.8,0.5 0.2,0.4 0.4,0.1 0.2,-0.2 0.8,-0.1 0.3,-0.4 -0.3,0.1 -0.8,-0.4 z m -6.1,-1.7 0.2,-0.5 -0.2,-0.1 -0.4,0.2 0,0.2 0.3,0.4 0.1,-0.2 z m 2.6,-3.1 0.3,-0.1 0,-0.1 -0.2,-0.2 -0.3,-0.1 -0.1,0.1 -0.1,0.2 0.1,0.3 0.3,-0.1 z m -2.9,-0.1 0.1,-0.3 0,-0.2 -0.1,-0.2 -0.9,-0.2 -0.1,0.1 0,0.4 0.2,0.5 0.3,0 0.5,-0.1 z
193	84e71b6b-7019-40fe-89a7-1b1678d8a64f	fef2c7ae-f872-4a71-9c87-0d0727258c26	m 681.4,556.2 1.8,-4.7 3.5,-5.8 -0.9,-2.6 -5.8,-5.4 -4.1,-1.5 -1.9,-0.7 -3.1,5.5 0.4,4.4 2.1,3.7 -1,2.7 -0.6,2.9 -1.4,2.8 2.4,1.3 1.8,-1.8 1.2,0.3 0.8,1.8 2.7,-0.5 2.1,-2.4 z
194	9226fefe-1e87-4111-86d8-f9ceb2658277	5f5fad3d-69c4-41b1-bc88-d9b8cff77027	m 887.4,76.3 -26,-0.4 -11.8,0.3 -5,1.3 -11.5,-0.1 -12.7,2.1 -1.6,1.7 6.7,2.1 -6.2,-1.3 -4.5,-0.3 -7,-1.4 -10.6,2.1 -2.7,-1.2 -10.4,0 -10.9,0.6 -8.9,1 -0.2,1.8 -5.3,0.5 -14.6,2.9 -4.6,1.7 8.1,1.5 -2.8,1.6 -14.9,2.2 -15.5,2.2 -2.2,1.7 6.4,2 14.5,1.2 -7.5,0.2 -10.9,1.5 3.8,3.1 3,1.5 9.4,-0.3 10.1,-0.2 7.6,0.3 8,2.9 -1.4,2.1 3.6,1.9 1.4,5.3 1,3.6 1.4,1.9 -7,4.8 2.6,1.3 4.4,-0.8 2.6,1.8 5.3,3.4 -7.5,-1.4 -3.8,0 -3,2.8 -1.5,3.6 4.2,1.8 4,-0.8 2.6,-0.8 5.5,-1.9 -2.8,4.2 -2.6,2.3 -7.1,2 -7,6.3 2,2 -3.4,4 3.7,5.2 -1.5,5 0.7,3.7 4.8,7.1 0.8,5.6 3.1,3.2 8.9,0 5,4.7 6.5,-0.3 4.1,-5.7 3.5,-4.8 -0.3,-4.4 8.6,-4.6 3.3,-3.7 1.4,-3.9 4.7,-3.5 6.5,-1.3 6.1,-1.4 3,-0.2 10.2,-3.9 7.4,-5.7 4.8,-2.1 4.6,-0.1 12.5,-1.8 12.1,-4.3 11.9,-4.6 -5.5,-0.3 -10.6,-0.2 5.3,-2.8 -0.5,-3.6 4.2,3 2.7,2.1 7.3,-1 -0.6,-4.3 -4.5,-3.1 -5,-1.3 2.4,-1.4 7.2,2.1 0.5,-2.3 -4.1,-3.4 5.4,0 5.6,-0.8 1.7,-1.8 -4,-2.1 8.6,-0.3 -4,-4.3 4.1,-0.5 0.1,-4.2 -6.2,-2.5 6.4,-1.6 5.8,-0.1 -3.6,-3.2 1.1,-5.1 3.6,-2.9 4.9,-3.2 -8,-0.2 11.3,-0.7 2.2,-1 14.6,-2.9 -1.6,-1.7 -10,-0.8 -16.9,1.5 -9.2,1.5 4.5,-2.3 -2.3,-1.4 -7,1.2 -9.7,-1.4 -12.1,0.5 -1.4,-0.7 18.3,-0.4 12.9,-0.2 6.6,-1.4 -19.7,-2.9 z
195	4e85fdb2-9801-41d7-b71f-a90480044a65	ba5a63e1-7feb-4d40-ae2f-d0a9f2123c0c	m 636.4,471.1 0.2,-0.2 0,-0.3 -0.2,-0.3 -0.2,0.1 -0.2,0.3 0,0.3 0.1,0.1 0.3,0 z m -1.9,-0.8 0.2,-0.2 0,-1.2 0.1,-0.3 -0.2,-0.1 -0.2,-0.2 -0.6,-0.2 -0.1,0.1 -0.2,0.3 0.1,1.5 0.2,0.5 0.2,0.1 0.5,-0.3 z m 1.6,-1.4 0.8,-0.2 -0.9,-0.6 -0.2,-0.4 0,-0.3 -0.4,-0.3 -0.2,0.2 -0.1,0.3 0.1,0.5 -0.3,0.4 0.1,0.4 0.4,0.1 0.7,-0.1 z
196	09bf9423-644f-4123-a7bb-f09f05566ed8	ae7c2b6b-a504-4e11-a52c-97175217c0a7	m 1604.9,430.9 0,-0.2 0,-0.2 -0.4,-0.2 -0.3,0 0.1,0.2 0.4,0.5 0.2,-0.1 z m -1.3,0 -0.1,-0.5 0.2,-0.3 -0.9,0.3 -0.1,0.3 0,0.1 0.2,0.1 0.7,0 z m 1.6,-1.2 -0.1,-0.3 -0.2,-0.1 -0.1,-0.3 -0.1,-0.2 0,0 -0.3,-0.1 -0.2,-0.1 -0.4,0 -0.1,0.1 -0.2,0 -0.2,0.2 0,0 0,0.2 -0.5,0.4 0,0.2 0.3,0.2 0.5,-0.1 0.6,0.2 0.8,0.3 0,-0.2 0,-0.3 0.2,-0.1 z
197	94a5446c-3195-4860-bcb1-d461aeb369ae	8510166b-62a4-475f-8afe-891fe1cb22a0	m 1024.4,273.6 0,-0.2 0.1,-0.2 -0.1,-0.1 -0.1,-0.2 -0.1,-0.1 0,-0.2 -0.1,-0.1 0,-0.2 -0.1,-0.1 -0.2,0.6 0,0.5 0.1,0.2 0.1,0 0.4,0.1 z
198	01f8a12f-04a2-41b5-ba73-e77ffb76e025	07546102-9696-4e5b-80fb-c435267230aa	m 638,479.9 -0.2,-0.7 -0.1,-0.2 -0.2,-0.3 0.1,-0.3 0,-0.1 -0.2,0 -0.3,-0.5 -0.6,-0.3 -0.3,0 -0.2,0.2 0,0.3 0.3,0.9 0.2,0.2 0.5,0.2 -0.4,0.4 0,0.1 0.1,0.3 0.9,0 0.2,0.3 0.1,-0.1 0.1,-0.4 z
199	dbf9f061-0932-440f-88c3-78f015d979f1	4f7bf3fc-1cdd-42ea-acc1-2325444ea405	m 1228.7,654.7 0,-0.3 0.2,-0.5 0,-0.1 0.1,-0.5 -0.3,-0.3 -0.2,0 -0.2,-0.3 -0.3,0.3 0.3,0.5 -0.1,0.3 -0.1,0.4 0.1,0.4 0.2,0.2 0.3,-0.1 z
200	9b20f32a-f406-4244-85ae-6592c78e30b0	adc6de52-b3d9-4448-a7d6-39622cf3261f	m 631.8,465.7 -0.1,-0.5 -0.1,0 -0.2,0.4 0,0.3 0.3,0.1 0.1,-0.3 z
201	68b0a56b-e71b-440b-b1a3-692f12ce30f7	17b783e7-ad5c-473c-8787-aab9c9397fed	m 1897.3,716.1 0,-0.3 -0.4,-0.2 -0.2,0.5 0,0.1 0.2,0.1 0.2,0 0.2,-0.2 z m 4.6,-7.6 -0.1,-0.1 0,-0.3 0.1,-0.2 -0.4,0.2 -0.6,0.2 0.1,0.8 -0.1,0.4 0.3,0.1 0.1,0.3 0.2,0 0.7,-0.2 0.3,-1.1 -0.4,0 -0.2,-0.1 z m -3,-1.7 0.3,-0.5 0.1,-0.2 -0.2,-0.7 -0.3,-0.3 0.3,-1 -0.1,-0.2 -0.4,-0.2 -0.9,0.3 -0.1,0.2 0.5,0.1 0.2,0.2 -0.5,0.7 -0.5,0.1 0.1,0.5 0.2,0.4 0.7,0.2 0.3,0.4 0.3,0 z m -3.9,-2.9 0.3,-0.3 0.3,-0.4 -0.1,-0.1 0,-0.3 0.2,-0.4 0.3,-0.1 -0.2,-0.2 -0.2,-0.1 0,0.3 -0.3,0.7 -0.1,0.3 -0.5,0.6 0.3,0 z m -12.3,-2.9 -0.6,-0.7 -0.1,0.2 -0.1,0.4 0,0.3 0.3,0.2 0.1,0.2 -0.1,0.5 0,0.4 0.6,0.9 0.1,0.7 0.3,0.6 0.5,0.5 0.4,0.5 0.8,1.4 0.2,0.5 0.4,0.3 1,1.2 0.4,0.4 0.4,0.2 0.9,0.7 0.6,0.3 0.3,0.5 0.6,0.3 0.8,0.4 0.1,0.2 0,0.3 0.1,0.3 0.5,0.4 0.6,0.3 0.1,0.2 0.1,0.2 0.3,-0.1 0.3,0.1 0.9,0.7 0.4,-0.1 0.3,0 0.5,-0.2 0.3,-0.4 -0.1,-1.1 -0.5,-0.5 -0.7,-0.4 -0.4,-0.5 -0.4,-0.5 -0.8,-1 -1.1,-1 -0.5,-0.2 -0.3,-0.4 -0.3,-0.1 -0.2,-0.3 -0.5,-0.3 -0.3,-0.6 -0.6,-0.6 -0.1,-0.3 0.1,-0.3 -0.1,-0.3 -0.4,-0.3 -0.2,-0.5 -0.2,-0.3 -0.4,-0.2 -0.7,-0.4 -1.6,-1.9 -0.7,-0.6 -0.7,0.2 -0.6,-0.4 z m -22,-6 0.2,-0.4 0.1,-0.8 -0.2,0.4 -0.2,1 0.1,-0.2 z
202	03299a99-70c7-4c91-bcdc-79065fb5ca7c	6ed0c70e-c6ab-4148-aae3-fbf474467390	m 1166.9,366.1 -2,-0.9 -0.7,4.3 1.4,0.7 -1.2,0.8 -0.1,1.7 2.4,-0.8 0.6,-1.9 -0.4,-3.9 z
203	483edfd7-9882-43d8-975c-5d84f16028c3	6fda58dd-3eb4-49f9-8f07-8e0c4562675b	m 274.2,727.4 0,-0.2 -0.1,-0.2 -0.2,-0.1 -0.1,0.1 0.1,0.2 0.2,0.2 0.1,0.1 0,-0.1 z
204	6882eb90-dc65-402c-b7a3-a1fa5e26baf0	f18ec7fe-184e-4e4b-9ac5-14c5bfbf1fb7	m 600.8,457.3 0,-0.1 0,0 0.1,0 0,-0.1 0.1,-0.1 0,0 0,-0.1 -0.1,0 0,0 -0.3,0 -0.1,0 0,0.1 0,0.1 0.2,0.1 0,0 0,0.1 0.1,0 0,0 z m 13.6,-0.3 0.7,-0.2 0,-0.1 -0.4,-0.1 -0.6,0 -0.5,0.2 0.1,0.2 0.2,0 0.5,0 z m -3.7,-2.2 -0.1,-0.2 -0.2,0 -3.5,-0.1 -1.3,-0.2 -0.3,0.1 -0.3,0.1 -0.1,0.4 -0.2,0.2 -0.3,0.2 0.1,0.3 0.1,0.2 0.2,0.4 -0.1,0.5 -0.2,1 0.3,0.2 0.7,-0.1 0.3,0.1 0.3,0.1 0.4,-0.1 0.4,-0.2 0.9,0.1 0.5,-0.1 0.6,0.3 0.4,-0.1 0.2,0.1 0.3,0 0.6,0 0.9,-0.2 0.8,-0.5 0.3,-0.5 0.4,-0.3 0.6,-0.4 0,-0.9 -0.7,-0.1 -0.6,-0.3 -1.1,-0.1 -0.1,0 0.1,0.2 -0.1,0 -0.2,-0.1 z
205	5168324c-f469-4333-a79a-5da51ddf5fe7	e600ef6e-e2fa-42cd-a54e-60cd0a48c98f	m 1284,707.9 0.2,-0.4 0.1,-0.8 -0.4,-0.8 -0.4,-0.7 -0.4,-0.2 -0.8,-0.1 -0.7,0.3 -0.4,0.6 -0.2,0.3 0.4,1.1 0.2,0.3 1.1,0.6 0.5,0 0.8,-0.2 z
206	3e11a8a4-86a4-46e9-b9ba-9ecefc839a17	f873ab5f-e175-4a90-9e0e-1efe1d0880ff	m 627.1,457.2 0,0 0.2,0.2 0.3,0.1 0.1,-0.1 0,-0.2 -0.6,0 z
207	ca548335-5a7e-4124-8650-b5cab8915879	188c245e-16ba-4c8b-a894-dcfd252e6735	m 1150.5,736.6 -2.7,-1.2 -1.6,0.5 -0.7,1.8 -1.6,2.4 -0.1,2.2 3,3.5 3.3,-0.7 1.3,-2.8 -0.3,-2.8 -0.6,-2.9 z
208	997b64d5-ddea-4a91-87f3-3487c89bbdc9	1f6e1df0-b5ff-4eb0-89b2-0bd06cf52883	m 1642.3,427.2 1.2,-10.2 0.1,-3.9 -2.9,-1.9 -3.3,4.8 -1.9,6.3 1.5,4.7 4,5.4 1.3,-5.2 z
209	9162057c-1693-436b-8293-90f8cbc6489b	29c528d3-2b84-4b14-adec-78d0f7a06fc1	m 578.7,433.1 -0.1,0.4 0,0.2 0.2,0.1 0.6,-0.1 0.1,-0.1 0.2,-0.1 0,-0.1 -0.4,0.1 -0.6,-0.4 z m 3.6,0.6 0.2,-0.2 -0.2,-0.2 -0.7,-0.2 -0.2,0.1 0,0.3 0.6,0 0.3,0.3 0,-0.1 z m -1.1,-0.5 -0.1,-0.1 -0.1,-0.6 -0.5,0 0,0.2 0.1,0.2 0.1,0 0.1,0.2 0.3,0.2 0.1,-0.1 z
210	776f9472-b40b-4489-9852-c5692ca3b269	cd560671-9a56-4d59-a90b-3fc5876c54a8	m 617.9,458.9 -0.7,0.2 -0.1,0.4 1.1,0 0.7,-0.3 -0.6,0 -0.4,-0.3 z m 0.9,-3.5 -0.5,-0.1 -0.2,0.2 0,0 0.3,0.1 0.4,-0.2 z m -1.1,0.1 -0.2,-0.2 -0.3,-0.1 -0.4,0.1 0.5,0.3 0.4,-0.1 z
211	563bc0bf-4a08-40d5-b081-bd8f816331f4	7c843d31-a3b7-4fd6-854d-a41fd456ab79	m 929.6,396.2 -0.8,0 0,0 0.1,3.4 -3.4,0.2 -1.8,1.5 -2.5,0 -1.9,-0.9 -4.6,0.7 -1.9,5 -1.7,0.4 -2.8,8.1 -7.8,6.8 -2,8.8 -2.3,2.9 -0.7,2.3 -12.4,0.5 -0.1,0 -0.3,2.7 1.2,-2.2 21.6,0.1 -0.9,-9.2 1.4,-3.3 5.2,-0.5 0.2,-16.3 17.9,0.3 0.2,-9.7 0.1,-1.2 0,-0.4 z
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

SELECT pg_catalog.setval('public.demonym_id_seq', 45, true);


--
-- Name: passport_travel_requirements_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brook
--

SELECT pg_catalog.setval('public.passport_travel_requirements_id_seq', 12, true);


--
-- Name: svg_path_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brook
--

SELECT pg_catalog.setval('public.svg_path_id_seq', 211, true);


--
-- Name: territory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brook
--

SELECT pg_catalog.setval('public.territory_id_seq', 29, true);


--
-- Name: territory_label_id_seq; Type: SEQUENCE SET; Schema: public; Owner: brook
--

SELECT pg_catalog.setval('public.territory_label_id_seq', 49, true);


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

SELECT pg_catalog.setval('public.visa_types_id_seq', 50, true);


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
-- Name: passport_travel_requirements passport_travel_requirements_pkey; Type: CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.passport_travel_requirements
    ADD CONSTRAINT passport_travel_requirements_pkey PRIMARY KEY (id);


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
-- Name: passport_travel_requirements visa_type; Type: FK CONSTRAINT; Schema: public; Owner: brook
--

ALTER TABLE ONLY public.passport_travel_requirements
    ADD CONSTRAINT visa_type FOREIGN KEY (visa_type) REFERENCES public.visa_type(name) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

