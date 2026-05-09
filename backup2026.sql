--
-- PostgreSQL database dump
--

-- Dumped from database version 10.23 (Ubuntu 10.23-0ubuntu0.18.04.2)
-- Dumped by pg_dump version 14.8 (Ubuntu 14.8-1.pgdg18.04+1)

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

--
-- Name: app_update; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.app_update (
    id bigint NOT NULL,
    date_added timestamp with time zone NOT NULL,
    android_version character varying(16) NOT NULL,
    android_force_upgrade boolean NOT NULL,
    android_recommended_upgrade boolean NOT NULL,
    ios_version character varying(16) NOT NULL,
    ios_force_upgrade boolean NOT NULL,
    ios_recommended_upgrade boolean NOT NULL
);


ALTER TABLE public.app_update OWNER TO nexsme_live;

--
-- Name: app_update_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.app_update_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app_update_id_seq OWNER TO nexsme_live;

--
-- Name: app_update_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.app_update_id_seq OWNED BY public.app_update.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO nexsme_live;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO nexsme_live;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO nexsme_live;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO nexsme_live;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO nexsme_live;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO nexsme_live;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO nexsme_live;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO nexsme_live;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO nexsme_live;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO nexsme_live;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO nexsme_live;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO nexsme_live;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: customer_bank_account; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.customer_bank_account (
    id uuid NOT NULL,
    date_added timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    bank_name character varying(128),
    account_number character varying(128) NOT NULL,
    account_holder character varying(128),
    swift_code character varying(128),
    branch character varying(128),
    iban character varying(128) NOT NULL,
    customer_id uuid NOT NULL
);


ALTER TABLE public.customer_bank_account OWNER TO nexsme_live;

--
-- Name: customers_customer; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.customers_customer (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    name character varying(50) NOT NULL,
    phone character varying(10) NOT NULL,
    email character varying(128),
    gst_number character varying(128),
    country character varying(128),
    state character varying(128),
    house character varying(128),
    building character varying(128),
    street character varying(128),
    opening_type character varying(128),
    opening_balance numeric(15,2) NOT NULL,
    current_balance numeric(15,2) NOT NULL,
    current_privilege_points numeric(15,0) NOT NULL,
    privilege_points numeric(15,0) NOT NULL,
    image character varying(100),
    is_web_registered boolean NOT NULL,
    creator_id integer NOT NULL,
    updater_id integer,
    user_id integer,
    CONSTRAINT customers_customer_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.customers_customer OWNER TO nexsme_live;

--
-- Name: customers_customeraddress; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.customers_customeraddress (
    id uuid NOT NULL,
    date_added timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    address_type integer NOT NULL,
    name character varying(50) NOT NULL,
    phone character varying(10) NOT NULL,
    email character varying(254),
    house_name character varying(50) NOT NULL,
    street character varying(128) NOT NULL,
    city character varying(50),
    landmark character varying(256),
    state character varying(128),
    is_default boolean NOT NULL,
    customer_id uuid NOT NULL,
    location_id uuid NOT NULL,
    zone_id bigint NOT NULL
);


ALTER TABLE public.customers_customeraddress OWNER TO nexsme_live;

--
-- Name: customers_userotpdata; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.customers_userotpdata (
    id bigint NOT NULL,
    name character varying(256) NOT NULL,
    phone character varying(10) NOT NULL,
    otp integer NOT NULL,
    attempts integer NOT NULL,
    resend_otp_index boolean NOT NULL,
    is_deleted boolean NOT NULL,
    password character varying(256),
    CONSTRAINT customers_userotpdata_attempts_check CHECK ((attempts >= 0)),
    CONSTRAINT customers_userotpdata_otp_check CHECK ((otp >= 0))
);


ALTER TABLE public.customers_userotpdata OWNER TO nexsme_live;

--
-- Name: customers_userotpdata_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.customers_userotpdata_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customers_userotpdata_id_seq OWNER TO nexsme_live;

--
-- Name: customers_userotpdata_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.customers_userotpdata_id_seq OWNED BY public.customers_userotpdata.id;


--
-- Name: deal_of_day; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.deal_of_day (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    offer_percentage numeric(15,2) NOT NULL,
    deal_date date NOT NULL,
    creator_id integer NOT NULL,
    product_variant_id uuid,
    updater_id integer,
    warehouse_id uuid,
    CONSTRAINT deal_of_day_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.deal_of_day OWNER TO nexsme_live;

--
-- Name: delivery_agent_collectedpaymentregister; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.delivery_agent_collectedpaymentregister (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    collected_payments text[] NOT NULL,
    collected_amount numeric(15,2) NOT NULL,
    is_approved boolean NOT NULL,
    is_declined boolean NOT NULL,
    declined_reason text,
    payment_medium character varying(15) NOT NULL,
    image character varying(100),
    creator_id integer NOT NULL,
    delivery_agent_id uuid NOT NULL,
    updater_id integer,
    CONSTRAINT delivery_agent_collectedpaymentregister_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.delivery_agent_collectedpaymentregister OWNER TO nexsme_live;

--
-- Name: delivery_agent_collectpayment; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.delivery_agent_collectpayment (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    name character varying(128) NOT NULL,
    collected_amount numeric(15,2) NOT NULL,
    is_transferred boolean NOT NULL,
    creator_id integer NOT NULL,
    delivery_agent_id uuid NOT NULL,
    order_id uuid NOT NULL,
    updater_id integer,
    CONSTRAINT delivery_agent_collectpayment_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.delivery_agent_collectpayment OWNER TO nexsme_live;

--
-- Name: delivery_agent_delivery_agent; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.delivery_agent_delivery_agent (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    name character varying(128) NOT NULL,
    phone1 character varying(10) NOT NULL,
    phone2 character varying(10),
    email character varying(254),
    password character varying(256) NOT NULL,
    active_time timestamp with time zone,
    is_active boolean,
    image character varying(100) NOT NULL,
    id_proof character varying(100) NOT NULL,
    license character varying(100) NOT NULL,
    license_expiry_date date NOT NULL,
    company_id character varying(100) NOT NULL,
    company_id_expiry_date date NOT NULL,
    creator_id integer NOT NULL,
    updater_id integer,
    user_id integer,
    warehouse_id uuid,
    CONSTRAINT delivery_agent_delivery_agent_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.delivery_agent_delivery_agent OWNER TO nexsme_live;

--
-- Name: delivery_agent_deliveryrating; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.delivery_agent_deliveryrating (
    id uuid NOT NULL,
    date_added timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    rating integer NOT NULL,
    customer_id uuid NOT NULL,
    delivery_agent_id uuid NOT NULL,
    order_id uuid NOT NULL
);


ALTER TABLE public.delivery_agent_deliveryrating OWNER TO nexsme_live;

--
-- Name: delivery_agent_travel; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.delivery_agent_travel (
    id uuid NOT NULL,
    date_added timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    origin_latitude text,
    origin_longitude text,
    pickup_latitude text,
    pickup_longitude text,
    delivery_latitude text,
    delivery_longitude text,
    pickup_distance numeric(15,2) NOT NULL,
    delivery_distance numeric(15,2) NOT NULL,
    pickup_distance_text character varying(125),
    delivery_distance_text character varying(125),
    delivery_agent_id uuid NOT NULL,
    delivery_trip_id uuid,
    order_id uuid NOT NULL
);


ALTER TABLE public.delivery_agent_travel OWNER TO nexsme_live;

--
-- Name: delivery_agent_trip; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.delivery_agent_trip (
    id uuid NOT NULL,
    date_added timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    title character varying(128) NOT NULL,
    start_time timestamp with time zone NOT NULL,
    end_time timestamp with time zone,
    distance_covered bigint,
    distance_covered_text character varying(128),
    is_active boolean NOT NULL,
    delivery_agent_id uuid NOT NULL,
    CONSTRAINT delivery_agent_trip_distance_covered_check CHECK ((distance_covered >= 0))
);


ALTER TABLE public.delivery_agent_trip OWNER TO nexsme_live;

--
-- Name: delivery_app_update; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.delivery_app_update (
    id bigint NOT NULL,
    date_added timestamp with time zone NOT NULL,
    android_version character varying(16) NOT NULL,
    android_force_upgrade boolean NOT NULL,
    android_recommended_upgrade boolean NOT NULL,
    ios_version character varying(16) NOT NULL,
    ios_force_upgrade boolean NOT NULL,
    ios_recommended_upgrade boolean NOT NULL
);


ALTER TABLE public.delivery_app_update OWNER TO nexsme_live;

--
-- Name: delivery_app_update_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.delivery_app_update_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.delivery_app_update_id_seq OWNER TO nexsme_live;

--
-- Name: delivery_app_update_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.delivery_app_update_id_seq OWNED BY public.delivery_app_update.id;


--
-- Name: designation; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.designation (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    name character varying(128) NOT NULL,
    creator_id integer NOT NULL,
    updater_id integer,
    CONSTRAINT designation_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.designation OWNER TO nexsme_live;

--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO nexsme_live;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO nexsme_live;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO nexsme_live;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO nexsme_live;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO nexsme_live;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO nexsme_live;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO nexsme_live;

--
-- Name: fcm_django_fcmdevice; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.fcm_django_fcmdevice (
    id integer NOT NULL,
    name character varying(255),
    active boolean NOT NULL,
    date_created timestamp with time zone,
    device_id character varying(255),
    registration_id text NOT NULL,
    type character varying(10) NOT NULL,
    user_id integer
);


ALTER TABLE public.fcm_django_fcmdevice OWNER TO nexsme_live;

--
-- Name: fcm_django_fcmdevice_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.fcm_django_fcmdevice_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fcm_django_fcmdevice_id_seq OWNER TO nexsme_live;

--
-- Name: fcm_django_fcmdevice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.fcm_django_fcmdevice_id_seq OWNED BY public.fcm_django_fcmdevice.id;


--
-- Name: finance_account_group; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.finance_account_group (
    id bigint NOT NULL,
    date_added timestamp with time zone,
    date_updated timestamp with time zone,
    is_deleted boolean NOT NULL,
    group_type integer NOT NULL,
    name character varying(128) NOT NULL,
    code character varying(128),
    deleted_reason character varying(128),
    creator_id integer,
    updater_id integer
);


ALTER TABLE public.finance_account_group OWNER TO nexsme_live;

--
-- Name: finance_account_group_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.finance_account_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.finance_account_group_id_seq OWNER TO nexsme_live;

--
-- Name: finance_account_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.finance_account_group_id_seq OWNED BY public.finance_account_group.id;


--
-- Name: finance_account_head; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.finance_account_head (
    id bigint NOT NULL,
    date_added timestamp with time zone,
    date_updated timestamp with time zone,
    is_deleted boolean NOT NULL,
    name character varying(128) NOT NULL,
    code character varying(128),
    deleted_reason character varying(128),
    account_group_id bigint NOT NULL,
    bank_account_id uuid,
    creator_id integer,
    updater_id integer
);


ALTER TABLE public.finance_account_head OWNER TO nexsme_live;

--
-- Name: finance_account_head_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.finance_account_head_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.finance_account_head_id_seq OWNER TO nexsme_live;

--
-- Name: finance_account_head_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.finance_account_head_id_seq OWNED BY public.finance_account_head.id;


--
-- Name: finance_account_head_opening; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.finance_account_head_opening (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    amount_type character varying(16),
    amount numeric(15,2) NOT NULL,
    account_head_id bigint NOT NULL,
    creator_id integer NOT NULL,
    financial_year_id uuid,
    updater_id integer,
    warehouse_id uuid NOT NULL,
    CONSTRAINT finance_account_head_opening_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.finance_account_head_opening OWNER TO nexsme_live;

--
-- Name: finance_bank_account; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.finance_bank_account (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    bank_name character varying(128) NOT NULL,
    account_number character varying(128) NOT NULL,
    account_holder character varying(128) NOT NULL,
    ifsc_code character varying(128) NOT NULL,
    branch character varying(128) NOT NULL,
    account_type character varying(128) NOT NULL,
    opening_balance_type character varying(128) NOT NULL,
    opening_balance numeric(15,2) NOT NULL,
    creator_id integer NOT NULL,
    updater_id integer,
    warehouse_id uuid NOT NULL,
    CONSTRAINT finance_bank_account_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.finance_bank_account OWNER TO nexsme_live;

--
-- Name: finance_credit_voucher; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.finance_credit_voucher (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    voucher_date timestamp with time zone,
    voucher_number integer NOT NULL,
    title character varying(128) NOT NULL,
    description character varying(128),
    amount numeric(15,2) NOT NULL,
    amount_type integer NOT NULL,
    transfer_type integer NOT NULL,
    is_system_generated boolean NOT NULL,
    cheque_number integer,
    cheque_date date,
    draft_number integer,
    draft_date date,
    transfer_number integer,
    transfer_date date,
    cheque_status integer,
    cheque_status_date date,
    bank_id uuid,
    creator_id integer NOT NULL,
    customer_id uuid,
    financial_year_id uuid,
    sale_return_id uuid NOT NULL,
    updater_id integer,
    warehouse_id uuid NOT NULL,
    CONSTRAINT finance_credit_voucher_auto_id_check CHECK ((auto_id >= 0)),
    CONSTRAINT finance_credit_voucher_cheque_number_check CHECK ((cheque_number >= 0)),
    CONSTRAINT finance_credit_voucher_draft_number_check CHECK ((draft_number >= 0)),
    CONSTRAINT finance_credit_voucher_transfer_number_check CHECK ((transfer_number >= 0)),
    CONSTRAINT finance_credit_voucher_voucher_number_check CHECK ((voucher_number >= 0))
);


ALTER TABLE public.finance_credit_voucher OWNER TO nexsme_live;

--
-- Name: finance_debit_voucher; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.finance_debit_voucher (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    voucher_date timestamp with time zone,
    voucher_number integer NOT NULL,
    title character varying(128) NOT NULL,
    description character varying(128),
    amount numeric(15,2) NOT NULL,
    amount_type integer NOT NULL,
    transfer_type integer NOT NULL,
    is_system_generated boolean NOT NULL,
    cheque_number integer,
    cheque_date date,
    cheque_status integer,
    cheque_status_date date,
    draft_number integer,
    draft_date date,
    transfer_number integer,
    transfer_date date,
    bank_id uuid,
    creator_id integer NOT NULL,
    financial_year_id uuid,
    purchase_return_id uuid NOT NULL,
    supplier_id uuid,
    updater_id integer,
    warehouse_id uuid NOT NULL,
    CONSTRAINT finance_debit_voucher_auto_id_check CHECK ((auto_id >= 0)),
    CONSTRAINT finance_debit_voucher_cheque_number_check CHECK ((cheque_number >= 0)),
    CONSTRAINT finance_debit_voucher_draft_number_check CHECK ((draft_number >= 0)),
    CONSTRAINT finance_debit_voucher_transfer_number_check CHECK ((transfer_number >= 0)),
    CONSTRAINT finance_debit_voucher_voucher_number_check CHECK ((voucher_number >= 0))
);


ALTER TABLE public.finance_debit_voucher OWNER TO nexsme_live;

--
-- Name: finance_financial_year; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.finance_financial_year (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    deleted_reason character varying(128),
    start_date timestamp with time zone NOT NULL,
    end_date timestamp with time zone NOT NULL,
    is_active boolean NOT NULL,
    is_deleted boolean NOT NULL,
    creator_id integer NOT NULL,
    updater_id integer,
    CONSTRAINT finance_financial_year_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.finance_financial_year OWNER TO nexsme_live;

--
-- Name: finance_journal_voucher; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.finance_journal_voucher (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    voucher_number integer NOT NULL,
    voucher_date timestamp with time zone,
    title character varying(128) NOT NULL,
    description character varying(128),
    sub_ledger character varying(128),
    debit_amount numeric(15,2) NOT NULL,
    credit_amount numeric(15,2) NOT NULL,
    creator_id integer NOT NULL,
    financial_year_id uuid NOT NULL,
    updater_id integer,
    CONSTRAINT finance_journal_voucher_auto_id_check CHECK ((auto_id >= 0)),
    CONSTRAINT finance_journal_voucher_voucher_number_check CHECK ((voucher_number >= 0))
);


ALTER TABLE public.finance_journal_voucher OWNER TO nexsme_live;

--
-- Name: finance_journal_voucher_item; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.finance_journal_voucher_item (
    id uuid NOT NULL,
    is_deleted boolean NOT NULL,
    sub_ledger character varying(128),
    amount numeric(15,2) NOT NULL,
    amount_type integer NOT NULL,
    deleted_reason character varying(128),
    account_head_id bigint NOT NULL,
    journal_id uuid NOT NULL,
    warehouse_id uuid NOT NULL
);


ALTER TABLE public.finance_journal_voucher_item OWNER TO nexsme_live;

--
-- Name: finance_payment_voucher; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.finance_payment_voucher (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    voucher_number integer NOT NULL,
    voucher_date timestamp with time zone,
    title character varying(128) NOT NULL,
    description character varying(128),
    sub_ledger character varying(128),
    amount numeric(15,2) NOT NULL,
    amount_type integer NOT NULL,
    transfer_type integer NOT NULL,
    is_system_generated boolean NOT NULL,
    cheque_number bigint,
    cheque_date date,
    cheque_status integer,
    cheque_status_date date,
    draft_number bigint,
    draft_date date,
    transfer_number bigint,
    transfer_date date,
    account_head_id bigint NOT NULL,
    bank_id uuid,
    creator_id integer NOT NULL,
    financial_year_id uuid NOT NULL,
    updater_id integer,
    warehouse_id uuid NOT NULL,
    CONSTRAINT finance_payment_voucher_auto_id_check CHECK ((auto_id >= 0)),
    CONSTRAINT finance_payment_voucher_voucher_number_check CHECK ((voucher_number >= 0))
);


ALTER TABLE public.finance_payment_voucher OWNER TO nexsme_live;

--
-- Name: finance_receipt_voucher; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.finance_receipt_voucher (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    voucher_date timestamp with time zone,
    voucher_number integer NOT NULL,
    title character varying(128) NOT NULL,
    description character varying(128),
    sub_ledger character varying(128),
    amount numeric(15,2) NOT NULL,
    amount_type integer NOT NULL,
    transfer_type integer NOT NULL,
    is_system_generated boolean NOT NULL,
    cheque_number integer,
    cheque_date date,
    cheque_status integer,
    cheque_status_date date,
    draft_number integer,
    draft_date date,
    transfer_number integer,
    transfer_date date,
    account_head_id bigint NOT NULL,
    bank_id uuid,
    creator_id integer NOT NULL,
    financial_year_id uuid NOT NULL,
    updater_id integer,
    warehouse_id uuid NOT NULL,
    CONSTRAINT finance_receipt_voucher_auto_id_check CHECK ((auto_id >= 0)),
    CONSTRAINT finance_receipt_voucher_cheque_number_check CHECK ((cheque_number >= 0)),
    CONSTRAINT finance_receipt_voucher_draft_number_check CHECK ((draft_number >= 0)),
    CONSTRAINT finance_receipt_voucher_transfer_number_check CHECK ((transfer_number >= 0)),
    CONSTRAINT finance_receipt_voucher_voucher_number_check CHECK ((voucher_number >= 0))
);


ALTER TABLE public.finance_receipt_voucher OWNER TO nexsme_live;

--
-- Name: finance_subledger_opening; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.finance_subledger_opening (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    sub_ledger character varying(30),
    sub_ledger_type integer,
    amount_type integer,
    amount numeric(15,2) NOT NULL,
    account_head_id bigint NOT NULL,
    creator_id integer NOT NULL,
    financial_year_id uuid,
    updater_id integer,
    CONSTRAINT finance_subledger_opening_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.finance_subledger_opening OWNER TO nexsme_live;

--
-- Name: general_batch; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.general_batch (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    batch_number character varying(128) NOT NULL,
    stock numeric(15,3) NOT NULL,
    mrp numeric(15,2) NOT NULL,
    retail_price numeric(15,3) NOT NULL,
    whole_sale_price numeric(15,3) NOT NULL,
    cost numeric(15,2) NOT NULL,
    manufacturing_date date,
    expire_date date,
    creator_id integer NOT NULL,
    product_id uuid NOT NULL,
    product_variant_id uuid NOT NULL,
    updater_id integer,
    warehouse_id uuid,
    CONSTRAINT general_batch_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.general_batch OWNER TO nexsme_live;

--
-- Name: general_charge_per_kilometer; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.general_charge_per_kilometer (
    id uuid NOT NULL,
    charge numeric(15,2) NOT NULL,
    is_deleted boolean NOT NULL
);


ALTER TABLE public.general_charge_per_kilometer OWNER TO nexsme_live;

--
-- Name: general_charge_setting; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.general_charge_setting (
    id uuid NOT NULL,
    no_delivery_charge_amount numeric(15,2) NOT NULL,
    no_free_delivery_amount numeric(15,2) NOT NULL,
    vendor_id uuid,
    warehouse_id uuid
);


ALTER TABLE public.general_charge_setting OWNER TO nexsme_live;

--
-- Name: general_damaged_product; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.general_damaged_product (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    date timestamp with time zone NOT NULL,
    quantity numeric(15,3) NOT NULL,
    amount numeric(15,3) NOT NULL,
    description text,
    batch_id uuid,
    creator_id integer NOT NULL,
    product_variant_id uuid NOT NULL,
    updater_id integer,
    warehouse_id uuid,
    CONSTRAINT general_damaged_product_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.general_damaged_product OWNER TO nexsme_live;

--
-- Name: general_delivery_charge; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.general_delivery_charge (
    id uuid NOT NULL,
    normal_charge numeric(15,2) NOT NULL,
    express_charge numeric(15,2),
    is_deleted boolean NOT NULL,
    to_zone_id bigint NOT NULL,
    vendor_id uuid,
    warehouse_id uuid
);


ALTER TABLE public.general_delivery_charge OWNER TO nexsme_live;

--
-- Name: invoic_prefix; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.invoic_prefix (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    retail_sale character varying(128) NOT NULL,
    "order" character varying(128) NOT NULL,
    purchase character varying(128) NOT NULL,
    is_active boolean NOT NULL,
    creator_id integer NOT NULL,
    financial_year_id uuid NOT NULL,
    updater_id integer,
    CONSTRAINT invoic_prefix_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.invoic_prefix OWNER TO nexsme_live;

--
-- Name: invoice_design; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.invoice_design (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    title character varying(128) NOT NULL,
    image character varying(100),
    is_active boolean NOT NULL,
    creator_id integer NOT NULL,
    updater_id integer,
    warehouse_id uuid NOT NULL,
    CONSTRAINT invoice_design_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.invoice_design OWNER TO nexsme_live;

--
-- Name: location; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.location (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    location character varying(128) NOT NULL,
    short_name character varying(50),
    latitude character varying(128),
    longitude character varying(128),
    creator_id integer NOT NULL,
    updater_id integer,
    CONSTRAINT location_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.location OWNER TO nexsme_live;

--
-- Name: mode; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.mode (
    id bigint NOT NULL,
    readonly boolean NOT NULL,
    maintenance boolean NOT NULL,
    down boolean NOT NULL
);


ALTER TABLE public.mode OWNER TO nexsme_live;

--
-- Name: mode_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.mode_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mode_id_seq OWNER TO nexsme_live;

--
-- Name: mode_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.mode_id_seq OWNED BY public.mode.id;


--
-- Name: offers; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.offers (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    title character varying(128) NOT NULL,
    offer_type character varying(128) NOT NULL,
    offer_percentage numeric(15,2) NOT NULL,
    start_time timestamp with time zone NOT NULL,
    end_time timestamp with time zone NOT NULL,
    image character varying(100),
    category_id uuid,
    creator_id integer NOT NULL,
    product_variant_id uuid,
    subcategory_id uuid,
    updater_id integer,
    warehouse_id uuid,
    CONSTRAINT offers_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.offers OWNER TO nexsme_live;

--
-- Name: offers_vouchercode; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.offers_vouchercode (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    voucher_code character varying(128) NOT NULL,
    title character varying(128) NOT NULL,
    description text NOT NULL,
    voucher_type smallint NOT NULL,
    start_time timestamp with time zone,
    end_time timestamp with time zone,
    minimum_order_amount numeric(15,2) NOT NULL,
    upto_limit numeric(15,2) NOT NULL,
    voucher_amount numeric(15,2) NOT NULL,
    percentage numeric(15,2) NOT NULL,
    is_limited_once boolean NOT NULL,
    is_expired boolean NOT NULL,
    creator_id integer NOT NULL,
    customer_id uuid,
    product_id uuid,
    product_variant_id uuid,
    updater_id integer,
    CONSTRAINT offers_vouchercode_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.offers_vouchercode OWNER TO nexsme_live;

--
-- Name: offers_vouchercode_used_users; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.offers_vouchercode_used_users (
    id bigint NOT NULL,
    vouchercode_id uuid NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.offers_vouchercode_used_users OWNER TO nexsme_live;

--
-- Name: offers_vouchercode_used_users_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.offers_vouchercode_used_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.offers_vouchercode_used_users_id_seq OWNER TO nexsme_live;

--
-- Name: offers_vouchercode_used_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.offers_vouchercode_used_users_id_seq OWNED BY public.offers_vouchercode_used_users.id;


--
-- Name: orders_booking; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.orders_booking (
    id uuid NOT NULL,
    date_added timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    message text NOT NULL,
    status character varying(10) NOT NULL,
    customer_id uuid NOT NULL,
    order_id uuid,
    product_variant_id uuid NOT NULL
);


ALTER TABLE public.orders_booking OWNER TO nexsme_live;

--
-- Name: orders_orderitem; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.orders_orderitem (
    id uuid NOT NULL,
    date_added timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    qty numeric(15,2) NOT NULL,
    price numeric(15,2) NOT NULL,
    status integer,
    igst_rate numeric(15,2) NOT NULL,
    cgst_rate numeric(15,2) NOT NULL,
    sgst_rate numeric(15,2) NOT NULL,
    igst_amount numeric(15,2) NOT NULL,
    cgst_amount numeric(15,2) NOT NULL,
    sgst_amount numeric(15,2) NOT NULL,
    is_cancelled boolean NOT NULL,
    date_cancelled timestamp with time zone,
    batch_id uuid,
    order_id uuid NOT NULL,
    product_variant_id uuid NOT NULL,
    CONSTRAINT orders_orderitem_status_check CHECK ((status >= 0))
);


ALTER TABLE public.orders_orderitem OWNER TO nexsme_live;

--
-- Name: orders_orders; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.orders_orders (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    billing_name character varying(50) NOT NULL,
    billing_phone character varying(10) NOT NULL,
    billing_street character varying(128) NOT NULL,
    billing_address text,
    billing_landmark character varying(128),
    billing_state character varying(128),
    billing_city character varying(128),
    billing_latitude text,
    billing_longitude text,
    delivery_date date,
    order_status character varying(5) NOT NULL,
    payment_method character varying(128) NOT NULL,
    payment_status character varying(5) NOT NULL,
    assigned_time timestamp with time zone,
    delivery_agent_is_accept boolean,
    delivery_agent_accepted_time timestamp with time zone,
    delivery_agent_declined_time timestamp with time zone,
    delivery_agent_declined_reason character varying(100),
    delivery_agent_declined_reason_text text,
    pickup_status character varying(256),
    pickup_time timestamp with time zone,
    delivered_time timestamp with time zone,
    total_amt double precision NOT NULL,
    wallet_amount double precision,
    voucher_amount double precision,
    card_name character varying(128),
    card_number character varying(128),
    transaction_id character varying(128),
    payment_order_id character varying(128),
    delivery_note text,
    order_no integer NOT NULL,
    order_id text,
    is_express_delivery boolean NOT NULL,
    delivery_charge double precision,
    is_manual boolean NOT NULL,
    creator_id integer NOT NULL,
    customer_id uuid NOT NULL,
    delivery_agent_id uuid,
    prefix_id uuid,
    receipt_voucher_id uuid,
    time_slot_id uuid,
    updater_id integer,
    vendor_id uuid,
    warehouse_id uuid,
    zone_id bigint NOT NULL,
    CONSTRAINT orders_orders_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.orders_orders OWNER TO nexsme_live;

--
-- Name: orders_timeslot; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.orders_timeslot (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    day integer NOT NULL,
    start_time time without time zone NOT NULL,
    end_time time without time zone NOT NULL,
    is_active boolean NOT NULL,
    creator_id integer NOT NULL,
    updater_id integer,
    CONSTRAINT orders_timeslot_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.orders_timeslot OWNER TO nexsme_live;

--
-- Name: permission; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.permission (
    id bigint NOT NULL,
    name character varying(128) NOT NULL,
    code character varying(128) NOT NULL,
    app character varying(128) NOT NULL
);


ALTER TABLE public.permission OWNER TO nexsme_live;

--
-- Name: permission_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.permission_id_seq OWNER TO nexsme_live;

--
-- Name: permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.permission_id_seq OWNED BY public.permission.id;


--
-- Name: privilege_point_history; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.privilege_point_history (
    id bigint NOT NULL,
    title character varying(256) NOT NULL,
    point_type smallint NOT NULL,
    points numeric(15,0) NOT NULL,
    value_in_amount numeric(15,2) NOT NULL,
    date_added timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    customer_id uuid NOT NULL,
    CONSTRAINT privilege_point_history_point_type_check CHECK ((point_type >= 0))
);


ALTER TABLE public.privilege_point_history OWNER TO nexsme_live;

--
-- Name: privilege_point_history_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.privilege_point_history_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.privilege_point_history_id_seq OWNER TO nexsme_live;

--
-- Name: privilege_point_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.privilege_point_history_id_seq OWNED BY public.privilege_point_history.id;


--
-- Name: privilege_points; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.privilege_points (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    minimum_amount numeric(15,2) NOT NULL,
    value_of_point numeric(15,2) NOT NULL,
    point_gained_online numeric(15,0) NOT NULL,
    point_gained_offline numeric(15,0) NOT NULL,
    creator_id integer NOT NULL,
    updater_id integer,
    CONSTRAINT privilege_points_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.privilege_points OWNER TO nexsme_live;

--
-- Name: product_hsn_code; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.product_hsn_code (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    name character varying(128) NOT NULL,
    hsn_number character varying(128) NOT NULL,
    description character varying(30),
    igst_rate numeric(15,2) NOT NULL,
    sgst_rate numeric(15,2) NOT NULL,
    cgst_rate numeric(15,2) NOT NULL,
    vendor_created boolean NOT NULL,
    is_admin_approved boolean,
    creator_id integer NOT NULL,
    unit_id uuid NOT NULL,
    updater_id integer,
    CONSTRAINT product_hsn_code_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.product_hsn_code OWNER TO nexsme_live;

--
-- Name: product_stock; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.product_stock (
    id bigint NOT NULL,
    category character varying(128) NOT NULL,
    date date NOT NULL,
    increment numeric(15,2) NOT NULL,
    decrement numeric(15,2) NOT NULL,
    batch_id uuid,
    product_variant_id uuid,
    warehouse_id uuid
);


ALTER TABLE public.product_stock OWNER TO nexsme_live;

--
-- Name: product_stock_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.product_stock_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_stock_id_seq OWNER TO nexsme_live;

--
-- Name: product_stock_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.product_stock_id_seq OWNED BY public.product_stock.id;


--
-- Name: product_variation_type; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.product_variation_type (
    id bigint NOT NULL,
    name character varying(128) NOT NULL,
    variation_type smallint NOT NULL,
    other_type character varying(128),
    is_deleted boolean NOT NULL
);


ALTER TABLE public.product_variation_type OWNER TO nexsme_live;

--
-- Name: product_variation_type_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.product_variation_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.product_variation_type_id_seq OWNER TO nexsme_live;

--
-- Name: product_variation_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.product_variation_type_id_seq OWNED BY public.product_variation_type.id;


--
-- Name: products_brand; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.products_brand (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    name character varying(128) NOT NULL,
    vendor_created boolean NOT NULL,
    is_admin_approved boolean,
    creator_id integer NOT NULL,
    updater_id integer,
    CONSTRAINT products_brand_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.products_brand OWNER TO nexsme_live;

--
-- Name: products_category; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.products_category (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    name character varying(128) NOT NULL,
    image character varying(100),
    is_featured boolean NOT NULL,
    vendor_created boolean NOT NULL,
    is_admin_approved boolean,
    creator_id integer NOT NULL,
    updater_id integer,
    CONSTRAINT products_category_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.products_category OWNER TO nexsme_live;

--
-- Name: products_product; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.products_product (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    name character varying(128) NOT NULL,
    image character varying(100),
    description text,
    meta_description character varying(128) NOT NULL,
    is_active boolean NOT NULL,
    is_varying_price boolean NOT NULL,
    has_special_variant boolean NOT NULL,
    cancellable_duration numeric(15,2) NOT NULL,
    cancellable_duration_type character varying(7) NOT NULL,
    returnable_duration numeric(15,2) NOT NULL,
    returnable_duration_type character varying(7) NOT NULL,
    vendor_created boolean NOT NULL,
    is_admin_approved boolean,
    brand_id uuid,
    category_id uuid,
    creator_id integer NOT NULL,
    hsn_id uuid,
    special_category_id uuid,
    subcategory_id uuid,
    unit_of_measurement_id uuid,
    updater_id integer,
    vendor_id uuid,
    CONSTRAINT products_product_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.products_product OWNER TO nexsme_live;

--
-- Name: products_product_image; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.products_product_image (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    deleted_reason character varying(128),
    image character varying(100),
    is_deleted boolean NOT NULL,
    creator_id integer NOT NULL,
    product_variant_id uuid,
    updater_id integer,
    CONSTRAINT products_product_image_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.products_product_image OWNER TO nexsme_live;

--
-- Name: products_product_variant; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.products_product_variant (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    title character varying(120) NOT NULL,
    product_code character varying(128) NOT NULL,
    image character varying(100),
    current_rating numeric(15,1) NOT NULL,
    stock numeric(15,3) NOT NULL,
    warranty character varying(120),
    discount_limit numeric(15,3) NOT NULL,
    low_stock_limit integer NOT NULL,
    first_time_stock numeric(15,3) NOT NULL,
    batch_number character varying(128),
    expire_date date,
    retail_price numeric(15,2) NOT NULL,
    manufacturing_date date,
    cost numeric(15,2) NOT NULL,
    mrp numeric(15,2) NOT NULL,
    commission_percentage numeric(15,2),
    whole_sale_quantity numeric(15,0) NOT NULL,
    whole_sale_price numeric(15,2) NOT NULL,
    tax_included boolean NOT NULL,
    is_featured boolean NOT NULL,
    is_default boolean NOT NULL,
    is_special_variant boolean NOT NULL,
    vendor_created boolean NOT NULL,
    is_admin_approved boolean,
    colour_variation_id bigint,
    creator_id integer NOT NULL,
    other_variation_id bigint,
    product_id uuid NOT NULL,
    size_variation_id bigint,
    unit_id uuid NOT NULL,
    updater_id integer,
    warehouse_id uuid,
    CONSTRAINT products_product_variant_auto_id_check CHECK ((auto_id >= 0)),
    CONSTRAINT products_product_variant_low_stock_limit_check CHECK ((low_stock_limit >= 0))
);


ALTER TABLE public.products_product_variant OWNER TO nexsme_live;

--
-- Name: products_special_category; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.products_special_category (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    name character varying(128) NOT NULL,
    creator_id integer NOT NULL,
    updater_id integer,
    CONSTRAINT products_special_category_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.products_special_category OWNER TO nexsme_live;

--
-- Name: products_sub_category; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.products_sub_category (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    name character varying(128) NOT NULL,
    vendor_created boolean NOT NULL,
    is_admin_approved boolean,
    category_id uuid NOT NULL,
    creator_id integer NOT NULL,
    updater_id integer,
    CONSTRAINT products_sub_category_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.products_sub_category OWNER TO nexsme_live;

--
-- Name: products_unit; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.products_unit (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    unit character varying(128) NOT NULL,
    vendor_created boolean NOT NULL,
    is_admin_approved boolean,
    creator_id integer NOT NULL,
    unit_of_measurement_id uuid NOT NULL,
    updater_id integer,
    CONSTRAINT products_unit_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.products_unit OWNER TO nexsme_live;

--
-- Name: products_unit_measurement; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.products_unit_measurement (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    unit_of_measurement character varying(128) NOT NULL,
    vendor_created boolean NOT NULL,
    is_admin_approved boolean,
    creator_id integer NOT NULL,
    updater_id integer,
    CONSTRAINT products_unit_measurement_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.products_unit_measurement OWNER TO nexsme_live;

--
-- Name: purchase; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.purchase (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    date timestamp with time zone NOT NULL,
    purchase_no integer,
    purchase_id character varying(128),
    product_total numeric(30,3) NOT NULL,
    round_off numeric(30,3) NOT NULL,
    discount numeric(30,3) NOT NULL,
    subtotal numeric(30,3) NOT NULL,
    paid numeric(30,3) NOT NULL,
    balance numeric(30,3),
    credit_date date,
    payment_method character varying(123),
    add_gst boolean NOT NULL,
    is_updated boolean NOT NULL,
    creator_id integer NOT NULL,
    payment_voucher_id uuid,
    purchase_prefix_id uuid,
    supplier_id uuid NOT NULL,
    updater_id integer,
    warehouse_id uuid,
    CONSTRAINT purchase_auto_id_check CHECK ((auto_id >= 0)),
    CONSTRAINT purchase_purchase_no_check CHECK ((purchase_no >= 0))
);


ALTER TABLE public.purchase OWNER TO nexsme_live;

--
-- Name: purchase_item; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.purchase_item (
    id bigint NOT NULL,
    add_new_batch boolean NOT NULL,
    batch_number character varying(128),
    quantity numeric(15,3) NOT NULL,
    return_qty numeric(15,2) NOT NULL,
    manufacturing_date date,
    expire_date timestamp with time zone,
    discount numeric(15,2) NOT NULL,
    net_rate numeric(15,2) NOT NULL,
    igst_rate numeric(15,2) NOT NULL,
    sgst_rate numeric(15,2) NOT NULL,
    cgst_rate numeric(15,2) NOT NULL,
    taxable_amount numeric(15,2) NOT NULL,
    mrp numeric(15,2) NOT NULL,
    retail_price numeric(15,3) NOT NULL,
    whole_sale_price numeric(15,3) NOT NULL,
    amount numeric(15,2) NOT NULL,
    total numeric(15,2) NOT NULL,
    gross_amount numeric(15,2) NOT NULL,
    hsn character varying(128),
    comments character varying(128),
    unit_type character varying(128),
    cgst_amount numeric(15,2) NOT NULL,
    sgst_amount numeric(15,2) NOT NULL,
    igst_amount numeric(15,2) NOT NULL,
    batch_id uuid,
    product_variant_id uuid,
    purchase_id uuid NOT NULL
);


ALTER TABLE public.purchase_item OWNER TO nexsme_live;

--
-- Name: purchase_item_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.purchase_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.purchase_item_id_seq OWNER TO nexsme_live;

--
-- Name: purchase_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.purchase_item_id_seq OWNED BY public.purchase_item.id;


--
-- Name: purchase_order; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.purchase_order (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    date timestamp with time zone NOT NULL,
    order_no integer,
    order_id character varying(128),
    product_total numeric(30,3) NOT NULL,
    round_off numeric(30,3) NOT NULL,
    discount numeric(30,3) NOT NULL,
    subtotal numeric(30,3) NOT NULL,
    add_gst boolean NOT NULL,
    is_updated boolean NOT NULL,
    is_partial boolean NOT NULL,
    is_purchased boolean NOT NULL,
    creator_id integer NOT NULL,
    purchase_id uuid,
    supplier_id uuid NOT NULL,
    updater_id integer,
    warehouse_id uuid,
    CONSTRAINT purchase_order_auto_id_check CHECK ((auto_id >= 0)),
    CONSTRAINT purchase_order_order_no_check CHECK ((order_no >= 0))
);


ALTER TABLE public.purchase_order OWNER TO nexsme_live;

--
-- Name: purchase_order_item; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.purchase_order_item (
    id bigint NOT NULL,
    add_new_batch boolean NOT NULL,
    batch_number character varying(128),
    quantity numeric(15,3) NOT NULL,
    expire_date timestamp with time zone NOT NULL,
    manufacturing_date date NOT NULL,
    discount numeric(15,2) NOT NULL,
    igst_rate numeric(15,2) NOT NULL,
    sgst_rate numeric(15,2) NOT NULL,
    cgst_rate numeric(15,2) NOT NULL,
    taxable_amount numeric(15,2) NOT NULL,
    net_rate numeric(15,2) NOT NULL,
    mrp numeric(15,2) NOT NULL,
    retail_price numeric(15,3) NOT NULL,
    whole_sale_price numeric(15,3) NOT NULL,
    amount numeric(15,2) NOT NULL,
    hsn character varying(128),
    comments character varying(128),
    unit_type character varying(128),
    total numeric(15,2) NOT NULL,
    cgst_amount numeric(15,2) NOT NULL,
    sgst_amount numeric(15,2) NOT NULL,
    igst_amount numeric(15,2) NOT NULL,
    gross_amount numeric(15,2) NOT NULL,
    is_purchased boolean NOT NULL,
    batch_id uuid,
    product_variant_id uuid,
    purchase_order_id uuid NOT NULL
);


ALTER TABLE public.purchase_order_item OWNER TO nexsme_live;

--
-- Name: purchase_order_item_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.purchase_order_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.purchase_order_item_id_seq OWNER TO nexsme_live;

--
-- Name: purchase_order_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.purchase_order_item_id_seq OWNED BY public.purchase_order_item.id;


--
-- Name: purchase_return; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.purchase_return (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    date date NOT NULL,
    total numeric(15,2) NOT NULL,
    amount_returned numeric(15,2) NOT NULL,
    is_updated boolean NOT NULL,
    creator_id integer NOT NULL,
    purchase_id uuid,
    supplier_id uuid NOT NULL,
    updater_id integer,
    CONSTRAINT purchase_return_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.purchase_return OWNER TO nexsme_live;

--
-- Name: purchase_return_item; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.purchase_return_item (
    id bigint NOT NULL,
    quantity numeric(15,3) NOT NULL,
    amount numeric(15,2) NOT NULL,
    total numeric(15,2) NOT NULL,
    status character varying(128) NOT NULL,
    is_deleted boolean NOT NULL,
    batch_id uuid,
    product_id uuid NOT NULL,
    product_variant_id uuid,
    purchase_item_id bigint NOT NULL,
    purchase_return_id uuid
);


ALTER TABLE public.purchase_return_item OWNER TO nexsme_live;

--
-- Name: purchase_return_item_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.purchase_return_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.purchase_return_item_id_seq OWNER TO nexsme_live;

--
-- Name: purchase_return_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.purchase_return_item_id_seq OWNED BY public.purchase_return_item.id;


--
-- Name: registration_registrationprofile; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.registration_registrationprofile (
    id bigint NOT NULL,
    activation_key character varying(64) NOT NULL,
    user_id integer NOT NULL,
    activated boolean NOT NULL
);


ALTER TABLE public.registration_registrationprofile OWNER TO nexsme_live;

--
-- Name: registration_registrationprofile_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.registration_registrationprofile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.registration_registrationprofile_id_seq OWNER TO nexsme_live;

--
-- Name: registration_registrationprofile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.registration_registrationprofile_id_seq OWNED BY public.registration_registrationprofile.id;


--
-- Name: registration_supervisedregistrationprofile; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.registration_supervisedregistrationprofile (
    registrationprofile_ptr_id bigint NOT NULL
);


ALTER TABLE public.registration_supervisedregistrationprofile OWNER TO nexsme_live;

--
-- Name: return_images; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.return_images (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    image character varying(100),
    creator_id integer NOT NULL,
    product_return_id uuid NOT NULL,
    updater_id integer,
    CONSTRAINT return_images_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.return_images OWNER TO nexsme_live;

--
-- Name: salary_pay; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.salary_pay (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    date date,
    leave_count numeric(15,2),
    half_leave_count numeric(15,2),
    salary numeric(15,0),
    is_paid boolean NOT NULL,
    paid_amount numeric(15,0),
    creator_id integer NOT NULL,
    staff_id uuid NOT NULL,
    updater_id integer,
    CONSTRAINT salary_pay_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.salary_pay OWNER TO nexsme_live;

--
-- Name: sale_return; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.sale_return (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    deleted_reason character varying(128),
    "time" timestamp with time zone NOT NULL,
    a_id integer NOT NULL,
    amount_returned numeric(15,2) NOT NULL,
    returnable_amount numeric(15,2),
    is_updated boolean NOT NULL,
    is_deleted boolean NOT NULL,
    creator_id integer NOT NULL,
    customer_id uuid,
    sale_id uuid NOT NULL,
    updater_id integer,
    warehouse_id uuid,
    CONSTRAINT sale_return_a_id_check CHECK ((a_id >= 0)),
    CONSTRAINT sale_return_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.sale_return OWNER TO nexsme_live;

--
-- Name: sale_return_item; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.sale_return_item (
    id bigint NOT NULL,
    qty numeric(15,3) NOT NULL,
    price numeric(15,2) NOT NULL,
    cost numeric(15,2) NOT NULL,
    status character varying(128) NOT NULL,
    is_deleted boolean NOT NULL,
    batch_id uuid,
    product_id uuid NOT NULL,
    product_variant_id uuid,
    sale_item_id bigint NOT NULL,
    sale_return_id uuid NOT NULL
);


ALTER TABLE public.sale_return_item OWNER TO nexsme_live;

--
-- Name: sale_return_item_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.sale_return_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sale_return_item_id_seq OWNER TO nexsme_live;

--
-- Name: sale_return_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.sale_return_item_id_seq OWNED BY public.sale_return_item.id;


--
-- Name: sales; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.sales (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    a_id integer NOT NULL,
    sale_no integer,
    tracking_no integer,
    sale_id character varying(128),
    tracking_id character varying(128),
    sale_date timestamp with time zone NOT NULL,
    shipment_date date,
    customer_address text,
    approval_status character varying(128) NOT NULL,
    sale_category character varying(128) NOT NULL,
    sale_type character varying(128) NOT NULL,
    payment_method character varying(123),
    credit_date date,
    transporter character varying(128),
    subtotal numeric(15,2) NOT NULL,
    round_off numeric(30,3) NOT NULL,
    total numeric(15,2) NOT NULL,
    paid numeric(15,2) NOT NULL,
    discount_rate numeric(15,2) NOT NULL,
    discount numeric(15,2) NOT NULL,
    special_discount numeric(15,2) NOT NULL,
    use_privilege_point boolean NOT NULL,
    privilege_point_used integer NOT NULL,
    privilege_point_amnt numeric(15,2) NOT NULL,
    privilege_points integer NOT NULL,
    total_cgst numeric(15,2) NOT NULL,
    total_igst numeric(15,2) NOT NULL,
    total_sgst numeric(15,2) NOT NULL,
    customer_balance_type character varying(128),
    customer_balance numeric(15,2) NOT NULL,
    tax_amount numeric(15,2) NOT NULL,
    sale_taxable_amount numeric(15,2) NOT NULL,
    purchase_taxable_amount numeric(15,2) NOT NULL,
    total_commission numeric(15,2) NOT NULL,
    total_outstanding numeric(15,2) NOT NULL,
    add_gst boolean NOT NULL,
    is_updated boolean NOT NULL,
    creator_id integer NOT NULL,
    customer_id uuid,
    receipt_voucher_id uuid,
    sale_prefix_id uuid,
    updater_id integer,
    warehouse_id uuid,
    CONSTRAINT sales_a_id_check CHECK ((a_id >= 0)),
    CONSTRAINT sales_auto_id_check CHECK ((auto_id >= 0)),
    CONSTRAINT sales_sale_no_check CHECK ((sale_no >= 0)),
    CONSTRAINT sales_tracking_no_check CHECK ((tracking_no >= 0))
);


ALTER TABLE public.sales OWNER TO nexsme_live;

--
-- Name: sales_sale_item; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.sales_sale_item (
    id bigint NOT NULL,
    comments character varying(128),
    return_qty numeric(15,2) NOT NULL,
    quantity numeric(15,3) NOT NULL,
    amount numeric(15,3) NOT NULL,
    mrp numeric(15,2) NOT NULL,
    total numeric(15,2) NOT NULL,
    sub_total numeric(15,2) NOT NULL,
    net_rate numeric(15,2) NOT NULL,
    discount_rate numeric(15,2) NOT NULL,
    discount numeric(15,2) NOT NULL,
    igst_rate numeric(15,2) NOT NULL,
    cgst_rate numeric(15,2) NOT NULL,
    sgst_rate numeric(15,2) NOT NULL,
    igst_amount numeric(15,2) NOT NULL,
    cgst_amount numeric(15,2) NOT NULL,
    sgst_amount numeric(15,2) NOT NULL,
    commission_amount numeric(15,2) NOT NULL,
    purchase_taxable_amount numeric(15,2) NOT NULL,
    sale_taxable_amount numeric(15,2) NOT NULL,
    batch_id uuid,
    product_variant_id uuid,
    sale_id uuid NOT NULL
);


ALTER TABLE public.sales_sale_item OWNER TO nexsme_live;

--
-- Name: sales_sale_item_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.sales_sale_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sales_sale_item_id_seq OWNER TO nexsme_live;

--
-- Name: sales_sale_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.sales_sale_item_id_seq OWNED BY public.sales_sale_item.id;


--
-- Name: setting; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.setting (
    id uuid NOT NULL,
    counter integer NOT NULL,
    prefix character varying(128) NOT NULL,
    project_prefix character varying(128) NOT NULL,
    product_prefix character varying(128) NOT NULL,
    purchase_prefix character varying(128) NOT NULL,
    sale_prefix character varying(128) NOT NULL,
    payment_prefix character varying(128) NOT NULL,
    is_deleted boolean NOT NULL,
    CONSTRAINT setting_counter_check CHECK ((counter >= 0))
);


ALTER TABLE public.setting OWNER TO nexsme_live;

--
-- Name: special_variant; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.special_variant (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    name character varying(128) NOT NULL,
    product_code character varying(128) NOT NULL,
    description text,
    actual_price numeric(15,2) NOT NULL,
    amount numeric(15,2) NOT NULL,
    quantity numeric(15,2) NOT NULL,
    created_variant_id uuid NOT NULL,
    creator_id integer NOT NULL,
    updater_id integer,
    CONSTRAINT special_variant_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.special_variant OWNER TO nexsme_live;

--
-- Name: special_variant_product_variant; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.special_variant_product_variant (
    id bigint NOT NULL,
    specialvariant_id uuid NOT NULL,
    productvariant_id uuid NOT NULL
);


ALTER TABLE public.special_variant_product_variant OWNER TO nexsme_live;

--
-- Name: special_variant_product_variant_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.special_variant_product_variant_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.special_variant_product_variant_id_seq OWNER TO nexsme_live;

--
-- Name: special_variant_product_variant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.special_variant_product_variant_id_seq OWNED BY public.special_variant_product_variant.id;


--
-- Name: staff; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.staff (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    staff_id character varying(128) NOT NULL,
    name character varying(128) NOT NULL,
    email character varying(254),
    phone character varying(128),
    gender character varying(40) NOT NULL,
    photo character varying(100),
    address text,
    staff_role character varying(40) NOT NULL,
    joining_date timestamp with time zone,
    staff_age text,
    current_salary numeric(8,2) NOT NULL,
    salary numeric(8,0) NOT NULL,
    bank_name character varying(128),
    branch character varying(128),
    bank_account_name character varying(128),
    ifsc_code character varying(128),
    account_num character varying(128),
    password character varying(60),
    is_currently_working boolean NOT NULL,
    normal_staff boolean NOT NULL,
    super_admin boolean NOT NULL,
    client_manager boolean NOT NULL,
    staff_manager boolean NOT NULL,
    advance_salary numeric(8,2),
    credit numeric(15,4) NOT NULL,
    debit numeric(15,4) NOT NULL,
    creator_id integer NOT NULL,
    designation_id uuid NOT NULL,
    updater_id integer,
    user_id integer,
    warehouse_id uuid,
    CONSTRAINT staff_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.staff OWNER TO nexsme_live;

--
-- Name: staff_attendence; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.staff_attendence (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    date date NOT NULL,
    leave_count numeric(15,2),
    half_leave_count numeric(15,2),
    is_present boolean NOT NULL,
    is_leave boolean NOT NULL,
    is_halfday boolean NOT NULL,
    is_excuseleave boolean NOT NULL,
    is_holiday boolean NOT NULL,
    is_work_at_home boolean NOT NULL,
    creator_id integer NOT NULL,
    staff_id uuid NOT NULL,
    updater_id integer,
    CONSTRAINT staff_attendence_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.staff_attendence OWNER TO nexsme_live;

--
-- Name: staff_permission; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.staff_permission (
    id bigint NOT NULL,
    staff_id uuid NOT NULL,
    permission_id bigint NOT NULL
);


ALTER TABLE public.staff_permission OWNER TO nexsme_live;

--
-- Name: staff_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.staff_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.staff_permission_id_seq OWNER TO nexsme_live;

--
-- Name: staff_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.staff_permission_id_seq OWNED BY public.staff_permission.id;


--
-- Name: staff_salary_allowance; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.staff_salary_allowance (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    deleted_reason character varying(128),
    date date NOT NULL,
    is_deleted boolean NOT NULL,
    description character varying(128),
    allowance_type character varying(128) NOT NULL,
    days numeric(15,2),
    hours numeric(15,2),
    rate_per_day numeric(15,2),
    rate_per_hour numeric(15,2),
    is_paid boolean NOT NULL,
    allowance numeric(15,2),
    creator_id integer NOT NULL,
    staff_id uuid,
    updater_id integer,
    CONSTRAINT staff_salary_allowance_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.staff_salary_allowance OWNER TO nexsme_live;

--
-- Name: stock_transfer; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.stock_transfer (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    date timestamp with time zone NOT NULL,
    creator_id integer NOT NULL,
    to_warehouse_id uuid NOT NULL,
    updater_id integer,
    warehouse_id uuid NOT NULL,
    CONSTRAINT stock_transfer_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.stock_transfer OWNER TO nexsme_live;

--
-- Name: stock_transfer_items; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.stock_transfer_items (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    retail_price numeric(15,3) NOT NULL,
    whole_sale_price numeric(15,3) NOT NULL,
    cost numeric(15,2) NOT NULL,
    mrp numeric(15,2) NOT NULL,
    quantity numeric(15,2) NOT NULL,
    manufacturing_date date NOT NULL,
    expire_date date NOT NULL,
    batch_id uuid,
    creator_id integer NOT NULL,
    product_variant_id uuid,
    stock_transfer_id uuid,
    updater_id integer,
    CONSTRAINT stock_transfer_items_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.stock_transfer_items OWNER TO nexsme_live;

--
-- Name: stock_update; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.stock_update (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    date timestamp with time zone NOT NULL,
    description character varying(128) NOT NULL,
    update_type character varying(128) NOT NULL,
    creator_id integer NOT NULL,
    updater_id integer,
    warehouse_id uuid NOT NULL,
    CONSTRAINT stock_update_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.stock_update OWNER TO nexsme_live;

--
-- Name: stock_update_item; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.stock_update_item (
    id bigint NOT NULL,
    add_new_batch boolean NOT NULL,
    batch_number character varying(128),
    expire_date date,
    manufacturing_date date,
    stock numeric(15,3) NOT NULL,
    mrp numeric(15,2) NOT NULL,
    cost numeric(15,2) NOT NULL,
    taxable_amount numeric(15,2) NOT NULL,
    retail_price numeric(15,3) NOT NULL,
    whole_sale_price numeric(15,3) NOT NULL,
    is_deleted boolean NOT NULL,
    batch_id uuid,
    product_variant_id uuid,
    stockupdate_id uuid NOT NULL
);


ALTER TABLE public.stock_update_item OWNER TO nexsme_live;

--
-- Name: stock_update_item_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.stock_update_item_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stock_update_item_id_seq OWNER TO nexsme_live;

--
-- Name: stock_update_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.stock_update_item_id_seq OWNED BY public.stock_update_item.id;


--
-- Name: students_registration_profile; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.students_registration_profile (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    phone character varying(16) NOT NULL,
    date_added timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    user_id integer NOT NULL,
    CONSTRAINT students_registration_profile_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.students_registration_profile OWNER TO nexsme_live;

--
-- Name: suppliers_supplier; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.suppliers_supplier (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    name character varying(128) NOT NULL,
    address text NOT NULL,
    phone character varying(128) NOT NULL,
    email character varying(254),
    bank_name character varying(128),
    bank_account_name character varying(128),
    branch character varying(128),
    ifsc_code character varying(128),
    account_num character varying(20),
    opening_type character varying(128) NOT NULL,
    opening_balance numeric(15,2) NOT NULL,
    credit_limit numeric(15,2) NOT NULL,
    debit_limit numeric(15,2) NOT NULL,
    current_balance numeric(15,2) NOT NULL,
    state character varying(128) NOT NULL,
    district character varying(128),
    country character varying(128) NOT NULL,
    gst_number character varying(128),
    creator_id integer NOT NULL,
    updater_id integer,
    user_id integer,
    CONSTRAINT suppliers_supplier_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.suppliers_supplier OWNER TO nexsme_live;

--
-- Name: techpe_staff_record; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.techpe_staff_record (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    leave_count numeric(15,2) NOT NULL,
    half_leave_count numeric(15,2) NOT NULL,
    salary numeric(15,0) NOT NULL,
    date timestamp with time zone NOT NULL,
    is_paid boolean NOT NULL,
    is_partially_paid boolean NOT NULL,
    paid_amount numeric(15,2) NOT NULL,
    payment_date date,
    creator_id integer NOT NULL,
    staff_id uuid NOT NULL,
    updater_id integer,
    CONSTRAINT techpe_staff_record_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.techpe_staff_record OWNER TO nexsme_live;

--
-- Name: tickets; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.tickets (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    subject character varying(256),
    description text,
    status character varying(50) NOT NULL,
    priority character varying(50) NOT NULL,
    attachment character varying(100),
    reject_reason character varying(256),
    message character varying(256),
    creator_id integer NOT NULL,
    customer_id uuid NOT NULL,
    updater_id integer,
    CONSTRAINT tickets_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.tickets OWNER TO nexsme_live;

--
-- Name: users_cartitem; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.users_cartitem (
    id uuid NOT NULL,
    date_added timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    qty integer NOT NULL,
    customer_id uuid NOT NULL,
    product_variant_id uuid NOT NULL,
    warehouse_id uuid
);


ALTER TABLE public.users_cartitem OWNER TO nexsme_live;

--
-- Name: users_notification; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.users_notification (
    id bigint NOT NULL,
    message character varying(128),
    "time" timestamp with time zone NOT NULL,
    is_read boolean NOT NULL,
    is_visited boolean NOT NULL,
    is_deleted boolean NOT NULL,
    is_active boolean NOT NULL,
    customer_id uuid,
    order_id uuid,
    subject_id bigint,
    user_id integer,
    who_id integer
);


ALTER TABLE public.users_notification OWNER TO nexsme_live;

--
-- Name: users_notification_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.users_notification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_notification_id_seq OWNER TO nexsme_live;

--
-- Name: users_notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.users_notification_id_seq OWNED BY public.users_notification.id;


--
-- Name: users_notification_subject; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.users_notification_subject (
    id bigint NOT NULL,
    code character varying(128) NOT NULL,
    name character varying(128) NOT NULL
);


ALTER TABLE public.users_notification_subject OWNER TO nexsme_live;

--
-- Name: users_notification_subject_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.users_notification_subject_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_notification_subject_id_seq OWNER TO nexsme_live;

--
-- Name: users_notification_subject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.users_notification_subject_id_seq OWNED BY public.users_notification_subject.id;


--
-- Name: users_user_login; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.users_user_login (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    ip inet NOT NULL,
    otp character varying(4) NOT NULL,
    status character varying(15) NOT NULL,
    failed_attempts integer NOT NULL,
    is_activated boolean NOT NULL,
    user_id integer NOT NULL,
    CONSTRAINT users_user_login_auto_id_check CHECK ((auto_id >= 0)),
    CONSTRAINT users_user_login_failed_attempts_check CHECK ((failed_attempts >= 0))
);


ALTER TABLE public.users_user_login OWNER TO nexsme_live;

--
-- Name: users_wishlistitem; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.users_wishlistitem (
    id uuid NOT NULL,
    date_added timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    customer_id uuid NOT NULL,
    product_variant_id uuid NOT NULL
);


ALTER TABLE public.users_wishlistitem OWNER TO nexsme_live;

--
-- Name: vendors_commission; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.vendors_commission (
    id bigint NOT NULL,
    date date NOT NULL,
    commission_amount numeric(15,2) NOT NULL,
    is_paid boolean NOT NULL,
    order_item_id uuid,
    vendor_id uuid NOT NULL
);


ALTER TABLE public.vendors_commission OWNER TO nexsme_live;

--
-- Name: vendors_commission_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.vendors_commission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vendors_commission_id_seq OWNER TO nexsme_live;

--
-- Name: vendors_commission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.vendors_commission_id_seq OWNED BY public.vendors_commission.id;


--
-- Name: vendors_vendor; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.vendors_vendor (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    name character varying(128) NOT NULL,
    vendor_type character varying(128),
    type_arabic character varying(128),
    arabic_name character varying(128),
    address text NOT NULL,
    phone character varying(128) NOT NULL,
    email character varying(254),
    bank_name character varying(128),
    bank_account_name character varying(128),
    branch character varying(128),
    ifsc_code character varying(128),
    account_num character varying(128),
    opening_type character varying(128) NOT NULL,
    opening_balance numeric(15,2) NOT NULL,
    country character varying(128) NOT NULL,
    current_balance numeric(15,2) NOT NULL,
    image character varying(100) NOT NULL,
    place character varying(128),
    commission_type character varying(128) NOT NULL,
    commission_percentage numeric(15,2) NOT NULL,
    location_arabic character varying(128),
    password character varying(128),
    delivery_availability character varying(128) NOT NULL,
    creator_id integer NOT NULL,
    location_id uuid NOT NULL,
    updater_id integer,
    user_id integer,
    zone_id bigint NOT NULL,
    CONSTRAINT vendors_vendor_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.vendors_vendor OWNER TO nexsme_live;

--
-- Name: vendors_vendor_deliverable_location; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.vendors_vendor_deliverable_location (
    id bigint NOT NULL,
    vendor_id uuid NOT NULL,
    zone_id bigint NOT NULL
);


ALTER TABLE public.vendors_vendor_deliverable_location OWNER TO nexsme_live;

--
-- Name: vendors_vendor_deliverable_location_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.vendors_vendor_deliverable_location_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vendors_vendor_deliverable_location_id_seq OWNER TO nexsme_live;

--
-- Name: vendors_vendor_deliverable_location_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.vendors_vendor_deliverable_location_id_seq OWNED BY public.vendors_vendor_deliverable_location.id;


--
-- Name: warehouse; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.warehouse (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    name character varying(128) NOT NULL,
    phone character varying(128) NOT NULL,
    address text NOT NULL,
    country character varying(128) NOT NULL,
    creator_id integer NOT NULL,
    location_id uuid NOT NULL,
    manager_id uuid,
    updater_id integer,
    zone_id bigint NOT NULL,
    CONSTRAINT warehouse_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.warehouse OWNER TO nexsme_live;

--
-- Name: warehouse_deliverable_location; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.warehouse_deliverable_location (
    id bigint NOT NULL,
    warehouse_id uuid NOT NULL,
    zone_id bigint NOT NULL
);


ALTER TABLE public.warehouse_deliverable_location OWNER TO nexsme_live;

--
-- Name: warehouse_deliverable_location_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.warehouse_deliverable_location_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.warehouse_deliverable_location_id_seq OWNER TO nexsme_live;

--
-- Name: warehouse_deliverable_location_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.warehouse_deliverable_location_id_seq OWNED BY public.warehouse_deliverable_location.id;


--
-- Name: warehouse_no_express_delivery; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.warehouse_no_express_delivery (
    id bigint NOT NULL,
    warehouse_id uuid NOT NULL,
    zone_id bigint NOT NULL
);


ALTER TABLE public.warehouse_no_express_delivery OWNER TO nexsme_live;

--
-- Name: warehouse_no_express_delivery_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.warehouse_no_express_delivery_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.warehouse_no_express_delivery_id_seq OWNER TO nexsme_live;

--
-- Name: warehouse_no_express_delivery_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.warehouse_no_express_delivery_id_seq OWNED BY public.warehouse_no_express_delivery.id;


--
-- Name: web_FeauturedCategory; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public."web_FeauturedCategory" (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    category_id uuid NOT NULL,
    creator_id integer NOT NULL,
    updater_id integer,
    CONSTRAINT "web_FeauturedCategory_auto_id_check" CHECK ((auto_id >= 0))
);


ALTER TABLE public."web_FeauturedCategory" OWNER TO nexsme_live;

--
-- Name: web_TrendingCategory; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public."web_TrendingCategory" (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    category_id uuid NOT NULL,
    creator_id integer NOT NULL,
    updater_id integer,
    CONSTRAINT "web_TrendingCategory_auto_id_check" CHECK ((auto_id >= 0))
);


ALTER TABLE public."web_TrendingCategory" OWNER TO nexsme_live;

--
-- Name: web_productreturn; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.web_productreturn (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    return_id text,
    reason_for_return character varying(256) NOT NULL,
    return_type character varying(256) NOT NULL,
    return_specification text,
    status character varying(100) NOT NULL,
    payment_status character varying(100) NOT NULL,
    agent_status character varying(256),
    rejected_reason text,
    agent_rejected_reason text,
    amount numeric(15,2) NOT NULL,
    is_same_product boolean NOT NULL,
    is_damaged_product boolean NOT NULL,
    is_same_quantity boolean NOT NULL,
    damaged_reason text,
    serial_status character varying(256),
    extra_notes text,
    customer_name character varying(50),
    customer_phone character varying(10),
    customer_street character varying(128),
    customer_landmark character varying(128),
    customer_latitude text,
    customer_longitude text,
    reached_image character varying(100),
    is_handover_required boolean NOT NULL,
    creator_id integer NOT NULL,
    customer_account_id uuid,
    customer_address_id uuid,
    delivery_boy_id uuid,
    order_id uuid NOT NULL,
    order_item_id uuid NOT NULL,
    updater_id integer,
    CONSTRAINT web_productreturn_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.web_productreturn OWNER TO nexsme_live;

--
-- Name: web_productreview; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.web_productreview (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    rating integer NOT NULL,
    review text,
    creator_id integer NOT NULL,
    product_variant_id uuid NOT NULL,
    updater_id integer,
    CONSTRAINT web_productreview_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.web_productreview OWNER TO nexsme_live;

--
-- Name: web_sociallinks; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.web_sociallinks (
    id bigint NOT NULL,
    facebook_link character varying(200) NOT NULL,
    instagram_link character varying(200) NOT NULL,
    twitter_link character varying(200) NOT NULL,
    whatsapp_link character varying(200) NOT NULL
);


ALTER TABLE public.web_sociallinks OWNER TO nexsme_live;

--
-- Name: web_sociallinks_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.web_sociallinks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.web_sociallinks_id_seq OWNER TO nexsme_live;

--
-- Name: web_sociallinks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.web_sociallinks_id_seq OWNED BY public.web_sociallinks.id;


--
-- Name: web_spotlightbanner; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.web_spotlightbanner (
    id uuid NOT NULL,
    auto_id integer NOT NULL,
    date_added timestamp with time zone NOT NULL,
    date_updated timestamp with time zone NOT NULL,
    is_deleted boolean NOT NULL,
    deleted_reason character varying(128),
    offer_type character varying(100),
    banner_type character varying(100) NOT NULL,
    image character varying(100) NOT NULL,
    brand_id uuid,
    category_id uuid,
    creator_id integer NOT NULL,
    product_variant_id uuid,
    updater_id integer,
    CONSTRAINT web_spotlightbanner_auto_id_check CHECK ((auto_id >= 0))
);


ALTER TABLE public.web_spotlightbanner OWNER TO nexsme_live;

--
-- Name: zone; Type: TABLE; Schema: public; Owner: nexsme_live
--

CREATE TABLE public.zone (
    id bigint NOT NULL,
    name character varying(256) NOT NULL,
    municipality character varying(256) NOT NULL,
    district character varying(256) NOT NULL,
    state character varying(128) NOT NULL,
    taluk character varying(128) NOT NULL,
    latitude character varying(128),
    longitude character varying(128),
    pincode integer NOT NULL,
    CONSTRAINT zone_pincode_check CHECK ((pincode >= 0))
);


ALTER TABLE public.zone OWNER TO nexsme_live;

--
-- Name: zone_id_seq; Type: SEQUENCE; Schema: public; Owner: nexsme_live
--

CREATE SEQUENCE public.zone_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.zone_id_seq OWNER TO nexsme_live;

--
-- Name: zone_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: nexsme_live
--

ALTER SEQUENCE public.zone_id_seq OWNED BY public.zone.id;


--
-- Name: app_update id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.app_update ALTER COLUMN id SET DEFAULT nextval('public.app_update_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: customers_userotpdata id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.customers_userotpdata ALTER COLUMN id SET DEFAULT nextval('public.customers_userotpdata_id_seq'::regclass);


--
-- Name: delivery_app_update id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.delivery_app_update ALTER COLUMN id SET DEFAULT nextval('public.delivery_app_update_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: fcm_django_fcmdevice id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.fcm_django_fcmdevice ALTER COLUMN id SET DEFAULT nextval('public.fcm_django_fcmdevice_id_seq'::regclass);


--
-- Name: finance_account_group id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_account_group ALTER COLUMN id SET DEFAULT nextval('public.finance_account_group_id_seq'::regclass);


--
-- Name: finance_account_head id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_account_head ALTER COLUMN id SET DEFAULT nextval('public.finance_account_head_id_seq'::regclass);


--
-- Name: mode id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.mode ALTER COLUMN id SET DEFAULT nextval('public.mode_id_seq'::regclass);


--
-- Name: offers_vouchercode_used_users id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.offers_vouchercode_used_users ALTER COLUMN id SET DEFAULT nextval('public.offers_vouchercode_used_users_id_seq'::regclass);


--
-- Name: permission id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.permission ALTER COLUMN id SET DEFAULT nextval('public.permission_id_seq'::regclass);


--
-- Name: privilege_point_history id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.privilege_point_history ALTER COLUMN id SET DEFAULT nextval('public.privilege_point_history_id_seq'::regclass);


--
-- Name: product_stock id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.product_stock ALTER COLUMN id SET DEFAULT nextval('public.product_stock_id_seq'::regclass);


--
-- Name: product_variation_type id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.product_variation_type ALTER COLUMN id SET DEFAULT nextval('public.product_variation_type_id_seq'::regclass);


--
-- Name: purchase_item id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase_item ALTER COLUMN id SET DEFAULT nextval('public.purchase_item_id_seq'::regclass);


--
-- Name: purchase_order_item id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase_order_item ALTER COLUMN id SET DEFAULT nextval('public.purchase_order_item_id_seq'::regclass);


--
-- Name: purchase_return_item id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase_return_item ALTER COLUMN id SET DEFAULT nextval('public.purchase_return_item_id_seq'::regclass);


--
-- Name: registration_registrationprofile id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.registration_registrationprofile ALTER COLUMN id SET DEFAULT nextval('public.registration_registrationprofile_id_seq'::regclass);


--
-- Name: sale_return_item id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.sale_return_item ALTER COLUMN id SET DEFAULT nextval('public.sale_return_item_id_seq'::regclass);


--
-- Name: sales_sale_item id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.sales_sale_item ALTER COLUMN id SET DEFAULT nextval('public.sales_sale_item_id_seq'::regclass);


--
-- Name: special_variant_product_variant id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.special_variant_product_variant ALTER COLUMN id SET DEFAULT nextval('public.special_variant_product_variant_id_seq'::regclass);


--
-- Name: staff_permission id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.staff_permission ALTER COLUMN id SET DEFAULT nextval('public.staff_permission_id_seq'::regclass);


--
-- Name: stock_update_item id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.stock_update_item ALTER COLUMN id SET DEFAULT nextval('public.stock_update_item_id_seq'::regclass);


--
-- Name: users_notification id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.users_notification ALTER COLUMN id SET DEFAULT nextval('public.users_notification_id_seq'::regclass);


--
-- Name: users_notification_subject id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.users_notification_subject ALTER COLUMN id SET DEFAULT nextval('public.users_notification_subject_id_seq'::regclass);


--
-- Name: vendors_commission id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.vendors_commission ALTER COLUMN id SET DEFAULT nextval('public.vendors_commission_id_seq'::regclass);


--
-- Name: vendors_vendor_deliverable_location id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.vendors_vendor_deliverable_location ALTER COLUMN id SET DEFAULT nextval('public.vendors_vendor_deliverable_location_id_seq'::regclass);


--
-- Name: warehouse_deliverable_location id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.warehouse_deliverable_location ALTER COLUMN id SET DEFAULT nextval('public.warehouse_deliverable_location_id_seq'::regclass);


--
-- Name: warehouse_no_express_delivery id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.warehouse_no_express_delivery ALTER COLUMN id SET DEFAULT nextval('public.warehouse_no_express_delivery_id_seq'::regclass);


--
-- Name: web_sociallinks id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.web_sociallinks ALTER COLUMN id SET DEFAULT nextval('public.web_sociallinks_id_seq'::regclass);


--
-- Name: zone id; Type: DEFAULT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.zone ALTER COLUMN id SET DEFAULT nextval('public.zone_id_seq'::regclass);


--
-- Data for Name: app_update; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.app_update (id, date_added, android_version, android_force_upgrade, android_recommended_upgrade, ios_version, ios_force_upgrade, ios_recommended_upgrade) FROM stdin;
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.auth_group (id, name) FROM stdin;
1	customer_user
2	vendor_user
3	supplier_user
4	delivery_agent
5	warehouse_manager
6	normal_staff
7	billing_staff
8	staff
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add registration profile	1	add_registrationprofile
2	Can change registration profile	1	change_registrationprofile
3	Can delete registration profile	1	delete_registrationprofile
4	Can view registration profile	1	view_registrationprofile
5	Can add supervised registration profile	2	add_supervisedregistrationprofile
6	Can change supervised registration profile	2	change_supervisedregistrationprofile
7	Can delete supervised registration profile	2	delete_supervisedregistrationprofile
8	Can view supervised registration profile	2	view_supervisedregistrationprofile
9	Can add FCM device	3	add_fcmdevice
10	Can change FCM device	3	change_fcmdevice
11	Can delete FCM device	3	delete_fcmdevice
12	Can view FCM device	3	view_fcmdevice
13	Can add log entry	4	add_logentry
14	Can change log entry	4	change_logentry
15	Can delete log entry	4	delete_logentry
16	Can view log entry	4	view_logentry
17	Can add permission	5	add_permission
18	Can change permission	5	change_permission
19	Can delete permission	5	delete_permission
20	Can view permission	5	view_permission
21	Can add group	6	add_group
22	Can change group	6	change_group
23	Can delete group	6	delete_group
24	Can view group	6	view_group
25	Can add user	7	add_user
26	Can change user	7	change_user
27	Can delete user	7	delete_user
28	Can view user	7	view_user
29	Can add content type	8	add_contenttype
30	Can change content type	8	change_contenttype
31	Can delete content type	8	delete_contenttype
32	Can view content type	8	view_contenttype
33	Can add session	9	add_session
34	Can change session	9	change_session
35	Can delete session	9	delete_session
36	Can view session	9	view_session
37	Can add App update	10	add_appupdate
38	Can change App update	10	change_appupdate
39	Can delete App update	10	delete_appupdate
40	Can view App update	10	view_appupdate
41	Can add Delivery Application Update	11	add_deliveryappupdate
42	Can change Delivery Application Update	11	change_deliveryappupdate
43	Can delete Delivery Application Update	11	delete_deliveryappupdate
44	Can view Delivery Application Update	11	view_deliveryappupdate
45	Can add mode	12	add_mode
46	Can change mode	12	change_mode
47	Can delete mode	12	delete_mode
48	Can view mode	12	view_mode
49	Can add setting	13	add_settings
50	Can change setting	13	change_settings
51	Can delete setting	13	delete_settings
52	Can view setting	13	view_settings
53	Can add notification subject	14	add_notificationsubject
54	Can change notification subject	14	change_notificationsubject
55	Can delete notification subject	14	delete_notificationsubject
56	Can view notification subject	14	view_notificationsubject
57	Can add permission	15	add_permission
58	Can change permission	15	change_permission
59	Can delete permission	15	delete_permission
60	Can view permission	15	view_permission
61	Can add wishlist item	16	add_wishlistitem
62	Can change wishlist item	16	change_wishlistitem
63	Can delete wishlist item	16	delete_wishlistitem
64	Can view wishlist item	16	view_wishlistitem
65	Can add user login	17	add_userlogin
66	Can change user login	17	change_userlogin
67	Can delete user login	17	delete_userlogin
68	Can view user login	17	view_userlogin
69	Can add Registration Profile	18	add_registrationprofile
70	Can change Registration Profile	18	change_registrationprofile
71	Can delete Registration Profile	18	delete_registrationprofile
72	Can view Registration Profile	18	view_registrationprofile
73	Can add notification	19	add_notification
74	Can change notification	19	change_notification
75	Can delete notification	19	delete_notification
76	Can view notification	19	view_notification
77	Can add cart item	20	add_cartitem
78	Can change cart item	20	change_cartitem
79	Can delete cart item	20	delete_cartitem
80	Can view cart item	20	view_cartitem
81	Can add brand	21	add_brand
82	Can change brand	21	change_brand
83	Can delete brand	21	delete_brand
84	Can view brand	21	view_brand
85	Can add category	22	add_category
86	Can change category	22	change_category
87	Can delete category	22	delete_category
88	Can view category	22	view_category
89	Can add product_hsn_code	23	add_hsncodes
90	Can change product_hsn_code	23	change_hsncodes
91	Can delete product_hsn_code	23	delete_hsncodes
92	Can view product_hsn_code	23	view_hsncodes
93	Can add product	24	add_product
94	Can change product	24	change_product
95	Can delete product	24	delete_product
96	Can view product	24	view_product
97	Can add product_image	25	add_productimages
98	Can change product_image	25	change_productimages
99	Can delete product_image	25	delete_productimages
100	Can view product_image	25	view_productimages
101	Can add product_stock	26	add_productstock
102	Can change product_stock	26	change_productstock
103	Can delete product_stock	26	delete_productstock
104	Can view product_stock	26	view_productstock
105	Can add product_variant	27	add_productvariant
106	Can change product_variant	27	change_productvariant
107	Can delete product_variant	27	delete_productvariant
108	Can view product_variant	27	view_productvariant
109	Can add Product variation Type	28	add_variationtype
110	Can change Product variation Type	28	change_variationtype
111	Can delete Product variation Type	28	delete_variationtype
112	Can view Product variation Type	28	view_variationtype
113	Can add Unit measurement	29	add_unitofmeasurement
114	Can change Unit measurement	29	change_unitofmeasurement
115	Can delete Unit measurement	29	delete_unitofmeasurement
116	Can view Unit measurement	29	view_unitofmeasurement
117	Can add Proudct unit	30	add_unit
118	Can change Proudct unit	30	change_unit
119	Can delete Proudct unit	30	delete_unit
120	Can view Proudct unit	30	view_unit
121	Can add Sub category	31	add_subcategory
122	Can change Sub category	31	change_subcategory
123	Can delete Sub category	31	delete_subcategory
124	Can view Sub category	31	view_subcategory
125	Can add Special Variant	32	add_specialvariant
126	Can change Special Variant	32	change_specialvariant
127	Can delete Special Variant	32	delete_specialvariant
128	Can view Special Variant	32	view_specialvariant
129	Can add Special Category	33	add_specialcategory
130	Can change Special Category	33	change_specialcategory
131	Can delete Special Category	33	delete_specialcategory
132	Can view Special Category	33	view_specialcategory
133	Can add Location	34	add_location
134	Can change Location	34	change_location
135	Can delete Location	34	delete_location
136	Can view Location	34	view_location
137	Can add Zone	35	add_zone
138	Can change Zone	35	change_zone
139	Can delete Zone	35	delete_zone
140	Can view Zone	35	view_zone
141	Can add Warehouse	36	add_warehouse
142	Can change Warehouse	36	change_warehouse
143	Can delete Warehouse	36	delete_warehouse
144	Can view Warehouse	36	view_warehouse
145	Can add designation	37	add_designation
146	Can change designation	37	change_designation
147	Can delete designation	37	delete_designation
148	Can view designation	37	view_designation
149	Can add salary_pay	38	add_pay
150	Can change salary_pay	38	change_pay
151	Can delete salary_pay	38	delete_pay
152	Can view salary_pay	38	view_pay
153	Can add Salary Allowance	39	add_salaryallowance
154	Can change Salary Allowance	39	change_salaryallowance
155	Can delete Salary Allowance	39	delete_salaryallowance
156	Can view Salary Allowance	39	view_salaryallowance
157	Can add staff	40	add_staff
158	Can change staff	40	change_staff
159	Can delete staff	40	delete_staff
160	Can view staff	40	view_staff
161	Can add Techpe staff record	41	add_staffrecord
162	Can change Techpe staff record	41	change_staffrecord
163	Can delete Techpe staff record	41	delete_staffrecord
164	Can view Techpe staff record	41	view_staffrecord
165	Can add staff_attendance	42	add_staffattendance
166	Can change staff_attendance	42	change_staffattendance
167	Can delete staff_attendance	42	delete_staffattendance
168	Can view staff_attendance	42	view_staffattendance
169	Can add sale	43	add_sale
170	Can change sale	43	change_sale
171	Can delete sale	43	delete_sale
172	Can view sale	43	view_sale
173	Can add sale item	44	add_saleitem
174	Can change sale item	44	change_saleitem
175	Can delete sale item	44	delete_saleitem
176	Can view sale item	44	view_saleitem
177	Can add sale return	45	add_salereturn
178	Can change sale return	45	change_salereturn
179	Can delete sale return	45	delete_salereturn
180	Can view sale return	45	view_salereturn
181	Can add sale return item	46	add_salereturnitem
182	Can change sale return item	46	change_salereturnitem
183	Can delete sale return item	46	delete_salereturnitem
184	Can view sale return item	46	view_salereturnitem
185	Can add Purchase	47	add_purchase
186	Can change Purchase	47	change_purchase
187	Can delete Purchase	47	delete_purchase
188	Can view Purchase	47	view_purchase
189	Can add Purchase Item	48	add_purchaseitem
190	Can change Purchase Item	48	change_purchaseitem
191	Can delete Purchase Item	48	delete_purchaseitem
192	Can view Purchase Item	48	view_purchaseitem
193	Can add Purchase Order	49	add_purchaseorder
194	Can change Purchase Order	49	change_purchaseorder
195	Can delete Purchase Order	49	delete_purchaseorder
196	Can view Purchase Order	49	view_purchaseorder
197	Can add Purchase Return	50	add_purchasereturn
198	Can change Purchase Return	50	change_purchasereturn
199	Can delete Purchase Return	50	delete_purchasereturn
200	Can view Purchase Return	50	view_purchasereturn
201	Can add Purchase Return Item	51	add_purchasereturnitem
202	Can change Purchase Return Item	51	change_purchasereturnitem
203	Can delete Purchase Return Item	51	delete_purchasereturnitem
204	Can view Purchase Return Item	51	view_purchasereturnitem
205	Can add Purchase Order Item	52	add_purchaseorderitem
206	Can change Purchase Order Item	52	change_purchaseorderitem
207	Can delete Purchase Order Item	52	delete_purchaseorderitem
208	Can view Purchase Order Item	52	view_purchaseorderitem
209	Can add customer	53	add_customer
210	Can change customer	53	change_customer
211	Can delete customer	53	delete_customer
212	Can view customer	53	view_customer
213	Can add customer bank account	54	add_customeraccount
214	Can change customer bank account	54	change_customeraccount
215	Can delete customer bank account	54	delete_customeraccount
216	Can view customer bank account	54	view_customeraccount
217	Can add OTP Record	55	add_userotpdata
218	Can change OTP Record	55	change_userotpdata
219	Can delete OTP Record	55	delete_userotpdata
220	Can view OTP Record	55	view_userotpdata
221	Can add ticket	56	add_ticket
222	Can change ticket	56	change_ticket
223	Can delete ticket	56	delete_ticket
224	Can view ticket	56	view_ticket
225	Can add Privilege Point History	57	add_privilegepointhistory
226	Can change Privilege Point History	57	change_privilegepointhistory
227	Can delete Privilege Point History	57	delete_privilegepointhistory
228	Can view Privilege Point History	57	view_privilegepointhistory
229	Can add privilege_point	58	add_privilegepoint
230	Can change privilege_point	58	change_privilegepoint
231	Can delete privilege_point	58	delete_privilegepoint
232	Can view privilege_point	58	view_privilegepoint
233	Can add customer address	59	add_customeraddress
234	Can change customer address	59	change_customeraddress
235	Can delete customer address	59	delete_customeraddress
236	Can view customer address	59	view_customeraddress
237	Can add vendor	60	add_vendor
238	Can change vendor	60	change_vendor
239	Can delete vendor	60	delete_vendor
240	Can view vendor	60	view_vendor
241	Can add Vendor Commission	61	add_vendorcommission
242	Can change Vendor Commission	61	change_vendorcommission
243	Can delete Vendor Commission	61	delete_vendorcommission
244	Can view Vendor Commission	61	view_vendorcommission
245	Can add supplier	62	add_supplier
246	Can change supplier	62	change_supplier
247	Can delete supplier	62	delete_supplier
248	Can view supplier	62	view_supplier
249	Can add Account Group	63	add_accountgroup
250	Can change Account Group	63	change_accountgroup
251	Can delete Account Group	63	delete_accountgroup
252	Can view Account Group	63	view_accountgroup
253	Can add Account Head	64	add_accounthead
254	Can change Account Head	64	change_accounthead
255	Can delete Account Head	64	delete_accounthead
256	Can view Account Head	64	view_accounthead
257	Can add Account Head Opening	65	add_accountheadopening
258	Can change Account Head Opening	65	change_accountheadopening
259	Can delete Account Head Opening	65	delete_accountheadopening
260	Can view Account Head Opening	65	view_accountheadopening
261	Can add Bank Account	66	add_bankaccount
262	Can change Bank Account	66	change_bankaccount
263	Can delete Bank Account	66	delete_bankaccount
264	Can view Bank Account	66	view_bankaccount
265	Can add Credit note Voucher	67	add_creditnotevoucher
266	Can change Credit note Voucher	67	change_creditnotevoucher
267	Can delete Credit note Voucher	67	delete_creditnotevoucher
268	Can view Credit note Voucher	67	view_creditnotevoucher
269	Can add Debit note Voucher	68	add_debitnotevoucher
270	Can change Debit note Voucher	68	change_debitnotevoucher
271	Can delete Debit note Voucher	68	delete_debitnotevoucher
272	Can view Debit note Voucher	68	view_debitnotevoucher
273	Can add Financial Year	69	add_financialyear
274	Can change Financial Year	69	change_financialyear
275	Can delete Financial Year	69	delete_financialyear
276	Can view Financial Year	69	view_financialyear
277	Can add Invoice Prefix	70	add_invoiceprefix
278	Can change Invoice Prefix	70	change_invoiceprefix
279	Can delete Invoice Prefix	70	delete_invoiceprefix
280	Can view Invoice Prefix	70	view_invoiceprefix
281	Can add Journal Voucher	71	add_journalvoucher
282	Can change Journal Voucher	71	change_journalvoucher
283	Can delete Journal Voucher	71	delete_journalvoucher
284	Can view Journal Voucher	71	view_journalvoucher
285	Can add Journal Voucher Item	72	add_journalvoucheritem
286	Can change Journal Voucher Item	72	change_journalvoucheritem
287	Can delete Journal Voucher Item	72	delete_journalvoucheritem
288	Can view Journal Voucher Item	72	view_journalvoucheritem
289	Can add Payment Voucher	73	add_paymentvoucher
290	Can change Payment Voucher	73	change_paymentvoucher
291	Can delete Payment Voucher	73	delete_paymentvoucher
292	Can view Payment Voucher	73	view_paymentvoucher
293	Can add Subledger Opening	74	add_subledgeropening
294	Can change Subledger Opening	74	change_subledgeropening
295	Can delete Subledger Opening	74	delete_subledgeropening
296	Can view Subledger Opening	74	view_subledgeropening
297	Can add Receipt Voucher	75	add_receiptvoucher
298	Can change Receipt Voucher	75	change_receiptvoucher
299	Can delete Receipt Voucher	75	delete_receiptvoucher
300	Can view Receipt Voucher	75	view_receiptvoucher
301	Can add booking	76	add_booking
302	Can change booking	76	change_booking
303	Can delete booking	76	delete_booking
304	Can view booking	76	view_booking
305	Can add order item	77	add_orderitem
306	Can change order item	77	change_orderitem
307	Can delete order item	77	delete_orderitem
308	Can view order item	77	view_orderitem
309	Can add time slot	78	add_timeslot
310	Can change time slot	78	change_timeslot
311	Can delete time slot	78	delete_timeslot
312	Can view time slot	78	view_timeslot
313	Can add Order	79	add_orders
314	Can change Order	79	change_orders
315	Can delete Order	79	delete_orders
316	Can view Order	79	view_orders
317	Can add product return	80	add_productreturn
318	Can change product return	80	change_productreturn
319	Can delete product return	80	delete_productreturn
320	Can view product return	80	view_productreturn
321	Can add social links	81	add_sociallinks
322	Can change social links	81	change_sociallinks
323	Can delete social links	81	delete_sociallinks
324	Can view social links	81	view_sociallinks
325	Can add Trending Category	82	add_trendingcategory
326	Can change Trending Category	82	change_trendingcategory
327	Can delete Trending Category	82	delete_trendingcategory
328	Can view Trending Category	82	view_trendingcategory
329	Can add spotlight banner	83	add_spotlightbanner
330	Can change spotlight banner	83	change_spotlightbanner
331	Can delete spotlight banner	83	delete_spotlightbanner
332	Can view spotlight banner	83	view_spotlightbanner
333	Can add Return image	84	add_returnimage
334	Can change Return image	84	change_returnimage
335	Can delete Return image	84	delete_returnimage
336	Can view Return image	84	view_returnimage
337	Can add review	85	add_productreview
338	Can change review	85	change_productreview
339	Can delete review	85	delete_productreview
340	Can view review	85	view_productreview
341	Can add Feautured Category	86	add_feauturedcategory
342	Can change Feautured Category	86	change_feauturedcategory
343	Can delete Feautured Category	86	delete_feauturedcategory
344	Can view Feautured Category	86	view_feauturedcategory
345	Can add deal_of_day	87	add_dealofday
346	Can change deal_of_day	87	change_dealofday
347	Can delete deal_of_day	87	delete_dealofday
348	Can view deal_of_day	87	view_dealofday
349	Can add offer	88	add_offers
350	Can change offer	88	change_offers
351	Can delete offer	88	delete_offers
352	Can view offer	88	view_offers
353	Can add voucher code	89	add_vouchercode
354	Can change voucher code	89	change_vouchercode
355	Can delete voucher code	89	delete_vouchercode
356	Can view voucher code	89	view_vouchercode
357	Can add collected payment register	90	add_collectedpaymentregister
358	Can change collected payment register	90	change_collectedpaymentregister
359	Can delete collected payment register	90	delete_collectedpaymentregister
360	Can view collected payment register	90	view_collectedpaymentregister
361	Can add collected payment	91	add_collectpayment
362	Can change collected payment	91	change_collectpayment
363	Can delete collected payment	91	delete_collectpayment
364	Can view collected payment	91	view_collectpayment
365	Can add delivery agent	92	add_deliveryagents
366	Can change delivery agent	92	change_deliveryagents
367	Can delete delivery agent	92	delete_deliveryagents
368	Can view delivery agent	92	view_deliveryagents
369	Can add delivery agent location	93	add_deliveryagenttravel
370	Can change delivery agent location	93	change_deliveryagenttravel
371	Can delete delivery agent location	93	delete_deliveryagenttravel
372	Can view delivery agent location	93	view_deliveryagenttravel
373	Can add delivery agent trip	94	add_deliveryagenttrip
374	Can change delivery agent trip	94	change_deliveryagenttrip
375	Can delete delivery agent trip	94	delete_deliveryagenttrip
376	Can view delivery agent trip	94	view_deliveryagenttrip
377	Can add rating	95	add_deliveryrating
378	Can change rating	95	change_deliveryrating
379	Can delete rating	95	delete_deliveryrating
380	Can view rating	95	view_deliveryrating
381	Can add general_batch	96	add_batch
382	Can change general_batch	96	change_batch
383	Can delete general_batch	96	delete_batch
384	Can view general_batch	96	view_batch
385	Can add charge per kilometer	97	add_chargeperkilometer
386	Can change charge per kilometer	97	change_chargeperkilometer
387	Can delete charge per kilometer	97	delete_chargeperkilometer
388	Can view charge per kilometer	97	view_chargeperkilometer
389	Can add Charge Setting	98	add_chargesetting
390	Can change Charge Setting	98	change_chargesetting
391	Can delete Charge Setting	98	delete_chargesetting
392	Can view Charge Setting	98	view_chargesetting
393	Can add Damaged Product	99	add_damagedproducts
394	Can change Damaged Product	99	change_damagedproducts
395	Can delete Damaged Product	99	delete_damagedproducts
396	Can view Damaged Product	99	view_damagedproducts
397	Can add Delivery Charge	100	add_deliverycharge
398	Can change Delivery Charge	100	change_deliverycharge
399	Can delete Delivery Charge	100	delete_deliverycharge
400	Can view Delivery Charge	100	view_deliverycharge
401	Can add Invoice Design	101	add_invoicedesign
402	Can change Invoice Design	101	change_invoicedesign
403	Can delete Invoice Design	101	delete_invoicedesign
404	Can view Invoice Design	101	view_invoicedesign
405	Can add stock_transfer	102	add_stocktransfer
406	Can change stock_transfer	102	change_stocktransfer
407	Can delete stock_transfer	102	delete_stocktransfer
408	Can view stock_transfer	102	view_stocktransfer
409	Can add stock_transfer_item	103	add_stocktransferitem
410	Can change stock_transfer_item	103	change_stocktransferitem
411	Can delete stock_transfer_item	103	delete_stocktransferitem
412	Can view stock_transfer_item	103	view_stocktransferitem
413	Can add stock_update	104	add_stockupdate
414	Can change stock_update	104	change_stockupdate
415	Can delete stock_update	104	delete_stockupdate
416	Can view stock_update	104	view_stockupdate
417	Can add stock_update_item	105	add_stockupdateitem
418	Can change stock_update_item	105	change_stockupdateitem
419	Can delete stock_update_item	105	delete_stockupdateitem
420	Can view stock_update_item	105	view_stockupdateitem
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
2	pbkdf2_sha256$260000$FvzuM0Wg5DgmHQGX5qEOr7$HyDLaUB/7P+v8fwsVGQ+/BVua8myPEXG97tD1zZE2T4=	\N	f	8768768761				f	t	2024-07-10 06:50:43.112291+00
4	pbkdf2_sha256$260000$6Jj4O1rb3QQCde5PHoGY2Q$tuiHr4Cuor2NwmzfTLDYcmwMxb+FTbq3iT4TOblCHLM=	2025-03-13 19:20:44.075787+00	f	ARAFAMOBILES				f	t	2024-07-18 09:40:46+00
3	pbkdf2_sha256$260000$QGZWD4BkrUZ2pB4iFJwYyg$TA/ojvj+pOTnyai7wYRkIImUrOwxrSEDhucAZjNR/nY=	2025-03-17 14:57:05.771231+00	f	ABHINAYA			abhiabhinaya92@gmail.com	f	t	2024-07-17 12:48:54+00
16	pbkdf2_sha256$260000$f2O4CPLZ2di0r465ZuJBEi$YFhtjALJFbiUl2BiyeTCTK0THiAehc47TDSssvU1Nu0=	\N	f	9876345678			a@example.com	f	f	2025-04-03 07:31:57.519426+00
5	pbkdf2_sha256$260000$c1xQ31SyWkVIQuzrvNMy4w$xAugWlTeMpnXxGSQFmHER4NsvwkCRwgR89V3ew6bb3c=	2025-08-27 15:20:22.578259+00	f	9745212222			riyasnizarudheen@gmail.com	f	t	2024-07-18 14:50:10.310495+00
6	pbkdf2_sha256$260000$ufBshmbpnekWM6GSXFHuna$WQluuVIaQDa/uozjRsqGkkKwWBlxuwG5Dwh44uVuVPk=	\N	f	9605788656			yaseen@tegain.com	f	f	2024-07-19 05:44:51.775981+00
7	pbkdf2_sha256$260000$FttGxXYg1qs9JJaLERFofu$B6+lu2I9ALWhfuiSwmSQ2zKbx4OClMCfKLC5VQbpZDc=	\N	f	9746880016				f	t	2024-07-19 07:01:20.067323+00
8	pbkdf2_sha256$260000$ChYGhM11rmzEDCQx2tydVN$/Thp6dZqE4fF4SwxfuUQGNIzqYncSO6Tim8D/6heyG4=	\N	f	7510805488			rameesfr66@gmial.com	f	t	2024-07-19 11:02:19.81164+00
17	pbkdf2_sha256$260000$gjGZQ8XTiDU1N2JspkivQj$vsK+yWAXKXFMNO/P9nXsAoBCiKpoR46zLB58i3HMBtk=	2025-05-06 11:31:27.217571+00	f	Arafa@12				f	t	2025-05-06 11:20:03.395936+00
9	pbkdf2_sha256$260000$AZdKzdU0r4ES6whdZTmSYN$kgkA0xi+uKddpQIWVgKSYeycAvEPVppCWVjT/z9BI5A=	\N	f	8765432100				f	t	2024-07-28 05:50:54.136323+00
10	pbkdf2_sha256$260000$ciQ0ROZugEWmqVMR3eqoTA$+aolH/PJL0RIjr7O6vvTxpW8tb1URcgNExz8fuLjWJM=	\N	f	6238144282				f	t	2024-08-21 09:30:48.151367+00
11	pbkdf2_sha256$260000$OLYKZPK5EQlgsEOXweUZfl$MJBIcsIZBSlOJU2LwlTvYQC2zfdHRQtH2SytdhyjRQQ=	\N	f	9633851399				f	t	2024-08-21 10:00:04.810985+00
12	pbkdf2_sha256$260000$snyF2kvq2Mtd5qYdYH8OhR$cczkkTHitDiCbfhuLgM9UOcJTxPOLtyEM0iGIadTrBQ=	2024-10-06 09:06:24.611487+00	f	7594818072			amanniyas007@gmail.com	f	t	2024-10-06 09:06:13.351559+00
13	pbkdf2_sha256$260000$FOf7TC7OGADFPvYUUXP62F$Khx509MFh9edd8ahsa5RRQcZpKxCf1UEPFQ7PnJjZxE=	\N	f	7356004584				f	t	2024-10-24 08:46:26.337412+00
1	pbkdf2_sha256$260000$EIfpfrykGTzvGSoCzfwVbI$Ltt0z+4ykQL3AjMTi02b6tjHhlm2dRq8QqxgFDsDvYI=	2026-01-06 09:28:59.595459+00	t	nexsme-admin				t	t	2024-07-10 05:57:51.995509+00
14	pbkdf2_sha256$260000$IUqkAwmsJRvSFBtnvAkdwA$aI+CaN0Ye+nch4xSkJsl4wuvOCHb31ERksiSgc/hiqc=	2024-10-25 10:11:22.513066+00	f	MUNEER1			muneerchunkzz@gmail.com	f	t	2024-10-25 09:58:22.604104+00
15	pbkdf2_sha256$260000$VbrV5nCaTjcNmmQfqdtkq0$jAFG9xhOCD+T7s721XHVIbS6BY8HESyd9tIlC2++5D4=	2024-11-09 15:03:49.726522+00	f	arafa_admin				f	t	2024-11-09 15:02:17.96277+00
18	pbkdf2_sha256$260000$YtRqwLulllf3ntp72J6iVe$2R+/sbORCRX8wretHAkYeLbeBr4YxcYZVSS3YThRb0w=	2025-07-17 16:02:07.1268+00	f	SARATH			sarathsasanka@gmail.com	f	t	2025-07-17 16:00:14.51291+00
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
1	2	4
2	3	7
3	3	8
4	4	2
5	4	8
6	5	1
7	6	1
10	7	1
11	8	4
12	9	1
13	10	1
14	11	1
15	12	1
16	13	1
17	14	5
18	15	2
19	16	1
20	17	2
21	18	5
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: customer_bank_account; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.customer_bank_account (id, date_added, is_deleted, bank_name, account_number, account_holder, swift_code, branch, iban, customer_id) FROM stdin;
\.


--
-- Data for Name: customers_customer; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.customers_customer (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, name, phone, email, gst_number, country, state, house, building, street, opening_type, opening_balance, current_balance, current_privilege_points, privilege_points, image, is_web_registered, creator_id, updater_id, user_id) FROM stdin;
338ef566-78a3-40cc-95e4-551ea5f8f46d	2	2024-07-19 05:44:51.949406+00	2024-07-19 05:44:51.949435+00	f	\N	yaseen Talrop	9605788656	yaseen@tegain.com	\N	India	\N	\N	\N	\N	debit	0.00	0.00	0	0		t	6	6	6
8b088dbe-d285-4102-af99-99458874e155	3	2024-07-19 07:01:20.275237+00	2024-07-19 07:01:20.27527+00	f	\N	guest_9746880016	9746880016	\N	\N	India	\N	\N	\N	\N	debit	0.00	0.00	0	0		f	7	7	7
228854d7-8247-40b9-9ed1-9e46486133ca	4	2024-07-28 05:50:54.306439+00	2024-07-28 05:50:54.306463+00	f	\N	guest_8765432100	8765432100	\N	\N	India	\N	\N	\N	\N	debit	0.00	0.00	0	0		f	9	9	9
52a91ff2-766b-4273-aa8d-04fd1506fda4	5	2024-08-21 09:30:48.437323+00	2024-08-21 09:30:48.437352+00	f	\N	Mahadev	6238144282	rmahadev2005@gmail.com	\N	India	\N	\N	\N	\N	debit	0.00	0.00	0	0		f	10	10	10
d07c6743-c976-4227-9148-e1c9b0e6d6a5	6	2024-08-21 10:00:04.967923+00	2024-08-21 10:00:04.967947+00	f	\N	guest_9633851399	9633851399	\N	\N	India	\N	\N	\N	\N	debit	0.00	0.00	0	0		f	11	11	11
37f01573-c73c-4a29-8188-adff1d6b92de	8	2024-10-24 08:46:26.507188+00	2024-10-24 08:46:26.50722+00	f	\N	thansih	7356004584	amanmniyas@gmail.com	\N	India	\N	\N	\N	\N	debit	0.00	0.00	0	0		f	13	13	13
29e61444-5029-4b31-a751-598c2df7a502	10	2025-04-03 07:31:57.931981+00	2025-04-03 07:31:57.932012+00	f	\N	Ameen	9876345678	a@example.com	\N	India	\N	\N	\N	\N	debit	0.00	-195.00	0	0		t	16	16	16
c6488465-a403-4642-92ce-210e51956062	7	2024-10-06 09:06:13.774927+00	2024-10-06 09:06:13.774953+00	f	\N	Ismail	7594818072	amanniyas007@gmail.com	\N	India	\N	\N	\N	\N	debit	0.00	-120.00	0	0		t	12	12	12
0ca5eb0b-1bf8-48ee-b11c-f1fa306e36c1	9	2025-02-06 09:54:35.857152+00	2025-02-06 09:54:35.857175+00	f	\N	Default Customer		\N	\N	India	\N	\N	\N	\N	debit	0.00	0.00	0	0		f	1	1	\N
760a809a-b409-44bf-83cb-79f76762cece	1	2024-07-18 14:50:10.492809+00	2024-07-18 14:50:10.49283+00	f	\N	Riyas	9745212222	riyasnizarudheen@gmail.com	\N	India	\N	\N	\N	\N	debit	0.00	9905.00	0	0	customers/images/photo.jpeg	t	5	5	5
\.


--
-- Data for Name: customers_customeraddress; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.customers_customeraddress (id, date_added, is_deleted, address_type, name, phone, email, house_name, street, city, landmark, state, is_default, customer_id, location_id, zone_id) FROM stdin;
7049ca33-d3e4-4f44-8d42-d18deb8320f4	2024-07-25 07:09:19.69837+00	f	10	yaseen Talrop	9605788656	yaseen@tegain.com	tegain	talrop	\N	Talrop	Kerala	f	338ef566-78a3-40cc-95e4-551ea5f8f46d	cf9cc45a-2598-46bd-aace-3b67ef8ac152	4950
859f948e-4294-4349-86f4-42aeaf5b2baa	2024-10-28 10:28:39.926786+00	f	10	Thanish	9387475212	\N	12	23	\N	\N	Kerala	f	37f01573-c73c-4a29-8188-adff1d6b92de	08c0e367-36cf-4c0c-b83c-c0d67e55ca37	3
aff9991f-d278-42e2-ba7e-61cd40c674c9	2024-10-28 10:28:40.438387+00	f	10	Thanish	9387475212	\N	12	23	\N	\N	Kerala	t	37f01573-c73c-4a29-8188-adff1d6b92de	08c0e367-36cf-4c0c-b83c-c0d67e55ca37	3
ff02624a-ed30-40a1-b9c7-da441415f48c	2025-03-17 13:52:53.589344+00	f	10	Ismail	7594818072	amanniyas007@gmail.com	ASA	PLD	\N	\N	Kerala	f	c6488465-a403-4642-92ce-210e51956062	8bd02c8b-d385-4aad-bfcb-93ef33c10a1e	4859
07fa1bcb-7d90-435e-a5ef-d17230b2d034	2024-10-25 12:33:51.946183+00	t	10	Riyas	9745212222	\N	12	12	\N	\N	Kerala	f	760a809a-b409-44bf-83cb-79f76762cece	08c0e367-36cf-4c0c-b83c-c0d67e55ca37	4950
f06b2abe-9cfa-45b0-bf65-37a514bfcb8b	2024-11-01 14:24:52.374879+00	f	10	Riyas	9745020163	\N	111	123	\N	\N	Kerala	t	760a809a-b409-44bf-83cb-79f76762cece	08c0e367-36cf-4c0c-b83c-c0d67e55ca37	4859
\.


--
-- Data for Name: customers_userotpdata; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.customers_userotpdata (id, name, phone, otp, attempts, resend_otp_index, is_deleted, password) FROM stdin;
2	yaseen Talrop	9605788656	1355	1	f	f	gAAAAABmmf1TipYVk7ATssgTwUGswMYIS746iENSWDy2GgZUsA27IN5Ur1NxPOtZIrWAq0Iongz9nGij8a1hHoAFhlmwCt1RSw==
3	9746880016	9746880016	9053	1	f	f	gAAAAABmmg9A9u2QnljPaUF-_cafotcGlQOAi2f5MrpjR4PeorH5VicxJ1GGpDPI1_Aw79KpJKySp2SWmi-wANiHhkUybb1zPw==
9	Ameen	9876345678	7403	1	f	f	gAAAAABn7jltR4tbCv6LkJEVdtwFbfv6MdaTi3eiF7OAPAg3lzXb82WMu-bzW5U9FRXBugDQe7oX8-qPCXMmpmqnk2s-y-tbrg==
5	6238144282	6238144282	7783	1	f	f	gAAAAABmxbPIzy-bTL634sqADSqbSZWIfH_MM8LhNq2Aoe1OTQ_GHKSI5hNRn3GLfDUttRMXA7p6fPhZAQF4oXn9ylwyg_VFWw==
6	9633851399	9633851399	2670	1	f	f	gAAAAABmxbqko3MOtBOo3LvQ185YpCeLjcBnWtpt7Ff33wQriOhIWhcCU89d0k9jLYWK918WJEfJbrrxWnxEWitA_Z_U1FqBWw==
7	Ismail	7594818072	2790	1	f	f	gAAAAABnAlMFYeeOnbHlhlwm_upTNpjPnjJAfnOTG5xzs0t2NPmWol4Vqo6e-j_xZfELPLlfBtVaMmeLVX8tTz3uTuSKU6s_eQ==
8	7356004584	7356004584	7277	1	f	f	gAAAAABnGgli_R9AKFpulqiYcNGootpxtiMoED1ji6AnzGUEIDQf0sExdvtnxUu5lJZllO2t6NVsCQPHkyJu5sLamJIJ_sDOuA==
4	8765432100	8765432100	1234	1	f	f	gAAAAABmpdw-VS8jC5NY-TP8rYzOAMq2HV0Hmw97LpcR0QIRlcAr3EwzBdeYmMo7FKxKfSIKmPBW_eD2Pyy1zLQMKoFv_U474Q==
1	Riyas	9745212222	9056	1	f	f	gAAAAABmmSuivsJ0P5iStWCjD_TeSoQf6u2kK6DHus_YKwVyF7nPWuv2PqdTgEmhW6nG25PHLqwSzqj7M1I1kHVOKfNYsJtyXQ==
\.


--
-- Data for Name: deal_of_day; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.deal_of_day (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, offer_percentage, deal_date, creator_id, product_variant_id, updater_id, warehouse_id) FROM stdin;
d65f0c2f-aecb-433b-b27b-dc1bf69a57a4	1	2024-07-18 15:59:34.097946+00	2024-07-18 15:59:49.252134+00	f	\N	50.00	2024-07-18	1	fb3ae593-aa0f-4650-82f4-2024299ac010	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
\.


--
-- Data for Name: delivery_agent_collectedpaymentregister; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.delivery_agent_collectedpaymentregister (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, collected_payments, collected_amount, is_approved, is_declined, declined_reason, payment_medium, image, creator_id, delivery_agent_id, updater_id) FROM stdin;
\.


--
-- Data for Name: delivery_agent_collectpayment; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.delivery_agent_collectpayment (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, name, collected_amount, is_transferred, creator_id, delivery_agent_id, order_id, updater_id) FROM stdin;
\.


--
-- Data for Name: delivery_agent_delivery_agent; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.delivery_agent_delivery_agent (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, name, phone1, phone2, email, password, active_time, is_active, image, id_proof, license, license_expiry_date, company_id, company_id_expiry_date, creator_id, updater_id, user_id, warehouse_id) FROM stdin;
b76e6884-bfec-49d9-ac6e-3a867ae40408	1	2024-07-19 11:02:20.027551+00	2025-03-17 14:13:30.323204+00	f	\N	RAMEES	7510805488	\N	rameesfr66@gmial.com	gAAAAABmmke8Wt-AoB8FNVYeYR8gdn1Wtmd2h9Nwqb4MPiA3Q0Qh4rv1VX3hB8JNb0cbFrf5r22Wy6A9k6F8wMDaOxI4aSh8Iw==	2025-09-03 15:25:23.843527+00	f	customers/images/photo	delivery_agents/proofs/ramees_adh.jpeg	delivery_agents/proofs/license/license_back.jpeg	2041-11-02	delivery_agents/proofs/company_id/ramees_license.jpeg	2026-01-31	1	1	8	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
\.


--
-- Data for Name: delivery_agent_deliveryrating; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.delivery_agent_deliveryrating (id, date_added, is_deleted, rating, customer_id, delivery_agent_id, order_id) FROM stdin;
\.


--
-- Data for Name: delivery_agent_travel; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.delivery_agent_travel (id, date_added, is_deleted, origin_latitude, origin_longitude, pickup_latitude, pickup_longitude, delivery_latitude, delivery_longitude, pickup_distance, delivery_distance, pickup_distance_text, delivery_distance_text, delivery_agent_id, delivery_trip_id, order_id) FROM stdin;
ef1fa0d9-9763-43d0-b304-448dcba980c8	2024-07-25 07:19:53.536359+00	f	\N	\N	\N	\N	\N	\N	0.00	0.00	\N	\N	b76e6884-bfec-49d9-ac6e-3a867ae40408	\N	fb59dc79-6346-4131-a487-6facd520deb1
65f32bd4-3422-44b1-8a55-f857c2f006c3	2024-11-01 14:27:09.851478+00	f	\N	\N	\N	\N	\N	\N	0.00	0.00	\N	\N	b76e6884-bfec-49d9-ac6e-3a867ae40408	\N	a9865e0d-efd2-4cda-b506-38745c4b964f
2140bd28-594a-4dfd-8ba5-7853def934d4	2024-11-01 14:40:42.669113+00	f	\N	\N	\N	\N	\N	\N	0.00	0.00	\N	\N	b76e6884-bfec-49d9-ac6e-3a867ae40408	\N	857bb7ad-fdaa-4dfc-b267-d7f152caad6a
75520d10-bcd8-4730-bd70-06623e3f0de8	2025-03-17 13:57:12.705529+00	f	\N	\N	\N	\N	\N	\N	0.00	0.00	\N	\N	b76e6884-bfec-49d9-ac6e-3a867ae40408	\N	7aad7a57-fa87-43da-9169-705f79c3761d
17e45142-5d58-4e1e-a5b1-177773b871b0	2025-03-17 14:14:22.755693+00	f	\N	\N	\N	\N	\N	\N	0.00	0.00	\N	\N	b76e6884-bfec-49d9-ac6e-3a867ae40408	\N	114ae1a5-b78a-43bc-a0f9-e96344ae3de7
a4ebff03-7db8-43d8-a94d-11bf24d1c1fd	2025-04-02 11:21:59.591223+00	f	\N	\N	\N	\N	\N	\N	0.00	0.00	\N	\N	b76e6884-bfec-49d9-ac6e-3a867ae40408	\N	19f84703-0c42-401a-af84-0f433b9e654a
d725ad8b-295c-4c29-b3c1-5d8d471674a8	2025-04-02 12:44:16.302294+00	f	\N	\N	\N	\N	\N	\N	0.00	0.00	\N	\N	b76e6884-bfec-49d9-ac6e-3a867ae40408	\N	e18a0c3d-2b62-4bdb-b12f-8ab0c16c7a7d
31cbedc9-6f49-499f-a2c5-e9ee12132e98	2025-07-09 17:11:26.636871+00	f	\N	\N	\N	\N	\N	\N	0.00	0.00	\N	\N	b76e6884-bfec-49d9-ac6e-3a867ae40408	\N	a8efc206-054e-4673-a530-2058b017e3f4
85240e5b-e622-4797-ba39-cf0eaeb9804d	2025-07-09 17:24:22.248328+00	f	\N	\N	\N	\N	\N	\N	0.00	0.00	\N	\N	b76e6884-bfec-49d9-ac6e-3a867ae40408	\N	86271658-4301-4a08-9d00-32e2d535467a
cedb4aa3-05de-4032-a8bd-c7e712ab091b	2025-08-23 12:31:07.857261+00	f	\N	\N	\N	\N	\N	\N	0.00	0.00	\N	\N	b76e6884-bfec-49d9-ac6e-3a867ae40408	\N	9f9474eb-3469-445a-9fd5-e5204c0d5779
02e4ab6f-2eef-472e-b0a1-be6203911e7c	2025-08-23 12:41:33.075177+00	f	\N	\N	\N	\N	\N	\N	0.00	0.00	\N	\N	b76e6884-bfec-49d9-ac6e-3a867ae40408	\N	f2bee48f-c828-40be-9440-dc323d0ebec6
\.


--
-- Data for Name: delivery_agent_trip; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.delivery_agent_trip (id, date_added, is_deleted, title, start_time, end_time, distance_covered, distance_covered_text, is_active, delivery_agent_id) FROM stdin;
cb395ecf-414c-4a5f-ae44-00b712b1393c	2024-07-25 07:20:13.052615+00	f	TRIPID07252024125013	2024-07-25 07:20:13.052664+00	\N	0	\N	t	b76e6884-bfec-49d9-ac6e-3a867ae40408
\.


--
-- Data for Name: delivery_app_update; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.delivery_app_update (id, date_added, android_version, android_force_upgrade, android_recommended_upgrade, ios_version, ios_force_upgrade, ios_recommended_upgrade) FROM stdin;
\.


--
-- Data for Name: designation; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.designation (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, name, creator_id, updater_id) FROM stdin;
178d9864-307d-4c13-9927-430caa2924ce	3	2024-07-17 12:07:42.5116+00	2024-07-17 12:07:42.511623+00	f	\N	Operation Manager	1	1
12b639a8-b1e1-4c1f-ac68-f83ff9e8358e	2	2024-07-17 12:07:01.968775+00	2024-07-17 12:07:01.968803+00	t	WR	Om	1	1
55f228a2-0780-4c98-a774-c7e157699bb0	1	2024-07-17 12:03:24.287927+00	2024-07-17 12:03:24.287966+00	t	WR	Cro	1	1
cb07fbe8-eba6-4799-bdc9-984dca72fa27	4	2024-10-25 15:07:14.901036+00	2024-10-25 15:07:14.901069+00	t	s	aa	1	1
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2024-07-10 09:24:28.067781+00	d2cdeb5b-b371-4b07-9b61-5887797465d1	Test Warehouse will be deleted	3		36	1
2	2024-07-18 08:58:24.039226+00	8	staff	1	[{"added": {}}]	6	1
3	2024-07-18 08:59:37.744115+00	3	ABHINAYA	2	[]	7	1
4	2024-07-18 09:00:42.95636+00	3	ABHINAYA	2	[{"changed": {"fields": ["Groups"]}}]	7	1
5	2024-07-18 09:54:20.682178+00	4	ARAFAMOBILES	2	[{"changed": {"fields": ["Groups"]}}]	7	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	registration	registrationprofile
2	registration	supervisedregistrationprofile
3	fcm_django	fcmdevice
4	admin	logentry
5	auth	permission
6	auth	group
7	auth	user
8	contenttypes	contenttype
9	sessions	session
10	main	appupdate
11	main	deliveryappupdate
12	main	mode
13	main	settings
14	users	notificationsubject
15	users	permission
16	users	wishlistitem
17	users	userlogin
18	users	registrationprofile
19	users	notification
20	users	cartitem
21	products	brand
22	products	category
23	products	hsncodes
24	products	product
25	products	productimages
26	products	productstock
27	products	productvariant
28	products	variationtype
29	products	unitofmeasurement
30	products	unit
31	products	subcategory
32	products	specialvariant
33	products	specialcategory
34	warehouses	location
35	warehouses	zone
36	warehouses	warehouse
37	staffs	designation
38	staffs	pay
39	staffs	salaryallowance
40	staffs	staff
41	staffs	staffrecord
42	staffs	staffattendance
43	sales	sale
44	sales	saleitem
45	sales	salereturn
46	sales	salereturnitem
47	purchases	purchase
48	purchases	purchaseitem
49	purchases	purchaseorder
50	purchases	purchasereturn
51	purchases	purchasereturnitem
52	purchases	purchaseorderitem
53	customers	customer
54	customers	customeraccount
55	customers	userotpdata
56	customers	ticket
57	customers	privilegepointhistory
58	customers	privilegepoint
59	customers	customeraddress
60	vendors	vendor
61	vendors	vendorcommission
62	suppliers	supplier
63	finance	accountgroup
64	finance	accounthead
65	finance	accountheadopening
66	finance	bankaccount
67	finance	creditnotevoucher
68	finance	debitnotevoucher
69	finance	financialyear
70	finance	invoiceprefix
71	finance	journalvoucher
72	finance	journalvoucheritem
73	finance	paymentvoucher
74	finance	subledgeropening
75	finance	receiptvoucher
76	orders	booking
77	orders	orderitem
78	orders	timeslot
79	orders	orders
80	web	productreturn
81	web	sociallinks
82	web	trendingcategory
83	web	spotlightbanner
84	web	returnimage
85	web	productreview
86	web	feauturedcategory
87	offers	dealofday
88	offers	offers
89	offers	vouchercode
90	delivery_agent	collectedpaymentregister
91	delivery_agent	collectpayment
92	delivery_agent	deliveryagents
93	delivery_agent	deliveryagenttravel
94	delivery_agent	deliveryagenttrip
95	delivery_agent	deliveryrating
96	general	batch
97	general	chargeperkilometer
98	general	chargesetting
99	general	damagedproducts
100	general	deliverycharge
101	general	invoicedesign
102	general	stocktransfer
103	general	stocktransferitem
104	general	stockupdate
105	general	stockupdateitem
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2024-07-10 05:10:15.684612+00
2	auth	0001_initial	2024-07-10 05:10:15.769687+00
3	admin	0001_initial	2024-07-10 05:10:15.791623+00
4	admin	0002_logentry_remove_auto_add	2024-07-10 05:10:15.800098+00
5	admin	0003_logentry_add_action_flag_choices	2024-07-10 05:10:15.808648+00
6	contenttypes	0002_remove_content_type_name	2024-07-10 05:10:15.828177+00
7	auth	0002_alter_permission_name_max_length	2024-07-10 05:10:15.837311+00
8	auth	0003_alter_user_email_max_length	2024-07-10 05:10:15.847091+00
9	auth	0004_alter_user_username_opts	2024-07-10 05:10:15.856785+00
10	auth	0005_alter_user_last_login_null	2024-07-10 05:10:15.866465+00
11	auth	0006_require_contenttypes_0002	2024-07-10 05:10:15.868821+00
12	auth	0007_alter_validators_add_error_messages	2024-07-10 05:10:15.878219+00
13	auth	0008_alter_user_username_max_length	2024-07-10 05:10:15.890436+00
14	auth	0009_alter_user_last_name_max_length	2024-07-10 05:10:15.900978+00
15	auth	0010_alter_group_name_max_length	2024-07-10 05:10:15.911085+00
16	auth	0011_update_proxy_permissions	2024-07-10 05:10:15.919526+00
17	auth	0012_alter_user_first_name_max_length	2024-07-10 05:10:15.928936+00
18	staffs	0001_initial	2024-07-10 05:10:16.134095+00
19	warehouses	0001_initial	2024-07-10 05:10:16.233616+00
20	customers	0001_initial	2024-07-10 05:10:16.392218+00
21	customers	0002_initial	2024-07-10 05:10:16.560433+00
22	finance	0001_initial	2024-07-10 05:10:16.796856+00
23	delivery_agent	0001_initial	2024-07-10 05:10:16.891411+00
24	orders	0001_initial	2024-07-10 05:10:17.036872+00
25	delivery_agent	0002_initial	2024-07-10 05:10:17.464558+00
26	delivery_agent	0003_initial	2024-07-10 05:10:17.916099+00
27	fcm_django	0001_initial	2024-07-10 05:10:17.965558+00
28	fcm_django	0002_auto_20160808_1645	2024-07-10 05:10:18.00771+00
29	fcm_django	0003_auto_20170313_1314	2024-07-10 05:10:18.036378+00
30	fcm_django	0004_auto_20181128_1642	2024-07-10 05:10:18.066846+00
31	fcm_django	0005_auto_20170808_1145	2024-07-10 05:10:18.106915+00
32	fcm_django	0006_auto_20210802_1140	2024-07-10 05:10:18.138222+00
33	fcm_django	0007_auto_20211001_1440	2024-07-10 05:10:18.181626+00
34	fcm_django	0008_auto_20211224_1205	2024-07-10 05:10:18.233059+00
35	fcm_django	0009_alter_fcmdevice_user	2024-07-10 05:10:18.274306+00
36	fcm_django	0010_unique_registration_id	2024-07-10 05:10:18.31211+00
37	fcm_django	0011_fcmdevice_fcm_django_registration_id_user_id_idx	2024-07-10 05:10:18.345077+00
38	suppliers	0001_initial	2024-07-10 05:10:18.552212+00
39	products	0001_initial	2024-07-10 05:10:19.504393+00
40	general	0001_initial	2024-07-10 05:10:19.639508+00
41	general	0002_initial	2024-07-10 05:10:19.867577+00
42	sales	0001_initial	2024-07-10 05:10:20.230151+00
43	purchases	0001_initial	2024-07-10 05:10:20.654092+00
44	finance	0002_initial	2024-07-10 05:10:25.045207+00
45	vendors	0001_initial	2024-07-10 05:10:25.259949+00
46	general	0003_initial	2024-07-10 05:10:28.585789+00
47	main	0001_initial	2024-07-10 05:10:28.632718+00
48	offers	0001_initial	2024-07-10 05:10:28.790965+00
49	offers	0002_initial	2024-07-10 05:10:29.91794+00
50	offers	0003_initial	2024-07-10 05:10:30.565028+00
51	orders	0002_initial	2024-07-10 05:10:31.71342+00
52	products	0002_initial	2024-07-10 05:10:34.635812+00
53	purchases	0002_initial	2024-07-10 05:10:35.989863+00
54	registration	0001_initial	2024-07-10 05:10:36.093555+00
55	registration	0002_registrationprofile_activated	2024-07-10 05:10:36.332105+00
56	registration	0003_migrate_activatedstatus	2024-07-10 05:10:36.439263+00
57	registration	0004_supervisedregistrationprofile	2024-07-10 05:10:36.5377+00
58	registration	0005_activation_key_sha256	2024-07-10 05:10:36.616413+00
59	registration	0006_alter_registrationprofile_id	2024-07-10 05:10:36.885427+00
60	sales	0002_initial	2024-07-10 05:10:38.275967+00
61	sessions	0001_initial	2024-07-10 05:10:38.305585+00
62	users	0001_initial	2024-07-10 05:10:39.008339+00
63	staffs	0002_initial	2024-07-10 05:10:40.763358+00
64	web	0001_initial	2024-07-10 05:10:41.86087+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
f4jr2qvk527xkhle83cmdlz45ojdxb3j	.eJxVjEEOwiAQRe_C2pCZCQXq0r1naGCYStVAUtqNxrvbJt10-977_6s-tYi6Kg-kLmoI65KHtck8TGmjeGYx8EvKLtIzlEfVXMsyT1HviT5s0_ea5H072tNBDi1va4CeRwTvDCFidEzSmdiPzhIaAjIeOZLphSwGRkHkNHbRSXDWAoD6_QH7iDoA:1sRQOV:NXl6CcdkR9p-NmHMzKA1zfv_13ynvcjbNsEcEg8BlFU	2024-07-24 06:01:35.743411+00
b7owym0mbfklrwzt5dvo3e1mehtywgya	.eJxVjEEOwiAQRe_C2hCHAlNcuvcMZIBBqgaS0q6Md7dNutDtf-_9t_C0LsWvnWc_JXERoMXpdwwUn1x3kh5U703GVpd5CnJX5EG7vLXEr-vh_h0U6mWrGTKqkBRj0obcgANxDhYhM5AlxZwMjqM7g6JoHcDmWQ1obISgEMXnCxusN90:1t4HHu:7oM_i2DCisoOKHJ6x28adZUR3B49Q8gMT8AG5tF3CTk	2024-11-08 10:11:22.516324+00
t495z3unj2wq9qgoib5aummkbwfgc6ku	eyJ6b25lIjoiMjcyNSJ9:1sTG6R:zYKB6au9fJMP9GkdIVCXeHiBVQ4jdzNlINDG4BYT1_Y	2024-07-29 07:26:31.885224+00
3rdhfqabawnyi5vg54nm27n70i3wccb4	.eJxVjEEOwiAQRe_C2hCYkim4dO8ZyAwDUjU0Ke3KeHdt0oVu_3vvv1Skba1x63mJk6izGtTpd2NKj9x2IHdqt1mnua3LxHpX9EG7vs6Sn5fD_Tuo1Ou39gAZ0Bc_ojWBTBF0HhI6h5CtTzxYKAiBjSdkLkQCNuQkHEYboKj3B8SAN6o:1sU72J:NFoEwuu0H_Y1IRp4xAJKd0v3maiVp8pC7pOc_uaPynI	2024-07-31 15:57:47.207841+00
lb8xvd1zcayvkowjzbtqayupp6xemfvg	eyJ6b25lIjoiNCJ9:1sUJWB:tsEqTlQqDf3fVHhyv8uOzrjUeekjb2nXyYED3hmW4bM	2024-08-01 05:17:27.301536+00
wtnq0r2eu4i5gj4d6picc6bcrr4j8jtz	eyJ6b25lIjo0OTUwfQ:1t5fSu:s6EyWq3p1xJ-zujK5O0CI-oYMPZb7-0_air-Xi9VuCA	2024-11-12 06:12:28.262434+00
4i04cphfgcd7meuhbtdpyjft50tgrvq1	eyJ6b25lIjo0NzA1fQ:1t6sYr:2Z-HZQw9VamxVEsAqPZErbgSkdmOwo3d_X8jKR4A1DU	2024-11-15 14:23:37.383202+00
cgdwzkcls7wh89cncmoljkkkxm9fuvg4	.eJxVjDsOwjAQBe_iGln2xmxsSvqcIdq11ySAbCmfBsTdSaQU0L6ZN2_V07oM_TrL1I9JXVSjTr8bU3xI2UG6U7lVHWtZppH1ruiDzrqrSZ7Xw_0LDDQP29sDCKDPvkVrApmc0HmI6ByCWB-5sZARAhtPyJyJEtggMXFobYC8RV-1yFZyrTmrzxfpgzsk:1sULAd:f9QGIOO3izkFGXKrIVce62Rb9OwNx9n74E2BTPqyUGE	2024-08-01 07:03:19.419177+00
8dipqkul8uhv046z9jockckr06y4weak	.eJxVjEEOwiAQRe_C2hCYkim4dO8ZyAwDUjU0Ke3KeHdt0oVu_3vvv1Skba1x63mJk6izGtTpd2NKj9x2IHdqt1mnua3LxHpX9EG7vs6Sn5fD_Tuo1Ou39gAZ0Bc_ojWBTBF0HhI6h5CtTzxYKAiBjSdkLkQCNuQkHEYboKj3B8SAN6o:1sULHh:K-SVddjg0FjQk872lQ_4nXxnUiDDqiobOvACNj6g3W4	2024-08-01 07:10:37.426109+00
zr170ura15nwt81sh827g96hpor53w9s	.eJxVjDsOwyAQBe9CHaHdFQaTMn3OYMGyBCcRSP40iXL32JIbtzPz3ld9WhV1VcZ3oC5qCOtShnWWaRjThvHMYuCX1F2kZ6iPprnVZRqj3hN92FnfW5L37WhPByXMZVsDeM4IvTOEiNExSWeiz84SGgIyPXIk44UsBkZB5JS76CQ4awFA_f4k6jo4:1t76Kt:mga5p-wMzyYMoaCyTJ0po6WyYPGoT5G9olrFfj9u2b4	2024-11-16 05:06:07.511982+00
g3rqlqlpjezbiml0aycy1iucj6u12b5d	.eJxVjEEOwiAQRe_C2hCYkim4dO8ZyAwDUjU0Ke3KeHdt0oVu_3vvv1Skba1x63mJk6izGtTpd2NKj9x2IHdqt1mnua3LxHpX9EG7vs6Sn5fD_Tuo1Ou39gAZ0Bc_ojWBTBF0HhI6h5CtTzxYKAiBjSdkLkQCNuQkHEYboKj3B8SAN6o:1sUObj:8oMzV4rUZXs0yDrO5dqmAkXYqjfYpzvQBy-LNeeLu1o	2024-08-01 10:43:31.843568+00
f9ay20ra7rsitcqmt8blu0jy85g3exa2	.eJxVjEEOwiAQRe_C2pCZCYXi0r1nIDAMUjU0Ke3KeHdt0oVu_3vvv1SI21rD1mUJU1Znher0u6XID2k7yPfYbrPmua3LlPSu6IN2fZ2zPC-H-3dQY6_fGsBzQRidIURMjkkGk3xxltAQkBmRExkvZDEyCiLnMiQn0VkLAOr9Aa-WNrw:1t8zt5:ZMYOQnoGpeKrg9wFfsDTmNuz3ymMt1IuZipNpZPrrWg	2024-11-21 10:37:15.385737+00
a23axhoij21gncbfp4q4r07ruwbz28ik	.eJxVjDkOwjAQRe_iGlleBi-U9DmDNeMFB5AtxUmFuDtESgHtf-_9Fwu4rTVsIy9hTuzCgJ1-N8L4yG0H6Y7t1nnsbV1m4rvCDzr41FN-Xg_376DiqN9aRKkKaZ2LN6pYa6VDMmjOyRYggULpqBVpdFmAtKRkAWcikgUvADx7fwDfgTdl:1sUQ8m:hmWtApLNmWNx0tTyqu9QCfGasKR1TizyL1TiMtlU_fw	2024-08-01 12:21:44.37468+00
x82u2o6vm1g0k9s1zzva994ut11hzpwz	.eJxVjEEOwiAQRe_C2hAGWgGX7nsGMgODVA0kpV0Z765NutDtf-_9lwi4rSVsnZcwJ3ERMIrT70gYH1x3ku5Yb03GVtdlJrkr8qBdTi3x83q4fwcFe_nWkdi7pAbUnJisysoxA4K3zgxAADx4Y-mcbPZa0-iAVWRtPFqXFSrx_gAd5Dgy:1t9n09:0ITrMN7RqDt3QYisW6RXIHAvzle6H60t8mAQBIHgi8A	2024-11-23 15:03:49.730878+00
sxs2f81mtu4oo3we5qv6xlyzi4fryvpe	eyJ6b25lIjoiMSJ9:1tATKe:MSeMtDjcTJYfdCgmULtnLiTkVi4oMpXFawKg2N5O8bs	2024-11-25 12:15:48.00763+00
vkfjic6ew2es9mxk2h074a6t7mk1j0n9	eyJ6b25lIjoiNDg1OSJ9:1tBx5q:FDea2lbci7BWdSqpjxZu4O3lhBTng9pYOolkbulRPpU	2024-11-29 14:14:38.635677+00
tvohlncle74g8rnrf7gwfiiixx3l8n97	eyJ6b25lIjoiNSJ9:1tOKy1:ifu3jqLh2apERjqlW7mB_RJ_3jP-6DHLR2zlSWKPfZU	2025-01-02 18:09:45.887642+00
viknlvmq679sbayc0752slfdo45k8cck	.eJxVjEEOwiAQRe_C2pCZCYXi0r1nIDAMUjU0Ke3KeHdt0oVu_3vvv1SI21rD1mUJU1Znher0u6XID2k7yPfYbrPmua3LlPSu6IN2fZ2zPC-H-3dQY6_fGsBzQRidIURMjkkGk3xxltAQkBmRExkvZDEyCiLnMiQn0VkLAOr9Aa-WNrw:1tXflv:iuz5DdcipKOswq_ppW0CPsyei_pKBihilFR01Jk36b4	2025-01-28 12:11:51.162609+00
205esazl834141gzbc53hbbf905vx6rx	eyJ6b25lIjoiMSJ9:1taZZt:sL8_3zLqJ0fscUkZ1ABwT-vw35Slxxvv4ckNv4fySgs	2025-02-05 12:11:25.51535+00
cd9sd2zsbk49th3jgeyurn8slcvu1312	.eJxVjEEOwiAQRe_C2pCZCYXi0r1nIDAMUjU0Ke3KeHdt0oVu_3vvv1SI21rD1mUJU1Znher0u6XID2k7yPfYbrPmua3LlPSu6IN2fZ2zPC-H-3dQY6_fGsBzQRidIURMjkkGk3xxltAQkBmRExkvZDEyCiLnMiQn0VkLAOr9Aa-WNrw:1tfyUn:hFH4R5NmsmiLTeGgraEaKBiw3Sf2BUCNGcIpMLMTvsA	2025-02-20 09:48:29.545372+00
3cibhoycvxec5m9ri6zxxf8pstjvx4g0	eyJ6b25lIjoxfQ:1sUjCw:GPjvM0gM9G8pZNJRWZY0pQhevLsUP6mbdZ-VGJLwXKU	2024-08-02 08:43:18.528599+00
qlp6tr3rpcful5e5x1cqg1r0l8gbuh2s	.eJxVjDsOwjAQBe_iGlm7K8cfSnrOENnrDQkgW4qTBsTdSaQU0L6ZN2_Vx3UZ-7XJ3E9ZnRWq0--WIj-k7CDfY7lVzbUs85T0ruiDNn2tWZ6Xw_0LjLGN2xsg8IDgnSFETI5JOpPC4CyhISDjkROZIGQxMgoi56FLTqKzFgC26KsW2UrGd0F9vse6OkA:1tlqFB:6CZeDArGkjZWyz4-lFOmcK-y1EbeNEYlICy7epMo17Y	2025-03-08 14:12:37.035832+00
zodo4v8yniu4i45a006z4owg71h0kcii	.eJxVjDsOwjAQBe_iGlm7K8cfSnrOENnrDQkgW4qTBsTdSaQU0L6ZN2_Vx3UZ-7XJ3E9ZnRWq0--WIj-k7CDfY7lVzbUs85T0ruiDNn2tWZ6Xw_0LjLGN2xsg8IDgnSFETI5JOpPC4CyhISDjkROZIGQxMgoi56FLTqKzFgC26KsW2UrGd0F9vse6OkA:1sVRzY:w15hi9ZbT0ZDtjw8kEcafSsEmIDwwrKQuz5bMLnc87g	2024-08-04 08:32:28.534884+00
2j2yd6jxl63p10x5hmvb828sj2gcv24e	eyJ6b25lIjoiMiJ9:1sW6A8:Vd5MPw8IDWrnSth3dwbY_1Yn9MF72DPpehoOcG07Zlc	2024-08-06 03:26:04.693801+00
ag4mtmjwdlldco1vv3hma19ycljojzj7	eyJ6b25lIjoiNDg1OSJ9:1tpRFM:HInMIdw3mGUhFpnhQ-rzJtP5qq5tU18tgmbhD2D4cWc	2025-03-18 12:19:40.436304+00
kb6a1dk2pg54jt0brpvcd225q6viecgl	.eJxVjEEOwiAQRe_C2pCZCYXi0r1nIDAMUjU0Ke3KeHdt0oVu_3vvv1SI21rD1mUJU1Znher0u6XID2k7yPfYbrPmua3LlPSu6IN2fZ2zPC-H-3dQY6_fGsBzQRidIURMjkkGk3xxltAQkBmRExkvZDEyCiLnMiQn0VkLAOr9Aa-WNrw:1sWri3:hehYh1JNzYO4iEjIyaymqqGm6h9P8OVc1MjR8_qGop0	2024-08-08 06:12:15.711776+00
5z0st1sxcxzjanenfajt9sqymphdvg5u	eyJ6b25lIjoxfQ:1sXwpy:hPL2_o7vYvubK2Kjz-XtplLG8TJuSDT433KDbOr0fIE	2024-08-11 05:52:54.895879+00
46r13p59q94mkgdf75nnbgnvd1innhx8	eyJ6b25lIjoxfQ:1tqYtb:9N7JePCtLX4FK9iuSjfqRFfE3HVvVeNzKikrMXH_DGg	2025-03-21 14:41:51.731281+00
2yspvmbsq8w3kh7xc3h4rv9twy8pwcb0	.eJxVjMsOwiAQRf-FtSEzEwrUpXu_gcAwlaqBpI-Nxn-3TbrQ7T3nnrcKcV1KWGeZwpjVWaE6_W4p8kPqDvI91lvT3OoyjUnvij7orK8ty_NyuH-BEueyvQF6HhC8M4SIyTFJZ1I_OEtoCMh45ESmF7IYGQWR89AlJ9FZCwBb9NWqbCXjLajPF8ejOjg:1sdWaM:DVuC5gZUG82bjioxgTt6hu9Pu_xD4lZrhDIfvBWDazg	2024-08-26 15:03:50.204812+00
ie60fjqr36wzm677uwmc89h7pdcr4p2f	eyJ6b25lIjoiMSJ9:1set2C:exx_DComIt08ZNCs0QQikhm2VJmZ5RfF6cKPB3pZYIU	2024-08-30 09:14:12.063099+00
ilhwvzbpnhj92zn4x4j0474rdpdsa5ag	eyJ6b25lIjo0ODQwfQ:1sghjb:oguBNAjjk07pVMLz1jmO0Io6bYHTMqWaXiN7tJ4Huu8	2024-09-04 09:34:31.338279+00
06g8yocjg5yjck1w6jvm1tbgjxrwha84	eyJ6b25lIjo0ODQwfQ:1sgi7d:wla0l0jqFKMD3m5WO6JkAf9I3xNwNjlI1G-Eu3wsSRk	2024-09-04 09:59:21.212869+00
k3y6uwoxiqjyb9e4pfosy9alopjkp4ye	.eJxVjDsOwjAQRO_iGln2xp-Ykj5nsNbeBQeQLeXTgLg7iZQmU755M1_xaZXFVWhxERHXpcR15imOtDM4w4T5xXVv6In10WRudZnGJHdFHu0sh0b8vh3u6aDgXLa170izA-BsenXvCQCcUcrgBoLbopm8cQp1lxJ6ncgEcDZYbzmzs-L3B-mMOh8:1sxNH0:B9tqdFHFri4cuPUc4hFdm4WH7k9hBFbcREKqIHnHJgw	2024-10-20 09:09:54.922116+00
15woa64g9s3e3c6uhqwy784cknxn79xt	.eJxVjDsOwjAQBe_iGlm7K8cfSnrOENnrDQkgW4qTBsTdSaQ0aWfmva_61CLqqoz3nbqoPq7L2K9N5n7KG8YzS5FfUnaRn7E8quZalnlKek_0YZu-1yzv29GeDsbYxm0NEHhA8M4QIibHJJ1JYXCW0BCQ8ciJTBCyGBkFkfPQJSfRWQsA6vcHKaY6Pw:1t3vD4:rwyEf3IswlWCPtVtP4ObYMu4IXOj63BHJHKBvGqZxBY	2024-11-07 10:36:54.799712+00
2sxvq17lmyznxsqf7z1hxgm0rpjwc4gx	.eJxVjDkOwjAQRe_iGlleBi-U9DmDNeMFB5AtxUmFuDtESgHtf-_9Fwu4rTVsIy9hTuzCgJ1-N8L4yG0H6Y7t1nnsbV1m4rvCDzr41FN-Xg_376DiqN9aRKkKaZ2LN6pYa6VDMmjOyRYggULpqBVpdFmAtKRkAWcikgUvADx7fwDfgTdl:1tmknS:E5gbwGbxRJc7Nkh4Ps5KZNHi8WHWMRBhh3UVFEwMdHE	2025-03-11 02:35:46.276637+00
usrizjfpp4pmz1fjake9muav023xdig5	eyJ6b25lIjoiMjQ1NCJ9:1uV5qB:FrncAFqK4S5a3UOcproEmFlU-bnw24VbdPrdSBGTSRs	2025-07-11 09:57:51.545788+00
auqzs9rat43u2xs9gkvh7e14bilxf5us	eyJ6b25lIjoiIn0:1uXdkF:JAyuFbdZHUOIXpPs0w5ndDaaxFkHY-F_hcHivUAaRvk	2025-07-18 10:34:15.629405+00
21dlu4t1by5d1r2oa1s13jgrq2aye634	eyJ6b25lIjo0ODU5fQ:1uai0w:OG2avzAU86hsngW5CuiiB9ooDFxX64TMiwfC3eJYGqY	2025-07-26 21:44:10.978773+00
pkcnmp3cgrb8qhoe42oxv1zvn0btv5zj	.eJxVjEEOwiAQRe_C2pCZCYXi0r1nIDAMUjU0Ke3KeHdt0oVu_3vvv1SI21rD1mUJU1Znher0u6XID2k7yPfYbrPmua3LlPSu6IN2fZ2zPC-H-3dQY6_fGsBzQRidIURMjkkGk3xxltAQkBmRExkvZDEyCiLnMiQn0VkLAOr9Aa-WNrw:1ugQ8X:l6waSNwZX3enf39oWwSHyVqAR_4O8h-P1Nf7t-US2qI	2025-08-11 15:51:37.798076+00
d849jvzc4sx39npoug7vzgwuii8btfoo	.eJxVj0tuwzAMBe-idSxIsunQXXbfMxgkRdbpRypie9Oid48SBAjC5bzhA_nnfmtR9-IGhMkd3Ez7tsz7quf5lBuGZ8Ykn1quQf6g8l691LKdT-yvir-nq3-rWb9e7-5TwULr0rZx5AwclUQMTPKQICAmDIYmOEQzipNxsBDImmqBuU9RBzpmYRtbqdT9p5aZvrfWN44-tHng2_EIwqhinU5AXfuw77iP0kkGShpygqO4_wtZKlIs:1upmcC:uY5jd2HM_wLVY8e79lX5xTSiidg289ma8AheuVPSDjY	2025-09-06 11:40:56.009359+00
57vp1r1gvccneuep0qzu779awayxbrqu	.eJw9yzEOgCAMAMC_dLYGwWrhMwZKTRwEB100_l0m58s9cNeiEEYm34HU66hl2TIEYJLEKiuqp4jNHSY3CEqmaNVkS7PAX-J-tuOm3hh4P0T3GNs:1upnXz:4leSbykgwRnZrnhZb_Xil2bvGJpgP80-H0mjA_oN5jI	2025-09-06 12:40:39.932433+00
v5l0csf2tv50p7hg4nm0ww2bbysxkx2m	.eJxVjEEOwiAQRe_C2pCZCYXi0r1nIDAMUjU0Ke3KeHdt0oVu_3vvv1SI21rD1mUJU1Znher0u6XID2k7yPfYbrPmua3LlPSu6IN2fZ2zPC-H-3dQY6_fGsBzQRidIURMjkkGk3xxltAQkBmRExkvZDEyCiLnMiQn0VkLAOr9Aa-WNrw:1urI5H:ABgL9dHcKOyrRyD8Su2FR_B6o8w3B7J0esMmA1Vougc	2025-09-10 15:29:11.341372+00
4aty5fki69gj6vcbgfr3rirdu9s5wubw	.eJxVjEEOwiAQRe_C2pCZCYXi0r1nIDAMUjU0Ke3KeHdt0oVu_3vvv1SI21rD1mUJU1Znher0u6XID2k7yPfYbrPmua3LlPSu6IN2fZ2zPC-H-3dQY6_fGsBzQRidIURMjkkGk3xxltAQkBmRExkvZDEyCiLnMiQn0VkLAOr9Aa-WNrw:1vd3N5:XJBnpWms1WPnmtHpwovYHZBGE45bfNk656nM1AfYAGI	2026-01-20 09:28:59.599507+00
ddx6v0ualj8vmbvm0iektvaqknzvuaki	.eJxVjEEOwiAQRe_C2pCZCYXi0r1nIDAMUjU0Ke3KeHdt0oVu_3vvv1SI21rD1mUJU1Znher0u6XID2k7yPfYbrPmua3LlPSu6IN2fZ2zPC-H-3dQY6_fGsBzQRidIURMjkkGk3xxltAQkBmRExkvZDEyCiLnMiQn0VkLAOr9Aa-WNrw:1uZY5a:29pDbSFDveHS7vWV1OvMxMGTbrhp3OgBxrQQa7z4PWY	2025-07-23 16:56:10.860172+00
may4m3uevib3zr9vts8p52ddcl0ycw99	eyJ6b25lIjoiNDg1OSJ9:1udhnb:dmTmGlbUwlSE5ZswbdJdrZBTMEq9F2YESh3rtQjfFe8	2025-08-04 04:06:47.339761+00
gqgxoucit0hmlbfo387ycpezsushl66e	eyJ6b25lIjoiMTAifQ:1up09C:dqOhMaJn9kJQcqxXuJwWqN9fAzKEcpfl0xYh-R-zt4Q	2025-09-04 07:55:46.703256+00
0iqcwf888nphung4b1zy1y3kub4acitu	.eJxVjMsOwiAQRf-FtSEzEwrUpXu_gcAwlaqBpI-Nxn-3TbrQ7T3nnrcKcV1KWGeZwpjVWaE6_W4p8kPqDvI91lvT3OoyjUnvij7orK8ty_NyuH-BEueyvQF6HhC8M4SIyTFJZ1I_OEtoCMh45ESmF7IYGQWR89AlJ9FZCwBb9NWqbCXjLajPF8ejOjg:1ttnMq:s4qNubbralPuKFPcRq7BuWe1db3c-09o2eW4Dvdo8sQ	2025-03-30 12:45:24.405348+00
3ptcsn0n1haxgxz2ekstdih1ac5biqh4	.eJxVjEEOwiAQRe_C2pCZCYXi0r1nIDAMUjU0Ke3KeHdt0oVu_3vvv1SI21rD1mUJU1Znher0u6XID2k7yPfYbrPmua3LlPSu6IN2fZ2zPC-H-3dQY6_fGsBzQRidIURMjkkGk3xxltAQkBmRExkvZDEyCiLnMiQn0VkLAOr9Aa-WNrw:1upmXE:11iE7e7j6snFCbns6qTvfX_w-zD4PwPFI0F5-cNbtSY	2025-09-06 11:35:48.187822+00
3tguwhyvp8ni61si7o5byj6bjbk762c1	.eJxVjDsOwjAQBe_iGln2xmxsSvqcIdq11ySAbCmfBsTdSaQ0aWfmva_61CLqplxrruqielqXoV9nmfoxbbg5M6b4krKL9KTyqDrWskwj6z3Rh511V5O870d7OhhoHra1BxBAn32L1gQyOaHzENE5BLE-cmMhIwQ2npA5EyWwQWLi0NoAWf3-OHE7JA:1tuBsM:y1PUcXrn5hgsWdrWzx7yTmKcsrkmUDXJyGCpKGbc57U	2025-03-31 14:55:34.771719+00
pqfabec6twqe86360hotpeb7vkb2n7h6	.eJxVjMsOwiAQRf-FtSEwJdPBpXu_gQww2KqBpI-Nxn-3TbrQ7T3nnrcKvC5DWGeZwpjVWXXq9LtFTg-pO8h3rremU6vLNEa9K_qgs762LM_L4f4FBp6H7U0AAkiFerTGsykZHUFC5xDEUoqdhYLgoyHGGAtzBusl5eh766Fs0VerspUcoVGfL-mROyY:1txOPa:-FJ0PFlpbsUCuqA1tWyBC9uSBpBDpY-rtLHZTfG4ZuA	2025-04-09 10:55:06.020225+00
2a94bab3r0kzw2nqeekxvyp9gxaulv40	eyJ6b25lIjo0ODU5fQ:1tyvke:IUqTkTYRws_zruNC7GN6DsFvro2LyYizcqf2JBiA7H0	2025-04-13 16:43:12.239239+00
92s3fmx1cokunuh1t9hqrjnqvgrz3tqa	.eJxVjEEOwiAQRe_C2pCZCYXi0r1nIDAMUjU0Ke3KeHdt0oVu_3vvv1SI21rD1mUJU1Znher0u6XID2k7yPfYbrPmua3LlPSu6IN2fZ2zPC-H-3dQY6_fGsBzQRidIURMjkkGk3xxltAQkBmRExkvZDEyCiLnMiQn0VkLAOr9Aa-WNrw:1tzw3l:jl8qSpHXeUP70ejJGPCNl4cotm1tIewZW9DK4x2XyOo	2025-04-16 11:15:05.319645+00
jb8msp3a9ts8vxb7ejqkbcprg6mmaip3	eyJ6b25lIjoiMiJ9:1u4GX2:jzpMEMDCBrbhUBREhHVjTxbkpLpjxIhZ_5ygN-sDwVA	2025-04-28 09:55:12.890927+00
1au72evdpz95hkfmw6o4cjtjvh9t70tg	.eJxVjEEOwiAQRe_C2pCZCYXi0r1nIDAMUjU0Ke3KeHdt0oVu_3vvv1SI21rD1mUJU1Znher0u6XID2k7yPfYbrPmua3LlPSu6IN2fZ2zPC-H-3dQY6_fGsBzQRidIURMjkkGk3xxltAQkBmRExkvZDEyCiLnMiQn0VkLAOr9Aa-WNrw:1u53M8:Y-lBh4Z7zm1H8pgg20AW_Hwy4Go4jNeSlWzJOllzEoc	2025-04-30 14:03:12.733733+00
pxl21dkiiahlsjz2u6uevafvpkxxf8ab	eyJ6b25lIjoiNDg2MCJ9:1uAnEM:Qm5ld705sI-HnnNPkJd22mldAFcRMDHL7Qf_XlQMijc	2025-05-16 10:02:54.761561+00
ufvg7vqvto0agagj40aojrbc2153qu5l	.eJxVjMsOwiAQRf-FtSGAUKcu3fsNzczASNVA0sdG479Lky50e8-5560GXJc8rHOahjGqswrq8LsR8iOVDcQ7llvVXMsyjaQ3Re901tca0_Oyu3-BjHNub-goBrIJmSUIR--CAXBgBITBWxG0vZARY1CaKobo6GzyeIpM0rXoq5bUSh5Crz5fVbc8-w:1urHXu:rM1LJ9PYk-CKDjZHUOlodH4ybBI29A9dnAkhHLm-p4o	2025-09-10 14:54:42.100102+00
lopntn0c9vn757dx6731x0phic0kt5tg	eyJ6b25lIjoiNDg3OCJ9:1uwZrJ:IZ19lvDS4exVmET1ZLdg9T921hYuTlLHBlJN1JCzhKg	2025-09-25 05:28:37.889484+00
ryphen4vgemsa8ua42cum6p9ymtom8z8	.eJxVjEEOgjAQRe_StWmm2OLo0j1nIDPTjqCmTShsNN5dSNiwfe_9_zWfkpO5GY8tmJPpaZmHfqlp6se44nBkTPJKeRPxSflRrJQ8TyPbLbG7rbYrMb3ve3s4GKgO6xpbjoFdIhENKtE3ARAbBEUV9E6V3FUZFIB0TRWYz41Lni5RWFvz-wOMnTzz:1uCFm5:h1BjYimTGwyzWxvzLfZFGSD8c4Roeowj7uupoe0Jv2w	2025-05-20 10:43:45.408401+00
a1twhg75s2gbaxubmzjrudz70jda6lrh	.eJxVjEEOwiAQRe_C2pCZCYXi0r1nIDAMUjU0Ke3KeHdt0oVu_3vvv1SI21rD1mUJU1Znher0u6XID2k7yPfYbrPmua3LlPSu6IN2fZ2zPC-H-3dQY6_fGsBzQRidIURMjkkGk3xxltAQkBmRExkvZDEyCiLnMiQn0VkLAOr9Aa-WNrw:1uwv8A:2YnMvjMSRbTF4kSXTnF8AepKlDypLOmalMF4jeu48i0	2025-09-26 04:11:26.666342+00
06pa5djulzoor25mawg4ycewfiz6lcw3	.eJxVjkEOwiAQRe_C2pAWmNK6dO8ZyMwwSNVAUtqV8e7apAvd_vfy8l8q4LbmsDVZwhzVWfVenX5HQn5I2Um8Y7lVzbWsy0x6V_RBm77WKM_L4f4FMra8d5NPE3QgHQzRoPTe2Z5FoGMDLqaRyQ42MlIyAJOxHoxDcjQOhun76v0BB7E3_A:1uCGWF:aLBZFOpIlonQVKsuxQPmm94TJZVEfluBF8szF7Azn5w	2025-05-20 11:31:27.221137+00
jogr80gq9us227yiziztqbrna6kmthjg	.eJxVjDsOwjAQBe_iGlm7K8cfSnrOENnrDQkgW4qTBsTdSaQU0L6ZN2_Vx3UZ-7XJ3E9ZnRWq0--WIj-k7CDfY7lVzbUs85T0ruiDNn2tWZ6Xw_0LjLGN2xsg8IDgnSFETI5JOpPC4CyhISDjkROZIGQxMgoi56FLTqKzFgC26KsW2UrGd0F9vse6OkA:1uCHS1:r0Vj8wlTmFhISn48gOVvmuwdiKyLxABl5z3zukTiVFk	2025-05-20 12:31:09.544617+00
vdzdt5is3ywdy3vohnao229dkf6a73fq	eyJ6b25lIjo0ODU5fQ:1uyTAG:2wlPoDC0Kbwop7LFofFiHEeKJNWRTgZ5kZlUPPeFXvA	2025-09-30 10:44:00.85108+00
4d2fkmq4zboadna7kec6yhmpjgswr24k	.eJxVjEEOwiAQRe_C2pCZCYXi0r1nIDAMUjU0Ke3KeHdt0oVu_3vvv1SI21rD1mUJU1Znher0u6XID2k7yPfYbrPmua3LlPSu6IN2fZ2zPC-H-3dQY6_fGsBzQRidIURMjkkGk3xxltAQkBmRExkvZDEyCiLnMiQn0VkLAOr9Aa-WNrw:1v1eKo:lFXWbHnCJ6OMNdKhJkfN0CBY4wFYr6zfUI31UJAI260	2025-10-09 05:16:02.102292+00
o9vdo9zvoutffrtugf2frd16sca6wkkh	.eJxVjEEOwiAQRe_C2hBAqFOX7j1DMzMwUjWQlHaj8e62STfdvvf-_6pPLUldlYfQq5MacJnzsLQ0DWNccTgyQn6lson4xPKommuZp5H0lujdNn2vMb1ve3s4yNjyuoaOYiCbkFmCcPQuGAAHRkAYvBVB2wsZMQZlTcUQnZ1NHi-RSTr1-wOSBDz7:1uCHsj:2sHeo3Ga__BhiQMXnByz-VNOu6XBQbCGcNJxZFZwUB0	2025-05-20 12:58:45.157594+00
14qwp24uw63p7f1n9q1ply0yh1n9h122	eyJ6b25lIjo0ODU5fQ:1uCI6Q:Yr6V3HY_Lz9S1m-zqIN9hvytvnFfKQ_wF5MJgbu7Cv4	2025-05-20 13:12:54.570451+00
ebwvaaj89nljxgbsr1cxw0jw1295ht4c	eyJ6b25lIjoiNDg2MCJ9:1uI2Nx:Hhp3yg1YQ6I8H6iYuIikze683ozJUk5n3XxChoV5uF8	2025-06-05 09:38:45.243637+00
lrfnajjo2gwxx89na502y4cwhzddbo76	eyJ6b25lIjoiMiJ9:1vKsxA:0xls64hi_OGzgTu1sZ68KBDDFlrUX5fxTPe_4kp6FMU	2025-12-01 06:43:08.608816+00
47k51q2060cvy3fphlnjmal8of2krk5p	.eJxVjEEOgjAQRe_StWmm2OLo0j1nIDPTjqCmTShsNN5dSNiwfe_9_zWfkpO5GY8tmJPpaZmHfqlp6se44nBkTPJKeRPxSflRrJQ8TyPbLbG7rbYrMb3ve3s4GKgO6xpbjoFdIhENKtE3ARAbBEUV9E6V3FUZFIB0TRWYz41Lni5RWFvz-wOMnTzz:1uI5wz:sd-lkNrOFJJ_jIx8VhWXttCrP6gIZkrsT_sRjGoRl0U	2025-06-05 13:27:09.044281+00
x8mhohw6egbvfqmyj0h0xoi25bgiyf5k	eyJ6b25lIjoiIn0:1uIiiH:4T2jZB5YaP1OEeX2-JUOpIAbSS9m34qEgF5hQkjADYI	2025-06-07 06:50:33.532526+00
6ai3sku138iaixfcr5fyvakg3aozh7ts	.eJxVjEEOwiAQRe_C2pCZCYXi0r1nIDAMUjU0Ke3KeHdt0oVu_3vvv1SI21rD1mUJU1Znher0u6XID2k7yPfYbrPmua3LlPSu6IN2fZ2zPC-H-3dQY6_fGsBzQRidIURMjkkGk3xxltAQkBmRExkvZDEyCiLnMiQn0VkLAOr9Aa-WNrw:1vVWuz:-AwvPOJg9Q7nJObvKvG33tVEIp9aeqxBajpLUZ7Q84Q	2025-12-30 15:24:53.967093+00
jjatsygfh9vvyad7n2zotxvi9ffacnrz	.eJxVjEEOwiAQRe_C2pCZCYXi0r1nIDAMUjU0Ke3KeHdt0oVu_3vvv1SI21rD1mUJU1Znher0u6XID2k7yPfYbrPmua3LlPSu6IN2fZ2zPC-H-3dQY6_fGsBzQRidIURMjkkGk3xxltAQkBmRExkvZDEyCiLnMiQn0VkLAOr9Aa-WNrw:1uOXxs:bj-_Ds63UcyE-pe6X2rz2ngMSZjyMyK0FgQ6bsQq3UU	2025-06-23 08:34:44.57202+00
y573erhr67vpvf2fffbdlmh9f3iiv5hb	eyJ6b25lIjoiNDM5In0:1uPDtr:O8r7P8VB-4Ttcb4Th8QOV6K0TYO9OqvsO8i3-IbUbVI	2025-06-25 05:21:23.586801+00
byk39918z9jhefkosre1n04jlizor097	eyJ6b25lIjoiNDcwNSJ9:1uQSXD:DVHzIhQArql4tiYS1Wji6duHkaqG_ceyViGweDRfvM8	2025-06-28 15:11:07.985952+00
gjuz33a93xiqiq1wqg7aybc1xv94vm3e	eyJ6b25lIjoiMzY0OCJ9:1vchEI:RckiOc5C2Dq-4GEiwurUUtkWeQO4iqZtaGRqkikeXhw	2026-01-19 09:50:26.086845+00
n7ma5ft9eav3kxfb6xh5pvspncmqc6nr	.eJxVjEEOwiAQRe_C2pCZCYXi0r1nIDAMUjU0Ke3KeHdt0oVu_3vvv1SI21rD1mUJU1Znher0u6XID2k7yPfYbrPmua3LlPSu6IN2fZ2zPC-H-3dQY6_fGsBzQRidIURMjkkGk3xxltAQkBmRExkvZDEyCiLnMiQn0VkLAOr9Aa-WNrw:1uTgpo:3rh_6bhtzv4IfiOwF9fbdifznvwQnpHKQlabqUpSBq0	2025-07-07 13:03:40.43095+00
ew5caw0z6kg3poo75mw4s2evsnhi3c98	.eJxVjEEOwiAQRe_C2pCZCYXi0r1nIDAMUjU0Ke3KeHdt0oVu_3vvv1SI21rD1mUJU1Znher0u6XID2k7yPfYbrPmua3LlPSu6IN2fZ2zPC-H-3dQY6_fGsBzQRidIURMjkkGk3xxltAQkBmRExkvZDEyCiLnMiQn0VkLAOr9Aa-WNrw:1uTgpo:3rh_6bhtzv4IfiOwF9fbdifznvwQnpHKQlabqUpSBq0	2025-07-07 13:03:40.558739+00
\.


--
-- Data for Name: fcm_django_fcmdevice; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.fcm_django_fcmdevice (id, name, active, date_created, device_id, registration_id, type, user_id) FROM stdin;
1	Name	t	2024-07-10 06:02:02.684424+00	\N	dBo0HnmGnSFoLLgCSQ0iFX:APA91bGXwZ62fgUZxpqzLDz3rBIiAjQv0TdIUY5aGT29pcwoZ8SI0aY9sxehXOeFWkfsCknw3xsIBl4cKOnSUlq5WO1S8SZhKF72xBcx_sWi7v7XRC-j-vNolezbqAJzHVpiYl56zS5S	web	1
2	Name	t	2024-07-10 06:02:09.463301+00	\N	dBo0HnmGnSFoLLgCSQ0iFX:APA91bEuErdvcEJTkcTpmsipM8Bq6AYzhXsbvjHTttHKQfE2W_qjQFq5oC_c0ZN0FAFQ6paTw8AxzbF9-S-kCKZSzFeZi0N6JnhE3hlW4fpn31stQS8w0OzCwKck5eFxTZTRJGLkHeLU	web	1
3	Name	t	2024-07-17 11:53:52.993261+00	\N	eleendiq7JF9AjJfjYye5j:APA91bGSVO2j5Be8Jn3BH7k8TW7JwxzSCKMpVUNO6vt9jP-7Mmjbm4uN0bkhU5liU2c2KZHmsIyNBaIZCuMgPKSEmAHyCjbXR_sVkpx6TYMTI4dmXaPMCfcAdaOyxpfzICTYLCwRHq9k	web	1
4	Name	t	2024-07-17 16:00:47.787314+00	\N	fyShui-S16_SiyDNRCXlPt:APA91bHFeYco1Qfw48tE27daIUNV_yhGdB0cNrPHMMsqsNgVlaU9WBn9Qy_hwoCL3quMyOUph4nCgKKYXmrxxyRDl-a_UTDQptfdI0ZuLN2Q8R8jdWt8uNDuthDL3kD0SkrNxTDaRJpW	web	3
5	Name	t	2024-07-18 07:02:32.761816+00	\N	f_3R_2P06fyo_JAUlMvC8g:APA91bFb2KPv1hl7mjbUwV4XCYJqpYoXPZyfvUeKlHEjHUB39Ly8-sngM5TAZqpWFHivlZ1cX6xR9NAGsXtyJxWPCIyGRKUfvwjBEzJeP_5FsgH8nq5fXCkyf67VEOM2DsK51G1YpbvT	web	3
6	Name	t	2024-07-18 10:24:25.456121+00	\N	d5N7zlojOompOTCQvqEAWp:APA91bGhdOyxdaOQzNA-lSqtnBVsDA_DHmw8QrGPxN3a3QYogJr9BeTcnooFVoH6JX9Ae5HdFrIYj56DXpbFTuun6c24zkoMYZ8_NHA3Ow3rpv2UvdR71emCI6c2UAfRSTPPbsgUsbHy	web	4
7	Name	t	2024-07-18 10:44:08.504018+00	\N	cV69pLt9gD_vEhNcgCuOGG:APA91bEtK_NQgwnPthZXkFSry6qanD2Th42jGtk--tHyjFAqZ--BIHqDipRM5V0ro0c4BvOv4TP7gW1atlsZBUIFy1vYHaBYiPnBElA9PH5-eVqtdPoelHKU6J82RSIuJMhrsp9CaDrR	web	3
8	Name	t	2024-07-18 12:21:52.875234+00	\N	dEjZ-Qz0EKMuwsgLoss5Jo:APA91bGSPIyXaFtYiYLh0zZgCP84NqSTq5aLow4zOPWnttTesgHD-gq-Oidzdq7qBo9w-lSsQR5AuMks42yrDEyls6-CYfW2ZWxegLqHTXCa4N2KGlfw5SeVb5NPr_AvsBv2pGh8D1p9	web	4
9	user	t	2024-07-19 06:57:07.320924+00	\N	cCnxmB48QIO5WQfdx--XA-:APA91bEecCqZgyHu2pT6rzrZL31kS8qkx2XX6PInHbhhGnCGkMFfhkmndPGAOdGLsbhwPxSkL__Ckpvzunsvpv42icJGnb0Cxf99811TJis_k3DTfO02HZdSSSgo_UYf__DrHXhtMdCI	android	\N
11	user	t	2024-07-25 10:41:20.004619+00	\N	dCst-zOmQQCOkjDV_9A9nR:APA91bGQqsF9Z8jf74amLehHs1SPcGQYfiLX_7NPWFjfNx_gru5TPGpWKap72m_XZRRaTLjorwociCqY4DWidOBo2gaHiGfUGwqAmQPdMeG6Kc9xrirV55-i-F1gj5J75DwWLMF3PDMT	android	\N
12	user	t	2024-07-25 10:41:22.475235+00	\N	fssIs1bsSD2C4SSBcr0nRt:APA91bHpSGvCLllP1SXjb73emnZ6sKZrakKozaPqa3IpMjCY1fxFPtg491f25u7psdjVEqQmAyJ30arOpT-8Tkwn_BRDAQponwivHEjkQwMVmqGBVPQ4Vx0GdJFDT6f6r2NW0MWSTpE6	android	\N
13	user	t	2024-07-25 10:41:41.158471+00	\N	fwVlz7rXTGy-MP8Zty0thy:APA91bHdVPtu8z47wyk55DDWEhIMJeUWCysbI2eWMU5fyahDmJWgG4HsvTigPj2fGZ-SxdL0ImLIFMyI_Wr5weICFPl03EyjGm0nt6Afvn0SEa8V4WL2rockhAIKqj3IxNYS-TLguWXK	android	\N
14	user	t	2024-07-25 10:41:54.301203+00	\N	cZ-aeF8qRi6a-DxHGQ9Dmw:APA91bHDo2E2bw6M6a4c6SoM0e5YPcY2UZSKWBH7TSs2r-er09TA2HqQyaXNN1WZVWT6BPVwdB1h1PIiRk94zFPUQXBA_wPb69-NiZ4JPTaArUxvegL84-iZo40XKBHL7TTybZhM_SC1	android	\N
15	user	t	2024-07-25 10:42:51.238877+00	\N	enu4L6nObaFN7H0sLHPcjU:APA91bGMIJg7S4Ybkp1y4lOStiTVvTtDWn2Yo2-EYVCtRldtLBY9EIeHE8e37HLKoI0w5ryd0-jDBF0H-uTHVj6PjkZvBzqniUIeL5QMoEU3KbCt75fmc7I1zRO8RT9Ab6THutGTtHDG	android	\N
16	user	t	2024-07-28 05:48:38.630657+00	\N	dqztaDFNRleZWcYotUCul-:APA91bFqswv8IuDmfHhYs5Etqffxs3nuvS6MFNZpfMYM0OWQh4l2wCDOcvDHPOTq-M2KIInXhPtIhLVqkrWg4dhHDt0FUNy-HeYuoP5IOObrTfg32DmclOyfpRM9pPOXqY9tJbetts9L	android	\N
17	user	t	2024-08-21 09:29:43.676139+00	\N	fCbq_WHLRiWU5Yq8WIcv28:APA91bE9xDSELKyYFS-KjJZZWRVXN6dglysO0ZzBod1hAMINbpJMwxaBMQ3P1l9ouQHfOJaBOQB3GkJb8fzrBwyWLuJM8RV6dryLhEvsg9f3Lz8ucOECNVQhCtC9EtoiX7Zm0tDoFzn-	android	\N
18	user	t	2024-08-21 09:58:57.844258+00	\N	cXK2IYpzQQCkge0TRcvYhd:APA91bFqOJIWel5OVSS9Qnupnf0C21q0p-wt0k-QmyQ7_xR3vz5KtgS5TlZWI62_ZYOkbDtZVp5BbtAyBfnYhawEQxCYTGxExR_ZYBI7D1iyulFPS62_lR6ohOVc_i2JUlN3JAFHn5tF	android	\N
19	user	t	2024-10-24 07:49:03.049061+00	\N	dNsQLmtuSPOkJGDKoH__p7:APA91bF41LccKasW2GXcDa1KZBwoceavPwWIXUfTxHtQNAAqNzmgZiuIV0EeuDci-ryhmqlO-FCRIejINseQmlKxVdeDWVXQduAhQ5_l9DXHPF4i7XuP0Zk	android	\N
20	user	t	2024-10-24 08:46:10.530497+00	\N	cvwlOyFUQ8KY-iwu65Vqk0:APA91bEY5XMoJubimzWxVFOkbYaVnLS-4mc4c3JhMTta7sJ98yUiySDYhnsfP7gCUCagMAaJpYA0oV9qzw6gMfN7w1yb3paGyTq8ttw12xm-9qHUcwnxIsKpMCP73ltE7conPuWC62m4	android	\N
21	user	t	2024-10-24 08:57:04.415727+00	\N	cAF95ZOzRhy9363fjS1LZX:APA91bGTHNSZk51cZWUhfJYP5NetB2sS8fGew35WNzAALS6vMFcpwmbNajGpAAA2b4YkB2yTEekaoQhLkUc5Vmr0UudgwpvtBgkCjLnliwgwp-F_qcOPWwOe2wfLg9JTSH0ngx4413jv	android	\N
22	Name	t	2024-11-02 05:06:42.766497+00	\N	c9Nx99kiwNe9dOVOJuE3Pb:APA91bHRwka33RTzS2thQog3lyOxfaqRdWNYAXYntBnEPsxf1fewKTY9z4U-MKUxHVnDQgTZJHdz8x8FZbzvxIJ7teUE_AgniAHcwr6T13ZVvjulazZubuM	web	1
23	Name	t	2025-01-14 12:12:24.389119+00	\N	f1TUPqmbwyt5wtMsgJH-ku:APA91bEisGU72zF74jNCzTAPLX1regFMRzbkEJkOU-efxCHwgNwn_HsNOOQm-MyhkbLcIBY9s70z1aOtMZZ2O2tHZlBYvuescO-E-dlhHHMAtCSzBgikJwE	web	1
24	Name	t	2025-02-28 14:03:33.989728+00	\N	dKzAqAB1VPkJ_WSRXoHpTu:APA91bEAPg1Hx3DHCd3tMyghcfylYSa3u0Opqg9PCWiBd5le8_jVbtM6CpE6p-4KAaQrPYUJK36i4xz2m4Z9KRzVx7Lc70FjKNUgYA11qFsPyKxRsc3nsKE	web	4
25	user	t	2025-03-04 14:58:10.903794+00	\N	dCxEDJGFTZqKXI2gebVboY:APA91bH0pKN2DzFmScFfkkrzP9RUTC5ZfOQ5F0zFpbTz_59PWMvhwMt4LtRouLPoGh759N8belaVLIuA5yMNbWxWPd2lDSjqoCXhRrafvxF6u-NY3jOoRJA	android	\N
26	Name	t	2025-09-25 03:51:59.051837+00	\N	fWsGX5WkCp81K2ae9VNlVe:APA91bFzZ-tLU_5nMByBfpDZQixr1J0BnvmZR6Ht0vS0LDeWK8y-VBz7R0-8d_GXBf5UPblgJYh8ovBBO8NLHLxW7ICnMlNzZ2JghbyFRmSdIfsicHJzdIw	web	1
\.


--
-- Data for Name: finance_account_group; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.finance_account_group (id, date_added, date_updated, is_deleted, group_type, name, code, deleted_reason, creator_id, updater_id) FROM stdin;
1	2024-07-10 05:58:11.136634+00	2024-07-10 05:58:11.136645+00	f	25	Direct Income	direct_income	\N	1	1
2	2024-07-10 05:58:11.140748+00	2024-07-10 05:58:11.140756+00	f	20	Direct Expense	direct_expense	\N	1	1
3	2024-07-10 05:58:11.142149+00	2024-07-10 05:58:11.142157+00	f	25	Indirect Income	indirect_income	\N	1	1
4	2024-07-10 05:58:11.143248+00	2024-07-10 05:58:11.143254+00	f	20	Indirect Expense	indirect_expense	\N	1	1
5	2024-07-10 05:58:11.144308+00	2024-07-10 05:58:11.144315+00	f	25	Sales	sales	\N	1	1
6	2024-07-10 05:58:11.145466+00	2024-07-10 05:58:11.145472+00	f	20	Purchase	purchase	\N	1	1
7	2024-07-10 05:58:11.146514+00	2024-07-10 05:58:11.14652+00	f	15	Capital Account	capital_account	\N	1	1
8	2024-07-10 05:58:11.147601+00	2024-07-10 05:58:11.147608+00	f	10	Current Asset	current_asset	\N	1	1
9	2024-07-10 05:58:11.148725+00	2024-07-10 05:58:11.148732+00	f	15	Current Liability	current_liability	\N	1	1
10	2024-07-10 05:58:11.150086+00	2024-07-10 05:58:11.150095+00	f	15	Loan & Liability	loan_and_liability	\N	1	1
11	2024-11-20 13:26:15.011366+00	2024-11-20 13:48:11.287234+00	f	25	Delivery Collection	\N	\N	1	1
12	2025-02-22 13:23:14.259199+00	2025-02-22 13:23:14.259215+00	t	10	cash_deleted_12	\N	yy	1	1
13	2025-02-25 11:01:55.963164+00	2025-02-25 11:01:55.963181+00	t	25	cash_deleted_13	\N	111	1	1
14	2025-02-25 11:01:56.142021+00	2025-02-25 11:01:56.142033+00	t	25	cash_deleted_14	\N	nn	1	1
15	2025-07-16 14:25:02.932346+00	2025-07-16 14:25:02.932361+00	f	10	tax paid	\N	\N	1	1
\.


--
-- Data for Name: finance_account_head; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.finance_account_head (id, date_added, date_updated, is_deleted, name, code, deleted_reason, account_group_id, bank_account_id, creator_id, updater_id) FROM stdin;
1	2024-07-10 05:58:19.823832+00	2024-07-10 05:58:19.823843+00	f	Cash A/C	cash_account	\N	8	\N	1	1
2	2024-07-10 05:58:19.833573+00	2024-07-10 05:58:19.833585+00	f	Capital A/C	capital_account	\N	7	\N	1	1
3	2024-07-10 05:58:19.835619+00	2024-07-10 05:58:19.835627+00	f	Salary A/C	salary_account	\N	4	\N	1	1
4	2024-07-10 05:58:19.837048+00	2024-07-10 05:58:19.837056+00	f	Sundry Debtor (Customer)	sundry_debtor_customer	\N	8	\N	1	1
5	2024-07-10 05:58:19.838283+00	2024-07-10 05:58:19.83829+00	f	Sundry Creditor (Supplier)	sundry_creditor_supplier	\N	9	\N	1	1
6	2024-07-10 05:58:19.839635+00	2024-07-10 05:58:19.839644+00	f	Sundry Creditor (Delivery Agent)	sundry_creditor_delivery_agent	\N	9	\N	1	1
7	2024-07-10 05:58:19.841204+00	2024-07-10 05:58:19.841214+00	f	Sales A/C	sales_account	\N	5	\N	1	1
8	2024-07-10 05:58:19.842515+00	2024-07-10 05:58:19.842523+00	f	Online Sales	online_sales	\N	5	\N	1	1
9	2024-07-10 05:58:19.84381+00	2024-07-10 05:58:19.843817+00	f	Purchases	purchases	\N	6	\N	1	1
10	2024-07-10 05:58:19.845224+00	2024-07-10 05:58:19.845233+00	f	Sundry Creditor (Vendor)	sundry_creditor_vendor	\N	9	\N	1	1
11	2024-11-07 10:49:08.862537+00	2024-11-07 10:49:08.862552+00	f	Tea Expense	\N	\N	4	\N	1	1
12	2025-02-25 11:25:24.961091+00	2025-02-25 11:25:24.961105+00	f	ryas	\N	\N	7	\N	1	1
13	2025-03-07 11:03:53.280407+00	2025-03-07 11:03:53.280421+00	f	RIYAS	\N	\N	9	\N	1	1
14	2025-03-12 12:52:42.294656+00	2025-03-12 12:52:42.294671+00	f	hdfc kallara	bank_account	\N	8	3281a7c6-ad46-4226-83e6-2604f5268870	1	1
15	2025-07-08 15:01:14.527119+00	2025-07-08 15:01:14.527134+00	t	abc_deleted_15	\N	ss	9	\N	1	1
16	2025-07-09 11:52:01.337845+00	2025-07-09 11:52:01.337862+00	f	2054	\N	\N	10	\N	1	1
17	2025-07-16 10:09:58.495242+00	2025-07-16 10:09:58.495258+00	f	pen	\N	\N	2	\N	1	1
18	2025-07-16 14:06:21.327931+00	2025-07-16 14:06:21.327951+00	t	cash kallara_deleted_18	\N	gg	8	\N	1	1
19	2025-07-16 14:26:32.856205+00	2025-07-16 14:26:32.856216+00	f	tax paid	\N	\N	8	\N	1	1
20	2025-07-16 14:26:59.097716+00	2025-07-18 10:07:57.529074+00	f	tax collect	\N	\N	9	\N	1	1
\.


--
-- Data for Name: finance_account_head_opening; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.finance_account_head_opening (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, amount_type, amount, account_head_id, creator_id, financial_year_id, updater_id, warehouse_id) FROM stdin;
bc8ffa85-1e19-483f-963e-93c47a046b4b	1	2024-11-07 10:49:08.878798+00	2024-11-07 10:49:08.878828+00	f	\N	debit	0.00	11	1	1b5eb376-5b10-4b96-a3a6-3a2a49af94f6	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
3ebcf119-3ebd-447d-bfb1-5a8180d80262	2	2025-02-25 11:25:24.982268+00	2025-02-25 11:25:24.9823+00	f	\N	credit	10.00	12	1	1b5eb376-5b10-4b96-a3a6-3a2a49af94f6	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
78d71015-7c10-467c-bb7b-8651a08b863b	3	2025-03-07 11:03:53.296439+00	2025-03-07 11:03:53.296462+00	f	\N	debit	10000.00	13	1	1b5eb376-5b10-4b96-a3a6-3a2a49af94f6	1	6568014e-bb8e-4058-8abc-20b985c67d29
e2b16021-d8fe-4595-a303-be71f73f8cd9	4	2025-03-12 12:52:42.305797+00	2025-03-12 12:52:42.305824+00	f	\N	debit	20000.00	14	1	1b5eb376-5b10-4b96-a3a6-3a2a49af94f6	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
debce878-ac44-4419-b908-9ea11d8b341d	5	2025-07-08 15:01:14.545067+00	2025-07-08 15:01:14.545093+00	f	\N	debit	0.00	15	1	0474f664-a3f4-4195-a943-15945636ec03	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
0bcf69da-595c-43a9-b1b5-06aa457068c9	6	2025-07-09 11:52:01.365503+00	2025-07-09 11:52:01.365536+00	f	\N	credit	50000.00	16	1	0474f664-a3f4-4195-a943-15945636ec03	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
cf2e036b-4c42-43c5-a9d8-b32206845b93	7	2025-07-16 10:09:58.517088+00	2025-07-16 10:09:58.51712+00	f	\N	debit	0.00	17	1	0474f664-a3f4-4195-a943-15945636ec03	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
681fd83b-f55c-4af0-8483-9556daafeb84	8	2025-07-16 14:06:21.363788+00	2025-07-16 14:06:21.363828+00	f	\N	debit	0.00	18	1	0474f664-a3f4-4195-a943-15945636ec03	1	6568014e-bb8e-4058-8abc-20b985c67d29
b1309215-116e-4639-bdb1-cca166675e09	9	2025-07-16 14:26:32.873138+00	2025-07-16 14:26:32.873167+00	f	\N	debit	0.00	19	1	0474f664-a3f4-4195-a943-15945636ec03	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
6b38f9a5-1331-4a85-b102-22b67320e879	10	2025-07-16 14:26:59.109647+00	2025-07-16 14:26:59.10967+00	f	\N	debit	0.00	20	1	0474f664-a3f4-4195-a943-15945636ec03	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
5c14748e-b8fe-425b-8d10-7e9d04fe9085	11	2025-07-18 10:07:57.534997+00	2025-07-18 10:07:57.535009+00	f	\N	debit	0.00	20	1	0474f664-a3f4-4195-a943-15945636ec03	1	e9c91e4d-271c-4063-90d0-87038135e85e
\.


--
-- Data for Name: finance_bank_account; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.finance_bank_account (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, bank_name, account_number, account_holder, ifsc_code, branch, account_type, opening_balance_type, opening_balance, creator_id, updater_id, warehouse_id) FROM stdin;
3281a7c6-ad46-4226-83e6-2604f5268870	1	2025-03-12 12:52:42.288126+00	2025-03-12 12:52:42.288159+00	f	\N	hdfc kallara	123456789	Arafafa	HDFC0005789	kalllara	current	debit	20000.00	1	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
\.


--
-- Data for Name: finance_credit_voucher; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.finance_credit_voucher (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, voucher_date, voucher_number, title, description, amount, amount_type, transfer_type, is_system_generated, cheque_number, cheque_date, draft_number, draft_date, transfer_number, transfer_date, cheque_status, cheque_status_date, bank_id, creator_id, customer_id, financial_year_id, sale_return_id, updater_id, warehouse_id) FROM stdin;
\.


--
-- Data for Name: finance_debit_voucher; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.finance_debit_voucher (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, voucher_date, voucher_number, title, description, amount, amount_type, transfer_type, is_system_generated, cheque_number, cheque_date, cheque_status, cheque_status_date, draft_number, draft_date, transfer_number, transfer_date, bank_id, creator_id, financial_year_id, purchase_return_id, supplier_id, updater_id, warehouse_id) FROM stdin;
\.


--
-- Data for Name: finance_financial_year; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.finance_financial_year (id, auto_id, date_added, date_updated, deleted_reason, start_date, end_date, is_active, is_deleted, creator_id, updater_id) FROM stdin;
1b5eb376-5b10-4b96-a3a6-3a2a49af94f6	1	2024-07-25 07:07:24.446052+00	2025-07-16 10:42:53.563825+00	\N	2024-03-31 18:30:00+00	2025-03-30 18:30:00+00	f	f	1	1
afca6fce-315f-42aa-be0a-80fc68728803	3	2025-09-04 13:32:49.860705+00	2025-09-04 13:32:49.860731+00	\N	2025-09-04 18:30:00+00	2026-09-03 18:30:00+00	t	f	1	1
0474f664-a3f4-4195-a943-15945636ec03	2	2025-04-02 13:46:49.160528+00	2025-09-04 13:38:29.064345+00	\N	2025-03-31 18:30:00+00	2025-09-02 18:30:00+00	f	f	1	1
\.


--
-- Data for Name: finance_journal_voucher; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.finance_journal_voucher (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, voucher_number, voucher_date, title, description, sub_ledger, debit_amount, credit_amount, creator_id, financial_year_id, updater_id) FROM stdin;
cd9204b2-ec78-4ab3-bf7e-5163fa537e26	1	2025-02-25 12:04:17.328651+00	2025-02-25 12:04:17.328671+00	t	\N	1	2025-02-25 12:04:17.327325+00	transfer	\N	\N	0.00	0.00	1	1b5eb376-5b10-4b96-a3a6-3a2a49af94f6	1
517b2f21-f8f8-4445-af86-6c2262bc5605	2	2025-07-08 15:12:14.842293+00	2025-07-08 15:12:14.842314+00	f	\N	2	2025-07-08 15:12:14.841233+00	dd	\N	\N	0.00	0.00	1	0474f664-a3f4-4195-a943-15945636ec03	1
\.


--
-- Data for Name: finance_journal_voucher_item; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.finance_journal_voucher_item (id, is_deleted, sub_ledger, amount, amount_type, deleted_reason, account_head_id, journal_id, warehouse_id) FROM stdin;
b907146b-8364-43d1-8d19-bdfc5ef16238	t	\N	25000.00	10	\N	1	cd9204b2-ec78-4ab3-bf7e-5163fa537e26	6568014e-bb8e-4058-8abc-20b985c67d29
b273ba68-6c36-4fb5-bdf5-bc29eccefd5e	t	\N	25000.00	20	\N	2	cd9204b2-ec78-4ab3-bf7e-5163fa537e26	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
f89376e4-38eb-4de3-8ccf-c9ad0bf2444b	f	\N	4000.00	10	\N	8	517b2f21-f8f8-4445-af86-6c2262bc5605	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
a8c281d6-136b-4dd0-a4bc-2ddec0dcd7fe	f	\N	4000.00	20	\N	1	517b2f21-f8f8-4445-af86-6c2262bc5605	6568014e-bb8e-4058-8abc-20b985c67d29
\.


--
-- Data for Name: finance_payment_voucher; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.finance_payment_voucher (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, voucher_number, voucher_date, title, description, sub_ledger, amount, amount_type, transfer_type, is_system_generated, cheque_number, cheque_date, cheque_status, cheque_status_date, draft_number, draft_date, transfer_number, transfer_date, account_head_id, bank_id, creator_id, financial_year_id, updater_id, warehouse_id) FROM stdin;
ffc7704e-f547-4398-9f53-180a8741eb3d	1	2024-11-07 10:17:59.359485+00	2024-11-07 10:17:59.359512+00	t	\N	1	2024-11-08 10:17:59.357596+00	CC	\N	\N	100.00	20	10	f	\N	\N	20	\N	\N	\N	\N	\N	2	\N	1	1b5eb376-5b10-4b96-a3a6-3a2a49af94f6	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
739ad69c-7942-4543-a1f3-0707cb4a18bc	2	2025-02-25 14:26:14.368819+00	2025-02-25 14:26:14.36884+00	f	\N	2	2025-02-25 14:26:14.367521+00	tr	\N	\N	250.00	20	10	f	\N	\N	20	\N	\N	\N	\N	\N	4	\N	1	1b5eb376-5b10-4b96-a3a6-3a2a49af94f6	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
decd03cc-9e9e-42f6-9285-bace239b4bda	3	2025-03-07 10:48:22.249036+00	2025-03-07 10:48:22.249058+00	f	\N	3	2025-03-07 10:48:22.247844+00	MMM	\N	\N	4000.00	20	10	f	\N	\N	20	\N	\N	\N	\N	\N	2	\N	1	1b5eb376-5b10-4b96-a3a6-3a2a49af94f6	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
96c63138-250e-4fac-a105-585fdf1e89ec	4	2025-03-12 14:22:15.71407+00	2025-03-12 14:22:15.714089+00	f	\N	4	2025-03-12 14:22:15.712911+00	tea	\N	\N	1000.00	20	10	f	\N	\N	20	\N	\N	\N	\N	\N	11	\N	1	1b5eb376-5b10-4b96-a3a6-3a2a49af94f6	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
a5296d5a-7042-4e98-9b7f-769a1184c59a	5	2025-03-12 14:31:08.711191+00	2025-03-12 14:31:08.711217+00	f	\N	5	2025-03-12 14:31:08.709652+00	nnn	\N	\N	5000.00	20	10	f	\N	\N	20	\N	\N	\N	\N	\N	10	\N	1	1b5eb376-5b10-4b96-a3a6-3a2a49af94f6	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
bbfcf572-342d-4648-b66e-ac2f6b7ebf71	6	2025-03-12 14:37:19.322061+00	2025-03-12 14:37:19.322081+00	f	\N	6	2025-03-12 14:37:19.320732+00	kk	\N	\N	20000.00	20	10	f	\N	\N	20	\N	\N	\N	\N	\N	2	\N	1	1b5eb376-5b10-4b96-a3a6-3a2a49af94f6	1	6568014e-bb8e-4058-8abc-20b985c67d29
ca2f9f87-4aba-4deb-83c5-a347d760ec84	7	2025-03-14 15:31:25.089441+00	2025-03-14 15:31:25.089465+00	f	\N	7	2025-03-14 15:31:25.053739+00	Purchase Create	Purchase Create	6631610e-1744-4a2b-891e-8f125ffba1f5	5000.00	20	10	t	\N	\N	\N	\N	\N	\N	\N	\N	5	\N	1	1b5eb376-5b10-4b96-a3a6-3a2a49af94f6	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
de8a6756-b5ef-4a65-b997-cedbb699d1d0	8	2025-07-08 12:06:46.070126+00	2025-07-08 12:06:46.070155+00	f	\N	8	2025-07-08 12:06:46.068096+00	dd	\N	\N	10000.00	20	10	f	\N	\N	20	\N	\N	\N	\N	\N	2	\N	1	0474f664-a3f4-4195-a943-15945636ec03	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
1cec1958-6a4c-4306-ba11-e15a04918236	9	2025-07-08 12:40:41.875247+00	2025-07-08 12:40:41.875277+00	f	\N	9	2025-07-08 12:40:41.873684+00	dd	\N	\N	3000.00	20	10	f	\N	\N	20	\N	\N	\N	\N	\N	2	\N	1	0474f664-a3f4-4195-a943-15945636ec03	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
5d897fd5-08fa-4f7e-b3ca-38ee8f39571e	11	2025-07-09 10:17:20.914623+00	2025-07-09 10:17:20.914655+00	f	\N	11	2025-07-09 10:17:20.912512+00	fdd	\N	\N	1000.00	20	10	f	\N	\N	20	\N	\N	\N	\N	\N	1	\N	1	0474f664-a3f4-4195-a943-15945636ec03	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
b407a0b9-6c3a-4c42-a70f-2928a8b8c64f	13	2025-07-09 11:04:14.299781+00	2025-07-09 11:04:14.299815+00	t	\N	13	2025-07-09 11:04:14.297692+00	nn	\N	\N	3000.00	20	10	f	\N	\N	20	\N	\N	\N	\N	\N	4	\N	1	0474f664-a3f4-4195-a943-15945636ec03	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
4e305a3c-1d16-4aad-a543-11a32d68148f	12	2025-07-09 10:56:06.395339+00	2025-07-09 10:56:06.39537+00	t	\N	12	2025-07-09 10:56:06.393954+00	crd	\N	\N	1000.00	20	10	f	\N	\N	20	\N	\N	\N	\N	\N	4	\N	1	0474f664-a3f4-4195-a943-15945636ec03	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
6f73f003-4010-4e72-b5ac-317560e6ff73	10	2025-07-09 10:14:48.694182+00	2025-07-09 10:14:48.694205+00	t	\N	10	2025-07-09 10:14:48.692547+00	fd	\N	\N	1000.00	20	10	f	\N	\N	20	\N	\N	\N	\N	\N	4	\N	1	0474f664-a3f4-4195-a943-15945636ec03	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
9988932c-3d77-43f4-b46c-6d3547ef2732	14	2025-07-09 11:53:11.77365+00	2025-07-09 11:53:11.77368+00	f	\N	14	2025-07-09 11:53:11.77209+00	emi	cc	\N	4000.00	20	10	f	\N	\N	20	\N	\N	\N	\N	\N	16	\N	1	0474f664-a3f4-4195-a943-15945636ec03	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
c55cbf77-fba1-40c5-b774-82597386c70a	15	2025-07-16 10:04:45.917971+00	2025-07-16 10:04:45.917993+00	f	\N	15	2025-07-16 10:04:45.916736+00	kk	\N	\N	200.00	20	10	f	\N	\N	20	\N	\N	\N	\N	\N	11	\N	1	0474f664-a3f4-4195-a943-15945636ec03	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
3646c40a-8839-4f47-a266-a4faf141e2c3	16	2025-07-16 10:11:21.508761+00	2025-07-16 10:11:21.508785+00	f	\N	16	2025-07-16 10:11:21.507032+00	km	cc	\N	500.00	20	10	f	\N	\N	20	\N	\N	\N	\N	\N	17	\N	1	0474f664-a3f4-4195-a943-15945636ec03	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
27e27e4b-fc0f-45f9-acff-9fbf65c35165	17	2025-07-17 15:46:23.066079+00	2025-07-17 15:46:23.066092+00	f	\N	17	2025-07-17 15:46:23.065244+00	KK	hhh	\N	200.00	20	10	f	\N	\N	20	\N	\N	\N	\N	\N	5	\N	1	0474f664-a3f4-4195-a943-15945636ec03	1	e9c91e4d-271c-4063-90d0-87038135e85e
bb359aa8-5202-4b18-a4b3-8383ffdfea69	18	2025-07-23 14:19:34.213358+00	2025-07-23 14:19:34.213373+00	f	\N	18	2025-07-23 14:19:34.212544+00	mm	\N	\N	1000.00	20	10	f	\N	\N	20	\N	\N	\N	\N	\N	5	\N	1	0474f664-a3f4-4195-a943-15945636ec03	1	6568014e-bb8e-4058-8abc-20b985c67d29
2ddbcc8a-2119-4c6a-8d07-c7a55d9debd9	19	2025-09-04 12:45:07.013951+00	2025-09-04 12:45:07.013974+00	t	\N	19	2025-09-04 12:45:07.012665+00	jj	\N	\N	6000.00	20	10	f	\N	\N	20	\N	\N	\N	\N	\N	4	\N	1	0474f664-a3f4-4195-a943-15945636ec03	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
\.


--
-- Data for Name: finance_receipt_voucher; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.finance_receipt_voucher (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, voucher_date, voucher_number, title, description, sub_ledger, amount, amount_type, transfer_type, is_system_generated, cheque_number, cheque_date, cheque_status, cheque_status_date, draft_number, draft_date, transfer_number, transfer_date, account_head_id, bank_id, creator_id, financial_year_id, updater_id, warehouse_id) FROM stdin;
f22e35ad-2633-4dd4-bd68-79f875bffe35	1	2025-02-06 09:55:27.110867+00	2025-02-06 09:55:27.110954+00	f	\N	2025-02-06 09:55:27.067298+00	1	Sale Payment received	Sale Payment received	c6488465-a403-4642-92ce-210e51956062	195.00	10	10	t	\N	\N	\N	\N	\N	\N	\N	\N	4	\N	1	1b5eb376-5b10-4b96-a3a6-3a2a49af94f6	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
eec3619a-a707-40fd-a562-70029b03eec0	2	2025-02-22 13:24:25.273606+00	2025-02-22 13:24:25.273631+00	f	\N	2025-02-22 13:24:25.272029+00	2	jijjj	hhh	\N	500.00	10	10	f	\N	\N	20	\N	\N	\N	\N	\N	1	\N	1	1b5eb376-5b10-4b96-a3a6-3a2a49af94f6	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
a12746c6-b208-41f6-950a-5f9107f3534a	3	2025-02-25 14:29:01.471352+00	2025-02-25 14:33:19.781858+00	f	\N	2025-02-25 14:33:19.78178+00	3	rr	\N	\N	250000.00	10	10	f	\N	\N	20	\N	\N	\N	\N	\N	1	\N	1	1b5eb376-5b10-4b96-a3a6-3a2a49af94f6	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
48b8ad51-5342-42aa-9aae-a1fe957c6a0b	4	2025-03-04 11:17:50.039576+00	2025-03-04 11:17:50.039594+00	f	\N	2025-03-04 11:17:50.038321+00	4	ooo	\N	\N	20000.00	10	10	f	\N	\N	20	\N	\N	\N	\N	\N	2	\N	1	1b5eb376-5b10-4b96-a3a6-3a2a49af94f6	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
11cf081a-4553-433c-9984-98437397635d	5	2025-03-04 11:17:50.142539+00	2025-03-04 11:17:50.142559+00	t	\N	2025-03-04 11:17:50.141305+00	5	ooo	\N	\N	20000.00	10	10	f	\N	\N	20	\N	\N	\N	\N	\N	2	\N	1	1b5eb376-5b10-4b96-a3a6-3a2a49af94f6	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
6cd377ce-05cd-47d4-a5b0-aea2284a8c41	6	2025-03-04 11:20:13.304027+00	2025-03-04 11:20:13.304046+00	f	\N	2025-03-04 11:20:13.302711+00	6	gg	\N	\N	25000.00	10	10	f	\N	\N	20	\N	\N	\N	\N	\N	2	\N	1	1b5eb376-5b10-4b96-a3a6-3a2a49af94f6	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
44789b96-2a8f-48bc-87cf-fc2ad6013920	7	2025-03-12 12:47:07.285586+00	2025-03-12 12:47:07.285609+00	f	\N	2025-03-12 12:47:07.23296+00	7	Sale Payment received	Sale Payment received	0ca5eb0b-1bf8-48ee-b11c-f1fa306e36c1	195.00	10	10	t	\N	\N	\N	\N	\N	\N	\N	\N	4	\N	1	1b5eb376-5b10-4b96-a3a6-3a2a49af94f6	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
b7456767-2f76-4f26-ab13-241834bc04b6	9	2025-03-12 14:35:25.331775+00	2025-03-12 14:35:25.331804+00	f	\N	2025-03-12 14:35:25.330216+00	9	kk	\N	\N	10000.00	10	10	f	\N	\N	20	\N	\N	\N	\N	\N	2	\N	1	1b5eb376-5b10-4b96-a3a6-3a2a49af94f6	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
215966f5-9562-4113-bfe8-e708e3e71378	10	2025-04-02 14:01:19.690905+00	2025-04-02 14:01:19.690937+00	f	\N	2025-04-02 14:01:19.641872+00	10	Sale Payment received	Sale Payment received	760a809a-b409-44bf-83cb-79f76762cece	4875.00	10	10	t	\N	\N	\N	\N	\N	\N	\N	\N	4	\N	1	0474f664-a3f4-4195-a943-15945636ec03	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
90b8f17e-8e71-49bc-84bc-b176fc2f84e7	11	2025-07-08 10:23:17.051544+00	2025-07-08 10:23:17.051578+00	f	\N	2025-07-08 10:23:17.049031+00	11	ll	\N	\N	1000.00	10	10	f	\N	\N	20	\N	\N	\N	\N	\N	2	\N	1	0474f664-a3f4-4195-a943-15945636ec03	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
c1534785-e7a2-4a68-9891-1e130de1b588	12	2025-07-08 12:42:19.659528+00	2025-07-08 12:42:19.659554+00	f	\N	2025-07-08 12:42:19.657969+00	12	dd	\N	\N	3000.00	10	10	f	\N	\N	20	\N	\N	\N	\N	\N	2	\N	1	0474f664-a3f4-4195-a943-15945636ec03	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
0e21c88f-e96c-40e4-be6e-00f909a8b705	13	2025-07-08 12:56:55.59872+00	2025-07-08 12:56:55.598758+00	f	\N	2025-07-08 12:56:55.596367+00	13	dd	\N	\N	5000.00	10	10	f	\N	\N	20	\N	\N	\N	\N	\N	2	\N	1	0474f664-a3f4-4195-a943-15945636ec03	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
4d8bd6aa-3b5a-4597-91c9-8c09d5a0ee4c	14	2025-07-08 13:00:26.482881+00	2025-07-08 13:00:26.48291+00	f	\N	2025-07-08 13:00:26.480556+00	14	dd	\N	\N	5000.00	10	10	f	\N	\N	20	\N	\N	\N	\N	\N	2	\N	1	0474f664-a3f4-4195-a943-15945636ec03	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
85896167-7a8a-47a2-bded-1bb3f0362a97	15	2025-07-08 13:27:09.482016+00	2025-07-08 13:27:09.482037+00	t	\N	2025-07-08 13:27:09.480915+00	15	dd	\N	\N	3000.00	10	10	f	\N	\N	20	\N	\N	\N	\N	\N	2	\N	1	0474f664-a3f4-4195-a943-15945636ec03	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
b0c8b07a-6a55-4edd-8854-dcb6bc8aefdb	16	2025-07-08 14:27:15.769197+00	2025-07-08 14:27:15.769219+00	t	\N	2025-07-08 14:27:15.767881+00	16	sals	\N	\N	5000.00	10	10	f	\N	\N	20	\N	\N	\N	\N	\N	4	\N	1	0474f664-a3f4-4195-a943-15945636ec03	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
6eaf5894-8813-4407-9818-b1468055773e	8	2025-03-12 12:53:56.14085+00	2025-03-12 12:53:56.140872+00	t	\N	2025-03-12 12:53:56.103893+00	8	Sale Payment received	Sale Payment received	c6488465-a403-4642-92ce-210e51956062	195.00	10	25	t	\N	\N	20	\N	\N	\N	111	2025-03-12	4	3281a7c6-ad46-4226-83e6-2604f5268870	1	1b5eb376-5b10-4b96-a3a6-3a2a49af94f6	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
96ef3849-cefe-4c12-8938-17fe15fc05c9	18	2025-07-09 11:23:40.790808+00	2025-07-09 11:23:40.790841+00	f	\N	2025-07-09 11:23:40.728523+00	18	Sale Payment received	Sale Payment received	29e61444-5029-4b31-a751-598c2df7a502	950.00	10	10	t	\N	\N	\N	\N	\N	\N	\N	\N	4	\N	1	0474f664-a3f4-4195-a943-15945636ec03	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
cbd51705-b9b9-4c30-8d0b-70ddf63b7336	19	2025-07-09 11:55:15.012992+00	2025-07-09 11:55:15.01303+00	t	\N	2025-07-09 11:55:15.010915+00	19	cc	\N	\N	5000.00	10	25	f	\N	\N	20	\N	\N	\N	123	2025-07-09	4	3281a7c6-ad46-4226-83e6-2604f5268870	1	0474f664-a3f4-4195-a943-15945636ec03	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
dc877edd-d77c-4ef9-a0ad-7d4017d69071	17	2025-07-09 11:13:29.108974+00	2025-07-09 11:13:29.109004+00	t	\N	2025-07-09 11:13:29.107034+00	17	hn	\N	\N	4000.00	10	10	f	\N	\N	20	\N	\N	\N	\N	\N	4	\N	1	0474f664-a3f4-4195-a943-15945636ec03	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
bb4c4932-ea24-44c8-a3d7-c6f727bf5c6e	20	2025-07-18 10:29:39.679394+00	2025-07-18 10:29:39.679407+00	f	\N	2025-07-18 10:29:39.67856+00	20	tax	\N	\N	100.00	10	10	f	\N	\N	20	\N	\N	\N	\N	\N	20	\N	1	0474f664-a3f4-4195-a943-15945636ec03	1	e9c91e4d-271c-4063-90d0-87038135e85e
81b826d9-4b2d-4399-b308-e87c4aaf9e5c	21	2025-07-18 10:30:55.197186+00	2025-07-18 10:30:55.197199+00	f	\N	2025-07-18 10:30:55.196367+00	21	kk	\N	\N	55.00	10	10	f	\N	\N	20	\N	\N	\N	\N	\N	20	\N	1	0474f664-a3f4-4195-a943-15945636ec03	1	6568014e-bb8e-4058-8abc-20b985c67d29
5b9e66fc-c6b5-4fdb-a5ce-032a27f1e359	22	2025-07-28 08:45:40.611705+00	2025-07-28 08:45:40.611727+00	f	\N	2025-07-28 08:45:40.579331+00	22	Sale Payment received	Sale Payment received	0ca5eb0b-1bf8-48ee-b11c-f1fa306e36c1	12000.00	10	10	t	\N	\N	\N	\N	\N	\N	\N	\N	4	\N	1	0474f664-a3f4-4195-a943-15945636ec03	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
95169cd3-e46d-4e9b-8613-a42b584a3c6e	23	2025-07-28 08:45:43.318553+00	2025-07-28 08:45:43.318575+00	f	\N	2025-07-28 08:45:43.2904+00	23	Sale Payment received	Sale Payment received	0ca5eb0b-1bf8-48ee-b11c-f1fa306e36c1	12000.00	10	10	t	\N	\N	\N	\N	\N	\N	\N	\N	4	\N	1	0474f664-a3f4-4195-a943-15945636ec03	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
8c8c5eea-26b1-41eb-a3ab-03f8243e7221	24	2025-09-04 12:48:54.227467+00	2025-09-04 12:48:54.227493+00	f	\N	2025-09-04 12:48:54.225857+00	24	u	600	\N	6000.00	10	10	f	\N	\N	20	\N	\N	\N	\N	\N	4	\N	1	0474f664-a3f4-4195-a943-15945636ec03	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
8a457146-4b39-4e73-9e8d-abe050cebffd	25	2025-09-04 13:03:47.657183+00	2025-09-04 13:03:47.657205+00	f	\N	2025-09-04 13:03:47.620157+00	25	Sale Payment received	Sale Payment received	760a809a-b409-44bf-83cb-79f76762cece	50000.00	10	10	t	\N	\N	\N	\N	\N	\N	\N	\N	4	\N	1	0474f664-a3f4-4195-a943-15945636ec03	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
\.


--
-- Data for Name: finance_subledger_opening; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.finance_subledger_opening (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, sub_ledger, sub_ledger_type, amount_type, amount, account_head_id, creator_id, financial_year_id, updater_id) FROM stdin;
\.


--
-- Data for Name: general_batch; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.general_batch (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, batch_number, stock, mrp, retail_price, whole_sale_price, cost, manufacturing_date, expire_date, creator_id, product_id, product_variant_id, updater_id, warehouse_id) FROM stdin;
4c458037-2d35-4ca1-b092-60572fa5ba03	2	2024-07-19 03:52:17.155904+00	2024-07-19 03:52:17.155925+00	f	\N	1234	0.000	300.00	245.000	175.000	199.00	2024-07-19	2024-07-19	3	af8c94bb-f2a2-4673-be69-64ebb670f0e4	bb827cf8-daa6-402c-a7cb-e8a8936c04ac	3	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
e04f87ab-a2b6-4631-bce1-4bc34bacf35e	3	2024-07-19 03:52:43.889572+00	2024-07-19 03:52:43.889596+00	f	\N	1234	0.000	300.00	245.000	175.000	199.00	2024-07-19	2024-07-19	3	b0d55f50-76e5-4d3d-b098-09e1ef106a48	b3c33e1d-16de-4ea9-bf55-0a0e6ac424f1	3	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
d1244be2-4ce8-4cb6-9c4b-fe4f54e72c6e	4	2024-07-19 03:52:43.897058+00	2024-07-19 03:52:43.89708+00	f	\N	1234	0.000	300.00	245.000	175.000	199.00	2024-07-19	2024-07-19	3	b0d55f50-76e5-4d3d-b098-09e1ef106a48	f1fa4f77-1f7e-48ff-889e-32de297e9cf5	3	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
940f77d3-77b4-496e-ae03-37f27f1bafe3	7	2024-07-19 04:30:43.40043+00	2024-07-19 04:30:43.400452+00	f	\N	nx0011	0.000	799.00	700.000	600.000	299.00	2024-07-19	2024-07-28	3	7cb05e19-e135-442d-aa25-690ad6f73585	7df72a13-0cd4-4417-bb5b-842ab39fd10c	3	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
ea02a970-3139-4495-a23c-1428f1849f12	5	2024-07-19 04:02:38.291559+00	2024-07-19 04:02:38.291581+00	f	\N	nx123	0.000	18999.00	18000.000	18000.000	14999.00	2024-07-19	2026-06-19	3	fc9666f2-41d0-4fa6-bf5c-4db92128a936	7ccaf6ae-f439-4456-a6ad-02d218fee39d	3	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
09357e84-ac1f-47fc-a08d-6ad488812c22	6	2024-07-19 04:02:38.301081+00	2024-07-19 04:02:38.301103+00	f	\N	nx123	0.000	18999.00	18000.000	18000.000	14999.00	2024-07-19	2026-06-19	3	fc9666f2-41d0-4fa6-bf5c-4db92128a936	056aa641-cd7c-4c1e-8fa0-e550389cc20d	3	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
e11893be-b3ca-4afa-a8cf-1dc81ae2ce84	8	2024-07-20 04:30:48.712816+00	2024-07-20 04:30:48.712835+00	f	\N	H01	20.000	450.00	400.000	350.000	370.00	2024-07-20	2024-07-29	3	54180912-e5d3-4d34-ba3e-9d04e4cb4186	21635aff-43d8-427f-a860-63ee2c222807	3	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
ff88bf53-0826-4d4f-8666-ae673fd7047e	9	2024-07-20 05:13:28.282878+00	2024-07-20 05:13:28.282899+00	f	\N	H02	0.000	300.00	250.000	200.000	209.00	2024-07-20	2024-07-31	3	5e077b69-9011-499c-8103-19a1782192af	278157e3-7790-4abd-9554-a3ab71531026	3	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
069ab9ab-8c20-4dc7-b51b-bcc8c1d0f577	10	2024-07-20 06:10:34.144235+00	2024-07-20 06:10:34.14426+00	f	\N	H04	0.000	405.00	400.000	350.000	300.00	2024-07-20	2024-07-30	3	60b6dada-d7bc-46ec-8fa7-f0dc53bab3e1	80721a40-6322-40f3-be9a-d61ed9e6cf72	3	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
3223e640-1c8e-4b70-be96-657c6ab2e110	11	2024-07-20 06:30:42.503315+00	2024-07-20 06:30:42.50334+00	f	\N	H06	10.000	390.00	380.000	300.000	370.00	2024-07-20	2024-07-31	3	17a87076-bd9c-4ff5-a851-edaa5f6e9ac2	2794b11d-405d-4eeb-ba63-81b435931357	3	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
11893f47-a0e9-43f8-b99d-c86d9c159419	12	2024-07-20 06:45:39.491863+00	2024-07-20 06:45:39.491892+00	f	\N	H07	10.000	75.00	75.000	70.000	75.00	2024-07-20	2024-08-11	3	d3f906d5-0f4e-4c3d-9fd6-3c2fa2076b36	6826bd65-4fd1-4aa8-9aad-814048862f9f	3	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
1314fe90-54db-4085-83ab-b6e7666272f1	1	2024-07-18 14:31:44.851266+00	2024-07-18 14:31:44.851287+00	f	\N	18/07/24	9.000	245.00	199.000	175.000	150.00	2024-07-18	2024-07-18	1	e467db7f-0682-4944-bb68-24393a6ff779	fb3ae593-aa0f-4650-82f4-2024299ac010	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
e14b6d1b-840d-4913-836c-e390f47b6dea	14	2024-10-25 12:51:34.304114+00	2024-10-25 12:51:34.304137+00	f	\N	0DEFLT	23.000	220.00	195.000	190.000	160.00	2024-10-25	2024-10-31	1	ed362c81-e154-49bb-a5a3-88efb27d9870	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
48ab8d69-03a1-485b-b230-ed66b0e22c60	19	2025-07-28 08:43:19.749334+00	2025-07-28 08:43:19.749354+00	f	\N	230725	1.000	150.00	120.000	110.000	80.00	2025-07-02	2025-07-28	1	72238de2-9962-4f7e-bbc0-cdf7e366b264	9a7c44b8-79e7-476f-8fb0-6d10fec63f75	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
13e0d4ed-9071-40c2-b536-a4d7c1ebe3a8	17	2025-05-06 12:11:26.642566+00	2025-05-06 12:11:26.642593+00	f	\N	DFLT0	5.000	30.00	25.000	15.000	8.00	2025-05-06	2025-05-07	1	8382e756-de7d-43fb-9e9d-2c341eb04395	4e290f81-d412-4025-acab-7b690f187583	1	\N
704832fc-98cd-48d5-b156-d66cb21caba9	15	2025-03-14 15:31:25.066682+00	2025-03-14 15:31:25.066712+00	f	\N	1242	200.000	200.00	195.000	150.000	145.00	2024-10-25	2026-06-10	1	ed362c81-e154-49bb-a5a3-88efb27d9870	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
0b2be5cd-c882-41b2-9daa-a6a0aca83058	13	2024-10-25 11:30:18.732247+00	2024-10-25 11:30:18.732274+00	f	\N	00	17.500	200.00	195.000	150.000	174.00	2024-10-25	2024-10-25	14	ed362c81-e154-49bb-a5a3-88efb27d9870	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3	14	6568014e-bb8e-4058-8abc-20b985c67d29
6d8e4b0b-dc44-41cb-8834-78835b3559bb	16	2025-04-02 13:50:45.12045+00	2025-04-02 13:50:45.120483+00	f	\N	1248	25.000	220.00	195.000	160.000	150.00	2025-04-01	2025-04-02	1	ed362c81-e154-49bb-a5a3-88efb27d9870	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
167a1337-86db-4a1f-b624-7f055d4276e9	18	2025-07-17 15:42:03.361815+00	2025-07-17 15:42:03.361827+00	f	\N	1248	9.000	120.00	120.000	110.000	80.00	2025-07-17	2025-07-17	1	ed362c81-e154-49bb-a5a3-88efb27d9870	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3	1	e9c91e4d-271c-4063-90d0-87038135e85e
\.


--
-- Data for Name: general_charge_per_kilometer; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.general_charge_per_kilometer (id, charge, is_deleted) FROM stdin;
\.


--
-- Data for Name: general_charge_setting; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.general_charge_setting (id, no_delivery_charge_amount, no_free_delivery_amount, vendor_id, warehouse_id) FROM stdin;
38b37123-0126-482c-8aea-cd5aeac42963	5000.00	0.00	\N	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
\.


--
-- Data for Name: general_damaged_product; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.general_damaged_product (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, date, quantity, amount, description, batch_id, creator_id, product_variant_id, updater_id, warehouse_id) FROM stdin;
\.


--
-- Data for Name: general_delivery_charge; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.general_delivery_charge (id, normal_charge, express_charge, is_deleted, to_zone_id, vendor_id, warehouse_id) FROM stdin;
c94837da-3db6-4e38-b85b-2f2fb53b79f5	0.00	20.00	f	4859	\N	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
\.


--
-- Data for Name: invoic_prefix; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.invoic_prefix (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, retail_sale, "order", purchase, is_active, creator_id, financial_year_id, updater_id) FROM stdin;
b1f380c7-02dc-4aa1-b52f-6f4af14ac7b0	1	2024-07-25 07:07:44.985297+00	2024-07-25 07:07:44.98532+00	f	\N	NXR	NXO	NXP	t	1	1b5eb376-5b10-4b96-a3a6-3a2a49af94f6	1
6623f5eb-b7e8-4b15-96c9-d832616b280d	2	2025-04-02 14:00:07.851858+00	2025-04-02 14:00:07.851886+00	f	\N	NXS	NXO	NXP	t	1	0474f664-a3f4-4195-a943-15945636ec03	1
\.


--
-- Data for Name: invoice_design; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.invoice_design (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, title, image, is_active, creator_id, updater_id, warehouse_id) FROM stdin;
f5d0ec63-832f-4f55-9e2e-9315892f2963	1	2025-06-12 11:33:46.71597+00	2025-06-12 11:33:46.715997+00	f	\N	AL ARAFA	media/arafa_vegetables1_Nk7fU3u.jpg	t	1	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
\.


--
-- Data for Name: location; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.location (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, location, short_name, latitude, longitude, creator_id, updater_id) FROM stdin;
a5f82889-6258-44d0-b3d5-b436d145164c	1	2024-07-10 06:50:30.800275+00	2024-07-10 06:50:30.800296+00	f	\N	hi lite platino	hi lite platino	9.948372194467844	76.31983474077317	1	1
e5a98e43-4b32-400c-b699-9c81c1d57482	2	2024-07-17 12:46:12.298189+00	2024-07-17 12:46:12.29821+00	f	\N	PALODE	PALODE	8.5292447	76.9009191	1	1
cf9cc45a-2598-46bd-aace-3b67ef8ac152	4	2024-07-25 07:09:19.69556+00	2024-07-25 07:09:19.69559+00	f	\N	Pacha Post Office, Plavara, Nanniyode, Kerala, India	Pacha Post Office	\N	\N	1	1
6b33ea6e-3c2a-4d05-a684-be91d35b650d	5	2024-07-18 09:40:46.263032+00	2024-07-18 09:40:46.263058+00	f	\N	Palode, Palode - Peringammala Road, Pacha P.O, Pappanamcode, Palode, Kerala, India	Palode	9.9312328	76.2673041	1	1
fbc93a87-2c11-41fb-adc7-e4bb2256c96a	6	2024-10-25 09:45:44.616912+00	2024-10-25 09:45:44.616937+00	f	\N	kallara	kallara	8.7219753	77.0287467	1	1
08c0e367-36cf-4c0c-b83c-c0d67e55ca37	7	2024-10-25 12:33:51.943556+00	2024-10-25 12:33:51.943581+00	f	\N					5	5
6650c764-6c50-4d87-8c81-8c731c6107d3	8	2024-11-09 15:02:17.957498+00	2024-11-09 15:02:17.95753+00	f	\N	Palode, Kerala, India	Palode	8.7219821	77.0287546	1	1
8bd02c8b-d385-4aad-bfcb-93ef33c10a1e	9	2025-03-17 13:52:33.791248+00	2025-03-17 13:52:33.79127+00	f	\N	Palode - Peringammala Road, Pacha P.O, Pappanamcode, Palode, Kerala, India	Palode - Peringammala Road	9.928704	76.2904576	1	1
6585478f-d17d-4dbf-9229-86e3d766cb36	10	2025-05-06 11:20:03.38794+00	2025-05-06 11:20:03.387974+00	f	\N	Palode - Peringammala Road, Pacha P.O, Pappanamcode, Palode, Kerala, India	Palode - Peringammala Road	9.9811328	76.2937344	1	1
c7466895-450e-4beb-a354-d24ffd5a9c3c	11	2025-07-17 15:36:19.118685+00	2025-07-17 15:36:19.118702+00	f	\N	ATTINGAL	ATTINGAL	8.7031808	77.0146304	1	1
\.


--
-- Data for Name: mode; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.mode (id, readonly, maintenance, down) FROM stdin;
1	f	f	f
\.


--
-- Data for Name: offers; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.offers (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, title, offer_type, offer_percentage, start_time, end_time, image, category_id, creator_id, product_variant_id, subcategory_id, updater_id, warehouse_id) FROM stdin;
6a037c34-534b-4285-a58c-cf9cde94193c	1	2024-07-18 16:03:08.549394+00	2024-07-18 16:04:29.204501+00	f	\N	ONAM	product	20.00	2024-07-16 18:30:00+00	2024-07-17 18:30:00+00	media/61YtDlLNlHL._SL1000__od6DmLF.jpg	\N	1	fb3ae593-aa0f-4650-82f4-2024299ac010	\N	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
\.


--
-- Data for Name: offers_vouchercode; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.offers_vouchercode (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, voucher_code, title, description, voucher_type, start_time, end_time, minimum_order_amount, upto_limit, voucher_amount, percentage, is_limited_once, is_expired, creator_id, customer_id, product_id, product_variant_id, updater_id) FROM stdin;
85cb8ecf-e95a-4853-b31c-cd5a2e0d257c	1	2025-08-23 11:37:29.412057+00	2025-08-23 11:39:49.634584+00	f	\N	001	onam ofer	tt	30	2025-08-22 18:30:00+00	2025-08-23 18:30:00+00	1000.00	500.00	0.00	10.00	t	f	1	\N	72238de2-9962-4f7e-bbc0-cdf7e366b264	\N	1
\.


--
-- Data for Name: offers_vouchercode_used_users; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.offers_vouchercode_used_users (id, vouchercode_id, user_id) FROM stdin;
1	85cb8ecf-e95a-4853-b31c-cd5a2e0d257c	5
\.


--
-- Data for Name: orders_booking; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.orders_booking (id, date_added, is_deleted, message, status, customer_id, order_id, product_variant_id) FROM stdin;
a25a3390-a341-42e8-9a56-6ba7559d3ea3	2024-07-19 08:41:21.700899+00	f		pending	8b088dbe-d285-4102-af99-99458874e155	\N	bb827cf8-daa6-402c-a7cb-e8a8936c04ac
5e054060-92f8-450d-bced-9c92ab3c5e89	2024-07-28 05:54:19.21659+00	f		pending	228854d7-8247-40b9-9ed1-9e46486133ca	\N	80721a40-6322-40f3-be9a-d61ed9e6cf72
61f9a3cb-614d-4bbb-aa9b-0ec9504380b8	2024-07-28 05:55:31.672278+00	f		pending	228854d7-8247-40b9-9ed1-9e46486133ca	\N	7df72a13-0cd4-4417-bb5b-842ab39fd10c
791f51f5-1c26-4738-966e-9d106452a66d	2024-08-21 09:35:25.694649+00	f		pending	52a91ff2-766b-4273-aa8d-04fd1506fda4	\N	7df72a13-0cd4-4417-bb5b-842ab39fd10c
9ec5e5fb-4bb6-491c-81b0-dfa56480a548	2024-08-21 10:00:33.513871+00	f		pending	d07c6743-c976-4227-9148-e1c9b0e6d6a5	\N	7df72a13-0cd4-4417-bb5b-842ab39fd10c
3367dabe-109c-4788-8227-8314ee55ecb3	2024-10-24 08:48:03.152382+00	f		pending	37f01573-c73c-4a29-8188-adff1d6b92de	\N	7df72a13-0cd4-4417-bb5b-842ab39fd10c
589e9c45-98a9-4e8c-91b0-9d6d8ceefcf4	2024-10-25 11:30:55.12715+00	f		confirmed	760a809a-b409-44bf-83cb-79f76762cece	\N	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3
d2a64d78-9a74-4c01-94f8-e5570888f29a	2025-05-06 12:18:27.183252+00	f		pending	760a809a-b409-44bf-83cb-79f76762cece	\N	4e290f81-d412-4025-acab-7b690f187583
9ef5ab5d-df30-46d0-b8bf-9b97865f536c	2025-05-06 12:18:35.755724+00	f		pending	760a809a-b409-44bf-83cb-79f76762cece	\N	4e290f81-d412-4025-acab-7b690f187583
d6c18235-ad7d-4df6-ad48-c15478d35d07	2025-08-27 14:41:19.913705+00	f		confirmed	760a809a-b409-44bf-83cb-79f76762cece	\N	9a7c44b8-79e7-476f-8fb0-6d10fec63f75
63e3ab3e-088f-41a2-8f9c-2a7bf90463ce	2025-08-27 14:42:12.627704+00	f		confirmed	760a809a-b409-44bf-83cb-79f76762cece	\N	9a7c44b8-79e7-476f-8fb0-6d10fec63f75
a800b0c3-a974-4031-a9ed-6b3d05736d2c	2025-08-27 15:27:00.446264+00	f		pending	760a809a-b409-44bf-83cb-79f76762cece	\N	4e290f81-d412-4025-acab-7b690f187583
\.


--
-- Data for Name: orders_orderitem; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.orders_orderitem (id, date_added, is_deleted, qty, price, status, igst_rate, cgst_rate, sgst_rate, igst_amount, cgst_amount, sgst_amount, is_cancelled, date_cancelled, batch_id, order_id, product_variant_id) FROM stdin;
10b28c67-d66b-4d70-8012-9f328b41fe89	2024-07-25 07:10:26.980157+00	f	1.00	199.00	10	0.00	0.00	0.00	0.00	0.00	0.00	f	\N	1314fe90-54db-4085-83ab-b6e7666272f1	fb59dc79-6346-4131-a487-6facd520deb1	fb3ae593-aa0f-4650-82f4-2024299ac010
e5a4f405-9bdf-431b-99ae-c1a929ffac50	2024-10-25 12:41:49.912799+00	f	1.00	195.00	30	0.00	0.00	0.00	0.00	0.00	0.00	f	\N	0b2be5cd-c882-41b2-9daa-a6a0aca83058	5b0440b0-1e7a-4184-8e40-e0d0d463fad2	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3
69588214-c397-4d43-83a7-35d5e4c0f1d5	2024-10-26 07:51:59.077898+00	f	1.00	195.00	10	0.00	0.00	0.00	0.00	0.00	0.00	f	\N	e14b6d1b-840d-4913-836c-e390f47b6dea	6eae223e-dbb0-47cb-8b35-5663bff78f5c	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3
53c1fac5-24c5-4370-bd03-ac457a7cd932	2024-11-01 14:24:57.034179+00	f	1.00	195.00	10	0.00	0.00	0.00	0.00	0.00	0.00	f	\N	0b2be5cd-c882-41b2-9daa-a6a0aca83058	a9865e0d-efd2-4cda-b506-38745c4b964f	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3
3214fd95-b909-4361-a8b3-e2b6f5e1201b	2024-11-01 14:39:19.374298+00	f	1.00	195.00	10	0.00	0.00	0.00	0.00	0.00	0.00	f	\N	0b2be5cd-c882-41b2-9daa-a6a0aca83058	857bb7ad-fdaa-4dfc-b267-d7f152caad6a	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3
7c4e73e9-f7c5-449d-a889-be58c042f9e3	2025-03-17 13:53:33.020253+00	f	2.50	195.00	30	0.00	0.00	0.00	0.00	0.00	0.00	f	\N	0b2be5cd-c882-41b2-9daa-a6a0aca83058	7aad7a57-fa87-43da-9169-705f79c3761d	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3
7f9da5f9-5d88-43ee-8c74-d6ef590d594e	2024-11-09 18:37:24.813468+00	f	1.00	195.00	30	0.00	0.00	0.00	0.00	0.00	0.00	f	\N	0b2be5cd-c882-41b2-9daa-a6a0aca83058	88d5515f-d134-463f-be88-b13947cb6b18	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3
f2bc93e0-c47b-4fa8-aea5-abfb973005d1	2024-11-01 14:21:30.25827+00	f	1.00	195.00	30	0.00	0.00	0.00	0.00	0.00	0.00	f	\N	e14b6d1b-840d-4913-836c-e390f47b6dea	114ae1a5-b78a-43bc-a0f9-e96344ae3de7	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3
10de7280-dd81-4f1a-bd6b-00e3d99cce4e	2025-03-18 08:47:19.786024+00	f	1.00	200.00	10	0.00	0.00	0.00	0.00	0.00	0.00	f	\N	0b2be5cd-c882-41b2-9daa-a6a0aca83058	31be0891-965b-4162-b73c-ee1731d7889d	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3
5427caad-c2a4-4232-a8f8-7698e42612c6	2025-04-02 11:17:42.131815+00	f	3.00	195.00	10	0.00	0.00	0.00	0.00	0.00	0.00	f	\N	e14b6d1b-840d-4913-836c-e390f47b6dea	a3dda155-ea06-491f-9ae6-a913b9fe7e42	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3
a279b687-bd75-4050-bbd2-333e53bed212	2025-04-02 11:18:13.878904+00	f	1.00	195.00	10	0.00	0.00	0.00	0.00	0.00	0.00	f	\N	e14b6d1b-840d-4913-836c-e390f47b6dea	a5506384-4ed8-4830-86ff-72f84635166c	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3
1f572b46-c2a0-4460-9a01-6c48857f2aa9	2025-04-02 11:19:40.26102+00	f	2.00	195.00	30	0.00	0.00	0.00	0.00	0.00	0.00	f	\N	e14b6d1b-840d-4913-836c-e390f47b6dea	19f84703-0c42-401a-af84-0f433b9e654a	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3
6517cec2-c6f6-4583-afa3-66169213ab8c	2025-05-06 10:50:15.52928+00	f	1.00	195.00	10	0.00	0.00	0.00	0.00	0.00	0.00	f	\N	e14b6d1b-840d-4913-836c-e390f47b6dea	a7cb2c11-7368-4ac0-aef2-769d8ae88f1b	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3
7c841de7-3917-4209-845f-03348a1e62f5	2025-04-02 12:41:42.132109+00	f	1.00	195.00	30	0.00	0.00	0.00	0.00	0.00	0.00	f	\N	e14b6d1b-840d-4913-836c-e390f47b6dea	e18a0c3d-2b62-4bdb-b12f-8ab0c16c7a7d	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3
ab88f175-7343-49b1-859f-d0719d45cdf7	2025-07-09 17:02:09.254425+00	f	1.00	195.00	10	0.00	0.00	0.00	0.00	0.00	0.00	f	\N	e14b6d1b-840d-4913-836c-e390f47b6dea	d36f2b35-9555-41cb-b9ae-0b07a9e34b0e	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3
083bf495-0dfd-4f55-a700-311e92bbb9fe	2025-07-09 17:10:17.050515+00	f	2.00	195.00	10	0.00	0.00	0.00	0.00	0.00	0.00	f	\N	e14b6d1b-840d-4913-836c-e390f47b6dea	a8efc206-054e-4673-a530-2058b017e3f4	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3
26ff97a3-b743-4226-af88-c39791da09fa	2025-07-09 17:03:50.319071+00	f	2.00	195.00	30	0.00	0.00	0.00	0.00	0.00	0.00	f	\N	e14b6d1b-840d-4913-836c-e390f47b6dea	86271658-4301-4a08-9d00-32e2d535467a	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3
3a50839e-e36a-4273-997b-6634b1da5eee	2025-08-23 11:41:45.100992+00	f	6.00	110.00	10	0.00	0.00	0.00	0.00	0.00	0.00	f	\N	48ab8d69-03a1-485b-b230-ed66b0e22c60	b910a2f4-8321-41ba-ab1d-9c3ef2418e71	9a7c44b8-79e7-476f-8fb0-6d10fec63f75
2b06393e-925b-45dd-bc49-aa11911dba14	2025-08-23 11:48:36.370372+00	f	2.00	120.00	10	0.00	0.00	0.00	0.00	0.00	0.00	f	\N	48ab8d69-03a1-485b-b230-ed66b0e22c60	c7bb0e2f-eed1-4e82-aa28-ffd8a42108ac	9a7c44b8-79e7-476f-8fb0-6d10fec63f75
ebdf89ca-396e-4156-8c68-6f9586e5e953	2025-08-23 11:50:33.282616+00	f	2.00	120.00	30	0.00	0.00	0.00	0.00	0.00	0.00	f	\N	48ab8d69-03a1-485b-b230-ed66b0e22c60	9f9474eb-3469-445a-9fd5-e5204c0d5779	9a7c44b8-79e7-476f-8fb0-6d10fec63f75
6fff3312-0f4f-4d71-8ab5-0c9a40a2d7e0	2025-08-23 12:40:53.266341+00	f	3.00	120.00	30	0.00	0.00	0.00	0.00	0.00	0.00	f	\N	48ab8d69-03a1-485b-b230-ed66b0e22c60	f2bee48f-c828-40be-9440-dc323d0ebec6	9a7c44b8-79e7-476f-8fb0-6d10fec63f75
530a82ae-1110-401e-95c2-7454f19fa4de	2025-08-27 14:41:54.008235+00	f	1.00	150.00	10	0.00	0.00	0.00	0.00	0.00	0.00	f	\N	48ab8d69-03a1-485b-b230-ed66b0e22c60	228f9f57-36e0-447a-a197-dc784cf5cab8	9a7c44b8-79e7-476f-8fb0-6d10fec63f75
6138737a-0c85-4bcd-8fd7-e7f674e028ce	2025-08-27 14:44:23.11377+00	f	1.00	150.00	10	0.00	0.00	0.00	0.00	0.00	0.00	f	\N	48ab8d69-03a1-485b-b230-ed66b0e22c60	de9ec9bb-47c4-45e8-94ac-fe7c5c63ba0f	9a7c44b8-79e7-476f-8fb0-6d10fec63f75
e126c633-40fd-49b8-882b-bd321e26e073	2025-08-27 14:52:12.446469+00	f	1.00	195.00	10	0.00	0.00	0.00	0.00	0.00	0.00	f	\N	e14b6d1b-840d-4913-836c-e390f47b6dea	005a3987-9692-4d17-962e-bd8251bafc3d	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3
ec8fbef4-b2bf-4535-9adb-53e12e400607	2025-08-27 14:57:02.417555+00	f	1.00	195.00	10	0.00	0.00	0.00	0.00	0.00	0.00	f	\N	e14b6d1b-840d-4913-836c-e390f47b6dea	0771ef10-8b31-4bec-9416-6ff986abe745	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3
\.


--
-- Data for Name: orders_orders; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.orders_orders (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, billing_name, billing_phone, billing_street, billing_address, billing_landmark, billing_state, billing_city, billing_latitude, billing_longitude, delivery_date, order_status, payment_method, payment_status, assigned_time, delivery_agent_is_accept, delivery_agent_accepted_time, delivery_agent_declined_time, delivery_agent_declined_reason, delivery_agent_declined_reason_text, pickup_status, pickup_time, delivered_time, total_amt, wallet_amount, voucher_amount, card_name, card_number, transaction_id, payment_order_id, delivery_note, order_no, order_id, is_express_delivery, delivery_charge, is_manual, creator_id, customer_id, delivery_agent_id, prefix_id, receipt_voucher_id, time_slot_id, updater_id, vendor_id, warehouse_id, zone_id) FROM stdin;
6eae223e-dbb0-47cb-8b35-5663bff78f5c	3	2024-10-26 07:51:59.052313+00	2024-10-26 07:51:59.052339+00	f	\N	Riyas	9745212222	12	12	\N	Kerala	\N			\N	40	cod	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	195	0	0	\N	\N	\N	\N	\N	3	NXO000003	f	0	f	5	760a809a-b409-44bf-83cb-79f76762cece	\N	b1f380c7-02dc-4aa1-b52f-6f4af14ac7b0	\N	\N	5	\N	9e0cf2de-e2eb-4392-9188-951e2af1d3eb	4950
31be0891-965b-4162-b73c-ee1731d7889d	9	2025-03-18 08:47:19.780716+00	2025-03-18 08:47:19.780741+00	f	\N	Ss	9745020163	123	111	\N	Kerala	\N	\N	\N	\N	40	cod	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	200	0	0	\N	\N	\N	\N	\N	9	NXO000009	f	\N	f	1	760a809a-b409-44bf-83cb-79f76762cece	\N	b1f380c7-02dc-4aa1-b52f-6f4af14ac7b0	\N	\N	1	\N	6568014e-bb8e-4058-8abc-20b985c67d29	4705
a5506384-4ed8-4830-86ff-72f84635166c	11	2025-04-02 11:18:13.849892+00	2025-04-02 11:18:13.849915+00	f	\N	Ss	9745020163	123	111	\N	Kerala	\N			\N	40	cod	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	195	0	0	\N	\N	\N	\N	\N	11	NXO000011	f	0	f	5	760a809a-b409-44bf-83cb-79f76762cece	\N	b1f380c7-02dc-4aa1-b52f-6f4af14ac7b0	\N	\N	5	\N	9e0cf2de-e2eb-4392-9188-951e2af1d3eb	4859
857bb7ad-fdaa-4dfc-b267-d7f152caad6a	6	2024-11-01 14:39:19.35201+00	2024-11-01 14:39:19.352042+00	f	\N	Ss	9745020163	123	111	\N	Kerala	\N			\N	30	cod	10	2024-11-01 14:40:26.633267+00	t	2024-11-01 14:40:42.663422+00	\N	\N	\N	picked_up	2024-11-01 14:42:50.932032+00	2024-11-01 14:42:31.07313+00	195	0	0	\N	\N	\N	\N	\N	6	NXO000006	f	0	f	5	760a809a-b409-44bf-83cb-79f76762cece	b76e6884-bfec-49d9-ac6e-3a867ae40408	b1f380c7-02dc-4aa1-b52f-6f4af14ac7b0	\N	\N	5	\N	6568014e-bb8e-4058-8abc-20b985c67d29	4705
fb59dc79-6346-4131-a487-6facd520deb1	1	2024-07-25 07:10:26.973263+00	2024-07-25 10:38:33.954859+00	f	\N	yaseen Talrop	9605788656	talrop	tegain	Talrop	Kerala	\N	\N	\N	2024-07-25	30	cod	10	2024-07-25 07:10:36.171042+00	t	2024-07-25 07:19:53.527892+00	\N	\N	\N	picked_up	2024-07-25 07:20:20.233301+00	2024-07-25 07:20:13.054615+00	199	0	0	\N	\N	\N	\N		1	NXO000001	f	0	f	1	338ef566-78a3-40cc-95e4-551ea5f8f46d	b76e6884-bfec-49d9-ac6e-3a867ae40408	b1f380c7-02dc-4aa1-b52f-6f4af14ac7b0	\N	c03b4196-8920-416f-9607-64b18a3646f9	1	\N	9e0cf2de-e2eb-4392-9188-951e2af1d3eb	4950
e18a0c3d-2b62-4bdb-b12f-8ab0c16c7a7d	13	2025-04-02 12:41:42.103985+00	2025-04-02 12:41:42.104018+00	f	\N	Ss	9745020163	123	111	\N	Kerala	\N			\N	30	cod	10	2025-07-09 11:32:09.308631+00	t	2025-04-02 12:44:16.295861+00	\N	\N	\N	picked_up	2025-04-02 12:44:53.133911+00	2025-04-02 12:44:50.491921+00	195	0	0	\N	\N	\N	\N	\N	13	NXO000013	f	0	f	5	760a809a-b409-44bf-83cb-79f76762cece	b76e6884-bfec-49d9-ac6e-3a867ae40408	b1f380c7-02dc-4aa1-b52f-6f4af14ac7b0	\N	\N	5	\N	9e0cf2de-e2eb-4392-9188-951e2af1d3eb	4859
19f84703-0c42-401a-af84-0f433b9e654a	12	2025-04-02 11:19:40.237373+00	2025-04-02 11:19:40.237402+00	f	\N	Ss	9745020163	123	111	\N	Kerala	\N			\N	40	cod	10	2025-04-02 11:21:19.498213+00	t	2025-04-02 11:21:59.583645+00	\N	\N	\N	picked_up	2025-04-02 11:24:48.019244+00	2025-04-02 11:24:41.278251+00	390	0	0	\N	\N	\N	\N	\N	12	NXO000012	f	0	f	5	760a809a-b409-44bf-83cb-79f76762cece	b76e6884-bfec-49d9-ac6e-3a867ae40408	b1f380c7-02dc-4aa1-b52f-6f4af14ac7b0	\N	\N	5	\N	9e0cf2de-e2eb-4392-9188-951e2af1d3eb	4859
7aad7a57-fa87-43da-9169-705f79c3761d	8	2025-03-17 13:53:33.007859+00	2025-03-17 13:53:33.007888+00	f	\N	Ismail	7594818072	PLD	ASA	\N	Kerala	\N	9.928704	76.2904576	2025-03-17	30	cod	10	2025-03-17 13:54:01.205022+00	t	2025-03-17 13:57:12.700277+00	\N	\N	\N	picked_up	2025-03-17 13:57:50.376883+00	2025-03-17 13:57:31.240627+00	487.5	0	0	\N	\N	\N	\N		8	NXO000008	f	20	f	1	c6488465-a403-4642-92ce-210e51956062	b76e6884-bfec-49d9-ac6e-3a867ae40408	b1f380c7-02dc-4aa1-b52f-6f4af14ac7b0	\N	c03b4196-8920-416f-9607-64b18a3646f9	1	\N	6568014e-bb8e-4058-8abc-20b985c67d29	4859
a9865e0d-efd2-4cda-b506-38745c4b964f	5	2024-11-01 14:24:57.012966+00	2024-11-01 14:24:57.012989+00	f	\N	Ss	9745020163	123	111	\N	Kerala	\N			\N	30	cod	10	2024-11-01 14:26:04.851536+00	t	2024-11-01 14:27:09.845153+00	\N	\N	\N	picked_up	2024-11-01 14:35:57.572982+00	2024-11-01 14:35:53.210375+00	195	0	0	\N	\N	\N	\N	\N	5	NXO000005	f	0	f	5	760a809a-b409-44bf-83cb-79f76762cece	b76e6884-bfec-49d9-ac6e-3a867ae40408	b1f380c7-02dc-4aa1-b52f-6f4af14ac7b0	\N	\N	5	\N	6568014e-bb8e-4058-8abc-20b985c67d29	4705
114ae1a5-b78a-43bc-a0f9-e96344ae3de7	4	2024-11-01 14:21:30.23216+00	2025-03-17 14:16:14.784316+00	f	\N	Riyas	9745212222	12	12	\N	Kerala	\N			\N	30	cod	10	2025-03-17 14:13:47.048631+00	t	2025-03-17 14:14:22.736152+00	\N	\N	\N	picked_up	2025-03-17 14:15:42.800487+00	2025-03-17 14:14:51.379496+00	195	0	0	\N	\N	\N	\N	\N	4	NXO000004	f	0	f	5	760a809a-b409-44bf-83cb-79f76762cece	b76e6884-bfec-49d9-ac6e-3a867ae40408	b1f380c7-02dc-4aa1-b52f-6f4af14ac7b0	\N	\N	5	\N	9e0cf2de-e2eb-4392-9188-951e2af1d3eb	4950
a3dda155-ea06-491f-9ae6-a913b9fe7e42	10	2025-04-02 11:17:42.109751+00	2025-04-02 11:17:42.109774+00	f	\N	Ss	9745020163	123	111	\N	Kerala	\N			\N	10	cod	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	585	0	0	\N	\N	\N	\N	\N	10	NXO000010	f	0	f	5	760a809a-b409-44bf-83cb-79f76762cece	\N	b1f380c7-02dc-4aa1-b52f-6f4af14ac7b0	\N	\N	5	\N	9e0cf2de-e2eb-4392-9188-951e2af1d3eb	4859
5b0440b0-1e7a-4184-8e40-e0d0d463fad2	2	2024-10-25 12:41:49.873059+00	2024-10-25 12:41:49.873095+00	f	\N	Riyas	9745212222	12	12	\N	Kerala	\N			\N	40	cod	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	195	0	0	\N	\N	\N	\N	\N	2	NXO000002	f	0	f	5	760a809a-b409-44bf-83cb-79f76762cece	\N	b1f380c7-02dc-4aa1-b52f-6f4af14ac7b0	\N	\N	5	\N	6568014e-bb8e-4058-8abc-20b985c67d29	4840
88d5515f-d134-463f-be88-b13947cb6b18	7	2024-11-09 18:37:24.789223+00	2024-11-09 18:37:24.789247+00	f	\N	Ss	9745020163	123	111	\N	Kerala	\N			\N	40	cod	10	2025-03-17 14:03:47.962238+00	f	\N	2025-03-17 14:01:07.770332+00	Large order list	Hhh	\N	\N	\N	195	0	0	\N	\N	\N	\N	\N	7	NXO000007	f	0	f	5	760a809a-b409-44bf-83cb-79f76762cece	b76e6884-bfec-49d9-ac6e-3a867ae40408	b1f380c7-02dc-4aa1-b52f-6f4af14ac7b0	\N	\N	5	\N	6568014e-bb8e-4058-8abc-20b985c67d29	4705
a7cb2c11-7368-4ac0-aef2-769d8ae88f1b	14	2025-05-06 10:50:15.232594+00	2025-07-09 17:33:16.205901+00	f	\N	Riyas	9745020163	123	111	\N	Kerala	\N			2025-05-06	40	Cash On Delivery	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	195	0	0	\N	\N	\N	\N	\N	14	NXO000014	f	0	f	5	760a809a-b409-44bf-83cb-79f76762cece	\N	b1f380c7-02dc-4aa1-b52f-6f4af14ac7b0	\N	e7d2922c-0ca8-481d-b927-7449728f6889	5	\N	9e0cf2de-e2eb-4392-9188-951e2af1d3eb	4859
86271658-4301-4a08-9d00-32e2d535467a	16	2025-07-09 17:03:50.282599+00	2025-07-09 17:25:52.491781+00	f	\N	Riyas	9745020163	123	111	\N	Kerala	\N			\N	30	cod	10	2025-07-12 14:33:31.49678+00	t	2025-07-09 17:24:22.242987+00	\N	\N	\N	picked_up	2025-07-09 17:26:16.699818+00	2025-07-09 17:25:58.305908+00	390	0	0	\N	\N	\N	\N	\N	2	NXO000002	f	0	f	5	760a809a-b409-44bf-83cb-79f76762cece	b76e6884-bfec-49d9-ac6e-3a867ae40408	6623f5eb-b7e8-4b15-96c9-d832616b280d	\N	\N	5	\N	9e0cf2de-e2eb-4392-9188-951e2af1d3eb	4859
b910a2f4-8321-41ba-ab1d-9c3ef2418e71	18	2025-08-23 11:41:44.837013+00	2025-08-23 11:41:44.837036+00	f	\N	Riyas	9745020163	123	111	\N	Kerala	\N			2025-08-23	10	Cash On Delivery	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	594	0	66	\N	\N	\N	\N	\N	15	NXO000015	f	0	f	5	760a809a-b409-44bf-83cb-79f76762cece	\N	b1f380c7-02dc-4aa1-b52f-6f4af14ac7b0	\N	\N	5	\N	9e0cf2de-e2eb-4392-9188-951e2af1d3eb	4859
a8efc206-054e-4673-a530-2058b017e3f4	17	2025-07-09 17:10:17.021211+00	2025-07-09 17:14:18.168562+00	f	\N	Riyas	9745020163	123	111	\N	Kerala	\N			\N	30	cod	10	2025-07-09 17:11:12.147565+00	t	2025-07-09 17:11:26.629021+00	\N	\N	\N	picked_up	2025-07-09 17:14:32.472704+00	2025-07-09 17:14:24.845737+00	390	0	0	\N	\N	\N	\N	\N	3	NXO000003	f	0	f	5	760a809a-b409-44bf-83cb-79f76762cece	b76e6884-bfec-49d9-ac6e-3a867ae40408	6623f5eb-b7e8-4b15-96c9-d832616b280d	\N	\N	5	\N	9e0cf2de-e2eb-4392-9188-951e2af1d3eb	4859
c7bb0e2f-eed1-4e82-aa28-ffd8a42108ac	19	2025-08-23 11:48:36.107293+00	2025-08-23 11:48:36.107316+00	f	\N	Riyas	9745020163	123	111	\N	Kerala	\N			2025-08-23	10	Cash On Delivery	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	174	0	66	\N	\N	\N	\N	\N	16	NXO000016	f	0	f	5	760a809a-b409-44bf-83cb-79f76762cece	\N	b1f380c7-02dc-4aa1-b52f-6f4af14ac7b0	\N	\N	5	\N	9e0cf2de-e2eb-4392-9188-951e2af1d3eb	4859
9f9474eb-3469-445a-9fd5-e5204c0d5779	20	2025-08-23 11:50:33.012628+00	2025-08-23 11:50:33.01265+00	f	\N	Riyas	9745020163	123	111	\N	Kerala	\N			2025-08-23	30	Cash On Delivery	10	2025-08-23 12:30:18.525418+00	t	2025-08-23 12:31:07.851356+00	\N	\N	\N	picked_up	2025-08-23 12:33:17.046713+00	2025-08-23 12:32:20.626889+00	174	0	66	\N	\N	\N	\N	\N	17	NXO000017	f	0	f	5	760a809a-b409-44bf-83cb-79f76762cece	b76e6884-bfec-49d9-ac6e-3a867ae40408	b1f380c7-02dc-4aa1-b52f-6f4af14ac7b0	\N	\N	5	\N	9e0cf2de-e2eb-4392-9188-951e2af1d3eb	4859
d36f2b35-9555-41cb-b9ae-0b07a9e34b0e	15	2025-07-09 17:02:09.226923+00	2025-07-09 17:31:59.392913+00	f	\N	Riyas	9745020163	123	111	\N	Kerala	\N			\N	40	cod	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	195	0	0	\N	\N	\N	\N	\N	1	NXO000001	f	0	f	5	760a809a-b409-44bf-83cb-79f76762cece	\N	6623f5eb-b7e8-4b15-96c9-d832616b280d	\N	\N	5	\N	9e0cf2de-e2eb-4392-9188-951e2af1d3eb	4859
0771ef10-8b31-4bec-9416-6ff986abe745	25	2025-08-27 14:57:01.83351+00	2025-08-27 14:57:01.833533+00	f	\N	Riyas	9745020163	123	111	\N	Kerala	\N			2025-08-27	10	Cash On Delivery	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	215	0	0	\N	\N	\N	\N	\N	20	NXO000020	f	20	f	5	760a809a-b409-44bf-83cb-79f76762cece	\N	b1f380c7-02dc-4aa1-b52f-6f4af14ac7b0	\N	\N	5	\N	9e0cf2de-e2eb-4392-9188-951e2af1d3eb	4859
f2bee48f-c828-40be-9440-dc323d0ebec6	21	2025-08-23 12:40:53.24435+00	2025-08-23 12:40:53.244373+00	f	\N	Riyas	9745020163	123	111	\N	Kerala	\N			\N	30	cod	10	2025-08-23 12:41:15.712249+00	t	2025-08-23 12:41:33.069782+00	\N	\N	\N	picked_up	2025-08-23 12:41:58.89089+00	2025-08-23 12:41:42.951496+00	324	0	36	\N	\N	\N	\N	\N	4	NXO000004	t	0	f	5	760a809a-b409-44bf-83cb-79f76762cece	b76e6884-bfec-49d9-ac6e-3a867ae40408	6623f5eb-b7e8-4b15-96c9-d832616b280d	\N	\N	5	\N	9e0cf2de-e2eb-4392-9188-951e2af1d3eb	4859
228f9f57-36e0-447a-a197-dc784cf5cab8	22	2025-08-27 14:41:54.00484+00	2025-08-27 14:41:54.004863+00	f	\N	Riyas	9745020163	123	111	\N	Kerala	\N	\N	\N	\N	10	cod	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	150	0	0	\N	\N	\N	\N	\N	18	NXO000018	f	\N	f	1	760a809a-b409-44bf-83cb-79f76762cece	\N	b1f380c7-02dc-4aa1-b52f-6f4af14ac7b0	\N	\N	1	\N	9e0cf2de-e2eb-4392-9188-951e2af1d3eb	4859
de9ec9bb-47c4-45e8-94ac-fe7c5c63ba0f	23	2025-08-27 14:44:23.109117+00	2025-08-27 14:44:23.109141+00	f	\N	Riyas	9745020163	123	111	\N	Kerala	\N	\N	\N	\N	10	cod	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	150	0	0	\N	\N	\N	\N	\N	19	NXO000019	f	\N	f	1	760a809a-b409-44bf-83cb-79f76762cece	\N	b1f380c7-02dc-4aa1-b52f-6f4af14ac7b0	\N	\N	1	\N	9e0cf2de-e2eb-4392-9188-951e2af1d3eb	4859
005a3987-9692-4d17-962e-bd8251bafc3d	24	2025-08-27 14:52:12.437827+00	2025-08-27 14:52:12.43785+00	f	\N	Riyas	9745020163	123	111	\N	Kerala	\N			2025-08-27	10	cod	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	215	0	0	\N	\N	\N	\N	hh	5	NXO000005	t	20	f	1	760a809a-b409-44bf-83cb-79f76762cece	\N	6623f5eb-b7e8-4b15-96c9-d832616b280d	\N	c03b4196-8920-416f-9607-64b18a3646f9	1	\N	9e0cf2de-e2eb-4392-9188-951e2af1d3eb	4859
\.


--
-- Data for Name: orders_timeslot; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.orders_timeslot (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, day, start_time, end_time, is_active, creator_id, updater_id) FROM stdin;
c03b4196-8920-416f-9607-64b18a3646f9	1	2024-07-18 15:16:10.065268+00	2024-07-18 15:16:10.065297+00	f	\N	1	07:00:00	08:30:00	t	1	1
79a990b3-3812-4ebd-a283-71b81b087d40	2	2025-03-17 14:22:05.43211+00	2025-03-17 14:22:05.432142+00	f	\N	1	07:10:00	08:05:00	t	1	1
6d9c27ab-0e3b-4f6a-9e07-5755767ca5a0	3	2025-05-06 10:42:42.682688+00	2025-05-06 10:42:42.682711+00	f	\N	1	07:11:00	10:16:00	t	1	1
8d2eac63-6ebe-4ac1-a2cf-faf0973b0fdc	4	2025-05-06 10:47:27.524986+00	2025-05-06 10:47:27.525007+00	f	\N	2	07:00:00	10:22:00	t	1	1
e7d2922c-0ca8-481d-b927-7449728f6889	5	2025-05-06 10:49:28.52626+00	2025-05-06 10:59:09.543911+00	f	\N	2	18:19:00	21:19:00	t	1	1
523e431c-a51b-4ded-bce6-ee64d643ca08	6	2025-08-27 14:53:37.445593+00	2025-08-27 14:53:37.445615+00	f	\N	1	20:23:00	21:24:00	t	1	1
\.


--
-- Data for Name: permission; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.permission (id, name, code, app) FROM stdin;
1	Manage Vendor	can_manage_vendor	vendors
2	Create Vendor	can_create_vendor	vendors
3	Modify Vendor	can_modify_vendor	vendors
4	View Vendor	can_view_vendor	vendors
5	Delete Vendor	can_delete_vendor	vendors
6	Manage Supplier	can_manage_supplier	suppliers
7	Create Supplier	can_create_supplier	suppliers
8	Modify Supplier	can_modify_supplier	suppliers
9	View Supplier	can_view_supplier	suppliers
10	Delete Supplier	can_delete_supplier	suppliers
11	Manage Customer	can_manage_customer	customers
12	Create Customer	can_create_customer	customers
13	Modify Customer	can_modify_customer	customers
14	View Customer	can_view_customer	customers
15	Delete Customer	can_delete_customer	customers
21	Manage Product	can_manage_product	products
22	Create Product	can_create_product	products
23	Modify Product	can_modify_product	products
24	View Product	can_view_product	products
25	Delete Product	can_delete_product	products
26	Manage HSN	can_manage_hsn	products
27	Create HSN	can_create_hsn	products
28	Modify HSN	can_modify_hsn	products
29	View HSN	can_view_hsn	products
30	Delete HSN	can_delete_hsn	products
36	Manage Staff Designation	can_manage_staff_designation	staffs
37	Create Staff Designation	can_create_staff_designation	staffs
38	Modify Staff Designation	can_modify_staff_designation	staffs
39	View Staff Designation	can_view_staff_designation	staffs
40	Delete Staff Designation	can_delete_staff_designation	staffs
41	Manage Staff	can_manage_staff	staffs
42	Create Staff	can_create_staff	staffs
43	Modify Staff	can_modify_staff	staffs
44	View Staff	can_view_staff	staffs
45	Delete Staff	can_delete_staff	staffs
46	Manage Purchase	can_manage_purchase	purchases
47	Create Purchase	can_create_purchase	purchases
48	Modify Purchase	can_modify_purchase	purchases
49	View Purchase	can_view_purchase	purchases
50	Delete Purchase	can_delete_purchase	purchases
51	Manage Product Category	can_manage_product_category	products
52	Create Product Category	can_create_product_category	products
53	Modify Product Category	can_modify_product_category	products
54	View Product Category	can_view_product_category	products
55	Delete Product Category	can_delete_product_category	products
56	Manage Product Sub-category	can_manage_product_subcategory	products
57	Create Product Sub-category	can_create_product_subcategory	products
58	Modify Product Sub-category	can_modify_product_subcategory	products
59	View Product Sub-category	can_view_product_subcategory	products
60	Delete Product Sub-category	can_delete_product_subcategory	products
66	Manage Sale	can_manage_sale	sales
67	Create Sale	can_create_sale	sales
68	Modify Sale	can_modify_sale	sales
69	View Sale	can_view_sale	sales
70	Delete Sale	can_delete_sale	sales
71	Manage Sale Return	can_manage_sale_return	sales
72	Create Sale Return	can_create_sale_return	sales
73	Modify Sale Return	can_modify_sale_return	sales
74	View Sale Return	can_view_sale_return	sales
75	Delete Sale Return	can_delete_sale_return	sales
76	Manage Warehouse	can_manage_warehouse	warehouses
77	Create Warehouse	can_create_warehouse	warehouses
78	Modify Warehouse	can_modify_warehouse	warehouses
79	View Warehouse	can_view_warehouse	warehouses
80	Delete Warehouse	can_delete_warehouse	warehouses
81	Manage PDC	can_manage_pdc	finance
82	Create PDC	can_create_pdc	finance
83	Modify PDC	can_modify_pdc	finance
84	View PDC	can_view_pdc	finance
85	Delete PDC	can_delete_pdc	finance
86	Manage Purchase Return	can_manage_purchase_return	purchases
87	Create Purchase Return	can_create_purchase_return	purchases
88	Modify Purchase Return	can_modify_purchase_return	purchases
89	View Purchase Return	can_view_purchase_return	purchases
90	Delete Purchase Return	can_delete_purchase_return	purchases
91	Manage Location	can_manage_location	warehouses
92	Create Location	can_create_location	warehouses
93	Modify Location	can_modify_location	warehouses
94	View Location	can_view_location	warehouses
95	Delete Location	can_delete_location	warehouses
111	Manage Staff Salary	can_manage_staff_salary	staffs
112	Create Staff Salary	can_create_staff_salary	staffs
113	Modify Staff Salary	can_modify_staff_salary	staffs
114	View Staff Salary	can_view_staff_salary	staffs
115	Delete Staff Salary	can_delete_staff_salary	staffs
116	Manage Staff Attendance	can_manage_staff_attendance	staffs
117	Create Staff Attendance	can_create_staff_attendance	staffs
118	Modify Staff Attendance	can_modify_staff_attendance	staffs
119	View Staff Attendance	can_view_staff_attendance	staffs
120	Delete Staff Attendance	can_delete_staff_attendance	staffs
121	Manage Cash Reciept	can_manage_cash_reciept	finance
122	Create Cash Reciept	can_create_cash_reciept	finance
123	Modify Cash Reciept	can_modify_cash_reciept	finance
124	View Cash Reciept	can_view_cash_reciept	finance
125	Delete Cash Reciept	can_delete_cash_reciept	finance
126	Manage Cash Payment	can_manage_cash_payment	finance
127	Create Cash Payment	can_create_cash_payment	finance
128	Modify Cash Payment	can_modify_cash_payment	finance
129	View Cash Payment	can_view_cash_payment	finance
130	Delete Cash Payment	can_delete_cash_payment	finance
131	Manage Bank Reciept	can_manage_bank_reciept	finance
132	Create Bank Reciept	can_create_bank_reciept	finance
133	Modify Bank Reciept	can_modify_bank_reciept	finance
134	View Bank Reciept	can_view_bank_reciept	finance
135	Delete Bank Reciept	can_delete_bank_reciept	finance
136	Manage Bank Payment	can_manage_bank_payment	finance
137	Create Bank Payment	can_create_bank_payment	finance
138	Modify Bank Payment	can_modify_bank_payment	finance
139	View Bank Payment	can_view_bank_payment	finance
140	Delete Bank Payment	can_delete_bank_payment	finance
146	Manage Bank Account	can_manage_bank_account	accounts
147	Create Bank Account	can_create_bank_account	accounts
148	Modify Bank Account	can_modify_bank_account	accounts
149	View Bank Account	can_view_bank_account	accounts
150	Delete Bank Account	can_delete_bank_account	accounts
151	Manage Cash Account	can_manage_cash_account	finance
152	Create Cash Account	can_create_cash_account	finance
153	Modify Cash Account	can_modify_cash_account	finance
154	View Cash Account	can_view_cash_account	finance
155	Delete Cash Account	can_delete_cash_account	finance
156	Manage Brand	can_manage_brand	products
157	Create Brand	can_create_brand	products
158	Modify Brand	can_modify_brand	products
159	View Brand	can_view_brand	products
160	Delete Brand	can_delete_brand	products
161	View Cash Day Book	can_view_cash_day_book	accounts
162	View Bank Day Book	can_view_bank_day_book	accounts
163	View Trial Balance	can_view_trial_balance	reports
164	View Balance Sheet	can_view_balance_sheet	reports
165	View Trading Profit and Loss	can_view_trading_profit_and_loss	reports
166	View PDC Issued	can_view_pdc_issued	accounts
167	View PDC Received	can_view_pdc_received	accounts
168	Update PDC Issued	can_update_pdc_issued	accounts
169	Update PDC Received	can_update_pdc_received	accounts
170	View Account Group	can_view_account_group	accounts
171	Manage Account Group	can_manage_account_group	accounts
172	Create Account Group	can_create_account_group	accounts
173	Modify Account Group	can_modify_account_group	accounts
174	Delete Account Group	can_delete_account_group	accounts
175	View Account Head	can_view_account_head	accounts
176	Manage Account Head	can_manage_account_head	accounts
177	Create Account Head	can_create_account_head	accounts
178	Modify Account Head	can_modify_account_head	accounts
179	Delete Account Head	can_delete_account_head	accounts
180	View Payment Voucher	can_view_payment_voucher	accounts
181	Manage Payment Voucher	can_manage_payment_voucher	accounts
182	Create Payment Voucher	can_create_payment_voucher	accounts
183	Modify Payment Voucher	can_modify_payment_voucher	accounts
184	Delete Payment Voucher	can_delete_payment_voucher	accounts
185	View Receipt Voucher	can_view_receipt_voucher	accounts
186	Manage Receipt Voucher	can_manage_receipt_voucher	accounts
187	Create Receipt Voucher	can_create_receipt_voucher	accounts
188	Modify Receipt Voucher	can_modify_receipt_voucher	accounts
189	Delete Receipt Voucher	can_delete_receipt_voucher	accounts
190	View Journal Voucher	can_view_journal_voucher	accounts
191	Manage Journal Voucher	can_manage_journal_voucher	accounts
192	Create Journal Voucher	can_create_journal_voucher	accounts
193	Modify Journal Voucher	can_modify_journal_voucher	accounts
194	Delete Journal Voucher	can_delete_journal_voucher	accounts
195	Franchisee Permissions	is_franchisee	franchisee
196	View GSTR-1 Report	can_view_gstr1_report	reports
197	View GSTR-2 Report	can_view_gstr2_report	reports
198	View GSTR-3 Report	can_view_gstr3_report	reports
199	View Sales Report	can_view_sales_report	reports
200	Create Credit Note Voucher	can_create_credit_note_voucher	accounts
201	View Credit Note Voucher	can_view_credit_note_voucher	accounts
202	Manage Credit Note Voucher	can_manage_credit_note_voucher	accounts
203	Modify Credit Note Voucher	can_modify_credit_note_voucher	accounts
204	Delete Credit Note Voucher	can_delete_credit_note_voucher	accounts
205	Create Debit Note Voucher	can_create_debit_note_voucher	accounts
206	View Debit Note Voucher	can_view_debit_note_voucher	accounts
207	Manage Debit Note Voucher	can_manage_debit_note_voucher	accounts
208	Modify Debit Note Voucher	can_modify_debit_note_voucher	accounts
209	Delete Debit Note Voucher	can_delete_debit_note_voucher	accounts
210	Can View Franchisee Sales	can_view_franchisee_sales	franchisee
211	Can View Franchisee Purchases	can_view_franchisee_purchases	franchisee
212	Can View Franchisee Report	can_view_franchisee_report	franchisee
213	Can Collect Royalty 	can_create_royalty_collection	franchisee
214	Can View Franchisee Report	can_manage_royalty_collection	franchisee
215	Can Verify Franchisee	can_verify_franchisee	franchisee
216	Can Update Royalty Percentage	can_update_royalty_percentage	admin
217	Create Salary Payment	can_create_salary_payment	staffs
218	View Salary Payment	can_view_salary_payment	staffs
219	Modify Salary Payment	can_delete_salary_payment	staffs
220	Can View Franchisee Products	can_manage_franchisee_product	franchisee
221	Can Set Discount Limit	can_set_discount_limit	admin
222	Can Update Product Discount Limit	can_update_product_discount_limit	admin
223	Can Set Admin Privileges	can_set_admin_privileges	admin
224	Can Update Product Opening Stock	can_update_product_opening_stock	admin
225	Can Update Opening Balance	can_update_opening_balance	admin
226	Can Set Product Selling Price	can_update_product_selling_price	admin
227	Can Set Customer To Get Special Discount	make_customer_special_discount_accessible	admin
228	Can Set Special Discount Percentage	can_set_special_discount_percentage	admin
229	Can View Bank Reconciliation Statements	can_view_bank_reconciliation	reports
230	Create Petty Cash Entry	can_create_petty_cash_entry	accounts
231	View Petty Cash Entry	can_view_petty_cash_entry	accounts
232	Manage Petty Cash Entry	can_manage_petty_cash_entry	accounts
233	Modify Petty Cash Entry	can_modify_petty_cash_entry	accounts
234	Delete Petty Cash Entry	can_delete_petty_cash_entry	accounts
235	Create Deal	can_create_deal	offers
236	View Deal	can_view_deal	offers
237	Manage Deal	can_manage_deal	offers
238	Modify Deal	can_modify_deal	offers
239	Delete Deal	can_delete_deal	offers
240	Create Damaged Products	can_create_damaged_product	products
241	View Damaged Products	can_view_damaged_product	products
242	Manage Damaged Products	can_manage_damaged_product	products
243	Modify Damaged Products	can_modify_damaged_product	products
244	Delete Damaged Products	can_delete_damaged_product	products
245	Create Financial Year	can_create_damaged_product	finance
246	View Financial Year	can_view_financial_year	finance
247	Manage Financial Year	can_manage_financial_year	finance
248	Modify Financial Year	can_modify_financial_year	finance
249	Delete Financial Year	can_delete_financial_year	finance
250	Create Offer	can_create_offer	offers
251	View Offer	can_view_offer	offers
252	Manage Offer	can_manage_offer	offers
253	Modify Offer	can_modify_offer	offers
254	Delete Offer	can_delete_offer	offers
255	Create Petty Cash Vocuher	can_create_petty_cash_voucher	accounts
256	View Petty Cash Vocuher	can_view_petty_cash_voucher	accounts
257	Manage Petty Cash Vocuher	can_manage_petty_cash_voucher	accounts
258	Modify Petty Cash Vocuher	can_modify_petty_cash_voucher	accounts
259	Delete Petty Cash Vocuher	can_delete_petty_cash_voucher	accounts
260	Can View Ledgers	can_view_ledgers	accounts
261	Create Vendor Category	can_create_vendor_category	accounts
262	View Vendor Category	can_view_vendor_category	accounts
263	Manage Vendor Category	can_manage_vendor_category	accounts
264	Modify Vendor Category	can_modify_vendor_category	accounts
265	Delete Vendor Category	can_delete_vendor_category	accounts
272	Create Income Expense	can_create_income_expense	accounts
273	View Income Expense	can_view_income_expense	accounts
274	Manage Income Expense	can_manage_income_expense	accounts
275	Modify Income Expense	can_modify_income_expense	accounts
276	Delete Income Expense	can_delete_income_expense	accounts
\.


--
-- Data for Name: privilege_point_history; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.privilege_point_history (id, title, point_type, points, value_in_amount, date_added, is_deleted, customer_id) FROM stdin;
\.


--
-- Data for Name: privilege_points; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.privilege_points (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, minimum_amount, value_of_point, point_gained_online, point_gained_offline, creator_id, updater_id) FROM stdin;
\.


--
-- Data for Name: product_hsn_code; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.product_hsn_code (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, name, hsn_number, description, igst_rate, sgst_rate, cgst_rate, vendor_created, is_admin_approved, creator_id, unit_id, updater_id) FROM stdin;
e2e568cc-15e9-4410-a17b-728935fed61b	1	2024-07-18 12:54:53.66771+00	2024-07-18 12:54:53.667731+00	f	\N	BROILER CHICKEN	01051199	\N	0.00	0.00	0.00	f	t	1	f445a5da-7c5d-433a-859e-0e56e2f00003	1
32159855-cb56-4e3b-825e-ef113902480e	2	2024-07-18 16:05:09.870839+00	2024-07-18 16:05:09.870862+00	f	\N	Dettol Original Germ Protection Bathing Soap	34011941	\N	0.00	0.00	0.00	f	t	3	f445a5da-7c5d-433a-859e-0e56e2f00002	3
2716e45b-efee-4439-b180-5b4ca1ba3b87	3	2024-07-18 16:20:48.473316+00	2024-07-18 16:20:48.473337+00	f	\N	Chicken Liver	16024100	\N	0.00	0.00	0.00	f	t	3	f445a5da-7c5d-433a-859e-0e56e2f00003	3
4160e571-b143-4a19-991d-986ce934661b	4	2024-07-19 03:56:07.192246+00	2024-07-19 03:56:07.192276+00	f	\N	vivo T3x 5G (Crimson Bliss, 128 GB)  (6 GB RAM)	39269099	\N	0.00	0.00	0.00	f	t	3	f445a5da-7c5d-433a-859e-0e56e2f00001	3
9792a329-e724-43da-996a-1f8f2220d922	5	2024-07-19 04:21:43.632981+00	2024-07-19 04:21:43.633004+00	f	\N	Fabbmate Trendy Sports Shoes for Women	64059000	\N	0.00	0.00	0.00	f	t	3	f445a5da-7c5d-433a-859e-0e56e2f00001	3
a1418739-5df0-44af-a904-4b71ecfa6666	6	2024-07-20 04:21:43.267213+00	2024-07-20 04:21:43.267236+00	f	\N	Comfort After Wash Morning Fresh Fabric Conditioner Pouch	34022090	\N	0.00	0.00	0.00	f	t	3	f445a5da-7c5d-433a-859e-0e56e2f00010	3
03297cf0-6bbb-43e5-b3a6-96ed092b58a2	7	2024-07-20 04:49:18.477149+00	2024-07-20 04:49:18.477171+00	f	\N	godrej aer power pocket bathroom freshener	33074900	\N	0.00	0.00	9.00	f	t	3	f445a5da-7c5d-433a-859e-0e56e2f00010	3
001a3dae-c076-4cec-86f1-b6b375dcdcea	8	2024-07-20 06:05:50.715049+00	2024-07-20 06:05:50.715077+00	f	\N	VIM	34022010	\N	0.00	0.00	0.00	f	t	3	f445a5da-7c5d-433a-859e-0e56e2f00010	3
0bfd803c-5577-4fcb-b671-019ce8364054	9	2024-07-20 06:23:50.790403+00	2024-07-20 06:23:50.790424+00	f	\N	Harpic	34022090	\N	0.00	0.00	0.00	f	t	3	f445a5da-7c5d-433a-859e-0e56e2f00010	3
c4ac1a52-e08d-4ee9-9bd2-6053930e608e	10	2024-07-20 06:36:30.289899+00	2024-07-20 06:36:30.289923+00	f	\N	Mangaldeep	33074100	\N	0.00	0.00	0.00	f	t	3	f445a5da-7c5d-433a-859e-0e56e2f00001	3
fefaeff8-52ff-481d-905c-ab2e93e2642e	11	2024-07-20 07:40:01.340751+00	2024-07-20 07:40:01.340784+00	f	\N	Mutton	02044200	\N	0.00	0.00	0.00	f	t	3	f445a5da-7c5d-433a-859e-0e56e2f00003	3
\.


--
-- Data for Name: product_stock; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.product_stock (id, category, date, increment, decrement, batch_id, product_variant_id, warehouse_id) FROM stdin;
\.


--
-- Data for Name: product_variation_type; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.product_variation_type (id, name, variation_type, other_type, is_deleted) FROM stdin;
1	Black	10	\N	f
2	Blue	10	\N	f
4	FRY CUT	30	PIECE	f
3	CURRY CUT	30	PIECE	f
\.


--
-- Data for Name: products_brand; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.products_brand (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, name, vendor_created, is_admin_approved, creator_id, updater_id) FROM stdin;
6eefdd94-33d0-4b5b-9d90-fc256716eabb	12	2024-07-18 12:29:28.788496+00	2024-07-18 12:41:57.682101+00	f	\N	ONEPLUS	t	t	4	1
36734491-2d06-4575-9ae2-4759873803b8	7	2024-07-18 12:28:50.084537+00	2024-07-18 12:42:02.373495+00	f	\N	OPPO	t	t	4	1
1f72fd53-c377-4b6b-a584-0e30a4e0e99d	5	2024-07-18 12:28:38.514345+00	2024-07-18 12:42:07.237062+00	f	\N	PORTRONICS	t	t	4	1
5e6204ae-4d2f-4ecf-a80c-a174c81bc6a0	10	2024-07-18 12:29:09.755243+00	2024-07-18 12:42:20.657608+00	f	\N	SAMSUNG	t	t	4	1
692f220f-0915-4117-be83-5109f1e10bcf	6	2024-07-18 12:28:43.994233+00	2024-07-18 12:42:25.410777+00	f	\N	SGM	t	t	4	1
337f36fb-1d1e-4722-8fcb-4b6142a1e9c2	1	2024-07-18 12:28:05.626085+00	2024-07-18 12:42:30.075865+00	f	\N	TREAMS	t	t	4	1
8e422f69-419e-40f5-a27f-006f23adc8e5	13	2024-07-18 12:53:10.468152+00	2024-07-18 12:53:10.468176+00	f	\N	SUGUNA	f	t	1	1
469c9f7b-74e2-4cac-8ca3-fd2c20d89a18	14	2024-07-18 16:00:14.000093+00	2024-07-18 16:00:14.000124+00	f	\N	Dettol	f	t	3	3
4648c326-0544-4ad0-a15e-519a581f64c1	15	2024-07-19 04:20:34.283518+00	2024-07-19 04:20:34.283541+00	f	\N	Fabbmate	f	t	3	3
0a254c61-a96d-4571-a733-77211c4cfb59	16	2024-07-20 04:19:16.753638+00	2024-07-20 04:19:16.753661+00	f	\N	COMFORT	f	t	3	3
4b3384d0-c94c-44e7-8138-c50957863205	17	2024-07-20 04:33:35.695036+00	2024-07-20 04:33:35.695057+00	f	\N	Godrej aer	f	t	3	3
ade6b58f-dc3b-410a-a5f6-b225cb3b42e5	18	2024-07-20 05:45:49.377821+00	2024-07-20 05:45:49.377842+00	f	\N	VIM	f	t	3	3
da0a9db7-1dfc-4fa0-8328-7321411dbc47	19	2024-07-20 06:18:51.83802+00	2024-07-20 06:18:51.838042+00	f	\N	Harpic	f	t	3	3
8faab61f-6787-41b9-847a-f5e5958436ac	20	2024-07-20 06:34:01.050382+00	2024-07-20 06:34:01.050407+00	f	\N	Mangaldeep	f	t	3	3
8029afce-0ca1-40a7-acbe-9c3b9fd86808	21	2024-10-25 10:30:40.063222+00	2024-10-25 10:30:40.063249+00	f	\N	Al Arafa	f	t	14	14
8efd743f-5682-4700-ae92-1d8ff20c9760	9	2024-07-18 12:29:02.846418+00	2025-05-06 12:27:33.668872+00	f	\N	APPLE	t	t	4	1
08ec6bb5-2c29-40fc-ab8b-0e95dc872358	2	2024-07-18 12:28:13.921939+00	2025-05-06 12:27:43.049041+00	f	\N	BOAT	t	t	4	1
a220bf38-502c-4234-8200-c95b6d7e5cfc	11	2024-07-18 12:29:18.367317+00	2025-05-06 12:27:48.534856+00	f	\N	ITEL	t	t	4	1
534ceeb4-573f-414e-9b25-0c9df4c1cee3	3	2024-07-18 12:28:20.554343+00	2025-05-06 12:27:56.543203+00	f	\N	REALME	t	t	4	1
2c0103c8-700e-49de-affb-25d3c2cace4c	4	2024-07-18 12:28:30.036159+00	2025-05-06 12:28:03.675743+00	f	\N	REDMI	t	t	4	1
dffa4dea-7340-4f43-b635-e1c4e4c8f4e0	8	2024-07-18 12:28:55.293684+00	2025-05-06 12:28:08.596708+00	f	\N	VIVO	t	t	4	1
\.


--
-- Data for Name: products_category; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.products_category (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, name, image, is_featured, vendor_created, is_admin_approved, creator_id, updater_id) FROM stdin;
638122ea-f238-4bf6-9e21-28192de9f95f	1	2024-07-17 13:10:04.732428+00	2024-07-17 13:10:04.732459+00	t	d	MEAT_deleted_1	media/raw-meat.jpg	t	f	t	1	1
9a735b68-fcb8-458d-850f-4424b6cd0b22	2	2024-07-17 13:10:06.132331+00	2024-07-17 13:10:06.132351+00	t	db	MEAT_deleted_2	media/raw-meat_AS6Xnh5.jpg	t	f	t	1	1
c8b47831-c7a2-44e1-9d2a-ebbccd116d2f	4	2024-07-17 13:10:07.484121+00	2024-07-17 13:10:07.484149+00	t	db	MEAT_deleted_4	media/raw-meat_80kIF2e.jpg	t	f	t	1	1
e94523ff-0ee5-4860-a8ce-443f80bc0ddf	5	2024-07-17 13:10:07.724439+00	2024-07-17 13:10:07.724467+00	t	db	MEAT_deleted_5	media/raw-meat_tK83i5c.jpg	t	f	t	1	1
9f133e1a-d7f1-4bab-b9d1-8b7d814d98c1	6	2024-07-17 13:10:07.819131+00	2024-07-17 13:10:07.819154+00	t	db	MEAT_deleted_6	media/raw-meat_1AQzJBD.jpg	t	f	t	1	1
df293eb5-69ae-480a-9e56-eadb7ce03d2b	7	2024-07-18 10:30:41.315225+00	2024-07-18 10:30:41.315249+00	t	DB	Electronics_deleted_7	media/wp1971518.jpg	t	f	t	1	1
1e4a51bd-0181-4df4-b55d-0cc7b258de53	16	2024-07-18 11:22:02.202185+00	2024-07-18 11:22:02.20221+00	t	db	Beauty_deleted_16	media/beauty-cosmetic-products_IpJIPfb.jpg	t	f	t	3	3
4cf2a336-ce0b-4608-a032-159e2c0d4ba7	15	2024-07-18 11:21:46.780581+00	2024-07-18 11:21:46.780605+00	t	db	Beauty_deleted_15	media/beauty-cosmetic-products_qVsULHp.jpg	t	f	t	3	3
90dde441-4aaa-44c0-8b98-675f6051bf22	17	2024-07-18 11:22:05.791618+00	2024-07-18 11:22:05.791641+00	t	db	Beauty_deleted_17	media/beauty-cosmetic-products_zZ7H8pr.jpg	t	f	t	3	3
01156b02-e1f3-42a6-bac2-2004ea6d75ac	3	2024-07-17 13:10:06.196966+00	2024-07-18 12:39:35.179921+00	f	\N	Meat	media/raw-meat_XHAzZ0V.jpg	t	f	t	1	3
0a9ff56f-679b-4a1f-b07b-0c4ea109ac91	22	2024-07-18 12:46:26.06417+00	2024-07-18 12:46:26.064192+00	t	Repeated	Electronics_deleted_22		f	f	t	3	3
0ee3935a-02bb-4984-9e69-28f1d8748218	18	2024-07-18 11:22:20.976716+00	2024-07-18 11:22:20.976745+00	t	s	Vegetables and Fruits_deleted_18	media/fresh-fruits-vegetables-2419.jpg	t	f	t	1	1
fefb62be-bbbe-4ba6-9831-57fba78d9e96	14	2024-07-18 11:21:42.659808+00	2024-07-18 11:21:42.65984+00	t	s	Beauty_deleted_14	media/beauty-cosmetic-products.jpg	t	f	t	3	3
f794c793-8a89-4aa7-b669-5800f98bffd0	10	2024-07-18 11:07:01.431128+00	2024-07-18 11:07:01.431159+00	t	s	Books_deleted_10	media/images_16.jpeg	t	f	t	3	3
33a7e888-3339-4716-a40e-b8050c178f2a	8	2024-07-18 10:32:57.097021+00	2024-07-18 10:32:57.097045+00	t	s	Electronics_deleted_8	media/electronics.png	t	f	t	3	3
4f00bb8d-9b6b-446e-8a4b-7fada87afa64	12	2024-07-18 11:14:57.218237+00	2024-07-18 11:14:57.218261+00	t	s	Fashion_deleted_12	media/images_17.jpeg	t	f	t	3	3
ecf235be-f2d2-4884-ad7a-13b8cd8f6528	20	2024-07-18 11:49:09.815445+00	2024-07-18 12:38:16.087424+00	t	s	Food_deleted_20	media/images_20.jpeg	t	f	t	3	3
0242d2fe-cfb9-4db7-971a-3b8b11b4776a	23	2024-07-19 04:25:04.628762+00	2024-07-19 07:10:05.570182+00	t	s	Footwear_deleted_23	media/Drip-Solemate-780x470.jpg	f	f	t	3	1
407d13b9-de63-4c94-80a9-4466e6de6205	11	2024-07-18 11:08:24.339179+00	2024-07-18 11:08:24.339204+00	t	s	Groceries_deleted_11	media/657523223201860664129_22-09-2018-1537555224.png	t	f	t	3	3
bbb2c423-94e1-432a-9ba2-41712cedd76d	13	2024-07-18 11:16:15.453389+00	2024-07-18 11:50:35.109387+00	t	s	Home Appliances_deleted_13	media/images_18.jpeg	t	f	t	3	3
b9358471-6823-4be1-b92a-a7873b0b3188	24	2024-07-20 04:14:41.442003+00	2024-07-20 04:14:41.442025+00	t	s	Household Supplies_deleted_24	media/ac36e1cf15cd64a3d858b8ccf3e858eb.jpg	t	f	t	3	3
f33ad4f3-894a-4e45-a0d3-731941c2598e	21	2024-07-18 12:45:11.838043+00	2024-07-18 12:45:11.838075+00	t	s	Mobiles_deleted_21	media/Apple-iPhone-15-Pro-Max.jpg	t	f	t	1	1
05ec95ab-6a4f-4f93-84e9-b537d9260ea7	9	2024-07-18 10:33:33.986088+00	2024-07-18 10:33:33.986112+00	t	s	TVs  Appliances_deleted_9	media/th.jpeg	t	f	t	1	1
e0d7a4d4-615c-4d50-92ed-9dbddf570efd	19	2024-07-18 11:28:43.865092+00	2024-07-18 11:28:43.865124+00	t	s	Toys_deleted_19	media/images_19.jpeg	f	f	t	3	3
992acd14-4d01-4fc5-b154-cf839d21c6e9	25	2024-10-24 10:27:51.180409+00	2024-10-24 10:27:51.180445+00	f	\N	Vegetables and Fruits	media/fresh-fruits-vegetables-2419_HNzuDQh.jpg	t	f	t	1	1
\.


--
-- Data for Name: products_product; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.products_product (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, name, image, description, meta_description, is_active, is_varying_price, has_special_variant, cancellable_duration, cancellable_duration_type, returnable_duration, returnable_duration_type, vendor_created, is_admin_approved, brand_id, category_id, creator_id, hsn_id, special_category_id, subcategory_id, unit_of_measurement_id, updater_id, vendor_id) FROM stdin;
5e077b69-9011-499c-8103-19a1782192af	7	2024-07-20 05:13:28.273523+00	2024-07-20 05:39:19.450618+00	t	\N	Godrej aer Power Pocket Bathroom FreshenerAssorted Pack of 5 (50g) |Gel Lasts up to 30 days | Germ Protection	media/80a70863e6d9427b480788b4d8ccbf55.jpg	Transform your bathroom experience with the Godrej Aer Power Pocket Bathroom Freshener. This compact and stylish freshener releases a consistent burst of fragrance, keeping your space smelling fresh and inviting for up to 30 days.	Buy Godrej Aer Power Pocket Bathroom Freshener online at Nexsme Bazar.	t	t	t	1.00	day	1.00	day	f	t	4b3384d0-c94c-44e7-8138-c50957863205	b9358471-6823-4be1-b92a-a7873b0b3188	3	03297cf0-6bbb-43e5-b3a6-96ed092b58a2	\N	dd3e3e1d-087a-4eb9-92b4-aa46058ab0f2	5896a66f-300c-4944-8e6b-f9d31c6ab004	3	\N
b0d55f50-76e5-4d3d-b098-09e1ef106a48	3	2024-07-19 03:52:43.879492+00	2024-07-19 04:03:16.299861+00	t	not needed	Chicken Liver	media/images_WbHlohl.jpeg	Discover the rich, savory taste of our premium chicken liver, perfect for creating delicious and nutritious meals. Packed with essential vitamins and minerals, our chicken liver is carefully sourced and handled to ensure the highest quality.	Buy fresh chicken liver online at Nexme Bazar.  Order now for quality  and freshness delivered to your door!	t	f	f	1.00	day	1.00	hours	f	t	8e422f69-419e-40f5-a27f-006f23adc8e5	01156b02-e1f3-42a6-bac2-2004ea6d75ac	3	2716e45b-efee-4439-b180-5b4ca1ba3b87	\N	\N	5896a66f-300c-4944-8e6b-f9d31c6ab002	3	\N
af8c94bb-f2a2-4673-be69-64ebb670f0e4	2	2024-07-19 03:52:17.145805+00	2024-10-24 09:18:35.63058+00	t	s	Chicken Liver	media/images.jpeg	Discover the rich, savory taste of our premium chicken liver, perfect for creating delicious and nutritious meals. Packed with essential vitamins and minerals, our chicken liver is carefully sourced and handled to ensure the highest quality.	Buy fresh chicken liver online at Nexme Bazar.  Order now for quality  and freshness delivered to your door!	t	f	f	1.00	day	1.00	hours	f	t	8e422f69-419e-40f5-a27f-006f23adc8e5	01156b02-e1f3-42a6-bac2-2004ea6d75ac	3	2716e45b-efee-4439-b180-5b4ca1ba3b87	\N	\N	5896a66f-300c-4944-8e6b-f9d31c6ab002	1	\N
e467db7f-0682-4944-bb68-24393a6ff779	1	2024-07-18 14:31:44.839148+00	2024-10-24 09:18:26.549165+00	t	s	Chicken Meat	media/61YtDlLNlHL._SL1000_.jpg	Fat-trimmed and tender cuts of chicken, straight from the farm. No antibiotics, growth-promoting hormones, or any harmful additives. Naturally reared for tastier, fat-free meat. Cleaned and cut in a state-of-the-art, fssai-certified processing center. No gizzard, no liver, skinless.	Antibiotic-residue-free Chicken	t	f	f	1.00	hours	1.00	day	f	t	8e422f69-419e-40f5-a27f-006f23adc8e5	01156b02-e1f3-42a6-bac2-2004ea6d75ac	1	e2e568cc-15e9-4410-a17b-728935fed61b	\N	ae907c1b-9702-43fe-a934-71e5ed64637f	5896a66f-300c-4944-8e6b-f9d31c6ab002	1	\N
d3f906d5-0f4e-4c3d-9fd6-3c2fa2076b36	10	2024-07-20 06:45:39.482317+00	2024-07-20 06:45:39.48234+00	t	\N	Mangaldeep Temple Yagna Gold Agarbatti Sticks	media/61JcS0B9jnL.jpg	Enhance your spiritual rituals with Mangaldeep Temple Yagna Gold Agarbatti Sticks. These premium incense sticks offer a rich and soothing fragrance that creates a serene and peaceful ambiance, perfect for meditation and prayer.	Shop Mangaldeep Temple Yagna Gold Agarbatti Sticks at Nexsme Bazar.	t	f	f	1.00	day	1.00	day	f	t	8faab61f-6787-41b9-847a-f5e5958436ac	b9358471-6823-4be1-b92a-a7873b0b3188	3	c4ac1a52-e08d-4ee9-9bd2-6053930e608e	\N	abbecb76-d31e-49ef-aba5-55963bc8e103	5896a66f-300c-4944-8e6b-f9d31c6ab002	3	\N
7cb05e19-e135-442d-aa25-690ad6f73585	5	2024-07-19 04:30:43.389383+00	2024-07-19 04:30:43.389408+00	t	\N	Fabbmate Trendy Sports Shoes for Women's Running,Walking with Memory Foam Running Shoes For Women  (Maroon , 6)	media/e6qid_512.jpg	Step up your style game with the Fabbmate Trendy Sports Shoes for Women. These chic and comfortable shoes are perfect for daily wear, workouts, or casual outings.	Discover Fabbmate Trendy Sports Shoes for Women: stylish, comfortable, and perfect for workouts or casual wear.	t	t	t	1.00	day	1.00	day	f	t	4648c326-0544-4ad0-a15e-519a581f64c1	0242d2fe-cfb9-4db7-971a-3b8b11b4776a	3	9792a329-e724-43da-996a-1f8f2220d922	\N	7c911277-d34b-40ff-865a-4ee64562d967	5896a66f-300c-4944-8e6b-f9d31c6ab001	3	\N
fc9666f2-41d0-4fa6-bf5c-4db92128a936	4	2024-07-19 04:02:38.280901+00	2024-07-19 04:02:38.280931+00	t	\N	vivo T3x 5G (Crimson Bliss, 128 GB)  (6 GB RAM)	media/download.jpeg	Experience the power and speed of the Vivo T3x 5G in stunning Crimson Bliss. With 128 GB storage and 6 GB RAM, this smartphone offers seamless multitasking and ample space for all your apps, photos, and videos. Enjoy crystal-clear visuals on its vibrant display and capture memorable moments with the advanced camera system.	Shop the Vivo T3x 5G (Crimson Bliss, 128 GB, 6 GB RAM) at Nexme Bazar. Enjoy fast performance, stunning design, and advanced cam	t	f	f	1.00	day	1.00	day	f	t	dffa4dea-7340-4f43-b635-e1c4e4c8f4e0	f33ad4f3-894a-4e45-a0d3-731941c2598e	3	4160e571-b143-4a19-991d-986ce934661b	\N	\N	5896a66f-300c-4944-8e6b-f9d31c6ab001	3	\N
54180912-e5d3-4d34-ba3e-9d04e4cb4186	6	2024-07-20 04:30:48.704328+00	2024-07-20 04:30:48.70435+00	t	\N	Comfort After Wash Morning Fresh Fabric Conditioner Pouch, 2 ltr, Liquid	media/afe46d32f5272c2ae6291fc29287c19d.jpg	Elevate your laundry routine with the Comfort After Wash Morning Fresh Fabric Conditioner. This convenient pouch infuses your clothes with a refreshing fragrance that lasts all day. Experience the perfect balance of softness and fragrance with Comfort.	Buy Comfort After Wash Morning Fresh Fabric Conditioner Pouch online at Nexsme Bazar.	t	t	t	1.00	day	1.00	day	f	t	0a254c61-a96d-4571-a733-77211c4cfb59	b9358471-6823-4be1-b92a-a7873b0b3188	3	a1418739-5df0-44af-a904-4b71ecfa6666	\N	88438f8b-561a-40de-8f85-1a3b9e091d23	5896a66f-300c-4944-8e6b-f9d31c6ab004	3	\N
17a87076-bd9c-4ff5-a851-edaa5f6e9ac2	9	2024-07-20 06:30:42.484065+00	2024-07-20 06:30:42.484122+00	t	\N	Harpic 1 Litre (Pack of 2) - Original, Disinfectant Toilet Cleaner Liquid | Suitable for Toilet Bowls	media/10ee37983c5c5f7120fd94070f0ccbd1.jpg	Keep your toilet spotless and hygienic with Harpic Original Disinfectant Toilet Cleaner Liquid. This pack of two 1-litre bottles offers powerful cleaning action, effectively removing tough stains, limescale, and germs. I	Buy Harpic 1 Litre (Pack of 2) Original Disinfectant Toilet Cleaner at Nexsme Bazar.	t	t	t	1.00	day	1.00	day	f	t	da0a9db7-1dfc-4fa0-8328-7321411dbc47	b9358471-6823-4be1-b92a-a7873b0b3188	3	0bfd803c-5577-4fcb-b671-019ce8364054	\N	814ed327-987c-4f4b-a019-568e3a2802ad	5896a66f-300c-4944-8e6b-f9d31c6ab004	3	\N
ed362c81-e154-49bb-a5a3-88efb27d9870	11	2024-10-25 11:30:18.710388+00	2024-10-25 11:30:18.710414+00	f	\N	Fresh Chicken	media/1000535466.jpg	Nnnnn	Nnnn	t	t	f	0.15	hours	0.30	hours	f	t	8029afce-0ca1-40a7-acbe-9c3b9fd86808	01156b02-e1f3-42a6-bac2-2004ea6d75ac	14	e2e568cc-15e9-4410-a17b-728935fed61b	\N	ae907c1b-9702-43fe-a934-71e5ed64637f	5896a66f-300c-4944-8e6b-f9d31c6ab002	14	\N
60b6dada-d7bc-46ec-8fa7-f0dc53bab3e1	8	2024-07-20 06:10:34.133149+00	2024-07-20 06:10:34.133181+00	t	\N	Vim Dishwash Liquid Gel Lemon Refill Pouch, 2 Ltr	media/2a38c91caea7c33117d9d4a4f5dcc768.jpg	Experience sparkling clean dishes with Vim Dishwash Liquid Gel Lemon Refill Pouch. This powerful gel formula effectively cuts through grease and removes tough stains, leaving your utensils spotless and hygienic.	Shop Vim Dishwash Liquid Gel Lemon Refill Pouch at Nexsme Bazar.	t	t	t	1.00	day	1.00	day	f	t	ade6b58f-dc3b-410a-a5f6-b225cb3b42e5	b9358471-6823-4be1-b92a-a7873b0b3188	3	001a3dae-c076-4cec-86f1-b6b375dcdcea	\N	3d8e04dc-6be5-44af-92ca-983d4653ac90	5896a66f-300c-4944-8e6b-f9d31c6ab004	3	\N
72238de2-9962-4f7e-bbc0-cdf7e366b264	13	2025-07-28 08:43:19.736874+00	2025-07-28 08:43:19.736898+00	f	\N	Bro live	media/Whole-Chicken-600x464.jpeg		GGG	t	f	f	0.00	day	0.00	hours	f	t	8029afce-0ca1-40a7-acbe-9c3b9fd86808	01156b02-e1f3-42a6-bac2-2004ea6d75ac	1	2716e45b-efee-4439-b180-5b4ca1ba3b87	\N	ae907c1b-9702-43fe-a934-71e5ed64637f	5896a66f-300c-4944-8e6b-f9d31c6ab002	1	\N
8382e756-de7d-43fb-9e9d-2c341eb04395	12	2025-05-06 12:06:49.875166+00	2025-07-09 17:06:24.490303+00	f	\N	Tomato 🍅	media/1000727789.jpg	Organic kerala farmers collection tomato 🍅	Healthy ang higenic	t	f	f	1.00	hours	0.30	hours	f	t	\N	992acd14-4d01-4fc5-b154-cf839d21c6e9	17	e2e568cc-15e9-4410-a17b-728935fed61b	\N	\N	5896a66f-300c-4944-8e6b-f9d31c6ab002	1	bdc3a234-5d4b-44a5-9c01-ca120fee547c
\.


--
-- Data for Name: products_product_image; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.products_product_image (id, auto_id, date_added, date_updated, deleted_reason, image, is_deleted, creator_id, product_variant_id, updater_id) FROM stdin;
fbfc617d-57de-45b5-825e-dbb36776dd50	1	2024-10-25 11:30:18.724348+00	2024-10-25 11:30:18.724382+00	\N	media/516WqNlKkPL._AC_UF10001000_QL80_.jpg	f	14	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3	14
0f240862-47ef-4b61-b125-40b0bef63f49	2	2025-05-06 12:06:49.886888+00	2025-05-06 12:06:49.88692+00	\N	media/images_5.jpeg	f	17	4e290f81-d412-4025-acab-7b690f187583	17
e6fa15b9-4182-4c0f-a6f9-e42d85bf1732	3	2025-07-28 08:43:19.746258+00	2025-07-28 08:43:19.746283+00	\N	media/61YtDlLNlHL._SL1000__rP8t2JP.jpg	f	1	9a7c44b8-79e7-476f-8fb0-6d10fec63f75	1
\.


--
-- Data for Name: products_product_variant; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.products_product_variant (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, title, product_code, image, current_rating, stock, warranty, discount_limit, low_stock_limit, first_time_stock, batch_number, expire_date, retail_price, manufacturing_date, cost, mrp, commission_percentage, whole_sale_quantity, whole_sale_price, tax_included, is_featured, is_default, is_special_variant, vendor_created, is_admin_approved, colour_variation_id, creator_id, other_variation_id, product_id, size_variation_id, unit_id, updater_id, warehouse_id) FROM stdin;
bb827cf8-daa6-402c-a7cb-e8a8936c04ac	2	2024-07-19 03:52:17.151256+00	2024-07-19 03:52:17.15128+00	t	s	Chicken Curry Liver	nx002__is_deleted_2	media/product_variant/images.jpeg	0.0	0.000	\N	0.000	1	0.000	1234	2024-07-19	245.00	2024-07-19	199.00	300.00	\N	10	175.00	f	f	t	f	f	t	\N	3	\N	af8c94bb-f2a2-4673-be69-64ebb670f0e4	\N	f445a5da-7c5d-433a-859e-0e56e2f00003	3	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
6826bd65-4fd1-4aa8-9aad-814048862f9f	12	2024-07-20 06:45:39.487144+00	2024-07-20 06:45:39.487185+00	t	\N	Mangaldeep Temple Yagna Gold Agarbatti Sticks	H007__is_deleted_12__is_deleted_12	media/product_variant/61JcS0B9jnL.jpg	0.0	10.000	\N	0.000	1	10.000	H07	2024-08-11	75.00	2024-07-20	75.00	75.00	\N	5	70.00	f	f	t	f	f	t	\N	3	\N	d3f906d5-0f4e-4c3d-9fd6-3c2fa2076b36	\N	f445a5da-7c5d-433a-859e-0e56e2f00002	3	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
b3c33e1d-16de-4ea9-bf55-0a0e6ac424f1	3	2024-07-19 03:52:43.884935+00	2024-07-19 03:52:43.884957+00	t	not needed	Chicken Curry Liver	nx003__is_deleted_3	media/product_variant/images_x7BBrL8.jpeg	0.0	0.000	\N	0.000	1	0.000	1234	2024-07-19	245.00	2024-07-19	199.00	300.00	\N	10	175.00	f	f	t	f	f	t	\N	3	\N	b0d55f50-76e5-4d3d-b098-09e1ef106a48	\N	f445a5da-7c5d-433a-859e-0e56e2f00003	3	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
f1fa4f77-1f7e-48ff-889e-32de297e9cf5	4	2024-07-19 03:52:43.892981+00	2024-07-19 03:52:43.893004+00	t	not needed	Chicken curry liver	nx004__is_deleted_4	media/product_variant/images_DsP5tSa.jpeg	0.0	0.000	\N	0.000	1	0.000	1234	2024-07-19	245.00	2024-07-19	199.00	300.00	\N	10	175.00	f	f	f	f	f	t	\N	3	\N	b0d55f50-76e5-4d3d-b098-09e1ef106a48	\N	f445a5da-7c5d-433a-859e-0e56e2f00003	3	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
2794b11d-405d-4eeb-ba63-81b435931357	11	2024-07-20 06:30:42.493541+00	2024-07-20 06:30:42.493593+00	t	\N	Harpic 1 Litre (Pack of 2) - Original, Disinfectant Toilet Cleaner Liquid | Suitable for Toilet Bowls	HOO6__is_deleted_11	media/product_variant/10ee37983c5c5f7120fd94070f0ccbd1.jpg	0.0	10.000	\N	0.000	1	10.000	H06	2024-07-31	380.00	2024-07-20	370.00	390.00	\N	4	300.00	f	f	t	f	f	t	\N	3	\N	17a87076-bd9c-4ff5-a851-edaa5f6e9ac2	\N	f445a5da-7c5d-433a-859e-0e56e2f00010	3	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
80721a40-6322-40f3-be9a-d61ed9e6cf72	10	2024-07-20 06:10:34.138776+00	2024-07-20 06:10:34.138806+00	t	\N	Shop Vim Dishwash Liquid Gel Lemon Refill Pouch at Nexsme Bazar.	H004__is_deleted_10	media/product_variant/2a38c91caea7c33117d9d4a4f5dcc768.jpg	0.0	0.000	\N	0.000	1	0.000	H04	2024-07-30	400.00	2024-07-20	300.00	405.00	\N	5	350.00	f	f	t	f	f	t	\N	3	\N	60b6dada-d7bc-46ec-8fa7-f0dc53bab3e1	\N	f445a5da-7c5d-433a-859e-0e56e2f00010	3	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
278157e3-7790-4abd-9554-a3ab71531026	9	2024-07-20 05:13:28.278392+00	2024-07-20 05:13:28.278414+00	t	\N	Godrej aer Power Pocket Bathroom FreshenerAssorted Pack of 5 (50g) |Gel Lasts up to 30 days | Germ Protection	H002__is_deleted_9	media/product_variant/80a70863e6d9427b480788b4d8ccbf55.jpg	0.0	0.000	\N	0.000	1	0.000	H02	2024-07-31	250.00	2024-07-20	209.00	300.00	\N	5	200.00	f	f	t	f	f	t	\N	3	\N	5e077b69-9011-499c-8103-19a1782192af	\N	f445a5da-7c5d-433a-859e-0e56e2f00010	3	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
fb3ae593-aa0f-4650-82f4-2024299ac010	1	2024-07-18 14:31:44.844429+00	2024-07-18 14:31:44.844451+00	t	s	Chicken Curry cut	nx001__is_deleted_1	media/product_variant/61YtDlLNlHL._SL1000_.jpg	0.0	9.000	\N	10.000	5	10.000	18/07/24	2024-07-18	199.00	2024-07-18	150.00	245.00	\N	10	175.00	f	t	t	f	f	t	\N	1	\N	e467db7f-0682-4944-bb68-24393a6ff779	\N	f445a5da-7c5d-433a-859e-0e56e2f00001	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
21635aff-43d8-427f-a860-63ee2c222807	8	2024-07-20 04:30:48.708755+00	2024-07-20 04:30:48.708777+00	t	\N	Comfort After Wash Morning Fresh Fabric Conditioner Pouch, 2 ltr, Liquid	H001__is_deleted_8	media/product_variant/afe46d32f5272c2ae6291fc29287c19d.jpg	0.0	20.000	\N	5.000	10	20.000	H01	2024-07-29	400.00	2024-07-20	370.00	450.00	\N	5	350.00	f	f	t	f	f	t	\N	3	\N	54180912-e5d3-4d34-ba3e-9d04e4cb4186	\N	f445a5da-7c5d-433a-859e-0e56e2f00010	3	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
7df72a13-0cd4-4417-bb5b-842ab39fd10c	7	2024-07-19 04:30:43.395136+00	2024-07-19 04:30:43.395159+00	t	\N	Fabbmate Trendy Sports Shoes for Women's Running,Walking with Memory Foam Running Shoes For Women  (Maroon , 6)	nx007__is_deleted_7	media/product_variant/e6qid_512.jpg	0.0	0.000	\N	0.000	1	0.000	nx0011	2024-07-28	700.00	2024-07-19	299.00	799.00	\N	10	600.00	f	t	t	f	f	t	1	3	\N	7cb05e19-e135-442d-aa25-690ad6f73585	\N	f445a5da-7c5d-433a-859e-0e56e2f00001	3	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
7ccaf6ae-f439-4456-a6ad-02d218fee39d	5	2024-07-19 04:02:38.286685+00	2024-07-19 11:18:56.961852+00	t	def	vivo T3x 5G (Crimson Bliss, 128 GB) (6 GB RAM)	nx005__is_deleted_5__is_deleted_5	media/product_variant/download.jpeg	0.0	0.000	\N	0.000	1	0.000	nx123	2026-06-19	18000.00	2024-07-19	14999.00	18999.00	\N	10	18000.00	f	f	f	f	f	t	1	3	\N	fc9666f2-41d0-4fa6-bf5c-4db92128a936	\N	f445a5da-7c5d-433a-859e-0e56e2f00001	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
056aa641-cd7c-4c1e-8fa0-e550389cc20d	6	2024-07-19 04:02:38.2966+00	2024-07-19 11:21:00.602732+00	t	\N	vivo T3x 5G (Crimson Bliss, 128 GB) (6 GB RAM)	nx006__is_deleted_6	media/product_variant/download_3uUKMVb.jpeg	0.0	0.000	\N	0.000	1	0.000	nx123	2026-06-19	18000.00	2024-07-19	14999.00	18999.00	\N	10	18000.00	f	f	f	f	f	t	2	3	\N	fc9666f2-41d0-4fa6-bf5c-4db92128a936	\N	f445a5da-7c5d-433a-859e-0e56e2f00001	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
bf2255ec-d2bd-4673-ad60-dd0578f9a6d3	13	2024-10-25 11:30:18.716574+00	2024-10-25 11:30:18.716609+00	f	\N	Curry cut Chicken	Ch001	media/product_variant/1000535466.jpg	4.0	274.500	\N	5.000	10	0.000	00	2024-10-25	195.00	\N	174.00	200.00	\N	10	190.00	f	t	t	f	f	t	\N	14	3	ed362c81-e154-49bb-a5a3-88efb27d9870	\N	f445a5da-7c5d-433a-859e-0e56e2f00003	14	6568014e-bb8e-4058-8abc-20b985c67d29
4e290f81-d412-4025-acab-7b690f187583	14	2025-05-06 12:06:49.88142+00	2025-05-06 12:11:26.624296+00	f	\N	Tomato	Tomato	media/product_variant/1000727789.jpg	0.0	5.000	\N	10.000	0	2.000	DEFAULT	2025-05-07	25.00	2025-05-06	8.00	30.00	10.00	10	15.00	f	f	t	f	t	t	\N	17	\N	8382e756-de7d-43fb-9e9d-2c341eb04395	\N	f445a5da-7c5d-433a-859e-0e56e2f00003	1	\N
9a7c44b8-79e7-476f-8fb0-6d10fec63f75	15	2025-07-28 08:43:19.741446+00	2025-07-28 08:43:19.741467+00	f	\N	Broiler Live 1	2222	media/product_variant/Whole-Chicken-600x464.jpeg	0.0	1.000	00	0.000	1	0.000	230725	2025-07-28	120.00	2025-07-02	80.00	150.00	\N	5	110.00	f	f	t	f	f	t	\N	1	\N	72238de2-9962-4f7e-bbc0-cdf7e366b264	\N	f445a5da-7c5d-433a-859e-0e56e2f00003	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
\.


--
-- Data for Name: products_special_category; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.products_special_category (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, name, creator_id, updater_id) FROM stdin;
cdfa78f0-8c2b-4600-82c4-6a5aac862553	1	2024-07-18 15:51:35.44303+00	2024-07-18 15:51:35.443055+00	t	DB	S	1	1
\.


--
-- Data for Name: products_sub_category; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.products_sub_category (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, name, vendor_created, is_admin_approved, category_id, creator_id, updater_id) FROM stdin;
e1d72866-93ce-40bf-9ae8-3e3ef94ba3dd	13	2024-07-18 11:24:51.456488+00	2024-07-18 11:24:51.456518+00	t	Repeated	Grooming	f	t	fefb62be-bbbe-4ba6-9831-57fba78d9e96	3	3
3efbe8f0-87c6-48e3-b866-f90a9c560d7e	20	2024-07-18 11:40:52.040477+00	2024-07-18 11:42:03.696551+00	f	\N	Nadan Chicken	f	t	01156b02-e1f3-42a6-bac2-2004ea6d75ac	1	1
ae907c1b-9702-43fe-a934-71e5ed64637f	19	2024-07-18 11:40:27.890773+00	2024-07-18 11:42:28.821046+00	f	\N	Broiler Chicken	f	t	01156b02-e1f3-42a6-bac2-2004ea6d75ac	1	1
4bcf6ca1-5721-45a2-82bc-80f1ea4a0c36	22	2024-07-18 11:43:07.294623+00	2024-07-18 11:43:07.29465+00	f	\N	Broiler Liver Parts	f	t	01156b02-e1f3-42a6-bac2-2004ea6d75ac	1	1
add965e1-b58d-4253-9f6c-bec38e3c8714	24	2024-07-18 11:43:32.784647+00	2024-07-18 11:43:32.784672+00	f	\N	Legg	f	t	01156b02-e1f3-42a6-bac2-2004ea6d75ac	1	1
0ecff9a5-8cf9-4f7a-b884-797c0b8f989d	25	2024-07-18 11:46:18.189847+00	2024-07-18 11:46:18.189871+00	f	\N	Beef	f	t	01156b02-e1f3-42a6-bac2-2004ea6d75ac	1	1
b5b04049-c7e8-45da-b39a-fd01c563d580	26	2024-07-18 11:47:42.411871+00	2024-07-18 11:47:42.411894+00	f	\N	Mutton	f	t	01156b02-e1f3-42a6-bac2-2004ea6d75ac	1	1
87643bee-e2ae-43c1-9ac8-9bf10fee9254	27	2024-07-18 11:48:19.089689+00	2024-07-18 11:48:38.326465+00	f	\N	Mutton Liver	f	t	01156b02-e1f3-42a6-bac2-2004ea6d75ac	1	1
42554359-278d-44b0-8658-d9ee388c1e79	18	2024-07-18 11:39:29.608045+00	2024-07-18 11:39:29.608069+00	t	db	Toys for Pre Teens	f	t	e0d7a4d4-615c-4d50-92ed-9dbddf570efd	3	3
d7e1364a-b46b-4adf-b752-da7c2628769e	28	2024-07-18 12:30:46.074109+00	2024-07-18 12:42:46.009579+00	t	db	MOBILES ACCESSORIES	t	t	33a7e888-3339-4716-a40e-b8050c178f2a	4	1
2e7c6f56-a05e-4e3c-bdfb-e224aab9c697	11	2024-07-18 11:24:10.97249+00	2024-07-18 11:24:10.972518+00	t	s	Bath and Shower	f	t	fefb62be-bbbe-4ba6-9831-57fba78d9e96	3	3
444c0f7c-2968-40f6-9de2-ff8d0483ddc4	12	2024-07-18 11:24:35.882374+00	2024-07-18 11:24:35.882398+00	t	s	Beauty Devices	f	t	fefb62be-bbbe-4ba6-9831-57fba78d9e96	3	3
2d1070a1-cfca-42cb-964f-f0c55263d496	10	2024-07-18 11:23:54.574889+00	2024-07-18 11:23:54.574913+00	t	s	Fragrances	f	t	fefb62be-bbbe-4ba6-9831-57fba78d9e96	3	3
561f5b57-79b5-4bef-9ffd-acc060ed40a7	14	2024-07-18 11:25:29.482527+00	2024-07-18 11:25:29.482558+00	t	s	Grooming	f	t	fefb62be-bbbe-4ba6-9831-57fba78d9e96	3	3
679396bb-e1a9-4622-a236-00cefb0589ec	8	2024-07-18 11:22:50.484445+00	2024-07-18 11:22:50.484478+00	t	s	Hair Care	f	t	fefb62be-bbbe-4ba6-9831-57fba78d9e96	3	3
3581c97b-32fa-4a68-af3d-9a1095c400ec	9	2024-07-18 11:23:12.839937+00	2024-07-18 11:23:12.83996+00	t	s	Makeup	f	t	fefb62be-bbbe-4ba6-9831-57fba78d9e96	3	3
592c930d-2381-48ee-8fdb-2116914c7203	7	2024-07-18 11:22:35.160016+00	2024-07-18 11:22:35.160037+00	t	s	Skin Care	f	t	fefb62be-bbbe-4ba6-9831-57fba78d9e96	3	3
7c911277-d34b-40ff-865a-4ee64562d967	30	2024-07-19 04:25:14.298229+00	2024-07-19 04:25:14.298252+00	t	s	Women Shoes	f	t	0242d2fe-cfb9-4db7-971a-3b8b11b4776a	3	3
c882943d-3801-4522-ae1e-3bc732f6e843	4	2024-07-18 11:19:01.604489+00	2024-07-18 11:19:01.604511+00	t	s	Tools	f	t	bbb2c423-94e1-432a-9ba2-41712cedd76d	3	3
db111bb4-0c6f-4421-b7e5-ca23df871ec8	6	2024-07-18 11:19:45.288692+00	2024-07-18 11:19:45.288718+00	t	s	Outdoors	f	t	bbb2c423-94e1-432a-9ba2-41712cedd76d	3	3
4d6e0ed5-2e57-48c9-b334-494577bf844b	3	2024-07-18 11:18:40.653918+00	2024-07-18 11:18:40.653939+00	t	s	Furniture	f	t	bbb2c423-94e1-432a-9ba2-41712cedd76d	3	3
da3230cf-cc4c-4dd3-9d13-583ca4948a00	5	2024-07-18 11:19:24.11457+00	2024-07-18 11:19:24.1146+00	t	s	Fitness and Sports	f	t	bbb2c423-94e1-432a-9ba2-41712cedd76d	3	3
1199cf67-929a-461d-a985-46fc83a1e572	2	2024-07-18 11:18:11.912225+00	2024-07-18 11:18:11.912249+00	t	s	Cookware	f	t	bbb2c423-94e1-432a-9ba2-41712cedd76d	3	3
3af0f1ad-3e1b-411b-833c-04a3812a5319	1	2024-07-18 11:18:00.523925+00	2024-07-18 11:18:00.523949+00	t	s	Appliances	f	t	bbb2c423-94e1-432a-9ba2-41712cedd76d	3	3
dd3e3e1d-087a-4eb9-92b4-aa46058ab0f2	34	2024-07-20 04:15:51.419785+00	2024-07-20 04:15:51.419807+00	t	s	Airfreshners	f	t	b9358471-6823-4be1-b92a-a7873b0b3188	3	3
3d8e04dc-6be5-44af-92ca-983d4653ac90	33	2024-07-20 04:15:37.963553+00	2024-07-20 04:15:37.963575+00	t	s	Dishwashing Supplies	f	t	b9358471-6823-4be1-b92a-a7873b0b3188	3	3
814ed327-987c-4f4b-a019-568e3a2802ad	32	2024-07-20 04:15:21.051884+00	2024-07-20 04:15:21.051908+00	t	s	Household Cleaners	f	t	b9358471-6823-4be1-b92a-a7873b0b3188	3	3
88438f8b-561a-40de-8f85-1a3b9e091d23	31	2024-07-20 04:15:06.194678+00	2024-07-20 04:15:06.194709+00	t	s	Laundry Essentials	f	t	b9358471-6823-4be1-b92a-a7873b0b3188	3	3
2d80d5cd-a3cd-40b2-9bf5-869058b52a57	35	2024-07-20 04:16:23.436843+00	2024-07-20 04:16:23.436866+00	t	s	Lighters and Matches	f	t	b9358471-6823-4be1-b92a-a7873b0b3188	3	3
abbecb76-d31e-49ef-aba5-55963bc8e103	36	2024-07-20 04:16:45.707086+00	2024-07-20 04:16:45.707115+00	t	s	Pooja Supplies	f	t	b9358471-6823-4be1-b92a-a7873b0b3188	3	3
7cdc5b4b-958a-457b-a82d-149ab3bacc68	29	2024-07-18 12:50:01.579719+00	2024-07-18 12:50:01.579752+00	t	s	Mobile Accessories	f	t	f33ad4f3-894a-4e45-a0d3-731941c2598e	1	1
61b53a46-5cbf-4a16-81c1-e793e3a2da8e	15	2024-07-18 11:30:27.741514+00	2024-07-18 11:30:27.741542+00	t	s	Toys for Infants	f	t	e0d7a4d4-615c-4d50-92ed-9dbddf570efd	3	3
fb8d2fcc-af42-40f8-b83c-f4e89f9f0fa7	21	2024-07-18 11:43:04.418299+00	2024-07-18 11:43:04.418333+00	t	s	Toys for Pre Teens	f	t	e0d7a4d4-615c-4d50-92ed-9dbddf570efd	3	3
3fc4f360-d50b-47cb-8997-45d0fe662b62	23	2024-07-18 11:43:23.253272+00	2024-07-18 11:43:23.253296+00	t	s	Toys for Young Teens	f	t	e0d7a4d4-615c-4d50-92ed-9dbddf570efd	3	3
bbd17a9b-9688-4b42-bbea-9882f1413b45	17	2024-07-18 11:32:10.346839+00	2024-07-18 11:32:10.346873+00	t	s	Toys for School Kids	f	t	e0d7a4d4-615c-4d50-92ed-9dbddf570efd	3	3
0f0ba5fe-f236-4600-b67e-d46384beda1e	16	2024-07-18 11:30:55.496986+00	2024-07-18 11:30:55.49701+00	t	s	Toys for Pre Schoolers	f	t	e0d7a4d4-615c-4d50-92ed-9dbddf570efd	3	3
\.


--
-- Data for Name: products_unit; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.products_unit (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, unit, vendor_created, is_admin_approved, creator_id, unit_of_measurement_id, updater_id) FROM stdin;
f445a5da-7c5d-433a-859e-0e56e2f00001	6	2023-02-10 15:28:06.228+00	2023-02-10 15:38:01.525+00	f	\N	Each	f	t	1	5896a66f-300c-4944-8e6b-f9d31c6ab001	1
f445a5da-7c5d-433a-859e-0e56e2f00002	7	2023-02-10 15:28:06.228+00	2023-02-10 15:38:01.525+00	f	\N	Gram	f	t	1	5896a66f-300c-4944-8e6b-f9d31c6ab002	1
f445a5da-7c5d-433a-859e-0e56e2f00003	8	2023-02-10 15:28:06.228+00	2023-02-10 15:38:01.525+00	f	\N	Kilogram	f	t	1	5896a66f-300c-4944-8e6b-f9d31c6ab002	1
f445a5da-7c5d-433a-859e-0e56e2f00004	9	2023-02-10 15:28:06.228+00	2023-02-10 15:38:01.525+00	f	\N	Pound	f	t	1	5896a66f-300c-4944-8e6b-f9d31c6ab002	1
f445a5da-7c5d-433a-859e-0e56e2f00005	10	2023-02-10 15:28:06.228+00	2023-02-10 15:38:01.525+00	f	\N	Meter	f	t	1	5896a66f-300c-4944-8e6b-f9d31c6ab003	1
f445a5da-7c5d-433a-859e-0e56e2f00006	11	2023-02-10 15:28:06.228+00	2023-02-10 15:38:01.525+00	f	\N	Centimeter	f	t	1	5896a66f-300c-4944-8e6b-f9d31c6ab003	1
f445a5da-7c5d-433a-859e-0e56e2f00007	12	2023-02-10 15:28:06.228+00	2023-02-10 15:38:01.525+00	f	\N	Millimeter	f	t	1	5896a66f-300c-4944-8e6b-f9d31c6ab003	1
f445a5da-7c5d-433a-859e-0e56e2f00008	13	2023-02-10 15:28:06.228+00	2023-02-10 15:38:01.525+00	f	\N	Kilometer	f	t	1	5896a66f-300c-4944-8e6b-f9d31c6ab003	1
f445a5da-7c5d-433a-859e-0e56e2f00009	14	2023-02-10 15:28:06.228+00	2023-02-10 15:38:01.525+00	f	\N	Inch	f	t	1	5896a66f-300c-4944-8e6b-f9d31c6ab003	1
f445a5da-7c5d-433a-859e-0e56e2f00011	16	2023-02-10 15:28:06.228+00	2023-02-10 15:38:01.525+00	f	\N	Milliliter	f	t	1	5896a66f-300c-4944-8e6b-f9d31c6ab004	1
f445a5da-7c5d-433a-859e-0e56e2f00012	17	2023-02-10 15:28:06.228+00	2023-02-10 15:38:01.525+00	f	\N	Gallon	f	t	1	5896a66f-300c-4944-8e6b-f9d31c6ab004	1
f445a5da-7c5d-433a-859e-0e56e2f00013	18	2023-02-10 15:28:06.228+00	2023-02-10 15:38:01.525+00	f	\N	Square Meter	f	t	1	5896a66f-300c-4944-8e6b-f9d31c6ab005	1
f445a5da-7c5d-433a-859e-0e56e2f00014	19	2023-02-10 15:28:06.228+00	2023-02-10 15:38:01.525+00	f	\N	Square Feet	f	t	1	5896a66f-300c-4944-8e6b-f9d31c6ab005	1
f445a5da-7c5d-433a-859e-0e56e2f00015	20	2023-02-10 15:28:06.228+00	2023-02-10 15:38:01.525+00	f	\N	Square Inch	f	t	1	5896a66f-300c-4944-8e6b-f9d31c6ab005	1
f445a5da-7c5d-433a-859e-0e56e2f00010	15	2023-02-10 15:28:06.228+00	2024-07-20 04:22:09.762246+00	f	\N	Litre	f	t	1	5896a66f-300c-4944-8e6b-f9d31c6ab004	3
\.


--
-- Data for Name: products_unit_measurement; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.products_unit_measurement (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, unit_of_measurement, vendor_created, is_admin_approved, creator_id, updater_id) FROM stdin;
5896a66f-300c-4944-8e6b-f9d31c6ab001	1	2023-02-10 15:28:06.228+00	2023-02-10 15:38:01.525+00	f	\N	Quantity	f	t	1	1
5896a66f-300c-4944-8e6b-f9d31c6ab002	2	2023-02-10 15:28:06.228+00	2023-02-10 15:38:01.525+00	f	\N	Weight	f	t	1	1
5896a66f-300c-4944-8e6b-f9d31c6ab003	3	2023-02-10 15:28:06.228+00	2023-02-10 15:38:01.525+00	f	\N	Length	f	t	1	1
5896a66f-300c-4944-8e6b-f9d31c6ab004	4	2023-02-10 15:28:06.228+00	2023-02-10 15:38:01.525+00	f	\N	Volume	f	t	1	1
5896a66f-300c-4944-8e6b-f9d31c6ab005	5	2023-02-10 15:28:06.228+00	2023-02-10 15:38:01.525+00	f	\N	Area	f	t	1	1
\.


--
-- Data for Name: purchase; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.purchase (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, date, purchase_no, purchase_id, product_total, round_off, discount, subtotal, paid, balance, credit_date, payment_method, add_gst, is_updated, creator_id, payment_voucher_id, purchase_prefix_id, supplier_id, updater_id, warehouse_id) FROM stdin;
4c4e835f-acd0-4a0a-9c32-7b773eb873f9	1	2024-10-25 12:51:34.293426+00	2024-10-25 12:51:34.29345+00	f	\N	2024-10-25 12:51:34.290337+00	1	NXP000001	800.000	0.000	0.000	800.000	0.000	800.000	2024-10-28	credit	t	f	1	\N	b1f380c7-02dc-4aa1-b52f-6f4af14ac7b0	6631610e-1744-4a2b-891e-8f125ffba1f5	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
f19b2565-faae-4388-af34-c7db001866e1	2	2024-11-20 12:42:09.401491+00	2024-11-20 12:42:09.401516+00	f	\N	2024-11-20 12:42:09.395121+00	2	NXP000002	4000.000	0.000	0.000	4000.000	0.000	4000.000	2024-11-24	credit	t	f	1	\N	b1f380c7-02dc-4aa1-b52f-6f4af14ac7b0	6631610e-1744-4a2b-891e-8f125ffba1f5	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
af5124bc-99bb-4789-8a98-59370fb36016	3	2025-03-07 11:12:17.492041+00	2025-03-07 11:12:17.492062+00	f	\N	2025-03-07 11:12:17.48838+00	3	NXP000003	4350.000	0.000	0.000	4350.000	0.000	4350.000	2025-03-07	credit	t	f	1	\N	b1f380c7-02dc-4aa1-b52f-6f4af14ac7b0	6631610e-1744-4a2b-891e-8f125ffba1f5	1	6568014e-bb8e-4058-8abc-20b985c67d29
734c0bb5-62db-4ba9-9150-6caea90cd3b1	4	2025-03-14 15:31:25.053739+00	2025-03-14 15:31:25.05377+00	f	\N	2025-03-14 15:31:25.048884+00	4	NXP000004	29000.000	-0.200	1.720	28501.000	5000.000	23501.000	\N	cash	t	f	1	ca2f9f87-4aba-4deb-83c5-a347d760ec84	b1f380c7-02dc-4aa1-b52f-6f4af14ac7b0	6631610e-1744-4a2b-891e-8f125ffba1f5	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
b72ae4a6-425b-41de-b272-3fc7286f1b34	5	2025-04-02 13:50:45.103743+00	2025-04-02 13:50:45.103778+00	f	\N	2025-04-02 13:50:45.097214+00	5	NXP000005	3750.000	0.000	0.000	3750.000	0.000	3750.000	2025-04-10	credit	t	f	1	\N	b1f380c7-02dc-4aa1-b52f-6f4af14ac7b0	6631610e-1744-4a2b-891e-8f125ffba1f5	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
3c718429-9fbc-4941-92a6-3c5f3a901305	6	2025-07-12 14:32:24.535264+00	2025-07-12 14:32:24.535288+00	f	\N	2025-07-12 14:32:24.531445+00	6	NXP000006	174.000	0.000	0.000	174.000	0.000	174.000	2025-07-17	credit	t	f	1	\N	b1f380c7-02dc-4aa1-b52f-6f4af14ac7b0	6631610e-1744-4a2b-891e-8f125ffba1f5	1	6568014e-bb8e-4058-8abc-20b985c67d29
a7f46dca-cdc1-436e-aa44-e9217536a3c6	7	2025-07-16 13:52:27.468872+00	2025-07-16 13:57:02.621865+00	f	\N	2025-07-16 13:57:02.621754+00	7	NXP000007	1500.000	0.000	0.000	1500.000	0.000	1500.000	2025-07-17	credit	t	t	1	\N	b1f380c7-02dc-4aa1-b52f-6f4af14ac7b0	6631610e-1744-4a2b-891e-8f125ffba1f5	1	6568014e-bb8e-4058-8abc-20b985c67d29
d396f6bd-7846-4caa-ad09-1177e196caca	8	2025-07-17 15:42:03.354555+00	2025-07-17 15:42:03.354568+00	f	\N	2025-07-17 15:42:03.351938+00	8	NXP000008	800.000	0.000	0.000	800.000	0.000	800.000	2025-07-18	credit	t	f	1	\N	b1f380c7-02dc-4aa1-b52f-6f4af14ac7b0	6631610e-1744-4a2b-891e-8f125ffba1f5	1	e9c91e4d-271c-4063-90d0-87038135e85e
599ec009-5913-4cc7-bd7d-0d6008a3f33e	9	2025-07-28 08:44:11.015168+00	2025-07-28 08:44:11.015191+00	f	\N	2025-07-28 08:44:11.011084+00	9	NXP000009	40000.000	0.000	0.000	40000.000	0.000	40000.000	2025-07-31	credit	t	f	1	\N	b1f380c7-02dc-4aa1-b52f-6f4af14ac7b0	6631610e-1744-4a2b-891e-8f125ffba1f5	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
\.


--
-- Data for Name: purchase_item; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.purchase_item (id, add_new_batch, batch_number, quantity, return_qty, manufacturing_date, expire_date, discount, net_rate, igst_rate, sgst_rate, cgst_rate, taxable_amount, mrp, retail_price, whole_sale_price, amount, total, gross_amount, hsn, comments, unit_type, cgst_amount, sgst_amount, igst_amount, batch_id, product_variant_id, purchase_id) FROM stdin;
1	t	0DEFLT	5.000	0.00	2024-10-25	2024-10-30 18:30:00+00	0.00	800.00	0.00	0.00	0.00	800.00	220.00	195.000	190.000	160.00	800.00	0.00	\N	\N	\N	0.00	0.00	0.00	e14b6d1b-840d-4913-836c-e390f47b6dea	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3	4c4e835f-acd0-4a0a-9c32-7b773eb873f9
2	f	0DEFLT	25.000	0.00	2024-10-25	2024-10-30 18:30:00+00	0.00	4000.00	0.00	0.00	0.00	4000.00	220.00	195.000	190.000	160.00	4000.00	0.00	\N	\N	\N	0.00	0.00	0.00	e14b6d1b-840d-4913-836c-e390f47b6dea	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3	f19b2565-faae-4388-af34-c7db001866e1
3	f	00	25.000	0.00	2024-10-25	2024-10-24 18:30:00+00	0.00	4350.00	0.00	0.00	0.00	4350.00	200.00	195.000	190.000	174.00	4350.00	0.00	\N	\N	\N	0.00	0.00	0.00	0b2be5cd-c882-41b2-9daa-a6a0aca83058	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3	af5124bc-99bb-4789-8a98-59370fb36016
4	t	1242	200.000	0.00	2024-10-25	2026-06-09 18:30:00+00	0.00	29000.00	0.00	0.00	0.00	29000.00	220.00	195.000	190.000	145.00	29000.00	0.00	\N	\N	\N	0.00	0.00	0.00	704832fc-98cd-48d5-b156-d66cb21caba9	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3	734c0bb5-62db-4ba9-9150-6caea90cd3b1
5	t	1248	25.000	0.00	2025-04-01	2025-04-01 18:30:00+00	0.00	3750.00	0.00	0.00	0.00	3750.00	220.00	195.000	160.000	150.00	3750.00	0.00	\N	\N	\N	0.00	0.00	0.00	6d8e4b0b-dc44-41cb-8834-78835b3559bb	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3	b72ae4a6-425b-41de-b272-3fc7286f1b34
6	f	00	1.000	0.00	2024-10-25	2024-10-24 18:30:00+00	0.00	174.00	0.00	0.00	0.00	174.00	200.00	195.000	150.000	174.00	174.00	0.00	\N	\N	\N	0.00	0.00	0.00	0b2be5cd-c882-41b2-9daa-a6a0aca83058	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3	3c718429-9fbc-4941-92a6-3c5f3a901305
8	f	1248	10.000	0.00	2025-04-01	2025-04-01 18:30:00+00	0.00	1500.00	0.00	0.00	0.00	1500.00	220.00	195.000	160.000	150.00	1500.00	0.00	\N	\N	\N	0.00	0.00	0.00	6d8e4b0b-dc44-41cb-8834-78835b3559bb	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3	a7f46dca-cdc1-436e-aa44-e9217536a3c6
9	t	1248	10.000	0.00	2025-07-17	2025-07-16 18:30:00+00	0.00	800.00	0.00	0.00	0.00	800.00	120.00	120.000	110.000	80.00	800.00	0.00	\N	\N	\N	0.00	0.00	0.00	167a1337-86db-4a1f-b624-7f055d4276e9	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3	d396f6bd-7846-4caa-ad09-1177e196caca
10	f	230725	500.000	0.00	2025-07-02	2025-07-27 18:30:00+00	0.00	40000.00	0.00	0.00	0.00	40000.00	150.00	120.000	110.000	80.00	40000.00	0.00	\N	\N	\N	0.00	0.00	0.00	48ab8d69-03a1-485b-b230-ed66b0e22c60	9a7c44b8-79e7-476f-8fb0-6d10fec63f75	599ec009-5913-4cc7-bd7d-0d6008a3f33e
\.


--
-- Data for Name: purchase_order; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.purchase_order (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, date, order_no, order_id, product_total, round_off, discount, subtotal, add_gst, is_updated, is_partial, is_purchased, creator_id, purchase_id, supplier_id, updater_id, warehouse_id) FROM stdin;
83fd9109-f4d8-4a35-b55a-017e7aa9f8a1	1	2025-07-12 14:31:18.225928+00	2025-07-12 14:32:24.57792+00	f	\N	2025-07-12 14:31:18.222919+00	1	PURO0001	174.000	0.000	0.000	174.000	f	f	f	t	1	3c718429-9fbc-4941-92a6-3c5f3a901305	6631610e-1744-4a2b-891e-8f125ffba1f5	1	6568014e-bb8e-4058-8abc-20b985c67d29
\.


--
-- Data for Name: purchase_order_item; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.purchase_order_item (id, add_new_batch, batch_number, quantity, expire_date, manufacturing_date, discount, igst_rate, sgst_rate, cgst_rate, taxable_amount, net_rate, mrp, retail_price, whole_sale_price, amount, hsn, comments, unit_type, total, cgst_amount, sgst_amount, igst_amount, gross_amount, is_purchased, batch_id, product_variant_id, purchase_order_id) FROM stdin;
1	f	00	1.000	2024-10-24 18:30:00+00	2024-10-25	0.00	0.00	0.00	0.00	174.00	174.00	200.00	195.000	150.000	174.00	\N	\N	\N	174.00	0.00	0.00	0.00	0.00	f	0b2be5cd-c882-41b2-9daa-a6a0aca83058	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3	83fd9109-f4d8-4a35-b55a-017e7aa9f8a1
\.


--
-- Data for Name: purchase_return; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.purchase_return (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, date, total, amount_returned, is_updated, creator_id, purchase_id, supplier_id, updater_id) FROM stdin;
88e2b9e1-181c-4c3c-8edf-2e668871bb08	1	2025-07-16 13:20:19.706421+00	2025-07-16 13:20:19.706459+00	f	\N	2025-07-16	0.00	0.00	f	1	734c0bb5-62db-4ba9-9150-6caea90cd3b1	6631610e-1744-4a2b-891e-8f125ffba1f5	1
0bd05be9-4cb9-42bd-833d-05420e8cc85c	2	2025-07-16 13:20:49.418032+00	2025-07-16 13:20:49.41806+00	f	\N	2025-07-16	0.00	0.00	f	1	3c718429-9fbc-4941-92a6-3c5f3a901305	6631610e-1744-4a2b-891e-8f125ffba1f5	1
7428eb38-3f71-404a-9e46-4ce4a141e9b6	3	2025-07-16 13:22:33.370212+00	2025-07-16 13:22:33.370246+00	f	\N	2025-07-16	0.00	0.00	f	1	3c718429-9fbc-4941-92a6-3c5f3a901305	6631610e-1744-4a2b-891e-8f125ffba1f5	1
13467cb4-f61d-45c2-aaa3-8c2c67efde99	4	2025-12-16 15:49:12.420545+00	2025-12-16 15:49:12.420566+00	f	\N	2025-12-16	0.00	0.00	f	1	599ec009-5913-4cc7-bd7d-0d6008a3f33e	6631610e-1744-4a2b-891e-8f125ffba1f5	1
\.


--
-- Data for Name: purchase_return_item; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.purchase_return_item (id, quantity, amount, total, status, is_deleted, batch_id, product_id, product_variant_id, purchase_item_id, purchase_return_id) FROM stdin;
\.


--
-- Data for Name: registration_registrationprofile; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.registration_registrationprofile (id, activation_key, user_id, activated) FROM stdin;
\.


--
-- Data for Name: registration_supervisedregistrationprofile; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.registration_supervisedregistrationprofile (registrationprofile_ptr_id) FROM stdin;
\.


--
-- Data for Name: return_images; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.return_images (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, image, creator_id, product_return_id, updater_id) FROM stdin;
\.


--
-- Data for Name: salary_pay; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.salary_pay (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, date, leave_count, half_leave_count, salary, is_paid, paid_amount, creator_id, staff_id, updater_id) FROM stdin;
\.


--
-- Data for Name: sale_return; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.sale_return (id, auto_id, date_added, date_updated, deleted_reason, "time", a_id, amount_returned, returnable_amount, is_updated, is_deleted, creator_id, customer_id, sale_id, updater_id, warehouse_id) FROM stdin;
6bd71e23-d9ba-426a-bb85-970b5ab25677	1	2025-04-02 14:46:14.140466+00	2025-04-02 14:46:14.140492+00	\N	2025-04-01 18:30:00+00	1	3900.00	\N	f	f	1	760a809a-b409-44bf-83cb-79f76762cece	a0ee42af-4447-4290-b786-ce9e0ad05bc9	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
\.


--
-- Data for Name: sale_return_item; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.sale_return_item (id, qty, price, cost, status, is_deleted, batch_id, product_id, product_variant_id, sale_item_id, sale_return_id) FROM stdin;
1	20.000	195.00	0.00	returnable	f	6d8e4b0b-dc44-41cb-8834-78835b3559bb	ed362c81-e154-49bb-a5a3-88efb27d9870	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3	5	6bd71e23-d9ba-426a-bb85-970b5ab25677
\.


--
-- Data for Name: sales; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.sales (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, a_id, sale_no, tracking_no, sale_id, tracking_id, sale_date, shipment_date, customer_address, approval_status, sale_category, sale_type, payment_method, credit_date, transporter, subtotal, round_off, total, paid, discount_rate, discount, special_discount, use_privilege_point, privilege_point_used, privilege_point_amnt, privilege_points, total_cgst, total_igst, total_sgst, customer_balance_type, customer_balance, tax_amount, sale_taxable_amount, purchase_taxable_amount, total_commission, total_outstanding, add_gst, is_updated, creator_id, customer_id, receipt_voucher_id, sale_prefix_id, updater_id, warehouse_id) FROM stdin;
2ed66c47-92a8-477c-9765-5e1f92cbbc5c	4	2025-03-14 15:25:21.869891+00	2025-07-09 17:38:20.809105+00	t	Ss	4	4	4	NXR000004	TR4	2025-03-14 15:25:21.866039+00	2025-03-14	gggg	pending	inter_state	b2c	credit	2025-03-21	14544	4875.00	0.000	4800.00	0.00	1.54	75.00	0.00	f	0	0.00	0	0.00	0.00	0.00	Debit	0.00	0.00	4875.00	4000.00	0.00	4800.00	f	f	1	760a809a-b409-44bf-83cb-79f76762cece	\N	b1f380c7-02dc-4aa1-b52f-6f4af14ac7b0	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
d38b4767-2c87-4f14-9f83-42550ed7af4b	6	2025-07-09 10:39:01.063075+00	2025-07-09 17:39:13.12125+00	t	Ss	6	6	6	NXS000006	TR6	2025-07-09 10:39:01.054543+00	2025-07-09	gggg	pending	inter_state	b2c	credit	2025-07-11	nnnn	975.00	0.000	975.00	0.00	0.00	0.00	0.00	f	0	0.00	0	0.00	0.00	0.00	Debit	0.00	0.00	975.00	750.00	0.00	975.00	f	f	1	760a809a-b409-44bf-83cb-79f76762cece	\N	6623f5eb-b7e8-4b15-96c9-d832616b280d	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
9d5c0d4a-fd13-42d3-8070-940d6fb7192f	3	2025-03-12 12:53:56.109652+00	2025-03-12 12:53:56.109676+00	f	\N	3	3	3	NXR000003	TR3	2025-03-12 12:53:56.103893+00	2025-03-12	gggg	pending	inter_state	b2c	bank transfer	\N	nnnn	195.00	0.000	195.00	195.00	0.00	0.00	0.00	f	0	0.00	0	0.00	0.00	0.00	Debit	0.00	0.00	195.00	160.00	0.00	195.00	f	f	1	c6488465-a403-4642-92ce-210e51956062	6eaf5894-8813-4407-9818-b1468055773e	b1f380c7-02dc-4aa1-b52f-6f4af14ac7b0	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
e9f3c629-5521-4b63-bce6-da9ed5cf076d	9	2025-07-17 15:49:26.538315+00	2025-07-17 15:49:26.538329+00	f	\N	1	9	9	NXS000009	TR9	2025-07-17 15:49:26.535352+00	2025-07-17	gggg	pending	inter_state	b2c	credit	2025-07-18	JJJ	120.00	0.000	120.00	0.00	0.00	0.00	0.00	f	0	0.00	0	0.00	0.00	0.00	Debit	0.00	0.00	120.00	80.00	0.00	120.00	f	f	1	c6488465-a403-4642-92ce-210e51956062	\N	6623f5eb-b7e8-4b15-96c9-d832616b280d	1	e9c91e4d-271c-4063-90d0-87038135e85e
2e235ee4-260d-4567-ac7b-bcf84891c019	2	2025-03-12 12:47:07.238205+00	2025-03-12 12:47:07.238237+00	f	\N	2	2	2	NXR000002	TR2	2025-03-12 12:47:07.23296+00	2025-03-12	gggg	pending	intra_state	b2c	cash	\N	nnnn	195.00	0.000	195.00	195.00	0.00	0.00	0.00	f	0	0.00	0	0.00	0.00	0.00	Debit	0.00	0.00	195.00	160.00	0.00	195.00	f	f	1	0ca5eb0b-1bf8-48ee-b11c-f1fa306e36c1	44789b96-2a8f-48bc-87cf-fc2ad6013920	b1f380c7-02dc-4aa1-b52f-6f4af14ac7b0	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
fefef6fd-f0b7-4cca-8e33-e7694f1bab24	10	2025-07-28 08:45:40.58326+00	2025-07-28 08:45:40.583282+00	f	\N	9	10	10	NXS000010	TR10	2025-07-28 08:45:40.579331+00	2025-07-28	JJJ	pending	intra_state	b2c	cash	\N	JJJJJ	12000.00	0.000	12000.00	12000.00	0.00	0.00	0.00	f	0	0.00	0	0.00	0.00	0.00	Debit	0.00	0.00	12000.00	8000.00	0.00	12000.00	f	f	1	0ca5eb0b-1bf8-48ee-b11c-f1fa306e36c1	5b9e66fc-c6b5-4fdb-a5ce-032a27f1e359	6623f5eb-b7e8-4b15-96c9-d832616b280d	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
f3615602-cbcb-4360-9e17-e3385200035e	11	2025-07-28 08:45:43.294227+00	2025-07-28 08:45:43.29425+00	f	\N	10	11	11	NXS000010	TR11	2025-07-28 08:45:43.2904+00	2025-07-28	JJJ	pending	intra_state	b2c	cash	\N	JJJJJ	12000.00	0.000	12000.00	12000.00	0.00	0.00	0.00	f	0	0.00	0	0.00	0.00	0.00	Debit	0.00	0.00	12000.00	8000.00	0.00	12000.00	f	f	1	0ca5eb0b-1bf8-48ee-b11c-f1fa306e36c1	95169cd3-e46d-4e9b-8613-a42b584a3c6e	6623f5eb-b7e8-4b15-96c9-d832616b280d	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
6b8bf5df-e723-4c0f-84c2-16aa382ea9ef	1	2025-02-06 09:55:27.069057+00	2025-02-06 09:55:27.069081+00	f	\N	1	1	1	NXR000001	TR1	2025-02-06 09:55:27.067298+00	2025-02-06	dd	pending	inter_state	b2c	cash	\N	jj	195.00	0.000	195.00	195.00	0.00	0.00	0.00	f	0	0.00	0	0.00	0.00	0.00	Debit	0.00	0.00	195.00	160.00	0.00	195.00	f	f	1	c6488465-a403-4642-92ce-210e51956062	f22e35ad-2633-4dd4-bd68-79f875bffe35	b1f380c7-02dc-4aa1-b52f-6f4af14ac7b0	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
bf5c3de6-2579-455a-ab8d-29f77dc64f71	12	2025-09-04 13:03:47.624053+00	2025-09-04 13:03:47.624075+00	f	\N	11	12	12	NXS000012	TR12	2025-09-04 13:03:47.620157+00	2025-09-04	kk	pending	inter_state	b2c	cash	\N	kk	34320.00	0.000	34320.00	50000.00	0.00	0.00	0.00	f	0	0.00	0	0.00	0.00	0.00	Debit	0.00	0.00	34320.00	22880.00	0.00	34320.00	f	f	1	760a809a-b409-44bf-83cb-79f76762cece	8a457146-4b39-4e73-9e8d-abe050cebffd	6623f5eb-b7e8-4b15-96c9-d832616b280d	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
c112a917-cb57-4532-b4e7-e3b13d30574d	7	2025-07-09 11:23:40.735523+00	2025-07-09 11:23:40.735558+00	f	\N	7	7	7	NXS000007	TR7	2025-07-09 11:23:40.728523+00	2025-07-09	dd	pending	inter_state	b2c	cash	\N	lkl	975.00	-0.040	950.00	950.00	2.56	24.96	0.00	f	0	0.00	0	0.00	0.00	0.00	Debit	0.00	0.00	975.00	750.00	0.00	950.00	f	f	1	29e61444-5029-4b31-a751-598c2df7a502	96ef3849-cefe-4c12-8938-17fe15fc05c9	6623f5eb-b7e8-4b15-96c9-d832616b280d	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
4c00bc7c-0ef9-47e2-8d90-371071afe28a	8	2025-07-16 08:54:33.52595+00	2025-07-16 08:54:33.525974+00	f	\N	8	8	8	NXS000008	TR8	2025-07-16 08:54:33.519663+00	2025-07-16	jnj	pending	inter_state	b2c	credit	2025-07-17	nnnl	195.00	0.000	195.00	0.00	0.00	0.00	0.00	f	0	0.00	0	0.00	0.00	0.00	Debit	0.00	0.00	195.00	160.00	0.00	195.00	f	f	1	29e61444-5029-4b31-a751-598c2df7a502	\N	6623f5eb-b7e8-4b15-96c9-d832616b280d	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
a0ee42af-4447-4290-b786-ce9e0ad05bc9	5	2025-04-02 14:01:19.646311+00	2025-04-02 14:01:19.646341+00	f	\N	5	5	5	NXS000001	TR5	2025-04-02 14:01:19.641872+00	2025-04-02	gggg	pending	inter_state	b2c	cash	\N	nnnn	4875.00	0.000	4875.00	4875.00	0.00	0.00	0.00	f	0	0.00	0	0.00	0.00	0.00	Debit	0.00	0.00	4875.00	3750.00	0.00	4875.00	f	f	1	760a809a-b409-44bf-83cb-79f76762cece	215966f5-9562-4113-bfe8-e708e3e71378	6623f5eb-b7e8-4b15-96c9-d832616b280d	1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
\.


--
-- Data for Name: sales_sale_item; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.sales_sale_item (id, comments, return_qty, quantity, amount, mrp, total, sub_total, net_rate, discount_rate, discount, igst_rate, cgst_rate, sgst_rate, igst_amount, cgst_amount, sgst_amount, commission_amount, purchase_taxable_amount, sale_taxable_amount, batch_id, product_variant_id, sale_id) FROM stdin;
1	\N	0.00	1.000	195.000	220.00	195.00	195.00	220.00	0.00	25.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	160.00	195.00	e14b6d1b-840d-4913-836c-e390f47b6dea	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3	6b8bf5df-e723-4c0f-84c2-16aa382ea9ef
2	\N	0.00	1.000	195.000	220.00	195.00	195.00	220.00	0.00	25.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	160.00	195.00	e14b6d1b-840d-4913-836c-e390f47b6dea	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3	2e235ee4-260d-4567-ac7b-bcf84891c019
3	\N	0.00	1.000	195.000	220.00	195.00	195.00	220.00	0.00	25.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	160.00	195.00	e14b6d1b-840d-4913-836c-e390f47b6dea	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3	9d5c0d4a-fd13-42d3-8070-940d6fb7192f
4	\N	0.00	25.000	195.000	220.00	4875.00	4875.00	5500.00	0.00	625.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	4000.00	4875.00	e14b6d1b-840d-4913-836c-e390f47b6dea	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3	2ed66c47-92a8-477c-9765-5e1f92cbbc5c
5	\N	20.00	25.000	195.000	220.00	4875.00	4875.00	5500.00	0.00	625.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	3750.00	4875.00	6d8e4b0b-dc44-41cb-8834-78835b3559bb	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3	a0ee42af-4447-4290-b786-ce9e0ad05bc9
6	\N	0.00	5.000	195.000	220.00	975.00	975.00	1100.00	0.00	125.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	750.00	975.00	6d8e4b0b-dc44-41cb-8834-78835b3559bb	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3	d38b4767-2c87-4f14-9f83-42550ed7af4b
7	\N	0.00	5.000	195.000	220.00	975.00	975.00	1100.00	0.00	125.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	750.00	975.00	6d8e4b0b-dc44-41cb-8834-78835b3559bb	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3	c112a917-cb57-4532-b4e7-e3b13d30574d
8	\N	0.00	1.000	195.000	220.00	195.00	195.00	220.00	0.00	25.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	160.00	195.00	e14b6d1b-840d-4913-836c-e390f47b6dea	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3	4c00bc7c-0ef9-47e2-8d90-371071afe28a
9	\N	0.00	1.000	120.000	120.00	120.00	120.00	120.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	80.00	120.00	167a1337-86db-4a1f-b624-7f055d4276e9	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3	e9f3c629-5521-4b63-bce6-da9ed5cf076d
10	\N	0.00	100.000	120.000	150.00	12000.00	12000.00	15000.00	0.00	3000.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	8000.00	12000.00	48ab8d69-03a1-485b-b230-ed66b0e22c60	9a7c44b8-79e7-476f-8fb0-6d10fec63f75	fefef6fd-f0b7-4cca-8e33-e7694f1bab24
11	\N	0.00	100.000	120.000	150.00	12000.00	12000.00	15000.00	0.00	3000.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	8000.00	12000.00	48ab8d69-03a1-485b-b230-ed66b0e22c60	9a7c44b8-79e7-476f-8fb0-6d10fec63f75	f3615602-cbcb-4360-9e17-e3385200035e
12	\N	0.00	286.000	120.000	150.00	34320.00	34320.00	42900.00	0.00	8580.00	0.00	0.00	0.00	0.00	0.00	0.00	0.00	22880.00	34320.00	48ab8d69-03a1-485b-b230-ed66b0e22c60	9a7c44b8-79e7-476f-8fb0-6d10fec63f75	bf5c3de6-2579-455a-ab8d-29f77dc64f71
\.


--
-- Data for Name: setting; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.setting (id, counter, prefix, project_prefix, product_prefix, purchase_prefix, sale_prefix, payment_prefix, is_deleted) FROM stdin;
\.


--
-- Data for Name: special_variant; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.special_variant (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, name, product_code, description, actual_price, amount, quantity, created_variant_id, creator_id, updater_id) FROM stdin;
\.


--
-- Data for Name: special_variant_product_variant; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.special_variant_product_variant (id, specialvariant_id, productvariant_id) FROM stdin;
\.


--
-- Data for Name: staff; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.staff (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, staff_id, name, email, phone, gender, photo, address, staff_role, joining_date, staff_age, current_salary, salary, bank_name, branch, bank_account_name, ifsc_code, account_num, password, is_currently_working, normal_staff, super_admin, client_manager, staff_manager, advance_salary, credit, debit, creator_id, designation_id, updater_id, user_id, warehouse_id) FROM stdin;
a9d3867e-51d1-43a1-82ee-d22cbe145cea	1	2024-07-17 12:48:54.621458+00	2024-07-17 12:48:54.62148+00	f	\N	ONZ0001	ABHINAYA	abhiabhinaya92@gmail.com	7907073533	female	staffs/photo/f6033d8c-ca4b-4cf2-be4b-ea07a6ad6489.jpeg	abhiabhinaya92@gmail.com	billing_staff	2024-07-17 18:30:00+00	28	7000.00	7000	CANARA BANK	KILIMANOOR	ABHINAYA	CNRB0003475	0716108045801	Abhi@123	f	f	f	f	f	0.00	0.0000	0.0000	1	178d9864-307d-4c13-9927-430caa2924ce	1	3	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
bc5bb326-1199-42e7-abb0-381331f3bd47	2	2024-10-25 09:58:22.790662+00	2024-10-25 15:29:21.541012+00	f	\N	ONZ0002	MUNEER	\N	7558837413	male		KALLARA	warehouse_manager	2024-10-24 18:30:00+00	27	0.00	0	\N	\N	\N	\N	\N	Arafa@123	f	f	f	f	f	0.00	0.0000	0.0000	1	178d9864-307d-4c13-9927-430caa2924ce	1	14	e9c91e4d-271c-4063-90d0-87038135e85e
674c03b0-ba50-4e84-b08f-25361264cdbe	3	2025-07-17 16:00:14.652635+00	2025-07-17 16:00:14.652654+00	f	\N	ONZ0003	SARATH	sarathsasanka@gmail.com	9745088002	male		Rushidha Manzil	warehouse_manager	2025-07-16 18:30:00+00	34	35000.00	35000	hdfc kallara	kalllara	212121212121	DDDD111	124151456	s9745088002	f	f	f	f	f	0.00	0.0000	0.0000	1	178d9864-307d-4c13-9927-430caa2924ce	1	18	e9c91e4d-271c-4063-90d0-87038135e85e
\.


--
-- Data for Name: staff_attendence; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.staff_attendence (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, date, leave_count, half_leave_count, is_present, is_leave, is_halfday, is_excuseleave, is_holiday, is_work_at_home, creator_id, staff_id, updater_id) FROM stdin;
431ec560-bb57-489a-8cc6-0248f1b7b1e1	1	2024-07-19 11:56:17.866671+00	2024-07-19 11:56:17.866695+00	f	\N	2024-07-19	0.00	0.00	f	f	f	f	f	t	1	a9d3867e-51d1-43a1-82ee-d22cbe145cea	1
\.


--
-- Data for Name: staff_permission; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.staff_permission (id, staff_id, permission_id) FROM stdin;
127	a9d3867e-51d1-43a1-82ee-d22cbe145cea	11
128	a9d3867e-51d1-43a1-82ee-d22cbe145cea	12
129	a9d3867e-51d1-43a1-82ee-d22cbe145cea	14
130	a9d3867e-51d1-43a1-82ee-d22cbe145cea	1
131	a9d3867e-51d1-43a1-82ee-d22cbe145cea	2
132	a9d3867e-51d1-43a1-82ee-d22cbe145cea	3
133	a9d3867e-51d1-43a1-82ee-d22cbe145cea	4
134	a9d3867e-51d1-43a1-82ee-d22cbe145cea	5
135	a9d3867e-51d1-43a1-82ee-d22cbe145cea	6
136	a9d3867e-51d1-43a1-82ee-d22cbe145cea	7
137	a9d3867e-51d1-43a1-82ee-d22cbe145cea	8
138	a9d3867e-51d1-43a1-82ee-d22cbe145cea	9
139	a9d3867e-51d1-43a1-82ee-d22cbe145cea	10
140	a9d3867e-51d1-43a1-82ee-d22cbe145cea	76
141	a9d3867e-51d1-43a1-82ee-d22cbe145cea	77
142	a9d3867e-51d1-43a1-82ee-d22cbe145cea	78
143	a9d3867e-51d1-43a1-82ee-d22cbe145cea	79
144	a9d3867e-51d1-43a1-82ee-d22cbe145cea	80
145	a9d3867e-51d1-43a1-82ee-d22cbe145cea	91
146	a9d3867e-51d1-43a1-82ee-d22cbe145cea	92
147	a9d3867e-51d1-43a1-82ee-d22cbe145cea	93
148	a9d3867e-51d1-43a1-82ee-d22cbe145cea	94
149	a9d3867e-51d1-43a1-82ee-d22cbe145cea	95
150	a9d3867e-51d1-43a1-82ee-d22cbe145cea	235
151	a9d3867e-51d1-43a1-82ee-d22cbe145cea	236
152	a9d3867e-51d1-43a1-82ee-d22cbe145cea	237
153	a9d3867e-51d1-43a1-82ee-d22cbe145cea	238
154	a9d3867e-51d1-43a1-82ee-d22cbe145cea	239
155	a9d3867e-51d1-43a1-82ee-d22cbe145cea	250
156	a9d3867e-51d1-43a1-82ee-d22cbe145cea	251
157	a9d3867e-51d1-43a1-82ee-d22cbe145cea	252
158	a9d3867e-51d1-43a1-82ee-d22cbe145cea	253
159	a9d3867e-51d1-43a1-82ee-d22cbe145cea	254
160	a9d3867e-51d1-43a1-82ee-d22cbe145cea	46
161	a9d3867e-51d1-43a1-82ee-d22cbe145cea	47
162	a9d3867e-51d1-43a1-82ee-d22cbe145cea	48
163	a9d3867e-51d1-43a1-82ee-d22cbe145cea	49
164	a9d3867e-51d1-43a1-82ee-d22cbe145cea	50
165	a9d3867e-51d1-43a1-82ee-d22cbe145cea	86
166	a9d3867e-51d1-43a1-82ee-d22cbe145cea	87
167	a9d3867e-51d1-43a1-82ee-d22cbe145cea	88
168	a9d3867e-51d1-43a1-82ee-d22cbe145cea	89
169	a9d3867e-51d1-43a1-82ee-d22cbe145cea	90
170	a9d3867e-51d1-43a1-82ee-d22cbe145cea	21
171	a9d3867e-51d1-43a1-82ee-d22cbe145cea	22
172	a9d3867e-51d1-43a1-82ee-d22cbe145cea	23
173	a9d3867e-51d1-43a1-82ee-d22cbe145cea	24
174	a9d3867e-51d1-43a1-82ee-d22cbe145cea	25
175	a9d3867e-51d1-43a1-82ee-d22cbe145cea	26
176	a9d3867e-51d1-43a1-82ee-d22cbe145cea	27
177	a9d3867e-51d1-43a1-82ee-d22cbe145cea	28
178	a9d3867e-51d1-43a1-82ee-d22cbe145cea	29
179	a9d3867e-51d1-43a1-82ee-d22cbe145cea	30
180	a9d3867e-51d1-43a1-82ee-d22cbe145cea	51
181	a9d3867e-51d1-43a1-82ee-d22cbe145cea	52
182	a9d3867e-51d1-43a1-82ee-d22cbe145cea	53
183	a9d3867e-51d1-43a1-82ee-d22cbe145cea	54
184	a9d3867e-51d1-43a1-82ee-d22cbe145cea	55
185	a9d3867e-51d1-43a1-82ee-d22cbe145cea	56
186	a9d3867e-51d1-43a1-82ee-d22cbe145cea	57
187	a9d3867e-51d1-43a1-82ee-d22cbe145cea	58
188	a9d3867e-51d1-43a1-82ee-d22cbe145cea	59
189	a9d3867e-51d1-43a1-82ee-d22cbe145cea	60
218	bc5bb326-1199-42e7-abb0-381331f3bd47	11
219	bc5bb326-1199-42e7-abb0-381331f3bd47	12
220	bc5bb326-1199-42e7-abb0-381331f3bd47	13
221	bc5bb326-1199-42e7-abb0-381331f3bd47	14
222	bc5bb326-1199-42e7-abb0-381331f3bd47	15
223	674c03b0-ba50-4e84-b08f-25361264cdbe	36
224	674c03b0-ba50-4e84-b08f-25361264cdbe	37
225	674c03b0-ba50-4e84-b08f-25361264cdbe	38
226	674c03b0-ba50-4e84-b08f-25361264cdbe	39
227	674c03b0-ba50-4e84-b08f-25361264cdbe	40
228	674c03b0-ba50-4e84-b08f-25361264cdbe	41
229	674c03b0-ba50-4e84-b08f-25361264cdbe	42
230	674c03b0-ba50-4e84-b08f-25361264cdbe	43
231	674c03b0-ba50-4e84-b08f-25361264cdbe	44
232	674c03b0-ba50-4e84-b08f-25361264cdbe	45
233	674c03b0-ba50-4e84-b08f-25361264cdbe	111
234	674c03b0-ba50-4e84-b08f-25361264cdbe	112
235	674c03b0-ba50-4e84-b08f-25361264cdbe	113
236	674c03b0-ba50-4e84-b08f-25361264cdbe	114
237	674c03b0-ba50-4e84-b08f-25361264cdbe	115
238	674c03b0-ba50-4e84-b08f-25361264cdbe	116
239	674c03b0-ba50-4e84-b08f-25361264cdbe	117
240	674c03b0-ba50-4e84-b08f-25361264cdbe	118
241	674c03b0-ba50-4e84-b08f-25361264cdbe	119
242	674c03b0-ba50-4e84-b08f-25361264cdbe	120
243	674c03b0-ba50-4e84-b08f-25361264cdbe	217
244	674c03b0-ba50-4e84-b08f-25361264cdbe	218
245	674c03b0-ba50-4e84-b08f-25361264cdbe	219
246	674c03b0-ba50-4e84-b08f-25361264cdbe	11
247	674c03b0-ba50-4e84-b08f-25361264cdbe	12
248	674c03b0-ba50-4e84-b08f-25361264cdbe	13
249	674c03b0-ba50-4e84-b08f-25361264cdbe	14
250	674c03b0-ba50-4e84-b08f-25361264cdbe	15
251	674c03b0-ba50-4e84-b08f-25361264cdbe	1
252	674c03b0-ba50-4e84-b08f-25361264cdbe	2
253	674c03b0-ba50-4e84-b08f-25361264cdbe	3
254	674c03b0-ba50-4e84-b08f-25361264cdbe	4
255	674c03b0-ba50-4e84-b08f-25361264cdbe	5
256	674c03b0-ba50-4e84-b08f-25361264cdbe	6
257	674c03b0-ba50-4e84-b08f-25361264cdbe	7
258	674c03b0-ba50-4e84-b08f-25361264cdbe	8
259	674c03b0-ba50-4e84-b08f-25361264cdbe	9
260	674c03b0-ba50-4e84-b08f-25361264cdbe	10
261	674c03b0-ba50-4e84-b08f-25361264cdbe	76
262	674c03b0-ba50-4e84-b08f-25361264cdbe	77
190	a9d3867e-51d1-43a1-82ee-d22cbe145cea	156
191	a9d3867e-51d1-43a1-82ee-d22cbe145cea	157
192	a9d3867e-51d1-43a1-82ee-d22cbe145cea	158
193	a9d3867e-51d1-43a1-82ee-d22cbe145cea	159
194	a9d3867e-51d1-43a1-82ee-d22cbe145cea	160
195	a9d3867e-51d1-43a1-82ee-d22cbe145cea	240
196	a9d3867e-51d1-43a1-82ee-d22cbe145cea	241
197	a9d3867e-51d1-43a1-82ee-d22cbe145cea	242
198	a9d3867e-51d1-43a1-82ee-d22cbe145cea	243
199	a9d3867e-51d1-43a1-82ee-d22cbe145cea	244
263	674c03b0-ba50-4e84-b08f-25361264cdbe	78
264	674c03b0-ba50-4e84-b08f-25361264cdbe	79
265	674c03b0-ba50-4e84-b08f-25361264cdbe	80
266	674c03b0-ba50-4e84-b08f-25361264cdbe	91
267	674c03b0-ba50-4e84-b08f-25361264cdbe	92
268	674c03b0-ba50-4e84-b08f-25361264cdbe	93
269	674c03b0-ba50-4e84-b08f-25361264cdbe	94
270	674c03b0-ba50-4e84-b08f-25361264cdbe	95
271	674c03b0-ba50-4e84-b08f-25361264cdbe	235
272	674c03b0-ba50-4e84-b08f-25361264cdbe	236
273	674c03b0-ba50-4e84-b08f-25361264cdbe	237
274	674c03b0-ba50-4e84-b08f-25361264cdbe	238
275	674c03b0-ba50-4e84-b08f-25361264cdbe	239
276	674c03b0-ba50-4e84-b08f-25361264cdbe	250
277	674c03b0-ba50-4e84-b08f-25361264cdbe	251
278	674c03b0-ba50-4e84-b08f-25361264cdbe	252
279	674c03b0-ba50-4e84-b08f-25361264cdbe	253
280	674c03b0-ba50-4e84-b08f-25361264cdbe	254
281	674c03b0-ba50-4e84-b08f-25361264cdbe	46
282	674c03b0-ba50-4e84-b08f-25361264cdbe	47
283	674c03b0-ba50-4e84-b08f-25361264cdbe	48
284	674c03b0-ba50-4e84-b08f-25361264cdbe	49
285	674c03b0-ba50-4e84-b08f-25361264cdbe	50
286	674c03b0-ba50-4e84-b08f-25361264cdbe	86
287	674c03b0-ba50-4e84-b08f-25361264cdbe	87
288	674c03b0-ba50-4e84-b08f-25361264cdbe	88
289	674c03b0-ba50-4e84-b08f-25361264cdbe	89
290	674c03b0-ba50-4e84-b08f-25361264cdbe	90
291	674c03b0-ba50-4e84-b08f-25361264cdbe	21
292	674c03b0-ba50-4e84-b08f-25361264cdbe	22
293	674c03b0-ba50-4e84-b08f-25361264cdbe	23
294	674c03b0-ba50-4e84-b08f-25361264cdbe	24
295	674c03b0-ba50-4e84-b08f-25361264cdbe	25
296	674c03b0-ba50-4e84-b08f-25361264cdbe	26
297	674c03b0-ba50-4e84-b08f-25361264cdbe	27
298	674c03b0-ba50-4e84-b08f-25361264cdbe	28
299	674c03b0-ba50-4e84-b08f-25361264cdbe	29
300	674c03b0-ba50-4e84-b08f-25361264cdbe	30
301	674c03b0-ba50-4e84-b08f-25361264cdbe	51
302	674c03b0-ba50-4e84-b08f-25361264cdbe	52
303	674c03b0-ba50-4e84-b08f-25361264cdbe	53
304	674c03b0-ba50-4e84-b08f-25361264cdbe	54
305	674c03b0-ba50-4e84-b08f-25361264cdbe	55
306	674c03b0-ba50-4e84-b08f-25361264cdbe	56
307	674c03b0-ba50-4e84-b08f-25361264cdbe	57
308	674c03b0-ba50-4e84-b08f-25361264cdbe	58
309	674c03b0-ba50-4e84-b08f-25361264cdbe	59
310	674c03b0-ba50-4e84-b08f-25361264cdbe	60
311	674c03b0-ba50-4e84-b08f-25361264cdbe	156
312	674c03b0-ba50-4e84-b08f-25361264cdbe	157
313	674c03b0-ba50-4e84-b08f-25361264cdbe	158
314	674c03b0-ba50-4e84-b08f-25361264cdbe	159
315	674c03b0-ba50-4e84-b08f-25361264cdbe	160
316	674c03b0-ba50-4e84-b08f-25361264cdbe	240
317	674c03b0-ba50-4e84-b08f-25361264cdbe	241
318	674c03b0-ba50-4e84-b08f-25361264cdbe	242
319	674c03b0-ba50-4e84-b08f-25361264cdbe	243
320	674c03b0-ba50-4e84-b08f-25361264cdbe	244
321	674c03b0-ba50-4e84-b08f-25361264cdbe	66
322	674c03b0-ba50-4e84-b08f-25361264cdbe	67
323	674c03b0-ba50-4e84-b08f-25361264cdbe	68
324	674c03b0-ba50-4e84-b08f-25361264cdbe	69
325	674c03b0-ba50-4e84-b08f-25361264cdbe	70
326	674c03b0-ba50-4e84-b08f-25361264cdbe	71
327	674c03b0-ba50-4e84-b08f-25361264cdbe	72
328	674c03b0-ba50-4e84-b08f-25361264cdbe	73
329	674c03b0-ba50-4e84-b08f-25361264cdbe	74
330	674c03b0-ba50-4e84-b08f-25361264cdbe	75
\.


--
-- Data for Name: staff_salary_allowance; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.staff_salary_allowance (id, auto_id, date_added, date_updated, deleted_reason, date, is_deleted, description, allowance_type, days, hours, rate_per_day, rate_per_hour, is_paid, allowance, creator_id, staff_id, updater_id) FROM stdin;
37829838-4440-4cd2-aeb8-c757802aa1e8	1	2024-10-25 15:35:41.541875+00	2024-10-25 15:35:41.541896+00	s	2024-10-25	t	\N	working on holiday	1.00	0.00	100.00	0.00	f	100.00	1	bc5bb326-1199-42e7-abb0-381331f3bd47	1
e0372120-6060-40c1-a428-9f809e572b7e	2	2025-07-09 12:18:04.209717+00	2025-07-09 12:18:04.209744+00	\N	2025-07-09	f	\N	over time	0.00	2.00	0.00	100.00	f	200.00	1	bc5bb326-1199-42e7-abb0-381331f3bd47	1
0c75a7e5-ef3c-4674-a183-b3dba157c5e8	3	2025-07-16 10:01:36.944764+00	2025-07-16 10:01:36.944808+00	\N	2025-07-16	f	\N	over time	0.00	50.00	0.00	10.00	f	500.00	1	bc5bb326-1199-42e7-abb0-381331f3bd47	1
\.


--
-- Data for Name: stock_transfer; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.stock_transfer (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, date, creator_id, to_warehouse_id, updater_id, warehouse_id) FROM stdin;
\.


--
-- Data for Name: stock_transfer_items; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.stock_transfer_items (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, retail_price, whole_sale_price, cost, mrp, quantity, manufacturing_date, expire_date, batch_id, creator_id, product_variant_id, stock_transfer_id, updater_id) FROM stdin;
\.


--
-- Data for Name: stock_update; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.stock_update (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, date, description, update_type, creator_id, updater_id, warehouse_id) FROM stdin;
\.


--
-- Data for Name: stock_update_item; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.stock_update_item (id, add_new_batch, batch_number, expire_date, manufacturing_date, stock, mrp, cost, taxable_amount, retail_price, whole_sale_price, is_deleted, batch_id, product_variant_id, stockupdate_id) FROM stdin;
\.


--
-- Data for Name: students_registration_profile; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.students_registration_profile (id, auto_id, phone, date_added, is_deleted, user_id) FROM stdin;
\.


--
-- Data for Name: suppliers_supplier; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.suppliers_supplier (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, name, address, phone, email, bank_name, bank_account_name, branch, ifsc_code, account_num, opening_type, opening_balance, credit_limit, debit_limit, current_balance, state, district, country, gst_number, creator_id, updater_id, user_id) FROM stdin;
6631610e-1744-4a2b-891e-8f125ffba1f5	1	2024-10-25 12:48:30.157689+00	2024-10-25 12:48:30.157714+00	f	\N	Arafa Traders	PALODE	9745212222	arafatraders2222@gmail.com	\N	\N	\N	\N	\N	debit	0.00	0.00	0.00	77375.00	Kerala	\N	India	\N	1	1	\N
3afce3f0-cef1-4993-8095-f6564a19871a	2	2025-12-16 15:52:19.417083+00	2025-12-16 15:52:19.417107+00	f	\N	Sasd	Rushidha Manzil	9745088002	arafamobiles111@gmail.com	\N	\N	\N	\N	\N	debit	1000.00	0.00	0.00	1000.00	Kerala	\N	India	\N	1	1	\N
\.


--
-- Data for Name: techpe_staff_record; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.techpe_staff_record (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, leave_count, half_leave_count, salary, date, is_paid, is_partially_paid, paid_amount, payment_date, creator_id, staff_id, updater_id) FROM stdin;
f0bebec3-c179-4ebf-9b72-384d6131c809	1	2024-07-19 11:56:17.875929+00	2024-07-19 11:56:17.875953+00	f	\N	0.00	0.00	7000	2024-07-18 18:30:00+00	f	f	0.00	\N	1	a9d3867e-51d1-43a1-82ee-d22cbe145cea	1
865ba9d8-ef01-43ec-ade6-48eca66103b5	2	2024-10-25 15:35:41.549123+00	2024-10-25 15:35:41.549144+00	f	\N	0.00	0.00	0	2024-10-24 18:30:00+00	f	f	0.00	\N	1	bc5bb326-1199-42e7-abb0-381331f3bd47	1
fcfb0067-ee3e-486d-b1dd-3e4849a0c5b3	3	2025-07-09 12:18:04.222912+00	2025-07-09 12:18:04.222947+00	f	\N	0.00	0.00	700	2025-07-15 18:30:00+00	f	f	0.00	\N	1	bc5bb326-1199-42e7-abb0-381331f3bd47	1
\.


--
-- Data for Name: tickets; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.tickets (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, subject, description, status, priority, attachment, reject_reason, message, creator_id, customer_id, updater_id) FROM stdin;
\.


--
-- Data for Name: users_cartitem; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.users_cartitem (id, date_added, is_deleted, qty, customer_id, product_variant_id, warehouse_id) FROM stdin;
1180d255-c7e0-4e28-82f8-ddbcaf7ae7b4	2025-08-27 15:20:34.862905+00	f	1	760a809a-b409-44bf-83cb-79f76762cece	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
91ee5b3d-bf5a-443e-9987-75242f3c2f75	2024-10-29 06:13:10.496264+00	f	1	37f01573-c73c-4a29-8188-adff1d6b92de	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3	9e0cf2de-e2eb-4392-9188-951e2af1d3eb
\.


--
-- Data for Name: users_notification; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.users_notification (id, message, "time", is_read, is_visited, is_deleted, is_active, customer_id, order_id, subject_id, user_id, who_id) FROM stdin;
1	An order assigned to you, check it out .	2024-07-25 07:10:36.18268+00	t	f	f	t	338ef566-78a3-40cc-95e4-551ea5f8f46d	fb59dc79-6346-4131-a487-6facd520deb1	9	1	8
2	An order assigned to you, check it out .	2024-11-01 14:26:04.862328+00	t	f	f	t	760a809a-b409-44bf-83cb-79f76762cece	a9865e0d-efd2-4cda-b506-38745c4b964f	9	1	8
3	An order assigned to you, check it out .	2024-11-01 14:40:26.642846+00	f	f	f	t	760a809a-b409-44bf-83cb-79f76762cece	857bb7ad-fdaa-4dfc-b267-d7f152caad6a	9	1	8
4	An order assigned to you, check it out .	2025-03-17 13:54:01.217494+00	f	f	f	t	c6488465-a403-4642-92ce-210e51956062	7aad7a57-fa87-43da-9169-705f79c3761d	9	1	8
5	An order assigned to you, check it out .	2025-03-17 14:00:08.945009+00	f	f	f	t	760a809a-b409-44bf-83cb-79f76762cece	88d5515f-d134-463f-be88-b13947cb6b18	9	1	8
6	An order assigned to you, check it out .	2025-03-17 14:00:27.721552+00	f	f	f	t	760a809a-b409-44bf-83cb-79f76762cece	88d5515f-d134-463f-be88-b13947cb6b18	9	1	8
7	An order assigned to you, check it out .	2025-03-17 14:01:27.355348+00	f	f	f	t	760a809a-b409-44bf-83cb-79f76762cece	88d5515f-d134-463f-be88-b13947cb6b18	9	1	8
8	An order assigned to you, check it out .	2025-03-17 14:02:03.681764+00	f	f	f	t	760a809a-b409-44bf-83cb-79f76762cece	88d5515f-d134-463f-be88-b13947cb6b18	9	1	8
9	An order assigned to you, check it out .	2025-03-17 14:02:53.632444+00	f	f	f	t	760a809a-b409-44bf-83cb-79f76762cece	88d5515f-d134-463f-be88-b13947cb6b18	9	1	8
10	An order assigned to you, check it out .	2025-03-17 14:03:28.455492+00	f	f	f	t	760a809a-b409-44bf-83cb-79f76762cece	88d5515f-d134-463f-be88-b13947cb6b18	9	1	8
11	An order assigned to you, check it out .	2025-03-17 14:03:47.970415+00	f	f	f	t	760a809a-b409-44bf-83cb-79f76762cece	88d5515f-d134-463f-be88-b13947cb6b18	9	1	8
12	An order assigned to you, check it out .	2025-03-17 14:13:47.062542+00	f	f	f	t	760a809a-b409-44bf-83cb-79f76762cece	114ae1a5-b78a-43bc-a0f9-e96344ae3de7	9	1	8
13	An order assigned to you, check it out .	2025-04-02 11:21:19.511283+00	f	f	f	t	760a809a-b409-44bf-83cb-79f76762cece	19f84703-0c42-401a-af84-0f433b9e654a	9	1	8
14	An order assigned to you, check it out .	2025-04-02 12:42:21.32426+00	f	f	f	t	760a809a-b409-44bf-83cb-79f76762cece	e18a0c3d-2b62-4bdb-b12f-8ab0c16c7a7d	9	1	8
15	An order assigned to you, check it out .	2025-07-09 11:32:09.323917+00	f	f	f	t	760a809a-b409-44bf-83cb-79f76762cece	e18a0c3d-2b62-4bdb-b12f-8ab0c16c7a7d	9	1	8
16	An order assigned to you, check it out .	2025-07-09 17:11:12.161375+00	f	f	f	t	760a809a-b409-44bf-83cb-79f76762cece	a8efc206-054e-4673-a530-2058b017e3f4	9	1	8
17	An order assigned to you, check it out .	2025-07-09 17:23:54.115528+00	f	f	f	t	760a809a-b409-44bf-83cb-79f76762cece	86271658-4301-4a08-9d00-32e2d535467a	9	1	8
18	An order assigned to you, check it out .	2025-07-12 14:33:31.516891+00	f	f	f	t	760a809a-b409-44bf-83cb-79f76762cece	86271658-4301-4a08-9d00-32e2d535467a	9	1	8
19	An order assigned to you, check it out .	2025-08-23 12:30:18.533801+00	f	f	f	t	760a809a-b409-44bf-83cb-79f76762cece	9f9474eb-3469-445a-9fd5-e5204c0d5779	9	1	8
20	An order assigned to you, check it out .	2025-08-23 12:41:15.721162+00	f	f	f	t	760a809a-b409-44bf-83cb-79f76762cece	f2bee48f-c828-40be-9440-dc323d0ebec6	9	1	8
\.


--
-- Data for Name: users_notification_subject; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.users_notification_subject (id, code, name) FROM stdin;
1	order_out_for_delivery	Order out for delivery
2	order_shipped	Order Shipped
3	order_delivered	Order Delivered
4	order_cancelled	Order Cancelled
5	order_placed	You have an new order
6	ticket_status_updated	Ticket status updated
7	batch_expiry_date_reached	Batch expired
8	product_low_stock	Low stock
9	you_have_a_new_order	You have a New Order
\.


--
-- Data for Name: users_user_login; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.users_user_login (id, auto_id, date_added, ip, otp, status, failed_attempts, is_activated, user_id) FROM stdin;
\.


--
-- Data for Name: users_wishlistitem; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.users_wishlistitem (id, date_added, is_deleted, customer_id, product_variant_id) FROM stdin;
ac87d0cb-420c-448f-a8bf-ac3a8a2c5adb	2024-07-28 05:54:02.60394+00	f	228854d7-8247-40b9-9ed1-9e46486133ca	6826bd65-4fd1-4aa8-9aad-814048862f9f
cdfc0d27-8690-4551-81bb-611fcd1cb0b7	2024-07-28 05:54:14.93593+00	f	228854d7-8247-40b9-9ed1-9e46486133ca	2794b11d-405d-4eeb-ba63-81b435931357
a5e9da59-0350-41d5-862a-fe6bd2174be3	2024-07-28 05:54:24.111717+00	f	228854d7-8247-40b9-9ed1-9e46486133ca	80721a40-6322-40f3-be9a-d61ed9e6cf72
309df1dd-19f6-4253-910d-3da72aa55d73	2024-07-28 05:54:35.90287+00	f	228854d7-8247-40b9-9ed1-9e46486133ca	21635aff-43d8-427f-a860-63ee2c222807
addedb55-a7bb-4e68-ac40-78aecf8bc395	2024-07-28 05:55:21.656218+00	f	228854d7-8247-40b9-9ed1-9e46486133ca	7df72a13-0cd4-4417-bb5b-842ab39fd10c
56f7da37-8524-4948-bfcf-ea27cd1559e0	2024-10-06 09:10:28.662008+00	f	c6488465-a403-4642-92ce-210e51956062	7df72a13-0cd4-4417-bb5b-842ab39fd10c
8985b7a3-ee8c-411a-8d08-f2af54229cb7	2024-10-06 09:10:40.270448+00	f	c6488465-a403-4642-92ce-210e51956062	fb3ae593-aa0f-4650-82f4-2024299ac010
f4c2f6d7-6644-4651-8a0c-06394bb10c74	2024-10-06 09:10:47.79971+00	f	c6488465-a403-4642-92ce-210e51956062	bb827cf8-daa6-402c-a7cb-e8a8936c04ac
521bf540-226e-4c8a-bff1-cba02024a6c6	2024-10-24 08:48:15.785279+00	f	37f01573-c73c-4a29-8188-adff1d6b92de	fb3ae593-aa0f-4650-82f4-2024299ac010
6796ff7c-5d21-419c-8774-09c58c0bc60b	2024-10-29 06:11:21.108015+00	f	37f01573-c73c-4a29-8188-adff1d6b92de	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3
b5361615-260e-495f-8834-a6ac9f7d62eb	2025-08-23 12:10:32.179145+00	f	760a809a-b409-44bf-83cb-79f76762cece	4e290f81-d412-4025-acab-7b690f187583
\.


--
-- Data for Name: vendors_commission; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.vendors_commission (id, date, commission_amount, is_paid, order_item_id, vendor_id) FROM stdin;
\.


--
-- Data for Name: vendors_vendor; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.vendors_vendor (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, name, vendor_type, type_arabic, arabic_name, address, phone, email, bank_name, bank_account_name, branch, ifsc_code, account_num, opening_type, opening_balance, country, current_balance, image, place, commission_type, commission_percentage, location_arabic, password, delivery_availability, creator_id, location_id, updater_id, user_id, zone_id) FROM stdin;
a743d8c3-f2b0-455a-bc98-85be2a4aae67	2	2024-11-09 15:02:18.189371+00	2024-11-09 15:02:18.189404+00	f	\N	Abc	DIGITAL	\N	\N	AAA	9995162122	arafamobiles111@gmail.com	\N	\N	\N	\N	\N	debit	0.00	India	0.00	media/th_1.jpeg	PALODE	monthly	0.00	\N	123456	all_india	1	6650c764-6c50-4d87-8c81-8c731c6107d3	1	15	4859
5f853b0d-ad9b-4420-9c3d-1039e329b4fc	1	2024-07-18 09:40:46.425271+00	2024-10-24 10:36:13.497402+00	f	\N	Arafa Mobiles	Electronics	\N	\N	COLLEGE ROAD PALODE	7356564156	arafamobiles111@gmail.com	\N	Arafa mobiles	\N	SBIN0070523	67357552696	debit	0.00	India	5000.00	media/NEXSME_BAZAR.jpg	PALODE	monthly	2.00	\N	Arafa@123	all_india	1	6b33ea6e-3c2a-4d05-a684-be91d35b650d	1	4	4950
bdc3a234-5d4b-44a5-9c01-ca120fee547c	3	2025-05-06 11:20:03.683759+00	2025-05-06 11:20:03.683806+00	f	\N	Arafa Vegetables	Grocery	\N	\N	College Road Palode	7994950698	arafavegitables@gmail.com	\N	\N	\N	\N	\N	debit	0.00	India	0.00	media/arafa_vegetables1.jpg	Plode	monthly	0.00	\N	7994950698	all_india	1	6585478f-d17d-4dbf-9229-86e3d766cb36	1	17	4859
\.


--
-- Data for Name: vendors_vendor_deliverable_location; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.vendors_vendor_deliverable_location (id, vendor_id, zone_id) FROM stdin;
43	a743d8c3-f2b0-455a-bc98-85be2a4aae67	4859
44	a743d8c3-f2b0-455a-bc98-85be2a4aae67	4885
45	a743d8c3-f2b0-455a-bc98-85be2a4aae67	4886
46	a743d8c3-f2b0-455a-bc98-85be2a4aae67	4946
47	a743d8c3-f2b0-455a-bc98-85be2a4aae67	4950
48	a743d8c3-f2b0-455a-bc98-85be2a4aae67	4951
49	a743d8c3-f2b0-455a-bc98-85be2a4aae67	4956
50	a743d8c3-f2b0-455a-bc98-85be2a4aae67	5069
59	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4656
60	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4657
61	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4658
62	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4659
63	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4660
64	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4661
65	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4662
66	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4663
67	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4664
68	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4665
69	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4666
70	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4667
71	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4668
72	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4669
73	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4670
74	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4671
75	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4672
76	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4673
77	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4674
78	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4675
79	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4676
80	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4677
81	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4678
82	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4679
83	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4680
84	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4681
85	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4682
86	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4683
87	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4684
88	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4685
89	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4686
90	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4687
91	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4688
92	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4689
93	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4690
94	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4691
95	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4692
96	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4693
97	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4694
98	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4695
99	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4696
100	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4697
101	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4698
102	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4699
103	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4700
104	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4701
105	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4702
106	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4703
107	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4704
108	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4705
109	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4706
110	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4707
111	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4708
112	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4709
113	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4710
114	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4711
115	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4712
116	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4713
117	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4714
118	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4715
119	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4716
120	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4717
121	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4718
122	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4719
123	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4720
124	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4721
125	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4722
126	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4723
127	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4724
128	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4725
129	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4726
130	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4727
131	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4728
132	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4729
133	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4730
134	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4731
135	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4732
136	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4733
137	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4734
138	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4735
139	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4736
140	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4737
141	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4738
142	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4739
143	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4740
144	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4741
145	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4742
146	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4743
147	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4744
148	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4745
149	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4746
150	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4747
151	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4748
152	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4749
153	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4750
154	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4751
155	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4752
156	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4753
157	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4754
158	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4755
159	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4859
160	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4885
161	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4886
162	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4946
163	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4950
164	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4951
165	bdc3a234-5d4b-44a5-9c01-ca120fee547c	4956
166	bdc3a234-5d4b-44a5-9c01-ca120fee547c	5069
\.


--
-- Data for Name: warehouse; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.warehouse (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, name, phone, address, country, creator_id, location_id, manager_id, updater_id, zone_id) FROM stdin;
9e0cf2de-e2eb-4392-9188-951e2af1d3eb	1	2024-07-17 12:46:12.302788+00	2024-07-17 12:46:12.302828+00	f	\N	ARAFA PLD	9745212222	College Road Palode	India	1	e5a98e43-4b32-400c-b699-9c81c1d57482	\N	1	4950
6568014e-bb8e-4058-8abc-20b985c67d29	2	2024-10-25 09:45:44.620536+00	2024-10-25 09:45:44.620563+00	f	\N	ARAFA KALLARA	8086752122	KARET ROAD KALLARA	India	1	fbc93a87-2c11-41fb-adc7-e4bb2256c96a	\N	1	4705
e9c91e4d-271c-4063-90d0-87038135e85e	3	2025-07-17 15:36:19.12428+00	2025-07-17 15:36:19.124294+00	f	\N	Attingal Branch	1234567890	ATINGAL	India	1	c7466895-450e-4beb-a354-d24ffd5a9c3c	bc5bb326-1199-42e7-abb0-381331f3bd47	1	4673
\.


--
-- Data for Name: warehouse_deliverable_location; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.warehouse_deliverable_location (id, warehouse_id, zone_id) FROM stdin;
1	9e0cf2de-e2eb-4392-9188-951e2af1d3eb	4859
2	9e0cf2de-e2eb-4392-9188-951e2af1d3eb	4885
3	9e0cf2de-e2eb-4392-9188-951e2af1d3eb	4886
4	9e0cf2de-e2eb-4392-9188-951e2af1d3eb	4946
5	9e0cf2de-e2eb-4392-9188-951e2af1d3eb	4950
6	9e0cf2de-e2eb-4392-9188-951e2af1d3eb	4951
7	9e0cf2de-e2eb-4392-9188-951e2af1d3eb	4956
8	9e0cf2de-e2eb-4392-9188-951e2af1d3eb	5069
9	9e0cf2de-e2eb-4392-9188-951e2af1d3eb	4860
10	9e0cf2de-e2eb-4392-9188-951e2af1d3eb	4907
11	9e0cf2de-e2eb-4392-9188-951e2af1d3eb	4927
12	9e0cf2de-e2eb-4392-9188-951e2af1d3eb	4952
13	9e0cf2de-e2eb-4392-9188-951e2af1d3eb	4986
14	9e0cf2de-e2eb-4392-9188-951e2af1d3eb	5030
15	9e0cf2de-e2eb-4392-9188-951e2af1d3eb	5032
16	6568014e-bb8e-4058-8abc-20b985c67d29	4705
17	6568014e-bb8e-4058-8abc-20b985c67d29	4709
18	6568014e-bb8e-4058-8abc-20b985c67d29	4711
19	6568014e-bb8e-4058-8abc-20b985c67d29	4772
20	6568014e-bb8e-4058-8abc-20b985c67d29	4840
21	6568014e-bb8e-4058-8abc-20b985c67d29	4719
22	6568014e-bb8e-4058-8abc-20b985c67d29	4805
23	6568014e-bb8e-4058-8abc-20b985c67d29	4806
24	e9c91e4d-271c-4063-90d0-87038135e85e	1
25	e9c91e4d-271c-4063-90d0-87038135e85e	2
26	e9c91e4d-271c-4063-90d0-87038135e85e	3
27	e9c91e4d-271c-4063-90d0-87038135e85e	4
28	e9c91e4d-271c-4063-90d0-87038135e85e	5
29	e9c91e4d-271c-4063-90d0-87038135e85e	6
30	e9c91e4d-271c-4063-90d0-87038135e85e	7
31	e9c91e4d-271c-4063-90d0-87038135e85e	8
32	e9c91e4d-271c-4063-90d0-87038135e85e	9
33	e9c91e4d-271c-4063-90d0-87038135e85e	10
34	e9c91e4d-271c-4063-90d0-87038135e85e	11
35	e9c91e4d-271c-4063-90d0-87038135e85e	12
36	e9c91e4d-271c-4063-90d0-87038135e85e	13
37	e9c91e4d-271c-4063-90d0-87038135e85e	14
38	e9c91e4d-271c-4063-90d0-87038135e85e	15
39	e9c91e4d-271c-4063-90d0-87038135e85e	16
40	e9c91e4d-271c-4063-90d0-87038135e85e	17
41	e9c91e4d-271c-4063-90d0-87038135e85e	18
42	e9c91e4d-271c-4063-90d0-87038135e85e	19
43	e9c91e4d-271c-4063-90d0-87038135e85e	20
44	e9c91e4d-271c-4063-90d0-87038135e85e	21
45	e9c91e4d-271c-4063-90d0-87038135e85e	22
46	e9c91e4d-271c-4063-90d0-87038135e85e	23
47	e9c91e4d-271c-4063-90d0-87038135e85e	24
48	e9c91e4d-271c-4063-90d0-87038135e85e	25
49	e9c91e4d-271c-4063-90d0-87038135e85e	26
50	e9c91e4d-271c-4063-90d0-87038135e85e	27
51	e9c91e4d-271c-4063-90d0-87038135e85e	28
52	e9c91e4d-271c-4063-90d0-87038135e85e	29
53	e9c91e4d-271c-4063-90d0-87038135e85e	30
54	e9c91e4d-271c-4063-90d0-87038135e85e	31
55	e9c91e4d-271c-4063-90d0-87038135e85e	32
56	e9c91e4d-271c-4063-90d0-87038135e85e	33
57	e9c91e4d-271c-4063-90d0-87038135e85e	34
58	e9c91e4d-271c-4063-90d0-87038135e85e	35
59	e9c91e4d-271c-4063-90d0-87038135e85e	36
60	e9c91e4d-271c-4063-90d0-87038135e85e	37
61	e9c91e4d-271c-4063-90d0-87038135e85e	38
62	e9c91e4d-271c-4063-90d0-87038135e85e	39
63	e9c91e4d-271c-4063-90d0-87038135e85e	40
64	e9c91e4d-271c-4063-90d0-87038135e85e	41
65	e9c91e4d-271c-4063-90d0-87038135e85e	42
66	e9c91e4d-271c-4063-90d0-87038135e85e	43
67	e9c91e4d-271c-4063-90d0-87038135e85e	44
68	e9c91e4d-271c-4063-90d0-87038135e85e	45
69	e9c91e4d-271c-4063-90d0-87038135e85e	46
70	e9c91e4d-271c-4063-90d0-87038135e85e	47
71	e9c91e4d-271c-4063-90d0-87038135e85e	48
72	e9c91e4d-271c-4063-90d0-87038135e85e	49
73	e9c91e4d-271c-4063-90d0-87038135e85e	50
74	e9c91e4d-271c-4063-90d0-87038135e85e	51
75	e9c91e4d-271c-4063-90d0-87038135e85e	52
76	e9c91e4d-271c-4063-90d0-87038135e85e	53
77	e9c91e4d-271c-4063-90d0-87038135e85e	54
78	e9c91e4d-271c-4063-90d0-87038135e85e	55
79	e9c91e4d-271c-4063-90d0-87038135e85e	56
80	e9c91e4d-271c-4063-90d0-87038135e85e	57
81	e9c91e4d-271c-4063-90d0-87038135e85e	58
82	e9c91e4d-271c-4063-90d0-87038135e85e	59
83	e9c91e4d-271c-4063-90d0-87038135e85e	60
84	e9c91e4d-271c-4063-90d0-87038135e85e	61
85	e9c91e4d-271c-4063-90d0-87038135e85e	62
86	e9c91e4d-271c-4063-90d0-87038135e85e	63
87	e9c91e4d-271c-4063-90d0-87038135e85e	64
88	e9c91e4d-271c-4063-90d0-87038135e85e	65
89	e9c91e4d-271c-4063-90d0-87038135e85e	66
90	e9c91e4d-271c-4063-90d0-87038135e85e	67
91	e9c91e4d-271c-4063-90d0-87038135e85e	68
92	e9c91e4d-271c-4063-90d0-87038135e85e	69
93	e9c91e4d-271c-4063-90d0-87038135e85e	70
94	e9c91e4d-271c-4063-90d0-87038135e85e	71
95	e9c91e4d-271c-4063-90d0-87038135e85e	72
96	e9c91e4d-271c-4063-90d0-87038135e85e	73
97	e9c91e4d-271c-4063-90d0-87038135e85e	74
98	e9c91e4d-271c-4063-90d0-87038135e85e	75
99	e9c91e4d-271c-4063-90d0-87038135e85e	76
100	e9c91e4d-271c-4063-90d0-87038135e85e	77
101	e9c91e4d-271c-4063-90d0-87038135e85e	78
102	e9c91e4d-271c-4063-90d0-87038135e85e	79
103	e9c91e4d-271c-4063-90d0-87038135e85e	80
104	e9c91e4d-271c-4063-90d0-87038135e85e	81
105	e9c91e4d-271c-4063-90d0-87038135e85e	82
106	e9c91e4d-271c-4063-90d0-87038135e85e	83
107	e9c91e4d-271c-4063-90d0-87038135e85e	84
108	e9c91e4d-271c-4063-90d0-87038135e85e	85
109	e9c91e4d-271c-4063-90d0-87038135e85e	86
110	e9c91e4d-271c-4063-90d0-87038135e85e	87
111	e9c91e4d-271c-4063-90d0-87038135e85e	88
112	e9c91e4d-271c-4063-90d0-87038135e85e	89
113	e9c91e4d-271c-4063-90d0-87038135e85e	90
114	e9c91e4d-271c-4063-90d0-87038135e85e	91
115	e9c91e4d-271c-4063-90d0-87038135e85e	92
116	e9c91e4d-271c-4063-90d0-87038135e85e	93
117	e9c91e4d-271c-4063-90d0-87038135e85e	94
118	e9c91e4d-271c-4063-90d0-87038135e85e	95
119	e9c91e4d-271c-4063-90d0-87038135e85e	96
120	e9c91e4d-271c-4063-90d0-87038135e85e	97
121	e9c91e4d-271c-4063-90d0-87038135e85e	98
122	e9c91e4d-271c-4063-90d0-87038135e85e	99
123	e9c91e4d-271c-4063-90d0-87038135e85e	100
\.


--
-- Data for Name: warehouse_no_express_delivery; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.warehouse_no_express_delivery (id, warehouse_id, zone_id) FROM stdin;
\.


--
-- Data for Name: web_FeauturedCategory; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public."web_FeauturedCategory" (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, category_id, creator_id, updater_id) FROM stdin;
\.


--
-- Data for Name: web_TrendingCategory; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public."web_TrendingCategory" (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, category_id, creator_id, updater_id) FROM stdin;
\.


--
-- Data for Name: web_productreturn; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.web_productreturn (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, return_id, reason_for_return, return_type, return_specification, status, payment_status, agent_status, rejected_reason, agent_rejected_reason, amount, is_same_product, is_damaged_product, is_same_quantity, damaged_reason, serial_status, extra_notes, customer_name, customer_phone, customer_street, customer_landmark, customer_latitude, customer_longitude, reached_image, is_handover_required, creator_id, customer_account_id, customer_address_id, delivery_boy_id, order_id, order_item_id, updater_id) FROM stdin;
\.


--
-- Data for Name: web_productreview; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.web_productreview (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, rating, review, creator_id, product_variant_id, updater_id) FROM stdin;
bef3bb45-8c19-4e40-930c-2e94f2b9d692	1	2025-08-23 12:03:47.760964+00	2025-08-23 12:03:47.760988+00	f	\N	4		5	bf2255ec-d2bd-4673-ad60-dd0578f9a6d3	5
\.


--
-- Data for Name: web_sociallinks; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.web_sociallinks (id, facebook_link, instagram_link, twitter_link, whatsapp_link) FROM stdin;
\.


--
-- Data for Name: web_spotlightbanner; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.web_spotlightbanner (id, auto_id, date_added, date_updated, is_deleted, deleted_reason, offer_type, banner_type, image, brand_id, category_id, creator_id, product_variant_id, updater_id) FROM stdin;
0c51dd50-734b-4659-9e9b-ec36e1313fcb	5	2024-07-20 08:14:15.420263+00	2024-07-20 08:14:15.420294+00	t	s	category	secondary	media/Drip-Solemate-780x470_jgg2VHj.jpg	\N	0242d2fe-cfb9-4db7-971a-3b8b11b4776a	1	\N	1
9d13bd17-a77d-488c-ac1a-f520f8eb83be	6	2024-07-20 08:15:09.956055+00	2024-07-20 08:15:09.956089+00	t	s	category	secondary	media/Drip-Solemate-780x470_wAhyhm4.jpg	\N	0242d2fe-cfb9-4db7-971a-3b8b11b4776a	1	\N	1
4e0eb426-6ee6-4560-9788-02ec32155efb	4	2024-07-18 16:31:38.087829+00	2024-07-18 16:31:38.087872+00	t	s	category	tertiary	media/th_GnGN8Er.jpeg	\N	33a7e888-3339-4716-a40e-b8050c178f2a	1	\N	1
d16b5efe-b6ea-41c6-9f0b-9febfb7a8ec3	1	2024-07-17 13:16:42.07568+00	2024-07-17 13:16:42.07571+00	t	s	category	primary	media/AdobeStock_666044026_Preview_5NIxJ6L.png	\N	638122ea-f238-4bf6-9e21-28192de9f95f	1	\N	1
0f9d26d4-570b-4fcb-8497-7e25230359e3	3	2024-07-18 16:29:33.986466+00	2024-07-18 16:29:33.986489+00	t	s	category	primary	media/fresh-fruits-vegetables-2419_bAAC1m4.jpg	\N	0ee3935a-02bb-4984-9e69-28f1d8748218	1	\N	1
27c7e773-8ef6-4007-84da-f78f98af2a12	2	2024-07-18 16:27:59.990528+00	2024-07-18 16:27:59.990557+00	t	s	category	secondary	media/fresh-fruits-vegetables-2419_crKG89X.jpg	\N	0ee3935a-02bb-4984-9e69-28f1d8748218	1	\N	1
caa4f107-edb2-4fcf-9617-7927c9f417e8	7	2024-10-24 10:43:18.075262+00	2024-10-24 10:47:56.710958+00	f	\N	product	primary	media/skin.webp	\N	\N	1	\N	1
7c068b47-2411-410c-816c-1d32d7345ad8	8	2024-10-24 10:49:13.138911+00	2024-10-24 10:49:13.138937+00	f	\N	category	primary	media/Whole-Chicken-Raw-scaled_eK1MJXd.jpeg	\N	\N	1	\N	1
0b220eef-bc44-445d-b168-360571fc4f0f	9	2024-10-24 10:49:13.217788+00	2024-10-24 10:49:13.217813+00	f	\N	category	primary	media/Whole-Chicken-Raw-scaled_lq0TmQ1.jpeg	\N	\N	1	\N	1
439c37d1-83a7-4277-9806-f944668703bf	10	2024-10-24 10:54:25.358826+00	2024-10-24 10:54:25.358849+00	f	\N	product	primary	media/chicken-leg-500x500.webp	\N	\N	1	\N	1
c25c33d1-58d7-4144-b6ac-3413df31f55a	11	2024-10-24 10:56:33.616786+00	2025-08-27 12:59:53.68808+00	f	\N	category	primary	media/marketing_poster_1.png	\N	01156b02-e1f3-42a6-bac2-2004ea6d75ac	1	\N	1
14db437d-c43d-4d97-a0ed-e36337486d0e	12	2025-08-27 13:02:13.000325+00	2025-08-27 13:02:13.000357+00	f	\N	product	secondary	media/photorealistic-view-rooster-with-beak-feathers.jpg	\N	\N	1	9a7c44b8-79e7-476f-8fb0-6d10fec63f75	1
b1c5c3b0-bc4b-4f54-8911-b883b25cb319	13	2025-08-27 13:03:53.282445+00	2025-08-27 13:03:53.282472+00	f	\N	category	tertiary	media/marketing_poster.png	\N	992acd14-4d01-4fc5-b154-cf839d21c6e9	1	\N	1
eb510e0f-8262-4fe6-b12e-852e273f55d2	14	2025-08-27 14:33:40.486109+00	2025-08-27 14:33:40.486139+00	f	\N	category	primary	media/whole-chicken-sliced-carrots-plate-burlap-napkin-blue-surface.jpg	\N	01156b02-e1f3-42a6-bac2-2004ea6d75ac	1	\N	1
\.


--
-- Data for Name: zone; Type: TABLE DATA; Schema: public; Owner: nexsme_live
--

COPY public.zone (id, name, municipality, district, state, taluk, latitude, longitude, pincode) FROM stdin;
1	Anakampoyil B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673603
2	Arakinar S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673028
3	Arambatta Kunnu B.O		Wayanad	KERALA	Vythiri	\N	\N	673575
4	Azhinjilam B.O		Malappuram	KERALA	Ernad	\N	\N	673632
5	Calicut City S.O		Kozhikode	KERALA	NA	\N	\N	673004
6	Calicut Civil Station H.O		Kozhikode	KERALA	Kozhikode	\N	\N	673020
7	Chennalode B.O		Wayanad	KERALA	Vythiri	\N	\N	673122
8	Chennamangallur B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673602
9	Choothupara B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673596
10	Chulur B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673601
11	Cottanad B.O		Wayanad	KERALA	Vythiri	\N	\N	673577
12	Eranhipalam S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673006
13	Guruvayurappan College S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673014
14	Kadalundi S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673302
15	Kambalakkad B.O		Wayanad	KERALA	Vythiti	\N	\N	673122
16	Karad Paramba B.O		Malappuram	KERALA	Ernad	\N	\N	673632
17	Kidanganad B.O		Wayanad	KERALA	Sulthan Batheri	\N	\N	673592
18	Kommeri B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673007
19	Kunnambetta B.O		Wayanad	KERALA	Vythiri	\N	\N	673123
20	Muthanga B.O		Wayanad	KERALA	Sulthan Batheri	\N	\N	673592
21	Nenmeni Kunnu B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673595
22	Parambil B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673012
23	Parappanpoyil B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673573
24	Parappil S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673001
25	Pariyaram - Wynad B.O		Wayanad	KERALA	Vythiri	\N	\N	673122
26	Paropadi B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673009
27	Perikallur B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673579
28	Pokkunnu B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673007
29	Poomulla B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673592
30	Poovattu Paramba B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673008
31	Puducode - Feroke B.O		Malappuram	KERALA	Eranad	\N	\N	673633
32	Pulpalli S.O		Wayanad	KERALA	Sulthan Bathery	\N	\N	673579
33	Puthiyangadi S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673021
34	Sulthan Bathery East S.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673592
35	Sulthan Bathery S.O		Wayanad	KERALA	Sulthan Bathery	\N	\N	673592
36	Thiruthiyad B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673004
37	Vavad B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673572
38	Vazhayur B.O		Malappuram	KERALA	Ernad	\N	\N	673633
39	Venappara B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673582
40	Alli B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673602
41	Amara Kuni B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673579
42	Athirattu Kunnu B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673596
43	Calicut Courts S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673032
44	Cheeral S.O		Wayanad	KERALA	Sulthan Batheri	\N	\N	673595
45	Chellangode B.O		Wayanad	KERALA	Vythiri	\N	\N	673581
46	Cheruvannur S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673655
47	Kakkatampoyil B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673604
48	Kakkoti S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673611
49	Kallai-kozhikode S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673003
50	Koombara Bazar B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673604
51	Kotancheri-tamaracheri S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673580
52	Kottathara B.O		Wayanad	KERALA	Vythiri	\N	\N	673122
53	Kudathai Bazar B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673573
54	Kuppadi B.O		Wayanad	KERALA	Sulthan Batheri	\N	\N	673592
55	Manasseri B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673602
56	Maniyangode B.O		Wayanad	KERALA	Vythiri	\N	\N	673122
57	Mayanad B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673008
58	Mookuthi Kunnu B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673595
59	Mundur -- Kozhikode B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673580
60	Muttancheri B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673585
61	Nellicode B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673016
62	Palakolli B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673579
63	Pallikunnu Wynad B.O		Wayanad	KERALA	Vythiri	\N	\N	673122
64	Puthiyara S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673004
65	Thachampoyil B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673573
66	Thariote North B.O		Wayanad	KERALA	Vythiri	\N	\N	673575
67	Thovari Mala B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673592
68	Tiruvannur B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673029
69	Vala Vayal B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673596
70	Vallarmala B.O		Wayanad	KERALA	Sulthan Bathery	\N	\N	673577
71	Valluvadi B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673592
72	Vrindavan Colony B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673017
73	Bhoodanam Colony B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673579
74	Chamal B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673573
75	Chedalath B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673592
76	Chettapalam B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673579
77	Feroke Pettah S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673631
78	Iim Kozhikode Campus S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673570
79	Kalpetta North S.O		Wayanad	KERALA	Vythiri	\N	\N	673122
80	Kannancheri B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673003
81	Kannoth B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673580
82	Kenichira S.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673596
83	Kumaranellur B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673602
84	Kunnamangalam S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673571
85	Maikavu B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673573
86	Morikkara B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673611
87	Narikkuni S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673585
88	Nenmeni B.O		Wayanad	KERALA	Sulthan Batheri	\N	\N	673592
89	Nit  Campus Po.Kozhikode S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673601
90	Nooramthode B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673586
91	Nulpuzha B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673592
92	Omasseri S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673582
93	Palath B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673611
94	Pannicode B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673602
95	Parannur B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673585
96	Pavandur B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673613
97	Perumpally B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673586
98	Pinangode B.O		Wayanad	KERALA	Vythiri	\N	\N	673122
99	Ponnamkayam B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673603
100	Punnakkal B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673603
101	Puzhamutti B.O		Wayanad	KERALA	Vythiri	\N	\N	673122
102	Theyyappara B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673580
103	Vengalam B.O		Kozhikode	KERALA	Quilandy	\N	\N	673303
104	West Hill Beach S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673005
105	West Hill S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673005
106	Calicut H.O		Kozhikode	KERALA	Kozhikode	\N	\N	673001
107	Calicut R.S. S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673001
108	Chaliyam S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673301
109	Chembu Kadavu B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673580
110	Cherukulathur B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673008
111	Cheruvadi B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673661
112	Chulliote B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673592
113	Elathur S.O (Kozhikode)		Kozhikode	KERALA	Kozhikode	\N	\N	673303
114	Elettil B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673572
115	Eranhikkal B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673303
116	Eravannur B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673585
117	Feroke S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673631
118	Kalanadi Kolli B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673579
119	Kalathu Vayal B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673593
120	Kalpetta H.O		Wayanad	KERALA	Vythiri	\N	\N	673121
121	Kaniyambetta B.O		Wayanad	KERALA	Vythiri	\N	\N	673122
122	Kanni Paramba B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673661
123	Karuvanthuruthy B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673631
124	Kilakkoth B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673572
125	Kodiyathur B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673602
126	Kolagapara B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673591
127	Koleri B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673596
128	Kudathai B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673573
129	Kythapoyil B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673586
130	Madakkimala B.O		Wayanad	KERALA	Vythiri	\N	\N	673122
131	Madavoor B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673585
132	Manha Kadavu B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673604
133	Mankavu S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673007
134	Mannur S.O (Kozhikode)		Kozhikode	KERALA	Kozhikode	\N	\N	673328
135	Mavoor S.O (Kozhikode)		Kozhikode	KERALA	Kozhikode	\N	\N	673661
136	Moolan Kavu B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673592
137	Mundakai B.O		Wayanad	KERALA	Vythiri	\N	\N	673577
138	Muttil B.O		Wayanad	KERALA	Vythiri	\N	\N	673122
139	Nanminda S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673613
140	Neeleswaram B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673582
141	Pakkom B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673579
142	Pambra B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673592
143	Pilasseri B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673571
144	Punnur - Cherupalam B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673585
145	Puthur Vayal B.O		Wayanad	KERALA	Vythiri	\N	\N	673577
146	Seetha Mount B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673579
147	Thariote B.O		Wayanad	KERALA	Vythiri	\N	\N	673575
148	Thekkumthara B.O		Wayanad	KERALA	Vythiri	\N	\N	673122
149	Trikai Petta B.O		Wayanad	KERALA	Sulthan Batheri	\N	\N	673577
150	Vatuvanchal S.O		Wayanad	KERALA	Sulthan Bathery	\N	\N	673581
151	Vazhayur East B.O		Malappuram	KERALA	Ernad	\N	\N	673633
152	Velliparamba B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673008
153	Beenachi B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673592
154	Bibleland B.O		Wayanad	KERALA	Vythiri	\N	\N	673575
155	Chalapuram S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673002
156	Chelannur S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673616
157	Chembra B.O		Wayanad	KERALA	Vythiri	\N	\N	673577
158	Chevarambalam B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673017
159	East Hill S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673005
160	Kakka Vayal B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673122
161	Kannan Kara B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673616
162	Karaparamba S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673010
163	Kayal B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673661
164	Kolathara S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673655
165	Koombara B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673604
166	Kottamparamba B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673008
167	Kotuvalli S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673572
168	Krishna Giri B.O		Wayanad	KERALA	Sulthan Batheri	\N	\N	673591
169	Kumbaleri B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673591
170	Kuppayakode B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673580
171	Kuthiravattom S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673016
172	Malayamma B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673601
173	Nambiar Kunnu B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673595
174	Payimbra B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673571
175	Pazhur B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673661
176	Perumukham B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673631
177	Peruvayal B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673008
178	Puduppadi S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673586
179	Pulluram Para B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673603
180	Punnasseri B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673585
181	Ripon Wynad B.O		Wayanad	KERALA	Vythiri	\N	\N	673577
182	Sreerama Krishna Mission B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673003
183	Thazha Munda B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673596
184	Thazhathur B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673595
185	Vakeri B.O		Wayanad	KERALA	Sulthan Batheri	\N	\N	673592
186	Valiyaparamba B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673572
187	Veliyambam B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673579
188	Vellalasseri B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673601
189	Vellayil S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673011
190	Achooranam B.O		Wayanad	KERALA	Vythiri	\N	\N	673575
191	Ambalavayal S.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673593
192	Beypore North B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673015
193	Calicut Beach S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673032
194	Calicut Medical College S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673008
195	Cheengeri B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673593
196	Cheeyambam B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673579
197	Cherooppa B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673661
198	Iringallur B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673014
199	Irivallur B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673616
200	Karanthur B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673571
201	Karinkutty B.O		Wayanad	KERALA	Vythiri	\N	\N	673122
202	Kattippara B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673573
203	Kavumannam B.O		Wayanad	KERALA	Vythiri	\N	\N	673122
204	Kizhakkumuri B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673611
205	Konott B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673571
206	Kottuli B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673016
207	Kunnamangalam Mini Industrial B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673571
208	Kuruvattur B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673611
209	Kuttikkattur B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673008
210	Mandad B.O		Wayanad	KERALA	Vythiri	\N	\N	673122
211	Mokkam S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673602
212	Muthappan Puzha B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673603
213	Naiketty B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673592
214	Nallara Chal B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673593
215	Nathamkuni B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673577
216	Nedungottur B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673010
217	Nellika Paramba B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673602
218	Pannikkottur B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673572
219	Poovaranthod B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673604
220	Pozhuthana S.O		Wayanad	KERALA	Vythiri	\N	\N	673575
221	Ramanattukara S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673633
222	Sasimala B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673579
223	Tiruvambadi S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673603
224	Velancode B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673580
225	Vengeri B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673010
226	Adivaram Pudupadi B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673586
227	Beypore S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673015
228	Calicut Collectorate S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673020
229	Edakkad - West Hill B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673005
230	Edakkara - Quilandy B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673616
231	Farook College S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673632
232	Govinda Puram B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673016
233	Kabanigiri B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673579
234	Kadalmat B.O		Wayanad	KERALA	Sulthan Batheri	\N	\N	673581
235	Kakkad Pudupadi B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673586
236	Kakkur B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673613
237	Kallurutty B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673582
238	Karachal B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673591
239	Karani B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673591
240	Karasseri B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673602
241	Kariyambadi B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673591
242	Karuvampoyil B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673572
243	Karuvasseri B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673010
244	Kuliramutty B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673604
245	Kundungal S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673003
246	Kutaranni S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673604
247	Madakunnu B.O		Wayanad	KERALA	Vythiri	\N	\N	673122
248	Mailellampara B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673586
249	Makkada B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673611
250	Manal Vayal B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673579
251	Manjoora B.O		Wayanad	KERALA	Vythiri	\N	\N	673575
252	Meemutty B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673580
253	Meenangadi S.O		Wayanad	KERALA	Sulthan Bathery	\N	\N	673591
254	Moodakolli B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673592
255	Murampathy B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673580
256	Mylambadi B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673591
257	Mysore Mala B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673602
258	Nadakavu S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673011
259	Narikkundu B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673593
260	Nayar Kuzhi B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673601
261	Padanilam B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673571
262	Padichira B.O		Wayanad	KERALA	Sulthan Batheri	\N	\N	673579
263	Perumanna B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673019
264	Puthiya Nirathu B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673303
265	Puthumala B.O		Wayanad	KERALA	Vythiri	\N	\N	673577
266	St.Vincent Colony B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673006
267	Sugandhagiri B.O		Wayanad	KERALA	Vythiri	\N	\N	673576
268	Tali S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673002
269	Thambalamanna B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673603
270	Tiruvannur Nada S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673029
271	Varadoor B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673591
272	Vazhu Vatta B.O		Wayanad	KERALA	Vythiri	\N	\N	673122
273	Vellayikkode B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673019
274	Avilora B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673572
275	Calicut Arts & Science College S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673018
276	Chathamangalam B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673601
277	Chelavur B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673571
278	Chevayur S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673017
279	Chundale S.O		Wayanad	KERALA	Vythiri	\N	\N	673123
280	Devagiri College B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673008
281	Karadipara B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673593
282	Lakkidi B.O		Wayanad	KERALA	Vythiri	\N	\N	673576
283	Malaparamba S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673009
284	Manipuram B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673572
285	Marakadavu B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673579
286	Marikunnu S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673012
287	Meppadi S.O		Wayanad	KERALA	Sulthan Bathery	\N	\N	673577
288	Mullankolli B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673579
289	Nallalam S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673027
290	Olavanna B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673019
291	Padinhara Thara B.O		Wayanad	KERALA	Vythiri	\N	\N	673575
292	Pantheerankavu S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673019
293	Pazhupathur B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673592
294	Peringalam B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673571
295	Poothadi B.O		Wayanad	KERALA	Sulthan Batheri	\N	\N	673596
296	Puthan Kunnu B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	673595
297	Puthur- Kotuvalli B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673582
298	Santhi Nagar B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673582
299	Tamaracheri S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673573
300	Vaidyarangadi B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673633
301	Varambetta B.O		Wayanad	KERALA	Vythiri	\N	\N	673575
302	Velimanna B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673582
303	Vythiri S.O		Wayanad	KERALA	Vythiri	\N	\N	673576
304	West Hill Chungam B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673005
305	Alakode-kuttaramba B.O		Kannur	KERALA	Taliparamba	\N	\N	670571
306	Aroli B.O		Kannur	KERALA	Kannur	\N	\N	670561
307	Chandanakampara B.O		Kannur	KERALA	Taliparamba	\N	\N	670633
308	Chattuvapara B.O		Kannur	KERALA	Taliparamba	\N	\N	670592
309	Chepparapadava S.O		Kannur	KERALA	Taliparamba	\N	\N	670581
310	Chirakk R.S. B.O		Kannur	KERALA	Kannur	\N	\N	670011
311	Irukkur S.O		Kannur	KERALA	Taliparamba	\N	\N	670593
312	Kadannapally B.O		Kannur	KERALA	Taliparamba	\N	\N	670504
313	Kakkat S.O		Kannur	KERALA	Kannur	\N	\N	670005
314	Kalliasseri S.O		Kannur	KERALA	Kannur	\N	\N	670562
315	Kanayi B.O		Kannur	KERALA	Taliparamba	\N	\N	670307
316	Kandankali B.O		Kannur	KERALA	Taliparamba	\N	\N	670307
317	Kannadiparamba S.O		Kannur	KERALA	Kannur	\N	\N	670604
318	Kannookara B.O		Kannur	KERALA	Kannur	\N	\N	670012
319	Kannur District Hospital S.O		Kannur	KERALA	Kannur	\N	\N	670017
320	Karivellur S.O		Kannur	KERALA	Taliparamba	\N	\N	670521
321	Kudiyanmala B.O		Kannur	KERALA	Taliparamba	\N	\N	670582
322	Manakadavu B.O		Kannur	KERALA	Taliparamba	\N	\N	670571
323	Mattul North S.O		Kannur	KERALA	Kannur	\N	\N	670325
324	Morazha B.O		Kannur	KERALA	Taliparamba	\N	\N	670331
325	Mottammal S.O		Kannur	KERALA	Kannur	\N	\N	670331
326	Mundalur S.O		Kannur	KERALA	Kannur	\N	\N	670622
327	Munderi B.O		Kannur	KERALA	Kannur	\N	\N	670591
328	Muyyam B.O		Kannur	KERALA	Taliparamba	\N	\N	670142
329	Ottathai B.O		Kannur	KERALA	Taliparamba	\N	\N	670571
330	Porakunnu B.O		Kannur	KERALA	Taliparamba	\N	\N	670306
331	Talap S.O (Kannur)		Kannur	KERALA	Kannur	\N	\N	670002
332	Thattummal B.O		Kannur	KERALA	Taliparamba	\N	\N	670511
333	Varam S.O		Kannur	KERALA	Kannur	\N	\N	670594
334	Vellad B.O		Kannur	KERALA	Taliparamba	\N	\N	670571
335	Vijayagiri B.O		Kannur	KERALA	Taliparamba	\N	\N	670571
336	Annur B.O		Kannur	KERALA	Taliparamba	\N	\N	670307
337	Attadappa B.O		Kannur	KERALA	Kannur	\N	\N	670006
338	Chalakkode B.O		Kannur	KERALA	NA	\N	\N	670307
339	Chemperi S.O		Kannur	KERALA	Taliparamba	\N	\N	670632
340	Cherukun R.S. B.O		Kannur	KERALA	Kannur	\N	\N	670301
341	Cherupuzha S.O		Kannur	KERALA	Taliparamba	\N	\N	670511
342	Kadumeni B.O		Kasargod	KERALA	Hosdurg	\N	\N	670511
343	Keezhara B.O		Kannur	KERALA	Kannur	\N	\N	670301
344	Kootumugham B.O		Kannur	KERALA	Taliparamba	\N	\N	670631
345	Kottali B.O		Kannur	KERALA	Kannur	\N	\N	670005
346	Koyyode B.O		Kannur	KERALA	Kannur	\N	\N	670621
347	Mandalam B.O		Kannur	KERALA	Taliparamba	\N	\N	670582
348	Mayyil S.O		Kannur	KERALA	Taliparamba	\N	\N	670602
349	Mullakodi B.O		Kannur	KERALA	Taliparamba	\N	\N	670602
350	Muzhappala B.O		Kannur	KERALA	Kannur	\N	\N	670611
351	Naduvil S.O		Kannur	KERALA	Taliparamba	\N	\N	670582
352	Nanichery B.O		Kannur	KERALA	Taliparamba	\N	\N	670563
353	Nedungome B.O		Kannur	KERALA	Taliparamba	\N	\N	670631
354	Payangadi S.O		Kannur	KERALA	Taliaparamba	\N	\N	670303
355	Peruvalathuparamba B.O		Kannur	KERALA	Taliparamba	\N	\N	670593
356	Pulikurumba B.O		Kannur	KERALA	Taliparamba	\N	\N	670582
357	Taliparamba H.O		Kannur	KERALA	Taliparamba	\N	\N	670141
358	Anchampeedika B.O		Kannur	KERALA	Kannur	\N	\N	670331
359	Arang B.O		Kannur	KERALA	Taliparamba	\N	\N	670582
360	Arivilanjapoyil B.O		Kannur	KERALA	Taliparamba	\N	\N	670571
361	Azhikode S.O		Kannur	KERALA	Kannur	\N	\N	670009
362	Cherukunnu S.O		Kannur	KERALA	NA	\N	\N	670301
363	Chittodi B.O		Kannur	KERALA	Taliparamba	\N	\N	670571
364	Chovva S.O		Kannur	KERALA	Kannur	\N	\N	670006
365	Civil Station Kannur S.O		Kannur	KERALA	Kannur	\N	\N	670002
366	CRPF Camp Aravanchal S.O		Kannur	KERALA	Taliparamba	\N	\N	670353
367	Eachur S.O		Kannur	KERALA	Kannur	\N	\N	670591
368	Eriam B.O		Kannur	KERALA	Kannur	\N	\N	670306
369	Eruvassi B.O		Kannur	KERALA	Taliparamba	\N	\N	670632
370	Eruvatty-chapparapadava B.O		Kannur	KERALA	Taliparamba	\N	\N	670581
371	Ettikulam B.O		Kannur	KERALA	Taliparamba	\N	\N	670308
372	Ezhilode B.O		Kannur	KERALA	Taliparamba	\N	\N	670309
373	Ezhome S.O		Kannur	KERALA	Kannur	\N	\N	670334
374	Kandoth B.O		Kannur	KERALA	Taliparamba	\N	\N	670307
375	Kanhirangad B.O		Kannur	KERALA	Taliparamba	\N	\N	670142
376	Kannur Thana S.O		Kannur	KERALA	Kannur	\N	\N	670012
377	Kanul B.O		Kannur	KERALA	Taliparamba	\N	\N	670562
378	Karuvanchal B.O		Kannur	KERALA	Taliparamba	\N	\N	670571
379	Makreri B.O		Kannur	KERALA	Kannur	\N	\N	670622
380	Malapattam B.O		Kannur	KERALA	Taliparamba	\N	\N	670631
381	Mattul S.O		Kannur	KERALA	Kannur	\N	\N	670302
382	Narath B.O		Kannur	KERALA	Kannur	\N	\N	670601
383	Nellikutty B.O		Kannur	KERALA	Taliparamba	\N	\N	670632
384	Panapuzha B.O		Kannur	KERALA	Taliparamba	\N	\N	670306
385	Pariyaram Medical College S.O		Kannur	KERALA	Kannur	\N	\N	670503
386	Pattanur B.O		Kannur	KERALA	Thalassery	\N	\N	670595
387	Pavanoormotta B.O		Kannur	KERALA	Taliparamba	\N	\N	670602
388	Thadikadavu B.O		Kannur	KERALA	Taliparamba	\N	\N	670581
389	Chalad S.O		Kannur	KERALA	Kannur	\N	\N	670014
390	Chekkikulam B.O		Kannur	KERALA	Taliparamba	\N	\N	670592
391	Chengalayi B.O		Kannur	KERALA	Taliparamba	\N	\N	670631
392	Cherupazhassi B.O		Kannur	KERALA	Taliparamba	\N	\N	670601
393	Irinavu B.O		Kannur	KERALA	Kannur	\N	\N	670301
394	Kanamvayal B.O		Kannur	KERALA	Taliparamba	\N	\N	670511
395	Kanhirode B.O		Kannur	KERALA	Kannur	\N	\N	670592
396	Kankol B.O		Kannur	KERALA	Taliparamba	\N	\N	670307
397	Kannur City S.O		Kannur	KERALA	Kannur	\N	\N	670003
398	Kizhunna B.O		Kannur	KERALA	Kannur	\N	\N	670007
399	Kuttiyeri B.O		Kannur	KERALA	Taliparamba	\N	\N	670142
400	Madayi S.O		Kannur	KERALA	Taliparamba	\N	\N	670304
401	Mathil B.O		Kannur	KERALA	Taliparamba	\N	\N	670307
402	Mundayad B.O		Kannur	KERALA	Kannur	\N	\N	670594
403	Nediyenga B.O		Kannur	KERALA	Taliparamba	\N	\N	670631
404	Nellipara B.O		Kannur	KERALA	Taliparamba	\N	\N	670571
405	Padiotchal B.O		Kannur	KERALA	Taliparamba	\N	\N	670307
406	Pappinisseri S.O		Kannur	KERALA	Kannur	\N	\N	670561
407	Payangadi R S S.O		Kannur	KERALA	Kannur	\N	\N	670358
408	Poduvachery B.O		Kannur	KERALA	Kannur	\N	\N	670621
409	Ramanthali S.O		Kannur	KERALA	Taliparamba	\N	\N	670308
410	Thabore B.O		Kannur	KERALA	Taliparamba	\N	\N	670511
411	Thavam B.O		Kannur	KERALA	Kannur	\N	\N	670301
412	Thrichambaram B.O		Kannur	KERALA	Taliparamba	\N	\N	670141
413	Udayagiri B.O		Kannur	KERALA	Taliparamba	\N	\N	670571
414	Vayattuparamba B.O		Kannur	KERALA	Taliparamba	\N	\N	670582
415	Vengad B.O		Kannur	KERALA	Thalassery	\N	\N	670612
416	Vengara-kannur S.O		Kannur	KERALA	Kannur	\N	\N	670305
417	Areekamala B.O		Kannur	KERALA	Taliparamba	\N	\N	670582
418	Chala East B.O		Kannur	KERALA	Kannur	\N	\N	670621
419	Chirakkal S.O		Kannur	KERALA	Kannur	\N	\N	670011
420	Chuzhali B.O		Kannur	KERALA	Taliparamba	\N	\N	670142
421	Josegiri B.O		Kannur	KERALA	Taliparamba	\N	\N	670511
422	Kalliad B.O		Kannur	KERALA	Taliparamba	\N	\N	670593
423	Kamballur B.O		Kasargod	KERALA	Hosdurg	\N	\N	670511
424	Kandakai B.O		Kannur	KERALA	Taliparamba	\N	\N	670602
425	Kannivayal B.O		Kasargod	KERALA	Hosdurg	\N	\N	670511
426	Katalayi B.O		Kannur	KERALA	Kannur	\N	\N	670003
427	Kavvayi B.O		Kannur	KERALA	Taliparamba	\N	\N	670307
428	Kolacherry S.O		Kannur	KERALA	Taliparamba	\N	\N	670601
429	Korom B.O		Kannur	KERALA	Taliparamba	\N	\N	670307
430	Kozhummal B.O		Kannur	KERALA	Taliparamba	\N	\N	670521
431	Kuppam-taliparamba B.O		Kannur	KERALA	Taliparamba	\N	\N	670502
432	Kuttiyattur B.O		Kannur	KERALA	Taliparamba	\N	\N	670602
433	Mathamangalam B.O		Kannur	KERALA	Kannur	\N	\N	670306
434	Mowancheri S.O		Kannur	KERALA	Kannur	\N	\N	670613
435	Nhekly B.O		Kannur	KERALA	Taliparamba	\N	\N	670307
436	Panniyur B.O		Kannur	KERALA	Taliparamba	\N	\N	670142
437	Pappinisseri West B.O		Kannur	KERALA	Kannur	\N	\N	670561
438	Parassinikadavu S.O		Kannur	KERALA	Taliparamba	\N	\N	670563
439	Payyambalam S.O		Kannur	KERALA	Kannur	\N	\N	670001
440	Payyanur S.O		Kannur	KERALA	Taliparamba	\N	\N	670307
441	Payyavur S.O		Kannur	KERALA	Taliparamba	\N	\N	670633
442	Pazhassikari B.O		Kannur	KERALA	Taliparamba	\N	\N	670633
443	Peringome B.O		Kannur	KERALA	Taliparamba	\N	\N	670307
444	Pottampilavu B.O		Kannur	KERALA	Taliparamba	\N	\N	670582
445	Sreekandapuram S.O		Kannur	KERALA	Taliparamba	\N	\N	670631
446	Therthally B.O		Kannur	KERALA	Taliparamba	\N	\N	670571
447	Thimiri-chepparapadava B.O		Kannur	KERALA	Taliparamba	\N	\N	670581
448	Thirumeni B.O		Kannur	KERALA	Taliparamba	\N	\N	670511
449	Thiruvattoor B.O		Kannur	KERALA	Taliparamba	\N	\N	670502
450	Vellur B.O		Kannur	KERALA	Taliparamba	\N	\N	670307
451	Azhikkal B.O		Kannur	KERALA	Kannur	\N	\N	670009
452	Edakkom B.O		Kannur	KERALA	Taliparamba	\N	\N	670581
453	Ettukudukka B.O		Kannur	KERALA	Taliparamba	\N	\N	670521
454	Kannur Railway Station S.O		Kannur	KERALA	Kannur	\N	\N	670001
455	Kayalampara B.O		Kannur	KERALA	Taliparamba	\N	\N	670632
456	Kezhallur B.O		Kannur	KERALA	Thalassery	\N	\N	670612
457	Kottayad B.O		Kannur	KERALA	Taliparamba	\N	\N	670571
458	Koyyam B.O		Kannur	KERALA	Taliparamba	\N	\N	670142
459	Kuttikol B.O		Kannur	KERALA	Taliparamba	\N	\N	670562
460	Mathamangalam Bazar S.O		Kannur	KERALA	Taliparamba	\N	\N	670306
461	Muringeri B.O		Kannur	KERALA	Kannur	\N	\N	670612
462	Pariyaram-kannur S.O		Kannur	KERALA	Taliparamba	\N	\N	670502
463	Pattuvam S.O		Kannur	KERALA	Taliparamba	\N	\N	670143
464	Rayarom B.O		Kannur	KERALA	Taliparamba	\N	\N	670571
465	Thayyeni B.O		Kasargod	KERALA	Hosdurg	\N	\N	670511
466	Thazhe Chovva S.O		Kannur	KERALA	Kannur	\N	\N	670018
467	Vadakkumbad-ramanthali B.O		Kannur	KERALA	Taliparamba	\N	\N	670308
468	Aril B.O		Kannur	KERALA	Taliparamba	\N	\N	670143
469	Azhikode South B.O		Kannur	KERALA	Kannur	\N	\N	670009
470	Cheleri B.O		Kannur	KERALA	Taliparamba	\N	\N	670604
471	Cherikode B.O		Kannur	KERALA	Taliparamba	\N	\N	670631
472	Chundakunnu B.O		Kannur	KERALA	Taliparamba	\N	\N	670632
473	Edayannur S.O		Kannur	KERALA	Thalassery	\N	\N	670595
474	Elampara B.O		Kannur	KERALA	Thalassery	\N	\N	670595
475	Eramam Desom B.O		Kannur	KERALA	Taliparamba	\N	\N	670307
476	Kadachira S.O		Kannur	KERALA	Kannur	\N	\N	670621
477	Kanjirakolly B.O		Kannur	KERALA	Taliparamba	\N	\N	670633
478	Kannur H.O		Kannur	KERALA	Kannur	\N	\N	670001
479	Kannur University Campus S.O		Kannur	KERALA	Kannur	\N	\N	670567
480	Karimbam S.O		Kannur	KERALA	Taliparamba	\N	\N	670142
481	Karippal B.O		Kannur	KERALA	Taliparamba	\N	\N	670581
482	Kattampally B.O		Kannur	KERALA	Kannur	\N	\N	670011
483	Kokkanisseri S.O		Kannur	KERALA	Taliparamba	\N	\N	670307
484	Kooveri B.O		Kannur	KERALA	Taliparamba	\N	\N	670581
485	Kottila B.O		Kannur	KERALA	Kannur	\N	\N	670334
486	Kunhimangalam S.O		Kannur	KERALA	Taliparamba	\N	\N	670309
487	Kusavanvayal B.O		Kannur	KERALA	Taliparamba	\N	\N	670593
488	Mamba S.O		Kannur	KERALA	Kannur	\N	\N	670611
489	Mandur-kannur S.O		Kannur	KERALA	Taliparamba	\N	\N	670501
490	Mavilayi B.O		Kannur	KERALA	Kannur	\N	\N	670622
491	Nareekamvally B.O		Kannur	KERALA	Taliparamba	\N	\N	670504
492	Padappangad B.O		Kannur	KERALA	Taliparamba	\N	\N	670581
493	Palavayal B.O		Kasargod	KERALA	Hosdurg	\N	\N	670511
494	Pathampara B.O		Kannur	KERALA	Taliparamba	\N	\N	670571
495	Payyan R.S. B.O		Kannur	KERALA	Taliparamba	\N	\N	670307
496	Pilathara S.O		Kannur	KERALA	Taliparamba	\N	\N	670504
497	Sreestha B.O		Kannur	KERALA	Taliparamba	\N	\N	670303
498	Thekkumbad B.O		Kannur	KERALA	Kannur	\N	\N	670301
499	Alakode S.O		Kannur	KERALA	Taliparamba	\N	\N	670571
500	Alavil S.O		Kannur	KERALA	Kannur	\N	\N	670008
501	Anjarakandy S.O		Kannur	KERALA	Thalassery	\N	\N	670612
502	Bavode B.O		Kannur	KERALA	Kannur	\N	\N	670622
503	Burnacherry S.O		Kannur	KERALA	Kannur	\N	\N	670013
504	Chamathachal B.O		Kannur	KERALA	Taliparamba	\N	\N	670633
505	Chempanthotty B.O		Kannur	KERALA	Taliparamba	\N	\N	670631
506	Chithapilapoyil B.O		Kannur	KERALA	Taliparamba	\N	\N	670502
507	Chunda B.O		Kannur	KERALA	Taliparamba	\N	\N	670511
508	Edat S.O		Kannur	KERALA	Kannur	\N	\N	670327
509	Edavaramba B.O		Kannur	KERALA	Taliparamba	\N	\N	670511
510	Ezhimala Naval Academy S.O		Kannur	KERALA	Taliparamba	\N	\N	670310
511	Iriveri B.O		Kannur	KERALA	Kannur	\N	\N	670613
512	Kaithapram B.O		Kannur	KERALA	Taliparamba	\N	\N	670631
513	Kakkara B.O		Kannur	KERALA	Taliparamba	\N	\N	670306
514	Kappad B.O		Kannur	KERALA	Kannur	\N	\N	670006
515	Karanthat B.O		Kannur	KERALA	Taliparamba	\N	\N	670308
516	Karthikapuram B.O		Kannur	KERALA	Taliparamba	\N	\N	670571
517	Kayaralam B.O		Kannur	KERALA	Taliparamba	\N	\N	670602
518	Koodali S.O		Kannur	KERALA	Thalassery	\N	\N	670592
519	Kovvapuram B.O		Kannur	KERALA	Kannur	\N	\N	670309
520	Kozhichal B.O		Kannur	KERALA	Taliparamba	\N	\N	670511
521	Kuniyampuzha B.O		Kannur	KERALA	Taliparamba	\N	\N	670632
522	Kurumathur B.O		Kannur	KERALA	Taliparamba	\N	\N	670142
523	Kuttur B.O		Kannur	KERALA	Taliparamba	\N	\N	670306
524	Olayampadi B.O		Kannur	KERALA	Taliparamba	\N	\N	670306
525	Othayammadom B.O		Kannur	KERALA	Kannur	\N	\N	670301
526	Palakkode B.O		Kannur	KERALA	Taliparamba	\N	\N	670305
527	Pallikunnu S.O		Kannur	KERALA	Kannur	\N	\N	670004
528	Pallivayal B.O		Kannur	KERALA	Taliparamba	\N	\N	670142
529	Prapoyil B.O		Kannur	KERALA	Taliparamba	\N	\N	670511
530	Thayyil B.O		Kannur	KERALA	Kannur	\N	\N	670003
531	Thottada S.O		Kannur	KERALA	Kannur	\N	\N	670007
532	Valapattanam S.O		Kannur	KERALA	Kannur	\N	\N	670010
533	Vellora B.O		Kannur	KERALA	Taliparamba	\N	\N	670306
534	Vilayancode B.O		Kannur	KERALA	Taliparamba	\N	\N	670504
535	Adkathbail B.O		Kasargod	KERALA	Kasaragod	\N	\N	671121
536	Ammeri B.O		Kasargod	KERALA	Kasaragod	\N	\N	671322
537	Bedadka B.O		Kasargod	KERALA	Kasaragod	\N	\N	671541
538	Bedradka B.O		Kasargod	KERALA	Kasaragod	\N	\N	671124
539	Beripadavu B.O		Kasargod	KERALA	Kasaragod	\N	\N	671322
540	Bheemanady B.O		Kasargod	KERALA	Hosdurg	\N	\N	671314
541	Bombrana B.O		Kasargod	KERALA	Kasaragod	\N	\N	671321
542	Chamnad B.O		Kasargod	KERALA	Kasaragod	\N	\N	671317
543	Chervathur S.O		Kasargod	KERALA	Hosdurg	\N	\N	671313
544	Kadambar B.O		Kasargod	KERALA	Kasaragod	\N	\N	671323
545	Kaithakkad B.O		Kasargod	KERALA	Hosdurg	\N	\N	671313
546	Kalichanadukam B.O		Kasargod	KERALA	Hosdurg	\N	\N	671314
547	Kanhangad South B.O		Kasargod	KERALA	Hosdurg	\N	\N	671531
548	Kanhirapoil B.O		Kasargod	KERALA	Hosdurg	\N	\N	671531
549	Kannur B.O		Kasargod	KERALA	Kasaragod	\N	\N	671321
550	Kasaragod R S S.O		Kasargod	KERALA	Kasaragod	\N	\N	671121
551	Kayyaru B.O		Kasargod	KERALA	Kasaragod	\N	\N	671322
552	Kinningar B.O		Kasargod	KERALA	Kasaragod	\N	\N	671543
553	Kotoor B.O		Kasargod	KERALA	Kasaragod	\N	\N	671542
554	Kottamala Estate B.O		Kasargod	KERALA	Hosdurg	\N	\N	671314
555	Kundankuzhy B.O		Kasargod	KERALA	Kasaragod	\N	\N	671541
556	Madikai B.O		Kasargod	KERALA	Hosdurg	\N	\N	671314
557	Manadka B.O		Kasargod	KERALA	Kasaragod	\N	\N	671541
558	Manikoth B.O		Kasargod	KERALA	Hosdurg	\N	\N	671316
559	Mogral B.O		Kasargod	KERALA	Kasaragod	\N	\N	671321
560	Moodambail B.O		Kasargod	KERALA	Kasaragod	\N	\N	671323
561	Nileshwar S.O		Kasargod	KERALA	Hosdurg	\N	\N	671314
562	Pathoor B.O		Kasargod	KERALA	Kasaragod	\N	\N	671323
563	Patla B.O		Kasargod	KERALA	Kasaragod	\N	\N	671124
564	Punnakkunnu B.O		Kasargod	KERALA	Hosdurg	\N	\N	671533
565	Ranipuram B.O		Kasargod	KERALA	Hosdurg	\N	\N	671532
566	Udinur B.O		Kasargod	KERALA	Hosdurg	\N	\N	671310
567	Udumbanthala B.O		Kasargod	KERALA	Hosdurg	\N	\N	671311
568	Urdur B.O		Kasargod	KERALA	Kasaragod	\N	\N	671543
569	Bandadka B.O		Kasargod	KERALA	Kasaragod	\N	\N	671541
570	Chippar B.O		Kasargod	KERALA	Kasaragod	\N	\N	671322
571	Dharmathadka B.O		Kasargod	KERALA	Kasaragod	\N	\N	671324
572	Kanathur B.O		Kasargod	KERALA	Kasaragod	\N	\N	671542
573	Kanhiradkam B.O		Kasargod	KERALA	Hosdurg	\N	\N	671531
574	Karadka B.O		Kasargod	KERALA	Kasaragod	\N	\N	671542
575	Majibail B.O		Kasargod	KERALA	Kasaragod	\N	\N	671323
576	Manimoole B.O		Kasargod	KERALA	Kasaragod	\N	\N	671541
577	Muliyar S.O		Kasargod	KERALA	Kasaragod	\N	\N	671542
578	Nettanige B.O		Kasargod	KERALA	Kasaragod	\N	\N	671543
579	Padne S.O		Kasargod	KERALA	Hosdurg	\N	\N	671312
580	Panathur B.O		Kasargod	KERALA	Hosdurg	\N	\N	671532
581	Paravanadkam B.O		Kasargod	KERALA	Kasaragod	\N	\N	671317
582	Perdala S.O		Kasargod	KERALA	Kasaragod	\N	\N	671551
583	Periyanganam B.O		Kasargod	KERALA	Hosdurg	\N	\N	671314
584	Periye B.O		Kasargod	KERALA	Hosdurg	\N	\N	671316
585	Podavur B.O		Kasargod	KERALA	Hosdurg	\N	\N	671313
586	Pudukai B.O		Kasargod	KERALA	Hosdurg	\N	\N	671314
587	Pullur B.O		Kasargod	KERALA	Hosdurg	\N	\N	671531
588	Ravaneshwaram B.O		Kasargod	KERALA	Hosdurg	\N	\N	671316
589	Udyavara B.O		Kasargod	KERALA	Kasaragod	\N	\N	671323
590	Ullody B.O		Kasargod	KERALA	Kasaragod	\N	\N	671321
591	Uppilakai B.O		Kasargod	KERALA	Hosdurg	\N	\N	671314
592	Vallikadavu B.O		Kasargod	KERALA	Hosdurg	\N	\N	671533
593	West Eleri B.O		Kasargod	KERALA	Hosdurg	\N	\N	671314
594	Anekallu B.O		Kasargod	KERALA	Kasaragod	\N	\N	671323
595	Attenganam B.O		Kasargod	KERALA	Hosdurg	\N	\N	671531
596	Badaje B.O		Kasargod	KERALA	Kasaragod	\N	\N	671323
597	Bangramanjeshwar B.O		Kasargod	KERALA	Kasaragod	\N	\N	671323
598	Bekur B.O		Kasargod	KERALA	Kasaragod	\N	\N	671322
599	Cheroor B.O		Kasargod	KERALA	Kasaragod	\N	\N	671123
600	Chimeni B.O		Kasargod	KERALA	Hosdurg	\N	\N	671313
601	Chittari B.O		Kasargod	KERALA	Hosdurg	\N	\N	671316
602	Erikulam B.O		Kasargod	KERALA	Hosdurg	\N	\N	671314
603	Karindala B.O		Kasargod	KERALA	Hosdurg	\N	\N	671314
604	Kidoor B.O		Kasargod	KERALA	Kasaragod	\N	\N	671321
605	Kolichal B.O		Kasargod	KERALA	Hosdurg	\N	\N	671532
606	Koliyur B.O		Kasargod	KERALA	Kasaragod	\N	\N	671323
607	Kottacherry S.O		Kasargod	KERALA	Hosdurg	\N	\N	671315
608	Kuttikolu B.O		Kasargod	KERALA	Kasaragod	\N	\N	671541
609	Maire B.O		Kasargod	KERALA	Kasaragod	\N	\N	671552
610	Manjeshwar S.O		Kasargod	KERALA	Kasaragod	\N	\N	671323
611	Mugu B.O		Kasargod	KERALA	Kasaragod	\N	\N	671321
612	Natakkal B.O		Kasargod	KERALA	Hosdurg	\N	\N	671533
613	Olat B.O		Kasargod	KERALA	Hosdurg	\N	\N	671310
614	Padimaruth B.O		Kasargod	KERALA	Hosdurg	\N	\N	671531
615	Paivalike S.O		Kasargod	KERALA	Kasaragod	\N	\N	671348
616	Panathady B.O		Kasargod	KERALA	Hosdurg	\N	\N	671532
617	Paniyal B.O		Kasargod	KERALA	Hosdurg	\N	\N	671318
618	Pavoor B.O		Kasargod	KERALA	Kasaragod	\N	\N	671323
619	Perla S.O		Kasargod	KERALA	Kasaragod	\N	\N	671552
620	Permude B.O		Kasargod	KERALA	Kasaragod	\N	\N	671324
621	Perumbatta B.O		Kasargod	KERALA	Hosdurg	\N	\N	671313
622	Puthariadukkam B.O		Kasargod	KERALA	Hosdurg	\N	\N	671314
623	Ramdasnagar B.O		Kasargod	KERALA	Kasaragod	\N	\N	671124
624	Thekkilferry B.O		Kasargod	KERALA	Kasaragod	\N	\N	671541
625	Trikarpur South B.O		Kasargod	KERALA	Hosdurg	\N	\N	671311
626	Uppala Gate B.O		Kasargod	KERALA	Kasaragod	\N	\N	671322
627	Vellap B.O		Kasargod	KERALA	Hosdurg	\N	\N	671310
628	Achanthuruthi B.O		Kasargod	KERALA	Hosdurg	\N	\N	671351
629	Ajanur B.O		Kasargod	KERALA	Hosdurg	\N	\N	671531
630	Chandragiri B.O		Kasargod	KERALA	Kasaragod	\N	\N	671317
631	Hidayathnagar B.O		Kasargod	KERALA	Kasaragod	\N	\N	671123
632	Kalnad S.O		Kasargod	KERALA	Kasaragod	\N	\N	671317
633	Kanakappally B.O		Kasargod	KERALA	Hosdurg	\N	\N	671533
634	Kinanur B.O		Kasargod	KERALA	Hosdurg	\N	\N	671533
635	Kodoth B.O		Kasargod	KERALA	Hosdurg	\N	\N	671531
636	Kumbdaje B.O		Kasargod	KERALA	Kasaragod	\N	\N	671551
637	Kumbla S.O		Kasargod	KERALA	Kasaragod	\N	\N	671321
638	Kuntikana B.O		Kasargod	KERALA	Kasaragod	\N	\N	671551
639	Madhur B.O		Kasargod	KERALA	Kasaragod	\N	\N	671124
640	Mandapam B.O		Kasargod	KERALA	Hosdurg	\N	\N	671326
641	Mavilakadapuram B.O		Kasargod	KERALA	Hosdurg	\N	\N	671312
642	Miyapadavu B.O		Kasargod	KERALA	Kasaragod	\N	\N	671323
643	Nekraje B.O		Kasargod	KERALA	Kasaragod	\N	\N	671543
644	Padnekadapuram B.O		Kasargod	KERALA	Hosdurg	\N	\N	671312
645	Pakkom B.O		Kasargod	KERALA	Hosdurg	\N	\N	671316
646	Parappa S.O		Kasargod	KERALA	Hosdurg	\N	\N	671533
647	Pettikundu B.O		Kasargod	KERALA	Hosdurg	\N	\N	671313
648	Pilicode B.O		Kasargod	KERALA	Hosdurg	\N	\N	671310
649	Puthige B.O		Kasargod	KERALA	Kasaragod	\N	\N	671321
650	Thaikadapuram B.O		Kasargod	KERALA	Hosdurg	\N	\N	671314
651	Trikarpur Kadapuram B.O		Kasargod	KERALA	Hosdurg	\N	\N	671310
652	Valiaparaba B.O		Kasargod	KERALA	Hosdurg	\N	\N	671312
653	Alampady B.O		Kasargod	KERALA	Kasaragod	\N	\N	671123
654	Angadimogaru B.O		Kasargod	KERALA	Kasaragod	\N	\N	671321
655	Balla B.O		Kasargod	KERALA	Hosdurg	\N	\N	671531
656	Charla B.O		Kasargod	KERALA	Kasaragod	\N	\N	671323
657	Darkas B.O		Kasargod	KERALA	Hosdurg	\N	\N	671533
658	Edneer B.O		Kasargod	KERALA	Kasaragod	\N	\N	671541
659	Ichlampady B.O		Kasargod	KERALA	Kasaragod	\N	\N	671321
660	Iriyanni B.O		Kasargod	KERALA	Kasaragod	\N	\N	671542
661	Kakkebettu B.O		Kasargod	KERALA	Kasaragod	\N	\N	671543
662	Keekan B.O		Kasargod	KERALA	Hosdurg	\N	\N	671316
663	Kodiamme B.O		Kasargod	KERALA	Kasaragod	\N	\N	671321
664	Kottapuram B.O		Kasargod	KERALA	Hosdurg	\N	\N	671314
665	Kudalmerkala B.O		Kasargod	KERALA	Kasaragod	\N	\N	671324
666	Kudlu S.O		Kasargod	KERALA	Kasaragod	\N	\N	671124
667	Malakallu B.O		Kasargod	KERALA	Hosdurg	\N	\N	671532
668	Maniyat B.O		Kasargod	KERALA	Hosdurg	\N	\N	671310
669	Mayipady B.O		Kasargod	KERALA	Kasaragod	\N	\N	671124
670	Munnad B.O		Kasargod	KERALA	Kasaragod	\N	\N	671541
671	Padnekkad B.O		Kasargod	KERALA	Hosdurg	\N	\N	671314
672	Paramba B.O		Kasargod	KERALA	Hosdurg	\N	\N	671533
673	Parappa - Delampady B.O		Kasargod	KERALA	Kasaragod	\N	\N	671543
674	Rajapuram S.O		Kasargod	KERALA	Hosdurg	\N	\N	671532
675	Shiriya B.O		Kasargod	KERALA	Kasaragod	\N	\N	671321
676	Talangara S.O		Kasargod	KERALA	Kasaragod	\N	\N	671122
677	Anandashrama S.O		Kasargod	KERALA	Hosdurg	\N	\N	671531
678	Arikady B.O		Kasargod	KERALA	Kasaragod	\N	\N	671321
679	Badur B.O		Kasargod	KERALA	Kasaragod	\N	\N	671321
680	Bekal Fort S.O		Kasargod	KERALA	Hosdurg	\N	\N	671316
681	Bekal S.O		Kasargod	KERALA	Hosdurg	\N	\N	671318
682	Bela B.O		Kasargod	KERALA	Kasaragod	\N	\N	671321
683	Chengala S.O		Kasargod	KERALA	Kasaragod	\N	\N	671541
684	Chittarikkal S.O		Kasargod	KERALA	Hosdurg	\N	\N	671326
685	Chully B.O		Kasargod	KERALA	Hosdurg	\N	\N	671533
686	Delampady B.O		Kasargod	KERALA	Kasaragod	\N	\N	671543
687	Elambachi S.O		Kasargod	KERALA	Hosdurg	\N	\N	671311
688	Haripuram B.O		Kasargod	KERALA	Hosdurg	\N	\N	671531
689	Hosabettu B.O		Kasargod	KERALA	Kasaragod	\N	\N	671323
690	Kanhangad H.O		Kasargod	KERALA	Hosdurg	\N	\N	671315
691	Kilaikote B.O		Kasargod	KERALA	Hosdurg	\N	\N	671313
692	Kodlamogaru B.O		Kasargod	KERALA	Kasaragod	\N	\N	671323
693	Kolavayal B.O		Kasargod	KERALA	Hosdurg	\N	\N	671531
694	Kunjathur B.O		Kasargod	KERALA	Kasaragod	\N	\N	671323
695	Kurudapadavu B.O		Kasargod	KERALA	Kasaragod	\N	\N	671322
696	Mangalpady S.O		Kasargod	KERALA	Kasaragod	\N	\N	671324
697	Movvar B.O		Kasargod	KERALA	Kasaragod	\N	\N	671543
698	Muttomkadavil B.O		Kasargod	KERALA	Hosdurg	\N	\N	671533
699	Paraklayi B.O		Kasargod	KERALA	Hosdurg	\N	\N	671531
700	Samekochi B.O		Kasargod	KERALA	Kasaragod	\N	\N	671541
701	Timiri - Chervathur B.O		Kasargod	KERALA	Hosdurg	\N	\N	671313
702	Valiapoil B.O		Kasargod	KERALA	Hosdurg	\N	\N	671313
703	Vattamthatta B.O		Kasargod	KERALA	Kasaragod	\N	\N	671542
704	Achikanam B.O		Kasargod	KERALA	Hosdurg	\N	\N	671531
705	Adur B.O		Kasargod	KERALA	Kasaragod	\N	\N	671543
706	Balal B.O		Kasargod	KERALA	Hosdurg	\N	\N	671533
707	Balemoole B.O		Kasargod	KERALA	Kasaragod	\N	\N	671552
708	Bayar B.O		Kasargod	KERALA	Kasaragod	\N	\N	671348
709	Belluru B.O		Kasargod	KERALA	NA	\N	\N	671543
710	Chathamath B.O		Kasargod	KERALA	Hosdurg	\N	\N	671314
711	Ednad B.O		Kasargod	KERALA	Kasaragod	\N	\N	671321
712	Iriya B.O		Kasargod	KERALA	Hosdurg	\N	\N	671531
713	Kallakatta B.O		Kasargod	KERALA	Kasaragod	\N	\N	671123
714	Kallappally B.O		Kasargod	KERALA	Hosdurg	\N	\N	671532
715	Kattukukke B.O		Kasargod	KERALA	Kasaragod	\N	\N	671552
716	Kotakkat B.O		Kasargod	KERALA	Hosdurg	\N	\N	671310
717	Malla B.O		Kasargod	KERALA	Kasaragod	\N	\N	671542
718	Mogral Puthur B.O		Kasargod	KERALA	Kasaragod	\N	\N	671124
719	Nirchal B.O		Kasargod	KERALA	Kasaragod	\N	\N	671321
720	Pandi B.O		Kasargod	KERALA	Kasaragod	\N	\N	671543
721	Plachikara B.O		Kasargod	KERALA	Hosdurg	\N	\N	671533
722	Sankarampady B.O		Kasargod	KERALA	Kasaragod	\N	\N	671541
723	Thayanoor B.O		Kasargod	KERALA	Hosdurg	\N	\N	671531
724	Ukkinadka B.O		Kasargod	KERALA	Kasaragod	\N	\N	671552
725	Umda - Padinhare B.O		Kasargod	KERALA	Hosdurg	\N	\N	671319
726	Uppala S.O		Kasargod	KERALA	Kasaragod	\N	\N	671322
727	Vellarikundu B.O		Kasargod	KERALA	Hosdurg	\N	\N	671533
728	Vorkadi B.O		Kasargod	KERALA	Kasaragod	\N	\N	671323
729	Yethadka B.O		Kasargod	KERALA	Kasaragod	\N	\N	671551
730	Ariyapady B.O		Kasargod	KERALA	Kasaragod	\N	\N	671551
731	Bare B.O		Kasargod	KERALA	Hosdurg	\N	\N	671319
732	Bengalam B.O		Kasargod	KERALA	Hosdurg	\N	\N	671314
733	Chamundikunnu B.O		Kasargod	KERALA	Hosdurg	\N	\N	671532
734	Chayoth B.O		Kasargod	KERALA	Hosdurg	\N	\N	671314
735	Edachakai B.O		Kasargod	KERALA	Hosdurg	\N	\N	671310
736	Elerithattu B.O		Kasargod	KERALA	Hosdurg	\N	\N	671314
737	Heroor B.O		Kasargod	KERALA	Kasaragod	\N	\N	671324
738	Ichlangodu B.O		Kasargod	KERALA	Kasaragod	\N	\N	671324
739	Karivedakam B.O		Kasargod	KERALA	Kasaragod	\N	\N	671541
740	Kasaragod H.O		Kasargod	KERALA	Kasaragod	\N	\N	671121
741	Kattipoil B.O		Kasargod	KERALA	Hosdurg	\N	\N	671314
742	Kayyur B.O		Kasargod	KERALA	Hosdurg	\N	\N	671313
743	Kolathuri B.O		Kasargod	KERALA	Kasaragod	\N	\N	671541
744	Kollampara B.O		Kasargod	KERALA	Hosdurg	\N	\N	671314
745	Konnakad B.O		Kasargod	KERALA	Hosdurg	\N	\N	671533
746	Kottody B.O		Kasargod	KERALA	Hosdurg	\N	\N	671532
747	Kuntar B.O		Kasargod	KERALA	Kasaragod	\N	\N	671543
748	Movval B.O		Kasargod	KERALA	Hosdurg	\N	\N	671316
749	Mulleria S.O		Kasargod	KERALA	Kasaragod	\N	\N	671543
750	Muttathody B.O		Kasargod	KERALA	Kasaragod	\N	\N	671123
751	Mylatti B.O		Kasargod	KERALA	Hosdurg	\N	\N	671319
752	Ozhinhavalappu B.O		Kasargod	KERALA	Hosdurg	\N	\N	671314
753	Padre B.O		Kasargod	KERALA	Kasaragod	\N	\N	671552
754	Pallathadka B.O		Kasargod	KERALA	Kasaragod	\N	\N	671551
755	Panjikkal B.O		Kasargod	KERALA	Kasaragod	\N	\N	671543
756	Perumbala B.O		Kasargod	KERALA	Kasaragod	\N	\N	671317
757	Shiribagilu B.O		Kasargod	KERALA	Kasaragod	\N	\N	671124
758	Thekkil B.O		Kasargod	KERALA	Kasaragod	\N	\N	671541
759	Thuruthi S.O		Kasargod	KERALA	Hosdurg	\N	\N	671351
760	Trikarpur S.O		Kasargod	KERALA	Hosdurg	\N	\N	671310
761	Udma S.O		Kasargod	KERALA	Hosdurg	\N	\N	671319
762	Vaninagar B.O		Kasargod	KERALA	Kasaragod	\N	\N	671552
763	Vidyanagar S.O (Kasargod)		Kasargod	KERALA	Kasaragod	\N	\N	671123
764	Amminikkad B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679322
765	Ayikkarapadi B.O		Malappuram	KERALA	Ernad	\N	\N	673637
766	Bhoodan Colony B.O		Malappuram	KERALA	Nilambur	\N	\N	679334
767	Calicut Airport S.O		Malappuram	KERALA	Tirurangadi	\N	\N	673647
768	Chandakkunnu B.O		Malappuram	KERALA	Nilambur	\N	\N	679329
769	Chathangottupuram B.O		Malappuram	KERALA	Nilambur	\N	\N	679328
770	Chettippadam B.O		Malappuram	KERALA	Nilambur	\N	\N	679332
771	Elad B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679340
772	Eravimangalam B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679340
773	Iringattiri B.O		Malappuram	KERALA	Nilambur	\N	\N	676523
774	Kalikavu S.O		Malappuram	KERALA	Nilambur	\N	\N	676525
775	Karapuram B.O		Malappuram	KERALA	Nilambur	\N	\N	679331
776	Karuvambram West B.O		Malappuram	KERALA	Ernad	\N	\N	676123
777	Makkaraparamba S.O		Malappuram	KERALA	Perinthalmanna	\N	\N	676507
778	Melmuri B.O		Malappuram	KERALA	Ernad	\N	\N	676517
779	Nallanthanni B.O		Malappuram	KERALA	Nilambur	\N	\N	679330
780	Palathole B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679340
781	Palengara B.O		Malappuram	KERALA	Nilambur	\N	\N	679330
782	Pallikuth B.O		Malappuram	KERALA	Nilambur	\N	\N	679334
783	Pandallur B.O		Malappuram	KERALA	Ernad	\N	\N	676521
784	Pathaikara B.O		Malappuram	KERALA	Perintalmanna	\N	\N	679322
785	Payyanad B.O		Malappuram	KERALA	Ernad	\N	\N	676122
786	Perakamanna B.O		Malappuram	KERALA	Ernad	\N	\N	676541
787	Perinthattiri B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	676507
788	Ponniyakurissi B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679322
789	Pookottumanna B.O		Malappuram	KERALA	Nilambur	\N	\N	679334
790	Poongode B.O		Malappuram	KERALA	Nilambur	\N	\N	679327
791	Pulpatta B.O		Malappuram	KERALA	Ernad	\N	\N	676123
792	Talekode West B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679322
793	Tirurkad B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679321
794	Trippanachi B.O		Malappuram	KERALA	Ernad	\N	\N	673641
795	Vadapuram B.O		Malappuram	KERALA	Nilambur	\N	\N	676542
796	Vazhikkadavu B.O		Malappuram	KERALA	Nilambur	\N	\N	679333
797	Wandoor S.O		Malappuram	KERALA	Nilambur	\N	\N	679328
798	Aliparamba B.O		Malappuram	KERALA	Perintalmanna	\N	\N	679357
799	Chattipparamba B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	676504
800	Chelembra S.O		Malappuram	KERALA	Tirurangadi	\N	\N	673634
801	Chemmarakkattur B.O		Malappuram	KERALA	Ernad	\N	\N	673639
802	Chokkad B.O		Malappuram	KERALA	Nilambur	\N	\N	679332
803	Erumamunda B.O		Malappuram	KERALA	Nilambur	\N	\N	679334
804	Kambalakallu B.O		Malappuram	KERALA	Nilambur	\N	\N	679333
805	Kannamvettikavu B.O		Malappuram	KERALA	Ernad	\N	\N	673637
806	Mampattumoola B.O		Malappuram	KERALA	Nilambur	\N	\N	679332
807	Manhappatta B.O		Malappuram	KERALA	Ernad	\N	\N	676123
808	Mariyad B.O		Malappuram	KERALA	Ernad	\N	\N	676122
809	Modapoika B.O		Malappuram	KERALA	Nilambur	\N	\N	679331
810	Mongam S.O		Malappuram	KERALA	Ernad	\N	\N	673642
811	Moorkkanad B.O		Malappuram	KERALA	Perintalmanna	\N	\N	679338
812	Moothedam B.O		Malappuram	KERALA	Nilambur	\N	\N	679331
813	Munderi B.O		Malappuram	KERALA	Nilambur	\N	\N	679334
814	Muthuparamba B.O		Malappuram	KERALA	Ernad	\N	\N	673638
815	Muthuvallur B.O		Malappuram	KERALA	Ernad	\N	\N	673638
816	Neelancheri B.O		Malappuram	KERALA	Nilambur	\N	\N	676525
817	Olukur B.O		Malappuram	KERALA	Ernad	\N	\N	673642
818	Padiripadam B.O		Malappuram	KERALA	Nilambur	\N	\N	679334
819	Pallikkal B.O		Malappuram	KERALA	Tirurangadi	\N	\N	673634
820	Panga Chendy B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679338
821	Peruparamba-ugrapuram B.O		Malappuram	KERALA	Ernad	\N	\N	673639
822	Poonthavanam B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679325
823	Poovathikkal B.O		Malappuram	KERALA	Ernad	\N	\N	673639
824	Pulikkal S.O		Malappuram	KERALA	Ernad	\N	\N	673637
825	Pulliparamba B.O		Malappuram	KERALA	Tirurangadi	\N	\N	673634
826	Puzhakkattiri B.O		Malappuram	KERALA	Perintalmanna	\N	\N	679321
827	Thurakkal B.O		Malappuram	KERALA	Ernad	\N	\N	673638
828	Tiruvali B.O		Malappuram	KERALA	Nilambur	\N	\N	676123
829	Uppada B.O		Malappuram	KERALA	Nilambur	\N	\N	679334
830	Vadakkangara B.O		Malappuram	KERALA	Perintalmanna	\N	\N	679324
831	Vadakkumpadam B.O		Malappuram	KERALA	Nilambur	\N	\N	679339
832	Vattalur B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	676507
833	Vettilappara B.O		Malappuram	KERALA	Ernad	\N	\N	673639
834	Amarambalam B.O		Malappuram	KERALA	Nilambur	\N	\N	679332
835	Aurvacode B.O		Malappuram	KERALA	Nilambur	\N	\N	679329
836	Calicut University S.O		Malappuram	KERALA	Tirurangadi	\N	\N	673635
837	Chembrassei B.O		Malappuram	KERALA	Ernad	\N	\N	676521
838	Edakkara-nilambur S.O		Malappuram	KERALA	Nilambur	\N	\N	679331
839	Edavanna S.O		Malappuram	KERALA	Ernad	\N	\N	676541
840	Elankur B.O		Malappuram	KERALA	Ernad	\N	\N	676122
841	Hajiarpalli B.O		Malappuram	KERALA	Ernad	\N	\N	676519
842	Kadannamanna B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679324
843	Kadungapurm B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679321
844	Karad B.O		Malappuram	KERALA	Nilambur	\N	\N	679339
845	Karakkode B.O		Malappuram	KERALA	Nilambur	\N	\N	679333
846	Karulai B.O		Malappuram	KERALA	Nilambur	\N	\N	679330
847	Karuvambram S.O		Malappuram	KERALA	Manjeri	\N	\N	676123
848	Kizhattur B.O		Malappuram	KERALA	Perintalmanna	\N	\N	679325
849	Kondotti S.O		Malappuram	KERALA	Ernad	\N	\N	673638
850	Koorad B.O		Malappuram	KERALA	Nilambur	\N	\N	679339
851	Malappuram Civil Station S.O		Malappuram	KERALA	Ernad	\N	\N	676505
852	Manjeri College S.O		Malappuram	KERALA	Ernad	\N	\N	676122
853	Narukara B.O		Malappuram	KERALA	Ernad	\N	\N	676122
854	Nilambur RS S.O		Malappuram	KERALA	Nilambur	\N	\N	679330
855	Omanur B.O		Malappuram	KERALA	Ernad	\N	\N	673645
856	Panga B.O		Malappuram	KERALA	Perintalmanna	\N	\N	679338
857	Pattikkad S.O		Malappuram	KERALA	Perintalmanna	\N	\N	679325
858	Pookkottur S.O		Malappuram	KERALA	Ernad	\N	\N	676517
859	Puliyakkode B.O		Malappuram	KERALA	Ernad	\N	\N	673641
860	Pullancheri B.O		Malappuram	KERALA	Ernad	\N	\N	676122
861	Pullengode B.O		Malappuram	KERALA	Nilambur	\N	\N	676525
862	Pulvetta B.O		Malappuram	KERALA	Nilambur	\N	\N	676523
863	Ramapuram B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679321
864	Thachinganadam B.O		Malappuram	KERALA	Perintalmanna	\N	\N	679325
865	Valambur B.O		Malappuram	KERALA	Perintalmanna	\N	\N	679325
866	Valluvangad B.O		Malappuram	KERALA	Ernad	\N	\N	676521
867	Valluvangad South B.O		Malappuram	KERALA	Ernad	\N	\N	676521
868	Vazhakkad S.O		Malappuram	KERALA	Ernad	\N	\N	673640
869	Velliyanchery B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679326
870	Vengad B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679338
871	Vengoor B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679325
872	Amayur B.O		Malappuram	KERALA	Ernad	\N	\N	676123
873	Andiyoorkunnu B.O		Malappuram	KERALA	Ernad	\N	\N	673637
874	Arimanal B.O		Malappuram	KERALA	Nilambur	\N	\N	676525
875	Aripra B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679321
876	Chelakkad B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679323
877	Chenakkalangadi B.O		Malappuram	KERALA	Tirurangadi	\N	\N	673636
878	Chikkode B.O		Malappuram	KERALA	Ernad	\N	\N	673645
879	Chungathara S.O		Malappuram	KERALA	Nilambur	\N	\N	679334
880	Edayattur B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679326
881	Irumbuzhi B.O		Malappuram	KERALA	Ernad	\N	\N	676509
882	Kalkundu B.O		Malappuram	KERALA	Nilambur	\N	\N	676523
883	Karumarakkad B.O		Malappuram	KERALA	Ernad	\N	\N	673640
884	Kerala Estate B.O		Malappuram	KERALA	Nilambur	\N	\N	676525
885	Koottil B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679324
886	Kumminiparamba B.O		Malappuram	KERALA	Tirurangadi	\N	\N	673638
887	Maithra B.O		Malappuram	KERALA	Ernad	\N	\N	673639
888	Mampad College B.O		Malappuram	KERALA	Nilambur	\N	\N	676542
889	Mankada Pallippuram B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679324
890	Mannarmala B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679325
891	Marutha B.O		Malappuram	KERALA	Nilambur	\N	\N	679333
892	Munduparmba S.O		Malappuram	KERALA	Ernad	\N	\N	676509
893	Nilambur S.O		Malappuram	KERALA	Nilambur	\N	\N	679329
894	Palakkalvetta B.O		Malappuram	KERALA	Nilambur	\N	\N	679327
895	Pariyapuram B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679321
896	Perimbalam B.O		Malappuram	KERALA	Ernad	\N	\N	676509
897	Puthanangadi B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679321
898	Ramankuth B.O		Malappuram	KERALA	Nilambur	\N	\N	679330
899	Talekode B.O		Malappuram	KERALA	Perintalmanna	\N	\N	679322
900	Tharis B.O		Malappuram	KERALA	Nilambur	\N	\N	676523
901	Thootha B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679357
902	Tuvvur S.O		Malappuram	KERALA	Nilambur	\N	\N	679327
903	Urangattiri B.O		Malappuram	KERALA	Ernad	\N	\N	673639
904	Valapuram B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679323
905	Vazhenkada B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679357
906	Vellayur B.O		Malappuram	KERALA	Nilambur	\N	\N	679327
907	Vettathur B.O		Malappuram	KERALA	Perintalmanna	\N	\N	679326
908	Areacode S.O		Malappuram	KERALA	Ernad	\N	\N	673639
909	Arimbra B.O		Malappuram	KERALA	Ernad	\N	\N	673638
910	Chathallur B.O		Malappuram	KERALA	Ernad	\N	\N	676541
911	Cherakkaparamba B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679321
912	Edivanna B.O		Malappuram	KERALA	Nilambur	\N	\N	679329
913	Eranhimangad B.O		Malappuram	KERALA	Nilambur	\N	\N	679329
914	Kappil B.O		Malappuram	KERALA	Nilambur	\N	\N	679328
915	Karakkunnu B.O		Malappuram	KERALA	Ernad	\N	\N	676123
916	Kavanur B.O		Malappuram	KERALA	Ernad	\N	\N	673639
917	Kolakkattuchali B.O		Malappuram	KERALA	Tirurangadi	\N	\N	673634
918	Kurumbalangode B.O		Malappuram	KERALA	Nilambur	\N	\N	679334
919	Kuruvambalam B.O		Malappuram	KERALA	Perintalmanna	\N	\N	679338
920	Malappuram H.O		Malappuram	KERALA	Ernad	\N	\N	676505
921	Manjeri Bazar S.O		Malappuram	KERALA	Ernad	\N	\N	676121
922	Munda B.O		Malappuram	KERALA	Nilambur	\N	\N	679331
923	Naduvath B.O		Malappuram	KERALA	Nilambur	\N	\N	679328
924	Padinhattumuri B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	676506
925	Padirikode B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679326
926	Palachode B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679338
927	Pathiriyal B.O		Malappuram	KERALA	Nilambur	\N	\N	676123
928	Theyyathumpadam B.O		Malappuram	KERALA	Nilambur	\N	\N	679331
929	Thottumukkam B.O		Malappuram	KERALA	Ernad	\N	\N	673639
930	Vakkethodi B.O		Malappuram	KERALA	Ernad	\N	\N	676122
931	Valamkulam B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679357
932	Vaniyambalam S.O		Malappuram	KERALA	Nilambur	\N	\N	679339
933	Akkaparamba B.O		Malappuram	KERALA	Ernad	\N	\N	673641
934	Amarambalam South B.O		Malappuram	KERALA	Nilambur	\N	\N	679339
935	Chembrasseri East B.O		Malappuram	KERALA	Ernad	\N	\N	679327
936	Cheruvayur S.O		Malappuram	KERALA	Ernad	\N	\N	673645
937	Chulliyode B.O		Malappuram	KERALA	Nilambur	\N	\N	679332
938	Eranhikode B.O		Malappuram	KERALA	Ernad	\N	\N	676541
939	Ezhupathekkar B.O		Malappuram	KERALA	Nilambur	\N	\N	676525
940	Iruvetti B.O		Malappuram	KERALA	Ernad	\N	\N	673639
941	Kadambode B.O		Malappuram	KERALA	Ernad	\N	\N	676521
942	Kolaparamba S.O		Malappuram	KERALA	Ernad	\N	\N	676522
943	Kottilangadi S.O		Malappuram	KERALA	Perintalmanna	\N	\N	676506
944	Kunnappally B.O		Malappuram	KERALA	Perintalmanna	\N	\N	679322
945	Mattarakkal B.O		Malappuram	KERALA	Perintalmanna	\N	\N	679322
946	Melattur S.O (Malappuram)		Malappuram	KERALA	Perintalmanna	\N	\N	679326
947	Morayur B.O		Malappuram	KERALA	Ernad	\N	\N	673642
948	Nambooripotty B.O		Malappuram	KERALA	Nilambur	\N	\N	679333
949	Nediyirippu B.O		Malappuram	KERALA	Ernad	\N	\N	673638
950	Nellikuth B.O		Malappuram	KERALA	Ernad	\N	\N	676122
951	Olavattur B.O		Malappuram	KERALA	Ernad	\N	\N	673638
952	Oorakam Melmuri B.O		Malappuram	KERALA	Tirurangadi	\N	\N	676519
953	Pandikkad S.O		Malappuram	KERALA	Ernad	\N	\N	676521
954	Pathar B.O		Malappuram	KERALA	Nilambur	\N	\N	679334
955	Perintalmanna Bazar S.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679322
956	Perintalmanna S.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679322
957	Pulamanthole S.O		Malappuram	KERALA	Perintalmanna	\N	\N	679323
958	Puthur-pallikkal B.O		Malappuram	KERALA	Tirurangadi	\N	\N	673636
959	Thelakkad B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679325
960	Thottilangadi B.O		Malappuram	KERALA	Ernad	\N	\N	673639
961	Valiyaparamba B.O		Malappuram	KERALA	Ernad	\N	\N	673637
962	Valluvambram B.O		Malappuram	KERALA	Ernad	\N	\N	673642
963	Adakkakundu B.O		Malappuram	KERALA	Nilambur	\N	\N	676525
964	Ambalakkadavu B.O		Malappuram	KERALA	Nilambur	\N	\N	676525
965	Angadipuram S.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679321
966	Arkkuparamba B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679322
967	Chemmaniyode B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679325
968	Cherukara S.O		Malappuram	KERALA	Perintalmanna	\N	\N	679340
969	Kodur-malabar S.O		Malappuram	KERALA	Perintalmanna	\N	\N	676504
970	Kolathur-MLP S.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679338
971	Kunnakkavu B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679340
972	Kuttathy B.O		Malappuram	KERALA	Nilambur	\N	\N	676523
973	Manalaya B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679357
974	Manjeri-kla H.O		Malappuram	KERALA	Ernad	\N	\N	676121
975	Mannathipoyil B.O		Malappuram	KERALA	Nilambur	\N	\N	679332
976	Meppadam B.O		Malappuram	KERALA	Nilambur	\N	\N	676542
977	Olamathil B.O		Malappuram	KERALA	Ernad	\N	\N	673642
978	Oorakam Kizhumuri B.O		Malappuram	KERALA	Tirurangadi	\N	\N	676519
979	Palemad B.O		Malappuram	KERALA	Nilambur	\N	\N	679331
980	Panampilavu B.O		Malappuram	KERALA	Ernad	\N	\N	673639
981	Pandallur Hills B.O		Malappuram	KERALA	Ernad	\N	\N	676521
982	Panga South B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679338
983	Pappinippara B.O		Malappuram	KERALA	Ernad	\N	\N	676122
984	Pookkottumpadam S.O		Malappuram	KERALA	Nilambur	\N	\N	679332
985	Pullippadam B.O		Malappuram	KERALA	Nilambur	\N	\N	676542
986	Punnappala B.O		Malappuram	KERALA	Nilambur	\N	\N	679328
987	T.K.Colony B.O		Malappuram	KERALA	Nilambur	\N	\N	679332
988	Tavanur-feroke B.O		Malappuram	KERALA	Ernad	\N	\N	673641
989	Valillapuzha B.O		Malappuram	KERALA	Ernad	\N	\N	673639
990	Vallikkapatta B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679324
991	Vellila B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679324
992	Vellur B.O		Malappuram	KERALA	Ernad	\N	\N	676517
993	Vilayil B.O		Malappuram	KERALA	Ernad	\N	\N	673641
994	Anakkayam B.O		Malappuram	KERALA	Ernad	\N	\N	676509
995	Anamangad S.O		Malappuram	KERALA	Perintalmanna	\N	\N	679357
996	Anchachavady B.O		Malappuram	KERALA	Nilambur	\N	\N	676525
997	Chemmalasseri B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679323
998	Chirayil B.O		Malappuram	KERALA	Ernad	\N	\N	673638
999	Downhill S.O		Malappuram	KERALA	Ernad	\N	\N	676519
1000	Edapatta B.O		Malappuram	KERALA	Perintalmanna	\N	\N	679326
1001	Karippur B.O		Malappuram	KERALA	Tirurangadi	\N	\N	673638
1002	Karuvarakundu S.O		Malappuram	KERALA	Nilambur	\N	\N	676523
1003	Kavalamukkatta B.O		Malappuram	KERALA	Nilambur	\N	\N	679332
1004	Kizhakkumpadam B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	679326
1005	Kizhuparamba B.O		Malappuram	KERALA	Ernad	\N	\N	673639
1006	Koomankulam B.O		Malappuram	KERALA	Ernad	\N	\N	676123
1007	Kunnummalpotti B.O		Malappuram	KERALA	Nilambur	\N	\N	679331
1008	Kuzhimanna S.O		Malappuram	KERALA	Ernad	\N	\N	673641
1009	Mampad S.O		Malappuram	KERALA	Nilambur	\N	\N	676542
1010	Manimooly S.O		Malappuram	KERALA	Nilambur	\N	\N	679333
1011	Mankada S.O		Malappuram	KERALA	Perintalmanna	\N	\N	679324
1012	Melangadi B.O		Malappuram	KERALA	Ernad	\N	\N	673638
1013	Mundakkal B.O		Malappuram	KERALA	Ernad	\N	\N	673645
1014	Palakkad(MLP) B.O		Malappuram	KERALA	Ernad	\N	\N	673641
1015	Pannippara B.O		Malappuram	KERALA	Ernad	\N	\N	676541
1016	Pathappiriyam B.O		Malappuram	KERALA	Ernad	\N	\N	676123
1017	Pattarkadavu B.O		Malappuram	KERALA	Ernad	\N	\N	676519
1018	Pazhamallur B.O		Malappuram	KERALA	Perinthalmanna	\N	\N	676506
1019	Peruvallur B.O		Malappuram	KERALA	Tirurangadi	\N	\N	673638
1020	Poolamanna B.O		Malappuram	KERALA	Ernad	\N	\N	679327
1021	Porur B.O		Malappuram	KERALA	Ernad	\N	\N	679339
1022	Tenhipalam S.O		Malappuram	KERALA	Tirurangadi	\N	\N	673636
1023	Trikkalangode B.O		Malappuram	KERALA	Ernad	\N	\N	676123
1024	Akalur B.O		Palakkad	KERALA	Ottapalam	\N	\N	679302
1025	Chalavara S.O		Palakkad	KERALA	Ottappalam	\N	\N	679505
1026	Chavadiyur B.O		Palakkad	KERALA	Mannarkad	\N	\N	678581
1027	Cherambattakavu B.O		Palakkad	KERALA	NA	\N	\N	679501
1028	Cherukutangad B.O		Palakkad	KERALA	Ottappalam	\N	\N	679305
1029	Etapalam B.O		Palakkad	KERALA	Ottappalam	\N	\N	679308
1030	Kaipuram B.O		Palakkad	KERALA	Ottappalam	\N	\N	679308
1031	Karimpuzha B.O		Palakkad	KERALA	Ottappalam	\N	\N	679513
1032	Kayiliad B.O		Palakkad	KERALA	Ottappalam	\N	\N	679122
1033	Kolikkottusseri B.O		Palakkad	KERALA	Ottappalam	\N	\N	679303
1034	Koottanad		Palakkad	KERALA	Ottappalam	\N	\N	679533
1035	Kottapadam(TTL) B.O		Palakkad	KERALA	Mannarkad	\N	\N	679534
1036	Kottappuram B.O		Palakkad	KERALA	Ottappalam	\N	\N	679513
1037	Kottathara B.O		Palakkad	KERALA	Mannarkad	\N	\N	678581
1038	Kudallur S.O		Palakkad	KERALA	Ottappalam	\N	\N	679554
1039	Kulappulli B.O		Palakkad	KERALA	Ottapalam	\N	\N	679122
1040	Kunduvampadam B.O		Palakkad	KERALA	Palakkad	\N	\N	678633
1041	Mannampatta B.O		Palakkad	KERALA	Ottappalam	\N	\N	678633
1042	Melmuri B.O		Palakkad	KERALA	Ottapalam	\N	\N	679307
1043	Melur B.O		Palakkad	KERALA	Ottapalam	\N	\N	679501
1044	Mudukurissi B.O		Palakkad	KERALA	Ottapalam	\N	\N	678593
1045	Munnurkode B.O		Palakkad	KERALA	Ottapalam	\N	\N	679502
1046	Naduvattom S.O		Palakkad	KERALA	Ottapalam	\N	\N	679308
1047	Nagalassery B.O		Palakkad	KERALA	Ottappalam	\N	\N	679533
1048	Nellikattiri B.O		Palakkad	KERALA	Ottappalam	\N	\N	679533
1049	Sankaramangalam B.O		Palakkad	KERALA	NA	\N	\N	679303
1050	Thirunayanapuram B.O		Palakkad	KERALA	NA	\N	\N	679514
1051	Thiruvegapura S.O		Palakkad	KERALA	Ottappalam	\N	\N	679304
1052	Valambillimangalam B.O		Palakkad	KERALA	Ottappalam	\N	\N	679513
1053	Vallapuzha S.O		Palakkad	KERALA	Ottappalam	\N	\N	679336
1054	Amayur B.O		Palakkad	KERALA	Ottappalam	\N	\N	679303
1055	Ambalapara S.O		Palakkad	KERALA	Ottappalam	\N	\N	679512
1056	Ambalavattom B.O		Palakkad	KERALA	Ottappalam	\N	\N	679501
1057	Chaliyattiri B.O		Palakkad	KERALA	Ottappalam	\N	\N	679535
1058	Cherottur B.O		Palakkad	KERALA	Ottappalam	\N	\N	679521
1059	Kacheriparamba B.O		Palakkad	KERALA	Mannarkad	\N	\N	678601
1060	Kalladathur B.O		Palakkad	KERALA	Ottappalam	\N	\N	679552
1061	Kanhirapuzha Dam B.O		Palakkad	KERALA	Mannarkad	\N	\N	678591
1062	Karattukurissi B.O		Palakkad	KERALA	Ottappalam	\N	\N	679503
1063	Kavalappara S.O		Palakkad	KERALA	Ottappalam	\N	\N	679523
1064	Kothachira B.O		Palakkad	KERALA	Ottappalam	\N	\N	679535
1065	Kulakkad B.O		Palakkad	KERALA	Ottappalam	\N	\N	679503
1066	Kumbidi S.O		Palakkad	KERALA	Ottappalam	\N	\N	679553
1067	Kundurkunnu B.O		Palakkad	KERALA	Mannarkkad	\N	\N	678583
1068	Mannanur B.O		Palakkad	KERALA	Ottappalam	\N	\N	679523
1069	Mattathukad B.O		Palakkad	KERALA	Mannarkkad	\N	\N	678581
1070	Melepattambi S.O		Palakkad	KERALA	Ottappalam	\N	\N	679306
1071	Moonnekkar B.O		Palakkad	KERALA	Ottapalam	\N	\N	678597
1072	Mundakkottukurissi B.O		Palakkad	KERALA	Ottapalam	\N	\N	679122
1073	Pattambi S.O		Palakkad	KERALA	Ottappalam	\N	\N	679303
1074	Perimbadari S.O		Palakkad	KERALA	Mannarkad	\N	\N	678762
1075	S G Press S.O		Palakkad	KERALA	Ottapalam	\N	\N	679122
1076	Thottakkara S.O		Palakkad	KERALA	Ottappalam	\N	\N	679102
1077	Trikkatiri S.O		Palakkad	KERALA	Ottappalam	\N	\N	679502
1078	Vakkadapuram B.O		Palakkad	KERALA	NA	\N	\N	678595
1079	Angadi B.O		Palakkad	KERALA	Ottappalam	\N	\N	679552
1080	Bhimanad B.O		Palakkad	KERALA	Mannarkad	\N	\N	678601
1081	Chembra B.O		Palakkad	KERALA	Ottappalam	\N	\N	679304
1082	Cherukattupulam B.O		Palakkad	KERALA	Ottappalam	\N	\N	679522
1083	Chunangad S.O		Palakkad	KERALA	Ottappalam	\N	\N	679511
1084	Elambulasseri B.O		Palakkad	KERALA	Ottappalam	\N	\N	678595
1085	Kadambur S.O (Palakkad)		Palakkad	KERALA	Ottappalam	\N	\N	679515
1086	Kanhirapuzha S.O		Palakkad	KERALA	Mannarkad	\N	\N	678591
1087	Karumanamkurissi B.O		Palakkad	KERALA	Ottappalam	\N	\N	679504
1088	Kulakkattukurissi B.O		Palakkad	KERALA	Ottapalam	\N	\N	678633
1089	Kumaramputhur B.O		Palakkad	KERALA	Mannarkkad	\N	\N	678583
1090	Malamalkkavu B.O		Palakkad	KERALA	Ottapalam	\N	\N	679554
1091	Mannarkad College S.O		Palakkad	KERALA	Mannarkad	\N	\N	678583
1092	Mukkali B.O		Palakkad	KERALA	Mannarkad	\N	\N	678582
1093	Palappuram S.O		Palakkad	KERALA	Ottappalam	\N	\N	679103
1094	Panamanna South B.O		Palakkad	KERALA	Ottappalam	\N	\N	679501
1095	Panayur B.O		Palakkad	KERALA	Ottapalam	\N	\N	679522
1096	Pattithara B.O		Palakkad	KERALA	Ottappalam	\N	\N	679534
1097	Poonchola B.O		Palakkad	KERALA	Mannarkad	\N	\N	678598
1098	Puliyanamkunnu B.O		Palakkad	KERALA	Ottappalam	\N	\N	679505
1099	Taruvakonam B.O		Palakkad	KERALA	NA	\N	\N	679501
1100	Tenkara B.O		Palakkad	KERALA	Mannarkkad	\N	\N	678582
1101	Thekke Vavanoor B.O		Palakkad	KERALA	NA	\N	\N	679533
1102	Thrikallur B.O		Palakkad	KERALA	Mannarkad	\N	\N	678593
1103	Uppukulam B.O		Palakkad	KERALA	Mannarkad	\N	\N	678601
1104	Vaniamkulam S.O		Palakkad	KERALA	Ottappalam	\N	\N	679522
1105	Varode B.O		Palakkad	KERALA	Ottappalam	\N	\N	679102
1106	Vellinezhi S.O		Palakkad	KERALA	Ottappalam	\N	\N	679504
1107	Ariyur B.O		Palakkad	KERALA	Mannarkad	\N	\N	678583
1108	Cherpalcheri S.O		Palakkad	KERALA	Ottappalam	\N	\N	679503
1109	Choorakode B.O		Palakkad	KERALA	Ottappalam	\N	\N	679336
1110	K A Samajam B.O		Palakkad	KERALA	Ottapalam	\N	\N	679123
1111	Kaithachira B.O		Palakkad	KERALA	NA	\N	\N	678582
1112	Kalladikode S.O		Palakkad	KERALA	Mannarkkad	\N	\N	678596
1113	Kalladipatta S.O		Palakkad	KERALA	Ottapalam	\N	\N	679313
1114	Kallipadam B.O		Palakkad	KERALA	Ottapalam	\N	\N	679122
1115	Kanhikulam B.O		Palakkad	KERALA	Palakkad	\N	\N	678596
1116	Kattukulam B.O		Palakkad	KERALA	Ottappalam	\N	\N	679514
1117	Kilmuri B.O		Palakkad	KERALA	Ottappalam	\N	\N	679307
1118	Kottopadam B.O		Palakkad	KERALA	Ottappalam	\N	\N	678583
1119	Kulukkallur S.O		Palakkad	KERALA	Ottappalam	\N	\N	679337
1120	Kumaranellur S.O		Palakkad	KERALA	Ottappalam	\N	\N	679552
1121	Mangalam(OPM) B.O		Palakkad	KERALA	Ottappalam	\N	\N	679301
1122	Manisseri S.O		Palakkad	KERALA	Ottapalam	\N	\N	679521
1123	Mannengode B.O		Palakkad	KERALA	Ottappalam	\N	\N	679307
1124	Marayamangalam B.O		Palakkad	KERALA	Ottappalam	\N	\N	679335
1125	Met Ind Nagar B.O		Palakkad	KERALA	Ottapalam	\N	\N	679122
1126	Mulanhur B.O		Palakkad	KERALA	Ottapalam	\N	\N	679511
1127	Othalur - Ttl B.O		Palakkad	KERALA	Ottapalam	\N	\N	679534
1128	Ottapalam H.O		Palakkad	KERALA	Ottapalam	\N	\N	679101
1129	Pallikunnu B.O		Palakkad	KERALA	Mannarkad Q	\N	\N	678583
1130	Pallikurup B.O		Palakkad	KERALA	Mannarkad	\N	\N	678593
1131	Pathankulam B.O		Palakkad	KERALA	Ottappalam	\N	\N	679522
1132	Pulappatta S.O		Palakkad	KERALA	Ottappalam	\N	\N	678632
1133	Sholayur-PKD B.O		Palakkad	KERALA	NA	\N	\N	678581
1134	Shornur S.O		Palakkad	KERALA	Ottapalam	\N	\N	679121
1135	Srikrishnapuram S.O		Palakkad	KERALA	Ottappalam	\N	\N	679513
1136	Thanneercode B.O		Palakkad	KERALA	Ottapalam	\N	\N	679536
1137	Vadanamkurussi B.O		Palakkad	KERALA	Ottappalam	\N	\N	679121
1138	Vettakara B.O		Palakkad	KERALA	Ottappalam	\N	\N	678633
1139	Chalisseri S.O		Palakkad	KERALA	Ottappalam	\N	\N	679536
1140	Cherukode B.O		Palakkad	KERALA	Ottappalam	\N	\N	679336
1141	Chethallur B.O		Palakkad	KERALA	Mannarkad	\N	\N	678583
1142	Chindaki B.O		Palakkad	KERALA	Mannarkad	\N	\N	678582
1143	Gandhi Seva  Sadan B.O		Palakkad	KERALA	Ottappalam	\N	\N	679302
1144	Irimbalasseri B.O		Palakkad	KERALA	Ottapalam	\N	\N	679335
1145	Jellipara B.O		Palakkad	KERALA	Mannarkkad	\N	\N	678581
1146	Kalluvazhi B.O		Palakkad	KERALA	Ottappalam	\N	\N	679514
1147	Kappur B.O		Palakkad	KERALA	Ottapalam	\N	\N	679552
1148	Karara B.O		Palakkad	KERALA	Mannarkad	\N	\N	678581
1149	Karkitamkunnu B.O		Palakkad	KERALA	Mannarkad	\N	\N	678601
1150	Katambazhipuram S.O		Palakkad	KERALA	Ottappalam	\N	\N	678633
1151	Konikazhi B.O		Palakkad	KERALA	Ottappalam	\N	\N	678632
1152	Kuruvattur B.O		Palakkad	KERALA	Ottpalam	\N	\N	679336
1153	Lakkidi S.O		Palakkad	KERALA	Ottappalam	\N	\N	679301
1154	Marayamangalam South B.O		Palakkad	KERALA	Ottappalam	\N	\N	679335
1155	Nattukal B.O		Palakkad	KERALA	Mannarkad	\N	\N	678583
1156	Palakayam B.O		Palakkad	KERALA	Mannarkkad	\N	\N	678591
1157	Paloor B.O		Palakkad	KERALA	Mannarkkad	\N	\N	678582
1158	Peringannur B.O		Palakkad	KERALA	Ottapalam	\N	\N	679535
1159	Perur-OPM S.O		Palakkad	KERALA	Ottappalam	\N	\N	679302
1160	Pombra B.O		Palakkad	KERALA	Ottappalam	\N	\N	678595
1161	Pullisseri B.O		Palakkad	KERALA	Mannarkad	\N	\N	678582
1162	Thekkumuri (CPL) B.O		Palakkad	KERALA	NA	\N	\N	679506
1163	Thirumittakode B.O		Palakkad	KERALA	Ottappalam	\N	\N	679533
1164	Tiruvalamkunnu B.O		Palakkad	KERALA	NA	\N	\N	678601
1165	Veetampara B.O		Palakkad	KERALA	Ottappalam	\N	\N	679102
1166	Vilathur B.O		Palakkad	KERALA	Ottappalam	\N	\N	679304
1167	Cherumundasseri B.O		Palakkad	KERALA	Ottapalam	\N	\N	679512
1168	Ezhuvanthala B.O		Palakkad	KERALA	Ottappalam	\N	\N	679335
1169	Kandamangalam B.O		Palakkad	KERALA	Mannarkkad	\N	\N	678583
1170	Kanniampuram S.O		Palakkad	KERALA	Ottappalam	\N	\N	679104
1171	Kavundikkal B.O		Palakkad	KERALA	Mannarkad	\N	\N	678581
1172	Kodakkad B.O		Palakkad	KERALA	Mannarkkad	\N	\N	678583
1173	Kuttanasseri B.O		Palakkad	KERALA	Ottappalam	\N	\N	679514
1174	Mangode B.O		Palakkad	KERALA	Ottappalam	\N	\N	679503
1175	Mannarkkad S.O		Palakkad	KERALA	Mannarkkad	\N	\N	678582
1176	Muduthala B.O		Palakkad	KERALA	Ottappalam	\N	\N	679303
1177	Mulayankavu B.O		Palakkad	KERALA	Ottappalam	\N	\N	679337
1178	Nhangattiri B.O		Palakkad	KERALA	Ottappalam	\N	\N	679303
1179	Pallipuram S.O (Palakkad)		Palakkad	KERALA	Ottappalam	\N	\N	679305
1180	Parudur B.O		Palakkad	KERALA	Ottappalam	\N	\N	679305
1181	Payyanadam B.O		Palakkad	KERALA	Mannarkad	\N	\N	678583
1182	Perumannur B.O		Palakkad	KERALA	Ottappalam	\N	\N	679536
1183	Punchapadam B.O		Palakkad	KERALA	Ottappalam	\N	\N	678633
1184	Thavalam B.O		Palakkad	KERALA	Mannarkad	\N	\N	678582
1185	Vazhumbram B.O		Palakkad	KERALA	NA	\N	\N	678595
1186	Veeramangalam B.O		Palakkad	KERALA	Ottappalam	\N	\N	679503
1187	Vilayur S.O		Palakkad	KERALA	Ottappalam	\N	\N	679309
1188	Vilayur West B.O		Palakkad	KERALA	NA	\N	\N	679309
1189	Viyyakurissi B.O		Palakkad	KERALA	NA	\N	\N	678593
1190	Agali S.O (Palakkad)		Palakkad	KERALA	Mannarkad	\N	\N	678581
1191	Alanallur S.O		Palakkad	KERALA	Mannarkad	\N	\N	678601
1192	Anakkara S.O (Palakkad)		Palakkad	KERALA	Ottappalam	\N	\N	679551
1193	Attasseri B.O		Palakkad	KERALA	NA	\N	\N	679513
1194	Azhiyannur B.O		Palakkad	KERALA	Ottapalam	\N	\N	678633
1195	Changileri B.O		Palakkad	KERALA	Mannarkad	\N	\N	678762
1196	Chittur -agali B.O		Palakkad	KERALA	Mannarkad	\N	\N	678581
1197	Edakode(Pavukonam) B.O		Palakkad	KERALA	Ottappalam	\N	\N	679522
1198	Edathanttukara B.O		Palakkad	KERALA	Mannarkad	\N	\N	678601
1199	Ganeshgiri S.O		Palakkad	KERALA	Ottapalam	\N	\N	679123
1200	Kalkandi B.O		Palakkad	KERALA	Mannarkad	\N	\N	678582
1201	Kallamala B.O		Palakkad	KERALA	Mannarkad	\N	\N	678582
1202	Karakurissi S.O		Palakkad	KERALA	Mannarkad	\N	\N	678595
1203	Karimba S.O		Palakkad	KERALA	Mannarkad	\N	\N	678597
1204	Kattukulam South B.O		Palakkad	KERALA	Ottapalam	\N	\N	679514
1205	Kizhayur B.O		Palakkad	KERALA	Ottappalam	\N	\N	679303
1206	Kizhur B.O		Palakkad	KERALA	Ottappalam	\N	\N	679501
1207	Koonathara B.O		Palakkad	KERALA	Ottappalam	\N	\N	679523
1208	Mala B.O		Palakkad	KERALA	Ottapalam	\N	\N	679534
1209	Nedungottur B.O		Palakkad	KERALA	Ottappalam	\N	\N	679308
1210	Nellaya S.O		Palakkad	KERALA	Ottappalam	\N	\N	679335
1211	Palode B.O		Palakkad	KERALA	Mannarkad	\N	\N	678583
1212	Panamanna S.O		Palakkad	KERALA	Ottappalam	\N	\N	679501
1213	Peringode S.O		Palakkad	KERALA	Ottappalam	\N	\N	679535
1214	Perumudiyur B.O		Palakkad	KERALA	Ottapalam	\N	\N	679303
1215	Pombilaya B.O		Palakkad	KERALA	Ottappalam	\N	\N	679335
1216	Pottasseri S.O		Palakkad	KERALA	Mannarkad	\N	\N	678598
1217	Pulasseri S.O		Palakkad	KERALA	Ottappalam	\N	\N	679307
1218	Thalakkasseri B.O		Palakkad	KERALA	Ottappalam	\N	\N	679534
1219	Thathanampully B.O		Palakkad	KERALA	NA	\N	\N	679337
1220	Thiruvazhiyode S.O		Palakkad	KERALA	Ottappalam	\N	\N	679514
1221	Ummanazhi B.O		Palakkad	KERALA	NA	\N	\N	678632
1222	Vattamannapuram B.O		Palakkad	KERALA	NA	\N	\N	678601
1223	Vengasseri S.O		Palakkad	KERALA	Ottappalam	\N	\N	679516
1224	Adakkaputhur B.O		Palakkad	KERALA	Ottappalam	\N	\N	679503
1225	Alangad B.O		Palakkad	KERALA	Ottappalam	\N	\N	678633
1226	Chathanur B.O		Palakkad	KERALA	Ottapalam	\N	\N	679535
1227	Chundampatta B.O		Palakkad	KERALA	Ottappalam	\N	\N	679337
1228	Eravakkad B.O		Palakkad	KERALA	Ottappalam	\N	\N	679552
1229	Irimbakachola B.O		Palakkad	KERALA	Mannarkad	\N	\N	678591
1230	Kanayam B.O		Palakkad	KERALA	Ottapalam	\N	\N	679122
1231	Karalmanna S.O		Palakkad	KERALA	Ottappalam	\N	\N	679506
1232	Karambathur B.O		Palakkad	KERALA	Ottapalam.	\N	\N	679305
1233	Kodumunda B.O		Palakkad	KERALA	Ottappalam	\N	\N	679303
1234	Kondurkara B.O		Palakkad	KERALA	Ottapalam	\N	\N	679313
1235	Maruthur B.O		Palakkad	KERALA	Ottappalam	\N	\N	679306
1236	Mezhathur B.O		Palakkad	KERALA	Ottappalam	\N	\N	679534
1237	Panniyamkurissi B.O		Palakkad	KERALA	Ottappalam	\N	\N	679503
1238	Paruthipra B.O		Palakkad	KERALA	Ottpalam	\N	\N	679121
1239	Pudur B.O		Palakkad	KERALA	Mannarkad	\N	\N	678581
1240	Sreeramakrishnanagar B.O		Palakkad	KERALA	Ottappalam	\N	\N	679103
1241	Tachampara S.O		Palakkad	KERALA	Mannarkad	\N	\N	678593
1242	Trithala S.O		Palakkad	KERALA	Ottappalam	\N	\N	679534
1243	Attempathy B.O		Palakkad	KERALA	Chittur	\N	\N	678556
1244	Ayakkad B.O		Palakkad	KERALA	Alathur	\N	\N	678683
1245	Ayalur S.O		Palakkad	KERALA	Chittur	\N	\N	678510
1246	Chandranagar S.O		Palakkad	KERALA	Palakkad	\N	\N	678007
1247	Chandrasekharapuram B.O		Palakkad	KERALA	Palakkad	\N	\N	678611
1248	Chittilancheri S.O		Palakkad	KERALA	Alathur	\N	\N	678704
1249	Edathara S.O		Palakkad	KERALA	Palakkad	\N	\N	678611
1250	Elavancheri B.O		Palakkad	KERALA	Chittur	\N	\N	678508
1251	Kalapatti B.O		Palakkad	KERALA	Alathur	\N	\N	678702
1252	Karingarapully B.O		Palakkad	KERALA	Palakkad	\N	\N	678551
1253	Karippali B.O		Palakkad	KERALA	Chittur	\N	\N	678532
1254	Kattusseri B.O		Palakkad	KERALA	Alatur	\N	\N	678542
1255	Keralasseri S.O		Palakkad	KERALA	Palakkad	\N	\N	678641
1256	Kottekkad S.O		Palakkad	KERALA	Palakkad	\N	\N	678732
1257	Kozhipara S.O		Palakkad	KERALA	Chittur	\N	\N	678557
1258	Kudallur B.O		Palakkad	KERALA	Alathur	\N	\N	678688
1259	Kunisseri S.O		Palakkad	KERALA	Alathur	\N	\N	678681
1260	Kuttipallam B.O		Palakkad	KERALA	Chittur	\N	\N	678101
1261	Mangalam Dam B.O		Palakkad	KERALA	Alathur	\N	\N	678706
1262	Manikkasseri B.O		Palakkad	KERALA	Palakkad	\N	\N	678631
1263	Mannalur B.O		Palakkad	KERALA	Palakkad	\N	\N	678502
1264	Mulangot B.O		Palakkad	KERALA	Alathur	\N	\N	678684
1265	Nemmara S.O		Palakkad	KERALA	Chittur	\N	\N	678508
1266	Olalapadi B.O		Palakkad	KERALA	Chittur	\N	\N	678557
1267	Palakkad Engineering College S.O		Palakkad	KERALA	Palakkad	\N	\N	678008
1268	Palakkad Fort S.O		Palakkad	KERALA	Palakkad	\N	\N	678001
1269	Perinkunnu B.O		Palakkad	KERALA	Alathur	\N	\N	678702
1270	Puthur-palakkad B.O		Palakkad	KERALA	Palakkad	\N	\N	678005
1271	Sekharipuram S.O		Palakkad	KERALA	Palakkad	\N	\N	678010
1272	Tenari B.O		Palakkad	KERALA	Palakkad	\N	\N	678622
1273	Tolanur S.O		Palakkad	KERALA	Alathur	\N	\N	678722
1274	Vadavannur S.O		Palakkad	KERALA	Chittur	\N	\N	678504
1275	Varode-kottayi B.O		Palakkad	KERALA	Alathur	\N	\N	678572
1276	Velanthavalam B.O		Palakkad	KERALA	Chittur	\N	\N	678557
1277	Velikkad B.O		Palakkad	KERALA	Palakkad	\N	\N	678592
1278	Chithali B.O		Palakkad	KERALA	Alathur	\N	\N	678702
1279	Chittur Courts B.O		Palakkad	KERALA	Chittur	\N	\N	678101
1280	Chokkanathapuram S.O		Palakkad	KERALA	Palakkad	\N	\N	678005
1281	Kanakkanthuruthy B.O		Palakkad	KERALA	Alathur	\N	\N	678683
1282	Kanimangalam B.O		Palakkad	KERALA	Chittur	\N	\N	678508
1283	Kanjikode West S.O		Palakkad	KERALA	Palakkad	\N	\N	678623
1284	Kannadi S.O		Palakkad	KERALA	Palakkad	\N	\N	678701
1285	Kavalpad B.O		Palakkad	KERALA	Palakkad	\N	\N	678012
1286	Kinavallur B.O		Palakkad	KERALA	Palakkad	\N	\N	678612
1287	Koduvayur Agraharam B.O		Palakkad	KERALA	Chittur	\N	\N	678501
1288	Manappadam B.O		Palakkad	KERALA	Alathur	\N	\N	678687
1289	Mankurussi B.O		Palakkad	KERALA	Palakkad	\N	\N	678613
1290	Mathur Agraharam B.O		Palakkad	KERALA	Alathur	\N	\N	678571
1291	Melarcode S.O		Palakkad	KERALA	Alathur	\N	\N	678703
1292	Nechur B.O		Palakkad	KERALA	Alathur	\N	\N	678722
1293	Nelliampathy B.O		Palakkad	KERALA	Chittur	\N	\N	678508
1294	Olasseri B.O		Palakkad	KERALA	Palakkad	\N	\N	678551
1295	Palakkad City S.O		Palakkad	KERALA	Palakkad	\N	\N	678014
1296	Palakkad Industrial Estate B.O		Palakkad	KERALA	Palakkad	\N	\N	678731
1297	Pallatheri B.O		Palakkad	KERALA	Palakkad	\N	\N	678007
1298	Panniankara B.O		Palakkad	KERALA	Alathur	\N	\N	678683
1299	Pattancheri S.O		Palakkad	KERALA	Palakkad	\N	\N	678532
1300	Peruvemba S.O		Palakkad	KERALA	Palakkad	\N	\N	678531
1301	Pudunagaram S.O		Palakkad	KERALA	Palakkad	\N	\N	678503
1302	Puthucode S.O		Palakkad	KERALA	Alathur	\N	\N	678687
1303	Thekkedesam B.O		Palakkad	KERALA	Chittur	\N	\N	678553
1304	Tirunilayi B.O		Palakkad	KERALA	Palakkad	\N	\N	678004
1305	Akathethara B.O		Palakkad	KERALA	Palakkad	\N	\N	678008
1306	Alathur Mbr H.O		Palakkad	KERALA	Alathur	\N	\N	678541
1307	Ambikapuram S.O (Palakkad)		Palakkad	KERALA	Palakkad	\N	\N	678011
1308	Chimbukat B.O		Palakkad	KERALA	Alathur	\N	\N	678721
1309	Chulanur B.O		Palakkad	KERALA	Alathur	\N	\N	678574
1310	Dhoni B.O		Palakkad	KERALA	Palakkad	\N	\N	678009
1311	Kadukkamkunnu B.O		Palakkad	KERALA	Palakkad	\N	\N	678651
1312	Kanjikode S.O		Palakkad	KERALA	Palakkad	\N	\N	678621
1313	Kannanur B.O		Palakkad	KERALA	Alathur	\N	\N	678702
1314	Kozhalmannam Agraharam B.O		Palakkad	KERALA	Alatur	\N	\N	678702
1315	Kunnamkattupathy B.O		Palakkad	KERALA	Chittur	\N	\N	678101
1316	Kuttanur S.O		Palakkad	KERALA	Alathur	\N	\N	678721
1317	Mannur S.O (Palakkad)		Palakkad	KERALA	Palakkad	\N	\N	678642
1318	Marudarode B.O		Palakkad	KERALA	Palakkad	\N	\N	678007
1319	Meenkara Dam B.O		Palakkad	KERALA	Chittur	\N	\N	678507
1320	Moothanthara B.O		Palakkad	KERALA	Palakkad	\N	\N	678012
1321	Mucheeri B.O		Palakkad	KERALA	Palakkad	\N	\N	678631
1322	Muthalamada S.O		Palakkad	KERALA	Chittur	\N	\N	678507
1323	Muttikulangara S.O		Palakkad	KERALA	Palakkad	\N	\N	678594
1324	Naduvathupara B.O		Palakkad	KERALA	Alathur	\N	\N	678574
1325	Olinkadavu B.O		Palakkad	KERALA	Alathur	\N	\N	678706
1326	Palakkad H.O		Palakkad	KERALA	Palakkad	\N	\N	678001
1327	Palakuzhy B.O		Palakkad	KERALA	Alathur	\N	\N	678684
1328	Palampalakode S.O		Palakkad	KERALA	Alathur	\N	\N	678544
1329	Parambikulam S.O		Palakkad	KERALA	Chittur	\N	\N	678661
1330	Parli PG S.O		Palakkad	KERALA	Palakkad	\N	\N	678612
1331	Pudanur B.O		Palakkad	KERALA	Palakkad	\N	\N	678592
1332	Pullode B.O		Palakkad	KERALA	Alathur	\N	\N	678545
1333	Tattamangalam S.O		Palakkad	KERALA	Chittur	\N	\N	678102
1334	Thannisseri B.O		Palakkad	KERALA	Palakkad	\N	\N	678501
1335	Thenkurussi S.O		Palakkad	KERALA	Alathur	\N	\N	678671
1336	Thiruvalathur B.O		Palakkad	KERALA	Palakkad	\N	\N	678551
1337	Tunacadavu B.O		Palakkad	KERALA	Chittur	\N	\N	678661
1338	Verkoli B.O		Palakkad	KERALA	Chittur	\N	\N	678552
1339	Yakkara B.O		Palakkad	KERALA	Palakkad	\N	\N	678701
1340	Anakkal B.O		Palakkad	KERALA	Palakkad	\N	\N	678651
1341	Chandrapuram B.O		Palakkad	KERALA	Palakkad	\N	\N	678624
1342	Chathamangalam B.O		Palakkad	KERALA	Chittur	\N	\N	678508
1343	Chenthamaranagar B.O		Palakkad	KERALA	Chittur	\N	\N	678102
1344	Coyalmanna S.O		Palakkad	KERALA	Alathur	\N	\N	678702
1345	Elakkad B.O		Palakkad	KERALA	Palakkad	\N	\N	678631
1346	Elapulli South B.O		Palakkad	KERALA	Palakkad	\N	\N	678622
1347	Ettanur S.O		Palakkad	KERALA	Chittur	\N	\N	678502
1348	Karinkayam B.O		Palakkad	KERALA	Alathur	\N	\N	678706
1349	Kilakkumbram B.O		Palakkad	KERALA	Palakkad	\N	\N	678642
1350	Kizhakkumuri B.O		Palakkad	KERALA	Chittur	\N	\N	678508
1351	Koduntharapully B.O		Palakkad	KERALA	Palakkad	\N	\N	678004
1352	Kollengode R.S. B.O		Palakkad	KERALA	Chittur	\N	\N	678506
1353	Kollengode West B.O		Palakkad	KERALA	Chittur	\N	\N	678506
1354	Koranchira B.O		Palakkad	KERALA	Alathur	\N	\N	678684
1355	Mannapra S.O		Palakkad	KERALA	Alathur	\N	\N	678685
1356	Mathur PG S.O		Palakkad	KERALA	Alathur	\N	\N	678571
1357	Nurani Agraharam B.O		Palakkad	KERALA	Palakkad	\N	\N	678004
1358	Olavakkot H.O		Palakkad	KERALA	Palakkad	\N	\N	678002
1359	Pallavur S.O		Palakkad	KERALA	Alathur	\N	\N	678688
1360	Pudusseri B.O		Palakkad	KERALA	Palakkad	\N	\N	678623
1361	Rvp Pudur B.O		Palakkad	KERALA	Chittur	\N	\N	678555
1362	Thekkepotta B.O		Palakkad	KERALA	Alathur	\N	\N	678687
1363	Vadasseri B.O		Palakkad	KERALA	Palakkad	\N	\N	678641
1364	Vandithavalam S.O		Palakkad	KERALA	Chittur	\N	\N	678534
1365	Vilayannur B.O		Palakkad	KERALA	Alathur	\N	\N	678671
1366	Vilayodi B.O		Palakkad	KERALA	Chittur	\N	\N	678103
1367	Anamari B.O		Palakkad	KERALA	Chittur	\N	\N	678506
1368	Athicode B.O		Palakkad	KERALA	Chittur	\N	\N	678554
1369	Chennangad B.O		Palakkad	KERALA	Alathur	\N	\N	678573
1370	Chittadi B.O		Palakkad	KERALA	Alathur	\N	\N	678706
1371	Chittur College S.O		Palakkad	KERALA	Palakkad	\N	\N	678104
1372	Erattakulam Alathur B.O		Palakkad	KERALA	Alathur	\N	\N	678682
1373	Govindapuram B.O		Palakkad	KERALA	Alathur	\N	\N	678507
1374	Kallur-palakkad B.O		Palakkad	KERALA	Palakkad	\N	\N	678613
1375	Kariyamkode B.O		Palakkad	KERALA	Alathur	\N	\N	678572
1376	Kazhani B.O		Palakkad	KERALA	Alathur	\N	\N	678543
1377	Kilakkancheri S.O		Palakkad	KERALA	Alathur	\N	\N	678684
1378	Kollengode S.O		Palakkad	KERALA	Chittur	\N	\N	678506
1379	Kongad S.O		Palakkad	KERALA	Palakkad	\N	\N	678631
1380	Mankarai R.S. B.O		Palakkad	KERALA	Palakkad	\N	\N	678613
1381	Meenakshipuram S.O		Palakkad	KERALA	Chittur	\N	\N	678533
1382	Mundur Palakkad S.O		Palakkad	KERALA	Palakkad	\N	\N	678592
1383	Nagaripuram B.O		Palakkad	KERALA	Palakkad	\N	\N	678642
1384	Nattukal S.O		Palakkad	KERALA	Chittur	\N	\N	678554
1385	Nochulli B.O		Palakkad	KERALA	Alathur	\N	\N	678702
1386	Nochupulli B.O		Palakkad	KERALA	Palakkad	\N	\N	678592
1387	Nurani S.O		Palakkad	KERALA	Palakkad	\N	\N	678004
1388	Olivemount B.O		Palakkad	KERALA	Alathur	\N	\N	678702
1389	Padur-Kavasseri B.O		Palakkad	KERALA	Alathur	\N	\N	678543
1390	Palakkad College S.O		Palakkad	KERALA	Palakkad	\N	\N	678001
1391	Pallanchathanur B.O		Palakkad	KERALA	Alathur	\N	\N	678571
1392	Parassikkal B.O		Palakkad	KERALA	Chittur	\N	\N	678556
1393	Paruthipulli S.O		Palakkad	KERALA	Alathur	\N	\N	678573
1394	Paruvasseri B.O		Palakkad	KERALA	Alathur	\N	\N	678686
1395	Perinkulam S.O		Palakkad	KERALA	Alathur	\N	\N	678542
1396	Pirayiri B.O		Palakkad	KERALA	Palakkad	\N	\N	678004
1397	Polpulli S.O		Palakkad	KERALA	Palakkad	\N	\N	678552
1398	Pulinelly B.O		Palakkad	KERALA	Alathur	\N	\N	678572
1399	Sitharkunda B.O		Palakkad	KERALA	Chittur	\N	\N	678508
1400	Tattamangalam South S.O		Palakkad	KERALA	Chittur	\N	\N	678102
1401	Thannilapuram B.O		Palakkad	KERALA	Alathur	\N	\N	678682
1402	Vadakanthara S.O		Palakkad	KERALA	Palakkad	\N	\N	678012
1403	Vandali S.O		Palakkad	KERALA	Alathur	\N	\N	678706
1404	Vattekkad B.O		Palakkad	KERALA	Chittur	\N	\N	678506
1405	Vengodi B.O		Palakkad	KERALA	Palakkad	\N	\N	678622
1406	Chittur PG S.O		Palakkad	KERALA	Palakkad	\N	\N	678101
1407	Erimayur S.O		Palakkad	KERALA	Alathur	\N	\N	678546
1408	Eruttenpadi B.O		Palakkad	KERALA	Chittur	\N	\N	678555
1409	Kakkayur S.O		Palakkad	KERALA	Chittur	\N	\N	678512
1410	Kallekulangara S.O		Palakkad	KERALA	Palakkad	\N	\N	678009
1411	Kannimari B.O		Palakkad	KERALA	Chittur	\N	\N	678534
1412	Koduvayur S.O		Palakkad	KERALA	Palakkad	\N	\N	678501
1413	Kozhinjampara S.O		Palakkad	KERALA	Palakkad	\N	\N	678555
1414	Kundalasseri B.O		Palakkad	KERALA	Palakkad	\N	\N	678641
1415	Kunnathurmedu S.O		Palakkad	KERALA	Palakkad	\N	\N	678013
1416	Malampuzha Dam S.O		Palakkad	KERALA	Palakkad	\N	\N	678651
1417	Mankarai S.O		Palakkad	KERALA	Palakkad	\N	\N	678613
1418	Mudappallur S.O		Palakkad	KERALA	Alathur	\N	\N	678705
1419	Nallepilly S.O		Palakkad	KERALA	Chittur	\N	\N	678553
1420	Nanniode B.O		Palakkad	KERALA	Chittur	\N	\N	678534
1421	Nemmara Old Village B.O		Palakkad	KERALA	Chittur	\N	\N	678508
1422	Nenmeni B.O		Palakkad	KERALA	Chittur	\N	\N	678506
1423	Newkalpathy B.O		Palakkad	KERALA	Palakkad	\N	\N	678003
1424	Panangattiri B.O		Palakkad	KERALA	Chittur	\N	\N	678506
1425	Panayur B.O		Palakkad	KERALA	Palakkad	\N	\N	678552
1426	Parasseri B.O		Palakkad	KERALA	Palakkad	\N	\N	678631
1427	Ramasseri B.O		Palakkad	KERALA	Palakkad	\N	\N	678622
1428	Tadukkasseri B.O		Palakkad	KERALA	Palakkad	\N	\N	678641
1429	Walayar Dam S.O		Palakkad	KERALA	Palakkad	\N	\N	678624
1430	Alampallam B.O		Palakkad	KERALA	Chittur	\N	\N	678506
1431	Athipotta B.O		Palakkad	KERALA	Alathur	\N	\N	678544
1432	Cherukulam B.O		Palakkad	KERALA	Alathur	\N	\N	678572
1433	Elavampadam B.O		Palakkad	KERALA	Alathur	\N	\N	678684
1434	Kallekkad B.O		Palakkad	KERALA	Palakkad	\N	\N	678006
1435	Kallepulli B.O		Palakkad	KERALA	Palakkad	\N	\N	678005
1436	Kanjikode Ind. Estate B.O		Palakkad	KERALA	Palakkad	\N	\N	678621
1437	Kotambu S.O		Palakkad	KERALA	Palakkad	\N	\N	678551
1438	Kottayi S.O		Palakkad	KERALA	Alathur	\N	\N	678572
1439	Nambullipura B.O		Palakkad	KERALA	Palakkad	\N	\N	678592
1440	Nemmara College B.O		Palakkad	KERALA	Chittur	\N	\N	678508
1441	Palaniyarpalayam B.O		Palakkad	KERALA	Chittur	\N	\N	678555
1442	Pallassana S.O		Palakkad	KERALA	Chittur	\N	\N	678505
1443	Pallipuram PG S.O		Palakkad	KERALA	Palakkad	\N	\N	678006
1444	Puduppariyaram S.O		Palakkad	KERALA	Palakkad	\N	\N	678731
1445	Tenur B.O		Palakkad	KERALA	Palakkad	\N	\N	678612
1446	Thachangad B.O		Palakkad	KERALA	Alatur	\N	\N	678571
1447	Thiruvaliad B.O		Palakkad	KERALA	Alatur	\N	\N	678510
1448	Vallikkode B.O		Palakkad	KERALA	Palakkad	\N	\N	678594
1449	Vavulliapuram B.O		Palakkad	KERALA	Alathur	\N	\N	678543
1450	Vemballur B.O		Palakkad	KERALA	Alatur	\N	\N	678502
1451	Anjumoorthy S.O		Palakkad	KERALA	Alathur	\N	\N	678682
1452	Chandramala Estate B.O		Palakkad	KERALA	Chittur	\N	\N	678508
1453	Cheramangalam B.O		Palakkad	KERALA	Alathur	\N	\N	678703
1454	Cheraya B.O		Palakkad	KERALA	Palakkad	\N	\N	678631
1455	Eduppukulam B.O		Palakkad	KERALA	Palakkad	\N	\N	678556
1456	Elapulli S.O		Palakkad	KERALA	Palakkad	\N	\N	678622
1457	Erattakulam B.O		Palakkad	KERALA	Chittur	\N	\N	678622
1458	Kairady B.O		Palakkad	KERALA	Alatur	\N	\N	678510
1459	Kalpathi S.O		Palakkad	KERALA	Palakkad	\N	\N	678003
1460	Kannambra S.O		Palakkad	KERALA	Alathur	\N	\N	678686
1461	Karippode B.O		Palakkad	KERALA	Palakkad	\N	\N	678503
1462	Kavasseri S.O		Palakkad	KERALA	Alathur	\N	\N	678543
1463	Kinasseri B.O		Palakkad	KERALA	Palakkad	\N	\N	678701
1464	Koottala B.O		Palakkad	KERALA	Alathur	\N	\N	678681
1465	Mannur West B.O		Palakkad	KERALA	Palakkad	\N	\N	678642
1466	Menonpara S.O		Palakkad	KERALA	Palakkad	\N	\N	678556
1467	Padagiri B.O		Palakkad	KERALA	Chittur	\N	\N	678508
1468	Palakkad Collectorate S.O		Palakkad	KERALA	Palakkad	\N	\N	678001
1469	Pampampallam B.O		Palakkad	KERALA	Palakkad	\N	\N	678621
1470	Payyalur B.O		Palakkad	KERALA	Chittur	\N	\N	678506
1471	Peringottukurussi S.O		Palakkad	KERALA	Alathur	\N	\N	678574
1472	Pothundy Dam B.O		Palakkad	KERALA	Chittur	\N	\N	678508
1473	Pudiyankam S.O		Palakkad	KERALA	Alathur	\N	\N	678545
1474	Tarur B.O		Palakkad	KERALA	Alathur	\N	\N	678544
1475	Thekkegramam S.O		Palakkad	KERALA	Chittur	\N	\N	678103
1476	Vadakkancherry MBR S.O		Palakkad	KERALA	Alathur	\N	\N	678683
1477	Vallanghy B.O		Palakkad	KERALA	Chittur	\N	\N	678508
1478	Vannamada B.O		Palakkad	KERALA	Palakkad	\N	\N	678555
1479	Ambayathode B.O		Kannur	KERALA	Thalassery	\N	\N	670651
1480	Anjukunnu B.O		Wayanad	KERALA	Mananthavady	\N	\N	670645
1481	Cheruparamba B.O		Kannur	KERALA	Thalassery	\N	\N	670693
1482	Dharmadam S.O		Kannur	KERALA	Thalasery	\N	\N	670106
1483	Elangot B.O		Kannur	KERALA	Thalassery	\N	\N	670692
1484	Kampatti B.O		Wayanad	KERALA	Mananthavady	\N	\N	670644
1485	Kappattumala B.O		Wayanad	KERALA	Mananthavady	\N	\N	670644
1486	Keezhpalli B.O		Kannur	KERALA	Thalassery	\N	\N	670704
1487	Kellur B.O		Wayanad	KERALA	Mananthavady	\N	\N	670645
1488	Kolari B.O		Kannur	KERALA	Thalassery	\N	\N	670702
1489	Manantheri B.O		Kannur	KERALA	Thalassery	\N	\N	670643
1490	Melur-tly B.O		Kannur	KERALA	Thalassery	\N	\N	670661
1491	Mundayamparamba B.O		Kannur	KERALA	Thalassery	\N	\N	670704
1492	Nadavayal B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	670721
1493	Neerveli B.O		Kannur	KERALA	Thalassery	\N	\N	670701
1494	Palaparamba B.O		Kannur	KERALA	Thalassery	\N	\N	670701
1495	Payam East B.O		Kannur	KERALA	Thalassery	\N	\N	670704
1496	Peringadi S.O		Kannur	KERALA	NA	\N	\N	673312
1497	Poyilur B.O		Kannur	KERALA	Thalassery	\N	\N	670693
1498	Temple Gate S.O		Kannur	KERALA	Thalassery	\N	\N	670102
1499	Thalassery Courts S.O		Kannur	KERALA	Thalassery	\N	\N	670101
1500	Thondernadu B.O		Wayanad	KERALA	Manantahvady	\N	\N	670731
1501	Tirunelli Temple B.O		Wayanad	KERALA	Mananthavady	\N	\N	670646
1502	Uliyil B.O		Kannur	KERALA	Thalassery	\N	\N	670702
1503	Ummenchira S.O		Kannur	KERALA	Thalassery	\N	\N	670649
1504	Valery B.O		Wayanad	KERALA	Mananthavady	\N	\N	670645
1505	Vallat B.O		Wayanad	KERALA	Mananthavady	\N	\N	670644
1506	Varayal B.O		Wayanad	KERALA	Mananthavady	\N	\N	670644
1507	Vattiamthode B.O		Kannur	KERALA	Taliparamba	\N	\N	670705
1508	Vemom B.O		Wayanad	KERALA	Mananthavady	\N	\N	670645
1509	Aralam B.O		Kannur	KERALA	Thalassery	\N	\N	670704
1510	Bavali B.O		Wayanad	KERALA	Mananthavady	\N	\N	670646
1511	Cherakkara S.O		Kannur	KERALA	Thalassery	\N	\N	670104
1512	Cherukattoor B.O		Wayanad	KERALA	Mananthavady	\N	\N	670721
1513	Cheruvancheri B.O		Kannur	KERALA	Thalassery	\N	\N	670650
1514	Chettiamparamba B.O		Kannur	KERALA	Thalassery	\N	\N	670674
1515	Chunkakunnu B.O		Kannur	KERALA	Thalassery	\N	\N	670651
1516	Iritty S.O		Kannur	KERALA	Thalassery	\N	\N	670703
1517	Kadavathur S.O		Kannur	KERALA	Thalassery	\N	\N	670676
1518	Kalluvayal B.O		Kannur	KERALA	Taliparamba	\N	\N	670703
1519	Kammana B.O		Wayanad	KERALA	Mananthavady	\N	\N	670645
1520	Kanichar B.O		Kannur	KERALA	Thalassery	\N	\N	670674
1521	Kannavam Colony B.O		Kannur	KERALA	Thalassery	\N	\N	670650
1522	Kartikulam S.O		Wayanad	KERALA	Mananthavady	\N	\N	670646
1523	Keecheri B.O		Kannur	KERALA	Thalassery	\N	\N	670702
1524	Kidanhi B.O		Kannur	KERALA	Thalassery	\N	\N	670675
1525	Kizhakke Kadirur B.O		Kannur	KERALA	Thalassery	\N	\N	670642
1526	Kolakkad B.O		Kannur	KERALA	Thalassery	\N	\N	670673
1527	Kottarakunnu B.O		Wayanad	KERALA	Mananthavady	\N	\N	670731
1528	Malayampadi B.O		Kannur	KERALA	Thalassery	\N	\N	670674
1529	Malur B.O		Kannur	KERALA	Thalassery	\N	\N	670702
1530	Mambram B.O		Kannur	KERALA	Thalasery	\N	\N	670741
1531	Mekkunnu B.O		Kannur	KERALA	NA	\N	\N	670675
1532	Melmuringodi B.O		Kannur	KERALA	Thalassery	\N	\N	670673
1533	Mokeri B.O		Kannur	KERALA	Thalassery	\N	\N	670692
1534	Pachapoika B.O		Kannur	KERALA	Thalassery	\N	\N	670643
1535	Peringathur S.O		Kannur	KERALA	Thalassery	\N	\N	670675
1536	Thalassery H.O		Kannur	KERALA	Thalassery	\N	\N	670101
1537	Thettamala B.O		Wayanad	KERALA	Mananthavady	\N	\N	670731
1538	Ulikkal S.O		Kannur	KERALA	Taliparamba	\N	\N	670705
1539	Uruvachal B.O		Kannur	KERALA	Thalasery	\N	\N	670702
1540	Veerpad B.O		Kannur	KERALA	Thalassery	\N	\N	670704
1541	Vellunni B.O		Kannur	KERALA	Thalassery	\N	\N	670674
1542	Vilakkode B.O		Kannur	KERALA	Thalassery	\N	\N	670703
1543	Alattil B.O		Wayanad	KERALA	Mananthavady	\N	\N	670644
1544	Arinjerummal B.O		Wayanad	KERALA	Mananthavady	\N	\N	670721
1545	Champad S.O		Kannur	KERALA	Thalassery	\N	\N	670694
1546	Kacherikadavu B.O		Kannur	KERALA	Thalassery	\N	\N	670706
1547	Kadambur-kannur B.O		Kannur	KERALA	Kannur	\N	\N	670663
1548	Kadirur-tly S.O		Kannur	KERALA	Thalassery	\N	\N	670642
1549	Kannoth B.O		Kannur	KERALA	Thalassery	\N	\N	670650
1550	Kariyad South S.O		Kannur	KERALA	Thalassery	\N	\N	673316
1551	Kavumbhagam B.O		Kannur	KERALA	Thalassery	\N	\N	670649
1552	Kelakam S.O		Kannur	KERALA	Thalassery	\N	\N	670674
1553	Koomanthode B.O		Kannur	KERALA	Thalassery	\N	\N	670704
1554	Koorara B.O		Kannur	KERALA	Thalassery	\N	\N	670694
1555	Kottayam Malabar B.O		Kannur	KERALA	Thalassery	\N	\N	670643
1556	Kunhome B.O		Wayanad	KERALA	Mananthavady	\N	\N	670731
1557	Kunnamangalam Wayanad B.O		Wayanad	KERALA	Mananthavady	\N	\N	670645
1558	Makkiad B.O		Wayanad	KERALA	Mananthavady	\N	\N	670731
1559	Manikkadavu B.O		Kannur	KERALA	Taliparamba	\N	\N	670705
1560	Mattanur College B.O		Kannur	KERALA	Thalassery	\N	\N	670702
1561	Muzhappilangad S.O		Kannur	KERALA	Thalassery	\N	\N	670662
1562	Nirmalagiri S.O		Kannur	KERALA	Thalassery	\N	\N	670701
1563	Padiyur-kannur B.O		Kannur	KERALA	Thalassery	\N	\N	670703
1564	Palayad S.O		Kannur	KERALA	Thalassery	\N	\N	670661
1565	Pathiriyad B.O		Kannur	KERALA	Thalassery	\N	\N	670741
1566	Perumpunna B.O		Kannur	KERALA	Thalassery	\N	\N	670673
1567	Ponniam B.O		Kannur	KERALA	Thalassery	\N	\N	670641
1568	Pukkot-kba B.O		Kannur	KERALA	Thalassery	\N	\N	670691
1569	Punnol B.O		Kannur	KERALA	Thalassery	\N	\N	670102
1570	Tholambra B.O		Kannur	KERALA	Thalassery	\N	\N	670673
1571	Thuvakunnu S.O		Kannur	KERALA	Thalassery	\N	\N	670693
1572	Vadakkumbad B.O		Kannur	KERALA	Thalassery	\N	\N	670105
1573	Alacherry B.O		Kannur	KERALA	Thalassery	\N	\N	670650
1574	Angadikadavu B.O		Kannur	KERALA	Thalassery	\N	\N	670706
1575	Arabi B.O		Kannur	KERALA	Taliparamba	\N	\N	670705
1576	Atakkathode B.O		Kannur	KERALA	Thalassery	\N	\N	670674
1577	Ellumannam B.O		Wayanad	KERALA	Mananthavady	\N	\N	670645
1578	Kattayad B.O		Wayanad	KERALA	Mananthavady	\N	\N	670731
1579	Keezhur-iritty B.O		Kannur	KERALA	Thalassery	\N	\N	670703
1580	Naduvanad B.O		Kannur	KERALA	Thalassery	\N	\N	670702
1581	Nettur S.O (Kannur)		Kannur	KERALA	Thalassery	\N	\N	670105
1582	Nirvaram B.O		Wayanad	KERALA	Mananthavady	\N	\N	670721
1583	Nuchiyad B.O		Kannur	KERALA	Taliparamba	\N	\N	670705
1584	Panavally B.O		Wayanad	KERALA	Mananthavady	\N	\N	670646
1585	Panniyannur B.O		Kannur	KERALA	Thalassery	\N	\N	670671
1586	Pazhassiraja Nagar B.O		Kannur	KERALA	Thalassery	\N	\N	670702
1587	Peruva B.O		Kannur	KERALA	Thalassery	\N	\N	670650
1588	Randamkadavu B.O		Kannur	KERALA	Thalassery	\N	\N	670706
1589	Thrissileri B.O		Wayanad	KERALA	Mananthavady	\N	\N	670646
1590	Tiruvangad S.O		Kannur	KERALA	Thalassery	\N	\N	670103
1591	Vayannur B.O		Kannur	KERALA	Thalassery	\N	\N	670650
1592	Vellarvelly B.O		Kannur	KERALA	Thalassery	\N	\N	670673
1593	Vilakkottur B.O		Kannur	KERALA	Thalassery	\N	\N	670693
1594	Aniyaram B.O		Kannur	KERALA	NA	\N	\N	670672
1595	Chalil S.O		Kannur	KERALA	Thalassery	\N	\N	670102
1596	Chavasseri B.O		Kannur	KERALA	Thalassery	\N	\N	670702
1597	Cherakkara(wayanad) B.O		Wayanad	KERALA	Mananthavady	\N	\N	670644
1598	Kallikandy B.O		Kannur	KERALA	Thalassery	\N	\N	670693
1599	Kolayad B.O		Kannur	KERALA	Thalassery	\N	\N	670650
1600	Kottayampoil B.O		Kannur	KERALA	Thalassery	\N	\N	670691
1601	Kuttikkakam B.O		Kannur	KERALA	Kannur	\N	\N	670663
1602	Moozhikkara B.O		Kannur	KERALA	Thalassery	\N	\N	670103
1603	Panamaram S.O		Wayanad	KERALA	Mananthavady	\N	\N	670721
1604	Panoor S.O		Kannur	KERALA	Thalassery	\N	\N	670692
1605	Paral S.O		Kannur	KERALA	Thalassery	\N	\N	670671
1606	Parikkalam B.O		Kannur	KERALA	Taliparamba	\N	\N	670705
1607	Payyampalli B.O		Wayanad	KERALA	Mananthavady	\N	\N	670646
1608	Perinkeri B.O		Kannur	KERALA	Thalassery	\N	\N	670706
1609	Pinarayi S.O		Kannur	KERALA	Thalassery	\N	\N	670741
1610	Porur(wayanad) B.O		Wayanad	KERALA	Mananthavady	\N	\N	670644
1611	Pullookkara B.O		Kannur	KERALA	Thalassery	\N	\N	670672
1612	Punnad B.O		Kannur	KERALA	Thalassery	\N	\N	670703
1613	Tavinhal B.O		Wayanad	KERALA	Mananthavady	\N	\N	670644
1614	Thondiyil B.O		Kannur	KERALA	Thalassery	\N	\N	670673
1615	Tirunelli B.O		Wayanad	KERALA	Manantahvady	\N	\N	670646
1616	Vellamunda S.O		Wayanad	KERALA	Mananthavady	\N	\N	670731
1617	Echchome B.O		Wayanad	KERALA	Mananthavady	\N	\N	670721
1618	Etakkad S.O		Kannur	KERALA	Kannur	\N	\N	670663
1619	Kakkengad B.O		Kannur	KERALA	Thalassery	\N	\N	670673
1620	Kalanki B.O		Kannur	KERALA	Taliparamba	\N	\N	670705
1621	Karakkamala B.O		Wayanad	KERALA	Mananthavady	\N	\N	670645
1622	Kayakunnu B.O		Wayanad	KERALA	Sulthanbathery	\N	\N	670721
1623	Kayani B.O		Kannur	KERALA	Thalassery	\N	\N	670702
1624	Koottupuzha B.O		Kannur	KERALA	Taliparamba	\N	\N	670706
1625	Kottiyur S.O		Kannur	KERALA	Thalassery	\N	\N	670651
1626	Kuthuparamba S.O		Kannur	KERALA	Thalassery	\N	\N	670643
1627	Mooriyad B.O		Kannur	KERALA	Thalassery	\N	\N	670643
1628	Mudiyanga B.O		Kannur	KERALA	Thalassery	\N	\N	670691
1629	Mundakutty B.O		Wayanad	KERALA	Vythiri	\N	\N	670645
1630	Narikkodmala B.O		Kannur	KERALA	Thalassery	\N	\N	670693
1631	Olavilam S.O		Kannur	KERALA	NA	\N	\N	673313
1632	Pathayakunnu S.O		Kannur	KERALA	Thalassery	\N	\N	670691
1633	Perundattil B.O		Kannur	KERALA	Thalassery	\N	\N	670107
1634	Pilakavu B.O		Wayanad	KERALA	Mananthavady	\N	\N	670645
1635	Poolakutty B.O		Kannur	KERALA	Thalassery	\N	\N	670650
1636	Porora B.O		Kannur	KERALA	Thalassery	\N	\N	670702
1637	Pudusserikadavu B.O		Wayanad	KERALA	Mananthavady	\N	\N	670645
1638	Santhigiri B.O		Kannur	KERALA	Thalassery	\N	\N	670674
1639	Ambilat B.O		Kannur	KERALA	Thalasseery	\N	\N	670701
1640	Aralam Farm B.O		Kannur	KERALA	Thalassery	\N	\N	670673
1641	Ayithara Mambram B.O		Kannur	KERALA	Thalassery	\N	\N	670643
1642	Chittariparamba S.O		Kannur	KERALA	Thalassery	\N	\N	670650
1643	Chokli S.O		Kannur	KERALA	NA	\N	\N	670672
1644	Edapuzha B.O		Kannur	KERALA	Thalassery	\N	\N	670704
1645	Edavaka B.O		Wayanad	KERALA	Mananthavady	\N	\N	670645
1646	Eruvatty B.O		Kannur	KERALA	Thalassery	\N	\N	670642
1647	Kanhileri B.O		Kannur	KERALA	Thalassery	\N	\N	670702
1648	Mallannur B.O		Kannur	KERALA	Thalassery	\N	\N	670701
1649	Mananthavady S.O		Wayanad	KERALA	Mananthavady	\N	\N	670645
1650	Mangattidam B.O		Kannur	KERALA	Thalassery	\N	\N	670643
1651	Mattanur S.O		Kannur	KERALA	Thalassery	\N	\N	670702
1652	New Mahe S.O		Kannur	KERALA	Thalassery	\N	\N	673311
1653	Payam S.O		Kannur	KERALA	Thalassery	\N	\N	670704
1654	Periya B.O		Wayanad	KERALA	Mananthavady	\N	\N	670644
1655	Puthur-panoor B.O		Kannur	KERALA	Thalassery	\N	\N	670692
1656	Sankaranellur B.O		Kannur	KERALA	Thalassery	\N	\N	670643
1657	Sivapuram B.O		Kannur	KERALA	Thalassery	\N	\N	670702
1658	Thalappuzha S.O		Wayanad	KERALA	Mananthavady	\N	\N	670644
1659	Thalassery Bazar S.O		Kannur	KERALA	Thalassery	\N	\N	670101
1660	Vanhode B.O		Wayanad	KERALA	Mananthavady	\N	\N	670731
1661	Vayalalam B.O		Kannur	KERALA	Thalassery	\N	\N	670671
1662	Velimanam B.O		Kannur	KERALA	Thalassery	\N	\N	670704
1663	Vimalanagar B.O		Wayanad	KERALA	Mananthavady	\N	\N	670645
1664	Arattuthara B.O		Wayanad	KERALA	Mananthavady	\N	\N	670645
1665	Charal B.O		Kannur	KERALA	Thalassery	\N	\N	670706
1666	Chendayad B.O		Kannur	KERALA	Thalassery	\N	\N	670692
1667	Eranholi S.O		Kannur	KERALA	Thalassery	\N	\N	670107
1668	Kara- Peravoor B.O		Kannur	KERALA	Thalassery	\N	\N	670702
1669	Kiliyanthara S.O		Kannur	KERALA	Thalassery	\N	\N	670706
1670	Kolithattu B.O		Kannur	KERALA	Taliparamba	\N	\N	670706
1671	Kurichiyil B.O		Kannur	KERALA	Thalassery	\N	\N	670102
1672	Madathil B.O		Kannur	KERALA	Thalassery	\N	\N	670703
1673	Manathana B.O		Kannur	KERALA	Thalassery	\N	\N	670674
1674	Manippara B.O		Kannur	KERALA	Taliparamba	\N	\N	670705
1675	Mattilayam B.O		Wayanad	KERALA	Mananthavady	\N	\N	670731
1676	Muzhakunnu B.O		Kannur	KERALA	Thalassery	\N	\N	670673
1677	Nallurnad B.O		Wayanad	KERALA	Mananthavady	\N	\N	670645
1678	Nedumpoil B.O		Kannur	KERALA	Thalassery	\N	\N	670650
1679	Parapram B.O		Kannur	KERALA	Thalassery	\N	\N	670741
1680	Peravoor S.O		Kannur	KERALA	Thalassery	\N	\N	670673
1681	Ponniam West S.O		Kannur	KERALA	Thalassery	\N	\N	670641
1682	Pudusseri B.O		Wayanad	KERALA	Mananthavady	\N	\N	670645
1683	Puliyanambram B.O		Kannur	KERALA	Thalassery	\N	\N	670675
1684	Tharuvana B.O		Wayanad	KERALA	Mananthavady	\N	\N	670645
1685	Thillenkeri B.O		Kannur	KERALA	Thalassery	\N	\N	670702
1686	Tholpetty B.O		Wayanad	KERALA	Mananthavady	\N	\N	670646
1687	Ariyallur S.O		Malappuram	KERALA	Tirurangadi	\N	\N	676312
1688	Chamravattom B.O		Malappuram	KERALA	Tirur	\N	\N	676102
1689	Indianur B.O		Malappuram	KERALA	Tirur	\N	\N	676503
1690	Karippol B.O		Malappuram	KERALA	Tirur	\N	\N	676552
1691	Karthala B.O		Malappuram	KERALA	Tirur	\N	\N	679571
1692	Kavancheri B.O		Malappuram	KERALA	Tirur	\N	\N	676561
1693	Kooriyad B.O		Malappuram	KERALA	Tirurangadi	\N	\N	676306
1694	Kuttippala B.O		Malappuram	KERALA	Tirur	\N	\N	676501
1695	Mampuram B.O		Malappuram	KERALA	Tirurangadi	\N	\N	676306
1696	Mudur B.O		Malappuram	KERALA	Ponnani	\N	\N	679578
1697	Naduvattom B.O		Malappuram	KERALA	Tirur	\N	\N	679571
1698	Omachapuzha B.O		Malappuram	KERALA	Tirur	\N	\N	676320
1699	Othukkungal S.O		Malappuram	KERALA	Tirur	\N	\N	676528
1700	Padinharekkara B.O		Malappuram	KERALA	Tirur	\N	\N	676562
1701	Panangattur B.O		Malappuram	KERALA	Tirur	\N	\N	676302
1702	Paravanna S.O		Malappuram	KERALA	Tirur	\N	\N	676502
1703	Perumparamba B.O		Malappuram	KERALA	Ponnani	\N	\N	679576
1704	Ponani Nagaram S.O		Malappuram	KERALA	Ponnani	\N	\N	679583
1705	Ponmundam S.O		Malappuram	KERALA	Tirur	\N	\N	676106
1706	Puduppalli B.O		Malappuram	KERALA	Tirur	\N	\N	676102
1707	Randathani S.O		Malappuram	KERALA	Tirur	\N	\N	676510
1708	Tanur Nagaram B.O		Malappuram	KERALA	Tirur	\N	\N	676302
1709	Thalakkadathur S.O		Malappuram	KERALA	Tirur	\N	\N	676103
1710	Vadakkumbram B.O		Malappuram	KERALA	Tirur	\N	\N	676552
1711	Valiyora B.O		Malappuram	KERALA	Tirurangadi	\N	\N	676304
1712	Velimukku South B.O		Malappuram	KERALA	Tirurangadi	\N	\N	676317
1713	Ananthavur B.O		Malappuram	KERALA	Tirur	\N	\N	676301
1714	Athalur B.O		Malappuram	KERALA	Ponnani	\N	\N	679573
1715	Ayilakkad B.O		Malappuram	KERALA	Ponnani	\N	\N	679576
1716	Bettath Pudiangadi S.O		Malappuram	KERALA	Tirur	\N	\N	676102
1717	Chengottur B.O		Malappuram	KERALA	Tirur	\N	\N	676503
1718	Chennara B.O		Malappuram	KERALA	Tirur	\N	\N	676561
1719	Kannattipadi B.O		Malappuram	KERALA	Tirurangadi	\N	\N	676304
1720	Keraladheeswarapuram B.O		Malappuram	KERALA	Tirur	\N	\N	676307
1721	Kurumbathur B.O		Malappuram	KERALA	Tirur	\N	\N	676301
1722	Mangattiri B.O		Malappuram	KERALA	Tirur	\N	\N	676105
1723	Nannamukku South B.O		Malappuram	KERALA	Ponnani	\N	\N	679575
1724	Nariparamba B.O		Malappuram	KERALA	Ponnani	\N	\N	679573
1725	Ozhur B.O		Malappuram	KERALA	Tirur	\N	\N	676307
1726	Pachattiri B.O		Malappuram	KERALA	Tirur	\N	\N	676105
1727	Parammalangadi B.O		Malappuram	KERALA	Tirur	\N	\N	676551
1728	Parpanangadi S.O		Malappuram	KERALA	Tirurangadi	\N	\N	676303
1729	Pathayakallu B.O		Malappuram	KERALA	Tirur	\N	\N	676553
1730	Perasannur B.O		Malappuram	KERALA	Tirur	\N	\N	679571
1731	Pidavannur B.O		Malappuram	KERALA	Ponnani	\N	\N	679574
1732	Ponmala B.O		Malappuram	KERALA	Tirur	\N	\N	676528
1733	Pookayil Bazar S.O		Malappuram	KERALA	Tirur	\N	\N	676107
1734	Poyilisseri B.O		Malappuram	KERALA	Tirur	\N	\N	676102
1735	Tanur-MBR S.O		Malappuram	KERALA	Tirur	\N	\N	676302
1736	Valakolam S.O		Malappuram	KERALA	Tirurangadi	\N	\N	676508
1737	Valancheri S.O		Malappuram	KERALA	Tirur	\N	\N	676552
1738	Vettom-pallippuram B.O		Malappuram	KERALA	Tirur	\N	\N	676102
1739	Alankode S.O		Malappuram	KERALA	Ponani	\N	\N	679585
1740	Alathiyur B.O		Malappuram	KERALA	Tirur	\N	\N	676102
1741	Anjapura B.O		Malappuram	KERALA	Tirurangadi	\N	\N	676303
1742	Cherur B.O		Malappuram	KERALA	Tirurangadi	\N	\N	676304
1743	Chettipadi S.O		Malappuram	KERALA	Tirurangadi	\N	\N	676319
1744	Chullippara B.O		Malappuram	KERALA	Tirurangadi	\N	\N	676508
1745	Codacal B.O		Malappuram	KERALA	Tirur	\N	\N	676108
1746	Irimbiliyam S.O		Malappuram	KERALA	Tirur	\N	\N	679572
1747	Kadavanad B.O		Malappuram	KERALA	Ponani	\N	\N	679586
1748	Kalpakancheri S.O		Malappuram	KERALA	Tirur	\N	\N	676551
1749	Kotakkad B.O		Malappuram	KERALA	Tirurangadi	\N	\N	676319
1750	Kuttayi S.O		Malappuram	KERALA	Tirur	\N	\N	676562
1751	Kuttippuram S.O		Malappuram	KERALA	Tirur	\N	\N	679571
1752	Meenadathur B.O		Malappuram	KERALA	Tirur	\N	\N	676307
1753	Olakara B.O		Malappuram	KERALA	Tirurangadi	\N	\N	676306
1754	Parambilpeedika B.O		Malappuram	KERALA	Tirurangadi	\N	\N	676317
1755	Pazhur B.O		Malappuram	KERALA	Tirur	\N	\N	679571
1756	Ponani H.O		Malappuram	KERALA	Ponnani	\N	\N	679577
1757	Ullanam North B.O		Malappuram	KERALA	Tirurangadi	\N	\N	676303
1758	Vengalur B.O		Malappuram	KERALA	Tirur	\N	\N	676102
1759	Venniyur B.O		Malappuram	KERALA	Tirurangadi	\N	\N	676508
1760	Kadancheri B.O		Malappuram	KERALA	Ponnani	\N	\N	679582
1761	Kanmanam-thekkummuri B.O		Malappuram	KERALA	Tirur	\N	\N	676551
1762	Karekkad B.O		Malappuram	KERALA	Tirur	\N	\N	676553
1763	Kokkur S.O		Malappuram	KERALA	Ponnani	\N	\N	679591
1764	Kuttippuram-kottakkal B.O		Malappuram	KERALA	Tirur	\N	\N	676503
1765	Mangalam-MLP S.O		Malappuram	KERALA	Tirur	\N	\N	676561
1766	Marakkara B.O		Malappuram	KERALA	Tirur	\N	\N	676553
1767	Mookkuthala S.O		Malappuram	KERALA	Ponnani	\N	\N	679574
1768	Moonniyur South B.O		Malappuram	KERALA	Tirurangadi	\N	\N	676311
1769	Niramaruthur S.O		Malappuram	KERALA	Tirur	\N	\N	676109
1770	Payinkanniyur B.O		Malappuram	KERALA	Tirur	\N	\N	679571
1771	Purathur B.O		Malappuram	KERALA	Tirur	\N	\N	676102
1772	Thennala B.O		Malappuram	KERALA	Tirurangadi	\N	\N	676508
1773	Tirunavaya S.O		Malappuram	KERALA	Tirur	\N	\N	676301
1774	Tirurangadi Bazar S.O		Malappuram	KERALA	Tirurangadi	\N	\N	676306
1775	Tolavanur B.O		Malappuram	KERALA	Tirur	\N	\N	676552
1776	Trikkandiyur S.O		Malappuram	KERALA	NA	\N	\N	676104
1777	Valavannur B.O		Malappuram	KERALA	Tirur	\N	\N	676551
1778	Valiyakunnu B.O		Malappuram	KERALA	Tirur	\N	\N	676552
1779	Vettom B.O		Malappuram	KERALA	Tirur	\N	\N	676102
1780	Vyrancode B.O		Malappuram	KERALA	Tirur	\N	\N	676301
1781	Biyyam B.O		Malappuram	KERALA	Ponani	\N	\N	679576
1782	Chappanangadi B.O		Malappuram	KERALA	Tirur	\N	\N	676503
1783	Edayur B.O		Malappuram	KERALA	Tirur	\N	\N	676552
1784	Edayur North B.O		Malappuram	KERALA	Tirur	\N	\N	676552
1785	Eramangalam S.O		Malappuram	KERALA	Ponnani	\N	\N	679587
1786	Iswaramangalam B.O		Malappuram	KERALA	Ponani	\N	\N	679573
1787	Kannamangalam West B.O		Malappuram	KERALA	Tirurangadi	\N	\N	676305
1788	Kuttur North B.O		Malappuram	KERALA	Tirurangadi	\N	\N	676305
1789	Muttanur B.O		Malappuram	KERALA	Tirur	\N	\N	676561
1790	Nannambra B.O		Malappuram	KERALA	Tirurangadi	\N	\N	676320
1791	Parappur B.O		Malappuram	KERALA	Tirur	\N	\N	676503
1792	Ponani South S.O		Malappuram	KERALA	Ponnani	\N	\N	679586
1793	Tanalur S.O		Malappuram	KERALA	Tirur	\N	\N	676307
1794	Tayyalingal S.O		Malappuram	KERALA	Tirurangadi	\N	\N	676320
1795	Tirur(kerala) H.O		Malappuram	KERALA	Tirur	\N	\N	676101
1796	Vallikkunnu B.O		Malappuram	KERALA	Tirurangadi	\N	\N	673314
1797	Veliankode S.O		Malappuram	KERALA	Ponani	\N	\N	679579
1798	Abdurahiman Nagar S.O		Malappuram	KERALA	Tirurangadi	\N	\N	676305
1799	Athrisseri B.O		Malappuram	KERALA	Tirur	\N	\N	676106
1800	Cherushola B.O		Malappuram	KERALA	Tirurangadi	\N	\N	676510
1801	Iringallur B.O		Malappuram	KERALA	Tirurangadi	\N	\N	676304
1802	Kadalundinagaram S.O		Malappuram	KERALA	Tirurangadi	\N	\N	673314
1803	Kakkad B.O		Malappuram	KERALA	Tirurangadi	\N	\N	676306
1804	Kololamba B.O		Malappuram	KERALA	Ponnani	\N	\N	679576
1805	Mattathur B.O		Malappuram	KERALA	Tirurangadi	\N	\N	676528
1806	Nannamukku S.O		Malappuram	KERALA	Ponani	\N	\N	679575
1807	Neduva B.O		Malappuram	KERALA	Tirurangadi	\N	\N	676303
1808	Pandamangalam B.O		Malappuram	KERALA	Tirur	\N	\N	676503
1809	Pantarangadi B.O		Malappuram	KERALA	Tirurangadi	\N	\N	676306
1810	Pariyapuram B.O		Malappuram	KERALA	Tirur	\N	\N	676302
1811	Pazhanji-mlp B.O		Malappuram	KERALA	Ponnani	\N	\N	679579
1812	Puramannur B.O		Malappuram	KERALA	Tirur	\N	\N	676552
1813	Puranga B.O		Malappuram	KERALA	Ponnani	\N	\N	679584
1814	Puthuparamba B.O		Malappuram	KERALA	Tirurangadi	\N	\N	676501
1815	Sugapuram B.O		Malappuram	KERALA	Ponnani	\N	\N	679576
1816	Tavanur S.O		Malappuram	KERALA	Ponani	\N	\N	679573
1817	Thekkummuri S.O		Malappuram	KERALA	Tirur	\N	\N	676105
1818	Tirur East Bazar S.O		Malappuram	KERALA	Tirur	\N	\N	676101
1819	Tirurangadi S.O		Malappuram	KERALA	Tirurangadi	\N	\N	676306
1820	Trikkanapuram B.O		Malappuram	KERALA	Ponnani	\N	\N	679573
1821	Vakkad B.O		Malappuram	KERALA	Tirur	\N	\N	676502
1822	Vallikkunnu North B.O		Malappuram	KERALA	Tirurangadi	\N	\N	673314
1823	Vengara MLP S.O		Malappuram	KERALA	Tirurangadi	\N	\N	676304
1824	Athavanad B.O		Malappuram	KERALA	Tirur	\N	\N	676301
1825	Ayirur B.O		Malappuram	KERALA	Ponnani	\N	\N	679580
1826	Cheriyamundam B.O		Malappuram	KERALA	Tirur	\N	\N	676106
1827	Gramam B.O		Malappuram	KERALA	Ponnani	\N	\N	679579
1828	Iringavur B.O		Malappuram	KERALA	Tirur	\N	\N	676103
1829	Kaladi-MLP S.O		Malappuram	KERALA	Ponani	\N	\N	679582
1830	Kallarmangalam B.O		Malappuram	KERALA	Tirur	\N	\N	676553
1831	Karukathiruthy B.O		Malappuram	KERALA	Ponani	\N	\N	679584
1832	Kodinhi S.O		Malappuram	KERALA	Tirurangadi	\N	\N	676309
1833	Othalur West B.O		Malappuram	KERALA	Ponnani	\N	\N	679591
1834	Palapetty B.O		Malappuram	KERALA	Ponnani	\N	\N	679579
1835	Perumbadappu S.O		Malappuram	KERALA	Ponani	\N	\N	679580
1836	Punnathala B.O		Malappuram	KERALA	Tirur	\N	\N	676552
1837	Puthiyakadappuram B.O		Malappuram	KERALA	Tirur	\N	\N	676302
1838	Puthur -kottakkal B.O		Malappuram	KERALA	Tirurangadi	\N	\N	676503
1839	Thekkankuttur B.O		Malappuram	KERALA	Tirur	\N	\N	676551
1840	Triprangode S.O		Malappuram	KERALA	Tirur	\N	\N	676108
1841	Ullanam B.O		Malappuram	KERALA	Tirurangadi	\N	\N	676303
1842	Vellachal B.O		Malappuram	KERALA	Tirur	\N	\N	676106
1843	Ayankalam B.O		Malappuram	KERALA	Ponnani	\N	\N	679573
1844	Cherumukku B.O		Malappuram	KERALA	Tirurangadi	\N	\N	676306
1845	Cheruvallur B.O		Malappuram	KERALA	Ponnani	\N	\N	679575
1846	Edapal S.O		Malappuram	KERALA	Ponani	\N	\N	679576
1847	Edarikode S.O		Malappuram	KERALA	Tirurangadi	\N	\N	676501
1848	Kadampuzha S.O		Malappuram	KERALA	Tirur	\N	\N	676553
1849	Kanhiramukku S.O		Malappuram	KERALA	Ponnani	\N	\N	679584
1850	Kanmanam B.O		Malappuram	KERALA	Tirur	\N	\N	676551
1851	Kannamangalam B.O		Malappuram	KERALA	Tirurangadi	\N	\N	676304
1852	Klari B.O		Malappuram	KERALA	Tirur	\N	\N	676501
1853	Kottakkal S.O		Malappuram	KERALA	Tirur	\N	\N	676503
1854	Kuruga B.O		Malappuram	KERALA	Tirur	\N	\N	676551
1855	Marancheri S.O		Malappuram	KERALA	Ponani	\N	\N	679581
1856	Mooniyur S.O		Malappuram	KERALA	Tirurangadi	\N	\N	676311
1857	Polpakara B.O		Malappuram	KERALA	Ponnani	\N	\N	679576
1858	Vattamkulam S.O		Malappuram	KERALA	Ponani	\N	\N	679578
1859	Velimukku S.O		Malappuram	KERALA	Tirurangadi	\N	\N	676317
1860	Chathangottunada B.O		Kozhikode	KERALA	Vadakara	\N	\N	673513
1861	Cherumoth B.O		Kozhikode	KERALA	Vadakara	\N	\N	673517
1862	Edacheri North B.O		Kozhikode	KERALA	Vadakara	\N	\N	673502
1863	Edakulam  Koyilandi S.O		Kozhikode	KERALA	Koyilandi	\N	\N	673306
1864	Iringal S.O		Kozhikode	KERALA	Vadakara	\N	\N	673521
1865	Kadiyangad B.O		Kozhikode	KERALA	Koyilandi	\N	\N	673525
1866	Karayad B.O		Kozhikode	KERALA	Quilandy	\N	\N	673524
1867	Katameri B.O		Kozhikode	KERALA	Vadakara	\N	\N	673542
1868	Kayappanichi B.O		Kozhikode	KERALA	Vadakara	\N	\N	673505
1869	Kilinnanyam B.O		Kozhikode	KERALA	Quilandy	\N	\N	673525
1870	Kilur Meladi B.O		Kozhikode	KERALA	Koyilandi	\N	\N	673522
1871	Kollam S.O		Kozhikode	KERALA	Koyilandi	\N	\N	673307
1872	Koorachundu S.O		Kozhikode	KERALA	Koyilandi	\N	\N	673527
1873	Kottakkal-igl B.O		Kozhikode	KERALA	Quilandy	\N	\N	673521
1874	Kozhukkallur B.O		Kozhikode	KERALA	Quilandy	\N	\N	673524
1875	Kuttoth B.O		Kozhikode	KERALA	Quilandy	\N	\N	673524
1876	Mandarathur B.O		Kozhikode	KERALA	Vadakara	\N	\N	673105
1877	Mangad B.O		Kozhikode	KERALA	Quilandy	\N	\N	673574
1878	Marudonkara B.O		Kozhikode	KERALA	Vadakara	\N	\N	673513
1879	Mattanode B.O		Kozhikode	KERALA	Koyilandi	\N	\N	673527
1880	Muchukunnu B.O		Kozhikode	KERALA	Quilandy	\N	\N	673307
1881	Muttungal B.O		Kozhikode	KERALA	Vadakara	\N	\N	673106
1882	Peruvannamuzhi S.O		Kozhikode	KERALA	Koyilandi	\N	\N	673528
1883	Tharopoyil B.O		Kozhikode	KERALA	Vadakara	\N	\N	673541
1884	Thuvakkode B.O		Kozhikode	KERALA	Quilandy	\N	\N	673304
1885	Tikkoti S.O		Kozhikode	KERALA	Koyilandi	\N	\N	673529
1886	Vanimal B.O		Kozhikode	KERALA	Vadakara	\N	\N	673506
1887	Vatayam B.O		Kozhikode	KERALA	Vadakara	\N	\N	673507
1888	Vayikkilassery B.O		Kozhikode	KERALA	Vadakara	\N	\N	673104
1889	Vilangad B.O		Kozhikode	KERALA	Vadakara	\N	\N	673506
1890	Adukkath B.O		Kozhikode	KERALA	Vadakara	\N	\N	673508
1891	Avala B.O		Kozhikode	KERALA	Quilandy	\N	\N	673524
1892	Chakkittapara B.O		Kozhikode	KERALA	Quilandy	\N	\N	673526
1893	Chaniyankadavu B.O		Kozhikode	KERALA	Vadakara	\N	\N	673541
1894	Cheliya B.O		Kozhikode	KERALA	Quilandy	\N	\N	673306
1895	Chempanoda B.O		Kozhikode	KERALA	Koyilandi	\N	\N	673528
1896	Cheruvannur Meladi B.O		Kozhikode	KERALA	Koyilandi	\N	\N	673524
1897	Eramala B.O		Kozhikode	KERALA	Vadakara	\N	\N	673501
1898	Karandode B.O		Kozhikode	KERALA	Vadakara	\N	\N	673508
1899	Kolathur B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673315
1900	Kurichagam B.O		Kozhikode	KERALA	Vadakara	\N	\N	673508
1901	Maniyur B.O		Kozhikode	KERALA	Vadakara	\N	\N	673523
1902	Mannankavu B.O		Kozhikode	KERALA	Quilandy	\N	\N	673614
1903	Mennaniam B.O		Kozhikode	KERALA	Quilandy	\N	\N	673525
1904	Meppayil B.O		Kozhikode	KERALA	Vadakara	\N	\N	673104
1905	Meppayur S.O		Kozhikode	KERALA	Koyilandi	\N	\N	673524
1906	Modakkallur B.O		Kozhikode	KERALA	Quilandy	\N	\N	673315
1907	Mudavantheri B.O		Kozhikode	KERALA	Vadakara	\N	\N	673505
1908	Nadakkuthala B.O		Kozhikode	KERALA	Vadakara	\N	\N	673104
1909	Nedumparamba B.O		Kozhikode	KERALA	Vadakara	\N	\N	673506
1910	Panangad Qdi B.O		Kozhikode	KERALA	Koyilandi	\N	\N	673612
1911	Parakkadavu S.O		Kozhikode	KERALA	Vadakara	\N	\N	673509
1912	Perampra S.O		Kozhikode	KERALA	Koyilandi	\N	\N	673525
1913	Peruvattur B.O		Kozhikode	KERALA	Koyilandi	\N	\N	673620
1914	Poozhithode B.O		Kozhikode	KERALA	Quilandy	\N	\N	673528
1915	Puliyavil B.O		Kozhikode	KERALA	Vadakara	\N	\N	673509
1916	Puthur B.O		Kozhikode	KERALA	Vadakara	\N	\N	673104
1917	Thanakottur B.O		Kozhikode	KERALA	Vadakara	\N	\N	673509
1918	Urallur B.O		Kozhikode	KERALA	Quilandy	\N	\N	673620
1919	Vakayad B.O		Kozhikode	KERALA	Quilandy	\N	\N	673614
1920	Vayalada B.O		Kozhikode	KERALA	Quilandy	\N	\N	673574
1921	Vishnumangalam B.O		Kozhikode	KERALA	Vadakara	\N	\N	673506
1922	Arikulam B.O		Kozhikode	KERALA	Koyilandi	\N	\N	673620
1923	Atholi S.O		Kozhikode	KERALA	Koyilani	\N	\N	673315
1924	Azhiyur S.O		Kozhikode	KERALA	Vadakara	\N	\N	673309
1925	Cheekilode B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673315
1926	Cheekkonnummal B.O		Kozhikode	KERALA	Vadakara	\N	\N	673507
1927	Chenoli B.O		Kozhikode	KERALA	Koyilandi	\N	\N	673525
1928	Cherukad B.O		Kozhikode	KERALA	Quilandy	\N	\N	673527
1929	Chorode East B.O		Kozhikode	KERALA	Vadakara	\N	\N	673106
1930	Eramangalam B.O		Kozhikode	KERALA	Quilandy	\N	\N	673612
1931	Iringath B.O		Kozhikode	KERALA	Quilandy	\N	\N	673523
1932	Kakkattil S.O		Kozhikode	KERALA	Vadakara	\N	\N	673507
1933	Kallanode B.O		Kozhikode	KERALA	Quilandy	\N	\N	673615
1934	Karingad B.O		Kozhikode	KERALA	Vadakara	\N	\N	673513
1935	Kariyathankavu B.O		Kozhikode	KERALA	Quilandy	\N	\N	673612
1936	Karthikappally B.O		Kozhikode	KERALA	Vadakara	\N	\N	673542
1937	Karuvannur B.O		Kozhikode	KERALA	Quilandy	\N	\N	673614
1938	Katalur B.O		Kozhikode	KERALA	Koyilandi	\N	\N	673529
1939	Kavil B.O		Kozhikode	KERALA	Quilandy	\N	\N	673614
1940	Keezhil B.O		Kozhikode	KERALA	Vadakara	\N	\N	673104
1941	Kongannur B.O		Kozhikode	KERALA	Quilandy	\N	\N	673315
1942	Kurikkilad B.O		Kozhikode	KERALA	Vadakara	\N	\N	673104
1943	Kuttiadi S.O		Kozhikode	KERALA	Vadakara	\N	\N	673508
1944	Mudadi B.O		Kozhikode	KERALA	Quilandy	\N	\N	673307
1945	Muthukad B.O		Kozhikode	KERALA	Quilandy	\N	\N	673528
1946	Muyipoth B.O		Kozhikode	KERALA	Quilandy	\N	\N	673524
1947	Nadapuram S.O		Kozhikode	KERALA	Vadakara	\N	\N	673504
1948	Naduvathur B.O		Kozhikode	KERALA	Quilandy	\N	\N	673620
1949	Naluthara B.O		Mahe	PONDICHERRY	Mahe Ut	\N	\N	673310
1950	Onchiyam B.O		Kozhikode	KERALA	Vadakara	\N	\N	673308
1951	Oravil B.O		Kozhikode	KERALA	Quilandy	\N	\N	673614
1952	Pallikara B.O		Kozhikode	KERALA	Quilandy	\N	\N	673522
1953	Taliyil B.O		Kozhikode	KERALA	Vadakara	\N	\N	673508
1954	Thinur B.O		Kozhikode	KERALA	Vadakara	\N	\N	673507
1955	Thiruvallur S.O		Kozhikode	KERALA	Vadakara	\N	\N	673541
1956	Tuneri S.O		Kozhikode	KERALA	Vadakara	\N	\N	673505
1957	Vadakara Beach S.O		Kozhikode	KERALA	Vadakara	\N	\N	673103
1958	Velur West B.O		Kozhikode	KERALA	Quilandy	\N	\N	673315
1959	Chengaroth B.O		Kozhikode	KERALA	Quilandy	\N	\N	673528
1960	Chombala S.O		Kozhikode	KERALA	Vadakara	\N	\N	673308
1961	Edacheri S.O		Kozhikode	KERALA	Vadakara	\N	\N	673502
1962	Emmamparamba B.O		Kozhikode	KERALA	Quilandy	\N	\N	673574
1963	Iyyad B.O		Kozhikode	KERALA	Quilandy	\N	\N	673574
1964	Kappad B.O		Kozhikode	KERALA	Quilandy	\N	\N	673304
1965	Kayanna Bazar B.O		Kozhikode	KERALA	Quilandy	\N	\N	673525
1966	Kayanna S.O		Kozhikode	KERALA	Quilandy	\N	\N	673526
1967	Koothali B.O		Kozhikode	KERALA	Koyilandi	\N	\N	673525
1968	Kunnathara B.O		Kozhikode	KERALA	Koyilandi	\N	\N	673620
1969	Mahe S.O		Kozhikode	KERALA	Vadakara	\N	\N	673310
1970	Naderi B.O		Kozhikode	KERALA	Quilandy	\N	\N	673620
1971	Naduvannur S.O		Kozhikode	KERALA	Koyilandi	\N	\N	673614
1972	Nochat B.O		Kozhikode	KERALA	Quilandy	\N	\N	673614
1973	Pandakkal B.O		Pondicherry	PONDICHERRY	Ut Of Pondichery	\N	\N	673310
1974	Payyoli Angadi S.O		Kozhikode	KERALA	Koyilandi	\N	\N	673523
1975	Ponmeri Parambil B.O		Kozhikode	KERALA	Vadakara	\N	\N	673542
1976	Purakkad B.O		Kozhikode	KERALA	Quilandy	\N	\N	673522
1977	Thuruthiyad B.O		Kozhikode	KERALA	Quilandy	\N	\N	673612
1978	Vattoli B.O		Kozhikode	KERALA	Vadakara	\N	\N	673507
1979	Velom B.O		Kozhikode	KERALA	Vadakara	\N	\N	673508
1980	Abhayagiri B.O		Kozhikode	KERALA	Vadakara	\N	\N	673517
1981	Annasseri B.O		Kozhikode	KERALA	Kozhikode	\N	\N	673317
1982	Arur B.O		Kozhikode	KERALA	Vadakara	\N	\N	673507
1983	Avadukka B.O		Kozhikode	KERALA	Quilandy	\N	\N	673528
1984	Ayancheri B.O		Kozhikode	KERALA	Vadakara	\N	\N	673541
1985	Eravattur B.O		Kozhikode	KERALA	Koyilandi	\N	\N	673525
1986	Kakkancheri B.O		Kozhikode	KERALA	Quilandy	\N	\N	673620
1987	Kayakodi B.O		Kozhikode	KERALA	Vadakara	\N	\N	673508
1988	Kunduthode B.O		Kozhikode	KERALA	Vadakara	\N	\N	673513
1989	Mayyannur B.O		Kozhikode	KERALA	Vadakara	\N	\N	673542
1990	Mudadi North B.O		Kozhikode	KERALA	Quilandy	\N	\N	673307
1991	Mullambath B.O		Kozhikode	KERALA	Vadakara	\N	\N	673507
1992	Nittur B.O		Kozhikode	KERALA	Vadakara	\N	\N	673507
1993	Orkatteri S.O		Kozhikode	KERALA	Vadakara	\N	\N	673501
1994	Paleri B.O		Kozhikode	KERALA	Koyilandi	\N	\N	673508
1995	Pathiyarakkara B.O		Kozhikode	KERALA	Vadakara	\N	\N	673105
1996	Payyoli S.O		Kozhikode	KERALA	Quilandy	\N	\N	673522
1997	Perode B.O		Kozhikode	KERALA	Vadakara	\N	\N	673504
1998	Poothampara B.O		Kozhikode	KERALA	Vadakara	\N	\N	673513
1999	Puduppanam S.O		Kozhikode	KERALA	Vadakara	\N	\N	673105
2000	Purameri S.O		Kozhikode	KERALA	Vadakara	\N	\N	673503
2001	Siddhasamaj B.O		Kozhikode	KERALA	Vadakara	\N	\N	673104
2002	Thalakolathur S.O		Kozhikode	KERALA	Kozhikode	\N	\N	673317
2003	Thandorapara B.O		Kozhikode	KERALA	Koyilandi	\N	\N	673526
2004	Tiruvangoor B.O		Kozhikode	KERALA	Quilandy	\N	\N	673304
2005	Unnikulam S.O		Kozhikode	KERALA	Quilandy	\N	\N	673574
2006	Vadakara H.O		Kozhikode	KERALA	Vadakara	\N	\N	673101
2007	Vannathichira B.O		Kozhikode	KERALA	Vadakara	\N	\N	673513
2008	Varikoli B.O		Kozhikode	KERALA	Vadakara	\N	\N	673506
2009	Avitanallur B.O		Kozhikode	KERALA	Koyilandi	\N	\N	673614
2010	Cheekonnummal  West B.O		Kozhikode	KERALA	Vadakara	\N	\N	673507
2011	Chemmarathur B.O		Kozhikode	KERALA	Vadakara	\N	\N	673104
2012	Ekarool B.O		Kozhikode	KERALA	Koyilandi	\N	\N	673574
2013	Kallunira B.O		Kozhikode	KERALA	Vadakara	\N	\N	673517
2014	Kavilampara S.O		Kozhikode	KERALA	Vadakara	\N	\N	673513
2015	Kizhpayur B.O		Kozhikode	KERALA	Quilandy	\N	\N	673524
2016	Kodiyura B.O		Kozhikode	KERALA	Vadakara	\N	\N	673506
2017	Korothroad B.O		Kozhikode	KERALA	Vadakara	\N	\N	673309
2018	Kottappalli B.O		Kozhikode	KERALA	Vadakara	\N	\N	673542
2019	Kottur B.O		Kozhikode	KERALA	Koyilandi	\N	\N	673614
2020	Koyilandi H.O		Kozhikode	KERALA	Koyilandi	\N	\N	673305
2021	Moilothara B.O		Kozhikode	KERALA	Vadakara	\N	\N	673513
2022	Moolad B.O		Kozhikode	KERALA	Quilandy	\N	\N	673614
2023	Muthuuvana B.O		Kozhikode	KERALA	Koyilandi	\N	\N	673523
2024	Muthuvadathur B.O		Kozhikode	KERALA	Vadakara	\N	\N	673503
2025	Muthuvannacha B.O		Kozhikode	KERALA	Quilandy	\N	\N	673508
2026	Muttungal West B.O		Kozhikode	KERALA	Vadakara	\N	\N	673106
2027	Paleri Town B.O		Kozhikode	KERALA	Quilandy	\N	\N	673508
2028	Quilandibazar S.O		Kozhikode	KERALA	Koyilandi	\N	\N	673620
2029	Rayarangoth B.O		Kozhikode	KERALA	Vadakara	\N	\N	673102
2030	Valayam S.O		Kozhikode	KERALA	Vadakara	\N	\N	673517
2031	Balusseri S.O		Kozhikode	KERALA	Quilandy	\N	\N	673612
2032	Cherandathur B.O		Kozhikode	KERALA	Vadakara	\N	\N	673541
2033	Cherapuram B.O		Kozhikode	KERALA	Vadakara	\N	\N	673507
2034	Chingapuram B.O		Kozhikode	KERALA	Quilandy	\N	\N	673529
2035	Chorode S.O		Kozhikode	KERALA	Vadakara	\N	\N	673106
2036	Chuzhali B.O		Kozhikode	KERALA	Vadakara	\N	\N	673517
2037	Indira Nagar B.O		Kozhikode	KERALA	Vadakara	\N	\N	673506
2038	Iringannur B.O		Kozhikode	KERALA	Vadakara	\N	\N	673505
2039	Kallachi S.O		Kozhikode	KERALA	Vadakara	\N	\N	673506
2040	Kalpathur B.O		Kozhikode	KERALA	Quilandy	\N	\N	673524
2041	Karumala B.O		Kozhikode	KERALA	Koyilandi	\N	\N	673612
2042	Kinalur B.O		Kozhikode	KERALA	Koyilandi	\N	\N	673612
2043	Kokkallur B.O		Kozhikode	KERALA	Koyilandi	\N	\N	673612
2044	Kotancheri B.O		Kozhikode	KERALA	Vadakara	\N	\N	673503
2045	Kuningad B.O		Kozhikode	KERALA	Vadakara	\N	\N	673503
2046	Kurinhaliyode B.O		Kozhikode	KERALA	Vadakara	\N	\N	673542
2047	Kuruvangad B.O		Kozhikode	KERALA	Koyilandi	\N	\N	673620
2048	Melur B.O		Kozhikode	KERALA	Quilandy	\N	\N	673306
2049	Mokeri Nadapuram B.O		Kozhikode	KERALA	Vadakara	\N	\N	673507
2050	Padiripetta B.O		Kozhikode	KERALA	Vadakara	\N	\N	673507
2051	Poolakkul B.O		Kozhikode	KERALA	Vadakara	\N	\N	673507
2052	Talayad B.O		Kozhikode	KERALA	Koyilandi	\N	\N	673574
2053	Thodannur B.O		Kozhikode	KERALA	Vadakara	\N	\N	673541
2054	Tiruvode B.O		Kozhikode	KERALA	Quilandy	\N	\N	673614
2055	Ulliyeri B.O		Kozhikode	KERALA	Quilandy	\N	\N	673620
2056	Valliyad B.O		Kozhikode	KERALA	Vadakara	\N	\N	673542
2057	Velom Peruvayal B.O		Kozhikode	KERALA	Vadakara	\N	\N	673508
2058	Villyappalli S.O		Kozhikode	KERALA	Vadakara	\N	\N	673542
2059	Akkal B.O		Kozhikode	KERALA	Vadakara	\N	\N	673513
2060	Ayanikkad B.O		Kozhikode	KERALA	Quilandy	\N	\N	673521
2061	Bhumivathukkal B.O		Kozhikode	KERALA	Vadakara	\N	\N	673517
2062	Chappanthottam B.O		Kozhikode	KERALA	Vadakara	\N	\N	673513
2063	Chekkiyad B.O		Kozhikode	KERALA	Vadakara	\N	\N	673509
2064	Chelakkad B.O		Kozhikode	KERALA	Vadakara	\N	\N	673506
2065	Chemancheri S.O		Kozhikode	KERALA	Koyilandi	\N	\N	673304
2066	Edavarad B.O		Kozhikode	KERALA	Quilandy	\N	\N	673525
2067	Iyyangode B.O		Kozhikode	KERALA	Vadakara	\N	\N	673504
2068	Kakkayam S.O		Kozhikode	KERALA	Quilandy	\N	\N	673615
2069	Kannadipoil B.O		Kozhikode	KERALA	Quilandy	\N	\N	673612
2070	Kannookkara B.O		Kozhikode	KERALA	Vadakara	\N	\N	673102
2071	Katcheri B.O		Kozhikode	KERALA	Vadakara	\N	\N	673502
2072	Keezhariyur B.O		Kozhikode	KERALA	Koyilandi	\N	\N	673307
2073	Kolakkad B.O		Kozhikode	KERALA	Quilandy	\N	\N	673315
2074	Kunnummakkara B.O		Kozhikode	KERALA	Vadakara	\N	\N	673308
2075	Madappalli College S.O		Kozhikode	KERALA	Vadakara	\N	\N	673102
2076	Memunda B.O		Kozhikode	KERALA	Vadakara	\N	\N	673104
2077	Naripetta B.O		Kozhikode	KERALA	Vadakara	\N	\N	673506
2078	Nitumannur B.O		Kozhikode	KERALA	Vadakara	\N	\N	673507
2079	Nut Street S.O		Kozhikode	KERALA	Vadakara	\N	\N	673104
2080	Palayad Nada B.O		Kozhikode	KERALA	Vadakara	\N	\N	673521
2081	Pallur B.O		Mahe	PONDICHERRY	Mahe Ut	\N	\N	673310
2082	Pasukkadavu B.O		Kozhikode	KERALA	Vadakara	\N	\N	673513
2083	Punath B.O		Kozhikode	KERALA	Quilandy	\N	\N	673614
2084	Vattoli Bazar B.O		Kozhikode	KERALA	Quilandy	\N	\N	673612
2085	Alappuzha Mullackal S.O		Alappuzha	KERALA	Ambalappuzha	\N	\N	688011
2086	Alappuzha North S.O		Alappuzha	KERALA	Ambalapuzh A	\N	\N	688007
2087	Arthingal S.O		Alappuzha	KERALA	Cherthala	\N	\N	688530
2088	Cherukara Kuttanad B.O		Alappuzha	KERALA	Kuttanad	\N	\N	688506
2089	Kavalam S.O		Alappuzha	KERALA	Kuttanad	\N	\N	688506
2090	Kochuramapuram EDB.O		Alappuzha	KERALA	Cherthala	\N	\N	688541
2091	Kunnumma Thakazhy B.O		Alappuzha	KERALA	Kuttanad	\N	\N	688562
2092	Mannancherry S.O		Alappuzha	KERALA	Ambalappuzha	\N	\N	688538
2093	Mararikulam North EDB.O		Alappuzha	KERALA	Cherthala	\N	\N	688523
2094	Moncombu S.O		Alappuzha	KERALA	Kuttanad	\N	\N	688502
2095	Pallippuram S.O		Alappuzha	KERALA	Cherthala	\N	\N	688541
2096	Poochackal S.O		Alappuzha	KERALA	Cherthala	\N	\N	688526
2097	Pullangadi B.O		Alappuzha	KERALA	Kuttanad	\N	\N	688505
2098	Purakad EDB.O		Alappuzha	KERALA	Ambalappuzha	\N	\N	688561
2099	Sethulekshmipuram S.O		Alappuzha	KERALA	Cherthala	\N	\N	688523
2100	Sreenarayanapuram S.O		Alappuzha	KERALA	Cherthala	\N	\N	688582
2101	Thottuvathala B.O		Alappuzha	KERALA	Kuttanad	\N	\N	688501
2102	Thuravoor South B.O		Alappuzha	KERALA	Cherthala	\N	\N	688532
2103	Eramallur S.O		Alappuzha	KERALA	Cherthala	\N	\N	688537
2104	Kalavamkodam B.O		Alappuzha	KERALA	Cherthala	\N	\N	688524
2105	Karumady EDB.O		Alappuzha	KERALA	Ambalapuzha	\N	\N	688561
2106	Kokkothamangalam B.O		Alappuzha	KERALA	Cherthala	\N	\N	688527
2107	Naduvathnagar EDB.O		Alappuzha	KERALA	Cherthala	\N	\N	688526
2108	Parayakad B.O		Alappuzha	KERALA	Cherthala	\N	\N	688540
2109	Punnakunnathussery B.O		Alappuzha	KERALA	Kuttanad	\N	\N	688504
2110	Thondankulangara S.O		Alappuzha	KERALA	Ambalappuzha	\N	\N	688013
2111	Valamangalam B.O		Alappuzha	KERALA	Cherthala	\N	\N	688532
2112	Vattayal Ward B.O		Alappuzha	KERALA	Ambalapuzha	\N	\N	688002
2113	Champakulam East B.O		Alappuzha	KERALA	Kuttanad	\N	\N	688505
2114	Kadakkarapally S.O		Alappuzha	KERALA	Cherthala	\N	\N	688529
2115	Kanichukulangara EDB.O		Alappuzha	KERALA	Cherthala	\N	\N	688582
2116	Komalapuram B.O		Alappuzha	KERALA	Ambalapuzha	\N	\N	688006
2117	Kuppappuram B.O		Alappuzha	KERALA	Ambalapuzha	\N	\N	688011
2118	Mayithara Market S.O		Alappuzha	KERALA	Cherthala	\N	\N	688539
2119	Thirumalabhagom S.O		Alappuzha	KERALA	Cherthala	\N	\N	688540
2120	Varanadu EDB.O		Alappuzha	KERALA	Cherthala	\N	\N	688539
2121	Alappuzha Medical College S.O		Alappuzha	KERALA	Ambalappuzha	\N	\N	688005
2122	Arookutty S.O		Alappuzha	KERALA	Cherthala	\N	\N	688535
2123	Chathurthiakary B.O		Alappuzha	KERALA	Kuttanad	\N	\N	688502
2124	Chennamkary East B.O		Alappuzha	KERALA	Kuttanad	\N	\N	688506
2125	Cherthala Cutcherry S.O		Alappuzha	KERALA	Cherthala	\N	\N	688524
2126	Kainakary East B.O		Alappuzha	KERALA	Kuttanad	\N	\N	688501
2127	Kanjiramchira B.O		Alappuzha	KERALA	Ambalappuzha	\N	\N	688007
2128	Kannady B.O		Alappuzha	KERALA	Kuttanad	\N	\N	688504
2129	Kavalam North B.O		Alappuzha	KERALA	Kuttanad	\N	\N	688506
2130	Kelamangalam B.O		Alappuzha	KERALA	Kuttanad	\N	\N	688562
2131	Manappuram EDB.O		Alappuzha	KERALA	Cherthala	\N	\N	688526
2132	Maruthorvattom EDB.O		Alappuzha	KERALA	Cherthala	\N	\N	688539
2133	Moncombu Thekkekara S.O		Alappuzha	KERALA	Kuttanad	\N	\N	688503
2134	Olavaipu B.O		Alappuzha	KERALA	Cherthala	\N	\N	688526
2135	Pallithode B.O		Alappuzha	KERALA	Cherthala	\N	\N	688540
2136	Perumbalam S.O		Alappuzha	KERALA	Cherthala	\N	\N	688570
2137	Pollethai EDB.O		Alappuzha	KERALA	Ambalappuzha	\N	\N	688522
2138	Thaickal EDB.O		Alappuzha	KERALA	Cherthala	\N	\N	688530
2139	Vaduthala Jetty B.O		Alappuzha	KERALA	Cherthala	\N	\N	688535
2140	Aroor S.O		Alappuzha	KERALA	Cherthla	\N	\N	688534
2141	Chennamkary B.O		Alappuzha	KERALA	Kuttanad	\N	\N	688501
2142	Cherthala H.O		Alappuzha	KERALA	Cherthala	\N	\N	688524
2143	Chethy GDB.O		Alappuzha	KERALA	Cherthala	\N	\N	688530
2144	Chirayakom B.O		Alappuzha	KERALA	Kuttanad	\N	\N	688562
2145	Ezhupunna South EDB.O		Alappuzha	KERALA	Cherthala	\N	\N	688537
2146	Kottankulangara B.O		Alappuzha	KERALA	Ambalappuzha	\N	\N	688006
2147	Muhamma S.O		Alappuzha	KERALA	Cherthala	\N	\N	688525
2148	Muttathiparambu B.O		Alappuzha	KERALA	Cherthala	\N	\N	688527
2149	Pathirappally S.O		Alappuzha	KERALA	Ambalapuzha	\N	\N	688521
2150	Pattanacaud S.O		Alappuzha	KERALA	Cherthala	\N	\N	688531
2151	Pazhaveedu S.O		Alappuzha	KERALA	Ambalapuzha	\N	\N	688009
2152	Ponnad B.O		Alappuzha	KERALA	Ambalappuzha	\N	\N	688538
2153	Thirunallur EDB.O		Alappuzha	KERALA	Cherthala	\N	\N	688541
2154	Thuravoor S.O		Alappuzha	KERALA	Cherthala	\N	\N	688532
2155	Thycattussery S.O		Alappuzha	KERALA	Cherthala	\N	\N	688528
2156	Vayalar S.O		Alappuzha	KERALA	Cherthala	\N	\N	688536
2157	Vysombhagom B.O		Alappuzha	KERALA	Kuttanad	\N	\N	688005
2158	Alappuzha Bazar S.O		Alappuzha	KERALA	Ambalapuzha	\N	\N	688012
2159	Alappuzha Collectorate S.O		Alappuzha	KERALA	Ambalapuzha	\N	\N	688001
2160	Ambalapuzha S.O		Alappuzha	KERALA	Ambalapuzha	\N	\N	688561
2161	Aryad North EDB.O		Alappuzha	KERALA	Mararikulam	\N	\N	688538
2162	Chempumpuram B.O		Alappuzha	KERALA	Kuttanad	\N	\N	688505
2163	Cherthala South EDB.O		Alappuzha	KERALA	Cherthala	\N	\N	688539
2164	Illichira B.O		Alappuzha	KERALA	Ambalappuzha	\N	\N	688561
2165	Karikad B.O		Alappuzha	KERALA	Cherthala	\N	\N	688527
2166	Narakathara B.O		Alappuzha	KERALA	Kuttanad	\N	\N	688506
2167	Panavally EDB.O		Alappuzha	KERALA	Cherthala	\N	\N	688526
2168	Thakazhy S.O		Alappuzha	KERALA	Kuttanad	\N	\N	688562
2169	Thiruvampady Junction S.O		Alappuzha	KERALA	Ambalapuha	\N	\N	688002
2170	Thottappally EDB.O		Alappuzha	KERALA	Ambalapuzha	\N	\N	688561
2171	Vadackal B.O		Alappuzha	KERALA	Ambalapuzha	\N	\N	688003
2172	Varanam S.O		Alappuzha	KERALA	Cherthala	\N	\N	688555
2173	Vettackal EDB.O		Alappuzha	KERALA	Cherthala	\N	\N	688529
2174	Alappuzha District Hospital S.O		Alappuzha	KERALA	Ambalapuzha	\N	\N	688011
2175	Alappuzha H.O		Alappuzha	KERALA	Ambalapuzha	\N	\N	688001
2176	Alappuzha Iron Bridge S.O		Alappuzha	KERALA	Ambalapuzha	\N	\N	688011
2177	Andhakaranazhy B.O		Alappuzha	KERALA	Cherthala	\N	\N	688531
2178	Champakulam S.O		Alappuzha	KERALA	Kuttanad	\N	\N	688505
2179	Chungom B.O		Alappuzha	KERALA	Ambalappuzha	\N	\N	688011
2180	Kakkazhom B.O		Alappuzha	KERALA	Ambalappuzha	\N	\N	688005
2181	Kalavoor S.O		Alappuzha	KERALA	Ambalapuzha	\N	\N	688522
2182	Kanjipadom B.O		Alappuzha	KERALA	Ambalappuzha	\N	\N	688005
2183	Kattoor Kalavoor EDB.O		Alappuzha	KERALA	Ambalapuzha	\N	\N	688522
2184	Kayalpuram B.O		Alappuzha	KERALA	Kuttanad	\N	\N	688504
2185	Kuruppankulangara B.O		Alappuzha	KERALA	Cherthala	\N	\N	688539
2186	Kuttamangalam B.O		Alappuzha	KERALA	Kuttanad	\N	\N	688501
2187	Nedumudy EDB.O		Alappuzha	KERALA	Kuttanad	\N	\N	688503
2188	Pulincunnu S.O		Alappuzha	KERALA	Kuttanad	\N	\N	688504
2189	Punnapra S.O		Alappuzha	KERALA	Ambalapuzha	\N	\N	688004
2190	Sanathanapuram S.O		Alappuzha	KERALA	Ambalapuzha	\N	\N	688003
2191	Thanneermukkom S.O		Alappuzha	KERALA	Cherthala	\N	\N	688527
2192	Thumpoly S.O		Alappuzha	KERALA	Ambalapuzha	\N	\N	688008
2193	Ambalapuzha East EDB.O		Alappuzha	KERALA	Ambalappuzha	\N	\N	688561
2194	Avalukkunnu S.O		Alappuzha	KERALA	Ambalapuzha	\N	\N	688006
2195	Chandiroor EDB.O		Alappuzha	KERALA	Cherthala	\N	\N	688537
2196	Ezhupunna EDB.O		Alappuzha	KERALA	Cherthala	\N	\N	688537
2197	Kainakary S.O		Alappuzha	KERALA	Kuttanad	\N	\N	688501
2198	Kannady West B.O		Alappuzha	KERALA	Kuttanad	\N	\N	688504
2199	Kannankara B.O		Alappuzha	KERALA	Cherthala	\N	\N	688527
2200	Kommady Ward B.O		Alappuzha	KERALA	Ambalappuzha	\N	\N	688007
2201	Kuthiathode S.O		Alappuzha	KERALA	Cherthala	\N	\N	688533
2202	Pandarakulam B.O		Alappuzha	KERALA	Kuttanad	\N	\N	688505
2203	Ponga B.O		Alappuzha	KERALA	Kuttanad	\N	\N	688503
2204	Punnakunnathussery South B.O		Alappuzha	KERALA	Kuttanad	\N	\N	688504
2205	Punnapra North S.O		Alappuzha	KERALA	Ambalapuzha	\N	\N	688014
2206	Thathampally S.O		Alappuzha	KERALA	Ambalappuzha	\N	\N	688013
2207	Trichattukulam EDB.O		Alappuzha	KERALA	Cherthala	\N	\N	688526
2208	Vembanad Kayal B.O		Alappuzha	KERALA	Ambalapuzha	\N	\N	688006
2209	Asamannoor S.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683549
2210	Cherai S.O		Ernakulam	KERALA	Paravur	\N	\N	683514
2211	Desom B.O		Ernakulam	KERALA	Aluva	\N	\N	683102
2212	Edayar B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686662
2213	Karamala B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686662
2214	Karukadom B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686691
2215	Koonammavu S.O		Ernakulam	KERALA	Paravur	\N	\N	683518
2216	Kurumassery S.O		Ernakulam	KERALA	Aluva	\N	\N	683579
2217	Madakkathanam B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686670
2218	Manickamangalam B.O		Ernakulam	KERALA	Aluva	\N	\N	683574
2219	Mannam Paravur S.O		Ernakulam	KERALA	Paravur	\N	\N	683520
2220	Marampally B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683105
2221	Meenkunnam B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686672
2222	Mullapuzhachal B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686670
2223	Mutholapuram B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686665
2224	Nechoor B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686664
2225	Neriamangalam B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686693
2226	Njayapalli B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686681
2227	Pampakuda S.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686667
2228	Pattimattam B.O		Ernakulam	KERALA	Aluva	\N	\N	683562
2229	Perumbavoor H.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683542
2230	Plamudi B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686692
2231	Pulinthanam B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686671
2232	Pulluvazhi B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683541
2233	Thottakkattukara S.O		Ernakulam	KERALA	Aluva	\N	\N	683108
2234	Thottumughom S.O		Ernakulam	KERALA	Aluva	\N	\N	683105
2235	Thuruthy B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683545
2236	Vadakkumpuram S.O		Ernakulam	KERALA	Paravur	\N	\N	683521
2237	Vappalassery B.O		Ernakulam	KERALA	Aluva	\N	\N	683572
2238	Vempilly B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683565
2239	Allapra B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683556
2240	Aruvappara B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683545
2241	Avoly B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686670
2242	Chengamanad S.O		Ernakulam	KERALA	Paravur	\N	\N	683578
2243	Edathala S.O		Ernakulam	KERALA	Aluva	\N	\N	683561
2244	Ezhikkara B.O		Ernakulam	KERALA	Paravur	\N	\N	683513
2245	Iringole B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683545
2246	Kadayirippu B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	682311
2247	Kakkoor B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686662
2248	Kaloor B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686668
2249	Kidangoor B.O		Ernakulam	KERALA	Aluva	\N	\N	683572
2250	Kodanad B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683544
2251	Malayidumthuruth B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683561
2252	Manary B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686673
2253	Mannathur B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686667
2254	Mudikkal S.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683547
2255	Muppathadam S.O		Ernakulam	KERALA	Paravur	\N	\N	683110
2256	Muvattupuzha H.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686661
2257	Neendapara B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686693
2258	Palakuzha B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686662
2259	Paravur Market S.O		Ernakulam	KERALA	Paravur	\N	\N	683513
2260	Pareekanni B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686693
2261	Pazhoor B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686664
2262	Thattekkad B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686681
2263	Thrikkalathoor B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683541
2264	Union Christian College S.O		Ernakulam	KERALA	Aluva	\N	\N	683102
2265	Urulanthanni B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686681
2266	Vengoor S.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683546
2267	West Veliyathunad B.O		Ernakulam	KERALA	Paravur	\N	\N	683511
2268	Yordhanapuram B.O		Ernakulam	KERALA	Aluva	\N	\N	683574
2269	Alattuchira B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683544
2270	Athani S.O (Ernakulam)		Ernakulam	KERALA	Aluva	\N	\N	683585
2271	Ayyampuzha B.O		Ernakulam	KERALA	Aluva	\N	\N	683581
2272	Chelad Junction S.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686681
2273	Chendamangalam S.O		Ernakulam	KERALA	Paravur	\N	\N	683512
2274	Illambakapalli B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683544
2275	Inchathotty B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686681
2276	Kadavoor B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686671
2277	Karukappilli B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	682311
2278	Keezhillam S.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683541
2279	Koovappady S.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683544
2280	Kothamangalam College S.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686666
2281	Kuttampuzha B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686681
2282	Manidu B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686664
2283	Marady East B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686673
2284	Mookkannur S.O		Ernakulam	KERALA	Aluva	\N	\N	683577
2285	Moothakunnam S.O		Ernakulam	KERALA	Paravur	\N	\N	683516
2286	Naval Armament Depot - Aluva S.O		Ernakulam	KERALA	Aluva	\N	\N	683563
2287	Nayathode B.O		Ernakulam	KERALA	Aluva	\N	\N	683572
2288	Nellad B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	686669
2289	Okkal S.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683550
2290	Oonnukal B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686693
2291	Paniely B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683546
2292	Pooyamkutty B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686681
2293	Puliyanam B.O		Ernakulam	KERALA	Aluva	\N	\N	683572
2294	Puthenvelikkara S.O		Ernakulam	KERALA	Paravur	\N	\N	683594
2295	S.Aduvassery B.O		Ernakulam	KERALA	Paravur	\N	\N	683578
2296	Thrikkariyoor S.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686692
2297	Thuravoor B.O		Ernakulam	KERALA	Aluva	\N	\N	683572
2298	Uliyannoor B.O		Ernakulam	KERALA	Aluva	\N	\N	683108
2299	Vadattupara B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686681
2300	Vaikkara B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683549
2301	Varapetty B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686691
2302	Vengola B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683556
2303	Airoopadam B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686692
2304	Angamally S.O		Ernakulam	KERALA	Paravur	\N	\N	683572
2305	Bhoothathankettu B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686681
2306	Chathamattam B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686671
2307	Chully B.O		Ernakulam	KERALA	Aluva	\N	\N	683581
2308	Kalampoor B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686664
2309	Karukutty S.O		Ernakulam	KERALA	Aluva	\N	\N	683576
2310	Keerampara B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686681
2311	Koovappara B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686681
2312	Kunjithai B.O		Ernakulam	KERALA	Paravur	\N	\N	683522
2313	Kunnackal S.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	682316
2314	Kuthiathode(EKM) B.O		Ernakulam	KERALA	Paravur	\N	\N	683594
2315	Mamalakandom B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686681
2316	Mazhuvannoor B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	686669
2317	Mazhuvannoor South B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	686669
2318	Mekkadambu B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	682316
2319	Memadangu B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686672
2320	Methala B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683545
2321	Muvattupuzha Market S.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686673
2322	Onakkoor B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686667
2323	Panipra B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686692
2324	Paravur S.O (Ernakulam)		Ernakulam	KERALA	Paravur	\N	\N	683513
2325	Perumballoor B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686673
2326	Pezhakkappilly B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686673
2327	Piravom S.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686664
2328	Ponjassery B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683547
2329	Ramamangalam S.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686663
2330	Thabore B.O		Ernakulam	KERALA	Aluva	\N	\N	683577
2331	Thaikkattukara S.O		Ernakulam	KERALA	Aluva	\N	\N	683106
2332	Vellarappilly South B.O		Ernakulam	KERALA	Aluva	\N	\N	683580
2333	Airapuram B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683541
2334	Anchelpetty B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686667
2335	Binanipuram S.O		Ernakulam	KERALA	Paravur	\N	\N	683502
2336	Cheruvattoor B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686691
2337	Choondakuzhy B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683546
2338	Enanalloor B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686673
2339	Iramalloor B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686691
2340	Kadakkanad B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	682311
2341	Kalady Plantation B.O		Ernakulam	KERALA	Aluva	\N	\N	683581
2342	Kalloorkkad S.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686668
2343	Kottappady B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686692
2344	Kumarapuram S.O (Ernakulam)		Ernakulam	KERALA	Kunnathunad	\N	\N	683565
2345	Kunnukara B.O		Ernakulam	KERALA	Paravur	\N	\N	683578
2346	Mamalassery B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686663
2347	Manjapra S.O		Ernakulam	KERALA	Aluva	\N	\N	683581
2348	Muvattupuzha Bazar B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686673
2349	Nadukani B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686691
2350	Neeleeswaram B.O		Ernakulam	KERALA	Aluva	\N	\N	683574
2351	Ooramana B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686663
2352	Paduvapuram B.O		Ernakulam	KERALA	Aluva	\N	\N	683576
2353	Parakkadavu B.O		Ernakulam	KERALA	Aluva	\N	\N	683579
2354	Pazhamthottam B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683565
2355	Peringala B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683565
2356	Perumbadavam B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686665
2357	Perumbavoor South S.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683542
2358	Pindimana B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686692
2359	Piraroor B.O		Ernakulam	KERALA	Aluva	\N	\N	683574
2360	Puthupadi B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686673
2361	Rayamangalam B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683545
2362	Rayonpuram S.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683543
2363	Thazhvankunnam B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686668
2364	Vazhakulam S.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686670
2365	West Kadungalloor B.O		Ernakulam	KERALA	Paravur	\N	\N	683110
2366	Cheranalloor(PBR) B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683544
2367	Edathala North B.O		Ernakulam	KERALA	Aluva	\N	\N	683561
2368	Edavoor B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683544
2369	Elanji S.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686665
2370	Elavoor B.O		Ernakulam	KERALA	Aluva	\N	\N	683572
2371	Idamalayar B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686681
2372	Kadalikkad B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686670
2373	Kadamattam B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	682311
2374	Kaitharam S.O		Ernakulam	KERALA	Paravur	\N	\N	683519
2375	Kakkad B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686664
2376	Kizhakkambalam S.O		Ernakulam	KERALA	Aluva	\N	\N	683562
2377	Kizhmuri B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686663
2378	Kochi Airport S.O		Ernakulam	KERALA	Aluva	\N	\N	683111
2379	Koothattukulam S.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686662
2380	Kothamangalam Bazar B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686691
2381	Kuruppampady S.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683545
2382	Malayattoor S.O		Ernakulam	KERALA	Aluva	\N	\N	683587
2383	Maliankara B.O		Ernakulam	KERALA	Paravur	\N	\N	683516
2384	Mattoor B.O		Ernakulam	KERALA	Aluva	\N	\N	683574
2385	Nedungapra B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683545
2386	Nellikuzhy B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686691
2387	Nellimattam S.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686693
2388	Oliyapuram B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686662
2389	Paingattoor B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686671
2390	South Vazhakulam B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683105
2391	Thalakode B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686693
2392	Thathappilly B.O		Ernakulam	KERALA	Paravur	\N	\N	683520
2393	Varapuzha Landing B.O		Ernakulam	KERALA	Paravur	\N	\N	683517
2394	Vazhappilly East B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686673
2395	Vettampara B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686681
2396	Alangad S.O		Ernakulam	KERALA	Paravur	\N	\N	683511
2397	Aluva Bazar S.O		Ernakulam	KERALA	Aluva	\N	\N	683101
2398	Ayavana B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686668
2399	Azhakam B.O		Ernakulam	KERALA	Aluva	\N	\N	683577
2400	Elanthikara B.O		Ernakulam	KERALA	Paravur	\N	\N	683594
2401	Ezhattumugham B.O		Ernakulam	KERALA	Aluva	\N	\N	683577
2402	Kalady S.O		Ernakulam	KERALA	Aluva	\N	\N	683574
2403	Kanjoor S.O		Ernakulam	KERALA	Aluva	\N	\N	683575
2404	Karimpana B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686662
2405	Kavakkad B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686668
2406	Kizhakompu B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686662
2407	Kongorpilly B.O		Ernakulam	KERALA	Paravur	\N	\N	683518
2408	Kottuvally B.O		Ernakulam	KERALA	Paravur	\N	\N	683519
2409	Kozhipilly B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686691
2410	Malipara B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686681
2411	Manikinar B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686693
2412	Mudavoor S.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686669
2413	Mulavoor B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686673
2414	Nirmala B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686673
2415	North Piramadom B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686667
2416	Palliport S.O		Ernakulam	KERALA	Kochi	\N	\N	683515
2417	Pandappily B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686672
2418	Parappuram B.O		Ernakulam	KERALA	Aluva	\N	\N	683575
2419	Thekkenmarady B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686673
2420	Vadakkekara S.O		Ernakulam	KERALA	Paravur	\N	\N	683522
2421	Valayanchirangara S.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683556
2422	Vattaparambu B.O		Ernakulam	KERALA	Aluva	\N	\N	683579
2423	Vengola West B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683556
2424	Vilangu B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683561
2425	Aimurikara B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683544
2426	Airoor B.O		Ernakulam	KERALA	Paravur	\N	\N	683579
2427	Aluva H.O		Ernakulam	KERALA	Aluva	\N	\N	683101
2428	Aluva Town Bus Stand S.O		Ernakulam	KERALA	Aluva	\N	\N	683101
2429	Aluva-asokapuram B.O		Ernakulam	KERALA	Aluva	\N	\N	683101
2430	Anappara-kalady B.O		Ernakulam	KERALA	Aluva	\N	\N	683581
2431	Angamally South S.O		Ernakulam	KERALA	Aluva	\N	\N	683573
2432	Arakuzha S.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686672
2433	Chowara S.O		Ernakulam	KERALA	Aluva	\N	\N	683571
2434	Erumathala S.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683112
2435	Gothuruthy B.O		Ernakulam	KERALA	Paravur	\N	\N	683516
2436	Karumalloor B.O		Ernakulam	KERALA	Paravur	\N	\N	683511
2437	Kinginimattom B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	682311
2438	Kolenchery S.O		Ernakulam	KERALA	Kunnathunad	\N	\N	682311
2439	Kombanad B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683546
2440	Koovalloor B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686671
2441	Kothamangalam S.O (Ernakulam)		Ernakulam	KERALA	Kothamangalam	\N	\N	686691
2442	Kuthukuzhy B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686691
2443	Marika B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686662
2444	Mekkad S.O		Ernakulam	KERALA	Aluva	\N	\N	683589
2445	Mudakuzha B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	683546
2446	Mulakulam B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686664
2447	Naduvattam B.O		Ernakulam	KERALA	Aluva	\N	\N	683574
2448	Nagapuzha B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686668
2449	Nanthiattukunnam B.O		Ernakulam	KERALA	Paravur	\N	\N	683513
2450	Nedumbassery B.O		Ernakulam	KERALA	Aluva	\N	\N	683585
2451	Neericode B.O		Ernakulam	KERALA	Paravur	\N	\N	683511
2452	Pallarimangalam B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686671
2453	Panaikulam B.O		Ernakulam	KERALA	Paravur	\N	\N	683511
2454	Paravur Town S.O		Ernakulam	KERALA	Paravur	\N	\N	683513
2455	Periapuram B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686667
2456	Perumannoor(KGM) B.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686693
2457	Pothanicaud S.O		Ernakulam	KERALA	Kothamangalam	\N	\N	686671
2458	Randar B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686673
2459	Sreemoolanagaram S.O		Ernakulam	KERALA	Aluva	\N	\N	683580
2460	Thirumarady B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686662
2461	Thuravumkara B.O		Ernakulam	KERALA	Aluva	\N	\N	683575
2462	Vadakode-vazhakulam B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	686670
2463	Varapuzha S.O		Ernakulam	KERALA	Paravur	\N	\N	683517
2464	Changanacherry College S.O		Kottayam	KERALA	Changanassery	\N	\N	686101
2465	Changanacherry Industrialnagar S.O		Kottayam	KERALA	Changanassery	\N	\N	686106
2466	Cheeranchira B.O		Kottayam	KERALA	Changanassery	\N	\N	686106
2467	Elamkadu B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686514
2468	Elampally B.O		Kottayam	KERALA	Kottayam	\N	\N	686503
2469	Ithithanam B.O		Kottayam	KERALA	Changanassery	\N	\N	686535
2470	Kanamala B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686510
2471	Karukachal S.O		Kottayam	KERALA	Changanacherry	\N	\N	686540
2472	Koottickal S.O		Kottayam	KERALA	Kanjirapally	\N	\N	686514
2473	Koovapally S.O		Kottayam	KERALA	Kanjirapally	\N	\N	686518
2474	Malakunnam B.O		Kottayam	KERALA	Changanassery	\N	\N	686535
2475	Nalukody S.O		Kottayam	KERALA	Changanassery	\N	\N	686548
2476	Nedumkunnam S.O		Kottayam	KERALA	Changanacherry	\N	\N	686542
2477	Panachepally B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686518
2478	Panamattom B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686522
2479	Perumpanachy S.O		Kottayam	KERALA	Changanassery	\N	\N	686536
2480	Ponkunnam S.O		Kottayam	KERALA	Kanjirappally	\N	\N	686506
2481	Ponthenpuzha B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686544
2482	Poothakuzhy B.O		Kottayam	KERALA	Kottayam	\N	\N	686521
2483	Pulikkallu B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686544
2484	Velloor S.O		Kottayam	KERALA	Kottayam	\N	\N	686501
2485	Wembly B.O		Idukki	KERALA	Peerumade	\N	\N	686514
2486	Amara B.O		Kottayam	KERALA	Changanassery	\N	\N	686546
2487	Chennakunnu B.O		Kottayam	KERALA	Kanjirapally	\N	\N	686506
2488	Chirakadavu Centre B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686519
2489	Kalaketty S.O		Kottayam	KERALA	Kanjirappally	\N	\N	686508
2490	Kanjirapally H.O		Kottayam	KERALA	Kanjirappally	\N	\N	686507
2491	Kanjirappara B.O		Kottayam	KERALA	Changanassery	\N	\N	686555
2492	Kannimala B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686509
2493	Koorali S.O		Kottayam	KERALA	Kanjirapally	\N	\N	686522
2494	Kulathoorprayar B.O		Kottayam	KERALA	Changanassery	\N	\N	686541
2495	Kunnam Vechoochira S.O		Pathanamthitta	KERALA	Ranni	\N	\N	686511
2496	Manthuruthy B.O		Kottayam	KERALA	Changanassery	\N	\N	686542
2497	Muttappally B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686510
2498	Nariyanani B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686506
2499	Neelamperoor S.O		Alappuzha	KERALA	Kuttanad	\N	\N	686534
2500	Perunna S.O		Kottayam	KERALA	Changanassery	\N	\N	686102
2501	Ponganthanam B.O		Kottayam	KERALA	Changanassery	\N	\N	686538
2502	Prpose B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686509
2503	Ruby Nagar B.O		Kottayam	KERALA	Changanacherry	\N	\N	686103
2504	Thuruthy S.O		Kottayam	KERALA	Changanassery	\N	\N	686535
2505	Umbidi B.O		Kottayam	KERALA	Changanassery	\N	\N	686539
2506	Urakkanadu B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686512
2507	Vazhoor East B.O		Kottayam	KERALA	Changanassery	\N	\N	686504
2508	Velanilam B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686514
2509	Yendayar B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686514
2510	Champakara B.O		Kottayam	KERALA	Changanassery	\N	\N	686540
2511	Chelacompu B.O		Kottayam	KERALA	Changanassery	\N	\N	686540
2512	Chemmalamattom B.O		Kottayam	KERALA	Meenachil	\N	\N	686508
2513	Chingavanam S.O		Kottayam	KERALA	Changanacherry	\N	\N	686531
2514	Chirakadavu S.O		Kottayam	KERALA	Kanjirappally	\N	\N	686520
2515	Edakkunnam B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686512
2516	Erathuvadakara B.O		Kottayam	KERALA	Changanassery	\N	\N	686543
2517	Eravuchira B.O		Kottayam	KERALA	Changanassery	\N	\N	686539
2518	Inchiyani B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686512
2519	Kooropada B.O		Kottayam	KERALA	Kottayam	\N	\N	686502
2520	Kothala B.O		Kottayam	KERALA	Kottayam	\N	\N	686502
2521	Manalunkal B.O		Kottayam	KERALA	Kottayam	\N	\N	686503
2522	Mukkoottuthara S.O		Kottayam	KERALA	Kanjirappally	\N	\N	686510
2523	Nedumanny B.O		Kottayam	KERALA	Changanassery	\N	\N	686542
2524	Pallickachirakavala S.O		Kottayam	KERALA	Changanacherry	\N	\N	686537
2525	Pangada B.O		Kottayam	KERALA	Kottayam	\N	\N	686502
2526	Sachivothamapuram S.O		Kottayam	KERALA	Changanacherry	\N	\N	686532
2527	Suryanarayana Puram B.O		Kottayam	KERALA	Kottayam	\N	\N	686502
2528	Thalumkal B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686514
2529	Thottackad West B.O		Kottayam	KERALA	Changanassery	\N	\N	686539
2530	Vanchimala B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686508
2531	Vellavoor B.O		Kottayam	KERALA	Changanassery	\N	\N	686541
2532	Anikad West B.O		Kottayam	KERALA	Kottayam	\N	\N	686503
2533	Areeparampu B.O		Kottayam	KERALA	Kottayam	\N	\N	686501
2534	Aruvikuzhy B.O		Kottayam	KERALA	Kottayam	\N	\N	686503
2535	Chathenthara B.O		Pathanamthitta	KERALA	Ranni	\N	\N	686510
2536	Chenappady B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686520
2537	Cheruvally B.O		Kottayam	KERALA	Changanacherry	\N	\N	686543
2538	Kanakapalam B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686509
2539	Kangazha S.O		Kottayam	KERALA	Changanacherry	\N	\N	686541
2540	Karinilam B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686513
2541	Koruthode B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686513
2542	Kottamurickal B.O		Kottayam	KERALA	Changanassery	\N	\N	686105
2543	Kumarankary B.O		Alappuzha	KERALA	Kuttanadu	\N	\N	686103
2544	Kurumpanadom B.O		Kottayam	KERALA	Changanassery	\N	\N	686536
2545	Madappally S.O		Kottayam	KERALA	Changanacherry	\N	\N	686546
2546	Nalunnackal B.O		Kottayam	KERALA	Changanassery	\N	\N	686538
2547	Rajendraprasad Colony B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686513
2548	Santhipuram B.O		Kottayam	KERALA	Changanassery	\N	\N	686545
2549	Theerthapadapuram S.O		Kottayam	KERALA	Changanassery	\N	\N	686505
2550	Thekkethukavala S.O		Kottayam	KERALA	Kanjirappally	\N	\N	686519
2551	Thottakadu S.O		Kottayam	KERALA	Changanacherry	\N	\N	686539
2552	Vazhappally West S.O		Kottayam	KERALA	Changanassery	\N	\N	686103
2553	Veroor B.O		Kottayam	KERALA	Changanassery	\N	\N	686104
2554	Anikad S.O		Kottayam	KERALA	Kottayam	\N	\N	686503
2555	Changanacherry H.O		Kottayam	KERALA	Changanacherry	\N	\N	686101
2556	Chittadi B.O		Kottayam	KERALA	Kanjirapally	\N	\N	686512
2557	Edayarickapuzha B.O		Kottayam	KERALA	Changanassery	\N	\N	686541
2558	Kanam B.O		Kottayam	KERALA	Changanassery	\N	\N	686515
2559	Karikkattoor Centre B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686544
2560	Kidangara B.O		Alappuzha	KERALA	Kuttanad	\N	\N	686102
2561	Kunnamkary B.O		Alappuzha	KERALA	Kuttanad	\N	\N	686102
2562	Kuppakkayam B.O		Idukki	KERALA	Peerumade	\N	\N	686513
2563	Lakkattoor B.O		Kottayam	KERALA	Kottayam	\N	\N	686502
2564	Moozhoor B.O		Kottayam	KERALA	Kottayam	\N	\N	686503
2565	Mukkada B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686544
2566	Panachikavu B.O		Kottayam	KERALA	Changanassery	\N	\N	686102
2567	Pathamuttom B.O		Kottayam	KERALA	Changanassery	\N	\N	686532
2568	Poovatholi B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686544
2569	Vizhikithode B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686518
2570	Anikad East B.O		Kottayam	KERALA	Kottayam	\N	\N	686503
2571	Chakompathal S.O		Kottayam	KERALA	Changanassery	\N	\N	686517
2572	Channanikadu B.O		Kottayam	KERALA	Kottayam	\N	\N	686533
2573	Chettuthode B.O		Kottayam	KERALA	Meenachil	\N	\N	686508
2574	Chirakadavu East B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686520
2575	Kadayanickad B.O		Kottayam	KERALA	Changanassery	\N	\N	686541
2576	Kavumbhagom B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686519
2577	Koothrappally B.O		Kottayam	KERALA	Changanassery	\N	\N	686540
2578	Kurichy B.O		Kottayam	KERALA	Changanassery	\N	\N	686532
2579	Kurisummoodu S.O		Kottayam	KERALA	Changanacherry	\N	\N	686104
2580	Kuruvammoozhy B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686509
2581	Manimala S.O		Kottayam	KERALA	Changanacherry	\N	\N	686543
2582	Mukkulam B.O		Idukki	KERALA	Peerumade	\N	\N	686514
2583	Mundakayam East B.O		Idukki	KERALA	Peerumade	\N	\N	686513
2584	Nedungadappally S.O		Kottayam	KERALA	Changanassery	\N	\N	686545
2585	Palampra B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686518
2586	Pampady S.O		Kottayam	KERALA	Kottayam	\N	\N	686502
2587	Parathode S.O (Kottayam)		Kottayam	KERALA	Kanjirappally	\N	\N	686512
2588	Puthenchantha B.O		Kottayam	KERALA	Changanassery	\N	\N	686538
2589	Vakathanam South B.O		Kottayam	KERALA	Changanassery	\N	\N	686538
2590	Venkurinji B.O		Kottayam	KERALA	Kanjirapally	\N	\N	686510
2591	Alapra B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686544
2592	Anakkal B.O		Kottayam	KERALA	Kanjirapally	\N	\N	686508
2593	Erumely S.O		Kottayam	KERALA	Kanjirapally	\N	\N	686509
2594	Kanjiramattom B.O		Kottayam	KERALA	Kottayam	\N	\N	686585
2595	Kappadu B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686508
2596	Karikkattoor S.O		Kottayam	KERALA	Kanjirapally	\N	\N	686544
2597	Kuzhimattom S.O		Kottayam	KERALA	Kottayam	\N	\N	686533
2598	Mammoodu B.O		Kottayam	KERALA	Changanassery	\N	\N	686536
2599	Mannadisala B.O		Pathanamthitta	KERALA	Ranni	\N	\N	686511
2600	Mannarakayam B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686506
2601	Pampady South S.O		Kottayam	KERALA	Kottayam	\N	\N	686521
2602	Ponkunnam Court B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686506
2603	Pothenpuram B.O		Kottayam	KERALA	Kottayam	\N	\N	686502
2604	Thazhathuvadakara B.O		Kottayam	KERALA	Changanassery	\N	\N	686541
2605	Thrickodithanam S.O		Kottayam	KERALA	Changanacherry	\N	\N	686105
2606	Vakathanam S.O		Kottayam	KERALA	Changanacherry	\N	\N	686538
2607	Vengathanam B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686512
2608	Changanacherry Market S.O		Kottayam	KERALA	Changanacherry	\N	\N	686101
2609	Chengalam S.O		Kottayam	KERALA	Kottayam	\N	\N	686585
2610	Devagiri S.O		Kottayam	KERALA	Changanassery	\N	\N	686555
2611	Eara North B.O		Alappuzha	KERALA	Kuttanad	\N	\N	686534
2612	Edakadathy B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686510
2613	Fathimapuram B.O		Kottayam	KERALA	Changanassery	\N	\N	686102
2614	Kainady B.O		Alappuzha	KERALA	Kuttanad	\N	\N	686534
2615	Kalloorkulam B.O		Kottayam	KERALA	Kottayam	\N	\N	686503
2616	Kanjirapally West B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686506
2617	Madukka B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686513
2618	Mukkulam East B.O		Idukki	KERALA	Peerumade	\N	\N	686514
2619	Mundakayam S.O		Kottayam	KERALA	Kanjirapally	\N	\N	686513
2620	Mundathanam B.O		Kottayam	KERALA	Changanassery	\N	\N	686541
2621	Pampavally North B.O		Kottayam	KERALA	Kottayam	\N	\N	686510
2622	Parathanam B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686514
2623	Pazhayidom B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686520
2624	Pulickakavala S.O		Kottayam	KERALA	Changanassery	\N	\N	686515
2625	Punchavayal B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686513
2626	Thampalakkad B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686506
2627	Thulappally B.O		Pathanamthitta	KERALA	Ranni	\N	\N	686510
2628	Vazhoor S.O		Kottayam	KERALA	Changanacherry	\N	\N	686504
2629	Bhaktanandapuram B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	682308
2630	Chethicode B.O		Ernakulam	KERALA	Kanayannur	\N	\N	682315
2631	Edakochi S.O		Ernakulam	KERALA	Kochi	\N	\N	682010
2632	Edapally North B.O		Ernakulam	KERALA	Ernakulam	\N	\N	682024
2633	Eroor West B.O		Ernakulam	KERALA	Ernakulam	\N	\N	682306
2634	Ezhakkaranad B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	682308
2635	Ezhakkaranadu South B.O		Ernakulam	KERALA	Muvattupuzha	\N	\N	682308
2636	Kadungamangalam B.O		Ernakulam	KERALA	Kanayannur	\N	\N	682305
2637	Kokkappilly B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	682305
2638	Kusumagiri B.O		Ernakulam	KERALA	Ernakulam	\N	\N	682030
2639	Mamala B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	682305
2640	Marithazham B.O		Ernakulam	KERALA	Kanayannur	\N	\N	682315
2641	Meempara B.O		Ernakulam	KERALA	Kunnathunadu	\N	\N	682308
2642	Mulavukad S.O		Ernakulam	KERALA	Ernakulam	\N	\N	682504
2643	Nadakkavu B.O		Ernakulam	KERALA	Kanayannur	\N	\N	682307
2644	Nedungad B.O		Ernakulam	KERALA	Kochi	\N	\N	682509
2645	Perumanur S.O		Ernakulam	KERALA	Ernakulam	\N	\N	682015
2646	Pizhala B.O		Ernakulam	KERALA	Ernakulam	\N	\N	682027
2647	Thengod B.O		Ernakulam	KERALA	Ernakulam	\N	\N	682030
2648	Willingdon Island S.O		Ernakulam	KERALA	Kochi	\N	\N	682003
2649	Brahmapuram B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	682303
2650	Changampuzha Nagar S.O		Ernakulam	KERALA	Kanayannur	\N	\N	682033
2651	Cochin Special Economic Zone S.O		Ernakulam	KERALA	Ernakulam	\N	\N	682037
2652	Edavanakad S.O		Ernakulam	KERALA	Kochi	\N	\N	682502
2653	Eroor S.O (Ernakulam)		Ernakulam	KERALA	Ernakulam	\N	\N	682306
2654	Eroor South B.O		Ernakulam	KERALA	Ernakulam	\N	\N	682306
2655	Kaipatoor B.O		Ernakulam	KERALA	Ernakulam	\N	\N	682313
2656	Kakkanad West B.O		Ernakulam	KERALA	Ernakulam	\N	\N	682030
2657	Kaloor S.O		Ernakulam	KERALA	Ernakulam	\N	\N	682017
2658	Kochi M.G.Road S.O		Ernakulam	KERALA	Ernakulam	\N	\N	682016
2659	Kureekad B.O		Ernakulam	KERALA	Kanayannur	\N	\N	682305
2660	Mattancherry Jetty S.O		Ernakulam	KERALA	Kochi	\N	\N	682002
2661	Mundamveli S.O		Ernakulam	KERALA	Kochi	\N	\N	682507
2662	Nazreth B.O		Ernakulam	KERALA	Kochi	\N	\N	682507
2663	Thevara S.O		Ernakulam	KERALA	Ernakulam	\N	\N	682013
2664	Udyogamandal S.O		Ernakulam	KERALA	Parur	\N	\N	683501
2665	Vadayampadi B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	682308
2666	Azheekal B.O		Ernakulam	KERALA	Kochi	\N	\N	682508
2667	Ernakulam Hindi Prachar Sabha S.O		Ernakulam	KERALA	Ernakulam	\N	\N	682016
2668	Kadamakudi B.O		Ernakulam	KERALA	Ernakulam	\N	\N	682027
2669	Kochi Palace B.O		Ernakulam	KERALA	Ernakulam	\N	\N	682301
2670	Malipuram S.O		Ernakulam	KERALA	Kochi	\N	\N	682511
2671	Manjummel B.O		Ernakulam	KERALA	Parur	\N	\N	683501
2672	Narakkal S.O		Ernakulam	KERALA	Kochi	\N	\N	682505
2673	North End S.O		Ernakulam	KERALA	Kochi	\N	\N	682009
2674	Ochanthuruth S.O		Ernakulam	KERALA	Kochi	\N	\N	682508
2675	Palluruthy South B.O		Ernakulam	KERALA	Kochi	\N	\N	682006
2676	Poonithura S.O		Ernakulam	KERALA	Ernakulam	\N	\N	682038
2677	Thammanam S.O		Ernakulam	KERALA	Ernakulam	\N	\N	682032
2678	Vadavucode S.O		Ernakulam	KERALA	Kunnathunadu	\N	\N	682310
2679	Vallarpadam B.O		Ernakulam	KERALA	Ernakulam	\N	\N	682504
2680	Ambalamedu S.O		Ernakulam	KERALA	Kunnathunad	\N	\N	682303
2681	Andikkadavu B.O		Ernakulam	KERALA	Kochi	\N	\N	682008
2682	Ayyampilly S.O		Ernakulam	KERALA	Kochi	\N	\N	682501
2683	Chittoor-ekm S.O		Ernakulam	KERALA	Ernakulam	\N	\N	682027
2684	Chottanikkara S.O		Ernakulam	KERALA	Kanayannur	\N	\N	682312
2685	Elamakkara S.O		Ernakulam	KERALA	Ernakulam	\N	\N	682026
2686	Ernakulam H.O		Ernakulam	KERALA	Ernakulam	\N	\N	682011
2687	Irimbanam S.O		Ernakulam	KERALA	Ernakulam	\N	\N	682309
2688	Kalamassery Development Plot B.O		Ernakulam	KERALA	Kanayannur	\N	\N	683104
2689	Kumbalangi S.O		Ernakulam	KERALA	Kochi	\N	\N	682007
2690	Poothrikka B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	682308
2691	Puthuvype B.O		Ernakulam	KERALA	Kochi	\N	\N	682508
2692	South Paravoor B.O		Ernakulam	KERALA	Kanayannur	\N	\N	682307
2693	Thalacode B.O		Ernakulam	KERALA	Kanayannur	\N	\N	682314
2694	Thekkumbhagom B.O		Ernakulam	KERALA	Ernakulam	\N	\N	682301
2695	Varikoli B.O		Ernakulam	KERALA	Kunnathunadu	\N	\N	682308
2696	Vennala S.O		Ernakulam	KERALA	Ernakulam	\N	\N	682028
2697	Cheranallur S.O		Ernakulam	KERALA	Ernakulam	\N	\N	682034
2698	Kochi University S.O		Ernakulam	KERALA	Ernakulam	\N	\N	682022
2699	Kuttikkattukara B.O		Ernakulam	KERALA	Ernakulam	\N	\N	683501
2700	Mattancherry S.O		Ernakulam	KERALA	Kochi	\N	\N	682002
2701	Mattancherry Town S.O		Ernakulam	KERALA	Kochi	\N	\N	682002
2702	Pachalam S.O		Ernakulam	KERALA	Ernakulam	\N	\N	682012
2703	Palarivattom S.O		Ernakulam	KERALA	Ernakulam	\N	\N	682025
2704	Panangad S.O (Ernakulam)		Ernakulam	KERALA	Kanayannur	\N	\N	682506
2705	Panayappilly S.O		Ernakulam	KERALA	Kochi	\N	\N	682002
2706	Poothotta B.O		Ernakulam	KERALA	Kanayannur	\N	\N	682307
2707	Rajagiri Valley S.O		Ernakulam	KERALA	Ernakulam	\N	\N	682039
2708	Thirumarayoor B.O		Ernakulam	KERALA	Kanayannur	\N	\N	682313
2709	Udayamperoor S.O		Ernakulam	KERALA	Ernakulam	\N	\N	682307
2710	Vadacode Kailas Colony B.O		Ernakulam	KERALA	Kanayannur	\N	\N	682021
2711	Vaduthala S.O		Ernakulam	KERALA	Ernakulam	\N	\N	682023
2712	Veliyanad B.O		Ernakulam	KERALA	Kanayannur	\N	\N	682313
2713	Vyttila S.O		Ernakulam	KERALA	Ernakulam	\N	\N	682019
2714	Ambalamugal S.O		Ernakulam	KERALA	Kunnathunad	\N	\N	682302
2715	Arakunnam S.O		Ernakulam	KERALA	Kanayannur	\N	\N	682313
2716	Ernakulam College S.O		Ernakulam	KERALA	Ernakulam	\N	\N	682035
2717	Hmt Colony S.O		Ernakulam	KERALA	Kanayannur	\N	\N	683503
2718	Kadavanthara S.O		Ernakulam	KERALA	Ernakulam	\N	\N	682020
2719	Kakkanad S.O		Ernakulam	KERALA	Ernakulam	\N	\N	682030
2720	Kalamassery S.O		Ernakulam	KERALA	Kanayannur	\N	\N	683104
2721	Kandanad B.O		Ernakulam	KERALA	Kanayannur	\N	\N	682305
2722	Kannamali S.O		Ernakulam	KERALA	Kochi	\N	\N	682008
2723	Kumbalam B.O		Ernakulam	KERALA	Ernakulam	\N	\N	682506
2724	Kumbalangi South B.O		Ernakulam	KERALA	Kochi	\N	\N	682007
2725	Maradu S.O		Ernakulam	KERALA	Ernakulam	\N	\N	682304
2726	Mulanthuruthy S.O		Ernakulam	KERALA	Ernakulam	\N	\N	682314
2727	Nayarambalam S.O		Ernakulam	KERALA	Kochi	\N	\N	682509
2728	Pancode B.O		Ernakulam	KERALA	Kunnathunadu	\N	\N	682310
2729	Perumpilly B.O		Ernakulam	KERALA	Kanayannur	\N	\N	682314
2730	Pulickamaly B.O		Ernakulam	KERALA	Kanayannur	\N	\N	682314
2731	Puthencruz S.O		Ernakulam	KERALA	Kunnathunadu	\N	\N	682308
2732	S.Chellanam B.O		Ernakulam	KERALA	Kochi	\N	\N	682008
2733	Thiruvamkulam S.O		Ernakulam	KERALA	Ernakulam	\N	\N	682305
2734	Thrikkakara S.O		Ernakulam	KERALA	Ernakulam	\N	\N	682021
2735	Edakkattuvayal B.O		Ernakulam	KERALA	Kanayannur	\N	\N	682313
2736	Elamkunnapuzha S.O		Ernakulam	KERALA	Kochi	\N	\N	682503
2737	Ernakulam High Court S.O		Ernakulam	KERALA	Ernakulam	\N	\N	682031
2738	Ernakulam North S.O		Ernakulam	KERALA	Ernakulam	\N	\N	682018
2739	Kanjiramattom S.O		Ernakulam	KERALA	Kanayannur	\N	\N	682315
2740	Karimugal B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	682303
2741	Kochi H.O		Ernakulam	KERALA	Kochi	\N	\N	682001
2742	Kochi Naval Base S.O		Ernakulam	KERALA	Kochi	\N	\N	682004
2743	Kothad B.O		Ernakulam	KERALA	Ernakulam	\N	\N	682027
2744	Kulayettikara B.O		Ernakulam	KERALA	Kanayannur	\N	\N	682315
2745	Kuzhiyara B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	682312
2746	Nettoor S.O		Ernakulam	KERALA	Kanayannur	\N	\N	682040
2747	Paingarapilly B.O		Ernakulam	KERALA	Kanayannur	\N	\N	682314
2748	Palluruthy S.O		Ernakulam	KERALA	Kochi	\N	\N	682006
2749	Panampilly Nagar S.O		Ernakulam	KERALA	Ernakulam	\N	\N	682036
2750	Shanmugham Road S.O		Ernakulam	KERALA	Ernakulam	\N	\N	682031
2751	Thoppumpady S.O		Ernakulam	KERALA	Kochi	\N	\N	682005
2752	Tripunithura S.O		Ernakulam	KERALA	Ernakulam	\N	\N	682301
2753	Vettickal B.O		Ernakulam	KERALA	Kanayannur	\N	\N	682314
2754	AIMS Ponekkara S.O		Ernakulam	KERALA	Kanayannur	\N	\N	682041
2755	Amballur B.O		Ernakulam	KERALA	Ernakulam	\N	\N	682315
2756	Chellanam B.O		Ernakulam	KERALA	Kochi	\N	\N	682008
2757	Edapally S.O		Ernakulam	KERALA	Ernakulam	\N	\N	682024
2758	Infopark-Kochi S.O		Ernakulam	KERALA	Kanayannur	\N	\N	682042
2759	Kanayannoor B.O		Ernakulam	KERALA	Kanayannur	\N	\N	682312
2760	Kaninad B.O		Ernakulam	KERALA	Kunnathunad	\N	\N	682310
2761	Matsyapuri S.O		Ernakulam	KERALA	Kochi	\N	\N	682029
2762	Rajagiri B.O		Ernakulam	KERALA	Kanayannur	\N	\N	683104
2763	Thiruvaniyoor B.O		Ernakulam	KERALA	Kunnathunadu	\N	\N	682308
2764	Tripunithura Fort S.O		Ernakulam	KERALA	Ernakulam	\N	\N	682301
2765	Vadacode B.O		Ernakulam	KERALA	Kanayannur	\N	\N	682021
2766	Chemmannar B.O		Idukki	KERALA	Udumbanchola	\N	\N	685554
2767	Chinnar B.O		Idukki	KERALA	Peerumade	\N	\N	685501
2768	Chottupara Periyar B.O		Idukki	KERALA	Peerumade	\N	\N	685533
2769	Ellapatti S.O		Idukki	KERALA	Devikulam	\N	\N	685615
2770	Kalayanthani S.O		Idukki	KERALA	Thodupuzha	\N	\N	685588
2771	Kallar S.O		Idukki	KERALA	Udumbanchola	\N	\N	685552
2772	Kanayankavayal B.O		Idukki	KERALA	Peerumade	\N	\N	685532
2773	Karunapuram B.O		Idukki	KERALA	Udumbanchola	\N	\N	685552
2774	Keerikara B.O		Idukki	KERALA	Peerumade	\N	\N	685533
2775	Kodikulam S.O		Idukki	KERALA	Thodupuzha	\N	\N	685582
2776	Kolahalamedu B.O		Idukki	KERALA	Peerumade	\N	\N	685501
2777	Kottakomboor B.O		Idukki	KERALA	Devikulam	\N	\N	685615
2778	Lakshmi Coil B.O		Idukki	KERALA	Peerumade	\N	\N	685531
2779	Mrala B.O		Idukki	KERALA	Thodupuzha	\N	\N	685587
2780	Muniyara B.O		Idukki	KERALA	Udumbanchola	\N	\N	685571
2781	Pampadumpara B.O		Idukki	KERALA	NA	\N	\N	685553
2782	Panamkutty B.O		Idukki	KERALA	Udumbanchola	\N	\N	685562
2783	Pandipara B.O		Idukki	KERALA	Udumbanchola	\N	\N	685609
2784	Peermade S.O		Idukki	KERALA	Peermade	\N	\N	685531
2785	Perinchankutty B.O		Idukki	KERALA	Udumbanchola	\N	\N	685604
2786	Rajakumari South B.O		Idukki	KERALA	Udumbanchola	\N	\N	685619
2787	Sahayagiri B.O		Idukki	KERALA	Devikulam	\N	\N	685620
2788	Senapathy B.O		Idukki	KERALA	Udumbanchola	\N	\N	685619
2789	Springvalley B.O		Idukki	KERALA	Peermade	\N	\N	685509
2790	Thattakuzha B.O		Idukki	KERALA	Thodupuzha	\N	\N	685581
2791	Thokkupara B.O		Idukki	KERALA	Devikulam	\N	\N	685565
2792	Upputhara S.O		Idukki	KERALA	Peermade	\N	\N	685505
2793	Upputhode B.O		Idukki	KERALA	Udumbanchola	\N	\N	685604
2794	Vagamon S.O		Idukki	KERALA	Peermade	\N	\N	685503
2795	Valiyathovala B.O		Idukki	KERALA	Udumbanchola	\N	\N	685514
2796	Adoormala B.O		Idukki	KERALA	Thodupuzha	\N	\N	685590
2797	Amayapra B.O		Idukki	KERALA	Thodupuzha	\N	\N	685595
2798	Anavilasam B.O		Idukki	KERALA	Udumbanchola	\N	\N	685535
2799	Anaviratty B.O		Idukki	KERALA	Devikulam	\N	\N	685561
2800	Anayirankal B.O		Idukki	KERALA	Udumbanchola	\N	\N	685613
2801	Arakulam S.O		Idukki	KERALA	Thodupuzha	\N	\N	685591
2802	Arnakal B.O		Idukki	KERALA	Peerumade	\N	\N	685533
2803	Ayyappancoil S.O		Idukki	KERALA	Udumbanchola	\N	\N	685507
2804	Bethel B.O		Idukki	KERALA	Udumbanchola	\N	\N	685514
2805	Combayar B.O		Idukki	KERALA	Udumbanchola	\N	\N	685552
2806	Devarupara B.O		Idukki	KERALA	Thodupuzha	\N	\N	685588
2807	Ellakallu B.O		Idukki	KERALA	Udumbanchola	\N	\N	685565
2808	Ellumpuram B.O		Idukki	KERALA	Thodupuzha	\N	\N	685587
2809	Erattayar North B.O		Idukki	KERALA	Udumbanchola	\N	\N	685514
2810	Haileyburia B.O		Idukki	KERALA	Peerumade	\N	\N	685501
2811	Ilappally B.O		Idukki	KERALA	Thodupuzha	\N	\N	685589
2812	Kallarkutty S.O		Idukki	KERALA	Devikulam	\N	\N	685562
2813	Karadikuzhy B.O		Idukki	KERALA	Peerumade	\N	\N	685531
2814	Karimkunnam S.O		Idukki	KERALA	Thodupuzha	\N	\N	685586
2815	Karippalangad B.O		Idukki	KERALA	Thodupuzha	\N	\N	685601
2816	Kattappana South S.O		Idukki	KERALA	Udumbanchola	\N	\N	685515
2817	Kochukarimtharuvi B.O		Idukki	KERALA	Peerumade	\N	\N	685501
2818	Koompanpara B.O		Idukki	KERALA	Devikulam	\N	\N	685561
2819	Kulamavu S.O		Idukki	KERALA	Thodupuzha	\N	\N	685601
2820	Kuninji B.O		Idukki	KERALA	Thodupuzha	\N	\N	685583
2821	Mailacombu B.O		Idukki	KERALA	Thodupuzha	\N	\N	685608
2822	Mariyapuram B.O		Idukki	KERALA	Udumbanchola	\N	\N	685602
2823	Melekuppachampady B.O		Idukki	KERALA	Udumbanchola	\N	\N	685514
2824	Moolamattom East B.O		Idukki	KERALA	Thodupuzha	\N	\N	685589
2825	Mullaringadu B.O		Idukki	KERALA	Thodupuzha	\N	\N	685607
2826	Muthalakodam S.O		Idukki	KERALA	Thodupuzha	\N	\N	685605
2827	Nayarupara B.O		Idukki	KERALA	Udumbanchola	\N	\N	685602
2828	Nediyasala B.O		Idukki	KERALA	Thodupuzha	\N	\N	685608
2829	Neyyassery B.O		Idukki	KERALA	Thodupuzha	\N	\N	685581
2830	Pallivasal B.O		Idukki	KERALA	Devikulam	\N	\N	685565
2831	Pallivasal Estate B.O		Idukki	KERALA	Devikulam	\N	\N	685612
2832	Pampupara B.O		Idukki	KERALA	Udumbanchola	\N	\N	685551
2833	Pannimattom B.O		Idukki	KERALA	Thodupuzha	\N	\N	685588
2834	Pius Nagar B.O		Idukki	KERALA	Devikulam	\N	\N	685620
2835	Pulickathotty B.O		Idukki	KERALA	Thodupuzha	\N	\N	685607
2836	Rajakandam B.O		Idukki	KERALA	Udumbanchola	\N	\N	685551
2837	Rajamudi B.O		Idukki	KERALA	Udumbanchola	\N	\N	685604
2838	Talliar S.O		Idukki	KERALA	Devikulam	\N	\N	685614
2839	Thodupuzha H.O		Idukki	KERALA	Thodupuzha	\N	\N	685584
2840	Vengallur S.O		Idukki	KERALA	Thodupuzha	\N	\N	685608
2841	Calvari Mount B.O		Idukki	KERALA	Udumbanchola	\N	\N	685515
2842	Cheenikuzhi B.O		Idukki	KERALA	Thodupuzha	\N	\N	685595
2843	Chempakapara B.O		Idukki	KERALA	Udumbanchola	\N	\N	685514
2844	Chenkara B.O		Idukki	KERALA	Peerumade	\N	\N	685533
2845	Dymock B.O		Idukki	KERALA	Peerumade	\N	\N	685533
2846	Edad-idukki B.O		Idukki	KERALA	Thodupuzha	\N	\N	685589
2847	Edavetty B.O		Idukki	KERALA	Thodupuzha	\N	\N	685588
2848	Ezhallur B.O		Idukki	KERALA	Thodupuzha	\N	\N	685605
2849	Ezhukunvayal B.O		Idukki	KERALA	Udumbanchola	\N	\N	685553
2850	Fair Field B.O		Idukki	KERALA	Peerumade	\N	\N	685501
2851	Gramby B.O		Idukki	KERALA	Peerumade	\N	\N	685533
2852	Konnackamali B.O		Idukki	KERALA	Udumbanchola	\N	\N	685604
2853	Koovappally-kudayathur B.O		Idukki	KERALA	Thodupuzha	\N	\N	685590
2854	Kumaramangala B.O		Idukki	KERALA	Thodupuzha	\N	\N	685608
2855	Mankulam B.O		Idukki	KERALA	Devikulam	\N	\N	685565
2856	Moolamattom S.O		Idukki	KERALA	Thodupuzha	\N	\N	685589
2857	Moongalar B.O		Idukki	KERALA	Peerumade	\N	\N	685533
2858	Mukkudam B.O		Idukki	KERALA	Devikulam	\N	\N	685562
2859	Mundanmudy B.O		Idukki	KERALA	Thodupuzha	\N	\N	685607
2860	Murinjapuzha B.O		Idukki	KERALA	Peerumade	\N	\N	685532
2861	Narakakanam B.O		Idukki	KERALA	Udumbanchola	\N	\N	685602
2862	Pathippally B.O		Idukki	KERALA	Thodupuzha	\N	\N	685589
2863	Peringassery B.O		Idukki	KERALA	Thodupuzha	\N	\N	685595
2864	Perumthotty B.O		Idukki	KERALA	Udumbanchola	\N	\N	685609
2865	Prakash B.O		Idukki	KERALA	Udumbanchola	\N	\N	685609
2866	Puliyanmala B.O		Idukki	KERALA	Udumbanchola	\N	\N	685515
2867	Pullikkanam B.O		Idukki	KERALA	Peerumade	\N	\N	685503
2868	Rajakad S.O		Idukki	KERALA	Udumbanchola	\N	\N	685566
2869	Santhanpara S.O		Idukki	KERALA	Udumbanchola	\N	\N	685619
2870	Thekkumbhagam B.O		Idukki	KERALA	Thodupuzha	\N	\N	685585
2871	Thopramkduy B.O		Idukki	KERALA	Udumbanchola	\N	\N	685609
2872	Vazhavara B.O		Idukki	KERALA	Udumbanchola	\N	\N	685515
2873	C. Kuthumkal B.O		Idukki	KERALA	Udumbanchola	\N	\N	685566
2874	Chembalam B.O		Idukki	KERALA	Udumbanchola	\N	\N	685553
2875	Chottupara B.O		Idukki	KERALA	Udumbanchola	\N	\N	685552
2876	Devikulam S.O		Idukki	KERALA	Devikulam	\N	\N	685613
2877	Elappara S.O		Idukki	KERALA	Peermade	\N	\N	685501
2878	Ettithope B.O		Idukki	KERALA	Udumbanchola	\N	\N	685514
2879	Ezhumuttom B.O		Idukki	KERALA	Thodupuzha	\N	\N	685605
2880	Glenmary B.O		Idukki	KERALA	Peerumade	\N	\N	685531
2881	Idukki Painavu S.O		Idukki	KERALA	Thodupuzha	\N	\N	685603
2882	Josegiri B.O		Idukki	KERALA	Udumbanchola	\N	\N	685565
2883	Kanjar B.O		Idukki	KERALA	Thodupuzha	\N	\N	685590
2884	Kanthallur B.O		Idukki	KERALA	Devikulam	\N	\N	685620
2885	Khajanapara B.O		Idukki	KERALA	Udumbanchola	\N	\N	685619
2886	Kolani B.O		Idukki	KERALA	Thodupuzha	\N	\N	685608
2887	Koviloor B.O		Idukki	KERALA	Devikulam	\N	\N	685615
2888	Kumily S.O		Idukki	KERALA	Peermade	\N	\N	685509
2889	Lonetree B.O		Idukki	KERALA	Peerumade	\N	\N	685505
2890	Mammattikanam B.O		Idukki	KERALA	Udumbanchola	\N	\N	685566
2891	Mankuva B.O		Idukki	KERALA	Udumbanchola	\N	\N	685604
2892	Mannamkandam B.O		Idukki	KERALA	Devikulam	\N	\N	685561
2893	Marigiri B.O		Idukki	KERALA	Udumbanchola	\N	\N	685609
2894	Michaelgiri B.O		Idukki	KERALA	Devikulam	\N	\N	685620
2895	Mount B.O		Idukki	KERALA	Peerumade	\N	\N	685533
2896	Mulakuvally B.O		Idukki	KERALA	Thodupuzha	\N	\N	685602
2897	Mullarikudy B.O		Idukki	KERALA	Udumbanchola	\N	\N	685571
2898	Murukady S.O		Idukki	KERALA	Peerumade	\N	\N	685535
2899	Nettithozhu B.O		Idukki	KERALA	Udumbanchola	\N	\N	685551
2900	Pachakanam B.O		Idukki	KERALA	Peerumade	\N	\N	685533
2901	Padicap B.O		Idukki	KERALA	Devikulam	\N	\N	685561
2902	Pallikunnu B.O		Idukki	KERALA	Peerumade	\N	\N	685531
2903	Pampa Dam B.O		Idukki	KERALA	Peerumade	\N	\N	685533
2904	Panickankudy B.O		Idukki	KERALA	Udumbanchola	\N	\N	685571
2905	Panniar Estate B.O		Idukki	KERALA	Udumbanchola	\N	\N	685613
2906	Periyar Lake B.O		Idukki	KERALA	Peerumade	\N	\N	685509
2907	Peruvanthanam S.O		Idukki	KERALA	Peermade	\N	\N	685532
2908	Puttady B.O		Idukki	KERALA	Udumbanchola	\N	\N	685551
2909	Selliampara B.O		Idukki	KERALA	Devikulam	\N	\N	685563
2910	Thankamany S.O		Idukki	KERALA	Udumbanchola	\N	\N	685609
2911	Thommankuthu B.O		Idukki	KERALA	Thodupuzha	\N	\N	685581
2912	Udumbannur S.O		Idukki	KERALA	Thodupuzha	\N	\N	685595
2913	Vazhithala S.O		Idukki	KERALA	Thodupuzha	\N	\N	685583
2914	Vimalagiri B.O		Idukki	KERALA	Udumbanchola	\N	\N	685602
2915	Alpara B.O		Idukki	KERALA	Thodupuzha	\N	\N	685606
2916	Anchiri B.O		Idukki	KERALA	Thodupuzha	\N	\N	685585
2917	Arikuzha B.O		Idukki	KERALA	Thodupuzha	\N	\N	685608
2918	Attapallam B.O		Idukki	KERALA	Peerumade	\N	\N	685509
2919	Chakkupallam B.O		Idukki	KERALA	Udumbanchola	\N	\N	685509
2920	Chathurangapara B.O		Idukki	KERALA	Udumbanchola	\N	\N	685554
2921	Chellarcoil B.O		Idukki	KERALA	Udumbanchola	\N	\N	685512
2922	Chilavu B.O		Idukki	KERALA	Thodupuzha	\N	\N	685588
2923	Chithirapuram S.O		Idukki	KERALA	Devikulam	\N	\N	685565
2924	Cumbumbettu B.O		Idukki	KERALA	Udumbanchola	\N	\N	685551
2925	Gavi B.O		Pathanamthitta	KERALA	Ranni	\N	\N	685533
2926	Kannickal B.O		Idukki	KERALA	Thodupuzha	\N	\N	685589
2927	Karimkulam Chappath B.O		Idukki	KERALA	Udumbanchola	\N	\N	685505
2928	Kochara B.O		Idukki	KERALA	Udumbanchola	\N	\N	685551
2929	Kozhimala B.O		Idukki	KERALA	Udumbanchola	\N	\N	685511
2930	Kudayathur S.O		Idukki	KERALA	Thodupuzha	\N	\N	685590
2931	Mattupatty ISP B.O		Idukki	KERALA	Devikulam	\N	\N	685616
2932	Mattuppatti S.O		Idukki	KERALA	Devikulam	\N	\N	685616
2933	Mattuthavalam B.O		Idukki	KERALA	Peerumade	\N	\N	685505
2934	Mavady B.O		Idukki	KERALA	Udumbanchola	\N	\N	685553
2935	Meencut B.O		Idukki	KERALA	Devikulam	\N	\N	685565
2936	Meloram B.O		Idukki	KERALA	Peermade	\N	\N	685532
2937	Moolakad B.O		Idukki	KERALA	Thodupuzha	\N	\N	685595
2938	Munnar S.O		Idukki	KERALA	Devikulam	\N	\N	685612
2939	Muttom EK S.O		Idukki	KERALA	Thodupuzha	\N	\N	685587
2940	Pachady B.O		Idukki	KERALA	Udumbanchola	\N	\N	685553
2941	Pannoor B.O		Idukki	KERALA	Thodupuzha	\N	\N	685581
2942	Pasupara B.O		Idukki	KERALA	Peerumade	\N	\N	685501
2943	Pethotty B.O		Idukki	KERALA	Udumbanchola	\N	\N	685619
2944	Ponmudi B.O		Idukki	KERALA	Udumbanchola	\N	\N	685563
2945	Thadiampadu B.O		Idukki	KERALA	Thodupuzha	\N	\N	685602
2946	Thodupuzha East S.O		Idukki	KERALA	Thodupuzha	\N	\N	685585
2947	Thodupuzha West S.O		Idukki	KERALA	Thodupuzha	\N	\N	685584
2948	Thoppipala B.O		Idukki	KERALA	Udumbanchola	\N	\N	685511
2949	Udumbanchola S.O		Idukki	KERALA	Udumbanchola	\N	\N	685554
2950	Valara B.O		Idukki	KERALA	Devikulam	\N	\N	685561
2951	Vandamattom B.O		Idukki	KERALA	Thodupuzha	\N	\N	685582
2952	Vattappara (UBC) B.O		Idukki	KERALA	Udumbanchola	\N	\N	685619
2953	Vellaramkunnu B.O		Idukki	KERALA	Udumbanchola	\N	\N	685535
2954	Venmony B.O		Idukki	KERALA	Thodupuzha	\N	\N	685606
2955	Amaravathy B.O		Idukki	KERALA	Peerumade	\N	\N	685509
2956	Anakkara S.O (Idukki)		Idukki	KERALA	Udumbanchola	\N	\N	685512
2957	Anakulam B.O		Idukki	KERALA	Devikulam	\N	\N	685565
2958	Aruvilanchal B.O		Idukki	KERALA	Udumbanchola	\N	\N	685619
2959	Bisonvalley B.O		Idukki	KERALA	Devikulam	\N	\N	685565
2960	Chelachuvadu B.O		Idukki	KERALA	Thodupuzha	\N	\N	685606
2961	Kadamakuzhy B.O		Idukki	KERALA	Udumbanchola	\N	\N	685515
2962	Kailasanadu B.O		Idukki	KERALA	Udumbanchola	\N	\N	685553
2963	Kochuthovala B.O		Idukki	KERALA	Udumbanchola	\N	\N	685514
2964	Koduveli B.O		Idukki	KERALA	Thodupuzha	\N	\N	685581
2965	Konnathady B.O		Idukki	KERALA	Udumbanchola	\N	\N	685563
2966	Kunchithanni B.O		Idukki	KERALA	Devikulam	\N	\N	685565
2967	Mali B.O		Idukki	KERALA	Udumbanchola	\N	\N	685551
2968	Maniyaramkudy B.O		Idukki	KERALA	Thodupuzha	\N	\N	685602
2969	Maraiyur S.O		Idukki	KERALA	Devikulam	\N	\N	685620
2970	Mukkudil B.O		Idukki	KERALA	Udumbanchola	\N	\N	685566
2971	Mulakaramedu B.O		Idukki	KERALA	Udumbanchola	\N	\N	685515
2972	Mulappuram B.O		Idukki	KERALA	Thodupuzha	\N	\N	685581
2973	Munnar Colony B.O		Idukki	KERALA	Devikulam	\N	\N	685612
2974	Murickassery S.O		Idukki	KERALA	Udumbanchola	\N	\N	685604
2975	Paloorkavu B.O		Idukki	KERALA	Peerumade	\N	\N	685532
2976	Parapuzha B.O		Idukki	KERALA	Thodupuzha	\N	\N	685582
2977	Pothamedu B.O		Idukki	KERALA	Devikulam	\N	\N	685612
2978	Pottenkad B.O		Idukki	KERALA	Udumbanchola	\N	\N	685565
2979	Ramakkal Mettu B.O		Idukki	KERALA	Udumbanchola	\N	\N	685552
2980	Sanniasioda B.O		Idukki	KERALA	Udumbanchola	\N	\N	685552
2981	Thattarathatta B.O		Idukki	KERALA	Thodupuzha	\N	\N	685586
2982	Thodupuzha -puthuperiyaram B.O		Idukki	KERALA	Thodupuzha	\N	\N	685608
2983	Thovarayar B.O		Idukki	KERALA	Udumbanchola	\N	\N	685511
2984	Thudanganad B.O		Idukki	KERALA	Thodupuzha	\N	\N	685587
2985	Vadakkummury B.O		Idukki	KERALA	Thodupuzha	\N	\N	685586
2986	Vallakadavu Periyar B.O		Idukki	KERALA	Peerumade	\N	\N	685533
2987	Vandanmettu S.O		Idukki	KERALA	Udumbanchola	\N	\N	685551
2988	Vellathooval S.O		Idukki	KERALA	Udumbanchola	\N	\N	685563
2989	Vellayamkudy B.O		Idukki	KERALA	Udumbanchola	\N	\N	685515
2990	Velliyamattom B.O		Idukki	KERALA	Thodupuzha	\N	\N	685588
2991	Wallardie B.O		Idukki	KERALA	Peerumade	\N	\N	685533
2992	Alakode B.O		Idukki	KERALA	Thodupuzha	\N	\N	685588
2993	Cheenthalar B.O		Idukki	KERALA	Peerumade	\N	\N	685501
2994	Chinnakanal B.O		Idukki	KERALA	Udumbanchola	\N	\N	685618
2995	Elamdesom B.O		Idukki	KERALA	Thodupuzha	\N	\N	685588
2996	Idukki Colony S.O		Idukki	KERALA	Thodupuzha	\N	\N	685602
2997	Kaloor East B.O		Idukki	KERALA	Thodupuzha	\N	\N	685608
2998	Kanchiyar S.O		Idukki	KERALA	Udumbanchola	\N	\N	685511
2999	Karimannoor S.O		Idukki	KERALA	Thodupuzha	\N	\N	685581
3000	Kattappana H.O		Idukki	KERALA	Udumbanchola	\N	\N	685508
3001	Keerithode B.O		Idukki	KERALA	Thodupuzha	\N	\N	685606
3002	Koottar B.O		Idukki	KERALA	Udumbanchola	\N	\N	685552
3003	Koovakandam B.O		Idukki	KERALA	Thodupuzha	\N	\N	685588
3004	Korangatti B.O		Idukki	KERALA	Devikulam	\N	\N	685561
3005	Kuzhithozhu B.O		Idukki	KERALA	Udumbanchola	\N	\N	685551
3006	Machiplavu B.O		Idukki	KERALA	Devikulam	\N	\N	685561
3007	Manakkad B.O		Idukki	KERALA	Thodupuzha	\N	\N	685608
3008	Manipara B.O		Idukki	KERALA	Thodupuzha	\N	\N	685602
3009	Manjappara B.O		Idukki	KERALA	Udumbanchola	\N	\N	685553
3010	N R City B.O		Idukki	KERALA	Udumbanchola	\N	\N	685566
3011	Nedumkandam S.O		Idukki	KERALA	Udumbanchola	\N	\N	685553
3012	Nellipara B.O		Idukki	KERALA	Udumbanchola	\N	\N	685515
3013	Padamugham B.O		Idukki	KERALA	Udumbanchola	\N	\N	685604
3014	Pambanar B.O		Idukki	KERALA	Peerumade	\N	\N	685531
3015	Pazhayarikandam B.O		Idukki	KERALA	Thodupuzha	\N	\N	685606
3016	Pushpakandam B.O		Idukki	KERALA	Udumbanchola	\N	\N	685552
3017	Rajakumari B.O		Idukki	KERALA	Udumbanchola	\N	\N	685619
3018	Santhigram B.O		Idukki	KERALA	Udumbanchola	\N	\N	685514
3019	Sasthanoda B.O		Idukki	KERALA	Udumbanchola	\N	\N	685535
3020	Sethuparvathipuram B.O		Idukki	KERALA	Devikulam	\N	\N	685615
3021	Sinkukandam B.O		Idukki	KERALA	Udumbanchola	\N	\N	685618
3022	South Kathipara B.O		Idukki	KERALA	Devikulam	\N	\N	685562
3023	Vattiar B.O		Idukki	KERALA	Devikulam	\N	\N	685565
3024	West Kodikulam B.O		Idukki	KERALA	Thodupuzha	\N	\N	685582
3025	Adimali S.O		Idukki	KERALA	Devikulam	\N	\N	685561
3026	Anniyartholu B.O		Idukki	KERALA	Udumbanchola	\N	\N	685515
3027	Balagram B.O		Idukki	KERALA	Udumbanchola	\N	\N	685552
3028	Chattamannar B.O		Idukki	KERALA	Devikulam	\N	\N	685614
3029	Cheppukulam B.O		Idukki	KERALA	Thodupuzha	\N	\N	685581
3030	Erattayar S.O		Idukki	KERALA	Udumbanchola	\N	\N	685514
3031	Gudarle B.O		Idukki	KERALA	Devikulam	\N	\N	685612
3032	Idinjamala B.O		Idukki	KERALA	Udumbanchola	\N	\N	685514
3033	Kaliyar B.O		Idukki	KERALA	Thodupuzha	\N	\N	685607
3034	Kalthotty B.O		Idukki	KERALA	Udumbanchola	\N	\N	685507
3035	Kamakshy B.O		Idukki	KERALA	Udumbanchola	\N	\N	685515
3036	Kanjikuzhi - Idukki S.O		Idukki	KERALA	Thodupuzha	\N	\N	685606
3037	Kottamala B.O		Idukki	KERALA	Peerumade	\N	\N	685503
3038	Kulaparachal B.O		Idukki	KERALA	Udumbanchola	\N	\N	685619
3039	Kuttikanam B.O		Idukki	KERALA	Peerumade	\N	\N	685531
3040	Malayinchi B.O		Idukki	KERALA	Thodupuzha	\N	\N	685595
3041	Mathaipara B.O		Idukki	KERALA	Peerumade	\N	\N	685505
3042	Nariampara B.O		Idukki	KERALA	Udumbanchola	\N	\N	685511
3043	Ottalloor B.O		Idukki	KERALA	Thodupuzha	\N	\N	685586
3044	Paloorkavu Central B.O		Idukki	KERALA	Peerumade	\N	\N	685532
3045	Parathode S.O (Idukki)		Idukki	KERALA	Udumbanchola	\N	\N	685571
3046	Perumpillichira B.O		Idukki	KERALA	Thodupuzha	\N	\N	685605
3047	Poopara B.O		Idukki	KERALA	Udumbanchola	\N	\N	685619
3048	Purapuzha B.O		Idukki	KERALA	Thodupuzha	\N	\N	685583
3049	Puthady B.O		Idukki	KERALA	Udumbanchola	\N	\N	685619
3050	Rajapuram B.O		Idukki	KERALA	Udumbanchola	\N	\N	685604
3051	Sengulam B.O		Idukki	KERALA	Devikulam	\N	\N	685565
3052	Surianalle S.O		Idukki	KERALA	Udumbanchola	\N	\N	685618
3053	Thattekanni B.O		Idukki	KERALA	Thodupuzha	\N	\N	685606
3054	Thekkady B.O		Idukki	KERALA	Peerumade	\N	\N	685509
3055	Thengakal B.O		Idukki	KERALA	Peerumade	\N	\N	685533
3056	Uppukandam B.O		Idukki	KERALA	Udumbanchola	\N	\N	685514
3057	Vandiperiyar S.O		Idukki	KERALA	Peermade	\N	\N	685533
3058	Vannapuram S.O		Idukki	KERALA	Thodupuzha	\N	\N	685607
3059	Annanad B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680309
3060	Aripalam S.O		Thrissur	KERALA	Mukundapuram	\N	\N	680688
3061	Eravathur B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680734
3062	Kaduppassery B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680683
3063	Kallettumkara S.O		Thrissur	KERALA	Mukundapuram	\N	\N	680683
3064	Karalam B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680711
3065	Karuvannur S.O		Thrissur	KERALA	Mukundapuram	\N	\N	680711
3066	Kathikkudam B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680308
3067	Kuzhikkattussery B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680697
3068	Kuzhur S.O		Thrissur	KERALA	Mukundapuram	\N	\N	680734
3069	Madathumpady B.O		Thrissur	KERALA	NA	\N	\N	680733
3070	Mambra B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680308
3071	Mothirakkanni B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680724
3072	Padinjare Vemballur B.O		Thrissur	KERALA	Kodungallur	\N	\N	680671
3073	Pady S.O		Thrissur	KERALA	Mukundapuram	\N	\N	680699
3074	Panamkulam B.O		Thrissur	KERALA	Thrissur	\N	\N	680711
3075	Pazhayi B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680301
3076	Perinjanam West B.O		Thrissur	KERALA	Kodungallur	\N	\N	680686
3077	Ponjanam B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680702
3078	Poringalkuthu B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680721
3079	Thiruvanchikulam B.O		Thrissur	KERALA	Kodungallur	\N	\N	680664
3080	Thuruthippuram B.O		Ernakulam	KERALA	Paravur	\N	\N	680667
3081	Vadama B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680732
3082	Valapad Beach B.O		Thrissur	KERALA	Chavakkad	\N	\N	680567
3083	Vallachira B.O		Thrissur	KERALA	Thrissur	\N	\N	680562
3084	Vellangallur S.O		Thrissur	KERALA	Mukundapuram	\N	\N	680662
3085	Vellani B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680701
3086	Vettilappara B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680721
3087	Annallur B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680731
3088	Annamanada S.O		Thrissur	KERALA	Mukundapuram	\N	\N	680741
3089	Chazhur B.O		Thrissur	KERALA	Thrissur	\N	\N	680571
3090	Cherpu Padinjattumuri B.O		Thrissur	KERALA	Thrissur	\N	\N	680561
3091	Inchakundu B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680312
3092	Inchamudy B.O		Thrissur	KERALA	Thrissur	\N	\N	680564
3093	Kaduppassery  South B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680683
3094	Kallur S.O (Thrissur)		Thrissur	KERALA	Mukundapuram	\N	\N	680317
3095	Kattoor S.O		Thrissur	KERALA	Mukundapuram	\N	\N	680702
3096	Kilakkummuri S.O		Thrissur	KERALA	Thrissur	\N	\N	680571
3097	Kombathukadavu B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680682
3098	Koratti S.O		Thrissur	KERALA	Mukundapuram	\N	\N	680308
3099	Kottamuri B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680732
3100	Kurumbilavu B.O		Thrissur	KERALA	Thrissur	\N	\N	680564
3101	Kuttamangalam B.O		Thrissur	KERALA	Kodungallur	\N	\N	680703
3102	Lokamaleswaram North B.O		Thrissur	KERALA	Kodungallur	\N	\N	680664
3103	Mathilakam S.O		Thrissur	KERALA	Kodungallur	\N	\N	680685
3104	Nandikkara B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680301
3105	Perambra-thrissur S.O		Thrissur	KERALA	Mukundapuram	\N	\N	680689
3106	Pooppathy B.O		Thrissur	KERALA	Kodungallur	\N	\N	680733
3107	Pudukad S.O		Thrissur	KERALA	Mukundapuram	\N	\N	680301
3108	Thottippal B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680310
3109	Thumbur B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680662
3110	Vattanathara B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680302
3111	Velupadam B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680303
3112	Chalingad B.O		Thrissur	KERALA	Kodungallur	\N	\N	680681
3113	Chelur B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680121
3114	Erayamkudi B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680308
3115	Iranikulam B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680734
3116	Irinjalakuda H.O		Thrissur	KERALA	Mukundapuram Taluk	\N	\N	680121
3117	Irinjalakuda Mkt S.O		Thrissur	KERALA	Mukundapuram	\N	\N	680121
3118	Kalparamba B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680662
3119	Kannikulangara B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680682
3120	Kinfra Park Koratti S.O		Thrissur	KERALA	Mukundapuram	\N	\N	680309
3121	Kodakara S.O		Thrissur	KERALA	Mukundapuram	\N	\N	680684
3122	Konnakuzhy B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680721
3123	Koolimuttam S.O		Thrissur	KERALA	Kodungallur	\N	\N	680691
3124	Koratti South B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680308
3125	Kottat B.O		Thrissur	KERALA	NA	\N	\N	680731
3126	Kundur B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680734
3127	Mala-thrissur S.O		Thrissur	KERALA	Mukundapuram	\N	\N	680732
3128	Methala S.O		Thrissur	KERALA	Kodungallur	\N	\N	680669
3129	Nattikabeach B.O		Thrissur	KERALA	Chavakkad	\N	\N	680566
3130	Parappukkara S.O		Thrissur	KERALA	Mukundapuram	\N	\N	680310
3131	Pazhuvil S.O		Thrissur	KERALA	Thrissur	\N	\N	680564
3132	Pazhuvil West B.O		Thrissur	KERALA	Thrissur	\N	\N	680564
3133	Peringottukara S.O		Thrissur	KERALA	Thrissur	\N	\N	680565
3134	Poovathussery B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680741
3135	Alur-Kalletumkara B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680683
3136	Ashtamichira S.O		Thrissur	KERALA	Mukundapuram	\N	\N	680731
3137	Chamakkala B.O		Thrissur	KERALA	Kodungallur	\N	\N	680687
3138	Chattikulam B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680721
3139	Chittissery B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680301
3140	Irinjalakuda North S.O		Thrissur	KERALA	Mukundapuram	\N	\N	680125
3141	Kannampallipuram B.O		Thrissur	KERALA	Kodungallur	\N	\N	680687
3142	Kizhupillikkara B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680702
3143	Kothaparamba S.O		Thrissur	KERALA	Kodungallur	\N	\N	680668
3144	Kunnappilly B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680311
3145	Kuruvilassery B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680732
3146	Moorkkanad B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680711
3147	Murikkungal B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680699
3148	Nellayi-thrissur S.O		Thrissur	KERALA	Mukundapuram	\N	\N	680305
3149	Padiyur B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680688
3150	Palappilly S.O		Thrissur	KERALA	Mukundapuram	\N	\N	680304
3151	Palayamparambu B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680741
3152	Pullut North B.O		Thrissur	KERALA	Kodungallur	\N	\N	680663
3153	Pullut S.O		Thrissur	KERALA	Kodungallur	\N	\N	680663
3154	Puthenchira Kizhakkummuri B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680682
3155	Puthenchira S.O		Thrissur	KERALA	Mukundapuram	\N	\N	680682
3156	Srinngapuram S.O		Thrissur	KERALA	NA	\N	\N	680664
3157	Thanissery S.O		Thrissur	KERALA	Mukundapuram	\N	\N	680701
3158	Thazhekkad S.O		Thrissur	KERALA	Mukundapuram	\N	\N	680697
3159	Triprayar B.O		Thrissur	KERALA	Chavakkad	\N	\N	680567
3160	Urakam S.O		Thrissur	KERALA	Thrissur	\N	\N	680562
3161	Vellanchira B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680697
3162	Azhikode-Thrissur B.O		Thrissur	KERALA	Kodungallur	\N	\N	680666
3163	Chalakudi R S B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680722
3164	Chalakudi South S.O		Thrissur	KERALA	NA	\N	\N	680307
3165	Chembuchira B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680684
3166	Chentrappinni East B.O		Thrissur	KERALA	Kodungallur	\N	\N	680687
3167	Kaipamangalam Beach B.O		Thrissur	KERALA	Kodungallur	\N	\N	680681
3168	Kaipamangalam S.O		Thrissur	KERALA	Kodungallur	\N	\N	680681
3169	Kalimbram B.O		Thrissur	KERALA	Chavakkad	\N	\N	680568
3170	Karayamvattam B.O		Thrissur	KERALA	Chavakkad	\N	\N	680567
3171	Karupadanna S.O		Thrissur	KERALA	Mukundapuram	\N	\N	680670
3172	Konathukunnu S.O		Thrissur	KERALA	Mukundapuram	\N	\N	680123
3173	Koovakkattukunnu B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680311
3174	Kottanallur B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680662
3175	Kottappuram S.O		Thrissur	KERALA	Kodungallur	\N	\N	680667
3176	Nadavaramba S.O		Thrissur	KERALA	Mukundapuram	\N	\N	680661
3177	Pathazhakkad B.O		Thrissur	KERALA	Kodungallur	\N	\N	680668
3178	Santhipuram B.O		Thrissur	KERALA	Kodungallur	\N	\N	680668
3179	Vellikulangara B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680699
3180	Anandapuram B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680305
3181	Arattupuzha B.O		Thrissur	KERALA	Thrissur	\N	\N	680562
3182	Azhikode Jetty B.O		Thrissur	KERALA	Kodungallur	\N	\N	680666
3183	Chengallur S.O		Thrissur	KERALA	Mukundapuram	\N	\N	680312
3184	Chimoni Dam B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680304
3185	Edamuttam S.O		Thrissur	KERALA	Chavakkad	\N	\N	680568
3186	Edavilangu S.O		Thrissur	KERALA	Kodungallur	\N	\N	680671
3187	Kanakamala B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680689
3188	Kanjirappilly-TCR B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680721
3189	Karumathra B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680123
3190	Kodungallur S.O		Thrissur	KERALA	Kodungallur	\N	\N	680664
3191	Koratti Kizhakkumuri B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680308
3192	Krishnankotta B.O		Thrissur	KERALA	Kodungallur	\N	\N	680733
3193	Madayikonam S.O		Thrissur	KERALA	Mukundapuram	\N	\N	680712
3194	Melur S.O (Thrissur)		Thrissur	KERALA	Mukundapuram	\N	\N	680311
3195	Nalukettu B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680308
3196	Nattika S.O		Thrissur	KERALA	Chavakkad	\N	\N	680566
3197	Nenmenikkara B.O		Thrissur	KERALA	NA	\N	\N	680301
3198	Pallipuram B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680732
3199	Pootharakkal B.O		Thrissur	KERALA	Thrissur	\N	\N	680561
3200	Pullur B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680683
3201	Puthenchira Thekkummuri B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680682
3202	Vadakkummuri S.O		Thrissur	KERALA	Thrissur	\N	\N	680570
3203	Vallivattam B.O		Thrissur	KERALA	Kodungallur	\N	\N	680123
3204	Alagappanagar S.O		Thrissur	KERALA	Mukundapuram	\N	\N	680302
3205	Alathur(Thrissur) B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680741
3206	Anapuzha B.O		Thrissur	KERALA	Kodungallur	\N	\N	680667
3207	Avittathur B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680683
3208	Chalakudi Town S.O		Thrissur	KERALA	NA	\N	\N	680307
3209	Chentrappinni S.O		Thrissur	KERALA	Kodungallur	\N	\N	680687
3210	Cherpu S.O		Thrissur	KERALA	Thrissur	\N	\N	680561
3211	Cheruvallur B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680308
3212	Edakulam B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680688
3213	Edathuruthy S.O		Thrissur	KERALA	Mukundapuram	\N	\N	680703
3214	Kadukutty B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680309
3215	Karanchira B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680702
3216	Karur B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680697
3217	Kuttikkad B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680724
3218	Malakkapara B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680721
3219	Manakulangara B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680684
3220	Mattathurkkunnu B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680684
3221	Muringoor Vadakkummuri B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680309
3222	Muttithadi B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680317
3223	Nandipulam B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680312
3224	Pariyaram S.O (Thrissur)		Thrissur	KERALA	Mukundapuram	\N	\N	680721
3225	Potta S.O		Thrissur	KERALA	Mukundapuram	\N	\N	680722
3226	Poyya S.O		Thrissur	KERALA	Kodungallur	\N	\N	680733
3227	Varakara B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680302
3228	Vijayaraghavapuram B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680722
3229	Chaipankuzhi B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680724
3230	Chakkarappadam B.O		Thrissur	KERALA	Kodungallur	\N	\N	680686
3231	Chalakudi H.O		Thrissur	KERALA	Mukundapuram Taluk	\N	\N	680307
3232	Chokkana B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680699
3233	Chulur B.O		Thrissur	KERALA	Chavakkad	\N	\N	680567
3234	Edathirinji S.O		Thrissur	KERALA	Mukundapuram	\N	\N	680122
3235	Elinjipra B.O		Thrissur	KERALA	Mi\\ukundapuram	\N	\N	680721
3236	Eriyad S.O		Thrissur	KERALA	Kodungallur	\N	\N	680666
3237	Kandamkulam B.O		Thrissur	KERALA	Kodungallur	\N	\N	680669
3238	Kara B.O		Thrissur	KERALA	Kodungallur	\N	\N	680671
3239	Kodassery B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680721
3240	Koorikuzhi B.O		Thrissur	KERALA	Kodungallur	\N	\N	680681
3241	Kuttichira S.O		Thrissur	KERALA	Mukundapuram	\N	\N	680724
3242	Madavana B.O		Thrissur	KERALA	Kodungallur	\N	\N	680666
3243	Mattathur B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680684
3244	Mupliyam B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680312
3245	Muriyad B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680683
3246	Panangad S.O (Thrissur)		Thrissur	KERALA	Kodungallur	\N	\N	680665
3247	Perinjanam S.O		Thrissur	KERALA	Kodungallur	\N	\N	680686
3248	Porathissery B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680125
3249	Valapad S.O		Thrissur	KERALA	Chavakkad	\N	\N	680567
3250	Varandarappilly S.O		Thrissur	KERALA	Mukundapuram	\N	\N	680303
3251	Alanad B.O		Kottayam	KERALA	Meenachil	\N	\N	686651
3252	Athirampuzha S.O		Kottayam	KERALA	Kottayam	\N	\N	686562
3253	Aymanam S.O		Kottayam	KERALA	Kottayam	\N	\N	686015
3254	Brahmamangalam B.O		Kottayam	KERALA	Vaikom	\N	\N	686605
3255	Chamakala B.O		Kottayam	KERALA	Vaikom	\N	\N	686603
3256	Chengalam South S.O		Kottayam	KERALA	Kottayam	\N	\N	686022
3257	Chennad B.O		Kottayam	KERALA	Meenachil	\N	\N	686581
3258	Ezhacherry B.O		Kottayam	KERALA	Meenachil	\N	\N	686651
3259	Ezhumanthuruth B.O		Kottayam	KERALA	Vaikom	\N	\N	686613
3260	Kattachira B.O		Kottayam	KERALA	Meenachil	\N	\N	686572
3261	Keezhoor B.O		Kottayam	KERALA	Vaikom	\N	\N	686605
3262	Kezhuvankulam B.O		Kottayam	KERALA	Meenachil	\N	\N	686584
3263	Kollad B.O		Kottayam	KERALA	Kottayam	\N	\N	686004
3264	Kongandoor B.O		Kottayam	KERALA	Kottayam	\N	\N	686564
3265	Kottayam H.O		Kottayam	KERALA	Kottayam	\N	\N	686001
3266	Kottayam West S.O		Kottayam	KERALA	Kottayam	\N	\N	686003
3267	Kumaranalloor S.O		Kottayam	KERALA	Kottayam	\N	\N	686016
3268	Mallikasery B.O		Kottayam	KERALA	Meenachil	\N	\N	686577
3269	Manjoor S.O		Kottayam	KERALA	Vaikom	\N	\N	686603
3270	Mariappally B.O		Kottayam	KERALA	Kottayam	\N	\N	686013
3271	Mary Land B.O		Kottayam	KERALA	Meenachil	\N	\N	686652
3272	Mechal B.O		Kottayam	KERALA	Meenachil	\N	\N	686586
3273	Midayikunnu B.O		Kottayam	KERALA	Vaikom	\N	\N	686605
3274	Palai H.O		Kottayam	KERALA	Meenachil	\N	\N	686575
3275	Palakkattumala B.O		Kottayam	KERALA	Meenachil	\N	\N	686635
3276	Poovathode B.O		Kottayam	KERALA	Meenachil	\N	\N	686578
3277	Puthuvely B.O		Kottayam	KERALA	Meenachil	\N	\N	686636
3278	Thidanad S.O		Kottayam	KERALA	Meenachil	\N	\N	686123
3279	Vellikulam B.O		Kottayam	KERALA	Meenachil	\N	\N	686580
3280	Villoonni B.O		Kottayam	KERALA	Kottayam	\N	\N	686008
3281	Amalagiri B.O		Kottayam	KERALA	Kottayam	\N	\N	686561
3282	Amayannur B.O		Kottayam	KERALA	Kottayam	\N	\N	686019
3283	Arumanur B.O		Kottayam	KERALA	Kottayam	\N	\N	686564
3284	Chakkampuzha B.O		Kottayam	KERALA	Meenachil	\N	\N	686574
3285	Elakad B.O		Kottayam	KERALA	Meenachil	\N	\N	686587
3286	Erattupetta S.O		Kottayam	KERALA	Meenachil	\N	\N	686121
3287	Kalathoor B.O		Kottayam	KERALA	Meenachil	\N	\N	686633
3288	Karikode B.O		Kottayam	KERALA	Vaikom	\N	\N	686610
3289	Kizhathiri B.O		Kottayam	KERALA	Meenachil	\N	\N	686576
3290	Kottayam Collectorate S.O		Kottayam	KERALA	Kottayam	\N	\N	686002
3291	Kurianad B.O		Kottayam	KERALA	Meenachil	\N	\N	686636
3292	Kurumannu B.O		Kottayam	KERALA	Meenachil	\N	\N	686651
3293	Kurumulloor B.O		Kottayam	KERALA	Meenachil	\N	\N	686632
3294	Madukkakunuu B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686577
3295	Malam B.O		Kottayam	KERALA	Kottayam	\N	\N	686019
3296	Malloossery S.O		Kottayam	KERALA	Kottayam	\N	\N	686041
3297	Mannanam S.O		Kottayam	KERALA	Kottayam	\N	\N	686561
3298	Meenachil B.O		Kottayam	KERALA	Meenachil	\N	\N	686577
3299	Melukavumattom S.O		Kottayam	KERALA	Meenachil	\N	\N	686652
3300	Muttuchira S.O		Kottayam	KERALA	Vaikom	\N	\N	686613
3301	Njizhoor S.O		Kottayam	KERALA	Vaikom	\N	\N	686612
3302	Pala Town S.O		Kottayam	KERALA	Meenachil	\N	\N	686575
3303	Pallippurathussery B.O		Kottayam	KERALA	Vaikom	\N	\N	686606
3304	Payyappady B.O		Kottayam	KERALA	Kottayam	\N	\N	686011
3305	Ramapuram Bazar S.O		Kottayam	KERALA	Meenachil	\N	\N	686576
3306	Thellakom S.O		Kottayam	KERALA	Kottayam	\N	\N	686630
3307	Thiruvarppu B.O		Kottayam	KERALA	Kottayam	\N	\N	686020
3308	Thrikothamangalam B.O		Kottayam	KERALA	Kottayam	\N	\N	686011
3309	Ullanad B.O		Kottayam	KERALA	Meenachil	\N	\N	686651
3310	Vadakara - Thalayolaparabu B.O		Kottayam	KERALA	Vaikom	\N	\N	686605
3311	Vadayar B.O		Kottayam	KERALA	Vaikom	\N	\N	686605
3312	Vaikom H.O		Kottayam	KERALA	Vaikom	\N	\N	686141
3313	Vakad B.O		Kottayam	KERALA	Vaikom	\N	\N	686636
3314	Amanakara B.O		Kottayam	KERALA	Meenachil	\N	\N	686576
3315	Ampara Nirappel B.O		Kottayam	KERALA	Meenachil	\N	\N	686578
3316	Anjoottimangalam B.O		Kottayam	KERALA	Meenachil	\N	\N	686579
3317	Apporkara B.O		Kottayam	KERALA	Kottayam	\N	\N	686008
3318	Arpookara East B.O		Kottayam	KERALA	Kottayam	\N	\N	686008
3319	Ayyarkulangara B.O		Kottayam	KERALA	Vaikom	\N	\N	686146
3320	Chempilavu B.O		Kottayam	KERALA	Meenachil	\N	\N	686584
3321	Edanad B.O		Kottayam	KERALA	Meenachil	\N	\N	686574
3322	Ettumanur Junction S.O		Kottayam	KERALA	Kottayam	\N	\N	686631
3323	Kadanad Meenachil S.O		Kottayam	KERALA	Meenachil	\N	\N	686653
3324	Kaduthuruthy S.O		Kottayam	KERALA	Vaikom	\N	\N	686604
3325	Karimpani B.O		Kottayam	KERALA	Kottayam	\N	\N	686564
3326	Kidangoor South S.O		Kottayam	KERALA	Meenachil	\N	\N	686583
3327	Kottakkapuram B.O		Kottayam	KERALA	Kottayam	\N	\N	686631
3328	Kottayam North S.O		Kottayam	KERALA	Kottayam	\N	\N	686001
3329	Kottayam South B.O		Kottayam	KERALA	Kottayam	\N	\N	686013
3330	Kozhuvanal B.O		Kottayam	KERALA	Meenachil	\N	\N	686573
3331	Kunnam B.O		Kottayam	KERALA	Meenachil	\N	\N	686582
3332	Kurinji B.O		Kottayam	KERALA	Meenachil	\N	\N	686576
3333	Manganam S.O		Kottayam	KERALA	Kottayam	\N	\N	686018
3334	Mediri B.O		Kottayam	KERALA	Meenachil	\N	\N	686576
3335	Mevelloor S.O		Kottayam	KERALA	Vaikom	\N	\N	686609
3336	Moonnilavu S.O		Kottayam	KERALA	Meenachil	\N	\N	686586
3337	Nadackal B.O		Kottayam	KERALA	Meenachil	\N	\N	686121
3338	Nattassery S H Mount S.O		Kottayam	KERALA	Kottayam	\N	\N	686006
3339	Njandupara B.O		Kottayam	KERALA	Kanjirappally	\N	\N	686577
3340	Onamthuruthu B.O		Kottayam	KERALA	Kottayam	\N	\N	686602
3341	Ozhavur East B.O		Kottayam	KERALA	Meenachil	\N	\N	686634
3342	Ozhavur S.O		Kottayam	KERALA	Vaikom	\N	\N	686634
3343	Parippu B.O		Kottayam	KERALA	Kottayam	\N	\N	686014
3344	Payyappar B.O		Kottayam	KERALA	Meenachil	\N	\N	686651
3345	Perumbaikkad B.O		Kottayam	KERALA	Kottayam	\N	\N	686016
3346	Pizhaku B.O		Kottayam	KERALA	Meenachil	\N	\N	686651
3347	Pravithanam B.O		Kottayam	KERALA	Meenachil	\N	\N	686651
3348	Pulikkuttissery B.O		Kottayam	KERALA	Kottayam	\N	\N	686015
3349	Thottakom B.O		Kottayam	KERALA	Vaikom	\N	\N	686607
3350	Vaikom Thekkenada B.O		Kottayam	KERALA	Vaikom	\N	\N	686146
3351	Velliappally B.O		Kottayam	KERALA	Meenachil	\N	\N	686574
3352	Adukkam B.O		Kottayam	KERALA	Meenachil	\N	\N	686580
3353	Chemmanathukara B.O		Kottayam	KERALA	Vaikom	\N	\N	686606
3354	Cholathadom B.O		Kottayam	KERALA	Meenachil	\N	\N	686582
3355	Chovvur B.O		Kottayam	KERALA	Meenachil	\N	\N	686586
3356	Kalathukadavu B.O		Kottayam	KERALA	Meenachil	\N	\N	686579
3357	Kallara South B.O		Kottayam	KERALA	Vaikom	\N	\N	686611
3358	Kanjiram B.O		Kottayam	KERALA	Kottayam	\N	\N	686020
3359	Kanjirathanam B.O		Kottayam	KERALA	Vaikom	\N	\N	686603
3360	Kattampack B.O		Kottayam	KERALA	Vaikom	\N	\N	686612
3361	Kayyoor B.O		Kottayam	KERALA	Meenachil	\N	\N	686651
3362	Kizhaparayar B.O		Kottayam	KERALA	Meenachil	\N	\N	686578
3363	Kummanam B.O		Kottayam	KERALA	Kottayam	\N	\N	686005
3364	Marangoli B.O		Kottayam	KERALA	Vaikom	\N	\N	686612
3365	Mattathipara B.O		Kottayam	KERALA	Meenachil	\N	\N	686651
3366	Monippally S.O		Kottayam	KERALA	Meenachil	\N	\N	686636
3367	Moozhikulangara B.O		Kottayam	KERALA	Kottayam	\N	\N	686601
3368	Mulakulam South B.O		Kottayam	KERALA	Vaikom	\N	\N	686610
3369	Mutholi B.O		Kottayam	KERALA	Meenachil	\N	\N	686573
3370	Muttambalam S.O		Kottayam	KERALA	Kottayam	\N	\N	686004
3371	Padinjattinkara B.O		Kottayam	KERALA	Meenachil	\N	\N	686571
3372	Pariyaram S.O (Kottayam)		Kottayam	KERALA	Kottayam	\N	\N	686021
3373	Peroor S.O		Kottayam	KERALA	Kottayam	\N	\N	686637
3374	Ponand-karur B.O		Kottayam	KERALA	Meenachil	\N	\N	686574
3375	Poonjar Thekkekara S.O		Kottayam	KERALA	Meenachil	\N	\N	686582
3376	Ramapuram B.O		Kottayam	KERALA	Meenachil	\N	\N	686576
3377	Thalayolaparambu S.O		Kottayam	KERALA	Vaikom	\N	\N	686605
3378	Thazhathangady S.O		Kottayam	KERALA	Kottayam	\N	\N	686005
3379	Thirunakkara S.O		Kottayam	KERALA	Kottayam	\N	\N	686001
3380	Thiruvanchoor B.O		Kottayam	KERALA	Kottayam	\N	\N	686019
3381	Thiruvanpady B.O		Kottayam	KERALA	Vaikom	\N	\N	686612
3382	Thodanal B.O		Kottayam	KERALA	Meenachil	\N	\N	686573
3383	Udayanapuram S.O		Kottayam	KERALA	Vaikom	\N	\N	686143
3384	Vadavathoor S.O		Kottayam	KERALA	Kottayam	\N	\N	686010
3385	Vaikaprayar B.O		Kottayam	KERALA	Vaikom	\N	\N	686146
3386	Vallichira B.O		Kottayam	KERALA	Meenachil	\N	\N	686574
3387	Vattakunnu B.O		Kottayam	KERALA	Kottayam	\N	\N	686516
3388	Vattukulam B.O		Kottayam	KERALA	Meenachil	\N	\N	686587
3389	Velathusseri B.O		Kottayam	KERALA	Meenachil	\N	\N	686580
3390	Vettimukal B.O		Kottayam	KERALA	Kottayam	\N	\N	686631
3391	Ayamkudy B.O		Kottayam	KERALA	Vaikom	\N	\N	686613
3392	Devalokam B.O		Kottayam	KERALA	Kottayam	\N	\N	686004
3393	Elikulam B.O		Kottayam	KERALA	Meenachil	\N	\N	686577
3394	Eravimangalam B.O		Kottayam	KERALA	Vaikom	\N	\N	686613
3395	Gandhi Nagar S.O (Kottayam)		Kottayam	KERALA	Kottayam	\N	\N	686008
3396	Irumpayam B.O		Kottayam	KERALA	Vaikom	\N	\N	686605
3397	Kadaplamattom S.O		Kottayam	KERALA	Meenachil	\N	\N	686571
3398	Kaipally B.O		Kottayam	KERALA	Meenachil	\N	\N	686582
3399	Konipad B.O		Kottayam	KERALA	Meenachil	\N	\N	686652
3400	Kothavara B.O		Kottayam	KERALA	Vaikom	\N	\N	686607
3401	Kudakkachira B.O		Kottayam	KERALA	Meenachil	\N	\N	686635
3402	Kudamaloor S.O		Kottayam	KERALA	Kottayam	\N	\N	686017
3403	Kumarakom S.O		Kottayam	KERALA	Kottayam	\N	\N	686563
3404	Kurichithanam B.O		Kottayam	KERALA	Vaikom	\N	\N	686634
3405	Kuruppamthara B.O		Kottayam	KERALA	Vaikom	\N	\N	686603
3406	Mannackanad B.O		Kottayam	KERALA	Meenachil	\N	\N	686633
3407	Maravanthuruthu B.O		Kottayam	KERALA	Vaikom	\N	\N	686608
3408	Meenadom S.O		Kottayam	KERALA	Kottayam	\N	\N	686516
3409	Nazreth Hill B.O		Kottayam	KERALA	Meenachil	\N	\N	686633
3410	Nechipuzhoor B.O		Kottayam	KERALA	Meenachil	\N	\N	686574
3411	Neerikkad B.O		Kottayam	KERALA	Kottayam	\N	\N	686564
3412	Padinjarekkara S.O		Kottayam	KERALA	Voikom	\N	\N	686146
3413	Palai Market Junction S.O		Kottayam	KERALA	Meenachil	\N	\N	686575
3414	Peringalam B.O		Kottayam	KERALA	Meenachil	\N	\N	686582
3415	Perumthuruth B.O		Kottayam	KERALA	Vaikom	\N	\N	686611
3416	Poovarani S.O		Kottayam	KERALA	Meenachil	\N	\N	686577
3417	Teekoy S.O		Kottayam	KERALA	Meenachil	\N	\N	686580
3418	Thirumani Venkita Puram S.O		Kottayam	KERALA	Vaikom	\N	\N	686606
3419	Vadakkenirappu B.O		Kottayam	KERALA	Vaikom	\N	\N	686612
3420	Vechoor B.O		Kottayam	KERALA	Vaikom	\N	\N	686144
3421	Adivaram B.O		Kottayam	KERALA	Meenachil	\N	\N	686582
3422	Akkarapadom B.O		Kottayam	KERALA	Vaikom	\N	\N	686143
3423	Arunapuram S.O		Kottayam	KERALA	Meenachil	\N	\N	686574
3424	Ayarkunnam S.O		Kottayam	KERALA	Kottayam	\N	\N	686564
3425	Cherpunkal S.O		Kottayam	KERALA	Meenachil	\N	\N	686584
3426	Edavattom B.O		Kottayam	KERALA	Vaikom	\N	\N	686605
3427	Ettumanur S.O		Kottayam	KERALA	Kottayam	\N	\N	686631
3428	Kadappattoor B.O		Kottayam	KERALA	Meenachil	\N	\N	686574
3429	Kallara S.O (Kottayam)		Kottayam	KERALA	Vaikom	\N	\N	686611
3430	Kanakari S.O		Kottayam	KERALA	Meenachil	\N	\N	686632
3431	Kappumthala B.O		Kottayam	KERALA	Vaikom	\N	\N	686613
3432	Kiliroor North S.O		Kottayam	KERALA	Kottayam	\N	\N	686020
3433	Koodapalam B.O		Kottayam	KERALA	Meenachil	\N	\N	686576
3434	Kumarakom North B.O		Kottayam	KERALA	Kottayam	\N	\N	686563
3435	Melukavu B.O		Kottayam	KERALA	Meenachil	\N	\N	686652
3436	Mevada B.O		Kottayam	KERALA	Meenachil	\N	\N	686573
3437	Moolavattom B.O		Kottayam	KERALA	Kottayam	\N	\N	686012
3438	Nariayanganam B.O		Kottayam	KERALA	Meenachil	\N	\N	686579
3439	Neendoor S.O		Kottayam	KERALA	Kottayam	\N	\N	686601
3440	Newsprint Nagar S.O		Kottayam	KERALA	Vaikom	\N	\N	686616
3441	Olessa S.O		Kottayam	KERALA	Kottayam	\N	\N	686014
3442	Paduva B.O		Kottayam	KERALA	Kottayam	\N	\N	686564
3443	Pakkil S.O		Kottayam	KERALA	Kottayam	\N	\N	686012
3444	Pattithanam B.O		Kottayam	KERALA	Kottayam	\N	\N	686631
3445	Peruva S.O		Kottayam	KERALA	Vaikom	\N	\N	686610
3446	Plassanal S.O		Kottayam	KERALA	Meenachil	\N	\N	686579
3447	Poonjar S.O		Kottayam	KERALA	Meenachil	\N	\N	686581
3448	Poovanthuruthu GDSB.O		Kottayam	KERALA	Kottayam	\N	\N	686012
3449	Puliyannoor S.O		Kottayam	KERALA	Meenachil	\N	\N	686573
3450	Punnathura B.O		Kottayam	KERALA	Kottayam	\N	\N	686583
3451	Puthupalli S.O		Kottayam	KERALA	Kottayam	\N	\N	686011
3452	Sreekantamangalam B.O		Kottayam	KERALA	Kottayam	\N	\N	686562
3453	Valavoor B.O		Kottayam	KERALA	Meenachil	\N	\N	686635
3454	Veliyannoor B.O		Kottayam	KERALA	Vaikom	\N	\N	686634
3455	Veloor B.O		Kottayam	KERALA	Kottayam	\N	\N	686003
3456	Vempally B.O		Kottayam	KERALA	Vaikom	\N	\N	686633
3457	Anthinad S.O		Kottayam	KERALA	Meenachil	\N	\N	686651
3458	Chempu B.O		Kottayam	KERALA	Vaikom	\N	\N	686608
3459	Kidangoor S.O		Kottayam	KERALA	Meenachil	\N	\N	686572
3460	Kizhakkenmattom B.O		Kottayam	KERALA	Meenachil	\N	\N	686652
3461	Kizhathadiyur B.O		Kottayam	KERALA	Meenachil	\N	\N	686574
3462	Kozha B.O		Kottayam	KERALA	Vaikom	\N	\N	686633
3463	Kulasekharamangalam S.O		Kottayam	KERALA	Vaikom	\N	\N	686608
3464	Kumarakom East B.O		Kottayam	KERALA	Kottayam	\N	\N	686563
3465	Kumarakom South B.O		Kottayam	KERALA	Kottayam	\N	\N	686563
3466	Kuravilangadu S.O		Kottayam	KERALA	Meenachil	\N	\N	686633
3467	Manarcaudu S.O		Kottayam	KERALA	Kottayam	\N	\N	686019
3468	Manjoor South B.O		Kottayam	KERALA	Vaikom	\N	\N	686603
3469	Marangattupally S.O		Kottayam	KERALA	Vaikom	\N	\N	686635
3470	Mariathuruthu B.O		Kottayam	KERALA	Kottayam	\N	\N	686017
3471	Mattakkara B.O		Kottayam	KERALA	Kottayam	\N	\N	686564
3472	Melampara B.O		Kottayam	KERALA	Meenachil	\N	\N	686578
3473	Memuri B.O		Kottayam	KERALA	Vaikom	\N	\N	686611
3474	Mundankal B.O		Kottayam	KERALA	Meenachil	\N	\N	686574
3475	Nattakom S.O		Kottayam	KERALA	Kottayam	\N	\N	686013
3476	Neeloor B.O		Kottayam	KERALA	Meenachil	\N	\N	686651
3477	Parampuzha B.O		Kottayam	KERALA	Kottayam	\N	\N	686004
3478	Pathampuzha B.O		Kottayam	KERALA	Meenachil	\N	\N	686582
3479	Punnathura West B.O		Kottayam	KERALA	Kottayam	\N	\N	686631
3480	Ambika Market B.O		Kottayam	KERALA	Vaikom	\N	\N	686144
3481	Arunoottimangalam B.O		Kottayam	KERALA	Vaikom	\N	\N	686604
3482	Aruvithura S.O		Kottayam	KERALA	Meenachil	\N	\N	686122
3483	Bharananganam S.O		Kottayam	KERALA	Meenachil	\N	\N	686578
3484	Cheepunkal B.O		Kottayam	KERALA	Kottayam	\N	\N	686563
3485	Choondacherry B.O		Kottayam	KERALA	Meenachil	\N	\N	686579
3486	Edamaruku B.O		Kottayam	KERALA	Meenachil	\N	\N	686652
3487	Edappady B.O		Kottayam	KERALA	Meenachil	\N	\N	686578
3488	Enadi B.O		Kottayam	KERALA	Vaikom	\N	\N	686608
3489	Eravinalloor B.O		Kottayam	KERALA	Kottayam	\N	\N	686011
3490	Erumapramattom B.O		Kottayam	KERALA	Meenachil	\N	\N	686586
3491	Idamattom B.O		Kottayam	KERALA	Meenachil	\N	\N	686578
3492	Idiyanal B.O		Kottayam	KERALA	Meenachil	\N	\N	686576
3493	Kaipuzha S.O		Kottayam	KERALA	Kottayam	\N	\N	686602
3494	Karipadom B.O		Kottayam	KERALA	Vaikom	\N	\N	686605
3495	Kodumpidi B.O		Kottayam	KERALA	Meenachil	\N	\N	686651
3496	Kothanallur B.O		Kottayam	KERALA	Meenachil	\N	\N	686632
3497	Kudalloor B.O		Kottayam	KERALA	Meenachil	\N	\N	686587
3498	Kudavechoor S.O		Kottayam	KERALA	Vaikom	\N	\N	686144
3499	Kummannoor B.O		Kottayam	KERALA	Meenachil	\N	\N	686572
3500	Pakalomattom B.O		Kottayam	KERALA	Meenachil	\N	\N	686633
3501	Pallom S.O		Kottayam	KERALA	Kottayam	\N	\N	686007
3502	Pious Mount B.O		Kottayam	KERALA	Meenachil	\N	\N	686636
3503	Poozhikole B.O		Kottayam	KERALA	Vaikom	\N	\N	686604
3504	Priyadarsini Hills S.O		Kottayam	KERALA	Kottayam	\N	\N	686560
3505	Rubber Board S.O		Kottayam	KERALA	Kottayam	\N	\N	686009
3506	Thalanad B.O		Kottayam	KERALA	Meenachil	\N	\N	686580
3507	Thalayazham S.O		Kottayam	KERALA	Vaikom	\N	\N	686607
3508	Vayala S.O		Kottayam	KERALA	Meenachil	\N	\N	686587
3509	Chetlat S.O		Lakshadweep	LAKSHADWEEP	Lakshadweep	\N	\N	682554
3510	Kavaratti S.O		Lakshadweep	LAKSHADWEEP	Lakshadweep	\N	\N	682555
3511	Amini S.O		Lakshadweep	LAKSHADWEEP	Amini	\N	\N	682552
3512	Androth S.O		Lakshadweep	LAKSHADWEEP	Lakshadweep	\N	\N	682551
3513	Bithra B.O		Lakshadweep	LAKSHADWEEP	Amini	\N	\N	682555
3514	Kadamat S.O		Lakshadweep	LAKSHADWEEP	Lakshadweep	\N	\N	682556
3515	Kalpeni S.O		Lakshadweep	LAKSHADWEEP	Lakshadweep	\N	\N	682557
3516	Minicoy S.O		Lakshadweep	LAKSHADWEEP	Lakshadweep	\N	\N	682559
3517	Kiltan S.O		Lakshadweep	LAKSHADWEEP	Lakshadweep	\N	\N	682558
3518	Agathi S.O		Lakshadweep	LAKSHADWEEP	Lakshadweep	\N	\N	682553
3519	Bharanickavu B.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690503
3520	Cheppaud S.O		Alappuzha	KERALA	Karthikappally	\N	\N	690507
3521	Ezhakadavu B.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690104
3522	Kandallur S.O		Alappuzha	KERALA	Karthikappally	\N	\N	690535
3523	Kareelakulangara S.O		Alappuzha	KERALA	Karthikappally	\N	\N	690572
3524	Mavelikara Court S.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690101
3525	Muttom-alleppey S.O		Alappuzha	KERALA	Karthikappally	\N	\N	690511
3526	Naduvattom B.O		Alappuzha	KERALA	Karthikappally	\N	\N	690512
3527	Pathiyoor B.O		Alappuzha	KERALA	Karthikappally	\N	\N	690508
3528	Puthiyacavu B.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690102
3529	Valiyaparambu B.O		Alappuzha	KERALA	Karthikappally	\N	\N	690516
3530	Choolatheruvu B.O		Alappuzha	KERALA	Karthikappally	\N	\N	690506
3531	Erezha South B.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690106
3532	Kallumala S.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690110
3533	Keerikad S.O		Alappuzha	KERALA	Karthikappally	\N	\N	690508
3534	Kodukulanji S.O		Alappuzha	KERALA	Chengannur	\N	\N	689508
3535	Kudassanad S.O		Alappuzha	KERALA	Mavelikkara	\N	\N	689512
3536	Kuttemperur S.O		Alappuzha	KERALA	Chengannur	\N	\N	689623
3537	Pallickal S.O		Alappuzha	KERALA	Mavelikara	\N	\N	690503
3538	Pandy B.O		Alappuzha	KERALA	Karthikappally	\N	\N	690517
3539	Pela B.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690103
3540	Peringala-mulakuzha B.O		Alappuzha	KERALA	Chengannur	\N	\N	689505
3541	Puthiyavila B.O		Alappuzha	KERALA	Karthikappally	\N	\N	690531
3542	Puthuppally S.O		Alappuzha	KERALA	Karthikappally	\N	\N	690527
3543	Thannikunnu B.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690534
3544	Varenickal B.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690107
3545	Arattupuzha B.O		Alappuzha	KERALA	Karthikappally	\N	\N	690535
3546	Ayiranikudy B.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690558
3547	Charumoodu S.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690505
3548	Cheruthana B.O		Alappuzha	KERALA	Karthikappally	\N	\N	690517
3549	Evur B.O		Alappuzha	KERALA	Karthikappally	\N	\N	690507
3550	Kannamangalam B.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690106
3551	Kappil East B.O		Alappuzha	KERALA	Mavelikara	\N	\N	690533
3552	Komallur B.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690505
3553	Kumarapuram S.O (Alappuzha)		Alappuzha	KERALA	Karthikappally	\N	\N	690548
3554	Kunnam S.O (Alappuzha)		Alappuzha	KERALA	Mavelikkara	\N	\N	690108
3555	Olakettiambalam S.O		Alappuzha	KERALA	Chengannur	\N	\N	690510
3556	Pallana B.O		Alappuzha	KERALA	Karthikappally	\N	\N	690515
3557	Panayil B.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690504
3558	Perungala S.O		Alappuzha	KERALA	Karthikappally	\N	\N	690559
3559	Vallikunnam S.O		Alappuzha	KERALA	Mavelikara	\N	\N	690501
3560	Akamkudy B.O		Alappuzha	KERALA	Karthikappally	\N	\N	690513
3561	Arattupuzha North B.O		Alappuzha	KERALA	Karthikappally	\N	\N	690515
3562	Arunoottimangalam B.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690110
3563	Eruva B.O		Alappuzha	KERALA	Karthikappally	\N	\N	690572
3564	Haripad S.O		Alappuzha	KERALA	Karthikappally	\N	\N	690514
3565	Kallimel B.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690509
3566	Karuvatta S.O		Alappuzha	KERALA	Karthikappally	\N	\N	690517
3567	Kattanam B.O		Alappuzha	KERALA	Mavelikara	\N	\N	690503
3568	Muthukulam South S.O		Alappuzha	KERALA	Karthikappally	\N	\N	690506
3569	Njakkanal B.O		Alappuzha	KERALA	Karthikappally	\N	\N	690533
3570	Pallickal -nooranad B.O		Pathanamthitta	KERALA	Adoor	\N	\N	690504
3571	Pavukara B.O		Alappuzha	KERALA	Chengannur	\N	\N	689622
3572	Peringilipuram B.O		Alappuzha	KERALA	Chengannur	\N	\N	689624
3573	Puthenchantha B.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690501
3574	Thrikkunnapuzha S.O		Alappuzha	KERALA	Karthikappally	\N	\N	690515
3575	Thripperunthura B.O		Alappuzha	KERALA	Mavelikara	\N	\N	690105
3576	Valiyakulangara B.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690104
3577	Vedaraplavu B.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690505
3578	Vettiyar B.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690558
3579	Areekara B.O		Alappuzha	KERALA	Chengannur	\N	\N	689505
3580	Ayaparambu B.O		Alappuzha	KERALA	Karthikappally	\N	\N	690517
3581	Chingoli S.O		Alappuzha	KERALA	Karthikappally	\N	\N	690532
3582	Chunakara S.O		Alappuzha	KERALA	Mavelikara	\N	\N	690534
3583	Eramathoor B.O		Alappuzha	KERALA	Chengannur	\N	\N	689622
3584	Karthikappally S.O		Alappuzha	KERALA	Karthikappally	\N	\N	690516
3585	Karuvatta North B.O		Alappuzha	KERALA	Karthikappally	\N	\N	690517
3586	Kayangulam H.O		Alappuzha	KERALA	Karthikappally	\N	\N	690502
3587	Kotta B.O		Alappuzha	KERALA	Chengannur	\N	\N	689504
3588	Mankamkuzhy S.O		Alappuzha	KERALA	Mavelikara	\N	\N	690558
3589	Mavelikara H.O		Alappuzha	KERALA	Mavelikara	\N	\N	690101
3590	Mulakuzha S.O		Alappuzha	KERALA	Chengannur	\N	\N	689505
3591	Muthukulam B.O		Alappuzha	KERALA	Karthikappally	\N	\N	690506
3592	Nangiarkulangara S.O		Alappuzha	KERALA	Karthikappally	\N	\N	690513
3593	Neduvaramkodu B.O		Alappuzha	KERALA	Chengannur	\N	\N	689508
3594	Pattolimarket S.O		Alappuzha	KERALA	Karthikappally	\N	\N	690531
3595	Punthala B.O		Alappuzha	KERALA	Chengannur	\N	\N	689509
3596	Thamallackal B.O		Alappuzha	KERALA	Karthikappally	\N	\N	690548
3597	Thamallackal North B.O		Alappuzha	KERALA	Karthikappally	\N	\N	690514
3598	Thazhakara S.O		Alappuzha	KERALA	Mavelikara	\N	\N	690102
3599	Athikattukulangara B.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690504
3600	Illippakulam B.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690503
3601	Kandiyoor B.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690103
3602	Kollakadavu S.O		Alappuzha	KERALA	Chengannur	\N	\N	690509
3603	Kozhuvallur S.O		Alappuzha	KERALA	Chengannur	\N	\N	689521
3604	Krishnapuram S.O (Alappuzha)		Alappuzha	KERALA	Karthikappally	\N	\N	690533
3605	Mannar S.O		Alappuzha	KERALA	Chengannur	\N	\N	689622
3606	Melpadom S.O		Alappuzha	KERALA	Mavelikara	\N	\N	689627
3607	Pallipad S.O		Alappuzha	KERALA	Karthikappally	\N	\N	690512
3608	Pattoor B.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690529
3609	Payipad B.O		Alappuzha	KERALA	Karthikappally	\N	\N	690514
3610	Poomala B.O		Alappuzha	KERALA	Chengannur	\N	\N	689520
3611	Chennithala S.O		Alappuzha	KERALA	Mavelikara	\N	\N	690105
3612	Chennithala South B.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690105
3613	Ennakkad S.O		Alappuzha	KERALA	Chengannur	\N	\N	689624
3614	Eravankara B.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690108
3615	Govindamuttom B.O		Alappuzha	KERALA	Karthikappally	\N	\N	690527
3616	Kaduvinal B.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690501
3617	Karakkad S.O		Alappuzha	KERALA	Chengannur	\N	\N	689504
3618	Mavelikara Cutcherry S.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690101
3619	Padanilam S.O		Alappuzha	KERALA	Mavelikara	\N	\N	690529
3620	Pennukkara S.O		Alappuzha	KERALA	Chengannur	\N	\N	689520
3621	Thekkekara S.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690107
3622	Valiyazheekkal B.O		Alappuzha	KERALA	Karthikappally	\N	\N	690535
3623	Venmony S.O		Alappuzha	KERALA	Chengannur	\N	\N	689509
3624	Vetticode B.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690503
3625	Cherukole S.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690104
3626	Chettikulangara S.O		Alappuzha	KERALA	Mavelikara	\N	\N	690106
3627	Erezha North B.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690106
3628	Erickavu B.O		Alappuzha	KERALA	Karthikappally	\N	\N	690516
3629	Kannanakuzhy B.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690505
3630	Karipuzha B.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690103
3631	Kayangulam College S.O		Alappuzha	KERALA	Karthikappally	\N	\N	690502
3632	Mahadevikadu B.O		Alappuzha	KERALA	Karthikappally	\N	\N	690516
3633	Mampra B.O		Alappuzha	KERALA	Chengannur	\N	\N	689508
3634	Mangalam B.O		Alappuzha	KERALA	Karthikappally	\N	\N	690515
3635	Mannarasala B.O		Alappuzha	KERALA	Karthikappally	\N	\N	690514
3636	Nooranad S.O		Alappuzha	KERALA	Mavelikara	\N	\N	690504
3637	Nooranad Sanatorium S.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690571
3638	Pallarimangalam B.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690107
3639	Pallickal Naduvilemuri B.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690503
3640	Payyanallur B.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690504
3641	Pullikanakku S.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690537
3642	Punnamoodu B.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690101
3643	Thamarakulam S.O		Alappuzha	KERALA	Mavelikara	\N	\N	690530
3644	Thattarambalam S.O		Alappuzha	KERALA	Mavelikkara	\N	\N	690103
3645	Veeyapuram B.O		Alappuzha	KERALA	Karthikappally	\N	\N	690514
3646	Adat B.O		Thrissur	KERALA	Thrissur	\N	\N	680551
3647	Agalad S.O		Thrissur	KERALA	Chavakkad	\N	\N	680518
3648	Akathiyur B.O		Thrissur	KERALA	Thalapilly	\N	\N	680519
3649	Alapad B.O		Thrissur	KERALA	Thrissur	\N	\N	680641
3650	Anchery B.O		Thrissur	KERALA	NA	\N	\N	680006
3651	Avanur B.O		Thrissur	KERALA	Thrissur	\N	\N	680541
3652	Chettupuzha B.O		Thrissur	KERALA	NA	\N	\N	680012
3653	Choolissery B.O		Thrissur	KERALA	Thrissur	\N	\N	680541
3654	Chottupara B.O		Thrissur	KERALA	Thrissur	\N	\N	680581
3655	Elavally B.O		Thrissur	KERALA	Chavakkad	\N	\N	680511
3656	Kadavallur S.O		Thrissur	KERALA	Talappilly	\N	\N	680543
3657	Kanattukara S.O		Thrissur	KERALA	Thrissur	\N	\N	680011
3658	Kavida B.O		Thrissur	KERALA	NA	\N	\N	680505
3659	Kecheri S.O		Thrissur	KERALA	Thalapilly	\N	\N	680501
3660	Kozhukully B.O		Thrissur	KERALA	Thrissur	\N	\N	680751
3661	Kumbalacode B.O		Thrissur	KERALA	Thalapilly	\N	\N	680587
3662	Kuriachira S.O		Thrissur	KERALA	NA	\N	\N	680006
3663	Manalur HS B.O		Thrissur	KERALA	Thrissur	\N	\N	680617
3664	Mangad B.O		Thrissur	KERALA	Talappilly	\N	\N	680542
3665	Mulagunnathukavu S.O		Thrissur	KERALA	Thrissur	\N	\N	680581
3666	Nadathara S.O		Thrissur	KERALA	NA	\N	\N	680751
3667	Naduvilkkara B.O		Thrissur	KERALA	Chavakkad	\N	\N	680614
3668	Nellikunnu B.O		Thrissur	KERALA	NA	\N	\N	680005
3669	Nelluvaya B.O		Thrissur	KERALA	Thalapilly	\N	\N	680584
3670	Netumpura B.O		Thrissur	KERALA	Talappilly	\N	\N	679531
3671	Orumanayur S.O		Thrissur	KERALA	Chavakkad	\N	\N	680512
3672	Palayur B.O		Thrissur	KERALA	NA	\N	\N	680506
3673	Panjal B.O		Thrissur	KERALA	Talappilly	\N	\N	679531
3674	Pattiparambu B.O		Thrissur	KERALA	Thalapilly	\N	\N	680588
3675	Pazhayannur S.O		Thrissur	KERALA	Talappilly	\N	\N	680587
3676	Peechi S.O		Thrissur	KERALA	Thrissur	\N	\N	680653
3677	Perakam B.O		Thrissur	KERALA	NA	\N	\N	680506
3678	Perinchery B.O		Thrissur	KERALA	NA	\N	\N	680306
3679	Peruvallur B.O		Thrissur	KERALA	Chavakkad	\N	\N	680508
3680	Punnayurkulam S.O		Thrissur	KERALA	Chavakkad	\N	\N	679561
3681	Talikulam S.O		Thrissur	KERALA	Chavakkad	\N	\N	680569
3682	Thayyur B.O		Thrissur	KERALA	Talappilly	\N	\N	680584
3683	Thekkumkara B.O		Thrissur	KERALA	Talappilly	\N	\N	680589
3684	Thrissur City S.O		Thrissur	KERALA	Thrissur	\N	\N	680020
3685	Vatanappally S.O		Thrissur	KERALA	Chavakkad	\N	\N	680614
3686	Vellattanjur B.O		Thrissur	KERALA	Talappilly	\N	\N	680601
3687	Vennur B.O		Thrissur	KERALA	Thalapilly	\N	\N	680587
3688	Wadakanchery-TC H.O		Thrissur	KERALA	Thalapilly	\N	\N	680582
3689	Aranattukara S.O		Thrissur	KERALA	NA	\N	\N	680618
3690	Ayyappankavu B.O		Thrissur	KERALA	Thrissur	\N	\N	680751
3691	Brahmakulam B.O		Thrissur	KERALA	NA	\N	\N	680104
3692	Chelakkara S.O		Thrissur	KERALA	Thalapilly	\N	\N	680586
3693	Chemmannur B.O		Thrissur	KERALA	NA	\N	\N	680517
3694	Desamangalam S.O		Thrissur	KERALA	Thalapilly	\N	\N	679532
3695	Enkakad S.O		Thrissur	KERALA	Thalapilly	\N	\N	680589
3696	Guruvayur Temple S.O		Thrissur	KERALA	NA	\N	\N	680101
3697	Kaiparamba S.O		Thrissur	KERALA	Thrissur	\N	\N	680546
3698	Kallepadam B.O		Thrissur	KERALA	Talappilly	\N	\N	680587
3699	Kanjani S.O		Thrissur	KERALA	Thrissur	\N	\N	680612
3700	Kannara B.O		Thrissur	KERALA	Thrissur	\N	\N	680652
3701	Karumathra B.O		Thrissur	KERALA	Thalapilly	\N	\N	680589
3702	Kiralur B.O		Thrissur	KERALA	Talappilly	\N	\N	680601
3703	Kumaranellur TC S.O		Thrissur	KERALA	Talappilly	\N	\N	680590
3704	Kumarappanal B.O		Thrissur	KERALA	Talappilly	\N	\N	680585
3705	Kunnamkulam H.O		Thrissur	KERALA	NA	\N	\N	680503
3706	Kurumala B.O		Thrissur	KERALA	Talappilly	\N	\N	680586
3707	Kuttanchery B.O		Thrissur	KERALA	Talappilly	\N	\N	680584
3708	Kuttanellur B.O		Thrissur	KERALA	NA	\N	\N	680014
3709	Maruthayur B.O		Thrissur	KERALA	NA	\N	\N	680507
3710	Mullurkkara S.O		Thrissur	KERALA	Thalapilly	\N	\N	680583
3711	Ollukkara S.O		Thrissur	KERALA	Thrissur	\N	\N	680655
3712	Padoor S.O		Thrissur	KERALA	Chavakkad	\N	\N	680524
3713	Pallur B.O		Thrissur	KERALA	Talappilly	\N	\N	679532
3714	Pampady East B.O		Thrissur	KERALA	Talappilly	\N	\N	680588
3715	Porkolangad B.O		Thrissur	KERALA	Talappilly	\N	\N	680517
3716	Puduruthy B.O		Thrissur	KERALA	Talappilly	\N	\N	680623
3717	Pullazhi S.O		Thrissur	KERALA	NA	\N	\N	680012
3718	Pullu B.O		Thrissur	KERALA	Thrissur	\N	\N	680641
3719	Puthenpeedika S.O		Thrissur	KERALA	Thrissur	\N	\N	680642
3720	Ramavarmapuram S.O		Thrissur	KERALA	Thrissur	\N	\N	680631
3721	Tali B.O		Thrissur	KERALA	Talappilly	\N	\N	680585
3722	Thalassery B.O		Thrissur	KERALA	Talappilly	\N	\N	679532
3723	Thangalur B.O		Thrissur	KERALA	Thrissur	\N	\N	680596
3724	Thichur B.O		Thrissur	KERALA	Talappilly	\N	\N	680584
3725	Thiruvenkitam B.O		Thrissur	KERALA	NA	\N	\N	680101
3726	Tiruvatra S.O		Thrissur	KERALA	NA	\N	\N	680516
3727	Trithallur S.O		Thrissur	KERALA	Chavakkad	\N	\N	680619
3728	Anthikad S.O		Thrissur	KERALA	Thrissur	\N	\N	680641
3729	Attur B.O		Thrissur	KERALA	Talappilly	\N	\N	680583
3730	Ayyanthole North B.O		Thrissur	KERALA	Thrissur	\N	\N	680003
3731	Blangad B.O		Thrissur	KERALA	Chavakkad	\N	\N	680506
3732	Chelakode B.O		Thrissur	KERALA	Thalapilly	\N	\N	680587
3733	Cherur S.O		Thrissur	KERALA	Thrissur	\N	\N	680008
3734	Chiramanangad B.O		Thrissur	KERALA	Talappilly	\N	\N	680604
3735	Elthuruth S.O		Thrissur	KERALA	NA	\N	\N	680611
3736	Eyyal B.O		Thrissur	KERALA	Talappilly	\N	\N	680501
3737	Karikkad S.O		Thrissur	KERALA	Talappilly	\N	\N	680519
3738	Kolazhi RM B.O		Thrissur	KERALA	NA	\N	\N	680010
3739	Kootala-Thrissur B.O		Thrissur	KERALA	Thrissur	\N	\N	680652
3740	Kundaliyur S.O		Thrissur	KERALA	Chavakkad	\N	\N	680616
3741	Kundukad B.O		Thrissur	KERALA	Thrissur	\N	\N	680028
3742	Kurkancheri S.O		Thrissur	KERALA	NA	\N	\N	680007
3743	Madu B.O		Thrissur	KERALA	Chavakkad	\N	\N	680512
3744	Mannalamkunnu B.O		Thrissur	KERALA	Chavakkad	\N	\N	680518
3745	Marathakkara B.O		Thrissur	KERALA	NA	\N	\N	680306
3746	Mayannur S.O		Thrissur	KERALA	Thalapilly	\N	\N	679105
3747	Nambazhikad B.O		Thrissur	KERALA	Talappilly	\N	\N	680602
3748	Nehrunagar B.O		Thrissur	KERALA	NA	\N	\N	680006
3749	Painkulam B.O		Thrissur	KERALA	Talappilly	\N	\N	679531
3750	Paluvai S.O		Thrissur	KERALA	NA	\N	\N	680522
3751	Pampady West B.O		Thrissur	KERALA	Talappilly	\N	\N	680588
3752	Pathiyarkulangara B.O		Thrissur	KERALA	Chavakkad	\N	\N	680552
3753	Peringavu B.O		Thrissur	KERALA	Thrissur	\N	\N	680008
3754	Pulakkad B.O		Thrissur	KERALA	Thalapilly	\N	\N	680585
3755	Punkunnu S.O		Thrissur	KERALA	Thrissur	\N	\N	680002
3756	Thampankadavu B.O		Thrissur	KERALA	Chavakkad	\N	\N	680569
3757	Vayilathur B.O		Thrissur	KERALA	Chavakkad	\N	\N	679563
3758	Viyyur S.O		Thrissur	KERALA	Thrissur	\N	\N	680010
3759	Alur Mattom B.O		Thrissur	KERALA	Talappilly	\N	\N	680602
3760	Andathode S.O		Thrissur	KERALA	Chavakkad	\N	\N	679564
3761	Anjur-kunnamkulam B.O		Thrissur	KERALA	Thrissur	\N	\N	680523
3762	Avanisseri B.O		Thrissur	KERALA	NA	\N	\N	680306
3763	Chiyyaram S.O		Thrissur	KERALA	NA	\N	\N	680026
3764	Edakkaliyur S.O		Thrissur	KERALA	Chavakkad	\N	\N	680515
3765	Guruvayur S.O		Thrissur	KERALA	NA	\N	\N	680101
3766	Kainoor B.O		Thrissur	KERALA	Thrissur	\N	\N	680014
3767	Kanjirakode B.O		Thrissur	KERALA	Talappilly	\N	\N	680590
3768	Kannoth B.O		Thrissur	KERALA	Chavakkad	\N	\N	680510
3769	Korattikkara B.O		Thrissur	KERALA	Talappilly	\N	\N	680543
3770	Kottappuram Wri B.O		Thrissur	KERALA	NA	\N	\N	680584
3771	Kundannur B.O		Thrissur	KERALA	NA	\N	\N	680590
3772	Kuruchikkara S.O		Thrissur	KERALA	Thrissur	\N	\N	680028
3773	Kuthampilly B.O		Thrissur	KERALA	Thalapilly	\N	\N	680594
3774	Manalur S.O		Thrissur	KERALA	Thrissur	\N	\N	680617
3775	Marottichal B.O		Thrissur	KERALA	Thrissur	\N	\N	680014
3776	Paralam B.O		Thrissur	KERALA	Thrissur	\N	\N	680563
3777	Pazhanji S.O		Thrissur	KERALA	Thalapilly	\N	\N	680542
3778	Perumthuruthy B.O		Thrissur	KERALA	Talappilly	\N	\N	680542
3779	Porkulam B.O		Thrissur	KERALA	Talappilly	\N	\N	680542
3780	Puranattukara S.O		Thrissur	KERALA	NA	\N	\N	680551
3781	Puthanpalli S.O		Thrissur	KERALA	NA	\N	\N	680103
3782	Thamarayur B.O		Thrissur	KERALA	NA	\N	\N	680505
3783	Thiruvambady TSR S.O		Thrissur	KERALA	Thrissur	\N	\N	680022
3784	Thozhiyur S.O		Thrissur	KERALA	Chavakkad	\N	\N	680520
3785	Thrissur East S.O		Thrissur	KERALA	Thrissur	\N	\N	680005
3786	Thrissur Engg College S.O		Thrissur	KERALA	Thrissur	\N	\N	680009
3787	Vadookkara B.O		Thrissur	KERALA	NA	\N	\N	680007
3788	Vaniampara B.O		Thrissur	KERALA	Thrissur	\N	\N	680652
3789	Velur Thrissur S.O		Thrissur	KERALA	Thalapilly	\N	\N	680601
3790	Venganellur B.O		Thrissur	KERALA	Talappilly	\N	\N	680586
3791	Wadakkancheri-Thrissur RS S.O		Thrissur	KERALA	Talappilly	\N	\N	680623
3792	Akkikavu B.O		Thrissur	KERALA	Talappilly	\N	\N	680519
3793	Ammadam S.O		Thrissur	KERALA	Thrissur	\N	\N	680563
3794	Chakkumkandam B.O		Thrissur	KERALA	NA	\N	\N	680522
3795	Chittanda B.O		Thrissur	KERALA	NA	\N	\N	680585
3796	Chittattukara S.O		Thrissur	KERALA	Chavakkad	\N	\N	680511
3797	Chovvur B.O		Thrissur	KERALA	NA	\N	\N	680027
3798	Chuvannamannu B.O		Thrissur	KERALA	Thrissur	\N	\N	680652
3799	Edakkara-Thrissur B.O		Thrissur	KERALA	Chavakkad	\N	\N	680518
3800	Enamakkal B.O		Thrissur	KERALA	Chavakkad	\N	\N	680510
3801	Kanippayur S.O		Thrissur	KERALA	Thalapilly	\N	\N	680517
3802	Killimangalam S.O		Thrissur	KERALA	Thalapilly	\N	\N	680591
3803	Kodannur B.O		Thrissur	KERALA	Thrissur	\N	\N	680563
3804	Kondazhi S.O		Thrissur	KERALA	Thalapilly	\N	\N	679106
3805	Madakkathara B.O		Thrissur	KERALA	Thrissur	\N	\N	680651
3806	Mundathicode B.O		Thrissur	KERALA	Thalapilly	\N	\N	680601
3807	Nemmini B.O		Thrissur	KERALA	NA	\N	\N	680104
3808	Ollur North B.O		Thrissur	KERALA	NA	\N	\N	680306
3809	Padiyam B.O		Thrissur	KERALA	NA	\N	\N	680641
3810	Parlikkad B.O		Thrissur	KERALA	Talappilly	\N	\N	680623
3811	Peringandur B.O		Thrissur	KERALA	Thrissur	\N	\N	680581
3812	Perumpilavu B.O		Thrissur	KERALA	Thalapilly	\N	\N	680519
3813	Punnayur B.O		Thrissur	KERALA	Chavakkad	\N	\N	679562
3814	Puthur-Thrissur S.O		Thrissur	KERALA	NA	\N	\N	680014
3815	Puvathur S.O		Thrissur	KERALA	Chavakkad	\N	\N	680508
3816	South Kondazhi B.O		Thrissur	KERALA	Talappilly	\N	\N	679106
3817	Thalakkottukara B.O		Thrissur	KERALA	Talappilly	\N	\N	680501
3818	Thrissur Medical College S.O		Thrissur	KERALA	Thrissur	\N	\N	680596
3819	Thrissur R S S.O		Thrissur	KERALA	Thrissur	\N	\N	680021
3820	Tirur B.O		Thrissur	KERALA	NA	\N	\N	680581
3821	Trithallur West B.O		Thrissur	KERALA	Chavakkad	\N	\N	680619
3822	Vadakkethara B.O		Thrissur	KERALA	Thalapilly	\N	\N	680587
3823	Vaka B.O		Thrissur	KERALA	Thalapilly	\N	\N	680602
3824	Vellarakad B.O		Thrissur	KERALA	Talappilly	\N	\N	680584
3825	Venkitangu S.O		Thrissur	KERALA	Chavakkad	\N	\N	680510
3826	Anjur Mundur B.O		Thrissur	KERALA	Thrissur	\N	\N	680541
3827	Annakara B.O		Thrissur	KERALA	Chavakkad	\N	\N	680508
3828	Athani Thrissur B.O		Thrissur	KERALA	Thrissur	\N	\N	680581
3829	Chammannur B.O		Thrissur	KERALA	Chavakkad	\N	\N	679561
3830	Chavakkad S.O		Thrissur	KERALA	Chavakkad	\N	\N	680506
3831	Chemmanthatta B.O		Thrissur	KERALA	Talappilly	\N	\N	680501
3832	Chiranellur B.O		Thrissur	KERALA	Thalapilly	\N	\N	680501
3833	Chittilapilly B.O		Thrissur	KERALA	Thrissur	\N	\N	680551
3834	Chowannur B.O		Thrissur	KERALA	Thalapilly	\N	\N	680517
3835	Edakkalathur B.O		Thrissur	KERALA	Thrissur	\N	\N	680552
3836	Eravimangalam B.O		Thrissur	KERALA	NA	\N	\N	680751
3837	Eravu B.O		Thrissur	KERALA	Thrissur	\N	\N	680620
3838	Kallur-Vadakkekkad B.O		Thrissur	KERALA	Chavakkad	\N	\N	679562
3839	Kanimangalam S.O		Thrissur	KERALA	NA	\N	\N	680027
3840	Kattakampal S.O		Thrissur	KERALA	Thalapilly	\N	\N	680544
3841	Kurumal B.O		Thrissur	KERALA	Talappilly	\N	\N	680601
3842	Mannuthy S.O		Thrissur	KERALA	NA	\N	\N	680651
3843	Mundur-TC S.O		Thrissur	KERALA	Thrissur	\N	\N	680541
3844	Nedupuzha B.O		Thrissur	KERALA	NA	\N	\N	680007
3845	Palissery B.O		Thrissur	KERALA	NA	\N	\N	680027
3846	Pangarappally B.O		Thrissur	KERALA	Talappilly	\N	\N	680586
3847	Poomala B.O		Thrissur	KERALA	Thrissur	\N	\N	680581
3848	Poothole S.O		Thrissur	KERALA	NA	\N	\N	680004
3849	Puzhakkal S.O		Thrissur	KERALA	Thrissur	\N	\N	680553
3850	Thalore B.O		Thrissur	KERALA	Thrissur	\N	\N	680306
3851	Thozhupadam B.O		Thrissur	KERALA	Talappilly	\N	\N	680586
3852	Toyakkavu S.O		Thrissur	KERALA	Chavakkad	\N	\N	680513
3853	Varavur S.O		Thrissur	KERALA	Thalapilly	\N	\N	680585
3854	Vatanapally Beach B.O		Thrissur	KERALA	Chavakkad	\N	\N	680614
3855	Vattekkad B.O		Thrissur	KERALA	Chavakkad	\N	\N	680512
3856	Veluthur B.O		Thrissur	KERALA	Thrissur	\N	\N	680012
3857	Vettukad B.O		Thrissur	KERALA	Thrissur	\N	\N	680014
3858	Arangottukara B.O		Thrissur	KERALA	Thalapilly	\N	\N	679532
3859	Arimpur S.O		Thrissur	KERALA	Thrissur	\N	\N	680620
3860	Ariyannur S.O		Thrissur	KERALA	Thalapilly	\N	\N	680102
3861	Asarikkad B.O		Thrissur	KERALA	Thrissur	\N	\N	680751
3862	Ayyanthole S.O		Thrissur	KERALA	Thrissur	\N	\N	680003
3863	Chennaipara B.O		Thrissur	KERALA	Thrissur	\N	\N	680653
3864	Cheruthuruthy S.O		Thrissur	KERALA	Talappilly	\N	\N	679531
3865	Choondal S.O		Thrissur	KERALA	Thalapilly	\N	\N	680502
3866	Elanad B.O		Thrissur	KERALA	Thalapilly	\N	\N	680586
3867	Engandiyur S.O		Thrissur	KERALA	Chavakkad	\N	\N	680615
3868	Eranellur B.O		Thrissur	KERALA	Talappilly	\N	\N	680501
3869	Erumapetty S.O		Thrissur	KERALA	Thalapilly	\N	\N	680584
3870	Irunilamcode B.O		Thrissur	KERALA	Talappilly	\N	\N	680583
3871	Kakkassery B.O		Thrissur	KERALA	Chavakkad	\N	\N	680511
3872	Kaliyarode B.O		Thrissur	KERALA	Talappilly	\N	\N	680586
3873	Kandanassery B.O		Thrissur	KERALA	Talappilly	\N	\N	680102
3874	Kaniyarkod S.O		Thrissur	KERALA	Talappilly	\N	\N	680594
3875	Katungode B.O		Thrissur	KERALA	Thalapilly	\N	\N	680584
3876	Kerala Agri-university S.O		Thrissur	KERALA	Thrissur	\N	\N	680656
3877	Konikara B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680306
3878	Koonamoochi S.O		Thrissur	KERALA	Talappilly	\N	\N	680504
3879	Kuttur S.O (Thrissur)		Thrissur	KERALA	Thrissur	\N	\N	680013
3880	Malavattom B.O		Thrissur	KERALA	Talappilly	\N	\N	680588
3881	Manalithara B.O		Thrissur	KERALA	Talappilly	\N	\N	680589
3882	Maruthancode S.O		Thrissur	KERALA	Thalapilly	\N	\N	680604
3883	Mattom S.O		Thrissur	KERALA	Thalapilly	\N	\N	680602
3884	Nettissery B.O		Thrissur	KERALA	NA	\N	\N	680651
3885	Nhamanghat S.O		Thrissur	KERALA	Chavakkad	\N	\N	679563
3886	Ollur S.O		Thrissur	KERALA	NA	\N	\N	680306
3887	Ollur Thaikkattussery B.O		Thrissur	KERALA	NA	\N	\N	680306
3888	Pallam Kottambathur B.O		Thrissur	KERALA	Talappilly	\N	\N	679532
3889	Panangattukara B.O		Thrissur	KERALA	NA	\N	\N	680623
3890	Parappur S.O		Thrissur	KERALA	Thrissur	\N	\N	680552
3891	Pavaratty S.O		Thrissur	KERALA	NA	\N	\N	680507
3892	Pengamuck B.O		Thrissur	KERALA	Talappilly	\N	\N	680544
3893	Ponnore B.O		Thrissur	KERALA	NA	\N	\N	680552
3894	Poovanchira B.O		Thrissur	KERALA	Thrissur	\N	\N	680652
3895	Thaikkad S.O		Thrissur	KERALA	NA	\N	\N	680104
3896	Thippilissery B.O		Thrissur	KERALA	Talappilly	\N	\N	680519
3897	Thonnurkkara B.O		Thrissur	KERALA	Talappilly	\N	\N	680586
3898	Thrissur H.O		Thrissur	KERALA	Thrissur	\N	\N	680001
3899	Tolur-parappur B.O		Thrissur	KERALA	Thrissur	\N	\N	680552
3900	Vazhani B.O		Thrissur	KERALA	Thalapilly	\N	\N	680589
3901	Vemmanad B.O		Thrissur	KERALA	NA	\N	\N	680507
3902	Amalanagar S.O		Thrissur	KERALA	Thrissur	\N	\N	680555
3903	Arthat S.O		Thrissur	KERALA	NA	\N	\N	680521
3904	Chittanjur B.O		Thrissur	KERALA	Thrissur	\N	\N	680523
3905	Edassery B.O		Thrissur	KERALA	Chavakkad	\N	\N	680569
3906	Elavally South B.O		Thrissur	KERALA	Chavakkad	\N	\N	680511
3907	Iringapuram B.O		Thrissur	KERALA	NA	\N	\N	680103
3908	Kadappuram S.O		Thrissur	KERALA	Chavakkad	\N	\N	680514
3909	Kandassankadavu S.O		Thrissur	KERALA	Thrissur	\N	\N	680613
3910	Kattilapoovam B.O		Thrissur	KERALA	Thrissur	\N	\N	680028
3911	Kizhur S.O		Thrissur	KERALA	NA	\N	\N	680523
3912	Kochannur B.O		Thrissur	KERALA	Chavakkad	\N	\N	679562
3913	Kottappadi S.O		Thrissur	KERALA	NA	\N	\N	680505
3914	Kunnamkulam City B.O		Thrissur	KERALA	NA	\N	\N	680523
3915	Kuranniyur B.O		Thrissur	KERALA	Chavakkad	\N	\N	680506
3916	Malesamangalam B.O		Thrissur	KERALA	Talappilly	\N	\N	680588
3917	Manakkodi B.O		Thrissur	KERALA	Thrissur	\N	\N	680012
3918	Mannamangalam B.O		Thrissur	KERALA	Thrissur	\N	\N	680014
3919	Minalur B.O		Thrissur	KERALA	Talappilly	\N	\N	680581
3920	Mulayam B.O		Thrissur	KERALA	Thrissur	\N	\N	680751
3921	Mullassery S.O		Thrissur	KERALA	Chavakkad	\N	\N	680509
3922	Mundathicode West B.O		Thrissur	KERALA	Talappilly	\N	\N	680623
3923	Pattikkad TC S.O		Thrissur	KERALA	Thrissur	\N	\N	680652
3924	Peramangalam S.O		Thrissur	KERALA	Thrissur	\N	\N	680545
3925	Ponnukkara B.O		Thrissur	KERALA	Thrissur	\N	\N	680306
3926	Pookode B.O		Thrissur	KERALA	NA	\N	\N	680505
3927	Pottore B.O		Thrissur	KERALA	NA	\N	\N	680581
3928	Pulakode B.O		Thrissur	KERALA	Talappilly	\N	\N	680586
3929	Thirunellur B.O		Thrissur	KERALA	Chavakkad	\N	\N	680508
3930	Thiruvilwamala S.O		Thrissur	KERALA	Talappilly	\N	\N	680588
3931	Thrissur Central S.O		Thrissur	KERALA	Thrissur	\N	\N	680001
3932	Trikkur B.O		Thrissur	KERALA	Mukundapuram	\N	\N	680306
3933	Vadakkekad S.O		Thrissur	KERALA	Chavakkad	\N	\N	679562
3934	Vellanikkara S.O		Thrissur	KERALA	Thrissur	\N	\N	680654
3935	Velur Bazar B.O		Thrissur	KERALA	Talappilly	\N	\N	680601
3936	Vettikkattiri R.S. B.O		Thrissur	KERALA	Thalapilly	\N	\N	679531
3937	Vyasagiri B.O		Thrissur	KERALA	Talappilly	\N	\N	680623
3938	West Fort B.O		Thrissur	KERALA	NA	\N	\N	680004
3939	Adur( Kla) H.O		Pathanamthitta	KERALA	Adur	\N	\N	691523
3940	Ambalathumbhagom B.O		Kollam	KERALA	Kunnathur	\N	\N	690520
3941	Angadi S.O (Pathanamthitta)		Pathanamthitta	KERALA	Ranny	\N	\N	689674
3942	Attachakkal B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689692
3943	Ayur S.O		Kollam	KERALA	Pathanapuram	\N	\N	691533
3944	Chandanapally B.O		Pathanamthitta	KERALA	Adur	\N	\N	689648
3945	Chellakkad S.O		Pathanamthitta	KERALA	Ranni	\N	\N	689677
3946	Chenneerkara B.O		Pathanamthitta	KERALA	Kozhencherry	\N	\N	689503
3947	Edakkad B.O		Kollam	KERALA	Kunnathur	\N	\N	691552
3948	Elanthur S.O		Pathanamthitta	KERALA	Kozhencherry	\N	\N	689643
3949	Kaipuzha North B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689503
3950	Karavaloor B.O		Kollam	KERALA	Pathanapuram	\N	\N	691333
3951	Kizhakkupuram B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689653
3952	Kochukoikkal B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689667
3953	Kodumon S.O		Pathanamthitta	KERALA	Adur	\N	\N	691555
3954	Koonamkara B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689711
3955	Kunnathur East S.O		Kollam	KERALA	Kunnathur	\N	\N	690540
3956	Makkapuzha S.O		Pathanamthitta	KERALA	Ranni	\N	\N	689676
3957	Mammoodu B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689513
3958	Mancode B.O		Pathanamthitta	KERALA	Adoor	\N	\N	689694
3959	Manneera B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689699
3960	Mylapra S.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689671
3961	Naranganam North B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689642
3962	Poruvazhy S.O		Kollam	KERALA	Kunnathur	\N	\N	690520
3963	Ranny Perinad S.O		Pathanamthitta	KERALA	Ranny	\N	\N	689711
3964	Thannithode S.O		Pathanamthitta	KERALA	Kozhencherry	\N	\N	689699
3965	Thattayil S.O		Pathanamthitta	KERALA	Adoor	\N	\N	691525
3966	Theppupara B.O		Pathanamthitta	KERALA	Adoor	\N	\N	691554
3967	Vadakkupuram B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689653
3968	Vilakkupara B.O		Kollam	KERALA	Pathanapuram	\N	\N	691312
3969	Alayamon B.O		Kollam	KERALA	Pathanapuram	\N	\N	691306
3970	Anayadi B.O		Kollam	KERALA	Kunnathur	\N	\N	690561
3971	Aryavon B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689691
3972	Athirumkal B.O		Pathanamthitta	KERALA	Adoor	\N	\N	689693
3973	Chathakulam B.O		Kollam	KERALA	Kunnathur	\N	\N	690520
3974	Edakulam B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689672
3975	Edapalayam B.O		Kollam	KERALA	Pathanapuram	\N	\N	691309
3976	Ellimullumplackal B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689692
3977	Kadammanitta S.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689649
3978	Kallada Irrigation Project B.O		Kollam	KERALA	Pathanapuram	\N	\N	691308
3979	Karimthottuva B.O		Kollam	KERALA	Kunnathur	\N	\N	690540
3980	Kozhencherry East B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689641
3981	Kumpalampoika S.O		Pathanamthitta	KERALA	Ranni	\N	\N	689661
3982	Kundayam B.O		Kollam	KERALA	Pathanapuram	\N	\N	689695
3983	Maniyar B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689662
3984	Mannady S.O (Pathanamthitta)		Pathanamthitta	KERALA	Adoor	\N	\N	691530
3985	Mannarakulanji B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689678
3986	Melood B.O		Pathanamthitta	KERALA	Adoor	\N	\N	691554
3987	Mundukottackal B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689649
3988	Naranganam S.O		Pathanamthitta	KERALA	Kozhencherry	\N	\N	689642
3989	Nedumoncavu B.O		Pathanamthitta	KERALA	Adoor	\N	\N	689693
3990	Nellikkamon B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689674
3991	Oonnakavu B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689674
3992	Oonnukal B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689647
3993	Paranthal B.O		Pathanamthitta	KERALA	Adoor	\N	\N	689501
3994	Payyanamon S.O		Pathanamthitta	KERALA	Kozhencherry	\N	\N	689692
3995	Pazhakulam B.O		Pathanamthitta	KERALA	Adur	\N	\N	691554
3996	Puthumala B.O		Pathanamthitta	KERALA	Adoor	\N	\N	691554
3997	Seethathode S.O		Pathanamthitta	KERALA	Ranni	\N	\N	689667
3998	Thengamom B.O		Pathanamthitta	KERALA	Adoor	\N	\N	690522
3999	Thenmala S.O		Kollam	KERALA	Pathanapuram	\N	\N	691308
4000	Thumpamon Thazham B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689625
4001	Vayala Parakode B.O		Pathanamthitta	KERALA	Adoor	\N	\N	691554
4002	Vayala-anchal B.O		Kollam	KERALA	Kottarakkara	\N	\N	691306
4003	Vettithitta B.O		Kollam	KERALA	Pathanapuram	\N	\N	689696
4004	Ambalathinnirappu B.O		Kollam	KERALA	Pathanapuram	\N	\N	691508
4005	Anandapally B.O		Pathanamthitta	KERALA	Adoor	\N	\N	691525
4006	Angadical North B.O		Pathanamthitta	KERALA	Adoor	\N	\N	689648
4007	Areeplachy B.O		Kollam	KERALA	Pathanapuram	\N	\N	691333
4008	Aruvappulam B.O		Pathanamthitta	KERALA	Kozhencherry	\N	\N	689691
4009	Aryankavu B.O		Kollam	KERALA	Pathanapuram	\N	\N	691309
4010	Channapettah S.O		Kollam	KERALA	Pathanapuram	\N	\N	691311
4011	Cherukulanji B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689673
4012	Chozhiakode B.O		Kollam	KERALA	Pathanapuram	\N	\N	691310
4013	Kakkudumon B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689711
4014	Karavoor B.O		Kollam	KERALA	Pathanapuram	\N	\N	689696
4015	Karikayam B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689663
4016	Keekozhur B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689672
4017	Keerukuzhy B.O		Pathanamthitta	KERALA	Adoor	\N	\N	689502
4018	Kozhencherry  Thekkemala S.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689654
4019	Kulathumon B.O		Pathanamthitta	KERALA	Adoor	\N	\N	689693
4020	Kummannoor B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689691
4021	Manjakala B.O		Kollam	KERALA	Pathanapuram	\N	\N	691508
4022	Mannam Nagar B.O		Pathanamthitta	KERALA	Adoor	\N	\N	689501
4023	Mannam Sugar Mills B.O		Pathanamthitta	KERALA	Adoor	\N	\N	689501
4024	Marthandankara B.O		Kollam	KERALA	Pathanapuram	\N	\N	691312
4025	Melila B.O		Kollam	KERALA	Kottarakkara	\N	\N	691508
4026	Muthupezhumkal B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689698
4027	Narikal B.O		Kollam	KERALA	Pathanapuram	\N	\N	691322
4028	Neeliplavu B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689663
4029	Nellipally B.O		Kollam	KERALA	Pathanapuram	\N	\N	691331
4030	Omallur-kla S.O		Pathanamthitta	KERALA	Kozhencherry	\N	\N	689647
4031	Pampa Triveni B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689662
4032	Pampini B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689663
4033	Pandalam Medical Mission S.O		Pathanamthitta	KERALA	Adoor	\N	\N	689501
4034	Pathanapuram S.O		Kollam	KERALA	Pathanapuram	\N	\N	689695
4035	Peringanad B.O		Pathanamthitta	KERALA	Adur	\N	\N	691551
4036	Pezhumpara B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689662
4037	Poonkulanji B.O		Kollam	KERALA	Pathanapuram	\N	\N	689695
4038	Pulloopram B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689674
4039	Punnala B.O		Kollam	KERALA	Pathanapuram	\N	\N	689696
4040	Thalavoor B.O		Kollam	KERALA	Pathanapuram	\N	\N	691508
4041	Thazhathuvadakku B.O		Kollam	KERALA	Pathanapuram	\N	\N	691526
4042	Vakayar S.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689698
4043	Venga B.O		Kollam	KERALA	Kunnathur	\N	\N	690521
4044	Adumpumkulam B.O		Pathanamthitta	KERALA	Kozhencherry	\N	\N	689692
4045	Chengalthadom B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689671
4046	Elamannur S.O		Pathanamthitta	KERALA	Adur	\N	\N	691524
4047	Kallely B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689691
4048	Karikulam B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689673
4049	Kidangannur S.O		Pathanamthitta	KERALA	Kozhencherry	\N	\N	689514
4050	Kodumon East B.O		Pathanamthitta	KERALA	Adoor	\N	\N	691555
4051	Kumarankudy B.O		Kollam	KERALA	Pathanapuram	\N	\N	689696
4052	Maloor B.O		Kollam	KERALA	Pathanapuram	\N	\N	689695
4053	Manakala S.O		Pathanamthitta	KERALA	Kunnathur	\N	\N	691551
4054	Manalil B.O		Kollam	KERALA	Pathanapuram	\N	\N	691312
4055	Manchallur Pathanapuram S.O		Kollam	KERALA	Pathanapuram	\N	\N	689695
4056	Mangadu-Elamannur B.O		Pathanamthitta	KERALA	Adur	\N	\N	691524
4057	Moozhiar B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689662
4058	Mudiyoorkonam B.O		Pathanamthitta	KERALA	Adoor	\N	\N	689501
4059	Nediyara B.O		Kollam	KERALA	Pathanapuram	\N	\N	691306
4060	Nedumon S.O		Pathanamthitta	KERALA	Adur	\N	\N	691556
4061	Nellikala B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689643
4062	Njakkunilam B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689656
4063	Oottupara B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689691
4064	Panthaplavu B.O		Kollam	KERALA	Pathanapuram	\N	\N	691522
4065	Punnakkad S.O		Pathanamthitta	KERALA	Kozhencherry	\N	\N	689652
4066	Puthenambalam B.O		Kollam	KERALA	Kunnathur	\N	\N	691553
4067	Ranny Edamon B.O		Pathanamthitta	KERALA	Ranny	\N	\N	689676
4068	Rosemala B.O		Kollam	KERALA	Pathanapuram	\N	\N	691309
4069	Thalachira Eram B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689664
4070	Thevannur B.O		Kollam	KERALA	Kottarakkara	\N	\N	691533
4071	Thingalkarikom B.O		Kollam	KERALA	Pathanapuram	\N	\N	691310
4072	Vallicode Kottayam S.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689656
4073	Vayyattupuzha B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689663
4074	Vazhamuttom B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689647
4075	Vellappara B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689691
4076	Vilanthara Jn B.O		Kollam	KERALA	Kunnathur	\N	\N	690521
4077	Anapettakongal B.O		Kollam	KERALA	Pathanapuram	\N	\N	691307
4078	Anchal S.O		Kollam	KERALA	Pathanapuram	\N	\N	691306
4079	Avaneeswaram RS B.O		Kollam	KERALA	Pathanapuram	\N	\N	691508
4080	Ayiranallur B.O		Kollam	KERALA	Pathanapuram	\N	\N	691307
4081	Chengara B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689664
4082	Cherukole Kozhencherri S.O		Pathanamthitta	KERALA	Kozhencherri	\N	\N	689650
4083	Cheruvakkal B.O		Kollam	KERALA	Kottarakkara	\N	\N	691533
4084	Dally B.O		Kollam	KERALA	Pathanapuram	\N	\N	691310
4085	Edamulackal B.O		Kollam	KERALA	Pathanapuram	\N	\N	691306
4086	Elamadu B.O		Kollam	KERALA	Kottarakkara	\N	\N	691533
4087	Elanthur East B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689643
4088	Elappupara B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689656
4089	Elavanthitta S.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689625
4090	Elicode B.O		Kollam	KERALA	Pathanapuram	\N	\N	691322
4091	Enathu S.O		Pathanamthitta	KERALA	Adur	\N	\N	691526
4092	Eroor S.O (Kollam)		Kollam	KERALA	Pathanapuram	\N	\N	691312
4093	Kaithaparambu B.O		Pathanamthitta	KERALA	Adoor	\N	\N	691526
4094	Kakkakunnu B.O		Kollam	KERALA	Kunnathur	\N	\N	690522
4095	Karamvely B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689643
4096	Kariyara B.O		Kollam	KERALA	Pathanapuram	\N	\N	691332
4097	Kottamonpara B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689667
4098	Kozhencherry S.O		Pathanamthitta	KERALA	Kozhencherry	\N	\N	689641
4099	Kudamurutty B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689711
4100	Kulathupuzha S.O		Kollam	KERALA	Pathanapuram	\N	\N	691310
4101	Madamon B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689711
4102	Mandiram Jn B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689672
4103	Maniyaru-punalur B.O		Kollam	KERALA	Pathanapuram	\N	\N	691333
4104	Mathra B.O		Kollam	KERALA	Pathanapuram	\N	\N	691333
4105	Musaliar College B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689653
4106	Nellimukal B.O		Pathanamthitta	KERALA	Adoor	\N	\N	691551
4107	Parakadavu B.O		Kollam	KERALA	Kunnathur	\N	\N	690561
4108	Parakoottam B.O		Pathanamthitta	KERALA	Adoor	\N	\N	691551
4109	Perinjottackal B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689692
4110	Sasthamcottah S.O		Kollam	KERALA	Kunnathur	\N	\N	690521
4111	Thuruthikara B.O		Kollam	KERALA	Kunnathur	\N	\N	690540
4112	Ullannur B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689503
4113	Uthimoodu B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689672
4114	Vallicode B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689648
4115	Vayalathala B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689672
4116	Vayyanam B.O		Kollam	KERALA	Kottarakkara	\N	\N	691533
4117	Vazhamuttom East B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689646
4118	Venchempu B.O		Kollam	KERALA	Pathanapuram	\N	\N	691333
4119	Vengoor B.O		Kollam	KERALA	Kottarakkara	\N	\N	691533
4120	Venture B.O		Kollam	KERALA	Pathanapuram	\N	\N	691309
4121	Vettur Kumbazha B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689653
4122	Vilakkuvattom B.O		Kollam	KERALA	Pathanapuram	\N	\N	691331
4123	Villumala B.O		Kollam	KERALA	Pathanapuram	\N	\N	691310
4124	Achencoil B.O		Kollam	KERALA	Pathanapuram	\N	\N	689696
4125	Ambanad B.O		Kollam	KERALA	Pathanapuram	\N	\N	691309
4126	Anakulam B.O		Kollam	KERALA	Pathanapuram	\N	\N	691311
4127	Angamoozhy B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689662
4128	Avaneeswaram B.O		Kollam	KERALA	Pathanapuram	\N	\N	691508
4129	Chakkuvarakkal B.O		Kollam	KERALA	Kottarakkara	\N	\N	691508
4130	Chayalode B.O		Pathanamthitta	KERALA	Adoor	\N	\N	691556
4131	Chittar S.O		Pathanamthitta	KERALA	Ranny	\N	\N	689663
4132	Choorakode B.O		Pathanamthitta	KERALA	Adoor	\N	\N	691551
4133	Edamon S.O		Kollam	KERALA	Pathanapuram	\N	\N	691307
4134	Edathitta B.O		Pathanamthitta	KERALA	Adoor	\N	\N	691555
4135	Elikattoor B.O		Kollam	KERALA	Pathanapuram	\N	\N	689696
4136	Gurunathanmannu B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689667
4137	Kadamancode B.O		Kollam	KERALA	Pathanapuram	\N	\N	691312
4138	Kadambanad S.O		Pathanamthitta	KERALA	Adur	\N	\N	691552
4139	Kakkode B.O		Kollam	KERALA	Pathanapuram	\N	\N	691331
4140	Kalanjoor S.O		Pathanamthitta	KERALA	Adoor	\N	\N	689694
4141	Karithotta B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689514
4142	Karukone B.O		Kollam	KERALA	Pathanapuram	\N	\N	691306
4143	Konny S.O		Pathanamthitta	KERALA	Kozhencherry	\N	\N	689691
4144	Koovakkad B.O		Kollam	KERALA	Pathanapuram	\N	\N	691310
4145	Kurampala South B.O		Pathanamthitta	KERALA	Adur	\N	\N	689501
4146	Kuzhikala S.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689644
4147	Lahai B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689662
4148	Makkankunnu S.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689645
4149	Mallasseri S.O		Pathanamthitta	KERALA	Kozhencherry	\N	\N	689646
4150	Mampara B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689711
4151	Mampazhathara B.O		Kollam	KERALA	Pathanapuram	\N	\N	691307
4152	Manjappara B.O		Kollam	KERALA	Kottarakkara	\N	\N	691533
4153	Mannur-anchal B.O		Kollam	KERALA	Kottarakkara	\N	\N	691311
4154	Manthuka B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689503
4155	Mathur B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689647
4156	Melukara B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689641
4157	Mezhuveli S.O		Pathanamthitta	KERALA	Kozhencherry	\N	\N	689507
4158	Muttathukonam B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689625
4159	Muttom Thumpamon B.O		Pathanamthitta	KERALA	Adoor	\N	\N	689502
4160	Nirathupara B.O		Pathanamthitta	KERALA	Adoor	\N	\N	689693
4161	Ottackal B.O		Kollam	KERALA	Pathanapuram	\N	\N	691308
4162	Padam B.O		Pathanamthitta	KERALA	Adoor	\N	\N	689694
4163	Prakkanam B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689643
4164	Puthusserimala B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689672
4165	Samnagar B.O		Kollam	KERALA	Pathanapuram	\N	\N	691310
4166	Shaliacarry Estate B.O		Kollam	KERALA	Pathanapuram	\N	\N	691331
4167	Thadicaud B.O		Kollam	KERALA	Pathanapuram	\N	\N	691306
4168	Thekkuthode B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689699
4169	Thengumcavu B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689646
4170	Tholicode S.O		Kollam	KERALA	Pathanapuram	\N	\N	691333
4171	Thonniamala B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689668
4172	Thumpamon S.O		Pathanamthitta	KERALA	Adur	\N	\N	689502
4173	Urukunnu B.O		Kollam	KERALA	Pathanapuram	\N	\N	691307
4174	Vadakkedathukavu Jn B.O		Pathanamthitta	KERALA	Adoor	\N	\N	691526
4175	Vadamon B.O		Kollam	KERALA	Pathanapuram	\N	\N	691306
4176	Arkannur B.O		Kollam	KERALA	Kottarakkara	\N	\N	691533
4177	Bharatheepuram B.O		Kollam	KERALA	Pathanapuram	\N	\N	691312
4178	Cherukulam B.O		Kollam	KERALA	Kottarakkara	\N	\N	691306
4179	Chethackal B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689677
4180	Churulicode S.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689668
4181	Ettichuvadu S.O		Pathanamthitta	KERALA	Ranni	\N	\N	689675
4182	Ezhiyam Vattathra Mala Mukku B.O		Kollam	KERALA	Pathanapuram	\N	\N	691306
4183	Kadambanad South S.O		Pathanamthitta	KERALA	Adoor	\N	\N	691553
4184	Kaipattur S.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689648
4185	Karali Jn B.O		Kollam	KERALA	Kunnathur	\N	\N	690521
4186	Kattoor Kozhencherry B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689650
4187	Kozhencherry College S.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689641
4188	Kumbazhamuri S.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689653
4189	Kunnicode S.O		Kollam	KERALA	Pathanapuram	\N	\N	691508
4190	Kurumbakara B.O		Pathanamthitta	KERALA	Adoor	\N	\N	689695
4191	Marur B.O		Pathanamthitta	KERALA	Adoor	\N	\N	691524
4192	Mekozhur B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689678
4193	Muthupilakkad B.O		Kollam	KERALA	Kunnathur	\N	\N	690520
4194	Mylapra Town S.O		Pathanamthitta	KERALA	Kozhencherry	\N	\N	689678
4195	Naranganam West B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689642
4196	Nellikkapara B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689691
4197	Ozhukkuparackal B.O		Kollam	KERALA	Pathanapuram	\N	\N	691533
4198	Panangad B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689503
4199	Pandalam S.O (Pathanamthitta)		Pathanamthitta	KERALA	Adur	\N	\N	689501
4200	Pathanamthitta H.O		Pathanamthitta	KERALA	Kozhencherry	\N	\N	689645
4201	Pidavoor B.O		Kollam	KERALA	Pathanapuram	\N	\N	689695
4202	Placherry B.O		Kollam	KERALA	Pathanapuram	\N	\N	691331
4203	Punalur Paper Mills S.O		Kollam	KERALA	Pathanapuram	\N	\N	691332
4204	Ranny-pazhavangadi S.O		Pathanamthitta	KERALA	Ranny	\N	\N	689673
4205	Sooranad S.O		Kollam	KERALA	Kunnathur	\N	\N	690522
4206	Thuvayur South B.O		Pathanamthitta	KERALA	Adoor	\N	\N	691552
4207	Vadasserikara S.O		Pathanamthitta	KERALA	Ranny	\N	\N	689662
4208	Valacode S.O		Kollam	KERALA	Pathanapuram	\N	\N	691331
4209	Adichipuzha B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689711
4210	Angadical South B.O		Pathanamthitta	KERALA	Adoor	\N	\N	691555
4211	Anthiyalankavu B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689649
4212	Ayilara B.O		Kollam	KERALA	Pathanapuram	\N	\N	691312
4213	Chelikuzhy B.O		Pathanamthitta	KERALA	Pathanapuram	\N	\N	691556
4214	Chembanaruvi B.O		Kollam	KERALA	Pathanapuram	\N	\N	689696
4215	Edapariyaram B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689643
4216	Elakollur B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689691
4217	Elampal S.O		Kollam	KERALA	Pathanapuram	\N	\N	691322
4218	Elanthur Pariyaram B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689643
4219	Iythala B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689673
4220	Kallely Thottam B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689691
4221	Kalthuruthy S.O		Kollam	KERALA	Pathanapuram	\N	\N	691309
4222	Kamukumcherry B.O		Kollam	KERALA	Pathanapuram	\N	\N	689696
4223	Kokkathode B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689691
4224	Koodal S.O		Pathanamthitta	KERALA	Adur	\N	\N	689693
4225	Kottavattom B.O		Kollam	KERALA	Kottarakkara	\N	\N	691322
4226	Kottukkal B.O		Kollam	KERALA	Kottarakkara	\N	\N	691306
4227	Kulanada S.O		Pathanamthitta	KERALA	Kozhencherry	\N	\N	689503
4228	Kumaramperoor Thekkekkara B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689662
4229	Malayalapuzha Eram S.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689664
4230	Malayalapuzha Thazham S.O		Pathanamthitta	KERALA	Ranny	\N	\N	689666
4231	Maloor College B.O		Kollam	KERALA	Pathanapuram	\N	\N	689695
4232	Manampuzha B.O		Kollam	KERALA	Kunnathur	\N	\N	691553
4233	Murinjakal B.O		Pathanamthitta	KERALA	Adoor	\N	\N	689693
4234	Naranamoozhy B.O		Pathanamthitta	KERALA	Ranny	\N	\N	689711
4235	Nariapuram S.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689513
4236	Pallisserickal B.O		Kollam	KERALA	Kunnathur	\N	\N	690521
4237	Parakara B.O		Pathanamthitta	KERALA	Adoor	\N	\N	691525
4238	Parakode S.O		Pathanamthitta	KERALA	Adoor	\N	\N	691554
4239	Patharam B.O		Kollam	KERALA	Kunnathur	\N	\N	690522
4240	Pathirickal B.O		Kollam	KERALA	Pathanapuram	\N	\N	689695
4241	Pattazhy S.O		Kollam	KERALA	Pathanapuram	\N	\N	691522
4242	Piravanthur S.O		Kollam	KERALA	Pathanapuram	\N	\N	689696
4243	Punalur H.O		Kollam	KERALA	Pathanapuram	\N	\N	691305
4244	Ranny S.O		Pathanamthitta	KERALA	Ranny	\N	\N	689672
4245	Sooranad North S.O		Kollam	KERALA	Kunnathur	\N	\N	690561
4246	Thekketheri B.O		Kollam	KERALA	Pathanapuram	\N	\N	691522
4247	Thombikandam B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689676
4248	Thumpamon North B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689625
4249	Ulanad B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689503
4250	Valiyakavu B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689675
4251	Vilakudy B.O		Kollam	KERALA	Pathanapuram	\N	\N	691508
4252	Alumpeedika B.O		Kollam	KERALA	Karunagappally	\N	\N	690547
4253	Chariparabu B.O		Kollam	KERALA	Kottarakkara	\N	\N	691536
4254	Chirakkara B.O		Kollam	KERALA	Kollam	\N	\N	691578
4255	Inchavila B.O		Kollam	KERALA	Kollam	\N	\N	691601
4256	Kaithacode S.O		Kollam	KERALA	Kottarakkara	\N	\N	691543
4257	Kalayapuram S.O		Kollam	KERALA	Kottarakara	\N	\N	691560
4258	Karikkom B.O		Kollam	KERALA	Kottarakkara	\N	\N	691531
4259	Kollam Cutchery S.O		Kollam	KERALA	Kollam	\N	\N	691013
4260	Kollayil B.O		Kollam	KERALA	Kottarakkara	\N	\N	691541
4261	Kottathala B.O		Kollam	KERALA	Kottarakkara	\N	\N	691507
4262	Kureepuzha B.O		Kollam	KERALA	Kollam	\N	\N	691601
4263	Mailom B.O		Kollam	KERALA	Kottarakkara	\N	\N	691560
4264	Manappally North S.O		Kollam	KERALA	Karunagappally	\N	\N	690574
4265	Mangad S.O		Kollam	KERALA	Kollam	\N	\N	691015
4266	Mathilil B.O		Kollam	KERALA	Kollam	\N	\N	691601
4267	Mukundapuram S.O		Kollam	KERALA	Karunagappally	\N	\N	691585
4268	Nellettil B.O		Kollam	KERALA	Kollam	\N	\N	691302
4269	Pallimon B.O		Kollam	KERALA	Kollam	\N	\N	691576
4270	Panmana B.O		Kollam	KERALA	Karunagapally	\N	\N	691583
4271	Perumannur B.O		Kollam	KERALA	Pathanapuram	\N	\N	691532
4272	Prakkulam B.O		Kollam	KERALA	Kollam	\N	\N	691602
4273	Vellimon S.O		Kollam	KERALA	Kollam	\N	\N	691511
4274	Aduthala B.O		Kollam	KERALA	Kollam	\N	\N	691579
4275	Athinad North S.O		Kollam	KERALA	Karunagappally	\N	\N	690542
4276	Ayirakuzhy B.O		Kollam	KERALA	Kottarakkara	\N	\N	691559
4277	Azheekkalthura B.O		Kollam	KERALA	Karunagappally	\N	\N	690547
4278	Chengamanad Jn S.O		Kollam	KERALA	Kottarakara	\N	\N	691557
4279	Chenkulam B.O		Kollam	KERALA	Kottarakkara	\N	\N	691510
4280	Decent Jn B.O		Kollam	KERALA	Kollam	\N	\N	691577
4281	Kadathur Ward B.O		Kollam	KERALA	Karunagappally	\N	\N	690523
4282	Kaithode B.O		Kollam	KERALA	Kottarakkara	\N	\N	691535
4283	Kalakode B.O		Kollam	KERALA	Kollam	\N	\N	691302
4284	Kanjavely S.O		Kollam	KERALA	Kollam	\N	\N	691602
4285	Karuvelil B.O		Kollam	KERALA	Kottarakkara	\N	\N	691505
4286	Kattilkadavu B.O		Kollam	KERALA	Karunagappally	\N	\N	690542
4287	Kavanad S.O		Kollam	KERALA	Kollam	\N	\N	691003
4288	Kollam Cantonment S.O		Kollam	KERALA	Kollam	\N	\N	691001
4289	Kollam Civil Station S.O		Kollam	KERALA	Kollam	\N	\N	691013
4290	Kulakkadathazham B.O		Kollam	KERALA	Kottarakkara	\N	\N	691521
4291	Kulasekharapuram S.O		Kollam	KERALA	Karunagapally	\N	\N	690544
4292	Kuzhithura B.O		Kollam	KERALA	Karunagappally	\N	\N	690542
4293	Madathilkaranma B.O		Kollam	KERALA	Karunagappally	\N	\N	690526
4294	Maruthadi B.O		Kollam	KERALA	Kollam	\N	\N	691003
4295	Mathira B.O		Kollam	KERALA	Kottarakkara	\N	\N	691536
4296	Meeyannur B.O		Kollam	KERALA	Kollam	\N	\N	691537
4297	Mylakkadu B.O		Kollam	KERALA	Kollam	\N	\N	691571
4298	Nedumoncavu B.O		Kollam	KERALA	Kottarakkara	\N	\N	691509
4299	Nedumpaikulam B.O		Kollam	KERALA	Kottarakkara	\N	\N	691501
4300	Nilamel S.O		Kollam	KERALA	Kottarakara	\N	\N	691535
4301	Odanavattom S.O		Kollam	KERALA	Kottarakara	\N	\N	691512
4302	Pallickal-kottarakara S.O		Kollam	KERALA	Kottarakkara	\N	\N	691566
4303	Pattathanam S.O		Kollam	KERALA	Kollam	\N	\N	691021
4304	Perumpuzha S.O		Kollam	KERALA	Kollam	\N	\N	691504
4305	Peruvelikara B.O		Kollam	KERALA	Kollam	\N	\N	691500
4306	Pulippara Jn B.O		Kollam	KERALA	Kottarakkara	\N	\N	691536
4307	Puthur-kollam S.O		Kollam	KERALA	Kottarakara	\N	\N	691507
4308	S V Market B.O		Kollam	KERALA	Karunagappally	\N	\N	690573
4309	Sakthikulangara S.O		Kollam	KERALA	Kollam	\N	\N	691581
4310	T K M College S.O		Kollam	KERALA	Kollam	\N	\N	691005
4311	Thevally S.O		Kollam	KERALA	Kollam	\N	\N	691009
4312	Thirumullavaram S.O		Kollam	KERALA	Kollam	\N	\N	691012
4313	Vadakkumthala East S.O		Kollam	KERALA	Karunagappally	\N	\N	690536
4314	Vakkanad B.O		Kollam	KERALA	Kottarakkara	\N	\N	691509
4315	Valathungal B.O		Kollam	KERALA	Kollam	\N	\N	691011
4316	Vellimon West B.O		Kollam	KERALA	Kollam	\N	\N	691511
4317	Vettikavala S.O		Kollam	KERALA	Kottarakara	\N	\N	691538
4318	West Kallada S.O		Kollam	KERALA	Kollam	\N	\N	691500
4319	Ambalakkara B.O		Kollam	KERALA	Kottarakkara	\N	\N	691532
4320	Arinallur S.O		Kollam	KERALA	Karunagappally	\N	\N	690538
4321	Asramom S.O		Kollam	KERALA	Kollam	\N	\N	691002
4322	Channappara B.O		Kollam	KERALA	Kottarakkara	\N	\N	691536
4323	Chithara S.O		Kollam	KERALA	Kottarakara	\N	\N	691559
4324	Elampazhannur B.O		Kollam	KERALA	Kottarakkara	\N	\N	691534
4325	Idakkadom B.O		Kollam	KERALA	Kottarakkara	\N	\N	691505
4326	Kadakkal S.O		Kollam	KERALA	Kottarakara	\N	\N	691536
4327	Kadakkode B.O		Kollam	KERALA	Kottarakkara	\N	\N	691505
4328	Kadappakada S.O		Kollam	KERALA	Kollam	\N	\N	691008
4329	Kundara S.O		Kollam	KERALA	Kollam	\N	\N	691501
4330	Kuzhimathicaud S.O		Kollam	KERALA	Kottarakara	\N	\N	691509
4331	Mancode-kadakkal B.O		Kollam	KERALA	Kottarakkara	\N	\N	691559
4332	Mukathala S.O		Kollam	KERALA	Kollam	\N	\N	691577
4333	Mundakkal B.O		Kollam	KERALA	Kollam	\N	\N	691010
4334	Mynagappally North B.O		Kollam	KERALA	Kunnathur	\N	\N	690519
4335	Parippally S.O		Kollam	KERALA	Kollam	\N	\N	691574
4336	Poredom B.O		Kollam	KERALA	Kottarakkara	\N	\N	691534
4337	Puthukkadukara B.O		Kollam	KERALA	Karunagappally	\N	\N	691585
4338	Thodiyur North B.O		Kollam	KERALA	Karunagappally	\N	\N	690523
4339	Thrioppilazhikom B.O		Kollam	KERALA	Kottarakkara	\N	\N	691509
4340	Ummannur B.O		Kollam	KERALA	Kottarakara	\N	\N	691520
4341	Vadakkevila S.O		Kollam	KERALA	Kollam	\N	\N	691010
4342	Valakom S.O		Kollam	KERALA	Kottarakara	\N	\N	691532
4343	Valiyode B.O		Kollam	KERALA	Kottarakkara	\N	\N	691520
4344	Vayakkal B.O		Kollam	KERALA	Kottarakkara	\N	\N	691532
4345	Akkal B.O		Kollam	KERALA	Kottarakkara	\N	\N	691516
4346	Amrithapuri B.O		Kollam	KERALA	Karunagappally	\N	\N	690525
4347	Arinallur South B.O		Kollam	KERALA	Karunagappally	\N	\N	690538
4348	Chemmakkad B.O		Kollam	KERALA	Kollam	\N	\N	691601
4349	Edakulangara B.O		Kollam	KERALA	Karunagappally	\N	\N	690523
4350	Edappallycotta B.O		Kollam	KERALA	Karunagappally	\N	\N	691583
4351	Kallelibhagom B.O		Kollam	KERALA	Karunagapally	\N	\N	690519
4352	Kalluvathukkal S.O		Kollam	KERALA	Kollam	\N	\N	691578
4353	Karimpinpuzha B.O		Kollam	KERALA	Kottarakkara	\N	\N	691507
4354	Kilikollur East S.O		Kollam	KERALA	Kollam	\N	\N	691004
4355	Kizhakketheruvu B.O		Kollam	KERALA	Kottarakkara	\N	\N	691531
4356	Koduvila B.O		Kollam	KERALA	Kollam	\N	\N	691502
4357	Kokkad B.O		Kollam	KERALA	Kottarakkara	\N	\N	691538
4358	Kollam H.O		Kollam	KERALA	Kollam	\N	\N	691001
4359	Kottiyam S.O		Kollam	KERALA	Kollam	\N	\N	691571
4360	Kudavattur B.O		Kollam	KERALA	Kottarakkara	\N	\N	691512
4361	Kulakada S.O		Kollam	KERALA	Kottarakara	\N	\N	691521
4362	Kumbalam B.O		Kollam	KERALA	Kollam	\N	\N	691503
4363	Kummallur B.O		Kollam	KERALA	Kollam	\N	\N	691573
4364	Mynagappally S.O		Kollam	KERALA	Karunagappally	\N	\N	690519
4365	Nallila S.O		Kollam	KERALA	Kollam	\N	\N	691515
4366	Plappally B.O		Kollam	KERALA	Kottarakkara	\N	\N	691531
4367	Ponmana B.O		Kollam	KERALA	Karunagappally	\N	\N	691583
4368	Pooyapally S.O		Kollam	KERALA	Kottarakara	\N	\N	691537
4369	Prayar S.O		Alappuzha	KERALA	Karthikappally	\N	\N	690547
4370	Pulamon S.O		Kollam	KERALA	Kottarakara	\N	\N	691531
4371	Pullichira S.O		Kollam	KERALA	Kollam	\N	\N	691304
4372	Pullupana B.O		Kollam	KERALA	Kottarakkara	\N	\N	691536
4373	Puthenthura B.O		Kollam	KERALA	Karunagappally	\N	\N	691582
4374	Sadanandapuram B.O		Kollam	KERALA	Kottarakkara	\N	\N	691531
4375	Thalachira B.O		Kollam	KERALA	Kottarakkara	\N	\N	691538
4376	Thamarakudy B.O		Kollam	KERALA	Kottarakkara	\N	\N	691560
4377	Uliyakovil S.O		Kollam	KERALA	Kollam	\N	\N	691019
4378	Vadakkumbhagom B.O		Kollam	KERALA	Karunagappally	\N	\N	691584
4379	Vattathamara B.O		Kollam	KERALA	Kottarakkara	\N	\N	691536
4380	Vendar B.O		Kollam	KERALA	Kottarakkara	\N	\N	691507
4381	Adichanallur S.O		Kollam	KERALA	Adichanallur	\N	\N	691573
4382	Ambalathumkala B.O		Kollam	KERALA	Kottarakkara	\N	\N	691505
4383	Ambipoika B.O		Kollam	KERALA	Kollam	\N	\N	691501
4384	Ashtamudi B.O		Kollam	KERALA	Kollam	\N	\N	691602
4385	Chavara South S.O		Kollam	KERALA	Karunagapally	\N	\N	691584
4386	Edathara B.O		Kollam	KERALA	Kottarakkara	\N	\N	691536
4387	Edayam B.O		Kollam	KERALA	Kottarakkara	\N	\N	691532
4388	Eravipuram S.O		Kollam	KERALA	Kollam	\N	\N	691011
4389	Extension Trg Centre B.O		Kollam	KERALA	Kottarakkara	\N	\N	691531
4390	Iverkala East B.O		Kollam	KERALA	Kottarakkara	\N	\N	691507
4391	Kallumthazham B.O		Kollam	KERALA	Kollam	\N	\N	691004
4392	Karamcode S.O		Kollam	KERALA	Kollam	\N	\N	691579
4393	Karunagappaly H.O		Kollam	KERALA	Karunagappaly	\N	\N	690518
4394	Kura B.O		Kollam	KERALA	Kottarakkara	\N	\N	691557
4395	Kuthirapanthy B.O		Kollam	KERALA	Karunagappally	\N	\N	690523
4396	Maranad B.O		Kollam	KERALA	Kottarakkara	\N	\N	691505
4397	Munroethuruthu B.O		Kollam	KERALA	Kollam	\N	\N	691502
4398	Nedumpana B.O		Kollam	KERALA	Kollam	\N	\N	691576
4399	Nedungolam S.O		Kollam	KERALA	Kollam	\N	\N	691334
4400	Neeleswaram B.O		Kollam	KERALA	Kottarakara	\N	\N	691505
4401	Nellikunnam B.O		Kollam	KERALA	Kottarakkara	\N	\N	691520
4402	Pavithreswaram B.O		Kollam	KERALA	Kottarakara	\N	\N	691507
4403	Pavumba B.O		Kollam	KERALA	Karunagapally	\N	\N	690574
4404	Perungalam B.O		Kollam	KERALA	Karunagappally	\N	\N	690538
4405	Thattakkattu Market B.O		Alappuzha	KERALA	Karthikappally	\N	\N	690547
4406	Thattarkonam B.O		Kollam	KERALA	Kollam	\N	\N	691005
4407	Thrikkannamangal B.O		Kollam	KERALA	Kottarakkara	\N	\N	691531
4408	Thudayannur B.O		Kollam	KERALA	Kottarakkara	\N	\N	691536
4409	Velamannoor B.O		Kollam	KERALA	Kollam	\N	\N	691574
4410	Venkolla B.O		Kollam	KERALA	Kottarakkara	\N	\N	691541
4411	Alumoodu B.O		Kollam	KERALA	Kollam	\N	\N	691577
4412	Chadayamangalam S.O		Kollam	KERALA	Kottarakkara	\N	\N	691534
4413	Chandanathope S.O		Kollam	KERALA	Kollam	\N	\N	691014
4414	Chathannur S.O		Kollam	KERALA	Kolllam	\N	\N	691572
4415	Chavara Bridge S.O		Kollam	KERALA	Karunagapally	\N	\N	691583
4416	Chirakkarathazham B.O		Kollam	KERALA	Kollam	\N	\N	691578
4417	Karunagappally North B.O		Kollam	KERALA	Karunagappally	\N	\N	690544
4418	Kollam Bazar S.O		Kollam	KERALA	Kollam	\N	\N	691001
4419	Kulakkada East B.O		Kollam	KERALA	Kottarakkara	\N	\N	691521
4420	Kummil B.O		Kollam	KERALA	Kottarakkara	\N	\N	691536
4421	Mayyanad S.O		Kollam	KERALA	Kollam	\N	\N	691303
4422	Mulavana S.O		Kollam	KERALA	Kollam	\N	\N	691503
4423	Neendakara S.O		Kollam	KERALA	Karunagapally	\N	\N	691582
4424	Padappakara B.O		Kollam	KERALA	Kollam	\N	\N	691503
4425	Padinjattakkara B.O		Kollam	KERALA	Karunagappally	\N	\N	690524
4426	Panavely B.O		Kollam	KERALA	Kottarakkara	\N	\N	691532
4427	Panayam B.O		Kollam	KERALA	Kollam	\N	\N	691601
4428	Panmana Puthen Chantha B.O		Kollam	KERALA	Karunagappally	\N	\N	691583
4429	Pattamthuruth B.O		Kollam	KERALA	Kollam	\N	\N	691601
4430	Perumon B.O		Kollam	KERALA	Kollam	\N	\N	691601
4431	Podiyattuvila B.O		Kollam	KERALA	Kottarakkara	\N	\N	691532
4432	Thattamala S.O		Kollam	KERALA	Kollam	\N	\N	691020
4433	Thekkevila S.O		Kollam	KERALA	Kollam	\N	\N	691016
4434	Thevalakkara S.O		Kollam	KERALA	Karunagappally	\N	\N	690524
4435	Thevalappuram B.O		Kollam	KERALA	Kottarakkara	\N	\N	691507
4436	Varavila B.O		Kollam	KERALA	Karunagappally	\N	\N	690528
4437	Veliyam S.O		Kollam	KERALA	Kottarakara	\N	\N	691540
4438	Vilavoorkonam B.O		Kollam	KERALA	Kollam	\N	\N	691578
4439	Alumkadavu S.O		Kollam	KERALA	Karunagappally	\N	\N	690573
4440	Ayathil B.O		Kollam	KERALA	Kollam	\N	\N	691021
4441	Cheriyavelinallur B.O		Kollam	KERALA	Kottarakkara	\N	\N	691516
4442	Cheriyazheekal B.O		Kollam	KERALA	Karunagappally	\N	\N	690573
4443	Clappana S.O		Kollam	KERALA	Karunagapally	\N	\N	690525
4444	Edanad B.O B.O		Kollam	KERALA	Kollam	\N	\N	691579
4445	Ezhukone S.O		Kollam	KERALA	Kottarakara	\N	\N	691505
4446	Kanjiracode B.O		Kollam	KERALA	Kollam	\N	\N	691501
4447	Kannanallur S.O		Kollam	KERALA	Kollam	\N	\N	691576
4448	Karingannur S.O		Kollam	KERALA	Kottarakkara	\N	\N	691516
4449	Kattadi Jn B.O		Kollam	KERALA	Kottarakkara	\N	\N	691537
4450	Kilikollur S.O		Kollam	KERALA	Kollam	\N	\N	691004
4451	Kottarakara H.O		Kollam	KERALA	Kottarakara	\N	\N	691506
4452	Kuriyode B.O		Kollam	KERALA	Kottarakkara	\N	\N	691534
4453	Mailode B.O		Kollam	KERALA	Kottarakkara	\N	\N	691537
4454	Mavadi B.O		Kollam	KERALA	Kottarakkara	\N	\N	691507
4455	Meeyana B.O		Kollam	KERALA	Kottarakkara	\N	\N	691510
4456	Muttara B.O		Kollam	KERALA	Kottarakkara	\N	\N	691512
4457	Oyur S.O		Kollam	KERALA	Kottarakkara	\N	\N	691510
4458	Pallithottam S.O		Kollam	KERALA	Kollam	\N	\N	691006
4459	Paravur S.O (Kollam)		Kollam	KERALA	Kollam	\N	\N	691301
4460	Puthenkulam B.O		Kollam	KERALA	Kollam	\N	\N	691302
4461	S R P Market S.O		Kollam	KERALA	Karunagappally	\N	\N	690539
4462	Thottumugham B.O		Kollam	KERALA	Karunagappally	\N	\N	690519
4463	Valavupacha B.O		Kollam	KERALA	Kottarakkara	\N	\N	691559
4464	Veliyam West B.O		Kollam	KERALA	Kottarakkara	\N	\N	691540
4465	Anakottur B.O		Kollam	KERALA	Kottarakkara	\N	\N	691505
4466	Andoor B.O		Kollam	KERALA	Kottarakkara	\N	\N	691532
4467	Bhoothakulam S.O		Kollam	KERALA	Kollam	\N	\N	691302
4468	Chavara S.O		Kollam	KERALA	Karunagappally	\N	\N	691583
4469	Cheppara S.O		Kollam	KERALA	Kottarakkara	\N	\N	691520
4470	Cherupoika B.O		Kollam	KERALA	Kottarakkara	\N	\N	691543
4471	East Kallada S.O		Kollam	KERALA	Kollam	\N	\N	691502
4472	Irumpanangadu B.O		Kollam	KERALA	Kottarakkara	\N	\N	691505
4473	Kakkotumoola B.O		Kollam	KERALA	Kollam	\N	\N	691303
4474	Kizhakkenela B.O		Kollam	KERALA	Kollam	\N	\N	691574
4475	Koivila S.O		Kollam	KERALA	Karunagappally	\N	\N	691590
4476	Kollaka B.O		Kollam	KERALA	Karunagappally	\N	\N	690536
4477	Kollam Taluk Cutchery S.O		Kollam	KERALA	Kollam	\N	\N	691001
4478	Koottikada B.O		Kollam	KERALA	Kollam	\N	\N	691020
4479	Kundara East S.O		Kollam	KERALA	Kollam	\N	\N	691501
4480	Kuttikadu B.O		Kollam	KERALA	Kottarakkara	\N	\N	691536
4481	Madathara S.O		Kollam	KERALA	Kottarakkara	\N	\N	691541
4482	Mukkoodu B.O		Kollam	KERALA	Kollam	\N	\N	691503
4483	Nellimukku B.O		Kollam	KERALA	Kottarakkara	\N	\N	691509
4484	Nettayam B.O		Kollam	KERALA	Kottarakkara	\N	\N	691537
4485	Ochira S.O		Kollam	KERALA	Karunagapally	\N	\N	690526
4486	Perinad S.O		Kollam	KERALA	Kollam	\N	\N	691601
4487	Perumkulam B.O		Kollam	KERALA	Kottarakkara	\N	\N	691566
4488	Polachira B.O		Kollam	KERALA	Kollam	\N	\N	691334
4489	Thangasserry S.O		Kollam	KERALA	Kollam	\N	\N	691007
4490	Thazhava S.O		Kollam	KERALA	Karunagappally	\N	\N	690523
4491	Thekkumbhagom S.O		Kollam	KERALA	Kollam	\N	\N	691319
4492	Thodiyur B.O		Kollam	KERALA	Karunagappally	\N	\N	690523
4493	Uliyanadu B.O		Kollam	KERALA	Kollam	\N	\N	691579
4494	Umayanallur I E S.O		Kollam	KERALA	Kollam	\N	\N	691589
4495	Vavvakkavu S.O		Kollam	KERALA	Karunagappally	\N	\N	690528
4496	Velichikala B.O		Kollam	KERALA	Kollam	\N	\N	691573
4497	Azhiyadathuchira S.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689113
4498	Chathankary S.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689112
4499	Edayarnmula S.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689532
4500	Kavumbhagom S.O		Pathanamthitta	KERALA	Tiruvalla	\N	\N	689102
4501	Mallappally East S.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689584
4502	Mallappally West S.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689585
4503	Manjady Jn S.O		Pathanamthitta	KERALA	Tiruvalla	\N	\N	689105
4504	Mepral S.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689591
4505	Narakathanni B.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689544
4506	Neervilakom B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689122
4507	Nellimala B.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689542
4508	Othera S.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689546
4509	Perumpramavu B.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689587
4510	Thelliyoor B.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689544
4511	Thonackad B.O		Alappuzha	KERALA	Chengannur	\N	\N	689511
4512	Thottabhagom B.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689541
4513	Tiruvalla RS S.O		Pathanamthitta	KERALA	Ranni	\N	\N	689111
4514	Valakuzhy B.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689544
4515	Ala S.O (Alappuzha)		Alappuzha	KERALA	Chengannur	\N	\N	689126
4516	Angadical Chengannur S.O		Alappuzha	KERALA	Chengannur	\N	\N	689122
4517	Bhudhanoor B.O		Alappuzha	KERALA	Chengannur	\N	\N	689510
4518	Chalappally B.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689586
4519	Chengannur H.O		Alappuzha	KERALA	Chengannur	\N	\N	689121
4520	Kaithakody B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689614
4521	Kattode B.O		Pathanamthitta	KERALA	Tiruvalla	\N	\N	689105
4522	Kuravankuzhy B.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689548
4523	Kurichimuttom B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689532
4524	Mithrakary B.O		Alappuzha	KERALA	Kuttanad	\N	\N	689595
4525	Mundiappally B.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689581
4526	Niranam Central B.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689621
4527	Parumala S.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689626
4528	Perisserry B.O		Alappuzha	KERALA	Chengannur	\N	\N	689126
4529	Pullad S.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689548
4530	Thadiyur S.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689545
4531	Thalavady S.O		Alappuzha	KERALA	Kuttanad	\N	\N	689572
4532	Thalavady South B.O		Alappuzha	KERALA	Kuttanad	\N	\N	689572
4533	Thayamkary B.O		Alappuzha	KERALA	Kuttanad	\N	\N	689573
4534	Thengeli B.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689106
4535	Thirumoolapuram S.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689115
4536	Vaipur S.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689588
4537	Varayannur B.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689548
4538	Vellayil B.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689613
4539	Alumthuruthy B.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689113
4540	Amichikary B.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689112
4541	Anaprambal North B.O		Alappuzha	KERALA	Kuttanad	\N	\N	689572
4542	Anikad Mallappally GDS B.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689585
4543	Chengannur RS S.O		Alappuzha	KERALA	Chengannur	\N	\N	689121
4544	Edathua S.O		Alappuzha	KERALA	Kuttanad	\N	\N	689573
4545	Edayaramula West B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689532
4546	Kallooppara S.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689583
4547	Kariamplavu B.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689615
4548	Karikuzhy B.O		Alappuzha	KERALA	Kuttanad	\N	\N	689571
4549	Kolabhagom B.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689545
4550	Kottangal B.O		Pathanamthitta	KERALA	Mallappally	\N	\N	686547
4551	Kulathur B.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689588
4552	Kumbanadu S.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689547
4553	Otherawest S.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689551
4554	Pandanad West B.O		Alappuzha	KERALA	Chengannur	\N	\N	689506
4555	Peringara S.O		Pathanamthitta	KERALA	Tiruvalla	\N	\N	689108
4556	Puliyoor S.O		Alappuzha	KERALA	Chengannur	\N	\N	689510
4557	Puthencavu S.O		Alappuzha	KERALA	Chengannur	\N	\N	689123
4558	Puthusserry South S.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689602
4559	Theodical S.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689613
4560	Valanjavattom East B.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689104
4561	Anjilithanam B.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689582
4562	Arattupuzha B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689123
4563	Cheriyanadu S.O		Alappuzha	KERALA	Chengannur	\N	\N	689511
4564	Eramallikkara B.O		Alappuzha	KERALA	Chengannur	\N	\N	689109
4565	Karakkal B.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689108
4566	Kozhimala B.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689541
4567	Kurunghazhabhagom B.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689548
4568	Kuttur S.O (Pathanamthitta)		Pathanamthitta	KERALA	Tiruvalla	\N	\N	689106
4569	Muthoor S.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689107
4570	Paduthode B.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689544
4571	Poovathoor B.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689531
4572	Punnavely S.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689589
4573	Vennikulam S.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689544
4574	Chengaroor S.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689594
4575	Chirayirambu B.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689549
4576	Edanad B.O		Alappuzha	KERALA	Chengannur	\N	\N	689123
4577	Elanjimel B.O		Alappuzha	KERALA	Chengannur	\N	\N	689511
4578	Eraviperoor East B.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689542
4579	Eraviperoor S.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689542
4580	Kadamankulam B.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689583
4581	Kodupunna B.O		Alappuzha	KERALA	Kuttanad	\N	\N	689595
4582	Kuttapuzha S.O		Pathanamthitta	KERALA	Tiruvalla	\N	\N	689103
4583	Mallappally North B.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689594
4584	Nalkallikkal B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689533
4585	Nooromavu B.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689589
4586	Piralassery B.O		Alappuzha	KERALA	Chengannur	\N	\N	689122
4587	Tiruvalla H.O		Pathanamthitta	KERALA	Tiruvalla	\N	\N	689101
4588	Valanjavattom S.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689104
4589	Vallamkulam East B.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689541
4590	Vdakkumbhagom B.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689621
4591	Velliyara B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689612
4592	Ayroor North S.O		Pathanamthitta	KERALA	Ranni	\N	\N	689612
4593	Ezhumattoor S.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689586
4594	Kadapra Mannar B.O		Pathanamthitta	KERALA	Tiruvalla	\N	\N	689621
4595	Kallisserry S.O		Alappuzha	KERALA	Chengannur	\N	\N	689124
4596	Kanjeettukara B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689611
4597	Koipuram S.O		Pathanamthitta	KERALA	Tiruvalla	\N	\N	689531
4598	Kottathoor S.O		Pathanamthitta	KERALA	Ranni	\N	\N	689614
4599	Kottoor B.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689582
4600	Kunnamthanam S.O		Pathanamthitta	KERALA	Tiruvalla	\N	\N	689581
4601	Malakara B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689532
4602	Manthanam B.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689581
4603	Mundamala B.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689543
4604	Muttumon B.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689547
4605	Nedumpuram B.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689110
4606	Neerattupuram S.O		Alappuzha	KERALA	Kuttanad	\N	\N	689571
4607	Pariyaram B.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689585
4608	Perumpatty S.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689592
4609	Perumthuruthy B.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689107
4610	Podiyadi S.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689110
4611	Puramattom S.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689543
4612	Pushpagiri Tiruvalla B.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689105
4613	Thekkumkal B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689614
4614	Thuruthicaud S.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689597
4615	Tiruvalla Market Jn S.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689101
4616	Veliyanadu S.O		Alappuzha	KERALA	Kuttanadu	\N	\N	689590
4617	Anaprambal B.O		Alappuzha	KERALA	Kuttanad	\N	\N	689572
4618	Aranmula S.O		Pathanamthitta	KERALA	Kozhencherry	\N	\N	689533
4619	Changankary B.O		Alappuzha	KERALA	Kuttanad	\N	\N	689573
4620	Chekkidikkadu B.O		Alappuzha	KERALA	Kuttanad	\N	\N	689573
4621	Kadapra Kumbanadu B.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689547
4622	Kallumkal B.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689102
4623	Kavungumprayar B.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689543
4624	Kizhakkumbhagom B.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689621
4625	Kottanad S.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689615
4626	Kunnathukara HSC B.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689546
4627	Kunthirickal B.O		Alappuzha	KERALA	Kuttanad	\N	\N	689572
4628	Maramon S.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689549
4629	Muttar S.O		Alappuzha	KERALA	Kuttanadu	\N	\N	689574
4630	Niranam S.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689621
4631	Palackathakidi B.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689581
4632	Pandanad S.O		Alappuzha	KERALA	Chengannur	\N	\N	689506
4633	Ramankary S.O		Alappuzha	KERALA	Kuttanad	\N	\N	689595
4634	Urukari B.O		Alappuzha	KERALA	Kuttanad	\N	\N	689595
4635	Vallamkulam S.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689541
4636	Veliyanadu West B.O		Alappuzha	KERALA	Kuttanad	\N	\N	689590
4637	Ayroor South S.O		Pathanamthitta	KERALA	Ranni	\N	\N	689611
4638	Chumathra B.O		Pathanamthitta	KERALA	Tiruvalla	\N	\N	689103
4639	Chunkapara S.O		Pathanamthitta	KERALA	Mallappally	\N	\N	686547
4640	Edappavoor B.O		Pathanamthitta	KERALA	Ranni	\N	\N	689614
4641	Erumakkad B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689532
4642	Kaviyoor S.O		Pathanamthitta	KERALA	Tiruvalla	\N	\N	689582
4643	Keezhvaipur S.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689587
4644	Kuriannoor S.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689550
4645	Madathumbhagom North B.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689543
4646	Mallappuzhassery B.O		Pathanamthitta	KERALA	Kozhenchery	\N	\N	689533
4647	Mundancavu B.O		Alappuzha	KERALA	Chengannur	\N	\N	689124
4648	Padimon B.O		Pathanamthitta	KERALA	Mallappally	\N	\N	689587
4649	Pandanad North B.O		Alappuzha	KERALA	Chengannur	\N	\N	689124
4650	Pandankary B.O		Alappuzha	KERALA	Kuttanad	\N	\N	689573
4651	Tiruvanvandur S.O		Alappuzha	KERALA	Chengannur	\N	\N	689109
4652	Vazharmangalam B.O		Alappuzha	KERALA	Chengannur	\N	\N	689124
4653	Veliyanadu North B.O		Alappuzha	KERALA	Kuttanad	\N	\N	689590
4654	Venpala B.O		Pathanamthitta	KERALA	Thiruvalla	\N	\N	689102
4655	Vezhapra B.O		Alappuzha	KERALA	Kuttanad	\N	\N	689595
4656	Altharamoodu B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695102
4657	Anayara S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695029
4658	Karavaram B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695605
4659	Koithurkonam B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695584
4660	Moongode S.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695144
4661	Mudapuram B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695304
4662	Nilakkamukku B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695306
4663	Njarayilkonam B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695602
4664	Pallipuram S.O (Thiruvananthapuram)		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695316
4665	Parayathukonam B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695104
4666	Thiruvananthapuram  Beach S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695007
4667	Thiruvananthapuram  Engg College S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695016
4668	Ulloor B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695011
4669	Varkala S.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695141
4670	Venkode B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695028
4671	Venkulam B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695311
4672	Andoorkonam B.O		Thiruvananthapuram	KERALA	Chirayinkil	\N	\N	695584
4673	Attingal H.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695101
4674	Beemapally B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695008
4675	Chirayinkeezhu S.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695304
4676	Hariharapuram B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695310
4677	Kaniyapuram S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695301
4678	Karimanal B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695583
4679	Keezhattingal B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695101
4680	Kulathur S.O (Thiruvananthapuram)		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695583
4681	Madavoor-pallickal S.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695602
4682	Maruthikunnu B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695603
4683	Moonnanakuzhy B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695615
4684	Nedumparambu B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695102
4685	Panayara B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695145
4686	Pangappara B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695581
4687	Peroor B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695601
4688	Ponganadu B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695601
4689	Prasanth Nagar B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695011
4690	Pullampara B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695607
4691	Pullayil B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695601
4692	Sainik School S.O (Thiruvananthapuram)		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695585
4693	Santhigiri S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695589
4694	St.Xavier"s College S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695586
4695	Thiruvananthapuram  Chalai S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695036
4696	Thiruvananthapuram  Medical College S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695011
4697	Thiruvananthapuram  University S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695034
4698	Varkala South B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695141
4699	Vennicode S.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695318
4700	Vettoor S.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695312
4701	Bharathannur B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695609
4702	Charupara B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695601
4703	Elakamon-kizhakkepuram B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695310
4704	Kalamachal B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695606
4705	Kallara S.O (Thiruvananthapuram)		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695608
4706	Kanchinada B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695609
4707	Karikkakom S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695021
4708	Karimkuttikara B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695606
4709	Kattumpuram B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695608
4710	Kilmanur S.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695601
4711	Kodithookiyakunnu B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695608
4712	Kokkottukonam B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695604
4713	Konchira B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695615
4714	Kuthirakulam B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695615
4715	Manambur S.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695611
4716	Moonnumukku B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695609
4717	Moothala B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695604
4718	Nagaroor B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695601
4719	Neeramankadavuu B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695610
4720	Nethajipuram B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695589
4721	Odayam B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695311
4722	Pakalkuri B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695604
4723	Pallithura B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695586
4724	PMG Jn S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695033
4725	Poothura B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695309
4726	Public Office S.O (Thiruvananthapuram)		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695033
4727	Sasthavattom B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695305
4728	Sreekaryam S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695017
4729	Thiruvananthapuram  Fort S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695023
4730	Thope B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695008
4731	Thuruvikkal B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695011
4732	Vanchiyur-attingal B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695102
4733	Adayamon B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695614
4734	Alamcode S.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695102
4735	Anakudy B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695606
4736	Anathalavattom B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695306
4737	Anjengo S.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695309
4738	Attakulangara S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695023
4739	Ayilam B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695103
4740	Chakkai B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695024
4741	Cheeranikkara B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695615
4742	Chilakur B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695141
4743	Edakode B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695104
4744	Elakamon B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695310
4745	Kadakkavur S.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695306
4746	Kavalayur B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695144
4747	Melvettoor B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695312
4748	Mukkudil B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695607
4749	Murukumpuzhaa S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695302
4750	Muthana B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695146
4751	Mylamoodu B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695609
4752	Perumathura B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695303
4753	Perumkulam B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695102
4754	Perunguzhi S.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695305
4755	Puthenthope B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695586
4756	Thiruvananthapuram  AG"s S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695001
4757	Thiruvananthapuram  ISRO S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695022
4758	Thiruvananthapuram  Pettah S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695024
4759	Thonnakkal S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695317
4760	Vattappara S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695028
4761	Ayroor-varkala S.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695310
4762	Chempazhanthy S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695587
4763	Cherunniyur S.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695142
4764	Edava S.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695311
4765	Janardhanapuram B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695141
4766	Kallambalam S.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695605
4767	Karyavattom S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695581
4768	Kazhakuttam S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695582
4769	Keezhavur B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695584
4770	Kilimanur Palace B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695601
4771	Koliakode B.O		Thiruvananthapuram	KERALA	Chirayinkil	\N	\N	695607
4772	Kurumbayam B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695608
4773	Mudakkal B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695103
4774	Nalanchira S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695015
4775	Palamkonam B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695607
4776	Pazhayakunnummel B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695601
4777	Powdikonam		Thiruvananthapuram	KERALA	Tiruvanathapuram	\N	\N	695588
4778	Pulimath S.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695612
4779	Puthencurichy S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695303
4780	Thalikuzhi B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695612
4781	Thiruvananthapuram  Govt Press S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695001
4782	Thokkad B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695143
4783	Titanium B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695021
4784	Vettiyara B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695603
4785	Vikas Bhavan S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695033
4786	Goureesapattom B.O		Thiruvananthapuram	KERALA	Trivandrum	\N	\N	695004
4787	Kandukrishi B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695104
4788	Kappil B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695311
4789	Kattaikonam B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695584
4790	Kurakkada B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695104
4791	Melkadakkavur B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695306
4792	Pallickal Kilimanur S.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695604
4793	Pirappancode B.O		Thiruvananthapuram	KERALA	Chirayinkil	\N	\N	695607
4794	Puthusserimukku B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695605
4795	Thiruvananthapuram G.P.O.		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695001
4796	Valiathura B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695008
4797	Aliyadu B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695607
4798	Cheruvallimukku B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695304
4799	Cheruvikkal B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695011
4800	Kottukunnam B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695606
4801	Kulamuttam B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695144
4802	Malakkal B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695602
4803	Manjamala B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695313
4804	Mannanathala S.O		Thiruvananthapuram	KERALA	Trivendrum	\N	\N	695015
4805	Mithirmala S.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695610
4806	Muthuvila B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695610
4807	Navaikulam S.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695603
4808	Nellanad B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695606
4809	Puliyurkonam B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695604
4810	Sreenivasapuram S.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695145
4811	Thottakkad B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695605
4812	Thundathil B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695581
4813	Vadasserikonam S.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695143
4814	Vakkom S.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695308
4815	Vallakkadavoo S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695008
4816	Vellallur B.O		Thiruvananthapuram	KERALA	Chirayinkil	\N	\N	695601
4817	Vembayam S.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695615
4818	Avanavancherry S.O		Thiruvananthapuram	KERALA	chirayinkeezhu	\N	\N	695103
4819	Azhurmarket B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695305
4820	Channamkara B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695301
4821	Chittattumukku B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695301
4822	Ilamba B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695103
4823	Iroopara B.O		Thiruvananthapuram	KERALA	Chirayinkil	\N	\N	695584
4824	Kaikara B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695307
4825	Kaithamukku S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695024
4826	Katakam B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695304
4827	Kizhuvalam S.O		Thiruvananthapuram	KERALA	Chirayinkeezh	\N	\N	695104
4828	Koduvazhannur B.O		Thiruvananthapuram	KERALA	Chirayinkil	\N	\N	695612
4829	Kudavur S.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695313
4830	Mg College B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695004
4831	Mulakkalathukavu B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695614
4832	Muttada S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695025
4833	Muttappalam B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695145
4834	Nedunganda S.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695307
4835	Oorupoika B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695104
4836	Palachira B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695143
4837	Palayamkunnu S.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695146
4838	Palkulangara S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695024
4839	Pandalacode B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695028
4840	Pangode S.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695609
4841	Parakunnu B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695603
4842	Pattom Palace S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695004
4843	Poikamukku B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695103
4844	Pothencode S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695584
4845	Pullanicode B.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695311
4846	Thattathumala S.O		Thiruvananthapuram	KERALA	Chirayinkeezhu	\N	\N	695614
4847	Valiaveli B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695021
4848	Vamanapuram S.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695606
4849	Vanchiyoor Junction S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695035
4850	Vanchiyur S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695035
4851	Vellumannady B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695607
4852	Venjaramoodu S.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695607
4853	Aralumoodu S.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695123
4854	Attukkal B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695009
4855	Bonaccord B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695551
4856	Changa B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695542
4857	Chettachal B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695551
4858	Chullimanoor B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695541
4859	Karimancode B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695562
4860	Kochuvila B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695563
4861	Kovalam S.O (Thiruvananthapuram)		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695527
4862	Malayinkil S.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695571
4863	Mancha B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695541
4864	Mulluvila B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695133
4865	Mylakkara B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695572
4866	Nellivila B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695523
4867	Nettayam   B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695013
4868	Panacode B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695542
4869	Parappara B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695551
4870	Paruthikuzhy B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695541
4871	Perurkada S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695005
4872	Peyad S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695573
4873	Poonthura S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695026
4874	Thiruvallom S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695027
4875	Uchakada S.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695506
4876	Veliyannur B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695543
4877	Vellayani S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695522
4878	Vithura S.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695551
4879	Ambalathara B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695026
4880	Ambalathinkala B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695572
4881	Anavoor B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695124
4882	Bhagavathinada B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695501
4883	Chenkal S.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695132
4884	Cheriakolla B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695504
4885	Elavattom B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695562
4886	Ex-servicemen"s Colony B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695562
4887	Kanjiramkulam S.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695524
4888	Kaudiar Square S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695003
4889	Kottapuram B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695521
4890	Malayam B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695571
4891	Mannamkonam B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695125
4892	Mannurkonam B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695541
4893	Nedumangad S.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695541
4894	Ooruttambalam S.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695507
4895	Paruthipally B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695574
4896	Pazhakutty S.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695561
4897	Perumpazhuthoor S.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695126
4898	Poozhanad B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695125
4899	TVM  R.K Mission B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695010
4900	Uriakode B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695543
4901	Vellarada S.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695505
4902	Vilappilsala B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695573
4903	Vinobaniketan B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695542
4904	Amachal B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695572
4905	Ambalamukku S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695005
4906	Chaikkottukonam B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695122
4907	Idinjar B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695563
4908	Kaimanam S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695040
4909	Kallar Tvm B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695551
4910	Karikuzhi B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695505
4911	Karode B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695506
4912	Kattacode B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695572
4913	Kuttamala B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695505
4914	Kuvalassery S.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695512
4915	Lourdepuram B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695526
4916	Manacaud S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695009
4917	Manchamcode B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695125
4918	Manchavilakom B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695503
4919	Mariyapuram B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695122
4920	Mundela B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695543
4921	Olathanni B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695133
4922	Pachallur B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695027
4923	Panavoor S.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695568
4924	Parassala S.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695502
4925	Plamootukada B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695122
4926	Puthukulangara B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695541
4927	Thennur B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695563
4928	Valiamala S.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695547
4929	Valiavila B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695006
4930	Vazhichal B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695125
4931	Venganur S.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695523
4932	Venpakal B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695123
4933	Vizhinjam S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695521
4934	Amaravila S.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695122
4935	Anad B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695541
4936	Aruvipuram B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695126
4937	Cgo Complex Poonkulam S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695522
4938	Kalliyoor S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695042
4939	Karakonam S.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695504
4940	Kattakada S.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695572
4941	Keezharur B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695124
4942	Kokkotela B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695542
4943	Kottukal B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695501
4944	Manikanteswaram B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695013
4945	Marangad B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695542
4946	Meenmutty B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695562
4947	Mithraniketan B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695543
4948	Nemom S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695020
4949	Neyyattinkara Town S.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695121
4950	Pacha S.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695562
4951	Paluvally B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695562
4952	Panangode B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695563
4953	Panayamuttom B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695561
4954	Pappanamcode S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695018
4955	Parandode B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695542
4956	Perayam B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695562
4957	Pulluvila S.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695526
4958	Puthiathura B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695526
4959	Veeranakavu B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695572
4960	Vellanad S.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695543
4961	Amboori B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695505
4962	Anappara B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695551
4963	Aruvikara B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695564
4964	Aryanad S.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695542
4965	Chekkakonam B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695564
4966	Cheriyakonni B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695013
4967	Elluvila B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695504
4968	Industrial Estate S.O (Thiruvananthapuram)		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695019
4969	Kanjampazhanji B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695525
4970	Karamana S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695002
4971	Kazhavur B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695526
4972	Koothali(TVM) B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695505
4973	Kottackal (TVM) B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695124
4974	Kottakkakom B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695542
4975	Kottoor(TVM) B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695574
4976	Kudappanamoodu B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695505
4977	Kudayal B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695505
4978	Kunnathukal B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695504
4979	Meenankal B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695542
4980	Mulayara B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695543
4981	Muttakadu B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695523
4982	Naruvamoodu S.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695528
4983	Panayam B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695568
4984	Panniyode B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695575
4985	Parasuvaickal S.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695508
4986	Peringamala S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695563
4987	Ponmudi B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695551
4988	Poojapura H.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695012
4989	Pozhiyoor S.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695513
4990	PTP Nagar S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695038
4991	Sasthamangalam S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695010
4992	Thannimoodu B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695123
4993	Tholicode B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695541
4994	Thycaud S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695014
4995	Tirumala S.O (Thiruvananthapuram)		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695006
4996	Vattavila B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695132
4997	Vattiyoorkavu S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695013
4998	Aramada S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695032
4999	Arayur B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695122
5000	Ayira B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695502
5001	Cheruvarakonam B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695502
5002	Irinchayam B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695561
5003	Kakkavila B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695506
5004	Kalliyal B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695574
5005	Karakulam S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695564
5006	Kattachalkuzhy B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695501
5007	Kaudiar S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695003
5008	Kerala Governor"s Camp S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695099
5009	Kodungavila B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695123
5010	Kovalam Beach B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695527
5011	Kulappada B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695542
5012	Kuruthamcode B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695572
5013	Kuthirakalam-vellanad B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695543
5014	Kuttichal S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695574
5015	Moongode B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695573
5016	Mukkolackal B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695043
5017	Mullur B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695521
5018	Nellimoodu B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695524
5019	Neyyattinkara H.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695121
5020	Ookode B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695020
5021	Pallichal B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695020
5022	Panachamoodu B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695505
5023	Puvar S.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695525
5024	Russelpuram B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695501
5025	Vlathankara S.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695134
5026	Arumanoor B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695525
5027	Balaramapuram S.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695501
5028	Chowara B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695501
5029	Cotton Hill S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695014
5030	Daivapura B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695563
5031	Dhanuvachapuram S.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695503
5032	Ilanchiyam B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695563
5033	Kallayam B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695043
5034	Karipur B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695541
5035	Karumom B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695002
5036	Kodunganur B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695013
5037	Kollode B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695571
5038	Manali B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695505
5039	Maruthamala B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695551
5040	Mayam B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695505
5041	Payattuvila B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695501
5042	Peppara Dam B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695551
5043	Perumkadavila S.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695124
5044	Poovachal S.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695575
5045	Poovathur B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695561
5046	Pravachambalam B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695020
5047	Tirupuram S.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695133
5048	Vedivachankoil B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695501
5049	Veliyamcode B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695512
5050	Dalmughom B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695125
5051	Jagathy S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695014
5052	Kandala B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695512
5053	Kanjirampara S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695030
5054	Kidarakuzhy B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695523
5055	Koonanvenga B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695568
5056	Kudappanakunnu S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695043
5057	Machel B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695571
5058	Marayamuttom B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695124
5059	Memala B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695551
5060	Neyyar Dam B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695572
5061	Ottasekharamangalam S.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695125
5062	Pantha B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695572
5063	Perukavu B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695573
5064	Poojapura Junction S.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695012
5065	Puliyarakonam B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695573
5066	Punalal B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695575
5067	Thamalam B.O		Thiruvananthapuram	KERALA	Thiruvananthapuram	\N	\N	695012
5068	Thekkupara B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695505
5069	Vattakarikkakom B.O		Thiruvananthapuram	KERALA	Nedumangad	\N	\N	695562
5070	Venkadambu B.O		Thiruvananthapuram	KERALA	Neyyattinkara	\N	\N	695506
\.


--
-- Name: app_update_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.app_update_id_seq', 1, false);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 8, true);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 420, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 21, true);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 18, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: customers_userotpdata_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.customers_userotpdata_id_seq', 9, true);


--
-- Name: delivery_app_update_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.delivery_app_update_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 5, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 105, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 64, true);


--
-- Name: fcm_django_fcmdevice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.fcm_django_fcmdevice_id_seq', 26, true);


--
-- Name: finance_account_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.finance_account_group_id_seq', 15, true);


--
-- Name: finance_account_head_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.finance_account_head_id_seq', 20, true);


--
-- Name: mode_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.mode_id_seq', 1, true);


--
-- Name: offers_vouchercode_used_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.offers_vouchercode_used_users_id_seq', 1, true);


--
-- Name: permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.permission_id_seq', 276, true);


--
-- Name: privilege_point_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.privilege_point_history_id_seq', 1, false);


--
-- Name: product_stock_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.product_stock_id_seq', 1, false);


--
-- Name: product_variation_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.product_variation_type_id_seq', 4, true);


--
-- Name: purchase_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.purchase_item_id_seq', 10, true);


--
-- Name: purchase_order_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.purchase_order_item_id_seq', 1, true);


--
-- Name: purchase_return_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.purchase_return_item_id_seq', 1, false);


--
-- Name: registration_registrationprofile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.registration_registrationprofile_id_seq', 1, false);


--
-- Name: sale_return_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.sale_return_item_id_seq', 1, true);


--
-- Name: sales_sale_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.sales_sale_item_id_seq', 12, true);


--
-- Name: special_variant_product_variant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.special_variant_product_variant_id_seq', 1, false);


--
-- Name: staff_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.staff_permission_id_seq', 330, true);


--
-- Name: stock_update_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.stock_update_item_id_seq', 1, false);


--
-- Name: users_notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.users_notification_id_seq', 20, true);


--
-- Name: users_notification_subject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.users_notification_subject_id_seq', 9, true);


--
-- Name: vendors_commission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.vendors_commission_id_seq', 1, false);


--
-- Name: vendors_vendor_deliverable_location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.vendors_vendor_deliverable_location_id_seq', 166, true);


--
-- Name: warehouse_deliverable_location_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.warehouse_deliverable_location_id_seq', 123, true);


--
-- Name: warehouse_no_express_delivery_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.warehouse_no_express_delivery_id_seq', 1, false);


--
-- Name: web_sociallinks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.web_sociallinks_id_seq', 1, false);


--
-- Name: zone_id_seq; Type: SEQUENCE SET; Schema: public; Owner: nexsme_live
--

SELECT pg_catalog.setval('public.zone_id_seq', 5070, true);


--
-- Name: app_update app_update_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.app_update
    ADD CONSTRAINT app_update_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: customer_bank_account customer_bank_account_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.customer_bank_account
    ADD CONSTRAINT customer_bank_account_pkey PRIMARY KEY (id);


--
-- Name: customers_customer customers_customer_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.customers_customer
    ADD CONSTRAINT customers_customer_auto_id_key UNIQUE (auto_id);


--
-- Name: customers_customer customers_customer_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.customers_customer
    ADD CONSTRAINT customers_customer_pkey PRIMARY KEY (id);


--
-- Name: customers_customer customers_customer_user_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.customers_customer
    ADD CONSTRAINT customers_customer_user_id_key UNIQUE (user_id);


--
-- Name: customers_customeraddress customers_customeraddress_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.customers_customeraddress
    ADD CONSTRAINT customers_customeraddress_pkey PRIMARY KEY (id);


--
-- Name: customers_userotpdata customers_userotpdata_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.customers_userotpdata
    ADD CONSTRAINT customers_userotpdata_pkey PRIMARY KEY (id);


--
-- Name: deal_of_day deal_of_day_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.deal_of_day
    ADD CONSTRAINT deal_of_day_auto_id_key UNIQUE (auto_id);


--
-- Name: deal_of_day deal_of_day_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.deal_of_day
    ADD CONSTRAINT deal_of_day_pkey PRIMARY KEY (id);


--
-- Name: delivery_agent_collectedpaymentregister delivery_agent_collectedpaymentregister_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.delivery_agent_collectedpaymentregister
    ADD CONSTRAINT delivery_agent_collectedpaymentregister_auto_id_key UNIQUE (auto_id);


--
-- Name: delivery_agent_collectedpaymentregister delivery_agent_collectedpaymentregister_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.delivery_agent_collectedpaymentregister
    ADD CONSTRAINT delivery_agent_collectedpaymentregister_pkey PRIMARY KEY (id);


--
-- Name: delivery_agent_collectpayment delivery_agent_collectpayment_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.delivery_agent_collectpayment
    ADD CONSTRAINT delivery_agent_collectpayment_auto_id_key UNIQUE (auto_id);


--
-- Name: delivery_agent_collectpayment delivery_agent_collectpayment_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.delivery_agent_collectpayment
    ADD CONSTRAINT delivery_agent_collectpayment_pkey PRIMARY KEY (id);


--
-- Name: delivery_agent_delivery_agent delivery_agent_delivery_agent_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.delivery_agent_delivery_agent
    ADD CONSTRAINT delivery_agent_delivery_agent_auto_id_key UNIQUE (auto_id);


--
-- Name: delivery_agent_delivery_agent delivery_agent_delivery_agent_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.delivery_agent_delivery_agent
    ADD CONSTRAINT delivery_agent_delivery_agent_pkey PRIMARY KEY (id);


--
-- Name: delivery_agent_delivery_agent delivery_agent_delivery_agent_user_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.delivery_agent_delivery_agent
    ADD CONSTRAINT delivery_agent_delivery_agent_user_id_key UNIQUE (user_id);


--
-- Name: delivery_agent_deliveryrating delivery_agent_deliveryrating_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.delivery_agent_deliveryrating
    ADD CONSTRAINT delivery_agent_deliveryrating_pkey PRIMARY KEY (id);


--
-- Name: delivery_agent_travel delivery_agent_travel_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.delivery_agent_travel
    ADD CONSTRAINT delivery_agent_travel_pkey PRIMARY KEY (id);


--
-- Name: delivery_agent_trip delivery_agent_trip_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.delivery_agent_trip
    ADD CONSTRAINT delivery_agent_trip_pkey PRIMARY KEY (id);


--
-- Name: delivery_app_update delivery_app_update_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.delivery_app_update
    ADD CONSTRAINT delivery_app_update_pkey PRIMARY KEY (id);


--
-- Name: designation designation_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.designation
    ADD CONSTRAINT designation_auto_id_key UNIQUE (auto_id);


--
-- Name: designation designation_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.designation
    ADD CONSTRAINT designation_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: fcm_django_fcmdevice fcm_django_fcmdevice_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.fcm_django_fcmdevice
    ADD CONSTRAINT fcm_django_fcmdevice_pkey PRIMARY KEY (id);


--
-- Name: fcm_django_fcmdevice fcm_django_fcmdevice_registration_id_9918b353_uniq; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.fcm_django_fcmdevice
    ADD CONSTRAINT fcm_django_fcmdevice_registration_id_9918b353_uniq UNIQUE (registration_id);


--
-- Name: finance_account_group finance_account_group_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_account_group
    ADD CONSTRAINT finance_account_group_pkey PRIMARY KEY (id);


--
-- Name: finance_account_head_opening finance_account_head_opening_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_account_head_opening
    ADD CONSTRAINT finance_account_head_opening_auto_id_key UNIQUE (auto_id);


--
-- Name: finance_account_head_opening finance_account_head_opening_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_account_head_opening
    ADD CONSTRAINT finance_account_head_opening_pkey PRIMARY KEY (id);


--
-- Name: finance_account_head finance_account_head_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_account_head
    ADD CONSTRAINT finance_account_head_pkey PRIMARY KEY (id);


--
-- Name: finance_bank_account finance_bank_account_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_bank_account
    ADD CONSTRAINT finance_bank_account_auto_id_key UNIQUE (auto_id);


--
-- Name: finance_bank_account finance_bank_account_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_bank_account
    ADD CONSTRAINT finance_bank_account_pkey PRIMARY KEY (id);


--
-- Name: finance_credit_voucher finance_credit_voucher_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_credit_voucher
    ADD CONSTRAINT finance_credit_voucher_auto_id_key UNIQUE (auto_id);


--
-- Name: finance_credit_voucher finance_credit_voucher_cheque_number_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_credit_voucher
    ADD CONSTRAINT finance_credit_voucher_cheque_number_key UNIQUE (cheque_number);


--
-- Name: finance_credit_voucher finance_credit_voucher_draft_number_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_credit_voucher
    ADD CONSTRAINT finance_credit_voucher_draft_number_key UNIQUE (draft_number);


--
-- Name: finance_credit_voucher finance_credit_voucher_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_credit_voucher
    ADD CONSTRAINT finance_credit_voucher_pkey PRIMARY KEY (id);


--
-- Name: finance_credit_voucher finance_credit_voucher_transfer_number_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_credit_voucher
    ADD CONSTRAINT finance_credit_voucher_transfer_number_key UNIQUE (transfer_number);


--
-- Name: finance_debit_voucher finance_debit_voucher_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_debit_voucher
    ADD CONSTRAINT finance_debit_voucher_auto_id_key UNIQUE (auto_id);


--
-- Name: finance_debit_voucher finance_debit_voucher_cheque_number_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_debit_voucher
    ADD CONSTRAINT finance_debit_voucher_cheque_number_key UNIQUE (cheque_number);


--
-- Name: finance_debit_voucher finance_debit_voucher_draft_number_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_debit_voucher
    ADD CONSTRAINT finance_debit_voucher_draft_number_key UNIQUE (draft_number);


--
-- Name: finance_debit_voucher finance_debit_voucher_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_debit_voucher
    ADD CONSTRAINT finance_debit_voucher_pkey PRIMARY KEY (id);


--
-- Name: finance_debit_voucher finance_debit_voucher_transfer_number_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_debit_voucher
    ADD CONSTRAINT finance_debit_voucher_transfer_number_key UNIQUE (transfer_number);


--
-- Name: finance_financial_year finance_financial_year_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_financial_year
    ADD CONSTRAINT finance_financial_year_auto_id_key UNIQUE (auto_id);


--
-- Name: finance_financial_year finance_financial_year_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_financial_year
    ADD CONSTRAINT finance_financial_year_pkey PRIMARY KEY (id);


--
-- Name: finance_journal_voucher finance_journal_voucher_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_journal_voucher
    ADD CONSTRAINT finance_journal_voucher_auto_id_key UNIQUE (auto_id);


--
-- Name: finance_journal_voucher_item finance_journal_voucher_item_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_journal_voucher_item
    ADD CONSTRAINT finance_journal_voucher_item_pkey PRIMARY KEY (id);


--
-- Name: finance_journal_voucher finance_journal_voucher_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_journal_voucher
    ADD CONSTRAINT finance_journal_voucher_pkey PRIMARY KEY (id);


--
-- Name: finance_journal_voucher finance_journal_voucher_voucher_number_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_journal_voucher
    ADD CONSTRAINT finance_journal_voucher_voucher_number_key UNIQUE (voucher_number);


--
-- Name: finance_payment_voucher finance_payment_voucher_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_payment_voucher
    ADD CONSTRAINT finance_payment_voucher_auto_id_key UNIQUE (auto_id);


--
-- Name: finance_payment_voucher finance_payment_voucher_cheque_number_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_payment_voucher
    ADD CONSTRAINT finance_payment_voucher_cheque_number_key UNIQUE (cheque_number);


--
-- Name: finance_payment_voucher finance_payment_voucher_draft_number_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_payment_voucher
    ADD CONSTRAINT finance_payment_voucher_draft_number_key UNIQUE (draft_number);


--
-- Name: finance_payment_voucher finance_payment_voucher_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_payment_voucher
    ADD CONSTRAINT finance_payment_voucher_pkey PRIMARY KEY (id);


--
-- Name: finance_payment_voucher finance_payment_voucher_transfer_number_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_payment_voucher
    ADD CONSTRAINT finance_payment_voucher_transfer_number_key UNIQUE (transfer_number);


--
-- Name: finance_receipt_voucher finance_receipt_voucher_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_receipt_voucher
    ADD CONSTRAINT finance_receipt_voucher_auto_id_key UNIQUE (auto_id);


--
-- Name: finance_receipt_voucher finance_receipt_voucher_cheque_number_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_receipt_voucher
    ADD CONSTRAINT finance_receipt_voucher_cheque_number_key UNIQUE (cheque_number);


--
-- Name: finance_receipt_voucher finance_receipt_voucher_draft_number_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_receipt_voucher
    ADD CONSTRAINT finance_receipt_voucher_draft_number_key UNIQUE (draft_number);


--
-- Name: finance_receipt_voucher finance_receipt_voucher_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_receipt_voucher
    ADD CONSTRAINT finance_receipt_voucher_pkey PRIMARY KEY (id);


--
-- Name: finance_receipt_voucher finance_receipt_voucher_transfer_number_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_receipt_voucher
    ADD CONSTRAINT finance_receipt_voucher_transfer_number_key UNIQUE (transfer_number);


--
-- Name: finance_subledger_opening finance_subledger_opening_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_subledger_opening
    ADD CONSTRAINT finance_subledger_opening_auto_id_key UNIQUE (auto_id);


--
-- Name: finance_subledger_opening finance_subledger_opening_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_subledger_opening
    ADD CONSTRAINT finance_subledger_opening_pkey PRIMARY KEY (id);


--
-- Name: general_batch general_batch_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.general_batch
    ADD CONSTRAINT general_batch_auto_id_key UNIQUE (auto_id);


--
-- Name: general_batch general_batch_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.general_batch
    ADD CONSTRAINT general_batch_pkey PRIMARY KEY (id);


--
-- Name: general_charge_per_kilometer general_charge_per_kilometer_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.general_charge_per_kilometer
    ADD CONSTRAINT general_charge_per_kilometer_pkey PRIMARY KEY (id);


--
-- Name: general_charge_setting general_charge_setting_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.general_charge_setting
    ADD CONSTRAINT general_charge_setting_pkey PRIMARY KEY (id);


--
-- Name: general_charge_setting general_charge_setting_vendor_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.general_charge_setting
    ADD CONSTRAINT general_charge_setting_vendor_id_key UNIQUE (vendor_id);


--
-- Name: general_charge_setting general_charge_setting_warehouse_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.general_charge_setting
    ADD CONSTRAINT general_charge_setting_warehouse_id_key UNIQUE (warehouse_id);


--
-- Name: general_damaged_product general_damaged_product_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.general_damaged_product
    ADD CONSTRAINT general_damaged_product_auto_id_key UNIQUE (auto_id);


--
-- Name: general_damaged_product general_damaged_product_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.general_damaged_product
    ADD CONSTRAINT general_damaged_product_pkey PRIMARY KEY (id);


--
-- Name: general_delivery_charge general_delivery_charge_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.general_delivery_charge
    ADD CONSTRAINT general_delivery_charge_pkey PRIMARY KEY (id);


--
-- Name: invoic_prefix invoic_prefix_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.invoic_prefix
    ADD CONSTRAINT invoic_prefix_auto_id_key UNIQUE (auto_id);


--
-- Name: invoic_prefix invoic_prefix_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.invoic_prefix
    ADD CONSTRAINT invoic_prefix_pkey PRIMARY KEY (id);


--
-- Name: invoice_design invoice_design_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.invoice_design
    ADD CONSTRAINT invoice_design_auto_id_key UNIQUE (auto_id);


--
-- Name: invoice_design invoice_design_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.invoice_design
    ADD CONSTRAINT invoice_design_pkey PRIMARY KEY (id);


--
-- Name: location location_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.location
    ADD CONSTRAINT location_auto_id_key UNIQUE (auto_id);


--
-- Name: location location_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.location
    ADD CONSTRAINT location_pkey PRIMARY KEY (id);


--
-- Name: mode mode_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.mode
    ADD CONSTRAINT mode_pkey PRIMARY KEY (id);


--
-- Name: offers offers_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_auto_id_key UNIQUE (auto_id);


--
-- Name: offers offers_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_pkey PRIMARY KEY (id);


--
-- Name: offers_vouchercode offers_vouchercode_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.offers_vouchercode
    ADD CONSTRAINT offers_vouchercode_auto_id_key UNIQUE (auto_id);


--
-- Name: offers_vouchercode offers_vouchercode_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.offers_vouchercode
    ADD CONSTRAINT offers_vouchercode_pkey PRIMARY KEY (id);


--
-- Name: offers_vouchercode_used_users offers_vouchercode_used__vouchercode_id_user_id_c1433d1a_uniq; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.offers_vouchercode_used_users
    ADD CONSTRAINT offers_vouchercode_used__vouchercode_id_user_id_c1433d1a_uniq UNIQUE (vouchercode_id, user_id);


--
-- Name: offers_vouchercode_used_users offers_vouchercode_used_users_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.offers_vouchercode_used_users
    ADD CONSTRAINT offers_vouchercode_used_users_pkey PRIMARY KEY (id);


--
-- Name: orders_booking orders_booking_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.orders_booking
    ADD CONSTRAINT orders_booking_pkey PRIMARY KEY (id);


--
-- Name: orders_orderitem orders_orderitem_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.orders_orderitem
    ADD CONSTRAINT orders_orderitem_pkey PRIMARY KEY (id);


--
-- Name: orders_orders orders_orders_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.orders_orders
    ADD CONSTRAINT orders_orders_auto_id_key UNIQUE (auto_id);


--
-- Name: orders_orders orders_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.orders_orders
    ADD CONSTRAINT orders_orders_pkey PRIMARY KEY (id);


--
-- Name: orders_timeslot orders_timeslot_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.orders_timeslot
    ADD CONSTRAINT orders_timeslot_auto_id_key UNIQUE (auto_id);


--
-- Name: orders_timeslot orders_timeslot_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.orders_timeslot
    ADD CONSTRAINT orders_timeslot_pkey PRIMARY KEY (id);


--
-- Name: permission permission_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.permission
    ADD CONSTRAINT permission_pkey PRIMARY KEY (id);


--
-- Name: privilege_point_history privilege_point_history_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.privilege_point_history
    ADD CONSTRAINT privilege_point_history_pkey PRIMARY KEY (id);


--
-- Name: privilege_points privilege_points_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.privilege_points
    ADD CONSTRAINT privilege_points_auto_id_key UNIQUE (auto_id);


--
-- Name: privilege_points privilege_points_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.privilege_points
    ADD CONSTRAINT privilege_points_pkey PRIMARY KEY (id);


--
-- Name: product_hsn_code product_hsn_code_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.product_hsn_code
    ADD CONSTRAINT product_hsn_code_auto_id_key UNIQUE (auto_id);


--
-- Name: product_hsn_code product_hsn_code_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.product_hsn_code
    ADD CONSTRAINT product_hsn_code_pkey PRIMARY KEY (id);


--
-- Name: product_stock product_stock_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.product_stock
    ADD CONSTRAINT product_stock_pkey PRIMARY KEY (id);


--
-- Name: product_variation_type product_variation_type_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.product_variation_type
    ADD CONSTRAINT product_variation_type_pkey PRIMARY KEY (id);


--
-- Name: products_brand products_brand_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_brand
    ADD CONSTRAINT products_brand_auto_id_key UNIQUE (auto_id);


--
-- Name: products_brand products_brand_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_brand
    ADD CONSTRAINT products_brand_pkey PRIMARY KEY (id);


--
-- Name: products_category products_category_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_category
    ADD CONSTRAINT products_category_auto_id_key UNIQUE (auto_id);


--
-- Name: products_category products_category_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_category
    ADD CONSTRAINT products_category_pkey PRIMARY KEY (id);


--
-- Name: products_product products_product_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_product
    ADD CONSTRAINT products_product_auto_id_key UNIQUE (auto_id);


--
-- Name: products_product_image products_product_image_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_product_image
    ADD CONSTRAINT products_product_image_auto_id_key UNIQUE (auto_id);


--
-- Name: products_product_image products_product_image_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_product_image
    ADD CONSTRAINT products_product_image_pkey PRIMARY KEY (id);


--
-- Name: products_product products_product_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_product
    ADD CONSTRAINT products_product_pkey PRIMARY KEY (id);


--
-- Name: products_product_variant products_product_variant_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_product_variant
    ADD CONSTRAINT products_product_variant_auto_id_key UNIQUE (auto_id);


--
-- Name: products_product_variant products_product_variant_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_product_variant
    ADD CONSTRAINT products_product_variant_pkey PRIMARY KEY (id);


--
-- Name: products_product_variant products_product_variant_product_code_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_product_variant
    ADD CONSTRAINT products_product_variant_product_code_key UNIQUE (product_code);


--
-- Name: products_special_category products_special_category_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_special_category
    ADD CONSTRAINT products_special_category_auto_id_key UNIQUE (auto_id);


--
-- Name: products_special_category products_special_category_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_special_category
    ADD CONSTRAINT products_special_category_pkey PRIMARY KEY (id);


--
-- Name: products_sub_category products_sub_category_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_sub_category
    ADD CONSTRAINT products_sub_category_auto_id_key UNIQUE (auto_id);


--
-- Name: products_sub_category products_sub_category_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_sub_category
    ADD CONSTRAINT products_sub_category_pkey PRIMARY KEY (id);


--
-- Name: products_unit products_unit_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_unit
    ADD CONSTRAINT products_unit_auto_id_key UNIQUE (auto_id);


--
-- Name: products_unit_measurement products_unit_measurement_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_unit_measurement
    ADD CONSTRAINT products_unit_measurement_auto_id_key UNIQUE (auto_id);


--
-- Name: products_unit_measurement products_unit_measurement_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_unit_measurement
    ADD CONSTRAINT products_unit_measurement_pkey PRIMARY KEY (id);


--
-- Name: products_unit products_unit_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_unit
    ADD CONSTRAINT products_unit_pkey PRIMARY KEY (id);


--
-- Name: purchase purchase_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT purchase_auto_id_key UNIQUE (auto_id);


--
-- Name: purchase_item purchase_item_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase_item
    ADD CONSTRAINT purchase_item_pkey PRIMARY KEY (id);


--
-- Name: purchase_order purchase_order_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase_order
    ADD CONSTRAINT purchase_order_auto_id_key UNIQUE (auto_id);


--
-- Name: purchase_order_item purchase_order_item_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase_order_item
    ADD CONSTRAINT purchase_order_item_pkey PRIMARY KEY (id);


--
-- Name: purchase_order purchase_order_order_no_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase_order
    ADD CONSTRAINT purchase_order_order_no_key UNIQUE (order_no);


--
-- Name: purchase_order purchase_order_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase_order
    ADD CONSTRAINT purchase_order_pkey PRIMARY KEY (id);


--
-- Name: purchase_order purchase_order_purchase_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase_order
    ADD CONSTRAINT purchase_order_purchase_id_key UNIQUE (purchase_id);


--
-- Name: purchase purchase_payment_voucher_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT purchase_payment_voucher_id_key UNIQUE (payment_voucher_id);


--
-- Name: purchase purchase_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT purchase_pkey PRIMARY KEY (id);


--
-- Name: purchase_return purchase_return_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase_return
    ADD CONSTRAINT purchase_return_auto_id_key UNIQUE (auto_id);


--
-- Name: purchase_return_item purchase_return_item_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase_return_item
    ADD CONSTRAINT purchase_return_item_pkey PRIMARY KEY (id);


--
-- Name: purchase_return purchase_return_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase_return
    ADD CONSTRAINT purchase_return_pkey PRIMARY KEY (id);


--
-- Name: registration_registrationprofile registration_registrationprofile_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.registration_registrationprofile
    ADD CONSTRAINT registration_registrationprofile_pkey PRIMARY KEY (id);


--
-- Name: registration_registrationprofile registration_registrationprofile_user_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.registration_registrationprofile
    ADD CONSTRAINT registration_registrationprofile_user_id_key UNIQUE (user_id);


--
-- Name: registration_supervisedregistrationprofile registration_supervisedregistrationprofile_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.registration_supervisedregistrationprofile
    ADD CONSTRAINT registration_supervisedregistrationprofile_pkey PRIMARY KEY (registrationprofile_ptr_id);


--
-- Name: return_images return_images_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.return_images
    ADD CONSTRAINT return_images_auto_id_key UNIQUE (auto_id);


--
-- Name: return_images return_images_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.return_images
    ADD CONSTRAINT return_images_pkey PRIMARY KEY (id);


--
-- Name: salary_pay salary_pay_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.salary_pay
    ADD CONSTRAINT salary_pay_auto_id_key UNIQUE (auto_id);


--
-- Name: salary_pay salary_pay_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.salary_pay
    ADD CONSTRAINT salary_pay_pkey PRIMARY KEY (id);


--
-- Name: sale_return sale_return_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.sale_return
    ADD CONSTRAINT sale_return_auto_id_key UNIQUE (auto_id);


--
-- Name: sale_return_item sale_return_item_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.sale_return_item
    ADD CONSTRAINT sale_return_item_pkey PRIMARY KEY (id);


--
-- Name: sale_return sale_return_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.sale_return
    ADD CONSTRAINT sale_return_pkey PRIMARY KEY (id);


--
-- Name: sales sales_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_auto_id_key UNIQUE (auto_id);


--
-- Name: sales sales_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_pkey PRIMARY KEY (id);


--
-- Name: sales sales_receipt_voucher_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_receipt_voucher_id_key UNIQUE (receipt_voucher_id);


--
-- Name: sales_sale_item sales_sale_item_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.sales_sale_item
    ADD CONSTRAINT sales_sale_item_pkey PRIMARY KEY (id);


--
-- Name: sales sales_tracking_no_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_tracking_no_key UNIQUE (tracking_no);


--
-- Name: setting setting_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.setting
    ADD CONSTRAINT setting_pkey PRIMARY KEY (id);


--
-- Name: special_variant special_variant_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.special_variant
    ADD CONSTRAINT special_variant_auto_id_key UNIQUE (auto_id);


--
-- Name: special_variant special_variant_created_variant_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.special_variant
    ADD CONSTRAINT special_variant_created_variant_id_key UNIQUE (created_variant_id);


--
-- Name: special_variant special_variant_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.special_variant
    ADD CONSTRAINT special_variant_pkey PRIMARY KEY (id);


--
-- Name: special_variant_product_variant special_variant_product__specialvariant_id_produc_fef7f0ba_uniq; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.special_variant_product_variant
    ADD CONSTRAINT special_variant_product__specialvariant_id_produc_fef7f0ba_uniq UNIQUE (specialvariant_id, productvariant_id);


--
-- Name: special_variant_product_variant special_variant_product_variant_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.special_variant_product_variant
    ADD CONSTRAINT special_variant_product_variant_pkey PRIMARY KEY (id);


--
-- Name: staff_attendence staff_attendence_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.staff_attendence
    ADD CONSTRAINT staff_attendence_auto_id_key UNIQUE (auto_id);


--
-- Name: staff_attendence staff_attendence_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.staff_attendence
    ADD CONSTRAINT staff_attendence_pkey PRIMARY KEY (id);


--
-- Name: staff staff_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_auto_id_key UNIQUE (auto_id);


--
-- Name: staff_permission staff_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.staff_permission
    ADD CONSTRAINT staff_permission_pkey PRIMARY KEY (id);


--
-- Name: staff_permission staff_permission_staff_id_permission_id_d3367742_uniq; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.staff_permission
    ADD CONSTRAINT staff_permission_staff_id_permission_id_d3367742_uniq UNIQUE (staff_id, permission_id);


--
-- Name: staff staff_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_pkey PRIMARY KEY (id);


--
-- Name: staff_salary_allowance staff_salary_allowance_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.staff_salary_allowance
    ADD CONSTRAINT staff_salary_allowance_auto_id_key UNIQUE (auto_id);


--
-- Name: staff_salary_allowance staff_salary_allowance_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.staff_salary_allowance
    ADD CONSTRAINT staff_salary_allowance_pkey PRIMARY KEY (id);


--
-- Name: staff staff_user_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_user_id_key UNIQUE (user_id);


--
-- Name: stock_transfer stock_transfer_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.stock_transfer
    ADD CONSTRAINT stock_transfer_auto_id_key UNIQUE (auto_id);


--
-- Name: stock_transfer_items stock_transfer_items_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.stock_transfer_items
    ADD CONSTRAINT stock_transfer_items_auto_id_key UNIQUE (auto_id);


--
-- Name: stock_transfer_items stock_transfer_items_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.stock_transfer_items
    ADD CONSTRAINT stock_transfer_items_pkey PRIMARY KEY (id);


--
-- Name: stock_transfer stock_transfer_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.stock_transfer
    ADD CONSTRAINT stock_transfer_pkey PRIMARY KEY (id);


--
-- Name: stock_update stock_update_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.stock_update
    ADD CONSTRAINT stock_update_auto_id_key UNIQUE (auto_id);


--
-- Name: stock_update_item stock_update_item_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.stock_update_item
    ADD CONSTRAINT stock_update_item_pkey PRIMARY KEY (id);


--
-- Name: stock_update stock_update_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.stock_update
    ADD CONSTRAINT stock_update_pkey PRIMARY KEY (id);


--
-- Name: students_registration_profile students_registration_profile_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.students_registration_profile
    ADD CONSTRAINT students_registration_profile_auto_id_key UNIQUE (auto_id);


--
-- Name: students_registration_profile students_registration_profile_phone_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.students_registration_profile
    ADD CONSTRAINT students_registration_profile_phone_key UNIQUE (phone);


--
-- Name: students_registration_profile students_registration_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.students_registration_profile
    ADD CONSTRAINT students_registration_profile_pkey PRIMARY KEY (id);


--
-- Name: students_registration_profile students_registration_profile_user_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.students_registration_profile
    ADD CONSTRAINT students_registration_profile_user_id_key UNIQUE (user_id);


--
-- Name: suppliers_supplier suppliers_supplier_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.suppliers_supplier
    ADD CONSTRAINT suppliers_supplier_auto_id_key UNIQUE (auto_id);


--
-- Name: suppliers_supplier suppliers_supplier_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.suppliers_supplier
    ADD CONSTRAINT suppliers_supplier_pkey PRIMARY KEY (id);


--
-- Name: suppliers_supplier suppliers_supplier_user_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.suppliers_supplier
    ADD CONSTRAINT suppliers_supplier_user_id_key UNIQUE (user_id);


--
-- Name: techpe_staff_record techpe_staff_record_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.techpe_staff_record
    ADD CONSTRAINT techpe_staff_record_auto_id_key UNIQUE (auto_id);


--
-- Name: techpe_staff_record techpe_staff_record_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.techpe_staff_record
    ADD CONSTRAINT techpe_staff_record_pkey PRIMARY KEY (id);


--
-- Name: tickets tickets_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_auto_id_key UNIQUE (auto_id);


--
-- Name: tickets tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (id);


--
-- Name: users_cartitem users_cartitem_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.users_cartitem
    ADD CONSTRAINT users_cartitem_pkey PRIMARY KEY (id);


--
-- Name: users_notification users_notification_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.users_notification
    ADD CONSTRAINT users_notification_pkey PRIMARY KEY (id);


--
-- Name: users_notification_subject users_notification_subject_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.users_notification_subject
    ADD CONSTRAINT users_notification_subject_pkey PRIMARY KEY (id);


--
-- Name: users_user_login users_user_login_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.users_user_login
    ADD CONSTRAINT users_user_login_auto_id_key UNIQUE (auto_id);


--
-- Name: users_user_login users_user_login_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.users_user_login
    ADD CONSTRAINT users_user_login_pkey PRIMARY KEY (id);


--
-- Name: users_wishlistitem users_wishlistitem_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.users_wishlistitem
    ADD CONSTRAINT users_wishlistitem_pkey PRIMARY KEY (id);


--
-- Name: vendors_commission vendors_commission_order_item_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.vendors_commission
    ADD CONSTRAINT vendors_commission_order_item_id_key UNIQUE (order_item_id);


--
-- Name: vendors_commission vendors_commission_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.vendors_commission
    ADD CONSTRAINT vendors_commission_pkey PRIMARY KEY (id);


--
-- Name: vendors_vendor vendors_vendor_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.vendors_vendor
    ADD CONSTRAINT vendors_vendor_auto_id_key UNIQUE (auto_id);


--
-- Name: vendors_vendor_deliverable_location vendors_vendor_deliverab_vendor_id_zone_id_7a5c856b_uniq; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.vendors_vendor_deliverable_location
    ADD CONSTRAINT vendors_vendor_deliverab_vendor_id_zone_id_7a5c856b_uniq UNIQUE (vendor_id, zone_id);


--
-- Name: vendors_vendor_deliverable_location vendors_vendor_deliverable_location_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.vendors_vendor_deliverable_location
    ADD CONSTRAINT vendors_vendor_deliverable_location_pkey PRIMARY KEY (id);


--
-- Name: vendors_vendor vendors_vendor_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.vendors_vendor
    ADD CONSTRAINT vendors_vendor_pkey PRIMARY KEY (id);


--
-- Name: vendors_vendor vendors_vendor_user_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.vendors_vendor
    ADD CONSTRAINT vendors_vendor_user_id_key UNIQUE (user_id);


--
-- Name: warehouse warehouse_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.warehouse
    ADD CONSTRAINT warehouse_auto_id_key UNIQUE (auto_id);


--
-- Name: warehouse_deliverable_location warehouse_deliverable_lo_warehouse_id_zone_id_6dd39396_uniq; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.warehouse_deliverable_location
    ADD CONSTRAINT warehouse_deliverable_lo_warehouse_id_zone_id_6dd39396_uniq UNIQUE (warehouse_id, zone_id);


--
-- Name: warehouse_deliverable_location warehouse_deliverable_location_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.warehouse_deliverable_location
    ADD CONSTRAINT warehouse_deliverable_location_pkey PRIMARY KEY (id);


--
-- Name: warehouse_no_express_delivery warehouse_no_express_del_warehouse_id_zone_id_b26544b7_uniq; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.warehouse_no_express_delivery
    ADD CONSTRAINT warehouse_no_express_del_warehouse_id_zone_id_b26544b7_uniq UNIQUE (warehouse_id, zone_id);


--
-- Name: warehouse_no_express_delivery warehouse_no_express_delivery_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.warehouse_no_express_delivery
    ADD CONSTRAINT warehouse_no_express_delivery_pkey PRIMARY KEY (id);


--
-- Name: warehouse warehouse_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.warehouse
    ADD CONSTRAINT warehouse_pkey PRIMARY KEY (id);


--
-- Name: web_FeauturedCategory web_FeauturedCategory_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public."web_FeauturedCategory"
    ADD CONSTRAINT "web_FeauturedCategory_auto_id_key" UNIQUE (auto_id);


--
-- Name: web_FeauturedCategory web_FeauturedCategory_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public."web_FeauturedCategory"
    ADD CONSTRAINT "web_FeauturedCategory_pkey" PRIMARY KEY (id);


--
-- Name: web_TrendingCategory web_TrendingCategory_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public."web_TrendingCategory"
    ADD CONSTRAINT "web_TrendingCategory_auto_id_key" UNIQUE (auto_id);


--
-- Name: web_TrendingCategory web_TrendingCategory_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public."web_TrendingCategory"
    ADD CONSTRAINT "web_TrendingCategory_pkey" PRIMARY KEY (id);


--
-- Name: web_productreturn web_productreturn_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.web_productreturn
    ADD CONSTRAINT web_productreturn_auto_id_key UNIQUE (auto_id);


--
-- Name: web_productreturn web_productreturn_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.web_productreturn
    ADD CONSTRAINT web_productreturn_pkey PRIMARY KEY (id);


--
-- Name: web_productreview web_productreview_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.web_productreview
    ADD CONSTRAINT web_productreview_auto_id_key UNIQUE (auto_id);


--
-- Name: web_productreview web_productreview_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.web_productreview
    ADD CONSTRAINT web_productreview_pkey PRIMARY KEY (id);


--
-- Name: web_sociallinks web_sociallinks_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.web_sociallinks
    ADD CONSTRAINT web_sociallinks_pkey PRIMARY KEY (id);


--
-- Name: web_spotlightbanner web_spotlightbanner_auto_id_key; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.web_spotlightbanner
    ADD CONSTRAINT web_spotlightbanner_auto_id_key UNIQUE (auto_id);


--
-- Name: web_spotlightbanner web_spotlightbanner_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.web_spotlightbanner
    ADD CONSTRAINT web_spotlightbanner_pkey PRIMARY KEY (id);


--
-- Name: zone zone_pkey; Type: CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.zone
    ADD CONSTRAINT zone_pkey PRIMARY KEY (id);


--
-- Name: app_update_date_added_b012093d; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX app_update_date_added_b012093d ON public.app_update USING btree (date_added);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: customer_bank_account_customer_id_e0de9b6a; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX customer_bank_account_customer_id_e0de9b6a ON public.customer_bank_account USING btree (customer_id);


--
-- Name: customer_bank_account_date_added_eae44918; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX customer_bank_account_date_added_eae44918 ON public.customer_bank_account USING btree (date_added);


--
-- Name: customers_customer_creator_id_1476a573; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX customers_customer_creator_id_1476a573 ON public.customers_customer USING btree (creator_id);


--
-- Name: customers_customer_date_added_954ee64a; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX customers_customer_date_added_954ee64a ON public.customers_customer USING btree (date_added);


--
-- Name: customers_customer_updater_id_fb08982a; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX customers_customer_updater_id_fb08982a ON public.customers_customer USING btree (updater_id);


--
-- Name: customers_customeraddress_customer_id_17a361bc; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX customers_customeraddress_customer_id_17a361bc ON public.customers_customeraddress USING btree (customer_id);


--
-- Name: customers_customeraddress_date_added_c17c45b9; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX customers_customeraddress_date_added_c17c45b9 ON public.customers_customeraddress USING btree (date_added);


--
-- Name: customers_customeraddress_location_id_17fe4522; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX customers_customeraddress_location_id_17fe4522 ON public.customers_customeraddress USING btree (location_id);


--
-- Name: customers_customeraddress_zone_id_c8ddc8d9; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX customers_customeraddress_zone_id_c8ddc8d9 ON public.customers_customeraddress USING btree (zone_id);


--
-- Name: deal_of_day_creator_id_9f340a2e; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX deal_of_day_creator_id_9f340a2e ON public.deal_of_day USING btree (creator_id);


--
-- Name: deal_of_day_date_added_59a923e4; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX deal_of_day_date_added_59a923e4 ON public.deal_of_day USING btree (date_added);


--
-- Name: deal_of_day_product_variant_id_114ec7a8; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX deal_of_day_product_variant_id_114ec7a8 ON public.deal_of_day USING btree (product_variant_id);


--
-- Name: deal_of_day_updater_id_ab1a7149; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX deal_of_day_updater_id_ab1a7149 ON public.deal_of_day USING btree (updater_id);


--
-- Name: deal_of_day_warehouse_id_e854bd5b; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX deal_of_day_warehouse_id_e854bd5b ON public.deal_of_day USING btree (warehouse_id);


--
-- Name: delivery_agent_collectedpa_delivery_agent_id_2c44ae37; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX delivery_agent_collectedpa_delivery_agent_id_2c44ae37 ON public.delivery_agent_collectedpaymentregister USING btree (delivery_agent_id);


--
-- Name: delivery_agent_collectedpaymentregister_creator_id_6a7cf32c; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX delivery_agent_collectedpaymentregister_creator_id_6a7cf32c ON public.delivery_agent_collectedpaymentregister USING btree (creator_id);


--
-- Name: delivery_agent_collectedpaymentregister_date_added_19a0b463; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX delivery_agent_collectedpaymentregister_date_added_19a0b463 ON public.delivery_agent_collectedpaymentregister USING btree (date_added);


--
-- Name: delivery_agent_collectedpaymentregister_updater_id_59b31cf8; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX delivery_agent_collectedpaymentregister_updater_id_59b31cf8 ON public.delivery_agent_collectedpaymentregister USING btree (updater_id);


--
-- Name: delivery_agent_collectpayment_creator_id_64dd3e92; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX delivery_agent_collectpayment_creator_id_64dd3e92 ON public.delivery_agent_collectpayment USING btree (creator_id);


--
-- Name: delivery_agent_collectpayment_date_added_356a23ca; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX delivery_agent_collectpayment_date_added_356a23ca ON public.delivery_agent_collectpayment USING btree (date_added);


--
-- Name: delivery_agent_collectpayment_delivery_agent_id_98e4f1b0; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX delivery_agent_collectpayment_delivery_agent_id_98e4f1b0 ON public.delivery_agent_collectpayment USING btree (delivery_agent_id);


--
-- Name: delivery_agent_collectpayment_order_id_1b5c37ce; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX delivery_agent_collectpayment_order_id_1b5c37ce ON public.delivery_agent_collectpayment USING btree (order_id);


--
-- Name: delivery_agent_collectpayment_updater_id_e81c108d; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX delivery_agent_collectpayment_updater_id_e81c108d ON public.delivery_agent_collectpayment USING btree (updater_id);


--
-- Name: delivery_agent_delivery_agent_creator_id_b89a1128; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX delivery_agent_delivery_agent_creator_id_b89a1128 ON public.delivery_agent_delivery_agent USING btree (creator_id);


--
-- Name: delivery_agent_delivery_agent_date_added_a62d0da9; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX delivery_agent_delivery_agent_date_added_a62d0da9 ON public.delivery_agent_delivery_agent USING btree (date_added);


--
-- Name: delivery_agent_delivery_agent_updater_id_56431a33; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX delivery_agent_delivery_agent_updater_id_56431a33 ON public.delivery_agent_delivery_agent USING btree (updater_id);


--
-- Name: delivery_agent_delivery_agent_warehouse_id_d0be882a; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX delivery_agent_delivery_agent_warehouse_id_d0be882a ON public.delivery_agent_delivery_agent USING btree (warehouse_id);


--
-- Name: delivery_agent_deliveryrating_customer_id_11ff6f1d; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX delivery_agent_deliveryrating_customer_id_11ff6f1d ON public.delivery_agent_deliveryrating USING btree (customer_id);


--
-- Name: delivery_agent_deliveryrating_date_added_16905603; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX delivery_agent_deliveryrating_date_added_16905603 ON public.delivery_agent_deliveryrating USING btree (date_added);


--
-- Name: delivery_agent_deliveryrating_delivery_agent_id_849f8046; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX delivery_agent_deliveryrating_delivery_agent_id_849f8046 ON public.delivery_agent_deliveryrating USING btree (delivery_agent_id);


--
-- Name: delivery_agent_deliveryrating_order_id_3d114519; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX delivery_agent_deliveryrating_order_id_3d114519 ON public.delivery_agent_deliveryrating USING btree (order_id);


--
-- Name: delivery_agent_travel_date_added_5042f482; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX delivery_agent_travel_date_added_5042f482 ON public.delivery_agent_travel USING btree (date_added);


--
-- Name: delivery_agent_travel_delivery_agent_id_f59da55f; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX delivery_agent_travel_delivery_agent_id_f59da55f ON public.delivery_agent_travel USING btree (delivery_agent_id);


--
-- Name: delivery_agent_travel_delivery_trip_id_3f5b0d44; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX delivery_agent_travel_delivery_trip_id_3f5b0d44 ON public.delivery_agent_travel USING btree (delivery_trip_id);


--
-- Name: delivery_agent_travel_order_id_e94054aa; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX delivery_agent_travel_order_id_e94054aa ON public.delivery_agent_travel USING btree (order_id);


--
-- Name: delivery_agent_trip_date_added_9b941d6a; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX delivery_agent_trip_date_added_9b941d6a ON public.delivery_agent_trip USING btree (date_added);


--
-- Name: delivery_agent_trip_delivery_agent_id_fe4f4191; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX delivery_agent_trip_delivery_agent_id_fe4f4191 ON public.delivery_agent_trip USING btree (delivery_agent_id);


--
-- Name: delivery_agent_trip_start_time_53990404; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX delivery_agent_trip_start_time_53990404 ON public.delivery_agent_trip USING btree (start_time);


--
-- Name: delivery_app_update_date_added_e80559fb; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX delivery_app_update_date_added_e80559fb ON public.delivery_app_update USING btree (date_added);


--
-- Name: designation_creator_id_4ad7c043; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX designation_creator_id_4ad7c043 ON public.designation USING btree (creator_id);


--
-- Name: designation_date_added_1cc78096; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX designation_date_added_1cc78096 ON public.designation USING btree (date_added);


--
-- Name: designation_updater_id_e24faf62; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX designation_updater_id_e24faf62 ON public.designation USING btree (updater_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: fcm_django__registr_dacdb2_idx; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX fcm_django__registr_dacdb2_idx ON public.fcm_django_fcmdevice USING btree (registration_id, user_id);


--
-- Name: fcm_django_fcmdevice_device_id_a9406c36; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX fcm_django_fcmdevice_device_id_a9406c36 ON public.fcm_django_fcmdevice USING btree (device_id);


--
-- Name: fcm_django_fcmdevice_registration_id_9918b353_like; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX fcm_django_fcmdevice_registration_id_9918b353_like ON public.fcm_django_fcmdevice USING btree (registration_id text_pattern_ops);


--
-- Name: fcm_django_fcmdevice_user_id_6cdfc0a2; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX fcm_django_fcmdevice_user_id_6cdfc0a2 ON public.fcm_django_fcmdevice USING btree (user_id);


--
-- Name: finance_account_group_creator_id_a96fc030; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_account_group_creator_id_a96fc030 ON public.finance_account_group USING btree (creator_id);


--
-- Name: finance_account_group_date_added_4c9741de; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_account_group_date_added_4c9741de ON public.finance_account_group USING btree (date_added);


--
-- Name: finance_account_group_updater_id_4b6f988b; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_account_group_updater_id_4b6f988b ON public.finance_account_group USING btree (updater_id);


--
-- Name: finance_account_head_account_group_id_321f5a9d; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_account_head_account_group_id_321f5a9d ON public.finance_account_head USING btree (account_group_id);


--
-- Name: finance_account_head_bank_account_id_39ea79a6; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_account_head_bank_account_id_39ea79a6 ON public.finance_account_head USING btree (bank_account_id);


--
-- Name: finance_account_head_creator_id_1eb4160e; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_account_head_creator_id_1eb4160e ON public.finance_account_head USING btree (creator_id);


--
-- Name: finance_account_head_date_added_d770d0e5; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_account_head_date_added_d770d0e5 ON public.finance_account_head USING btree (date_added);


--
-- Name: finance_account_head_opening_account_head_id_e4dc2463; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_account_head_opening_account_head_id_e4dc2463 ON public.finance_account_head_opening USING btree (account_head_id);


--
-- Name: finance_account_head_opening_creator_id_de6547fe; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_account_head_opening_creator_id_de6547fe ON public.finance_account_head_opening USING btree (creator_id);


--
-- Name: finance_account_head_opening_date_added_dfaf027c; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_account_head_opening_date_added_dfaf027c ON public.finance_account_head_opening USING btree (date_added);


--
-- Name: finance_account_head_opening_financial_year_id_81c820fb; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_account_head_opening_financial_year_id_81c820fb ON public.finance_account_head_opening USING btree (financial_year_id);


--
-- Name: finance_account_head_opening_updater_id_3d59963d; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_account_head_opening_updater_id_3d59963d ON public.finance_account_head_opening USING btree (updater_id);


--
-- Name: finance_account_head_opening_warehouse_id_38c376ec; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_account_head_opening_warehouse_id_38c376ec ON public.finance_account_head_opening USING btree (warehouse_id);


--
-- Name: finance_account_head_updater_id_9d210e1b; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_account_head_updater_id_9d210e1b ON public.finance_account_head USING btree (updater_id);


--
-- Name: finance_bank_account_creator_id_284c0ab7; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_bank_account_creator_id_284c0ab7 ON public.finance_bank_account USING btree (creator_id);


--
-- Name: finance_bank_account_date_added_c483fb9a; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_bank_account_date_added_c483fb9a ON public.finance_bank_account USING btree (date_added);


--
-- Name: finance_bank_account_updater_id_f839d86d; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_bank_account_updater_id_f839d86d ON public.finance_bank_account USING btree (updater_id);


--
-- Name: finance_bank_account_warehouse_id_d42963ee; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_bank_account_warehouse_id_d42963ee ON public.finance_bank_account USING btree (warehouse_id);


--
-- Name: finance_credit_voucher_bank_id_f319bb56; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_credit_voucher_bank_id_f319bb56 ON public.finance_credit_voucher USING btree (bank_id);


--
-- Name: finance_credit_voucher_creator_id_53bf998f; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_credit_voucher_creator_id_53bf998f ON public.finance_credit_voucher USING btree (creator_id);


--
-- Name: finance_credit_voucher_customer_id_121729e3; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_credit_voucher_customer_id_121729e3 ON public.finance_credit_voucher USING btree (customer_id);


--
-- Name: finance_credit_voucher_date_added_7b0d08f1; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_credit_voucher_date_added_7b0d08f1 ON public.finance_credit_voucher USING btree (date_added);


--
-- Name: finance_credit_voucher_financial_year_id_b2546424; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_credit_voucher_financial_year_id_b2546424 ON public.finance_credit_voucher USING btree (financial_year_id);


--
-- Name: finance_credit_voucher_sale_return_id_635b6e78; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_credit_voucher_sale_return_id_635b6e78 ON public.finance_credit_voucher USING btree (sale_return_id);


--
-- Name: finance_credit_voucher_updater_id_b37092ec; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_credit_voucher_updater_id_b37092ec ON public.finance_credit_voucher USING btree (updater_id);


--
-- Name: finance_credit_voucher_warehouse_id_34e0969b; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_credit_voucher_warehouse_id_34e0969b ON public.finance_credit_voucher USING btree (warehouse_id);


--
-- Name: finance_debit_voucher_bank_id_88c1d0bc; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_debit_voucher_bank_id_88c1d0bc ON public.finance_debit_voucher USING btree (bank_id);


--
-- Name: finance_debit_voucher_creator_id_43ff9a0f; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_debit_voucher_creator_id_43ff9a0f ON public.finance_debit_voucher USING btree (creator_id);


--
-- Name: finance_debit_voucher_date_added_8f1e87c6; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_debit_voucher_date_added_8f1e87c6 ON public.finance_debit_voucher USING btree (date_added);


--
-- Name: finance_debit_voucher_financial_year_id_a7e58d07; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_debit_voucher_financial_year_id_a7e58d07 ON public.finance_debit_voucher USING btree (financial_year_id);


--
-- Name: finance_debit_voucher_purchase_return_id_f30a1914; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_debit_voucher_purchase_return_id_f30a1914 ON public.finance_debit_voucher USING btree (purchase_return_id);


--
-- Name: finance_debit_voucher_supplier_id_65432f72; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_debit_voucher_supplier_id_65432f72 ON public.finance_debit_voucher USING btree (supplier_id);


--
-- Name: finance_debit_voucher_updater_id_a04e7319; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_debit_voucher_updater_id_a04e7319 ON public.finance_debit_voucher USING btree (updater_id);


--
-- Name: finance_debit_voucher_warehouse_id_4d484ffc; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_debit_voucher_warehouse_id_4d484ffc ON public.finance_debit_voucher USING btree (warehouse_id);


--
-- Name: finance_financial_year_creator_id_7496c62f; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_financial_year_creator_id_7496c62f ON public.finance_financial_year USING btree (creator_id);


--
-- Name: finance_financial_year_date_added_6df5402d; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_financial_year_date_added_6df5402d ON public.finance_financial_year USING btree (date_added);


--
-- Name: finance_financial_year_updater_id_e530114b; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_financial_year_updater_id_e530114b ON public.finance_financial_year USING btree (updater_id);


--
-- Name: finance_journal_voucher_creator_id_0a832a6e; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_journal_voucher_creator_id_0a832a6e ON public.finance_journal_voucher USING btree (creator_id);


--
-- Name: finance_journal_voucher_date_added_530a87d7; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_journal_voucher_date_added_530a87d7 ON public.finance_journal_voucher USING btree (date_added);


--
-- Name: finance_journal_voucher_financial_year_id_3a9afc1d; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_journal_voucher_financial_year_id_3a9afc1d ON public.finance_journal_voucher USING btree (financial_year_id);


--
-- Name: finance_journal_voucher_item_account_head_id_60bb56e9; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_journal_voucher_item_account_head_id_60bb56e9 ON public.finance_journal_voucher_item USING btree (account_head_id);


--
-- Name: finance_journal_voucher_item_journal_id_f4c0d941; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_journal_voucher_item_journal_id_f4c0d941 ON public.finance_journal_voucher_item USING btree (journal_id);


--
-- Name: finance_journal_voucher_item_warehouse_id_d1f399da; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_journal_voucher_item_warehouse_id_d1f399da ON public.finance_journal_voucher_item USING btree (warehouse_id);


--
-- Name: finance_journal_voucher_updater_id_2b87e133; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_journal_voucher_updater_id_2b87e133 ON public.finance_journal_voucher USING btree (updater_id);


--
-- Name: finance_payment_voucher_account_head_id_266b6c79; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_payment_voucher_account_head_id_266b6c79 ON public.finance_payment_voucher USING btree (account_head_id);


--
-- Name: finance_payment_voucher_bank_id_4cf952e3; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_payment_voucher_bank_id_4cf952e3 ON public.finance_payment_voucher USING btree (bank_id);


--
-- Name: finance_payment_voucher_creator_id_eaa19d07; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_payment_voucher_creator_id_eaa19d07 ON public.finance_payment_voucher USING btree (creator_id);


--
-- Name: finance_payment_voucher_date_added_72c0a35a; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_payment_voucher_date_added_72c0a35a ON public.finance_payment_voucher USING btree (date_added);


--
-- Name: finance_payment_voucher_financial_year_id_47131237; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_payment_voucher_financial_year_id_47131237 ON public.finance_payment_voucher USING btree (financial_year_id);


--
-- Name: finance_payment_voucher_updater_id_37b26034; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_payment_voucher_updater_id_37b26034 ON public.finance_payment_voucher USING btree (updater_id);


--
-- Name: finance_payment_voucher_warehouse_id_f9d89734; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_payment_voucher_warehouse_id_f9d89734 ON public.finance_payment_voucher USING btree (warehouse_id);


--
-- Name: finance_receipt_voucher_account_head_id_9c536327; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_receipt_voucher_account_head_id_9c536327 ON public.finance_receipt_voucher USING btree (account_head_id);


--
-- Name: finance_receipt_voucher_bank_id_f02521ee; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_receipt_voucher_bank_id_f02521ee ON public.finance_receipt_voucher USING btree (bank_id);


--
-- Name: finance_receipt_voucher_creator_id_afe023e4; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_receipt_voucher_creator_id_afe023e4 ON public.finance_receipt_voucher USING btree (creator_id);


--
-- Name: finance_receipt_voucher_date_added_294613a4; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_receipt_voucher_date_added_294613a4 ON public.finance_receipt_voucher USING btree (date_added);


--
-- Name: finance_receipt_voucher_financial_year_id_466dd990; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_receipt_voucher_financial_year_id_466dd990 ON public.finance_receipt_voucher USING btree (financial_year_id);


--
-- Name: finance_receipt_voucher_updater_id_d5ead95d; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_receipt_voucher_updater_id_d5ead95d ON public.finance_receipt_voucher USING btree (updater_id);


--
-- Name: finance_receipt_voucher_warehouse_id_eae17eaf; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_receipt_voucher_warehouse_id_eae17eaf ON public.finance_receipt_voucher USING btree (warehouse_id);


--
-- Name: finance_subledger_opening_account_head_id_840f0c30; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_subledger_opening_account_head_id_840f0c30 ON public.finance_subledger_opening USING btree (account_head_id);


--
-- Name: finance_subledger_opening_creator_id_4bfa2dcb; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_subledger_opening_creator_id_4bfa2dcb ON public.finance_subledger_opening USING btree (creator_id);


--
-- Name: finance_subledger_opening_date_added_117f7b4b; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_subledger_opening_date_added_117f7b4b ON public.finance_subledger_opening USING btree (date_added);


--
-- Name: finance_subledger_opening_financial_year_id_77d7eff4; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_subledger_opening_financial_year_id_77d7eff4 ON public.finance_subledger_opening USING btree (financial_year_id);


--
-- Name: finance_subledger_opening_updater_id_7a927cd8; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX finance_subledger_opening_updater_id_7a927cd8 ON public.finance_subledger_opening USING btree (updater_id);


--
-- Name: general_batch_creator_id_6ea88850; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX general_batch_creator_id_6ea88850 ON public.general_batch USING btree (creator_id);


--
-- Name: general_batch_date_added_dce9410f; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX general_batch_date_added_dce9410f ON public.general_batch USING btree (date_added);


--
-- Name: general_batch_product_id_20668ccd; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX general_batch_product_id_20668ccd ON public.general_batch USING btree (product_id);


--
-- Name: general_batch_product_variant_id_055f6acb; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX general_batch_product_variant_id_055f6acb ON public.general_batch USING btree (product_variant_id);


--
-- Name: general_batch_updater_id_b0d73f76; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX general_batch_updater_id_b0d73f76 ON public.general_batch USING btree (updater_id);


--
-- Name: general_batch_warehouse_id_9696d936; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX general_batch_warehouse_id_9696d936 ON public.general_batch USING btree (warehouse_id);


--
-- Name: general_damaged_product_batch_id_7eb10204; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX general_damaged_product_batch_id_7eb10204 ON public.general_damaged_product USING btree (batch_id);


--
-- Name: general_damaged_product_creator_id_2639440e; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX general_damaged_product_creator_id_2639440e ON public.general_damaged_product USING btree (creator_id);


--
-- Name: general_damaged_product_date_added_6b12d6c1; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX general_damaged_product_date_added_6b12d6c1 ON public.general_damaged_product USING btree (date_added);


--
-- Name: general_damaged_product_product_variant_id_4e9fbf30; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX general_damaged_product_product_variant_id_4e9fbf30 ON public.general_damaged_product USING btree (product_variant_id);


--
-- Name: general_damaged_product_updater_id_46cfb8dd; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX general_damaged_product_updater_id_46cfb8dd ON public.general_damaged_product USING btree (updater_id);


--
-- Name: general_damaged_product_warehouse_id_5ad29b00; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX general_damaged_product_warehouse_id_5ad29b00 ON public.general_damaged_product USING btree (warehouse_id);


--
-- Name: general_delivery_charge_to_zone_id_039dd59b; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX general_delivery_charge_to_zone_id_039dd59b ON public.general_delivery_charge USING btree (to_zone_id);


--
-- Name: general_delivery_charge_vendor_id_c4a38f7c; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX general_delivery_charge_vendor_id_c4a38f7c ON public.general_delivery_charge USING btree (vendor_id);


--
-- Name: general_delivery_charge_warehouse_id_443ee827; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX general_delivery_charge_warehouse_id_443ee827 ON public.general_delivery_charge USING btree (warehouse_id);


--
-- Name: invoic_prefix_creator_id_fa166727; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX invoic_prefix_creator_id_fa166727 ON public.invoic_prefix USING btree (creator_id);


--
-- Name: invoic_prefix_date_added_ffaa49cf; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX invoic_prefix_date_added_ffaa49cf ON public.invoic_prefix USING btree (date_added);


--
-- Name: invoic_prefix_financial_year_id_c0145277; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX invoic_prefix_financial_year_id_c0145277 ON public.invoic_prefix USING btree (financial_year_id);


--
-- Name: invoic_prefix_updater_id_aa0be792; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX invoic_prefix_updater_id_aa0be792 ON public.invoic_prefix USING btree (updater_id);


--
-- Name: invoice_design_creator_id_4a6b4885; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX invoice_design_creator_id_4a6b4885 ON public.invoice_design USING btree (creator_id);


--
-- Name: invoice_design_date_added_f87e017b; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX invoice_design_date_added_f87e017b ON public.invoice_design USING btree (date_added);


--
-- Name: invoice_design_updater_id_107cd5c0; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX invoice_design_updater_id_107cd5c0 ON public.invoice_design USING btree (updater_id);


--
-- Name: invoice_design_warehouse_id_3869b6ea; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX invoice_design_warehouse_id_3869b6ea ON public.invoice_design USING btree (warehouse_id);


--
-- Name: location_creator_id_0907a9b4; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX location_creator_id_0907a9b4 ON public.location USING btree (creator_id);


--
-- Name: location_date_added_16374d49; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX location_date_added_16374d49 ON public.location USING btree (date_added);


--
-- Name: location_updater_id_ca2da178; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX location_updater_id_ca2da178 ON public.location USING btree (updater_id);


--
-- Name: offers_category_id_5c4d6d5e; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX offers_category_id_5c4d6d5e ON public.offers USING btree (category_id);


--
-- Name: offers_creator_id_9bf8c888; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX offers_creator_id_9bf8c888 ON public.offers USING btree (creator_id);


--
-- Name: offers_date_added_a2b38a81; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX offers_date_added_a2b38a81 ON public.offers USING btree (date_added);


--
-- Name: offers_product_variant_id_58f87d65; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX offers_product_variant_id_58f87d65 ON public.offers USING btree (product_variant_id);


--
-- Name: offers_subcategory_id_931759be; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX offers_subcategory_id_931759be ON public.offers USING btree (subcategory_id);


--
-- Name: offers_updater_id_f49d637b; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX offers_updater_id_f49d637b ON public.offers USING btree (updater_id);


--
-- Name: offers_vouchercode_creator_id_80269e0d; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX offers_vouchercode_creator_id_80269e0d ON public.offers_vouchercode USING btree (creator_id);


--
-- Name: offers_vouchercode_customer_id_197cbef2; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX offers_vouchercode_customer_id_197cbef2 ON public.offers_vouchercode USING btree (customer_id);


--
-- Name: offers_vouchercode_date_added_8c556eb7; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX offers_vouchercode_date_added_8c556eb7 ON public.offers_vouchercode USING btree (date_added);


--
-- Name: offers_vouchercode_product_id_55258afe; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX offers_vouchercode_product_id_55258afe ON public.offers_vouchercode USING btree (product_id);


--
-- Name: offers_vouchercode_product_variant_id_123fc773; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX offers_vouchercode_product_variant_id_123fc773 ON public.offers_vouchercode USING btree (product_variant_id);


--
-- Name: offers_vouchercode_updater_id_0e238778; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX offers_vouchercode_updater_id_0e238778 ON public.offers_vouchercode USING btree (updater_id);


--
-- Name: offers_vouchercode_used_users_user_id_be265f61; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX offers_vouchercode_used_users_user_id_be265f61 ON public.offers_vouchercode_used_users USING btree (user_id);


--
-- Name: offers_vouchercode_used_users_vouchercode_id_6318e92e; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX offers_vouchercode_used_users_vouchercode_id_6318e92e ON public.offers_vouchercode_used_users USING btree (vouchercode_id);


--
-- Name: offers_warehouse_id_fc467b97; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX offers_warehouse_id_fc467b97 ON public.offers USING btree (warehouse_id);


--
-- Name: orders_booking_customer_id_34e64a17; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX orders_booking_customer_id_34e64a17 ON public.orders_booking USING btree (customer_id);


--
-- Name: orders_booking_date_added_0d978050; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX orders_booking_date_added_0d978050 ON public.orders_booking USING btree (date_added);


--
-- Name: orders_booking_order_id_19db7154; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX orders_booking_order_id_19db7154 ON public.orders_booking USING btree (order_id);


--
-- Name: orders_booking_product_variant_id_8e682975; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX orders_booking_product_variant_id_8e682975 ON public.orders_booking USING btree (product_variant_id);


--
-- Name: orders_orderitem_batch_id_04b36d63; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX orders_orderitem_batch_id_04b36d63 ON public.orders_orderitem USING btree (batch_id);


--
-- Name: orders_orderitem_date_added_05683813; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX orders_orderitem_date_added_05683813 ON public.orders_orderitem USING btree (date_added);


--
-- Name: orders_orderitem_order_id_fe61a34d; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX orders_orderitem_order_id_fe61a34d ON public.orders_orderitem USING btree (order_id);


--
-- Name: orders_orderitem_product_variant_id_148aec19; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX orders_orderitem_product_variant_id_148aec19 ON public.orders_orderitem USING btree (product_variant_id);


--
-- Name: orders_orders_creator_id_a00589be; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX orders_orders_creator_id_a00589be ON public.orders_orders USING btree (creator_id);


--
-- Name: orders_orders_customer_id_b5742c78; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX orders_orders_customer_id_b5742c78 ON public.orders_orders USING btree (customer_id);


--
-- Name: orders_orders_date_added_fec54455; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX orders_orders_date_added_fec54455 ON public.orders_orders USING btree (date_added);


--
-- Name: orders_orders_delivery_agent_id_c5706fa1; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX orders_orders_delivery_agent_id_c5706fa1 ON public.orders_orders USING btree (delivery_agent_id);


--
-- Name: orders_orders_prefix_id_c6c8bfa2; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX orders_orders_prefix_id_c6c8bfa2 ON public.orders_orders USING btree (prefix_id);


--
-- Name: orders_orders_receipt_voucher_id_6315824f; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX orders_orders_receipt_voucher_id_6315824f ON public.orders_orders USING btree (receipt_voucher_id);


--
-- Name: orders_orders_time_slot_id_5bc4f1bb; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX orders_orders_time_slot_id_5bc4f1bb ON public.orders_orders USING btree (time_slot_id);


--
-- Name: orders_orders_updater_id_9ee949cd; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX orders_orders_updater_id_9ee949cd ON public.orders_orders USING btree (updater_id);


--
-- Name: orders_orders_vendor_id_fb9bbaef; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX orders_orders_vendor_id_fb9bbaef ON public.orders_orders USING btree (vendor_id);


--
-- Name: orders_orders_warehouse_id_62f83e3f; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX orders_orders_warehouse_id_62f83e3f ON public.orders_orders USING btree (warehouse_id);


--
-- Name: orders_orders_zone_id_9e98a9e1; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX orders_orders_zone_id_9e98a9e1 ON public.orders_orders USING btree (zone_id);


--
-- Name: orders_timeslot_creator_id_2e465d6b; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX orders_timeslot_creator_id_2e465d6b ON public.orders_timeslot USING btree (creator_id);


--
-- Name: orders_timeslot_date_added_30842139; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX orders_timeslot_date_added_30842139 ON public.orders_timeslot USING btree (date_added);


--
-- Name: orders_timeslot_updater_id_e1e17907; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX orders_timeslot_updater_id_e1e17907 ON public.orders_timeslot USING btree (updater_id);


--
-- Name: privilege_point_history_customer_id_f28b1010; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX privilege_point_history_customer_id_f28b1010 ON public.privilege_point_history USING btree (customer_id);


--
-- Name: privilege_point_history_date_added_24cbd5c0; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX privilege_point_history_date_added_24cbd5c0 ON public.privilege_point_history USING btree (date_added);


--
-- Name: privilege_points_creator_id_e2ff39b1; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX privilege_points_creator_id_e2ff39b1 ON public.privilege_points USING btree (creator_id);


--
-- Name: privilege_points_date_added_e82d1328; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX privilege_points_date_added_e82d1328 ON public.privilege_points USING btree (date_added);


--
-- Name: privilege_points_updater_id_1cf14e45; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX privilege_points_updater_id_1cf14e45 ON public.privilege_points USING btree (updater_id);


--
-- Name: product_hsn_code_creator_id_c9ce9865; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX product_hsn_code_creator_id_c9ce9865 ON public.product_hsn_code USING btree (creator_id);


--
-- Name: product_hsn_code_date_added_365a6665; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX product_hsn_code_date_added_365a6665 ON public.product_hsn_code USING btree (date_added);


--
-- Name: product_hsn_code_unit_id_d76f5c9e; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX product_hsn_code_unit_id_d76f5c9e ON public.product_hsn_code USING btree (unit_id);


--
-- Name: product_hsn_code_updater_id_d41bd083; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX product_hsn_code_updater_id_d41bd083 ON public.product_hsn_code USING btree (updater_id);


--
-- Name: product_stock_batch_id_58af0926; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX product_stock_batch_id_58af0926 ON public.product_stock USING btree (batch_id);


--
-- Name: product_stock_product_variant_id_5eb9072a; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX product_stock_product_variant_id_5eb9072a ON public.product_stock USING btree (product_variant_id);


--
-- Name: product_stock_warehouse_id_6ab44a4b; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX product_stock_warehouse_id_6ab44a4b ON public.product_stock USING btree (warehouse_id);


--
-- Name: products_brand_creator_id_9af5a1d0; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_brand_creator_id_9af5a1d0 ON public.products_brand USING btree (creator_id);


--
-- Name: products_brand_date_added_1f2362c5; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_brand_date_added_1f2362c5 ON public.products_brand USING btree (date_added);


--
-- Name: products_brand_updater_id_476398fc; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_brand_updater_id_476398fc ON public.products_brand USING btree (updater_id);


--
-- Name: products_category_creator_id_b64be08e; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_category_creator_id_b64be08e ON public.products_category USING btree (creator_id);


--
-- Name: products_category_date_added_bf596973; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_category_date_added_bf596973 ON public.products_category USING btree (date_added);


--
-- Name: products_category_updater_id_d476cdeb; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_category_updater_id_d476cdeb ON public.products_category USING btree (updater_id);


--
-- Name: products_product_brand_id_3e2e8fd1; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_product_brand_id_3e2e8fd1 ON public.products_product USING btree (brand_id);


--
-- Name: products_product_category_id_9b594869; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_product_category_id_9b594869 ON public.products_product USING btree (category_id);


--
-- Name: products_product_creator_id_34c5af30; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_product_creator_id_34c5af30 ON public.products_product USING btree (creator_id);


--
-- Name: products_product_date_added_b8f7f1bd; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_product_date_added_b8f7f1bd ON public.products_product USING btree (date_added);


--
-- Name: products_product_hsn_id_5b962fea; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_product_hsn_id_5b962fea ON public.products_product USING btree (hsn_id);


--
-- Name: products_product_image_creator_id_14270e46; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_product_image_creator_id_14270e46 ON public.products_product_image USING btree (creator_id);


--
-- Name: products_product_image_date_added_c3a8b756; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_product_image_date_added_c3a8b756 ON public.products_product_image USING btree (date_added);


--
-- Name: products_product_image_product_variant_id_a98efec2; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_product_image_product_variant_id_a98efec2 ON public.products_product_image USING btree (product_variant_id);


--
-- Name: products_product_image_updater_id_18053b63; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_product_image_updater_id_18053b63 ON public.products_product_image USING btree (updater_id);


--
-- Name: products_product_special_category_id_0882a913; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_product_special_category_id_0882a913 ON public.products_product USING btree (special_category_id);


--
-- Name: products_product_subcategory_id_b28a1e3b; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_product_subcategory_id_b28a1e3b ON public.products_product USING btree (subcategory_id);


--
-- Name: products_product_unit_of_measurement_id_ab58e750; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_product_unit_of_measurement_id_ab58e750 ON public.products_product USING btree (unit_of_measurement_id);


--
-- Name: products_product_updater_id_fe83239f; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_product_updater_id_fe83239f ON public.products_product USING btree (updater_id);


--
-- Name: products_product_variant_colour_variation_id_315d48a6; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_product_variant_colour_variation_id_315d48a6 ON public.products_product_variant USING btree (colour_variation_id);


--
-- Name: products_product_variant_creator_id_dd4f67b2; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_product_variant_creator_id_dd4f67b2 ON public.products_product_variant USING btree (creator_id);


--
-- Name: products_product_variant_date_added_7ddca63d; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_product_variant_date_added_7ddca63d ON public.products_product_variant USING btree (date_added);


--
-- Name: products_product_variant_other_variation_id_c6323f0e; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_product_variant_other_variation_id_c6323f0e ON public.products_product_variant USING btree (other_variation_id);


--
-- Name: products_product_variant_product_code_fa241e46_like; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_product_variant_product_code_fa241e46_like ON public.products_product_variant USING btree (product_code varchar_pattern_ops);


--
-- Name: products_product_variant_product_id_f5ced6a1; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_product_variant_product_id_f5ced6a1 ON public.products_product_variant USING btree (product_id);


--
-- Name: products_product_variant_size_variation_id_455901a4; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_product_variant_size_variation_id_455901a4 ON public.products_product_variant USING btree (size_variation_id);


--
-- Name: products_product_variant_unit_id_4a7f296a; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_product_variant_unit_id_4a7f296a ON public.products_product_variant USING btree (unit_id);


--
-- Name: products_product_variant_updater_id_cbe07c07; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_product_variant_updater_id_cbe07c07 ON public.products_product_variant USING btree (updater_id);


--
-- Name: products_product_variant_warehouse_id_fde4c94d; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_product_variant_warehouse_id_fde4c94d ON public.products_product_variant USING btree (warehouse_id);


--
-- Name: products_product_vendor_id_4c43277c; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_product_vendor_id_4c43277c ON public.products_product USING btree (vendor_id);


--
-- Name: products_special_category_creator_id_3c1b6926; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_special_category_creator_id_3c1b6926 ON public.products_special_category USING btree (creator_id);


--
-- Name: products_special_category_date_added_3e2c77c9; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_special_category_date_added_3e2c77c9 ON public.products_special_category USING btree (date_added);


--
-- Name: products_special_category_updater_id_11b131a6; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_special_category_updater_id_11b131a6 ON public.products_special_category USING btree (updater_id);


--
-- Name: products_sub_category_category_id_6587a3a2; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_sub_category_category_id_6587a3a2 ON public.products_sub_category USING btree (category_id);


--
-- Name: products_sub_category_creator_id_27a63ae7; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_sub_category_creator_id_27a63ae7 ON public.products_sub_category USING btree (creator_id);


--
-- Name: products_sub_category_date_added_42974aa8; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_sub_category_date_added_42974aa8 ON public.products_sub_category USING btree (date_added);


--
-- Name: products_sub_category_updater_id_9052720c; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_sub_category_updater_id_9052720c ON public.products_sub_category USING btree (updater_id);


--
-- Name: products_unit_creator_id_8b6518e9; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_unit_creator_id_8b6518e9 ON public.products_unit USING btree (creator_id);


--
-- Name: products_unit_date_added_0910748d; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_unit_date_added_0910748d ON public.products_unit USING btree (date_added);


--
-- Name: products_unit_measurement_creator_id_26356ff1; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_unit_measurement_creator_id_26356ff1 ON public.products_unit_measurement USING btree (creator_id);


--
-- Name: products_unit_measurement_date_added_fcb5d0ce; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_unit_measurement_date_added_fcb5d0ce ON public.products_unit_measurement USING btree (date_added);


--
-- Name: products_unit_measurement_updater_id_d8e12c40; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_unit_measurement_updater_id_d8e12c40 ON public.products_unit_measurement USING btree (updater_id);


--
-- Name: products_unit_unit_of_measurement_id_a326b2ac; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_unit_unit_of_measurement_id_a326b2ac ON public.products_unit USING btree (unit_of_measurement_id);


--
-- Name: products_unit_updater_id_7f8d8a05; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX products_unit_updater_id_7f8d8a05 ON public.products_unit USING btree (updater_id);


--
-- Name: purchase_creator_id_63d20283; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX purchase_creator_id_63d20283 ON public.purchase USING btree (creator_id);


--
-- Name: purchase_date_added_680c220d; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX purchase_date_added_680c220d ON public.purchase USING btree (date_added);


--
-- Name: purchase_item_batch_id_07ed9f91; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX purchase_item_batch_id_07ed9f91 ON public.purchase_item USING btree (batch_id);


--
-- Name: purchase_item_product_variant_id_9d882c83; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX purchase_item_product_variant_id_9d882c83 ON public.purchase_item USING btree (product_variant_id);


--
-- Name: purchase_item_purchase_id_ae31d28e; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX purchase_item_purchase_id_ae31d28e ON public.purchase_item USING btree (purchase_id);


--
-- Name: purchase_order_creator_id_ab7196ed; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX purchase_order_creator_id_ab7196ed ON public.purchase_order USING btree (creator_id);


--
-- Name: purchase_order_date_added_43f7bd1c; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX purchase_order_date_added_43f7bd1c ON public.purchase_order USING btree (date_added);


--
-- Name: purchase_order_item_batch_id_6ac5076d; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX purchase_order_item_batch_id_6ac5076d ON public.purchase_order_item USING btree (batch_id);


--
-- Name: purchase_order_item_product_variant_id_a492e653; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX purchase_order_item_product_variant_id_a492e653 ON public.purchase_order_item USING btree (product_variant_id);


--
-- Name: purchase_order_item_purchase_order_id_acc6db73; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX purchase_order_item_purchase_order_id_acc6db73 ON public.purchase_order_item USING btree (purchase_order_id);


--
-- Name: purchase_order_supplier_id_f3ce40ee; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX purchase_order_supplier_id_f3ce40ee ON public.purchase_order USING btree (supplier_id);


--
-- Name: purchase_order_updater_id_507f1761; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX purchase_order_updater_id_507f1761 ON public.purchase_order USING btree (updater_id);


--
-- Name: purchase_order_warehouse_id_2bb9b357; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX purchase_order_warehouse_id_2bb9b357 ON public.purchase_order USING btree (warehouse_id);


--
-- Name: purchase_purchase_prefix_id_faca0061; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX purchase_purchase_prefix_id_faca0061 ON public.purchase USING btree (purchase_prefix_id);


--
-- Name: purchase_return_creator_id_6f14c0b2; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX purchase_return_creator_id_6f14c0b2 ON public.purchase_return USING btree (creator_id);


--
-- Name: purchase_return_date_added_07b3d9db; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX purchase_return_date_added_07b3d9db ON public.purchase_return USING btree (date_added);


--
-- Name: purchase_return_item_batch_id_f29045d2; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX purchase_return_item_batch_id_f29045d2 ON public.purchase_return_item USING btree (batch_id);


--
-- Name: purchase_return_item_product_id_c8dac44f; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX purchase_return_item_product_id_c8dac44f ON public.purchase_return_item USING btree (product_id);


--
-- Name: purchase_return_item_product_variant_id_3b06df43; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX purchase_return_item_product_variant_id_3b06df43 ON public.purchase_return_item USING btree (product_variant_id);


--
-- Name: purchase_return_item_purchase_item_id_0620450f; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX purchase_return_item_purchase_item_id_0620450f ON public.purchase_return_item USING btree (purchase_item_id);


--
-- Name: purchase_return_item_purchase_return_id_22f49d0e; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX purchase_return_item_purchase_return_id_22f49d0e ON public.purchase_return_item USING btree (purchase_return_id);


--
-- Name: purchase_return_purchase_id_b1b9da4e; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX purchase_return_purchase_id_b1b9da4e ON public.purchase_return USING btree (purchase_id);


--
-- Name: purchase_return_supplier_id_3b6c26db; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX purchase_return_supplier_id_3b6c26db ON public.purchase_return USING btree (supplier_id);


--
-- Name: purchase_return_updater_id_6cd3dd53; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX purchase_return_updater_id_6cd3dd53 ON public.purchase_return USING btree (updater_id);


--
-- Name: purchase_supplier_id_efe205b7; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX purchase_supplier_id_efe205b7 ON public.purchase USING btree (supplier_id);


--
-- Name: purchase_updater_id_8b151978; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX purchase_updater_id_8b151978 ON public.purchase USING btree (updater_id);


--
-- Name: purchase_warehouse_id_f6182a98; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX purchase_warehouse_id_f6182a98 ON public.purchase USING btree (warehouse_id);


--
-- Name: return_images_creator_id_f2483bd1; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX return_images_creator_id_f2483bd1 ON public.return_images USING btree (creator_id);


--
-- Name: return_images_date_added_c40fde0f; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX return_images_date_added_c40fde0f ON public.return_images USING btree (date_added);


--
-- Name: return_images_product_return_id_29d1c8fd; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX return_images_product_return_id_29d1c8fd ON public.return_images USING btree (product_return_id);


--
-- Name: return_images_updater_id_ce2109e0; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX return_images_updater_id_ce2109e0 ON public.return_images USING btree (updater_id);


--
-- Name: salary_pay_creator_id_7fe1b925; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX salary_pay_creator_id_7fe1b925 ON public.salary_pay USING btree (creator_id);


--
-- Name: salary_pay_date_added_649e9a81; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX salary_pay_date_added_649e9a81 ON public.salary_pay USING btree (date_added);


--
-- Name: salary_pay_staff_id_7308fc7a; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX salary_pay_staff_id_7308fc7a ON public.salary_pay USING btree (staff_id);


--
-- Name: salary_pay_updater_id_9094dbe1; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX salary_pay_updater_id_9094dbe1 ON public.salary_pay USING btree (updater_id);


--
-- Name: sale_return_creator_id_ca4dfdc8; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX sale_return_creator_id_ca4dfdc8 ON public.sale_return USING btree (creator_id);


--
-- Name: sale_return_customer_id_2dbf9690; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX sale_return_customer_id_2dbf9690 ON public.sale_return USING btree (customer_id);


--
-- Name: sale_return_date_added_89c42395; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX sale_return_date_added_89c42395 ON public.sale_return USING btree (date_added);


--
-- Name: sale_return_item_batch_id_a264bc1a; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX sale_return_item_batch_id_a264bc1a ON public.sale_return_item USING btree (batch_id);


--
-- Name: sale_return_item_product_id_b74d2eab; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX sale_return_item_product_id_b74d2eab ON public.sale_return_item USING btree (product_id);


--
-- Name: sale_return_item_product_variant_id_e61feb36; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX sale_return_item_product_variant_id_e61feb36 ON public.sale_return_item USING btree (product_variant_id);


--
-- Name: sale_return_item_sale_item_id_86bf752a; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX sale_return_item_sale_item_id_86bf752a ON public.sale_return_item USING btree (sale_item_id);


--
-- Name: sale_return_item_sale_return_id_69ce4fd8; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX sale_return_item_sale_return_id_69ce4fd8 ON public.sale_return_item USING btree (sale_return_id);


--
-- Name: sale_return_sale_id_5cb39e41; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX sale_return_sale_id_5cb39e41 ON public.sale_return USING btree (sale_id);


--
-- Name: sale_return_updater_id_35e400db; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX sale_return_updater_id_35e400db ON public.sale_return USING btree (updater_id);


--
-- Name: sale_return_warehouse_id_870f2b0c; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX sale_return_warehouse_id_870f2b0c ON public.sale_return USING btree (warehouse_id);


--
-- Name: sales_creator_id_d767af96; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX sales_creator_id_d767af96 ON public.sales USING btree (creator_id);


--
-- Name: sales_customer_id_b4959801; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX sales_customer_id_b4959801 ON public.sales USING btree (customer_id);


--
-- Name: sales_date_added_12b12097; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX sales_date_added_12b12097 ON public.sales USING btree (date_added);


--
-- Name: sales_sale_item_batch_id_7abe5bf7; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX sales_sale_item_batch_id_7abe5bf7 ON public.sales_sale_item USING btree (batch_id);


--
-- Name: sales_sale_item_product_variant_id_b2c2abdf; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX sales_sale_item_product_variant_id_b2c2abdf ON public.sales_sale_item USING btree (product_variant_id);


--
-- Name: sales_sale_item_sale_id_76eaa814; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX sales_sale_item_sale_id_76eaa814 ON public.sales_sale_item USING btree (sale_id);


--
-- Name: sales_sale_prefix_id_c62f025c; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX sales_sale_prefix_id_c62f025c ON public.sales USING btree (sale_prefix_id);


--
-- Name: sales_updater_id_a64fa776; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX sales_updater_id_a64fa776 ON public.sales USING btree (updater_id);


--
-- Name: sales_warehouse_id_84e0b516; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX sales_warehouse_id_84e0b516 ON public.sales USING btree (warehouse_id);


--
-- Name: special_variant_creator_id_9a2f8939; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX special_variant_creator_id_9a2f8939 ON public.special_variant USING btree (creator_id);


--
-- Name: special_variant_date_added_575c7827; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX special_variant_date_added_575c7827 ON public.special_variant USING btree (date_added);


--
-- Name: special_variant_product_variant_productvariant_id_f2415396; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX special_variant_product_variant_productvariant_id_f2415396 ON public.special_variant_product_variant USING btree (productvariant_id);


--
-- Name: special_variant_product_variant_specialvariant_id_7b1e7b1b; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX special_variant_product_variant_specialvariant_id_7b1e7b1b ON public.special_variant_product_variant USING btree (specialvariant_id);


--
-- Name: special_variant_updater_id_708ebca3; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX special_variant_updater_id_708ebca3 ON public.special_variant USING btree (updater_id);


--
-- Name: staff_attendence_creator_id_0920f368; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX staff_attendence_creator_id_0920f368 ON public.staff_attendence USING btree (creator_id);


--
-- Name: staff_attendence_date_added_71809dc6; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX staff_attendence_date_added_71809dc6 ON public.staff_attendence USING btree (date_added);


--
-- Name: staff_attendence_staff_id_d6748ba4; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX staff_attendence_staff_id_d6748ba4 ON public.staff_attendence USING btree (staff_id);


--
-- Name: staff_attendence_updater_id_8281af3a; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX staff_attendence_updater_id_8281af3a ON public.staff_attendence USING btree (updater_id);


--
-- Name: staff_creator_id_3adcbdeb; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX staff_creator_id_3adcbdeb ON public.staff USING btree (creator_id);


--
-- Name: staff_date_added_a4b5fcd6; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX staff_date_added_a4b5fcd6 ON public.staff USING btree (date_added);


--
-- Name: staff_designation_id_5370c180; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX staff_designation_id_5370c180 ON public.staff USING btree (designation_id);


--
-- Name: staff_permission_permission_id_db9b3f33; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX staff_permission_permission_id_db9b3f33 ON public.staff_permission USING btree (permission_id);


--
-- Name: staff_permission_staff_id_697f9421; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX staff_permission_staff_id_697f9421 ON public.staff_permission USING btree (staff_id);


--
-- Name: staff_salary_allowance_creator_id_9f39108d; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX staff_salary_allowance_creator_id_9f39108d ON public.staff_salary_allowance USING btree (creator_id);


--
-- Name: staff_salary_allowance_date_added_2857c70c; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX staff_salary_allowance_date_added_2857c70c ON public.staff_salary_allowance USING btree (date_added);


--
-- Name: staff_salary_allowance_staff_id_7aa5764f; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX staff_salary_allowance_staff_id_7aa5764f ON public.staff_salary_allowance USING btree (staff_id);


--
-- Name: staff_salary_allowance_updater_id_0880b574; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX staff_salary_allowance_updater_id_0880b574 ON public.staff_salary_allowance USING btree (updater_id);


--
-- Name: staff_updater_id_491d90f5; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX staff_updater_id_491d90f5 ON public.staff USING btree (updater_id);


--
-- Name: staff_warehouse_id_1ea8b77d; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX staff_warehouse_id_1ea8b77d ON public.staff USING btree (warehouse_id);


--
-- Name: stock_transfer_creator_id_917a3181; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX stock_transfer_creator_id_917a3181 ON public.stock_transfer USING btree (creator_id);


--
-- Name: stock_transfer_date_added_6eecae7c; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX stock_transfer_date_added_6eecae7c ON public.stock_transfer USING btree (date_added);


--
-- Name: stock_transfer_items_batch_id_6e12881d; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX stock_transfer_items_batch_id_6e12881d ON public.stock_transfer_items USING btree (batch_id);


--
-- Name: stock_transfer_items_creator_id_4aa0f9b4; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX stock_transfer_items_creator_id_4aa0f9b4 ON public.stock_transfer_items USING btree (creator_id);


--
-- Name: stock_transfer_items_date_added_643ef65a; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX stock_transfer_items_date_added_643ef65a ON public.stock_transfer_items USING btree (date_added);


--
-- Name: stock_transfer_items_product_variant_id_10090a13; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX stock_transfer_items_product_variant_id_10090a13 ON public.stock_transfer_items USING btree (product_variant_id);


--
-- Name: stock_transfer_items_stock_transfer_id_8b4d6f0e; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX stock_transfer_items_stock_transfer_id_8b4d6f0e ON public.stock_transfer_items USING btree (stock_transfer_id);


--
-- Name: stock_transfer_items_updater_id_e94dc7ab; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX stock_transfer_items_updater_id_e94dc7ab ON public.stock_transfer_items USING btree (updater_id);


--
-- Name: stock_transfer_to_warehouse_id_9c565097; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX stock_transfer_to_warehouse_id_9c565097 ON public.stock_transfer USING btree (to_warehouse_id);


--
-- Name: stock_transfer_updater_id_daf05e5e; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX stock_transfer_updater_id_daf05e5e ON public.stock_transfer USING btree (updater_id);


--
-- Name: stock_transfer_warehouse_id_98a99844; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX stock_transfer_warehouse_id_98a99844 ON public.stock_transfer USING btree (warehouse_id);


--
-- Name: stock_update_creator_id_cf29eb24; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX stock_update_creator_id_cf29eb24 ON public.stock_update USING btree (creator_id);


--
-- Name: stock_update_date_added_2c99da19; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX stock_update_date_added_2c99da19 ON public.stock_update USING btree (date_added);


--
-- Name: stock_update_item_batch_id_3fb160b5; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX stock_update_item_batch_id_3fb160b5 ON public.stock_update_item USING btree (batch_id);


--
-- Name: stock_update_item_product_variant_id_9156dec5; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX stock_update_item_product_variant_id_9156dec5 ON public.stock_update_item USING btree (product_variant_id);


--
-- Name: stock_update_item_stockupdate_id_79d2ec56; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX stock_update_item_stockupdate_id_79d2ec56 ON public.stock_update_item USING btree (stockupdate_id);


--
-- Name: stock_update_updater_id_412fb489; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX stock_update_updater_id_412fb489 ON public.stock_update USING btree (updater_id);


--
-- Name: stock_update_warehouse_id_f0f5eea0; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX stock_update_warehouse_id_f0f5eea0 ON public.stock_update USING btree (warehouse_id);


--
-- Name: students_registration_profile_phone_197b4975_like; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX students_registration_profile_phone_197b4975_like ON public.students_registration_profile USING btree (phone varchar_pattern_ops);


--
-- Name: suppliers_supplier_creator_id_07cc976c; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX suppliers_supplier_creator_id_07cc976c ON public.suppliers_supplier USING btree (creator_id);


--
-- Name: suppliers_supplier_date_added_c86471ec; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX suppliers_supplier_date_added_c86471ec ON public.suppliers_supplier USING btree (date_added);


--
-- Name: suppliers_supplier_updater_id_a9a0014f; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX suppliers_supplier_updater_id_a9a0014f ON public.suppliers_supplier USING btree (updater_id);


--
-- Name: techpe_staff_record_creator_id_9ea540ca; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX techpe_staff_record_creator_id_9ea540ca ON public.techpe_staff_record USING btree (creator_id);


--
-- Name: techpe_staff_record_date_added_e1d4732d; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX techpe_staff_record_date_added_e1d4732d ON public.techpe_staff_record USING btree (date_added);


--
-- Name: techpe_staff_record_staff_id_3b03ef2a; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX techpe_staff_record_staff_id_3b03ef2a ON public.techpe_staff_record USING btree (staff_id);


--
-- Name: techpe_staff_record_updater_id_73376052; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX techpe_staff_record_updater_id_73376052 ON public.techpe_staff_record USING btree (updater_id);


--
-- Name: tickets_creator_id_2fc0e6d2; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX tickets_creator_id_2fc0e6d2 ON public.tickets USING btree (creator_id);


--
-- Name: tickets_customer_id_1778b1f7; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX tickets_customer_id_1778b1f7 ON public.tickets USING btree (customer_id);


--
-- Name: tickets_date_added_c0d38e07; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX tickets_date_added_c0d38e07 ON public.tickets USING btree (date_added);


--
-- Name: tickets_updater_id_720df8cd; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX tickets_updater_id_720df8cd ON public.tickets USING btree (updater_id);


--
-- Name: users_cartitem_customer_id_3aa9bb25; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX users_cartitem_customer_id_3aa9bb25 ON public.users_cartitem USING btree (customer_id);


--
-- Name: users_cartitem_product_variant_id_2ffc31b9; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX users_cartitem_product_variant_id_2ffc31b9 ON public.users_cartitem USING btree (product_variant_id);


--
-- Name: users_cartitem_warehouse_id_65535620; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX users_cartitem_warehouse_id_65535620 ON public.users_cartitem USING btree (warehouse_id);


--
-- Name: users_notification_customer_id_ddee569d; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX users_notification_customer_id_ddee569d ON public.users_notification USING btree (customer_id);


--
-- Name: users_notification_order_id_26554506; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX users_notification_order_id_26554506 ON public.users_notification USING btree (order_id);


--
-- Name: users_notification_subject_id_03f187af; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX users_notification_subject_id_03f187af ON public.users_notification USING btree (subject_id);


--
-- Name: users_notification_user_id_fed360c8; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX users_notification_user_id_fed360c8 ON public.users_notification USING btree (user_id);


--
-- Name: users_notification_who_id_1bc02fb3; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX users_notification_who_id_1bc02fb3 ON public.users_notification USING btree (who_id);


--
-- Name: users_user_login_user_id_1e0c5baa; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX users_user_login_user_id_1e0c5baa ON public.users_user_login USING btree (user_id);


--
-- Name: users_wishlistitem_customer_id_3c1ca701; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX users_wishlistitem_customer_id_3c1ca701 ON public.users_wishlistitem USING btree (customer_id);


--
-- Name: users_wishlistitem_product_variant_id_4f5db007; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX users_wishlistitem_product_variant_id_4f5db007 ON public.users_wishlistitem USING btree (product_variant_id);


--
-- Name: vendors_commission_vendor_id_46d0d483; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX vendors_commission_vendor_id_46d0d483 ON public.vendors_commission USING btree (vendor_id);


--
-- Name: vendors_vendor_creator_id_f1bab48a; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX vendors_vendor_creator_id_f1bab48a ON public.vendors_vendor USING btree (creator_id);


--
-- Name: vendors_vendor_date_added_5cb446d7; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX vendors_vendor_date_added_5cb446d7 ON public.vendors_vendor USING btree (date_added);


--
-- Name: vendors_vendor_deliverable_location_vendor_id_a1286659; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX vendors_vendor_deliverable_location_vendor_id_a1286659 ON public.vendors_vendor_deliverable_location USING btree (vendor_id);


--
-- Name: vendors_vendor_deliverable_location_zone_id_d15159a0; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX vendors_vendor_deliverable_location_zone_id_d15159a0 ON public.vendors_vendor_deliverable_location USING btree (zone_id);


--
-- Name: vendors_vendor_location_id_a62c69f7; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX vendors_vendor_location_id_a62c69f7 ON public.vendors_vendor USING btree (location_id);


--
-- Name: vendors_vendor_updater_id_5e59b1f7; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX vendors_vendor_updater_id_5e59b1f7 ON public.vendors_vendor USING btree (updater_id);


--
-- Name: vendors_vendor_zone_id_ca06c82a; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX vendors_vendor_zone_id_ca06c82a ON public.vendors_vendor USING btree (zone_id);


--
-- Name: warehouse_creator_id_ca390d1b; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX warehouse_creator_id_ca390d1b ON public.warehouse USING btree (creator_id);


--
-- Name: warehouse_date_added_d46f5b24; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX warehouse_date_added_d46f5b24 ON public.warehouse USING btree (date_added);


--
-- Name: warehouse_deliverable_location_warehouse_id_c1f110a9; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX warehouse_deliverable_location_warehouse_id_c1f110a9 ON public.warehouse_deliverable_location USING btree (warehouse_id);


--
-- Name: warehouse_deliverable_location_zone_id_7cbfc158; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX warehouse_deliverable_location_zone_id_7cbfc158 ON public.warehouse_deliverable_location USING btree (zone_id);


--
-- Name: warehouse_location_id_00f5bf11; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX warehouse_location_id_00f5bf11 ON public.warehouse USING btree (location_id);


--
-- Name: warehouse_manager_id_88a15ae0; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX warehouse_manager_id_88a15ae0 ON public.warehouse USING btree (manager_id);


--
-- Name: warehouse_no_express_delivery_warehouse_id_51219f49; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX warehouse_no_express_delivery_warehouse_id_51219f49 ON public.warehouse_no_express_delivery USING btree (warehouse_id);


--
-- Name: warehouse_no_express_delivery_zone_id_7dd21bfe; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX warehouse_no_express_delivery_zone_id_7dd21bfe ON public.warehouse_no_express_delivery USING btree (zone_id);


--
-- Name: warehouse_updater_id_db0742a3; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX warehouse_updater_id_db0742a3 ON public.warehouse USING btree (updater_id);


--
-- Name: warehouse_zone_id_09e97e47; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX warehouse_zone_id_09e97e47 ON public.warehouse USING btree (zone_id);


--
-- Name: web_FeauturedCategory_category_id_d455bce9; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX "web_FeauturedCategory_category_id_d455bce9" ON public."web_FeauturedCategory" USING btree (category_id);


--
-- Name: web_FeauturedCategory_creator_id_0abe369e; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX "web_FeauturedCategory_creator_id_0abe369e" ON public."web_FeauturedCategory" USING btree (creator_id);


--
-- Name: web_FeauturedCategory_date_added_99c45639; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX "web_FeauturedCategory_date_added_99c45639" ON public."web_FeauturedCategory" USING btree (date_added);


--
-- Name: web_FeauturedCategory_updater_id_93ce2b27; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX "web_FeauturedCategory_updater_id_93ce2b27" ON public."web_FeauturedCategory" USING btree (updater_id);


--
-- Name: web_TrendingCategory_category_id_62630652; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX "web_TrendingCategory_category_id_62630652" ON public."web_TrendingCategory" USING btree (category_id);


--
-- Name: web_TrendingCategory_creator_id_42d034a2; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX "web_TrendingCategory_creator_id_42d034a2" ON public."web_TrendingCategory" USING btree (creator_id);


--
-- Name: web_TrendingCategory_date_added_2fd38e98; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX "web_TrendingCategory_date_added_2fd38e98" ON public."web_TrendingCategory" USING btree (date_added);


--
-- Name: web_TrendingCategory_updater_id_fc885942; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX "web_TrendingCategory_updater_id_fc885942" ON public."web_TrendingCategory" USING btree (updater_id);


--
-- Name: web_productreturn_creator_id_ed38cc45; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX web_productreturn_creator_id_ed38cc45 ON public.web_productreturn USING btree (creator_id);


--
-- Name: web_productreturn_customer_account_id_c06bfd0e; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX web_productreturn_customer_account_id_c06bfd0e ON public.web_productreturn USING btree (customer_account_id);


--
-- Name: web_productreturn_customer_address_id_22b0bf5b; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX web_productreturn_customer_address_id_22b0bf5b ON public.web_productreturn USING btree (customer_address_id);


--
-- Name: web_productreturn_date_added_053ba767; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX web_productreturn_date_added_053ba767 ON public.web_productreturn USING btree (date_added);


--
-- Name: web_productreturn_delivery_boy_id_0828cf82; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX web_productreturn_delivery_boy_id_0828cf82 ON public.web_productreturn USING btree (delivery_boy_id);


--
-- Name: web_productreturn_order_id_731bb36a; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX web_productreturn_order_id_731bb36a ON public.web_productreturn USING btree (order_id);


--
-- Name: web_productreturn_order_item_id_7ed5e915; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX web_productreturn_order_item_id_7ed5e915 ON public.web_productreturn USING btree (order_item_id);


--
-- Name: web_productreturn_updater_id_acc1ff48; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX web_productreturn_updater_id_acc1ff48 ON public.web_productreturn USING btree (updater_id);


--
-- Name: web_productreview_creator_id_3f7511d7; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX web_productreview_creator_id_3f7511d7 ON public.web_productreview USING btree (creator_id);


--
-- Name: web_productreview_date_added_e2d9abfa; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX web_productreview_date_added_e2d9abfa ON public.web_productreview USING btree (date_added);


--
-- Name: web_productreview_product_variant_id_d2100523; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX web_productreview_product_variant_id_d2100523 ON public.web_productreview USING btree (product_variant_id);


--
-- Name: web_productreview_updater_id_da352572; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX web_productreview_updater_id_da352572 ON public.web_productreview USING btree (updater_id);


--
-- Name: web_spotlightbanner_brand_id_5af72f13; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX web_spotlightbanner_brand_id_5af72f13 ON public.web_spotlightbanner USING btree (brand_id);


--
-- Name: web_spotlightbanner_category_id_dcda9297; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX web_spotlightbanner_category_id_dcda9297 ON public.web_spotlightbanner USING btree (category_id);


--
-- Name: web_spotlightbanner_creator_id_367149ad; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX web_spotlightbanner_creator_id_367149ad ON public.web_spotlightbanner USING btree (creator_id);


--
-- Name: web_spotlightbanner_date_added_75679e8e; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX web_spotlightbanner_date_added_75679e8e ON public.web_spotlightbanner USING btree (date_added);


--
-- Name: web_spotlightbanner_product_variant_id_ffccb843; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX web_spotlightbanner_product_variant_id_ffccb843 ON public.web_spotlightbanner USING btree (product_variant_id);


--
-- Name: web_spotlightbanner_updater_id_b6c739d7; Type: INDEX; Schema: public; Owner: nexsme_live
--

CREATE INDEX web_spotlightbanner_updater_id_b6c739d7 ON public.web_spotlightbanner USING btree (updater_id);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: customer_bank_account customer_bank_accoun_customer_id_e0de9b6a_fk_customers; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.customer_bank_account
    ADD CONSTRAINT customer_bank_accoun_customer_id_e0de9b6a_fk_customers FOREIGN KEY (customer_id) REFERENCES public.customers_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: customers_customer customers_customer_creator_id_1476a573_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.customers_customer
    ADD CONSTRAINT customers_customer_creator_id_1476a573_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: customers_customer customers_customer_updater_id_fb08982a_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.customers_customer
    ADD CONSTRAINT customers_customer_updater_id_fb08982a_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: customers_customer customers_customer_user_id_a9568d6c_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.customers_customer
    ADD CONSTRAINT customers_customer_user_id_a9568d6c_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: customers_customeraddress customers_customerad_customer_id_17a361bc_fk_customers; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.customers_customeraddress
    ADD CONSTRAINT customers_customerad_customer_id_17a361bc_fk_customers FOREIGN KEY (customer_id) REFERENCES public.customers_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: customers_customeraddress customers_customeraddress_location_id_17fe4522_fk_location_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.customers_customeraddress
    ADD CONSTRAINT customers_customeraddress_location_id_17fe4522_fk_location_id FOREIGN KEY (location_id) REFERENCES public.location(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: customers_customeraddress customers_customeraddress_zone_id_c8ddc8d9_fk_zone_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.customers_customeraddress
    ADD CONSTRAINT customers_customeraddress_zone_id_c8ddc8d9_fk_zone_id FOREIGN KEY (zone_id) REFERENCES public.zone(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: deal_of_day deal_of_day_creator_id_9f340a2e_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.deal_of_day
    ADD CONSTRAINT deal_of_day_creator_id_9f340a2e_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: deal_of_day deal_of_day_product_variant_id_114ec7a8_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.deal_of_day
    ADD CONSTRAINT deal_of_day_product_variant_id_114ec7a8_fk_products_ FOREIGN KEY (product_variant_id) REFERENCES public.products_product_variant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: deal_of_day deal_of_day_updater_id_ab1a7149_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.deal_of_day
    ADD CONSTRAINT deal_of_day_updater_id_ab1a7149_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: deal_of_day deal_of_day_warehouse_id_e854bd5b_fk_warehouse_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.deal_of_day
    ADD CONSTRAINT deal_of_day_warehouse_id_e854bd5b_fk_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES public.warehouse(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: delivery_agent_collectpayment delivery_agent_colle_creator_id_64dd3e92_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.delivery_agent_collectpayment
    ADD CONSTRAINT delivery_agent_colle_creator_id_64dd3e92_fk_auth_user FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: delivery_agent_collectedpaymentregister delivery_agent_colle_creator_id_6a7cf32c_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.delivery_agent_collectedpaymentregister
    ADD CONSTRAINT delivery_agent_colle_creator_id_6a7cf32c_fk_auth_user FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: delivery_agent_collectedpaymentregister delivery_agent_colle_delivery_agent_id_2c44ae37_fk_delivery_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.delivery_agent_collectedpaymentregister
    ADD CONSTRAINT delivery_agent_colle_delivery_agent_id_2c44ae37_fk_delivery_ FOREIGN KEY (delivery_agent_id) REFERENCES public.delivery_agent_delivery_agent(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: delivery_agent_collectpayment delivery_agent_colle_delivery_agent_id_98e4f1b0_fk_delivery_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.delivery_agent_collectpayment
    ADD CONSTRAINT delivery_agent_colle_delivery_agent_id_98e4f1b0_fk_delivery_ FOREIGN KEY (delivery_agent_id) REFERENCES public.delivery_agent_delivery_agent(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: delivery_agent_collectpayment delivery_agent_colle_order_id_1b5c37ce_fk_orders_or; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.delivery_agent_collectpayment
    ADD CONSTRAINT delivery_agent_colle_order_id_1b5c37ce_fk_orders_or FOREIGN KEY (order_id) REFERENCES public.orders_orders(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: delivery_agent_collectedpaymentregister delivery_agent_colle_updater_id_59b31cf8_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.delivery_agent_collectedpaymentregister
    ADD CONSTRAINT delivery_agent_colle_updater_id_59b31cf8_fk_auth_user FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: delivery_agent_collectpayment delivery_agent_colle_updater_id_e81c108d_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.delivery_agent_collectpayment
    ADD CONSTRAINT delivery_agent_colle_updater_id_e81c108d_fk_auth_user FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: delivery_agent_delivery_agent delivery_agent_deliv_creator_id_b89a1128_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.delivery_agent_delivery_agent
    ADD CONSTRAINT delivery_agent_deliv_creator_id_b89a1128_fk_auth_user FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: delivery_agent_deliveryrating delivery_agent_deliv_customer_id_11ff6f1d_fk_customers; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.delivery_agent_deliveryrating
    ADD CONSTRAINT delivery_agent_deliv_customer_id_11ff6f1d_fk_customers FOREIGN KEY (customer_id) REFERENCES public.customers_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: delivery_agent_deliveryrating delivery_agent_deliv_delivery_agent_id_849f8046_fk_delivery_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.delivery_agent_deliveryrating
    ADD CONSTRAINT delivery_agent_deliv_delivery_agent_id_849f8046_fk_delivery_ FOREIGN KEY (delivery_agent_id) REFERENCES public.delivery_agent_delivery_agent(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: delivery_agent_deliveryrating delivery_agent_deliv_order_id_3d114519_fk_orders_or; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.delivery_agent_deliveryrating
    ADD CONSTRAINT delivery_agent_deliv_order_id_3d114519_fk_orders_or FOREIGN KEY (order_id) REFERENCES public.orders_orders(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: delivery_agent_delivery_agent delivery_agent_deliv_updater_id_56431a33_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.delivery_agent_delivery_agent
    ADD CONSTRAINT delivery_agent_deliv_updater_id_56431a33_fk_auth_user FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: delivery_agent_delivery_agent delivery_agent_deliv_warehouse_id_d0be882a_fk_warehouse; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.delivery_agent_delivery_agent
    ADD CONSTRAINT delivery_agent_deliv_warehouse_id_d0be882a_fk_warehouse FOREIGN KEY (warehouse_id) REFERENCES public.warehouse(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: delivery_agent_delivery_agent delivery_agent_delivery_agent_user_id_f4bfda87_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.delivery_agent_delivery_agent
    ADD CONSTRAINT delivery_agent_delivery_agent_user_id_f4bfda87_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: delivery_agent_travel delivery_agent_trave_delivery_agent_id_f59da55f_fk_delivery_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.delivery_agent_travel
    ADD CONSTRAINT delivery_agent_trave_delivery_agent_id_f59da55f_fk_delivery_ FOREIGN KEY (delivery_agent_id) REFERENCES public.delivery_agent_delivery_agent(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: delivery_agent_travel delivery_agent_trave_delivery_trip_id_3f5b0d44_fk_delivery_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.delivery_agent_travel
    ADD CONSTRAINT delivery_agent_trave_delivery_trip_id_3f5b0d44_fk_delivery_ FOREIGN KEY (delivery_trip_id) REFERENCES public.delivery_agent_trip(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: delivery_agent_travel delivery_agent_travel_order_id_e94054aa_fk_orders_orders_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.delivery_agent_travel
    ADD CONSTRAINT delivery_agent_travel_order_id_e94054aa_fk_orders_orders_id FOREIGN KEY (order_id) REFERENCES public.orders_orders(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: delivery_agent_trip delivery_agent_trip_delivery_agent_id_fe4f4191_fk_delivery_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.delivery_agent_trip
    ADD CONSTRAINT delivery_agent_trip_delivery_agent_id_fe4f4191_fk_delivery_ FOREIGN KEY (delivery_agent_id) REFERENCES public.delivery_agent_delivery_agent(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: designation designation_creator_id_4ad7c043_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.designation
    ADD CONSTRAINT designation_creator_id_4ad7c043_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: designation designation_updater_id_e24faf62_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.designation
    ADD CONSTRAINT designation_updater_id_e24faf62_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: fcm_django_fcmdevice fcm_django_fcmdevice_user_id_6cdfc0a2_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.fcm_django_fcmdevice
    ADD CONSTRAINT fcm_django_fcmdevice_user_id_6cdfc0a2_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_account_group finance_account_group_creator_id_a96fc030_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_account_group
    ADD CONSTRAINT finance_account_group_creator_id_a96fc030_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_account_group finance_account_group_updater_id_4b6f988b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_account_group
    ADD CONSTRAINT finance_account_group_updater_id_4b6f988b_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_account_head finance_account_head_account_group_id_321f5a9d_fk_finance_a; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_account_head
    ADD CONSTRAINT finance_account_head_account_group_id_321f5a9d_fk_finance_a FOREIGN KEY (account_group_id) REFERENCES public.finance_account_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_account_head_opening finance_account_head_account_head_id_e4dc2463_fk_finance_a; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_account_head_opening
    ADD CONSTRAINT finance_account_head_account_head_id_e4dc2463_fk_finance_a FOREIGN KEY (account_head_id) REFERENCES public.finance_account_head(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_account_head finance_account_head_bank_account_id_39ea79a6_fk_finance_b; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_account_head
    ADD CONSTRAINT finance_account_head_bank_account_id_39ea79a6_fk_finance_b FOREIGN KEY (bank_account_id) REFERENCES public.finance_bank_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_account_head finance_account_head_creator_id_1eb4160e_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_account_head
    ADD CONSTRAINT finance_account_head_creator_id_1eb4160e_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_account_head_opening finance_account_head_creator_id_de6547fe_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_account_head_opening
    ADD CONSTRAINT finance_account_head_creator_id_de6547fe_fk_auth_user FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_account_head_opening finance_account_head_financial_year_id_81c820fb_fk_finance_f; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_account_head_opening
    ADD CONSTRAINT finance_account_head_financial_year_id_81c820fb_fk_finance_f FOREIGN KEY (financial_year_id) REFERENCES public.finance_financial_year(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_account_head_opening finance_account_head_updater_id_3d59963d_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_account_head_opening
    ADD CONSTRAINT finance_account_head_updater_id_3d59963d_fk_auth_user FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_account_head finance_account_head_updater_id_9d210e1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_account_head
    ADD CONSTRAINT finance_account_head_updater_id_9d210e1b_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_account_head_opening finance_account_head_warehouse_id_38c376ec_fk_warehouse; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_account_head_opening
    ADD CONSTRAINT finance_account_head_warehouse_id_38c376ec_fk_warehouse FOREIGN KEY (warehouse_id) REFERENCES public.warehouse(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_bank_account finance_bank_account_creator_id_284c0ab7_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_bank_account
    ADD CONSTRAINT finance_bank_account_creator_id_284c0ab7_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_bank_account finance_bank_account_updater_id_f839d86d_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_bank_account
    ADD CONSTRAINT finance_bank_account_updater_id_f839d86d_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_bank_account finance_bank_account_warehouse_id_d42963ee_fk_warehouse_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_bank_account
    ADD CONSTRAINT finance_bank_account_warehouse_id_d42963ee_fk_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES public.warehouse(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_credit_voucher finance_credit_vouch_bank_id_f319bb56_fk_finance_b; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_credit_voucher
    ADD CONSTRAINT finance_credit_vouch_bank_id_f319bb56_fk_finance_b FOREIGN KEY (bank_id) REFERENCES public.finance_bank_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_credit_voucher finance_credit_vouch_customer_id_121729e3_fk_customers; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_credit_voucher
    ADD CONSTRAINT finance_credit_vouch_customer_id_121729e3_fk_customers FOREIGN KEY (customer_id) REFERENCES public.customers_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_credit_voucher finance_credit_vouch_financial_year_id_b2546424_fk_finance_f; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_credit_voucher
    ADD CONSTRAINT finance_credit_vouch_financial_year_id_b2546424_fk_finance_f FOREIGN KEY (financial_year_id) REFERENCES public.finance_financial_year(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_credit_voucher finance_credit_vouch_sale_return_id_635b6e78_fk_sale_retu; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_credit_voucher
    ADD CONSTRAINT finance_credit_vouch_sale_return_id_635b6e78_fk_sale_retu FOREIGN KEY (sale_return_id) REFERENCES public.sale_return(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_credit_voucher finance_credit_voucher_creator_id_53bf998f_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_credit_voucher
    ADD CONSTRAINT finance_credit_voucher_creator_id_53bf998f_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_credit_voucher finance_credit_voucher_updater_id_b37092ec_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_credit_voucher
    ADD CONSTRAINT finance_credit_voucher_updater_id_b37092ec_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_credit_voucher finance_credit_voucher_warehouse_id_34e0969b_fk_warehouse_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_credit_voucher
    ADD CONSTRAINT finance_credit_voucher_warehouse_id_34e0969b_fk_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES public.warehouse(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_debit_voucher finance_debit_vouche_bank_id_88c1d0bc_fk_finance_b; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_debit_voucher
    ADD CONSTRAINT finance_debit_vouche_bank_id_88c1d0bc_fk_finance_b FOREIGN KEY (bank_id) REFERENCES public.finance_bank_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_debit_voucher finance_debit_vouche_financial_year_id_a7e58d07_fk_finance_f; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_debit_voucher
    ADD CONSTRAINT finance_debit_vouche_financial_year_id_a7e58d07_fk_finance_f FOREIGN KEY (financial_year_id) REFERENCES public.finance_financial_year(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_debit_voucher finance_debit_vouche_purchase_return_id_f30a1914_fk_purchase_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_debit_voucher
    ADD CONSTRAINT finance_debit_vouche_purchase_return_id_f30a1914_fk_purchase_ FOREIGN KEY (purchase_return_id) REFERENCES public.purchase_return(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_debit_voucher finance_debit_vouche_supplier_id_65432f72_fk_suppliers; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_debit_voucher
    ADD CONSTRAINT finance_debit_vouche_supplier_id_65432f72_fk_suppliers FOREIGN KEY (supplier_id) REFERENCES public.suppliers_supplier(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_debit_voucher finance_debit_voucher_creator_id_43ff9a0f_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_debit_voucher
    ADD CONSTRAINT finance_debit_voucher_creator_id_43ff9a0f_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_debit_voucher finance_debit_voucher_updater_id_a04e7319_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_debit_voucher
    ADD CONSTRAINT finance_debit_voucher_updater_id_a04e7319_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_debit_voucher finance_debit_voucher_warehouse_id_4d484ffc_fk_warehouse_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_debit_voucher
    ADD CONSTRAINT finance_debit_voucher_warehouse_id_4d484ffc_fk_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES public.warehouse(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_financial_year finance_financial_year_creator_id_7496c62f_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_financial_year
    ADD CONSTRAINT finance_financial_year_creator_id_7496c62f_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_financial_year finance_financial_year_updater_id_e530114b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_financial_year
    ADD CONSTRAINT finance_financial_year_updater_id_e530114b_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_journal_voucher_item finance_journal_vouc_account_head_id_60bb56e9_fk_finance_a; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_journal_voucher_item
    ADD CONSTRAINT finance_journal_vouc_account_head_id_60bb56e9_fk_finance_a FOREIGN KEY (account_head_id) REFERENCES public.finance_account_head(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_journal_voucher finance_journal_vouc_financial_year_id_3a9afc1d_fk_finance_f; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_journal_voucher
    ADD CONSTRAINT finance_journal_vouc_financial_year_id_3a9afc1d_fk_finance_f FOREIGN KEY (financial_year_id) REFERENCES public.finance_financial_year(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_journal_voucher_item finance_journal_vouc_journal_id_f4c0d941_fk_finance_j; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_journal_voucher_item
    ADD CONSTRAINT finance_journal_vouc_journal_id_f4c0d941_fk_finance_j FOREIGN KEY (journal_id) REFERENCES public.finance_journal_voucher(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_journal_voucher_item finance_journal_vouc_warehouse_id_d1f399da_fk_warehouse; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_journal_voucher_item
    ADD CONSTRAINT finance_journal_vouc_warehouse_id_d1f399da_fk_warehouse FOREIGN KEY (warehouse_id) REFERENCES public.warehouse(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_journal_voucher finance_journal_voucher_creator_id_0a832a6e_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_journal_voucher
    ADD CONSTRAINT finance_journal_voucher_creator_id_0a832a6e_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_journal_voucher finance_journal_voucher_updater_id_2b87e133_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_journal_voucher
    ADD CONSTRAINT finance_journal_voucher_updater_id_2b87e133_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_payment_voucher finance_payment_vouc_account_head_id_266b6c79_fk_finance_a; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_payment_voucher
    ADD CONSTRAINT finance_payment_vouc_account_head_id_266b6c79_fk_finance_a FOREIGN KEY (account_head_id) REFERENCES public.finance_account_head(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_payment_voucher finance_payment_vouc_bank_id_4cf952e3_fk_finance_b; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_payment_voucher
    ADD CONSTRAINT finance_payment_vouc_bank_id_4cf952e3_fk_finance_b FOREIGN KEY (bank_id) REFERENCES public.finance_bank_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_payment_voucher finance_payment_vouc_financial_year_id_47131237_fk_finance_f; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_payment_voucher
    ADD CONSTRAINT finance_payment_vouc_financial_year_id_47131237_fk_finance_f FOREIGN KEY (financial_year_id) REFERENCES public.finance_financial_year(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_payment_voucher finance_payment_voucher_creator_id_eaa19d07_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_payment_voucher
    ADD CONSTRAINT finance_payment_voucher_creator_id_eaa19d07_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_payment_voucher finance_payment_voucher_updater_id_37b26034_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_payment_voucher
    ADD CONSTRAINT finance_payment_voucher_updater_id_37b26034_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_payment_voucher finance_payment_voucher_warehouse_id_f9d89734_fk_warehouse_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_payment_voucher
    ADD CONSTRAINT finance_payment_voucher_warehouse_id_f9d89734_fk_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES public.warehouse(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_receipt_voucher finance_receipt_vouc_account_head_id_9c536327_fk_finance_a; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_receipt_voucher
    ADD CONSTRAINT finance_receipt_vouc_account_head_id_9c536327_fk_finance_a FOREIGN KEY (account_head_id) REFERENCES public.finance_account_head(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_receipt_voucher finance_receipt_vouc_bank_id_f02521ee_fk_finance_b; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_receipt_voucher
    ADD CONSTRAINT finance_receipt_vouc_bank_id_f02521ee_fk_finance_b FOREIGN KEY (bank_id) REFERENCES public.finance_bank_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_receipt_voucher finance_receipt_vouc_financial_year_id_466dd990_fk_finance_f; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_receipt_voucher
    ADD CONSTRAINT finance_receipt_vouc_financial_year_id_466dd990_fk_finance_f FOREIGN KEY (financial_year_id) REFERENCES public.finance_financial_year(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_receipt_voucher finance_receipt_voucher_creator_id_afe023e4_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_receipt_voucher
    ADD CONSTRAINT finance_receipt_voucher_creator_id_afe023e4_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_receipt_voucher finance_receipt_voucher_updater_id_d5ead95d_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_receipt_voucher
    ADD CONSTRAINT finance_receipt_voucher_updater_id_d5ead95d_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_receipt_voucher finance_receipt_voucher_warehouse_id_eae17eaf_fk_warehouse_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_receipt_voucher
    ADD CONSTRAINT finance_receipt_voucher_warehouse_id_eae17eaf_fk_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES public.warehouse(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_subledger_opening finance_subledger_op_account_head_id_840f0c30_fk_finance_a; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_subledger_opening
    ADD CONSTRAINT finance_subledger_op_account_head_id_840f0c30_fk_finance_a FOREIGN KEY (account_head_id) REFERENCES public.finance_account_head(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_subledger_opening finance_subledger_op_financial_year_id_77d7eff4_fk_finance_f; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_subledger_opening
    ADD CONSTRAINT finance_subledger_op_financial_year_id_77d7eff4_fk_finance_f FOREIGN KEY (financial_year_id) REFERENCES public.finance_financial_year(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_subledger_opening finance_subledger_opening_creator_id_4bfa2dcb_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_subledger_opening
    ADD CONSTRAINT finance_subledger_opening_creator_id_4bfa2dcb_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: finance_subledger_opening finance_subledger_opening_updater_id_7a927cd8_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.finance_subledger_opening
    ADD CONSTRAINT finance_subledger_opening_updater_id_7a927cd8_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: general_batch general_batch_creator_id_6ea88850_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.general_batch
    ADD CONSTRAINT general_batch_creator_id_6ea88850_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: general_batch general_batch_product_id_20668ccd_fk_products_product_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.general_batch
    ADD CONSTRAINT general_batch_product_id_20668ccd_fk_products_product_id FOREIGN KEY (product_id) REFERENCES public.products_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: general_batch general_batch_product_variant_id_055f6acb_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.general_batch
    ADD CONSTRAINT general_batch_product_variant_id_055f6acb_fk_products_ FOREIGN KEY (product_variant_id) REFERENCES public.products_product_variant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: general_batch general_batch_updater_id_b0d73f76_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.general_batch
    ADD CONSTRAINT general_batch_updater_id_b0d73f76_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: general_batch general_batch_warehouse_id_9696d936_fk_warehouse_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.general_batch
    ADD CONSTRAINT general_batch_warehouse_id_9696d936_fk_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES public.warehouse(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: general_charge_setting general_charge_setting_vendor_id_92256b26_fk_vendors_vendor_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.general_charge_setting
    ADD CONSTRAINT general_charge_setting_vendor_id_92256b26_fk_vendors_vendor_id FOREIGN KEY (vendor_id) REFERENCES public.vendors_vendor(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: general_charge_setting general_charge_setting_warehouse_id_5b651f0a_fk_warehouse_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.general_charge_setting
    ADD CONSTRAINT general_charge_setting_warehouse_id_5b651f0a_fk_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES public.warehouse(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: general_damaged_product general_damaged_prod_product_variant_id_4e9fbf30_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.general_damaged_product
    ADD CONSTRAINT general_damaged_prod_product_variant_id_4e9fbf30_fk_products_ FOREIGN KEY (product_variant_id) REFERENCES public.products_product_variant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: general_damaged_product general_damaged_product_batch_id_7eb10204_fk_general_batch_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.general_damaged_product
    ADD CONSTRAINT general_damaged_product_batch_id_7eb10204_fk_general_batch_id FOREIGN KEY (batch_id) REFERENCES public.general_batch(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: general_damaged_product general_damaged_product_creator_id_2639440e_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.general_damaged_product
    ADD CONSTRAINT general_damaged_product_creator_id_2639440e_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: general_damaged_product general_damaged_product_updater_id_46cfb8dd_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.general_damaged_product
    ADD CONSTRAINT general_damaged_product_updater_id_46cfb8dd_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: general_damaged_product general_damaged_product_warehouse_id_5ad29b00_fk_warehouse_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.general_damaged_product
    ADD CONSTRAINT general_damaged_product_warehouse_id_5ad29b00_fk_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES public.warehouse(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: general_delivery_charge general_delivery_charge_to_zone_id_039dd59b_fk_zone_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.general_delivery_charge
    ADD CONSTRAINT general_delivery_charge_to_zone_id_039dd59b_fk_zone_id FOREIGN KEY (to_zone_id) REFERENCES public.zone(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: general_delivery_charge general_delivery_charge_vendor_id_c4a38f7c_fk_vendors_vendor_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.general_delivery_charge
    ADD CONSTRAINT general_delivery_charge_vendor_id_c4a38f7c_fk_vendors_vendor_id FOREIGN KEY (vendor_id) REFERENCES public.vendors_vendor(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: general_delivery_charge general_delivery_charge_warehouse_id_443ee827_fk_warehouse_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.general_delivery_charge
    ADD CONSTRAINT general_delivery_charge_warehouse_id_443ee827_fk_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES public.warehouse(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: invoic_prefix invoic_prefix_creator_id_fa166727_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.invoic_prefix
    ADD CONSTRAINT invoic_prefix_creator_id_fa166727_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: invoic_prefix invoic_prefix_financial_year_id_c0145277_fk_finance_f; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.invoic_prefix
    ADD CONSTRAINT invoic_prefix_financial_year_id_c0145277_fk_finance_f FOREIGN KEY (financial_year_id) REFERENCES public.finance_financial_year(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: invoic_prefix invoic_prefix_updater_id_aa0be792_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.invoic_prefix
    ADD CONSTRAINT invoic_prefix_updater_id_aa0be792_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: invoice_design invoice_design_creator_id_4a6b4885_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.invoice_design
    ADD CONSTRAINT invoice_design_creator_id_4a6b4885_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: invoice_design invoice_design_updater_id_107cd5c0_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.invoice_design
    ADD CONSTRAINT invoice_design_updater_id_107cd5c0_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: invoice_design invoice_design_warehouse_id_3869b6ea_fk_warehouse_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.invoice_design
    ADD CONSTRAINT invoice_design_warehouse_id_3869b6ea_fk_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES public.warehouse(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: location location_creator_id_0907a9b4_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.location
    ADD CONSTRAINT location_creator_id_0907a9b4_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: location location_updater_id_ca2da178_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.location
    ADD CONSTRAINT location_updater_id_ca2da178_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offers offers_category_id_5c4d6d5e_fk_products_category_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_category_id_5c4d6d5e_fk_products_category_id FOREIGN KEY (category_id) REFERENCES public.products_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offers offers_creator_id_9bf8c888_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_creator_id_9bf8c888_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offers offers_product_variant_id_58f87d65_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_product_variant_id_58f87d65_fk_products_ FOREIGN KEY (product_variant_id) REFERENCES public.products_product_variant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offers offers_subcategory_id_931759be_fk_products_sub_category_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_subcategory_id_931759be_fk_products_sub_category_id FOREIGN KEY (subcategory_id) REFERENCES public.products_sub_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offers offers_updater_id_f49d637b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_updater_id_f49d637b_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offers_vouchercode offers_vouchercode_creator_id_80269e0d_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.offers_vouchercode
    ADD CONSTRAINT offers_vouchercode_creator_id_80269e0d_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offers_vouchercode offers_vouchercode_customer_id_197cbef2_fk_customers; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.offers_vouchercode
    ADD CONSTRAINT offers_vouchercode_customer_id_197cbef2_fk_customers FOREIGN KEY (customer_id) REFERENCES public.customers_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offers_vouchercode offers_vouchercode_product_id_55258afe_fk_products_product_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.offers_vouchercode
    ADD CONSTRAINT offers_vouchercode_product_id_55258afe_fk_products_product_id FOREIGN KEY (product_id) REFERENCES public.products_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offers_vouchercode offers_vouchercode_product_variant_id_123fc773_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.offers_vouchercode
    ADD CONSTRAINT offers_vouchercode_product_variant_id_123fc773_fk_products_ FOREIGN KEY (product_variant_id) REFERENCES public.products_product_variant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offers_vouchercode_used_users offers_vouchercode_u_vouchercode_id_6318e92e_fk_offers_vo; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.offers_vouchercode_used_users
    ADD CONSTRAINT offers_vouchercode_u_vouchercode_id_6318e92e_fk_offers_vo FOREIGN KEY (vouchercode_id) REFERENCES public.offers_vouchercode(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offers_vouchercode offers_vouchercode_updater_id_0e238778_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.offers_vouchercode
    ADD CONSTRAINT offers_vouchercode_updater_id_0e238778_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offers_vouchercode_used_users offers_vouchercode_used_users_user_id_be265f61_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.offers_vouchercode_used_users
    ADD CONSTRAINT offers_vouchercode_used_users_user_id_be265f61_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: offers offers_warehouse_id_fc467b97_fk_warehouse_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_warehouse_id_fc467b97_fk_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES public.warehouse(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_booking orders_booking_customer_id_34e64a17_fk_customers_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.orders_booking
    ADD CONSTRAINT orders_booking_customer_id_34e64a17_fk_customers_customer_id FOREIGN KEY (customer_id) REFERENCES public.customers_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_booking orders_booking_order_id_19db7154_fk_orders_orders_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.orders_booking
    ADD CONSTRAINT orders_booking_order_id_19db7154_fk_orders_orders_id FOREIGN KEY (order_id) REFERENCES public.orders_orders(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_booking orders_booking_product_variant_id_8e682975_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.orders_booking
    ADD CONSTRAINT orders_booking_product_variant_id_8e682975_fk_products_ FOREIGN KEY (product_variant_id) REFERENCES public.products_product_variant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_orderitem orders_orderitem_batch_id_04b36d63_fk_general_batch_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.orders_orderitem
    ADD CONSTRAINT orders_orderitem_batch_id_04b36d63_fk_general_batch_id FOREIGN KEY (batch_id) REFERENCES public.general_batch(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_orderitem orders_orderitem_order_id_fe61a34d_fk_orders_orders_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.orders_orderitem
    ADD CONSTRAINT orders_orderitem_order_id_fe61a34d_fk_orders_orders_id FOREIGN KEY (order_id) REFERENCES public.orders_orders(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_orderitem orders_orderitem_product_variant_id_148aec19_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.orders_orderitem
    ADD CONSTRAINT orders_orderitem_product_variant_id_148aec19_fk_products_ FOREIGN KEY (product_variant_id) REFERENCES public.products_product_variant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_orders orders_orders_creator_id_a00589be_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.orders_orders
    ADD CONSTRAINT orders_orders_creator_id_a00589be_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_orders orders_orders_customer_id_b5742c78_fk_customers_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.orders_orders
    ADD CONSTRAINT orders_orders_customer_id_b5742c78_fk_customers_customer_id FOREIGN KEY (customer_id) REFERENCES public.customers_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_orders orders_orders_delivery_agent_id_c5706fa1_fk_delivery_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.orders_orders
    ADD CONSTRAINT orders_orders_delivery_agent_id_c5706fa1_fk_delivery_ FOREIGN KEY (delivery_agent_id) REFERENCES public.delivery_agent_delivery_agent(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_orders orders_orders_prefix_id_c6c8bfa2_fk_invoic_prefix_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.orders_orders
    ADD CONSTRAINT orders_orders_prefix_id_c6c8bfa2_fk_invoic_prefix_id FOREIGN KEY (prefix_id) REFERENCES public.invoic_prefix(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_orders orders_orders_receipt_voucher_id_6315824f_fk_finance_r; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.orders_orders
    ADD CONSTRAINT orders_orders_receipt_voucher_id_6315824f_fk_finance_r FOREIGN KEY (receipt_voucher_id) REFERENCES public.finance_receipt_voucher(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_orders orders_orders_time_slot_id_5bc4f1bb_fk_orders_timeslot_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.orders_orders
    ADD CONSTRAINT orders_orders_time_slot_id_5bc4f1bb_fk_orders_timeslot_id FOREIGN KEY (time_slot_id) REFERENCES public.orders_timeslot(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_orders orders_orders_updater_id_9ee949cd_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.orders_orders
    ADD CONSTRAINT orders_orders_updater_id_9ee949cd_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_orders orders_orders_vendor_id_fb9bbaef_fk_vendors_vendor_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.orders_orders
    ADD CONSTRAINT orders_orders_vendor_id_fb9bbaef_fk_vendors_vendor_id FOREIGN KEY (vendor_id) REFERENCES public.vendors_vendor(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_orders orders_orders_warehouse_id_62f83e3f_fk_warehouse_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.orders_orders
    ADD CONSTRAINT orders_orders_warehouse_id_62f83e3f_fk_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES public.warehouse(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_orders orders_orders_zone_id_9e98a9e1_fk_zone_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.orders_orders
    ADD CONSTRAINT orders_orders_zone_id_9e98a9e1_fk_zone_id FOREIGN KEY (zone_id) REFERENCES public.zone(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_timeslot orders_timeslot_creator_id_2e465d6b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.orders_timeslot
    ADD CONSTRAINT orders_timeslot_creator_id_2e465d6b_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: orders_timeslot orders_timeslot_updater_id_e1e17907_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.orders_timeslot
    ADD CONSTRAINT orders_timeslot_updater_id_e1e17907_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: privilege_point_history privilege_point_hist_customer_id_f28b1010_fk_customers; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.privilege_point_history
    ADD CONSTRAINT privilege_point_hist_customer_id_f28b1010_fk_customers FOREIGN KEY (customer_id) REFERENCES public.customers_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: privilege_points privilege_points_creator_id_e2ff39b1_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.privilege_points
    ADD CONSTRAINT privilege_points_creator_id_e2ff39b1_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: privilege_points privilege_points_updater_id_1cf14e45_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.privilege_points
    ADD CONSTRAINT privilege_points_updater_id_1cf14e45_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_hsn_code product_hsn_code_creator_id_c9ce9865_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.product_hsn_code
    ADD CONSTRAINT product_hsn_code_creator_id_c9ce9865_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_hsn_code product_hsn_code_unit_id_d76f5c9e_fk_products_unit_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.product_hsn_code
    ADD CONSTRAINT product_hsn_code_unit_id_d76f5c9e_fk_products_unit_id FOREIGN KEY (unit_id) REFERENCES public.products_unit(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_hsn_code product_hsn_code_updater_id_d41bd083_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.product_hsn_code
    ADD CONSTRAINT product_hsn_code_updater_id_d41bd083_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_stock product_stock_batch_id_58af0926_fk_general_batch_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.product_stock
    ADD CONSTRAINT product_stock_batch_id_58af0926_fk_general_batch_id FOREIGN KEY (batch_id) REFERENCES public.general_batch(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_stock product_stock_product_variant_id_5eb9072a_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.product_stock
    ADD CONSTRAINT product_stock_product_variant_id_5eb9072a_fk_products_ FOREIGN KEY (product_variant_id) REFERENCES public.products_product_variant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: product_stock product_stock_warehouse_id_6ab44a4b_fk_warehouse_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.product_stock
    ADD CONSTRAINT product_stock_warehouse_id_6ab44a4b_fk_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES public.warehouse(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_brand products_brand_creator_id_9af5a1d0_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_brand
    ADD CONSTRAINT products_brand_creator_id_9af5a1d0_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_brand products_brand_updater_id_476398fc_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_brand
    ADD CONSTRAINT products_brand_updater_id_476398fc_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_category products_category_creator_id_b64be08e_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_category
    ADD CONSTRAINT products_category_creator_id_b64be08e_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_category products_category_updater_id_d476cdeb_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_category
    ADD CONSTRAINT products_category_updater_id_d476cdeb_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_product products_product_brand_id_3e2e8fd1_fk_products_brand_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_product
    ADD CONSTRAINT products_product_brand_id_3e2e8fd1_fk_products_brand_id FOREIGN KEY (brand_id) REFERENCES public.products_brand(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_product products_product_category_id_9b594869_fk_products_category_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_product
    ADD CONSTRAINT products_product_category_id_9b594869_fk_products_category_id FOREIGN KEY (category_id) REFERENCES public.products_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_product products_product_creator_id_34c5af30_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_product
    ADD CONSTRAINT products_product_creator_id_34c5af30_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_product products_product_hsn_id_5b962fea_fk_product_hsn_code_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_product
    ADD CONSTRAINT products_product_hsn_id_5b962fea_fk_product_hsn_code_id FOREIGN KEY (hsn_id) REFERENCES public.product_hsn_code(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_product_image products_product_ima_product_variant_id_a98efec2_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_product_image
    ADD CONSTRAINT products_product_ima_product_variant_id_a98efec2_fk_products_ FOREIGN KEY (product_variant_id) REFERENCES public.products_product_variant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_product_image products_product_image_creator_id_14270e46_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_product_image
    ADD CONSTRAINT products_product_image_creator_id_14270e46_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_product_image products_product_image_updater_id_18053b63_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_product_image
    ADD CONSTRAINT products_product_image_updater_id_18053b63_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_product products_product_special_category_id_0882a913_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_product
    ADD CONSTRAINT products_product_special_category_id_0882a913_fk_products_ FOREIGN KEY (special_category_id) REFERENCES public.products_special_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_product products_product_subcategory_id_b28a1e3b_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_product
    ADD CONSTRAINT products_product_subcategory_id_b28a1e3b_fk_products_ FOREIGN KEY (subcategory_id) REFERENCES public.products_sub_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_product products_product_unit_of_measurement__ab58e750_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_product
    ADD CONSTRAINT products_product_unit_of_measurement__ab58e750_fk_products_ FOREIGN KEY (unit_of_measurement_id) REFERENCES public.products_unit_measurement(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_product products_product_updater_id_fe83239f_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_product
    ADD CONSTRAINT products_product_updater_id_fe83239f_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_product_variant products_product_var_colour_variation_id_315d48a6_fk_product_v; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_product_variant
    ADD CONSTRAINT products_product_var_colour_variation_id_315d48a6_fk_product_v FOREIGN KEY (colour_variation_id) REFERENCES public.product_variation_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_product_variant products_product_var_other_variation_id_c6323f0e_fk_product_v; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_product_variant
    ADD CONSTRAINT products_product_var_other_variation_id_c6323f0e_fk_product_v FOREIGN KEY (other_variation_id) REFERENCES public.product_variation_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_product_variant products_product_var_product_id_f5ced6a1_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_product_variant
    ADD CONSTRAINT products_product_var_product_id_f5ced6a1_fk_products_ FOREIGN KEY (product_id) REFERENCES public.products_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_product_variant products_product_var_size_variation_id_455901a4_fk_product_v; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_product_variant
    ADD CONSTRAINT products_product_var_size_variation_id_455901a4_fk_product_v FOREIGN KEY (size_variation_id) REFERENCES public.product_variation_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_product_variant products_product_variant_creator_id_dd4f67b2_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_product_variant
    ADD CONSTRAINT products_product_variant_creator_id_dd4f67b2_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_product_variant products_product_variant_unit_id_4a7f296a_fk_products_unit_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_product_variant
    ADD CONSTRAINT products_product_variant_unit_id_4a7f296a_fk_products_unit_id FOREIGN KEY (unit_id) REFERENCES public.products_unit(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_product_variant products_product_variant_updater_id_cbe07c07_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_product_variant
    ADD CONSTRAINT products_product_variant_updater_id_cbe07c07_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_product_variant products_product_variant_warehouse_id_fde4c94d_fk_warehouse_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_product_variant
    ADD CONSTRAINT products_product_variant_warehouse_id_fde4c94d_fk_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES public.warehouse(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_product products_product_vendor_id_4c43277c_fk_vendors_vendor_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_product
    ADD CONSTRAINT products_product_vendor_id_4c43277c_fk_vendors_vendor_id FOREIGN KEY (vendor_id) REFERENCES public.vendors_vendor(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_special_category products_special_category_creator_id_3c1b6926_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_special_category
    ADD CONSTRAINT products_special_category_creator_id_3c1b6926_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_special_category products_special_category_updater_id_11b131a6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_special_category
    ADD CONSTRAINT products_special_category_updater_id_11b131a6_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_sub_category products_sub_categor_category_id_6587a3a2_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_sub_category
    ADD CONSTRAINT products_sub_categor_category_id_6587a3a2_fk_products_ FOREIGN KEY (category_id) REFERENCES public.products_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_sub_category products_sub_category_creator_id_27a63ae7_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_sub_category
    ADD CONSTRAINT products_sub_category_creator_id_27a63ae7_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_sub_category products_sub_category_updater_id_9052720c_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_sub_category
    ADD CONSTRAINT products_sub_category_updater_id_9052720c_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_unit products_unit_creator_id_8b6518e9_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_unit
    ADD CONSTRAINT products_unit_creator_id_8b6518e9_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_unit_measurement products_unit_measurement_creator_id_26356ff1_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_unit_measurement
    ADD CONSTRAINT products_unit_measurement_creator_id_26356ff1_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_unit_measurement products_unit_measurement_updater_id_d8e12c40_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_unit_measurement
    ADD CONSTRAINT products_unit_measurement_updater_id_d8e12c40_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_unit products_unit_unit_of_measurement__a326b2ac_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_unit
    ADD CONSTRAINT products_unit_unit_of_measurement__a326b2ac_fk_products_ FOREIGN KEY (unit_of_measurement_id) REFERENCES public.products_unit_measurement(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: products_unit products_unit_updater_id_7f8d8a05_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.products_unit
    ADD CONSTRAINT products_unit_updater_id_7f8d8a05_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase purchase_creator_id_63d20283_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT purchase_creator_id_63d20283_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_item purchase_item_batch_id_07ed9f91_fk_general_batch_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase_item
    ADD CONSTRAINT purchase_item_batch_id_07ed9f91_fk_general_batch_id FOREIGN KEY (batch_id) REFERENCES public.general_batch(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_item purchase_item_product_variant_id_9d882c83_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase_item
    ADD CONSTRAINT purchase_item_product_variant_id_9d882c83_fk_products_ FOREIGN KEY (product_variant_id) REFERENCES public.products_product_variant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_item purchase_item_purchase_id_ae31d28e_fk_purchase_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase_item
    ADD CONSTRAINT purchase_item_purchase_id_ae31d28e_fk_purchase_id FOREIGN KEY (purchase_id) REFERENCES public.purchase(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_order purchase_order_creator_id_ab7196ed_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase_order
    ADD CONSTRAINT purchase_order_creator_id_ab7196ed_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_order_item purchase_order_item_batch_id_6ac5076d_fk_general_batch_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase_order_item
    ADD CONSTRAINT purchase_order_item_batch_id_6ac5076d_fk_general_batch_id FOREIGN KEY (batch_id) REFERENCES public.general_batch(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_order_item purchase_order_item_product_variant_id_a492e653_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase_order_item
    ADD CONSTRAINT purchase_order_item_product_variant_id_a492e653_fk_products_ FOREIGN KEY (product_variant_id) REFERENCES public.products_product_variant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_order_item purchase_order_item_purchase_order_id_acc6db73_fk_purchase_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase_order_item
    ADD CONSTRAINT purchase_order_item_purchase_order_id_acc6db73_fk_purchase_ FOREIGN KEY (purchase_order_id) REFERENCES public.purchase_order(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_order purchase_order_purchase_id_e04a6a73_fk_purchase_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase_order
    ADD CONSTRAINT purchase_order_purchase_id_e04a6a73_fk_purchase_id FOREIGN KEY (purchase_id) REFERENCES public.purchase(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_order purchase_order_supplier_id_f3ce40ee_fk_suppliers_supplier_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase_order
    ADD CONSTRAINT purchase_order_supplier_id_f3ce40ee_fk_suppliers_supplier_id FOREIGN KEY (supplier_id) REFERENCES public.suppliers_supplier(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_order purchase_order_updater_id_507f1761_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase_order
    ADD CONSTRAINT purchase_order_updater_id_507f1761_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_order purchase_order_warehouse_id_2bb9b357_fk_warehouse_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase_order
    ADD CONSTRAINT purchase_order_warehouse_id_2bb9b357_fk_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES public.warehouse(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase purchase_payment_voucher_id_d578c30d_fk_finance_p; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT purchase_payment_voucher_id_d578c30d_fk_finance_p FOREIGN KEY (payment_voucher_id) REFERENCES public.finance_payment_voucher(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase purchase_purchase_prefix_id_faca0061_fk_invoic_prefix_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT purchase_purchase_prefix_id_faca0061_fk_invoic_prefix_id FOREIGN KEY (purchase_prefix_id) REFERENCES public.invoic_prefix(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_return purchase_return_creator_id_6f14c0b2_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase_return
    ADD CONSTRAINT purchase_return_creator_id_6f14c0b2_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_return_item purchase_return_item_batch_id_f29045d2_fk_general_batch_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase_return_item
    ADD CONSTRAINT purchase_return_item_batch_id_f29045d2_fk_general_batch_id FOREIGN KEY (batch_id) REFERENCES public.general_batch(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_return_item purchase_return_item_product_id_c8dac44f_fk_products_product_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase_return_item
    ADD CONSTRAINT purchase_return_item_product_id_c8dac44f_fk_products_product_id FOREIGN KEY (product_id) REFERENCES public.products_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_return_item purchase_return_item_product_variant_id_3b06df43_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase_return_item
    ADD CONSTRAINT purchase_return_item_product_variant_id_3b06df43_fk_products_ FOREIGN KEY (product_variant_id) REFERENCES public.products_product_variant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_return_item purchase_return_item_purchase_item_id_0620450f_fk_purchase_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase_return_item
    ADD CONSTRAINT purchase_return_item_purchase_item_id_0620450f_fk_purchase_ FOREIGN KEY (purchase_item_id) REFERENCES public.purchase_item(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_return_item purchase_return_item_purchase_return_id_22f49d0e_fk_purchase_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase_return_item
    ADD CONSTRAINT purchase_return_item_purchase_return_id_22f49d0e_fk_purchase_ FOREIGN KEY (purchase_return_id) REFERENCES public.purchase_return(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_return purchase_return_purchase_id_b1b9da4e_fk_purchase_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase_return
    ADD CONSTRAINT purchase_return_purchase_id_b1b9da4e_fk_purchase_id FOREIGN KEY (purchase_id) REFERENCES public.purchase(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_return purchase_return_supplier_id_3b6c26db_fk_suppliers_supplier_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase_return
    ADD CONSTRAINT purchase_return_supplier_id_3b6c26db_fk_suppliers_supplier_id FOREIGN KEY (supplier_id) REFERENCES public.suppliers_supplier(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase_return purchase_return_updater_id_6cd3dd53_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase_return
    ADD CONSTRAINT purchase_return_updater_id_6cd3dd53_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase purchase_supplier_id_efe205b7_fk_suppliers_supplier_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT purchase_supplier_id_efe205b7_fk_suppliers_supplier_id FOREIGN KEY (supplier_id) REFERENCES public.suppliers_supplier(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase purchase_updater_id_8b151978_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT purchase_updater_id_8b151978_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: purchase purchase_warehouse_id_f6182a98_fk_warehouse_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.purchase
    ADD CONSTRAINT purchase_warehouse_id_f6182a98_fk_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES public.warehouse(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: registration_registrationprofile registration_registr_user_id_5fcbf725_fk_auth_user; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.registration_registrationprofile
    ADD CONSTRAINT registration_registr_user_id_5fcbf725_fk_auth_user FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: registration_supervisedregistrationprofile registration_supervisedre_registrationprofile_ptr_i_0a59f3b2_fk; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.registration_supervisedregistrationprofile
    ADD CONSTRAINT registration_supervisedre_registrationprofile_ptr_i_0a59f3b2_fk FOREIGN KEY (registrationprofile_ptr_id) REFERENCES public.registration_registrationprofile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: return_images return_images_creator_id_f2483bd1_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.return_images
    ADD CONSTRAINT return_images_creator_id_f2483bd1_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: return_images return_images_product_return_id_29d1c8fd_fk_web_produ; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.return_images
    ADD CONSTRAINT return_images_product_return_id_29d1c8fd_fk_web_produ FOREIGN KEY (product_return_id) REFERENCES public.web_productreturn(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: return_images return_images_updater_id_ce2109e0_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.return_images
    ADD CONSTRAINT return_images_updater_id_ce2109e0_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: salary_pay salary_pay_creator_id_7fe1b925_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.salary_pay
    ADD CONSTRAINT salary_pay_creator_id_7fe1b925_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: salary_pay salary_pay_staff_id_7308fc7a_fk_staff_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.salary_pay
    ADD CONSTRAINT salary_pay_staff_id_7308fc7a_fk_staff_id FOREIGN KEY (staff_id) REFERENCES public.staff(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: salary_pay salary_pay_updater_id_9094dbe1_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.salary_pay
    ADD CONSTRAINT salary_pay_updater_id_9094dbe1_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sale_return sale_return_creator_id_ca4dfdc8_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.sale_return
    ADD CONSTRAINT sale_return_creator_id_ca4dfdc8_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sale_return sale_return_customer_id_2dbf9690_fk_customers_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.sale_return
    ADD CONSTRAINT sale_return_customer_id_2dbf9690_fk_customers_customer_id FOREIGN KEY (customer_id) REFERENCES public.customers_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sale_return_item sale_return_item_batch_id_a264bc1a_fk_general_batch_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.sale_return_item
    ADD CONSTRAINT sale_return_item_batch_id_a264bc1a_fk_general_batch_id FOREIGN KEY (batch_id) REFERENCES public.general_batch(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sale_return_item sale_return_item_product_id_b74d2eab_fk_products_product_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.sale_return_item
    ADD CONSTRAINT sale_return_item_product_id_b74d2eab_fk_products_product_id FOREIGN KEY (product_id) REFERENCES public.products_product(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sale_return_item sale_return_item_product_variant_id_e61feb36_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.sale_return_item
    ADD CONSTRAINT sale_return_item_product_variant_id_e61feb36_fk_products_ FOREIGN KEY (product_variant_id) REFERENCES public.products_product_variant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sale_return_item sale_return_item_sale_item_id_86bf752a_fk_sales_sale_item_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.sale_return_item
    ADD CONSTRAINT sale_return_item_sale_item_id_86bf752a_fk_sales_sale_item_id FOREIGN KEY (sale_item_id) REFERENCES public.sales_sale_item(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sale_return_item sale_return_item_sale_return_id_69ce4fd8_fk_sale_return_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.sale_return_item
    ADD CONSTRAINT sale_return_item_sale_return_id_69ce4fd8_fk_sale_return_id FOREIGN KEY (sale_return_id) REFERENCES public.sale_return(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sale_return sale_return_sale_id_5cb39e41_fk_sales_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.sale_return
    ADD CONSTRAINT sale_return_sale_id_5cb39e41_fk_sales_id FOREIGN KEY (sale_id) REFERENCES public.sales(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sale_return sale_return_updater_id_35e400db_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.sale_return
    ADD CONSTRAINT sale_return_updater_id_35e400db_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sale_return sale_return_warehouse_id_870f2b0c_fk_warehouse_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.sale_return
    ADD CONSTRAINT sale_return_warehouse_id_870f2b0c_fk_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES public.warehouse(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales sales_creator_id_d767af96_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_creator_id_d767af96_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales sales_customer_id_b4959801_fk_customers_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_customer_id_b4959801_fk_customers_customer_id FOREIGN KEY (customer_id) REFERENCES public.customers_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales sales_receipt_voucher_id_161ab400_fk_finance_receipt_voucher_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_receipt_voucher_id_161ab400_fk_finance_receipt_voucher_id FOREIGN KEY (receipt_voucher_id) REFERENCES public.finance_receipt_voucher(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_sale_item sales_sale_item_batch_id_7abe5bf7_fk_general_batch_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.sales_sale_item
    ADD CONSTRAINT sales_sale_item_batch_id_7abe5bf7_fk_general_batch_id FOREIGN KEY (batch_id) REFERENCES public.general_batch(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_sale_item sales_sale_item_product_variant_id_b2c2abdf_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.sales_sale_item
    ADD CONSTRAINT sales_sale_item_product_variant_id_b2c2abdf_fk_products_ FOREIGN KEY (product_variant_id) REFERENCES public.products_product_variant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales_sale_item sales_sale_item_sale_id_76eaa814_fk_sales_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.sales_sale_item
    ADD CONSTRAINT sales_sale_item_sale_id_76eaa814_fk_sales_id FOREIGN KEY (sale_id) REFERENCES public.sales(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales sales_sale_prefix_id_c62f025c_fk_invoic_prefix_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_sale_prefix_id_c62f025c_fk_invoic_prefix_id FOREIGN KEY (sale_prefix_id) REFERENCES public.invoic_prefix(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales sales_updater_id_a64fa776_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_updater_id_a64fa776_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: sales sales_warehouse_id_84e0b516_fk_warehouse_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_warehouse_id_84e0b516_fk_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES public.warehouse(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: special_variant special_variant_created_variant_id_493d4ae2_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.special_variant
    ADD CONSTRAINT special_variant_created_variant_id_493d4ae2_fk_products_ FOREIGN KEY (created_variant_id) REFERENCES public.products_product_variant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: special_variant special_variant_creator_id_9a2f8939_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.special_variant
    ADD CONSTRAINT special_variant_creator_id_9a2f8939_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: special_variant_product_variant special_variant_prod_productvariant_id_f2415396_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.special_variant_product_variant
    ADD CONSTRAINT special_variant_prod_productvariant_id_f2415396_fk_products_ FOREIGN KEY (productvariant_id) REFERENCES public.products_product_variant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: special_variant_product_variant special_variant_prod_specialvariant_id_7b1e7b1b_fk_special_v; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.special_variant_product_variant
    ADD CONSTRAINT special_variant_prod_specialvariant_id_7b1e7b1b_fk_special_v FOREIGN KEY (specialvariant_id) REFERENCES public.special_variant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: special_variant special_variant_updater_id_708ebca3_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.special_variant
    ADD CONSTRAINT special_variant_updater_id_708ebca3_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: staff_attendence staff_attendence_creator_id_0920f368_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.staff_attendence
    ADD CONSTRAINT staff_attendence_creator_id_0920f368_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: staff_attendence staff_attendence_staff_id_d6748ba4_fk_staff_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.staff_attendence
    ADD CONSTRAINT staff_attendence_staff_id_d6748ba4_fk_staff_id FOREIGN KEY (staff_id) REFERENCES public.staff(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: staff_attendence staff_attendence_updater_id_8281af3a_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.staff_attendence
    ADD CONSTRAINT staff_attendence_updater_id_8281af3a_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: staff staff_creator_id_3adcbdeb_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_creator_id_3adcbdeb_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: staff staff_designation_id_5370c180_fk_designation_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_designation_id_5370c180_fk_designation_id FOREIGN KEY (designation_id) REFERENCES public.designation(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: staff_permission staff_permission_permission_id_db9b3f33_fk_permission_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.staff_permission
    ADD CONSTRAINT staff_permission_permission_id_db9b3f33_fk_permission_id FOREIGN KEY (permission_id) REFERENCES public.permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: staff_permission staff_permission_staff_id_697f9421_fk_staff_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.staff_permission
    ADD CONSTRAINT staff_permission_staff_id_697f9421_fk_staff_id FOREIGN KEY (staff_id) REFERENCES public.staff(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: staff_salary_allowance staff_salary_allowance_creator_id_9f39108d_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.staff_salary_allowance
    ADD CONSTRAINT staff_salary_allowance_creator_id_9f39108d_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: staff_salary_allowance staff_salary_allowance_staff_id_7aa5764f_fk_staff_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.staff_salary_allowance
    ADD CONSTRAINT staff_salary_allowance_staff_id_7aa5764f_fk_staff_id FOREIGN KEY (staff_id) REFERENCES public.staff(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: staff_salary_allowance staff_salary_allowance_updater_id_0880b574_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.staff_salary_allowance
    ADD CONSTRAINT staff_salary_allowance_updater_id_0880b574_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: staff staff_updater_id_491d90f5_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_updater_id_491d90f5_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: staff staff_user_id_e6242ba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_user_id_e6242ba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: staff staff_warehouse_id_1ea8b77d_fk_warehouse_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_warehouse_id_1ea8b77d_fk_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES public.warehouse(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: stock_transfer stock_transfer_creator_id_917a3181_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.stock_transfer
    ADD CONSTRAINT stock_transfer_creator_id_917a3181_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: stock_transfer_items stock_transfer_items_batch_id_6e12881d_fk_general_batch_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.stock_transfer_items
    ADD CONSTRAINT stock_transfer_items_batch_id_6e12881d_fk_general_batch_id FOREIGN KEY (batch_id) REFERENCES public.general_batch(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: stock_transfer_items stock_transfer_items_creator_id_4aa0f9b4_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.stock_transfer_items
    ADD CONSTRAINT stock_transfer_items_creator_id_4aa0f9b4_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: stock_transfer_items stock_transfer_items_product_variant_id_10090a13_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.stock_transfer_items
    ADD CONSTRAINT stock_transfer_items_product_variant_id_10090a13_fk_products_ FOREIGN KEY (product_variant_id) REFERENCES public.products_product_variant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: stock_transfer_items stock_transfer_items_stock_transfer_id_8b4d6f0e_fk_stock_tra; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.stock_transfer_items
    ADD CONSTRAINT stock_transfer_items_stock_transfer_id_8b4d6f0e_fk_stock_tra FOREIGN KEY (stock_transfer_id) REFERENCES public.stock_transfer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: stock_transfer_items stock_transfer_items_updater_id_e94dc7ab_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.stock_transfer_items
    ADD CONSTRAINT stock_transfer_items_updater_id_e94dc7ab_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: stock_transfer stock_transfer_to_warehouse_id_9c565097_fk_warehouse_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.stock_transfer
    ADD CONSTRAINT stock_transfer_to_warehouse_id_9c565097_fk_warehouse_id FOREIGN KEY (to_warehouse_id) REFERENCES public.warehouse(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: stock_transfer stock_transfer_updater_id_daf05e5e_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.stock_transfer
    ADD CONSTRAINT stock_transfer_updater_id_daf05e5e_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: stock_transfer stock_transfer_warehouse_id_98a99844_fk_warehouse_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.stock_transfer
    ADD CONSTRAINT stock_transfer_warehouse_id_98a99844_fk_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES public.warehouse(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: stock_update stock_update_creator_id_cf29eb24_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.stock_update
    ADD CONSTRAINT stock_update_creator_id_cf29eb24_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: stock_update_item stock_update_item_batch_id_3fb160b5_fk_general_batch_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.stock_update_item
    ADD CONSTRAINT stock_update_item_batch_id_3fb160b5_fk_general_batch_id FOREIGN KEY (batch_id) REFERENCES public.general_batch(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: stock_update_item stock_update_item_product_variant_id_9156dec5_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.stock_update_item
    ADD CONSTRAINT stock_update_item_product_variant_id_9156dec5_fk_products_ FOREIGN KEY (product_variant_id) REFERENCES public.products_product_variant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: stock_update_item stock_update_item_stockupdate_id_79d2ec56_fk_stock_update_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.stock_update_item
    ADD CONSTRAINT stock_update_item_stockupdate_id_79d2ec56_fk_stock_update_id FOREIGN KEY (stockupdate_id) REFERENCES public.stock_update(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: stock_update stock_update_updater_id_412fb489_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.stock_update
    ADD CONSTRAINT stock_update_updater_id_412fb489_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: stock_update stock_update_warehouse_id_f0f5eea0_fk_warehouse_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.stock_update
    ADD CONSTRAINT stock_update_warehouse_id_f0f5eea0_fk_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES public.warehouse(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: students_registration_profile students_registration_profile_user_id_b4191036_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.students_registration_profile
    ADD CONSTRAINT students_registration_profile_user_id_b4191036_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: suppliers_supplier suppliers_supplier_creator_id_07cc976c_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.suppliers_supplier
    ADD CONSTRAINT suppliers_supplier_creator_id_07cc976c_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: suppliers_supplier suppliers_supplier_updater_id_a9a0014f_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.suppliers_supplier
    ADD CONSTRAINT suppliers_supplier_updater_id_a9a0014f_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: suppliers_supplier suppliers_supplier_user_id_1b86ec9a_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.suppliers_supplier
    ADD CONSTRAINT suppliers_supplier_user_id_1b86ec9a_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: techpe_staff_record techpe_staff_record_creator_id_9ea540ca_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.techpe_staff_record
    ADD CONSTRAINT techpe_staff_record_creator_id_9ea540ca_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: techpe_staff_record techpe_staff_record_staff_id_3b03ef2a_fk_staff_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.techpe_staff_record
    ADD CONSTRAINT techpe_staff_record_staff_id_3b03ef2a_fk_staff_id FOREIGN KEY (staff_id) REFERENCES public.staff(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: techpe_staff_record techpe_staff_record_updater_id_73376052_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.techpe_staff_record
    ADD CONSTRAINT techpe_staff_record_updater_id_73376052_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tickets tickets_creator_id_2fc0e6d2_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_creator_id_2fc0e6d2_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tickets tickets_customer_id_1778b1f7_fk_customers_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_customer_id_1778b1f7_fk_customers_customer_id FOREIGN KEY (customer_id) REFERENCES public.customers_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tickets tickets_updater_id_720df8cd_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_updater_id_720df8cd_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_cartitem users_cartitem_customer_id_3aa9bb25_fk_customers_customer_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.users_cartitem
    ADD CONSTRAINT users_cartitem_customer_id_3aa9bb25_fk_customers_customer_id FOREIGN KEY (customer_id) REFERENCES public.customers_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_cartitem users_cartitem_product_variant_id_2ffc31b9_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.users_cartitem
    ADD CONSTRAINT users_cartitem_product_variant_id_2ffc31b9_fk_products_ FOREIGN KEY (product_variant_id) REFERENCES public.products_product_variant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_cartitem users_cartitem_warehouse_id_65535620_fk_warehouse_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.users_cartitem
    ADD CONSTRAINT users_cartitem_warehouse_id_65535620_fk_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES public.warehouse(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_notification users_notification_customer_id_ddee569d_fk_customers; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.users_notification
    ADD CONSTRAINT users_notification_customer_id_ddee569d_fk_customers FOREIGN KEY (customer_id) REFERENCES public.customers_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_notification users_notification_order_id_26554506_fk_orders_orders_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.users_notification
    ADD CONSTRAINT users_notification_order_id_26554506_fk_orders_orders_id FOREIGN KEY (order_id) REFERENCES public.orders_orders(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_notification users_notification_subject_id_03f187af_fk_users_not; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.users_notification
    ADD CONSTRAINT users_notification_subject_id_03f187af_fk_users_not FOREIGN KEY (subject_id) REFERENCES public.users_notification_subject(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_notification users_notification_user_id_fed360c8_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.users_notification
    ADD CONSTRAINT users_notification_user_id_fed360c8_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_notification users_notification_who_id_1bc02fb3_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.users_notification
    ADD CONSTRAINT users_notification_who_id_1bc02fb3_fk_auth_user_id FOREIGN KEY (who_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_user_login users_user_login_user_id_1e0c5baa_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.users_user_login
    ADD CONSTRAINT users_user_login_user_id_1e0c5baa_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_wishlistitem users_wishlistitem_customer_id_3c1ca701_fk_customers; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.users_wishlistitem
    ADD CONSTRAINT users_wishlistitem_customer_id_3c1ca701_fk_customers FOREIGN KEY (customer_id) REFERENCES public.customers_customer(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_wishlistitem users_wishlistitem_product_variant_id_4f5db007_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.users_wishlistitem
    ADD CONSTRAINT users_wishlistitem_product_variant_id_4f5db007_fk_products_ FOREIGN KEY (product_variant_id) REFERENCES public.products_product_variant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vendors_commission vendors_commission_order_item_id_610ad1cb_fk_orders_or; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.vendors_commission
    ADD CONSTRAINT vendors_commission_order_item_id_610ad1cb_fk_orders_or FOREIGN KEY (order_item_id) REFERENCES public.orders_orderitem(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vendors_commission vendors_commission_vendor_id_46d0d483_fk_vendors_vendor_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.vendors_commission
    ADD CONSTRAINT vendors_commission_vendor_id_46d0d483_fk_vendors_vendor_id FOREIGN KEY (vendor_id) REFERENCES public.vendors_vendor(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vendors_vendor vendors_vendor_creator_id_f1bab48a_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.vendors_vendor
    ADD CONSTRAINT vendors_vendor_creator_id_f1bab48a_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vendors_vendor_deliverable_location vendors_vendor_deliv_vendor_id_a1286659_fk_vendors_v; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.vendors_vendor_deliverable_location
    ADD CONSTRAINT vendors_vendor_deliv_vendor_id_a1286659_fk_vendors_v FOREIGN KEY (vendor_id) REFERENCES public.vendors_vendor(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vendors_vendor_deliverable_location vendors_vendor_deliverable_location_zone_id_d15159a0_fk_zone_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.vendors_vendor_deliverable_location
    ADD CONSTRAINT vendors_vendor_deliverable_location_zone_id_d15159a0_fk_zone_id FOREIGN KEY (zone_id) REFERENCES public.zone(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vendors_vendor vendors_vendor_location_id_a62c69f7_fk_location_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.vendors_vendor
    ADD CONSTRAINT vendors_vendor_location_id_a62c69f7_fk_location_id FOREIGN KEY (location_id) REFERENCES public.location(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vendors_vendor vendors_vendor_updater_id_5e59b1f7_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.vendors_vendor
    ADD CONSTRAINT vendors_vendor_updater_id_5e59b1f7_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vendors_vendor vendors_vendor_user_id_14564ee2_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.vendors_vendor
    ADD CONSTRAINT vendors_vendor_user_id_14564ee2_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: vendors_vendor vendors_vendor_zone_id_ca06c82a_fk_zone_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.vendors_vendor
    ADD CONSTRAINT vendors_vendor_zone_id_ca06c82a_fk_zone_id FOREIGN KEY (zone_id) REFERENCES public.zone(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: warehouse warehouse_creator_id_ca390d1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.warehouse
    ADD CONSTRAINT warehouse_creator_id_ca390d1b_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: warehouse_deliverable_location warehouse_deliverabl_warehouse_id_c1f110a9_fk_warehouse; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.warehouse_deliverable_location
    ADD CONSTRAINT warehouse_deliverabl_warehouse_id_c1f110a9_fk_warehouse FOREIGN KEY (warehouse_id) REFERENCES public.warehouse(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: warehouse_deliverable_location warehouse_deliverable_location_zone_id_7cbfc158_fk_zone_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.warehouse_deliverable_location
    ADD CONSTRAINT warehouse_deliverable_location_zone_id_7cbfc158_fk_zone_id FOREIGN KEY (zone_id) REFERENCES public.zone(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: warehouse warehouse_location_id_00f5bf11_fk_location_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.warehouse
    ADD CONSTRAINT warehouse_location_id_00f5bf11_fk_location_id FOREIGN KEY (location_id) REFERENCES public.location(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: warehouse warehouse_manager_id_88a15ae0_fk_staff_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.warehouse
    ADD CONSTRAINT warehouse_manager_id_88a15ae0_fk_staff_id FOREIGN KEY (manager_id) REFERENCES public.staff(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: warehouse_no_express_delivery warehouse_no_express_delivery_zone_id_7dd21bfe_fk_zone_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.warehouse_no_express_delivery
    ADD CONSTRAINT warehouse_no_express_delivery_zone_id_7dd21bfe_fk_zone_id FOREIGN KEY (zone_id) REFERENCES public.zone(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: warehouse_no_express_delivery warehouse_no_express_warehouse_id_51219f49_fk_warehouse; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.warehouse_no_express_delivery
    ADD CONSTRAINT warehouse_no_express_warehouse_id_51219f49_fk_warehouse FOREIGN KEY (warehouse_id) REFERENCES public.warehouse(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: warehouse warehouse_updater_id_db0742a3_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.warehouse
    ADD CONSTRAINT warehouse_updater_id_db0742a3_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: warehouse warehouse_zone_id_09e97e47_fk_zone_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.warehouse
    ADD CONSTRAINT warehouse_zone_id_09e97e47_fk_zone_id FOREIGN KEY (zone_id) REFERENCES public.zone(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_FeauturedCategory web_FeauturedCategor_category_id_d455bce9_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public."web_FeauturedCategory"
    ADD CONSTRAINT "web_FeauturedCategor_category_id_d455bce9_fk_products_" FOREIGN KEY (category_id) REFERENCES public.products_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_FeauturedCategory web_FeauturedCategory_creator_id_0abe369e_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public."web_FeauturedCategory"
    ADD CONSTRAINT "web_FeauturedCategory_creator_id_0abe369e_fk_auth_user_id" FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_FeauturedCategory web_FeauturedCategory_updater_id_93ce2b27_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public."web_FeauturedCategory"
    ADD CONSTRAINT "web_FeauturedCategory_updater_id_93ce2b27_fk_auth_user_id" FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_TrendingCategory web_TrendingCategory_category_id_62630652_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public."web_TrendingCategory"
    ADD CONSTRAINT "web_TrendingCategory_category_id_62630652_fk_products_" FOREIGN KEY (category_id) REFERENCES public.products_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_TrendingCategory web_TrendingCategory_creator_id_42d034a2_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public."web_TrendingCategory"
    ADD CONSTRAINT "web_TrendingCategory_creator_id_42d034a2_fk_auth_user_id" FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_TrendingCategory web_TrendingCategory_updater_id_fc885942_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public."web_TrendingCategory"
    ADD CONSTRAINT "web_TrendingCategory_updater_id_fc885942_fk_auth_user_id" FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_productreturn web_productreturn_creator_id_ed38cc45_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.web_productreturn
    ADD CONSTRAINT web_productreturn_creator_id_ed38cc45_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_productreturn web_productreturn_customer_account_id_c06bfd0e_fk_customer_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.web_productreturn
    ADD CONSTRAINT web_productreturn_customer_account_id_c06bfd0e_fk_customer_ FOREIGN KEY (customer_account_id) REFERENCES public.customer_bank_account(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_productreturn web_productreturn_customer_address_id_22b0bf5b_fk_customers; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.web_productreturn
    ADD CONSTRAINT web_productreturn_customer_address_id_22b0bf5b_fk_customers FOREIGN KEY (customer_address_id) REFERENCES public.customers_customeraddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_productreturn web_productreturn_delivery_boy_id_0828cf82_fk_delivery_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.web_productreturn
    ADD CONSTRAINT web_productreturn_delivery_boy_id_0828cf82_fk_delivery_ FOREIGN KEY (delivery_boy_id) REFERENCES public.delivery_agent_delivery_agent(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_productreturn web_productreturn_order_id_731bb36a_fk_orders_orders_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.web_productreturn
    ADD CONSTRAINT web_productreturn_order_id_731bb36a_fk_orders_orders_id FOREIGN KEY (order_id) REFERENCES public.orders_orders(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_productreturn web_productreturn_order_item_id_7ed5e915_fk_orders_orderitem_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.web_productreturn
    ADD CONSTRAINT web_productreturn_order_item_id_7ed5e915_fk_orders_orderitem_id FOREIGN KEY (order_item_id) REFERENCES public.orders_orderitem(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_productreturn web_productreturn_updater_id_acc1ff48_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.web_productreturn
    ADD CONSTRAINT web_productreturn_updater_id_acc1ff48_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_productreview web_productreview_creator_id_3f7511d7_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.web_productreview
    ADD CONSTRAINT web_productreview_creator_id_3f7511d7_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_productreview web_productreview_product_variant_id_d2100523_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.web_productreview
    ADD CONSTRAINT web_productreview_product_variant_id_d2100523_fk_products_ FOREIGN KEY (product_variant_id) REFERENCES public.products_product_variant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_productreview web_productreview_updater_id_da352572_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.web_productreview
    ADD CONSTRAINT web_productreview_updater_id_da352572_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_spotlightbanner web_spotlightbanner_brand_id_5af72f13_fk_products_brand_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.web_spotlightbanner
    ADD CONSTRAINT web_spotlightbanner_brand_id_5af72f13_fk_products_brand_id FOREIGN KEY (brand_id) REFERENCES public.products_brand(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_spotlightbanner web_spotlightbanner_category_id_dcda9297_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.web_spotlightbanner
    ADD CONSTRAINT web_spotlightbanner_category_id_dcda9297_fk_products_ FOREIGN KEY (category_id) REFERENCES public.products_category(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_spotlightbanner web_spotlightbanner_creator_id_367149ad_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.web_spotlightbanner
    ADD CONSTRAINT web_spotlightbanner_creator_id_367149ad_fk_auth_user_id FOREIGN KEY (creator_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_spotlightbanner web_spotlightbanner_product_variant_id_ffccb843_fk_products_; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.web_spotlightbanner
    ADD CONSTRAINT web_spotlightbanner_product_variant_id_ffccb843_fk_products_ FOREIGN KEY (product_variant_id) REFERENCES public.products_product_variant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: web_spotlightbanner web_spotlightbanner_updater_id_b6c739d7_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: nexsme_live
--

ALTER TABLE ONLY public.web_spotlightbanner
    ADD CONSTRAINT web_spotlightbanner_updater_id_b6c739d7_fk_auth_user_id FOREIGN KEY (updater_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

