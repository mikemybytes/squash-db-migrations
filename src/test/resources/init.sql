-- Generated with <3 using Testcontainers at 2023-01-31T19:46:03.198831

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1 (Debian 15.1-1.pgdg110+1)
-- Dumped by pg_dump version 15.1 (Debian 15.1-1.pgdg110+1)

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
-- Name: customer_order; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.customer_order (
    id integer NOT NULL,
    customer character varying(255)
);


ALTER TABLE public.customer_order OWNER TO test;

--
-- Name: customer_order_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

ALTER TABLE public.customer_order ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.customer_order_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: customer_order_item; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.customer_order_item (
    id integer NOT NULL,
    order_id integer NOT NULL,
    amount_minor integer,
    currency character varying(3),
    quantity integer DEFAULT 1 NOT NULL,
    comment character varying(1024),
    order_item_id integer NOT NULL
);


ALTER TABLE public.customer_order_item OWNER TO test;

--
-- Name: customer_order_item_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

ALTER TABLE public.customer_order_item ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.customer_order_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE public.flyway_schema_history OWNER TO test;

--
-- Name: order_item; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.order_item (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    description character varying(2048),
    removed boolean DEFAULT false NOT NULL
);


ALTER TABLE public.order_item OWNER TO test;

--
-- Name: order_item_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

ALTER TABLE public.order_item ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.order_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: customer_order; Type: TABLE DATA; Schema: public; Owner: test
--



--
-- Data for Name: customer_order_item; Type: TABLE DATA; Schema: public; Owner: test
--



--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.flyway_schema_history VALUES (1, '001', 'initial model', 'SQL', 'V001__initial_model.sql', 1485106706, 'test', '2023-01-31 19:46:02.712496', 7, true);
INSERT INTO public.flyway_schema_history VALUES (2, '002', 'add quantity', 'SQL', 'V002__add_quantity.sql', -1517708285, 'test', '2023-01-31 19:46:02.733131', 4, true);
INSERT INTO public.flyway_schema_history VALUES (3, '003', 'add order item comment', 'SQL', 'V003__add_order_item_comment.sql', -1033864838, 'test', '2023-01-31 19:46:02.752145', 3, true);
INSERT INTO public.flyway_schema_history VALUES (4, '004', 'separate order items', 'SQL', 'V004__separate_order_items.sql', -365207902, 'test', '2023-01-31 19:46:02.765606', 9, true);
INSERT INTO public.flyway_schema_history VALUES (5, '005', 'predefine order items', 'SQL', 'V005__predefine_order_items.sql', -117992296, 'test', '2023-01-31 19:46:02.78403', 7, true);
INSERT INTO public.flyway_schema_history VALUES (6, '006', 'add order item removed flag', 'SQL', 'V006__add_order_item_removed_flag.sql', 199715604, 'test', '2023-01-31 19:46:02.799189', 5, true);
INSERT INTO public.flyway_schema_history VALUES (7, '007', 'add more order items', 'SQL', 'V007__add_more_order_items.sql', -291066168, 'test', '2023-01-31 19:46:02.810967', 5, true);


--
-- Data for Name: order_item; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.order_item OVERRIDING SYSTEM VALUE VALUES (1, 'Item 1', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', false);
INSERT INTO public.order_item OVERRIDING SYSTEM VALUE VALUES (2, 'Item 2', 'Maecenas ullamcorper eget odio eu aliquet.', false);
INSERT INTO public.order_item OVERRIDING SYSTEM VALUE VALUES (5, 'Item 5', 'Pellentesque a mauris elit.', false);
INSERT INTO public.order_item OVERRIDING SYSTEM VALUE VALUES (7, 'Item 7', 'Nullam nec enim et nulla dapibus sodales vitae in massa.', false);
INSERT INTO public.order_item OVERRIDING SYSTEM VALUE VALUES (3, 'Item 3', 'In ut facilisis ipsum, condimentum maximus diam.', true);
INSERT INTO public.order_item OVERRIDING SYSTEM VALUE VALUES (4, 'Item 4', 'Nulla ullamcorper convallis maximus. Quisque vel dictum metus.', true);
INSERT INTO public.order_item OVERRIDING SYSTEM VALUE VALUES (6, 'Item 6', 'Praesent eget metus sit amet arcu egestas auctor eu in tortor', true);
INSERT INTO public.order_item OVERRIDING SYSTEM VALUE VALUES (8, 'Item 8', 'Pellentesque consectetur ullamcorper accumsan.', false);
INSERT INTO public.order_item OVERRIDING SYSTEM VALUE VALUES (9, 'Item 9', 'Maecenas quis condimentum lacus.', false);
INSERT INTO public.order_item OVERRIDING SYSTEM VALUE VALUES (10, 'Item 10', 'Suspendisse et lacus quis massa sollicitudin posuere ut at metus.', false);
INSERT INTO public.order_item OVERRIDING SYSTEM VALUE VALUES (11, 'Item 11', 'Etiam vel nibh sed mi faucibus facilisis.', false);
INSERT INTO public.order_item OVERRIDING SYSTEM VALUE VALUES (12, 'Item 12', 'Vivamus justo augue, iaculis sit amet porta nec, eleifend vel arcu.', false);


--
-- Name: customer_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.customer_order_id_seq', 1, false);


--
-- Name: customer_order_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.customer_order_item_id_seq', 1, false);


--
-- Name: order_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.order_item_id_seq', 12, true);


--
-- Name: customer_order_item customer_order_item_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.customer_order_item
    ADD CONSTRAINT customer_order_item_pkey PRIMARY KEY (id);


--
-- Name: customer_order customer_order_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.customer_order
    ADD CONSTRAINT customer_order_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: order_item order_item_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT order_item_pkey PRIMARY KEY (id);


--
-- Name: order_item qu_name; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.order_item
    ADD CONSTRAINT qu_name UNIQUE (name);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: test
--

CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);


--
-- Name: customer_order_item customer_order_item_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.customer_order_item
    ADD CONSTRAINT customer_order_item_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.customer_order(id);


--
-- Name: customer_order_item customer_order_item_order_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.customer_order_item
    ADD CONSTRAINT customer_order_item_order_item_id_fkey FOREIGN KEY (order_item_id) REFERENCES public.order_item(id);


--
-- PostgreSQL database dump complete
--

