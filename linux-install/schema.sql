--
-- PostgreSQL database dump
--


-- Dumped from database version 17.10 (6a49db4)
-- Dumped by pg_dump version 17.9 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: neon_auth; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA neon_auth;


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: activity_action; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.activity_action AS ENUM (
    'agent_created',
    'agent_updated',
    'agent_paused',
    'agent_resumed',
    'agent_terminated',
    'issue_created',
    'issue_updated',
    'issue_status_changed',
    'issue_assigned',
    'project_created',
    'project_updated',
    'goal_created',
    'goal_updated',
    'approval_created',
    'approval_resolved',
    'run_started',
    'run_completed',
    'run_failed',
    'deliverable_created',
    'routine_triggered',
    'cost_recorded',
    'permission_denied',
    'task_claimed',
    'task_released',
    'heartbeat_started',
    'heartbeat_completed',
    'wake_received',
    'wake_rejected',
    'wake_chain_depth_exceeded',
    'budget_warning_80pct',
    'config_changed',
    'wake_requeued',
    'handoff_stalled',
    'storyline_generated',
    'wake_deferred',
    'goal_measurement_recorded',
    'goal_achieved',
    'goal_linked',
    'goal_suggested',
    'goal_accepted',
    'goal_rejected',
    'cos_handoff_skipped',
    'objective_decomposed',
    'objective_decomposition_empty',
    'review_requested_wake',
    'review_approved',
    'review_rejected',
    'review_loop_escalated',
    'objective_activation_failed',
    'review_handler_error',
    'inngest_proxy_call',
    'review_attempt_started',
    'review_skipped_in_flight',
    'review_no_decision',
    'review_blocked',
    'auto_push_failed',
    'review_skipped_document_evidence_required',
    'review_skipped_stable_outcome',
    'provider_health_degraded',
    'tool_executed',
    'dependencies_failed',
    'execution_paused_model_exhaustion',
    'execution_resumed',
    'blocker_opened',
    'blocker_resolved',
    'batch_finalized_at_cap',
    'batch_pass_checkpointed',
    'batch_job_routed'
);


--
-- Name: agent_role; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.agent_role AS ENUM (
    'cos',
    'growth',
    'operations',
    'product',
    'engineering',
    'risk_legal',
    'specialist',
    'general',
    'ceo',
    'observer'
);


--
-- Name: agent_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.agent_status AS ENUM (
    'idle',
    'active',
    'running',
    'paused',
    'error',
    'pending_approval',
    'terminated'
);


--
-- Name: approval_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.approval_status AS ENUM (
    'pending',
    'approved',
    'rejected',
    'revision_requested'
);


--
-- Name: approval_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.approval_type AS ENUM (
    'escalation',
    'hire_agent',
    'budget_change',
    'strategy_decision',
    'human_handoff',
    'copy_voice_select',
    'deliverable_execution'
);


--
-- Name: beta_status_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.beta_status_type AS ENUM (
    'active',
    'waitlisted'
);


--
-- Name: billing_model; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.billing_model AS ENUM (
    'pay_per_token',
    'flat_rate',
    'self_hosted'
);


--
-- Name: blog_post_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.blog_post_status AS ENUM (
    'draft',
    'published'
);


--
-- Name: business_phase; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.business_phase AS ENUM (
    'idea',
    'pre_launch',
    'early_revenue',
    'scaling',
    'mature'
);


--
-- Name: capability_tier; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.capability_tier AS ENUM (
    'router',
    'routine',
    'judgment',
    'frontier'
);


--
-- Name: catch_up_policy; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.catch_up_policy AS ENUM (
    'skip_missed',
    'enqueue_missed_with_cap'
);


--
-- Name: composio_recommendation_outcome; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.composio_recommendation_outcome AS ENUM (
    'connected',
    'dismissed',
    'ignored'
);


--
-- Name: concurrency_policy; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.concurrency_policy AS ENUM (
    'coalesce_if_active',
    'always_enqueue',
    'skip_if_active'
);


--
-- Name: deliverable_approval_state; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.deliverable_approval_state AS ENUM (
    'draft',
    'proposed',
    'revision_requested',
    'approved',
    'executing',
    'final',
    'rejected'
);


--
-- Name: deliverable_category; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.deliverable_category AS ENUM (
    'report',
    'draft',
    'analysis',
    'recommendation',
    'brief',
    'other',
    'document',
    'plan',
    'copy',
    'research',
    'template',
    'handoff'
);


--
-- Name: deliverable_section_kind; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.deliverable_section_kind AS ENUM (
    'overview',
    'timeline',
    'channel_plan',
    'kpi_table',
    'risks',
    'next_actions',
    'custom',
    'executive_summary',
    'data_table',
    'checklist',
    'code_block',
    'quote'
);


--
-- Name: deliverable_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.deliverable_status AS ENUM (
    'draft',
    'final'
);


--
-- Name: gate_class; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.gate_class AS ENUM (
    'free',
    'outbound',
    'golive',
    'irreversible',
    'financial'
);


--
-- Name: goal_level; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.goal_level AS ENUM (
    'company',
    'team',
    'agent',
    'task'
);


--
-- Name: goal_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.goal_status AS ENUM (
    'planned',
    'proposed',
    'active',
    'achieved',
    'cancelled',
    'monitoring'
);


--
-- Name: hub_channel_provider; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.hub_channel_provider AS ENUM (
    'gmail',
    'outlook',
    'twilio',
    'facebook',
    'twitter',
    'instagram',
    'whatsapp',
    'slack',
    'custom',
    'telegram',
    'discord',
    'teams',
    'intercom',
    'hubspot',
    'zendesk',
    'linkedin',
    'google_voice',
    'line',
    'wechat',
    'signal',
    'viber'
);


--
-- Name: hub_channel_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.hub_channel_status AS ENUM (
    'active',
    'paused',
    'error',
    'disconnected'
);


--
-- Name: hub_channel_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.hub_channel_type AS ENUM (
    'email',
    'sms',
    'social',
    'chat',
    'voice'
);


--
-- Name: hub_conversation_audience; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.hub_conversation_audience AS ENUM (
    'internal',
    'external'
);


--
-- Name: hub_conversation_priority; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.hub_conversation_priority AS ENUM (
    'low',
    'normal',
    'high',
    'urgent'
);


--
-- Name: hub_conversation_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.hub_conversation_status AS ENUM (
    'open',
    'snoozed',
    'archived',
    'closed'
);


--
-- Name: hub_message_direction; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.hub_message_direction AS ENUM (
    'inbound',
    'outbound'
);


--
-- Name: hub_participant_role; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.hub_participant_role AS ENUM (
    'from',
    'to',
    'cc',
    'bcc'
);


--
-- Name: issue_priority; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.issue_priority AS ENUM (
    'critical',
    'high',
    'medium',
    'low'
);


--
-- Name: issue_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.issue_status AS ENUM (
    'backlog',
    'todo',
    'on_hold',
    'paused',
    'in_progress',
    'in_review',
    'chief_review',
    'ceo_review',
    'done',
    'blocked',
    'cancelled',
    'waiting'
);


--
-- Name: memory_category; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.memory_category AS ENUM (
    'correction',
    'preference',
    'instruction',
    'context',
    'observation'
);


--
-- Name: memory_source; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.memory_source AS ENUM (
    'chat',
    'onboarding',
    'manual',
    'system'
);


--
-- Name: memory_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.memory_status AS ENUM (
    'captured',
    'embedded',
    'indexed',
    'active',
    'superseded'
);


--
-- Name: message_kind; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.message_kind AS ENUM (
    'chat',
    'issue_comment'
);


--
-- Name: message_role; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.message_role AS ENUM (
    'user',
    'assistant'
);


--
-- Name: message_visibility; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.message_visibility AS ENUM (
    'private',
    'team'
);


--
-- Name: model_weight_class; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.model_weight_class AS ENUM (
    'open',
    'frontier'
);


--
-- Name: policy_source; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.policy_source AS ENUM (
    'provider_meta',
    'llm',
    'curated',
    'heuristic'
);


--
-- Name: principal_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.principal_type AS ENUM (
    'user',
    'agent'
);


--
-- Name: project_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.project_status AS ENUM (
    'backlog',
    'planned',
    'in_progress',
    'completed',
    'cancelled',
    'active_standing'
);


--
-- Name: routine_run_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.routine_run_status AS ENUM (
    'received',
    'dispatched',
    'completed',
    'failed',
    'skipped'
);


--
-- Name: routine_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.routine_status AS ENUM (
    'active',
    'paused',
    'archived'
);


--
-- Name: routine_trigger_kind; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.routine_trigger_kind AS ENUM (
    'schedule',
    'webhook',
    'api'
);


--
-- Name: routing_preference; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.routing_preference AS ENUM (
    'open_optimized',
    'open_only',
    'frontier_only',
    'ask_each_time',
    'max_performance',
    'performance_optimized',
    'cost_optimized',
    'flat_rate_only'
);


--
-- Name: run_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.run_status AS ENUM (
    'queued',
    'running',
    'completed',
    'failed',
    'cancelled'
);


--
-- Name: task_domain; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.task_domain AS ENUM (
    'chat_general',
    'chat_interview',
    'routing',
    'extraction',
    'summarization',
    'analysis',
    'planning',
    'research',
    'decomposition',
    'code_frontend',
    'code_backend',
    'code_data',
    'code_devops',
    'code_review',
    'code_tests',
    'copy_short',
    'copy_long',
    'copy_email',
    'copy_sales',
    'copy_technical',
    'image_generation',
    'image_editing',
    'video_generation',
    'video_editing',
    'audio_generation'
);


--
-- Name: task_frequency; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.task_frequency AS ENUM (
    'daily',
    'weekly',
    'monthly'
);


--
-- Name: task_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.task_type AS ENUM (
    'copywriting',
    'coding',
    'research',
    'analysis',
    'outreach',
    'planning',
    'data',
    'general'
);


--
-- Name: tool_calling_quality; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.tool_calling_quality AS ENUM (
    'native',
    'unreliable',
    'none'
);


--
-- Name: user_role; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.user_role AS ENUM (
    'user',
    'admin'
);


--
-- Name: workspace_role; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.workspace_role AS ENUM (
    'owner',
    'admin',
    'member'
);


--
-- Name: jsonb_is_int_array(jsonb); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.jsonb_is_int_array(j jsonb) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $$ SELECT jsonb_typeof(j) = 'array' AND NOT EXISTS (SELECT 1 FROM jsonb_array_elements(j) e WHERE jsonb_typeof(e) <> 'number') $$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: account; Type: TABLE; Schema: neon_auth; Owner: -
--

CREATE TABLE neon_auth.account (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "accountId" text NOT NULL,
    "providerId" text NOT NULL,
    "userId" uuid NOT NULL,
    "accessToken" text,
    "refreshToken" text,
    "idToken" text,
    "accessTokenExpiresAt" timestamp with time zone,
    "refreshTokenExpiresAt" timestamp with time zone,
    scope text,
    password text,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


--
-- Name: invitation; Type: TABLE; Schema: neon_auth; Owner: -
--

CREATE TABLE neon_auth.invitation (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "organizationId" uuid NOT NULL,
    email text NOT NULL,
    role text,
    status text NOT NULL,
    "expiresAt" timestamp with time zone NOT NULL,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "inviterId" uuid NOT NULL
);


--
-- Name: jwks; Type: TABLE; Schema: neon_auth; Owner: -
--

CREATE TABLE neon_auth.jwks (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "publicKey" text NOT NULL,
    "privateKey" text NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "expiresAt" timestamp with time zone
);


--
-- Name: member; Type: TABLE; Schema: neon_auth; Owner: -
--

CREATE TABLE neon_auth.member (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "organizationId" uuid NOT NULL,
    "userId" uuid NOT NULL,
    role text NOT NULL,
    "createdAt" timestamp with time zone NOT NULL
);


--
-- Name: organization; Type: TABLE; Schema: neon_auth; Owner: -
--

CREATE TABLE neon_auth.organization (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    slug text NOT NULL,
    logo text,
    "createdAt" timestamp with time zone NOT NULL,
    metadata text
);


--
-- Name: project_config; Type: TABLE; Schema: neon_auth; Owner: -
--

CREATE TABLE neon_auth.project_config (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    endpoint_id text NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    trusted_origins jsonb NOT NULL,
    social_providers jsonb NOT NULL,
    email_provider jsonb,
    email_and_password jsonb,
    allow_localhost boolean NOT NULL,
    plugin_configs jsonb,
    webhook_config jsonb
);


--
-- Name: session; Type: TABLE; Schema: neon_auth; Owner: -
--

CREATE TABLE neon_auth.session (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    "expiresAt" timestamp with time zone NOT NULL,
    token text NOT NULL,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "ipAddress" text,
    "userAgent" text,
    "userId" uuid NOT NULL,
    "impersonatedBy" text,
    "activeOrganizationId" text
);


--
-- Name: user; Type: TABLE; Schema: neon_auth; Owner: -
--

CREATE TABLE neon_auth."user" (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    "emailVerified" boolean NOT NULL,
    image text,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    role text,
    banned boolean,
    "banReason" text,
    "banExpires" timestamp with time zone,
    "phoneNumber" text,
    "phoneNumberVerified" boolean
);


--
-- Name: verification; Type: TABLE; Schema: neon_auth; Owner: -
--

CREATE TABLE neon_auth.verification (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    identifier text NOT NULL,
    value text NOT NULL,
    "expiresAt" timestamp with time zone NOT NULL,
    "createdAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: accessibility_audit_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.accessibility_audit_items (
    id bigint NOT NULL,
    workspace_slug text,
    page_path text NOT NULL,
    wcag_criterion text NOT NULL,
    level text DEFAULT 'AA'::text NOT NULL,
    status text DEFAULT 'open'::text NOT NULL,
    severity text DEFAULT 'medium'::text NOT NULL,
    description text NOT NULL,
    remediation_notes text,
    owner_user_id integer,
    due_at timestamp with time zone,
    resolved_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: accessibility_audit_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.accessibility_audit_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: accessibility_audit_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.accessibility_audit_items_id_seq OWNED BY public.accessibility_audit_items.id;


--
-- Name: activity_log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.activity_log (
    id integer NOT NULL,
    user_id integer NOT NULL,
    action public.activity_action NOT NULL,
    agent_id integer,
    issue_id integer,
    project_id integer,
    run_id integer,
    detail jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    workspace_slug text NOT NULL
);


--
-- Name: activity_log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.activity_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: activity_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.activity_log_id_seq OWNED BY public.activity_log.id;


--
-- Name: agent_backlog; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.agent_backlog (
    id bigint NOT NULL,
    workspace_slug text NOT NULL,
    agent_id integer NOT NULL,
    issue_id integer NOT NULL,
    reason text NOT NULL,
    priority text NOT NULL,
    enqueued_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: agent_backlog_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.agent_backlog_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: agent_backlog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.agent_backlog_id_seq OWNED BY public.agent_backlog.id;


--
-- Name: agent_execution_locks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.agent_execution_locks (
    id bigint NOT NULL,
    workspace_slug text NOT NULL,
    user_id integer NOT NULL,
    agent_id integer NOT NULL,
    issue_id integer NOT NULL,
    lock_kind text NOT NULL,
    run_id bigint,
    reason text,
    acquired_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    released_at timestamp with time zone,
    release_reason text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: agent_execution_locks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.agent_execution_locks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: agent_execution_locks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.agent_execution_locks_id_seq OWNED BY public.agent_execution_locks.id;


--
-- Name: agent_keys; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.agent_keys (
    id integer NOT NULL,
    workspace_slug text NOT NULL,
    agent_id integer NOT NULL,
    name text NOT NULL,
    key_hash text NOT NULL,
    key_prefix text NOT NULL,
    last_used_at timestamp with time zone,
    revoked_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: agent_keys_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.agent_keys_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: agent_keys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.agent_keys_id_seq OWNED BY public.agent_keys.id;


--
-- Name: agent_model_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.agent_model_config (
    id integer NOT NULL,
    agent_id integer NOT NULL,
    profile_key text DEFAULT 'primary'::text NOT NULL,
    provider text NOT NULL,
    model text NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    composio_connection_id text,
    adapter_config jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    workspace_slug text NOT NULL
);


--
-- Name: agent_model_config_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.agent_model_config_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: agent_model_config_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.agent_model_config_id_seq OWNED BY public.agent_model_config.id;


--
-- Name: agent_runs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.agent_runs (
    id integer NOT NULL,
    user_id integer NOT NULL,
    agent_id integer NOT NULL,
    issue_id integer,
    invocation_source text DEFAULT 'chat'::text NOT NULL,
    trigger_detail text,
    status public.run_status DEFAULT 'queued'::public.run_status NOT NULL,
    started_at timestamp with time zone,
    finished_at timestamp with time zone,
    error text,
    model_provider text,
    model_name text,
    input_tokens integer DEFAULT 0 NOT NULL,
    output_tokens integer DEFAULT 0 NOT NULL,
    cost_cents integer DEFAULT 0 NOT NULL,
    result_json jsonb,
    context_snapshot jsonb,
    parent_run_id integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    workspace_slug text NOT NULL,
    progress_detected boolean DEFAULT false NOT NULL
);


--
-- Name: agent_runs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.agent_runs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: agent_runs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.agent_runs_id_seq OWNED BY public.agent_runs.id;


--
-- Name: agent_skills; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.agent_skills (
    id integer NOT NULL,
    agent_id integer NOT NULL,
    skill_id integer NOT NULL,
    workspace_slug text NOT NULL,
    granted_at timestamp with time zone DEFAULT now() NOT NULL,
    granted_by_user_id integer
);


--
-- Name: agent_skills_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.agent_skills_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: agent_skills_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.agent_skills_id_seq OWNED BY public.agent_skills.id;


--
-- Name: agent_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.agent_tokens (
    id integer NOT NULL,
    agent_id integer NOT NULL,
    workspace_slug text NOT NULL,
    token_hash text NOT NULL,
    permissions jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    rotated_at timestamp with time zone,
    revoked_at timestamp with time zone
);


--
-- Name: agent_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.agent_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: agent_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.agent_tokens_id_seq OWNED BY public.agent_tokens.id;


--
-- Name: agent_wakeup_requests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.agent_wakeup_requests (
    id bigint NOT NULL,
    workspace_slug text NOT NULL,
    agent_id integer NOT NULL,
    source text DEFAULT 'assignment'::text NOT NULL,
    trigger_detail text,
    reason text,
    payload jsonb,
    status text DEFAULT 'pending'::text NOT NULL,
    requested_by_actor_type text,
    requested_by_actor_id text,
    idempotency_key text,
    context_snapshot jsonb,
    requested_at timestamp with time zone DEFAULT now() NOT NULL,
    claimed_at timestamp with time zone,
    finished_at timestamp with time zone,
    error text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    attempts integer DEFAULT 0 NOT NULL,
    last_attempted_at timestamp with time zone
);


--
-- Name: agent_wakeup_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.agent_wakeup_requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: agent_wakeup_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.agent_wakeup_requests_id_seq OWNED BY public.agent_wakeup_requests.id;


--
-- Name: agents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.agents (
    id integer NOT NULL,
    user_id integer NOT NULL,
    name text NOT NULL,
    role public.agent_role DEFAULT 'general'::public.agent_role NOT NULL,
    title text,
    icon text,
    status public.agent_status DEFAULT 'idle'::public.agent_status NOT NULL,
    reports_to integer,
    capabilities text,
    adapter_type text DEFAULT 'openai'::text NOT NULL,
    adapter_config jsonb DEFAULT '{}'::jsonb NOT NULL,
    runtime_config jsonb DEFAULT '{}'::jsonb NOT NULL,
    model_provider text,
    model_name text,
    budget_monthly_cents integer DEFAULT 0 NOT NULL,
    spent_monthly_cents integer DEFAULT 0 NOT NULL,
    pause_reason text,
    paused_at timestamp with time zone,
    permissions jsonb DEFAULT '{}'::jsonb NOT NULL,
    last_heartbeat_at timestamp with time zone,
    metadata jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    routing_override public.routing_preference,
    workspace_slug text NOT NULL,
    instruction_body text,
    frontmatter jsonb DEFAULT '{}'::jsonb NOT NULL,
    last_budget_reset_month text,
    primary_domains jsonb
);


--
-- Name: agents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.agents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: agents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.agents_id_seq OWNED BY public.agents.id;


--
-- Name: app_cache; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.app_cache (
    cache_key character varying(255) NOT NULL,
    data jsonb NOT NULL,
    fetched_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: app_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.app_settings (
    key text NOT NULL,
    value jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: approvals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.approvals (
    id integer NOT NULL,
    user_id integer NOT NULL,
    type public.approval_type NOT NULL,
    requested_by_agent_id integer,
    status public.approval_status DEFAULT 'pending'::public.approval_status NOT NULL,
    payload jsonb DEFAULT '{}'::jsonb NOT NULL,
    decision_note text,
    decided_at timestamp with time zone,
    related_issue_id integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    workspace_slug text NOT NULL,
    deliverable_id integer,
    user_message jsonb,
    user_message_at timestamp with time zone
);


--
-- Name: approvals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.approvals_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: approvals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.approvals_id_seq OWNED BY public.approvals.id;


--
-- Name: archived_objects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.archived_objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    workspace_slug text NOT NULL,
    object_kind text NOT NULL,
    original_id text NOT NULL,
    r2_key text NOT NULL,
    size_bytes bigint NOT NULL,
    archived_at timestamp with time zone DEFAULT now() NOT NULL,
    restored_at timestamp with time zone,
    delete_after timestamp with time zone
);


--
-- Name: beta_access_log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.beta_access_log (
    id bigint NOT NULL,
    action text NOT NULL,
    email text,
    user_id bigint,
    workspace_slug text,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: beta_access_log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.beta_access_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: beta_access_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.beta_access_log_id_seq OWNED BY public.beta_access_log.id;


--
-- Name: beta_invitations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.beta_invitations (
    id bigint NOT NULL,
    email text NOT NULL,
    token_hash text NOT NULL,
    invited_by_user_id bigint,
    workspace_slug text,
    expires_at timestamp with time zone NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    accepted_at timestamp with time zone,
    accepted_by_user_id bigint,
    revoked_at timestamp with time zone
);


--
-- Name: beta_invitations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.beta_invitations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: beta_invitations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.beta_invitations_id_seq OWNED BY public.beta_invitations.id;


--
-- Name: blocker_digests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.blocker_digests (
    id bigint NOT NULL,
    workspace_slug text NOT NULL,
    group_key text NOT NULL,
    status text DEFAULT 'open'::text NOT NULL,
    title text NOT NULL,
    cause_summary text NOT NULL,
    action_text text NOT NULL,
    member_blocker_ids jsonb DEFAULT '[]'::jsonb NOT NULL,
    member_approval_ids jsonb DEFAULT '[]'::jsonb NOT NULL,
    affected_total integer DEFAULT 0 NOT NULL,
    message_thread_id text,
    message_id bigint,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    last_updated_at timestamp with time zone DEFAULT now() NOT NULL,
    resolved_at timestamp with time zone
);


--
-- Name: blocker_digests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.blocker_digests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: blocker_digests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.blocker_digests_id_seq OWNED BY public.blocker_digests.id;


--
-- Name: blog_posts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.blog_posts (
    id text NOT NULL,
    title text NOT NULL,
    slug text NOT NULL,
    content text DEFAULT ''::text NOT NULL,
    excerpt text,
    meta_description text,
    featured_image_url text,
    author_name text NOT NULL,
    status public.blog_post_status DEFAULT 'draft'::public.blog_post_status NOT NULL,
    tags text[] DEFAULT '{}'::text[] NOT NULL,
    published_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: business_profiles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.business_profiles (
    id integer NOT NULL,
    user_id integer NOT NULL,
    business_name character varying(255) DEFAULT ''::character varying NOT NULL,
    business_description text DEFAULT ''::text NOT NULL,
    industry character varying(255) DEFAULT ''::character varying NOT NULL,
    has_staff boolean DEFAULT false NOT NULL,
    staff_description text DEFAULT ''::text NOT NULL,
    tone_preferences text DEFAULT ''::text NOT NULL,
    things_to_avoid text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    status text DEFAULT 'active'::text NOT NULL,
    budget_monthly_cents integer DEFAULT 0 NOT NULL,
    spent_monthly_cents integer DEFAULT 0 NOT NULL,
    issue_prefix text DEFAULT 'FMN'::text NOT NULL,
    issue_counter integer DEFAULT 0 NOT NULL,
    routing_preference public.routing_preference DEFAULT 'open_optimized'::public.routing_preference NOT NULL,
    use_own_provider_for_routing boolean DEFAULT false NOT NULL,
    workspace_slug text NOT NULL,
    provider_priority jsonb,
    artifact_destination_preferences jsonb,
    artifact_platform_policy text DEFAULT 'user_choice'::text NOT NULL,
    task_execution_preferences jsonb,
    website_url text DEFAULT ''::text NOT NULL,
    target_customers text DEFAULT ''::text NOT NULL,
    value_proposition text DEFAULT ''::text NOT NULL,
    customer_pain_points text DEFAULT ''::text NOT NULL,
    how_they_solve text DEFAULT ''::text NOT NULL,
    products_services text DEFAULT ''::text NOT NULL,
    competitive_landscape text DEFAULT ''::text NOT NULL,
    geography text DEFAULT ''::text NOT NULL,
    business_goals_summary text DEFAULT ''::text NOT NULL,
    brand_voice text DEFAULT ''::text NOT NULL,
    onboarding_depth text DEFAULT 'basic'::text NOT NULL,
    builtin_models_backup_only boolean DEFAULT true NOT NULL,
    default_copy_voice_id integer,
    auto_topup_config jsonb,
    task_type_routing jsonb,
    allow_indirect_deepseek_fallback boolean DEFAULT false NOT NULL
);


--
-- Name: business_profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.business_profiles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: business_profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.business_profiles_id_seq OWNED BY public.business_profiles.id;


--
-- Name: channels; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.channels (
    id bigint NOT NULL,
    workspace_slug text NOT NULL,
    connected_account_id bigint NOT NULL,
    type text NOT NULL,
    external_channel_id text,
    display_name text,
    status text DEFAULT 'active'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: channels_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.channels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: channels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.channels_id_seq OWNED BY public.channels.id;


--
-- Name: chat_threads; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.chat_threads (
    id text NOT NULL,
    user_id integer NOT NULL,
    workspace_slug text NOT NULL,
    subject text DEFAULT 'New conversation'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    needs_input_at timestamp with time zone,
    unread_count integer DEFAULT 0 NOT NULL
);


--
-- Name: communication_compliance_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.communication_compliance_events (
    id bigint NOT NULL,
    workspace_slug text NOT NULL,
    actor_user_id integer,
    event_type text NOT NULL,
    channel_type text,
    channel_provider text,
    recipient_address text,
    action_name text,
    allowed boolean DEFAULT true NOT NULL,
    reasons jsonb DEFAULT '[]'::jsonb NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: communication_compliance_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.communication_compliance_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: communication_compliance_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.communication_compliance_events_id_seq OWNED BY public.communication_compliance_events.id;


--
-- Name: communication_consents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.communication_consents (
    id bigint NOT NULL,
    workspace_slug text NOT NULL,
    recipient_address text NOT NULL,
    recipient_type text NOT NULL,
    channel_provider text,
    consent_source text NOT NULL,
    consent_evidence jsonb DEFAULT '{}'::jsonb NOT NULL,
    granted_by_user_id integer,
    granted_at timestamp with time zone DEFAULT now() NOT NULL,
    revoked_at timestamp with time zone,
    expires_at timestamp with time zone,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: communication_consents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.communication_consents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: communication_consents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.communication_consents_id_seq OWNED BY public.communication_consents.id;


--
-- Name: communication_suppressions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.communication_suppressions (
    id bigint NOT NULL,
    workspace_slug text NOT NULL,
    recipient_address text NOT NULL,
    recipient_type text NOT NULL,
    reason text NOT NULL,
    source text DEFAULT 'manual'::text NOT NULL,
    created_by_user_id integer,
    expires_at timestamp with time zone,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: communication_suppressions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.communication_suppressions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: communication_suppressions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.communication_suppressions_id_seq OWNED BY public.communication_suppressions.id;


--
-- Name: compliance_access_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.compliance_access_events (
    id bigint NOT NULL,
    workspace_slug text,
    actor_user_id bigint,
    event_type text NOT NULL,
    risk_level text DEFAULT 'review'::text NOT NULL,
    reason text NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: compliance_access_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.compliance_access_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: compliance_access_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.compliance_access_events_id_seq OWNED BY public.compliance_access_events.id;


--
-- Name: compliance_incidents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.compliance_incidents (
    id bigint NOT NULL,
    incident_key text NOT NULL,
    title text NOT NULL,
    severity text DEFAULT 'review'::text NOT NULL,
    status text DEFAULT 'open'::text NOT NULL,
    source text DEFAULT 'internal'::text NOT NULL,
    reportable_breach boolean DEFAULT false NOT NULL,
    affected_scope jsonb DEFAULT '{}'::jsonb NOT NULL,
    detected_at timestamp with time zone DEFAULT now() NOT NULL,
    confirmed_at timestamp with time zone,
    breach_notice_due_at timestamp with time zone,
    resolved_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: compliance_incidents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.compliance_incidents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: compliance_incidents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.compliance_incidents_id_seq OWNED BY public.compliance_incidents.id;


--
-- Name: compliance_monitor_runs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.compliance_monitor_runs (
    id bigint NOT NULL,
    monitor_kind text NOT NULL,
    status text NOT NULL,
    summary jsonb DEFAULT '{}'::jsonb NOT NULL,
    notification_obligations jsonb DEFAULT '[]'::jsonb NOT NULL,
    internal_alert_email text NOT NULL,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    finished_at timestamp with time zone,
    error text
);


--
-- Name: compliance_monitor_runs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.compliance_monitor_runs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: compliance_monitor_runs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.compliance_monitor_runs_id_seq OWNED BY public.compliance_monitor_runs.id;


--
-- Name: compliance_uptime_checks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.compliance_uptime_checks (
    id bigint NOT NULL,
    check_name text NOT NULL,
    status text NOT NULL,
    latency_ms integer,
    details jsonb DEFAULT '{}'::jsonb NOT NULL,
    checked_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: compliance_uptime_checks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.compliance_uptime_checks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: compliance_uptime_checks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.compliance_uptime_checks_id_seq OWNED BY public.compliance_uptime_checks.id;


--
-- Name: composio_recommendations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.composio_recommendations (
    id integer NOT NULL,
    workspace_slug text NOT NULL,
    agent_id integer,
    toolkit_slug text NOT NULL,
    conversation_thread_id text,
    emitted_at timestamp with time zone DEFAULT now() NOT NULL,
    outcome public.composio_recommendation_outcome DEFAULT 'ignored'::public.composio_recommendation_outcome NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: composio_recommendations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.composio_recommendations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: composio_recommendations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.composio_recommendations_id_seq OWNED BY public.composio_recommendations.id;


--
-- Name: config_versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.config_versions (
    id integer NOT NULL,
    workspace_slug text NOT NULL,
    entity_type text NOT NULL,
    entity_id integer NOT NULL,
    field_name text NOT NULL,
    prior_value jsonb,
    new_value jsonb,
    changed_by_user_id integer,
    changed_by_agent_id integer,
    reverted_from_version_id integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: config_versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.config_versions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: config_versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.config_versions_id_seq OWNED BY public.config_versions.id;


--
-- Name: connected_account_identity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.connected_account_identity (
    connected_account_id text NOT NULL,
    workspace_slug text NOT NULL,
    provider text,
    toolkit_slug text,
    label text,
    resolved_at timestamp with time zone,
    connection_status text DEFAULT 'ok'::text NOT NULL,
    connection_error text,
    connection_error_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    last_attempt_at timestamp with time zone,
    resolution_debug jsonb
);


--
-- Name: connected_accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.connected_accounts (
    id bigint NOT NULL,
    workspace_slug text NOT NULL,
    user_id integer,
    provider text NOT NULL,
    provider_account_id text,
    display_name text,
    auth_provider text,
    auth_account_id text,
    access_status text DEFAULT 'active'::text NOT NULL,
    external_metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    last_sync_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: connected_accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.connected_accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: connected_accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.connected_accounts_id_seq OWNED BY public.connected_accounts.id;


--
-- Name: copy_voices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.copy_voices (
    id integer NOT NULL,
    workspace_slug text NOT NULL,
    key text NOT NULL,
    name text NOT NULL,
    style_instruction text NOT NULL,
    based_on_default_key text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    refinements jsonb DEFAULT '[]'::jsonb NOT NULL
);


--
-- Name: copy_voices_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.copy_voices_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: copy_voices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.copy_voices_id_seq OWNED BY public.copy_voices.id;


--
-- Name: cost_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cost_events (
    id integer NOT NULL,
    user_id integer NOT NULL,
    agent_id integer NOT NULL,
    issue_id integer,
    project_id integer,
    run_id integer,
    provider text NOT NULL,
    model text NOT NULL,
    input_tokens integer DEFAULT 0 NOT NULL,
    cached_input_tokens integer DEFAULT 0 NOT NULL,
    output_tokens integer DEFAULT 0 NOT NULL,
    cost_cents integer DEFAULT 0 NOT NULL,
    occurred_at timestamp with time zone DEFAULT now() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    workspace_slug text NOT NULL
);


--
-- Name: cost_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cost_events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cost_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cost_events_id_seq OWNED BY public.cost_events.id;


--
-- Name: cron_run_log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cron_run_log (
    id bigint NOT NULL,
    job_name text NOT NULL,
    started_at timestamp with time zone NOT NULL,
    finished_at timestamp with time zone DEFAULT now() NOT NULL,
    duration_ms integer,
    ok boolean DEFAULT true NOT NULL,
    step_errors jsonb,
    summary jsonb,
    error text,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: cron_run_log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.cron_run_log ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.cron_run_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: customer_notification_obligations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customer_notification_obligations (
    id bigint NOT NULL,
    source_monitor_kind text NOT NULL,
    obligation_key text NOT NULL,
    status text DEFAULT 'pending'::text NOT NULL,
    severity text DEFAULT 'review'::text NOT NULL,
    reason text NOT NULL,
    affected_scope jsonb DEFAULT '{}'::jsonb NOT NULL,
    dedupe_key text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    notified_at timestamp with time zone
);


--
-- Name: customer_notification_obligations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.customer_notification_obligations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: customer_notification_obligations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.customer_notification_obligations_id_seq OWNED BY public.customer_notification_obligations.id;


--
-- Name: deliverable_proposed_tasks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.deliverable_proposed_tasks (
    id bigint NOT NULL,
    deliverable_id integer NOT NULL,
    workspace_slug text NOT NULL,
    "position" integer NOT NULL,
    title text NOT NULL,
    description text,
    suggested_assignee_role text,
    priority public.issue_priority DEFAULT 'medium'::public.issue_priority NOT NULL,
    due_offset_days integer DEFAULT 7 NOT NULL,
    depends_on_position integer,
    materialized_issue_id integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: deliverable_proposed_tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.deliverable_proposed_tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: deliverable_proposed_tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.deliverable_proposed_tasks_id_seq OWNED BY public.deliverable_proposed_tasks.id;


--
-- Name: deliverable_sections; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.deliverable_sections (
    id bigint NOT NULL,
    deliverable_id integer NOT NULL,
    workspace_slug text NOT NULL,
    "position" integer NOT NULL,
    kind public.deliverable_section_kind DEFAULT 'custom'::public.deliverable_section_kind NOT NULL,
    title text NOT NULL,
    body_md text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: deliverable_sections_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.deliverable_sections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: deliverable_sections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.deliverable_sections_id_seq OWNED BY public.deliverable_sections.id;


--
-- Name: deliverables; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.deliverables (
    id integer NOT NULL,
    user_id integer NOT NULL,
    title character varying(500) NOT NULL,
    summary text DEFAULT ''::text NOT NULL,
    content text NOT NULL,
    category public.deliverable_category DEFAULT 'other'::public.deliverable_category NOT NULL,
    status public.deliverable_status DEFAULT 'final'::public.deliverable_status NOT NULL,
    tags text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    agent_id integer,
    issue_id integer,
    project_id integer,
    workspace_slug text NOT NULL,
    originating_human_id integer,
    approval_state public.deliverable_approval_state DEFAULT 'draft'::public.deliverable_approval_state NOT NULL,
    approved_at timestamp with time zone,
    approved_by_user_id integer,
    revision_notes text,
    proposed_project_id integer,
    linked_project_id integer,
    goal_id integer,
    artifact_kind text,
    render_mode text DEFAULT 'native'::text NOT NULL,
    native_content_ref jsonb,
    external_destination jsonb,
    verification_state text DEFAULT 'unverified'::text NOT NULL,
    format text DEFAULT 'markdown'::text NOT NULL,
    deliverable_group_id text NOT NULL,
    version integer DEFAULT 1 NOT NULL,
    is_latest boolean DEFAULT true NOT NULL,
    content_type_bucket text,
    archived_at timestamp with time zone,
    archived_reason text,
    verification_notes text
);


--
-- Name: deliverables_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.deliverables_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: deliverables_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.deliverables_id_seq OWNED BY public.deliverables.id;


--
-- Name: delivery_problem_reports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.delivery_problem_reports (
    id integer NOT NULL,
    issue_id integer NOT NULL,
    project_id integer,
    workspace_slug text NOT NULL,
    trigger_source text DEFAULT 'auto'::text NOT NULL,
    user_id integer,
    task_title text,
    task_type text,
    classified_reason text,
    escalation_trail jsonb DEFAULT '[]'::jsonb,
    diagnostic_snapshot jsonb DEFAULT '{}'::jsonb,
    user_notes text,
    status text DEFAULT 'open'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    resolved_by_user_id integer
);


--
-- Name: delivery_problem_reports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.delivery_problem_reports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delivery_problem_reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.delivery_problem_reports_id_seq OWNED BY public.delivery_problem_reports.id;


--
-- Name: execution_blockers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.execution_blockers (
    id bigint NOT NULL,
    workspace_slug text NOT NULL,
    blocker_key text NOT NULL,
    blocker_type text NOT NULL,
    status text DEFAULT 'open'::text NOT NULL,
    blocks_new_work boolean DEFAULT false NOT NULL,
    title text NOT NULL,
    resolution_instructions text NOT NULL,
    detail jsonb,
    affected_count integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    last_seen_at timestamp with time zone DEFAULT now() NOT NULL,
    resolved_at timestamp with time zone,
    resolved_by text,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    last_screened_at timestamp with time zone
);


--
-- Name: execution_blockers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.execution_blockers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: execution_blockers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.execution_blockers_id_seq OWNED BY public.execution_blockers.id;


--
-- Name: feedback_reports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.feedback_reports (
    id bigint NOT NULL,
    user_id integer,
    workspace_slug text,
    category text DEFAULT 'bug'::text NOT NULL,
    message text NOT NULL,
    screenshot_base64 text,
    screenshot_mime text,
    page_url text,
    context_json jsonb,
    status text DEFAULT 'new'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT feedback_reports_category_chk CHECK ((category = ANY (ARRAY['bug'::text, 'confusing'::text, 'idea'::text, 'other'::text]))),
    CONSTRAINT feedback_reports_status_chk CHECK ((status = ANY (ARRAY['new'::text, 'triaged'::text, 'resolved'::text])))
);


--
-- Name: feedback_reports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.feedback_reports ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.feedback_reports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: free_tier_ledger; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.free_tier_ledger (
    workspace_slug text NOT NULL,
    period_key text NOT NULL,
    used_cents integer DEFAULT 0 NOT NULL,
    cap_cents integer DEFAULT 200 NOT NULL,
    gated_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    used_micro_cents integer DEFAULT 0 NOT NULL
);


--
-- Name: global_model_catalog; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.global_model_catalog (
    id bigint NOT NULL,
    provider_id text NOT NULL,
    model_id text NOT NULL,
    canonical_id text NOT NULL,
    model_name text NOT NULL,
    api_base_url text NOT NULL,
    capability_tier text DEFAULT 'routine'::text NOT NULL,
    weight_class text DEFAULT 'open'::text NOT NULL,
    thinking_supported boolean DEFAULT false NOT NULL,
    tool_calling_quality text DEFAULT 'none'::text NOT NULL,
    benchmark_score real DEFAULT 80 NOT NULL,
    domain_scores jsonb DEFAULT '{}'::jsonb NOT NULL,
    default_config jsonb DEFAULT '{}'::jsonb NOT NULL,
    estimated_param_billions real,
    source text DEFAULT 'models_dev'::text NOT NULL,
    fetched_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: global_model_catalog_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.global_model_catalog_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: global_model_catalog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.global_model_catalog_id_seq OWNED BY public.global_model_catalog.id;


--
-- Name: goal_archetypes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.goal_archetypes (
    id integer NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    category text NOT NULL,
    direction text NOT NULL,
    typical_target_value numeric,
    typical_unit text,
    typical_cadence text NOT NULL,
    example_baseline_value numeric,
    applicable_phases jsonb DEFAULT '[]'::jsonb NOT NULL,
    supporting_context text NOT NULL,
    display_order integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: goal_archetypes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.goal_archetypes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: goal_archetypes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.goal_archetypes_id_seq OWNED BY public.goal_archetypes.id;


--
-- Name: goal_measurements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.goal_measurements (
    id integer NOT NULL,
    goal_id integer NOT NULL,
    workspace_slug text NOT NULL,
    value numeric NOT NULL,
    recorded_at timestamp with time zone DEFAULT now() NOT NULL,
    source text NOT NULL,
    source_metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    period_start timestamp with time zone,
    period_end timestamp with time zone,
    notes text,
    recorded_by text
);


--
-- Name: goal_measurements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.goal_measurements_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: goal_measurements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.goal_measurements_id_seq OWNED BY public.goal_measurements.id;


--
-- Name: goals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.goals (
    id integer NOT NULL,
    user_id integer NOT NULL,
    title text NOT NULL,
    description text,
    level public.goal_level DEFAULT 'task'::public.goal_level NOT NULL,
    status public.goal_status DEFAULT 'planned'::public.goal_status NOT NULL,
    parent_id integer,
    owner_agent_id integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    workspace_slug text NOT NULL,
    category text,
    priority_order integer DEFAULT 0 NOT NULL,
    metric_name text,
    metric_unit text,
    direction text,
    target_value numeric,
    baseline_value numeric DEFAULT 0 NOT NULL,
    current_value numeric,
    cadence text,
    due_at timestamp with time zone,
    measurement_mode text DEFAULT 'manual'::text NOT NULL,
    measurement_config jsonb DEFAULT '{}'::jsonb NOT NULL,
    last_measured_at timestamp with time zone,
    measurement_frequency_hours integer DEFAULT 24 NOT NULL,
    achieved_at timestamp with time zone,
    conversation_id bigint,
    draft_revisions integer DEFAULT 0 NOT NULL,
    abandoned_at timestamp with time zone,
    execution_preferences jsonb,
    objective_mode text DEFAULT 'one_time'::text NOT NULL,
    completion_condition jsonb
);


--
-- Name: goals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.goals_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: goals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.goals_id_seq OWNED BY public.goals.id;


--
-- Name: high_risk_gate_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.high_risk_gate_events (
    id bigint NOT NULL,
    workspace_slug text NOT NULL,
    actor_user_id integer,
    agent_id integer,
    action_name text,
    domain text,
    mode text NOT NULL,
    decision text NOT NULL,
    reasons jsonb DEFAULT '[]'::jsonb NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: high_risk_gate_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.high_risk_gate_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: high_risk_gate_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.high_risk_gate_events_id_seq OWNED BY public.high_risk_gate_events.id;


--
-- Name: hub_channels; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hub_channels (
    id bigint NOT NULL,
    workspace_slug text NOT NULL,
    type public.hub_channel_type NOT NULL,
    provider public.hub_channel_provider NOT NULL,
    display_name text NOT NULL,
    account_identifier text NOT NULL,
    credentials_encrypted text,
    sync_cursor text,
    status public.hub_channel_status DEFAULT 'active'::public.hub_channel_status NOT NULL,
    last_sync_at timestamp with time zone,
    error_message text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    integration_provider text,
    connected_account_id text,
    sync_enabled boolean DEFAULT true NOT NULL,
    webhook_token text,
    composio_trigger_id text,
    webhook_secret_encrypted text,
    blocker_id bigint
);


--
-- Name: hub_channels_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.hub_channels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hub_channels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.hub_channels_id_seq OWNED BY public.hub_channels.id;


--
-- Name: hub_conversation_reads; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hub_conversation_reads (
    member_id integer NOT NULL,
    conversation_id bigint NOT NULL,
    last_read_message_id bigint,
    last_read_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: hub_conversation_tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hub_conversation_tags (
    conversation_id bigint NOT NULL,
    tag_id integer NOT NULL
);


--
-- Name: hub_conversations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hub_conversations (
    id bigint NOT NULL,
    workspace_slug text NOT NULL,
    channel_id bigint NOT NULL,
    subject text,
    preview_text text,
    status public.hub_conversation_status DEFAULT 'open'::public.hub_conversation_status NOT NULL,
    priority public.hub_conversation_priority DEFAULT 'normal'::public.hub_conversation_priority NOT NULL,
    assigned_to_member_id integer,
    external_thread_id text,
    last_message_at timestamp with time zone,
    snoozed_until timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    audience public.hub_conversation_audience,
    audience_source text DEFAULT 'auto'::text
);


--
-- Name: hub_conversations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.hub_conversations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hub_conversations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.hub_conversations_id_seq OWNED BY public.hub_conversations.id;


--
-- Name: hub_internal_comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hub_internal_comments (
    id bigint NOT NULL,
    conversation_id bigint NOT NULL,
    author_member_id integer NOT NULL,
    body text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: hub_internal_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.hub_internal_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hub_internal_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.hub_internal_comments_id_seq OWNED BY public.hub_internal_comments.id;


--
-- Name: hub_message_attachments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hub_message_attachments (
    id bigint NOT NULL,
    message_id bigint NOT NULL,
    filename text NOT NULL,
    content_type text,
    size_bytes bigint,
    storage_url text NOT NULL
);


--
-- Name: hub_message_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.hub_message_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hub_message_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.hub_message_attachments_id_seq OWNED BY public.hub_message_attachments.id;


--
-- Name: hub_message_participants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hub_message_participants (
    id bigint NOT NULL,
    message_id bigint NOT NULL,
    participant_role public.hub_participant_role NOT NULL,
    address text NOT NULL,
    display_name text
);


--
-- Name: hub_message_participants_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.hub_message_participants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hub_message_participants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.hub_message_participants_id_seq OWNED BY public.hub_message_participants.id;


--
-- Name: hub_messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hub_messages (
    id bigint NOT NULL,
    conversation_id bigint NOT NULL,
    channel_id bigint NOT NULL,
    workspace_slug text NOT NULL,
    direction public.hub_message_direction NOT NULL,
    sender_address text,
    sender_name text,
    body_text text,
    body_html text,
    external_message_id text,
    metadata jsonb DEFAULT '{}'::jsonb,
    sent_at timestamp with time zone DEFAULT now() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: hub_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.hub_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hub_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.hub_messages_id_seq OWNED BY public.hub_messages.id;


--
-- Name: hub_routing_rules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hub_routing_rules (
    id integer NOT NULL,
    workspace_slug text NOT NULL,
    match_type text NOT NULL,
    match_value text NOT NULL,
    route_to public.hub_conversation_audience NOT NULL,
    note text,
    created_by_user_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: hub_routing_rules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.hub_routing_rules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hub_routing_rules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.hub_routing_rules_id_seq OWNED BY public.hub_routing_rules.id;


--
-- Name: hub_tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hub_tags (
    id integer NOT NULL,
    workspace_slug text NOT NULL,
    name text NOT NULL,
    color text DEFAULT '#6b7280'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: hub_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.hub_tags_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hub_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.hub_tags_id_seq OWNED BY public.hub_tags.id;


--
-- Name: idempotency_ledger; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.idempotency_ledger (
    id bigint NOT NULL,
    workspace_slug text NOT NULL,
    entity_type text NOT NULL,
    fingerprint_hash text NOT NULL,
    scope_key text NOT NULL,
    status text DEFAULT 'pending'::text NOT NULL,
    entity_id bigint,
    debug_signature jsonb DEFAULT '{}'::jsonb NOT NULL,
    expires_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: idempotency_ledger_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.idempotency_ledger_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: idempotency_ledger_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.idempotency_ledger_id_seq OWNED BY public.idempotency_ledger.id;


--
-- Name: inbox_conversations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inbox_conversations (
    id bigint NOT NULL,
    workspace_slug text NOT NULL,
    owner_user_id integer NOT NULL,
    channel_type text DEFAULT 'internal'::text NOT NULL,
    title text NOT NULL,
    subtitle text,
    avatar_url text,
    participant_type text DEFAULT 'agent'::text NOT NULL,
    participant_id integer,
    participant_name text,
    external_contact_info jsonb DEFAULT '{}'::jsonb NOT NULL,
    status text DEFAULT 'open'::text NOT NULL,
    priority text DEFAULT 'normal'::text NOT NULL,
    is_pinned boolean DEFAULT false NOT NULL,
    unread_count integer DEFAULT 0 NOT NULL,
    last_message_at timestamp with time zone,
    last_message_preview text,
    last_read_at timestamp with time zone,
    linked_issue_id integer,
    linked_approval_id integer,
    tags jsonb DEFAULT '[]'::jsonb NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    snoozed_until timestamp with time zone,
    linked_goal_id integer
);


--
-- Name: inbox_conversations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.inbox_conversations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inbox_conversations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.inbox_conversations_id_seq OWNED BY public.inbox_conversations.id;


--
-- Name: inbox_messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inbox_messages (
    id bigint NOT NULL,
    conversation_id bigint NOT NULL,
    workspace_slug text NOT NULL,
    sender_type text DEFAULT 'agent'::text NOT NULL,
    sender_agent_id integer,
    sender_user_id integer,
    sender_name text,
    content text NOT NULL,
    content_type text DEFAULT 'text'::text NOT NULL,
    action_type text,
    action_payload jsonb DEFAULT '{}'::jsonb NOT NULL,
    action_status text,
    linked_approval_id integer,
    linked_needs_item_id integer,
    linked_notification_id bigint,
    attachments jsonb DEFAULT '[]'::jsonb NOT NULL,
    is_read boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    action_dedupe_key text
);


--
-- Name: inbox_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.inbox_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inbox_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.inbox_messages_id_seq OWNED BY public.inbox_messages.id;


--
-- Name: inbox_notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inbox_notifications (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    workspace_slug text NOT NULL,
    source_brief_id integer NOT NULL,
    type text NOT NULL,
    title text NOT NULL,
    summary text NOT NULL,
    deliverable_url text,
    deliverable_label text,
    status text DEFAULT 'unread'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    read_at timestamp with time zone,
    archived_at timestamp with time zone
);


--
-- Name: inbox_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.inbox_notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inbox_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.inbox_notifications_id_seq OWNED BY public.inbox_notifications.id;


--
-- Name: integration_action_failures; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.integration_action_failures (
    id bigint NOT NULL,
    provider text NOT NULL,
    action_slug text NOT NULL,
    error_signature text NOT NULL,
    error_sample text,
    failure_count integer DEFAULT 1 NOT NULL,
    last_workspace_slug text,
    status text DEFAULT 'open'::text NOT NULL,
    first_seen_at timestamp with time zone DEFAULT now() NOT NULL,
    last_seen_at timestamp with time zone DEFAULT now() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: integration_action_failures_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.integration_action_failures ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.integration_action_failures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: integration_action_policies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.integration_action_policies (
    id bigint NOT NULL,
    provider text NOT NULL,
    action_slug text NOT NULL,
    gate_class public.gate_class DEFAULT 'irreversible'::public.gate_class NOT NULL,
    param_conditions jsonb,
    source public.policy_source DEFAULT 'heuristic'::public.policy_source NOT NULL,
    confidence numeric DEFAULT 0.5 NOT NULL,
    rationale text,
    last_reviewed_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    agent_exposure text DEFAULT 'allow'::text NOT NULL,
    description_override text,
    preferred_alternative text,
    permission_type text,
    CONSTRAINT integration_action_policies_agent_exposure_chk CHECK ((agent_exposure = ANY (ARRAY['allow'::text, 'hidden'::text]))),
    CONSTRAINT integration_action_policies_permission_type_chk CHECK (((permission_type IS NULL) OR (permission_type = ANY (ARRAY['read'::text, 'write'::text, 'execute'::text, 'financial'::text]))))
);


--
-- Name: integration_action_policies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.integration_action_policies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: integration_action_policies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.integration_action_policies_id_seq OWNED BY public.integration_action_policies.id;


--
-- Name: integration_action_schemas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.integration_action_schemas (
    provider text NOT NULL,
    action_slug text NOT NULL,
    input_schema jsonb DEFAULT '{"type": "object", "properties": {}}'::jsonb NOT NULL,
    required jsonb DEFAULT '[]'::jsonb NOT NULL,
    source text DEFAULT 'composio'::text NOT NULL,
    last_verified_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: integration_whoami_registry; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.integration_whoami_registry (
    provider text NOT NULL,
    toolkit_slug text NOT NULL,
    action text,
    identity_path text,
    candidates jsonb,
    status text DEFAULT 'pending'::text NOT NULL,
    error text,
    refreshed_at timestamp with time zone,
    attempted_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    identity_params jsonb,
    value_type text,
    audited_at timestamp with time zone,
    audit_confidence text,
    audit_notes text
);


--
-- Name: issue_comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.issue_comments (
    id bigint NOT NULL,
    issue_id integer NOT NULL,
    parent_comment_id bigint,
    author_user_id integer,
    author_agent_id integer,
    content text NOT NULL,
    workspace_slug text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT chk_author CHECK ((((author_user_id IS NOT NULL) AND (author_agent_id IS NULL)) OR ((author_user_id IS NULL) AND (author_agent_id IS NOT NULL))))
);


--
-- Name: issue_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.issue_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: issue_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.issue_comments_id_seq OWNED BY public.issue_comments.id;


--
-- Name: issue_decompositions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.issue_decompositions (
    id bigint NOT NULL,
    workspace_slug text NOT NULL,
    goal_id integer,
    source_issue_id integer,
    plan_fingerprint text NOT NULL,
    status text DEFAULT 'in_flight'::text NOT NULL,
    requested_child_count integer DEFAULT 0 NOT NULL,
    child_issue_ids jsonb DEFAULT '[]'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: issue_decompositions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.issue_decompositions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: issue_decompositions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.issue_decompositions_id_seq OWNED BY public.issue_decompositions.id;


--
-- Name: issue_review_attempts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.issue_review_attempts (
    id bigint NOT NULL,
    workspace_slug text NOT NULL,
    user_id integer NOT NULL,
    issue_id integer NOT NULL,
    reviewer_agent_id integer NOT NULL,
    attempt_token text NOT NULL,
    trigger_source text NOT NULL,
    status text DEFAULT 'running'::text NOT NULL,
    decision text,
    rationale text,
    evidence_checked jsonb DEFAULT '[]'::jsonb NOT NULL,
    correction_items jsonb DEFAULT '[]'::jsonb NOT NULL,
    review_packet jsonb,
    error text,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    completed_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: issue_review_attempts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.issue_review_attempts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: issue_review_attempts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.issue_review_attempts_id_seq OWNED BY public.issue_review_attempts.id;


--
-- Name: issue_storylines; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.issue_storylines (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    workspace_slug text NOT NULL,
    issue_id bigint NOT NULL,
    body text NOT NULL,
    base_generated_at timestamp with time zone DEFAULT now() NOT NULL,
    last_appended_at timestamp with time zone DEFAULT now() NOT NULL,
    append_count integer DEFAULT 0 NOT NULL,
    model text NOT NULL,
    total_input_tokens integer DEFAULT 0 NOT NULL,
    total_output_tokens integer DEFAULT 0 NOT NULL,
    generation_in_progress boolean DEFAULT false NOT NULL,
    generation_lock_acquired_at timestamp with time zone,
    last_error text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: issues; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.issues (
    id integer NOT NULL,
    user_id integer NOT NULL,
    project_id integer,
    goal_id integer,
    parent_id integer,
    title text NOT NULL,
    description text,
    status public.issue_status DEFAULT 'backlog'::public.issue_status NOT NULL,
    priority public.issue_priority DEFAULT 'medium'::public.issue_priority NOT NULL,
    assignee_agent_id integer,
    created_by_agent_id integer,
    origin_kind text DEFAULT 'manual'::text NOT NULL,
    request_depth integer DEFAULT 0 NOT NULL,
    execution_state jsonb,
    started_at timestamp with time zone,
    completed_at timestamp with time zone,
    cancelled_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    workspace_slug text NOT NULL,
    claimed_by_agent_id integer,
    claimed_at timestamp with time zone,
    claim_timeout_seconds integer DEFAULT 3600 NOT NULL,
    originating_human_id integer,
    due_date timestamp with time zone,
    dependency_issue_ids jsonb DEFAULT '[]'::jsonb NOT NULL,
    blocked_by_issue_ids jsonb DEFAULT '[]'::jsonb NOT NULL,
    origin_id text,
    origin_fingerprint text DEFAULT 'default'::text NOT NULL,
    execution_run_id integer,
    execution_agent_name_key text,
    execution_locked_at timestamp with time zone,
    origin_thread_id text,
    task_type public.task_type,
    cancelled_by text,
    completion_quality text,
    is_primary_output boolean DEFAULT false NOT NULL,
    blocked_reason text,
    blocker_id bigint,
    CONSTRAINT blocked_by_issue_ids_int_array CHECK (((blocked_by_issue_ids IS NULL) OR public.jsonb_is_int_array(blocked_by_issue_ids)))
);


--
-- Name: issues_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.issues_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: issues_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.issues_id_seq OWNED BY public.issues.id;


--
-- Name: kilo_tool_call_repair_dispatch_state; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.kilo_tool_call_repair_dispatch_state (
    webhook_url text NOT NULL,
    dispatch_paused_until timestamp with time zone,
    last_capacity_blocked_at timestamp with time zone,
    last_error text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: legal_acceptances; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.legal_acceptances (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    workspace_slug text,
    document_slug text NOT NULL,
    document_version text NOT NULL,
    acceptance_type text NOT NULL,
    ip_address_hash text,
    user_agent text,
    source_surface text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    metadata jsonb
);


--
-- Name: legal_acceptances_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.legal_acceptances_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: legal_acceptances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.legal_acceptances_id_seq OWNED BY public.legal_acceptances.id;


--
-- Name: local_servers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.local_servers (
    id text NOT NULL,
    owner_user_id bigint NOT NULL,
    workspace_slug text,
    display_name text,
    device_credential_hash text NOT NULL,
    status text DEFAULT 'active'::text NOT NULL,
    last_seen_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: login_attempts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.login_attempts (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    attempted_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    success boolean DEFAULT false
);


--
-- Name: login_attempts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.login_attempts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: login_attempts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.login_attempts_id_seq OWNED BY public.login_attempts.id;


--
-- Name: memory_entries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.memory_entries (
    id integer NOT NULL,
    user_id integer NOT NULL,
    category public.memory_category DEFAULT 'observation'::public.memory_category NOT NULL,
    content text NOT NULL,
    source public.memory_source DEFAULT 'chat'::public.memory_source NOT NULL,
    status public.memory_status DEFAULT 'captured'::public.memory_status NOT NULL,
    source_message_id integer,
    superseded_by integer,
    tags text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    workspace_slug text NOT NULL
);


--
-- Name: memory_entries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.memory_entries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: memory_entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.memory_entries_id_seq OWNED BY public.memory_entries.id;


--
-- Name: message_attachments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.message_attachments (
    id integer NOT NULL,
    workspace_slug text NOT NULL,
    message_id integer NOT NULL,
    user_id integer NOT NULL,
    kind text DEFAULT 'image'::text NOT NULL,
    mime text NOT NULL,
    data_base64 text,
    byte_size integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    filename text,
    object_key text,
    extracted_text text
);


--
-- Name: message_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.message_attachments ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.message_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: message_delivery_attempts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.message_delivery_attempts (
    id bigint NOT NULL,
    workspace_slug text NOT NULL,
    message_id bigint,
    provider text NOT NULL,
    request_payload jsonb DEFAULT '{}'::jsonb NOT NULL,
    response_payload jsonb DEFAULT '{}'::jsonb NOT NULL,
    status text NOT NULL,
    error text,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: message_delivery_attempts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.message_delivery_attempts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: message_delivery_attempts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.message_delivery_attempts_id_seq OWNED BY public.message_delivery_attempts.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.messages (
    id integer NOT NULL,
    user_id integer NOT NULL,
    role public.message_role NOT NULL,
    content text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    agent_id integer,
    run_id integer,
    workspace_slug text NOT NULL,
    visibility public.message_visibility DEFAULT 'private'::public.message_visibility NOT NULL,
    shared_with_team_at timestamp with time zone,
    kind public.message_kind DEFAULT 'chat'::public.message_kind NOT NULL,
    cos_processed_at timestamp with time zone,
    issue_id integer,
    thread_id text DEFAULT 'default'::text NOT NULL
);


--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- Name: model_health; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.model_health (
    provider text NOT NULL,
    model_id text NOT NULL,
    consecutive_failures integer DEFAULT 0 NOT NULL,
    cooldown_seconds integer DEFAULT 0 NOT NULL,
    disabled_until_at timestamp with time zone,
    last_error text,
    last_failure_at timestamp with time zone,
    last_success_at timestamp with time zone,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    tool_calling_failures integer DEFAULT 0 NOT NULL,
    tool_calling_cooldown_seconds integer DEFAULT 0 NOT NULL,
    tool_calling_disabled_until_at timestamp with time zone,
    tool_calling_last_failure_at timestamp with time zone,
    tool_calling_last_error text,
    workspace_slug text NOT NULL
);


--
-- Name: model_registry; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.model_registry (
    id integer NOT NULL,
    user_id integer NOT NULL,
    provider character varying(100) NOT NULL,
    model_id character varying(200) NOT NULL,
    model_name character varying(200) NOT NULL,
    capability_tier public.capability_tier NOT NULL,
    weight_class public.model_weight_class NOT NULL,
    thinking_supported boolean DEFAULT false NOT NULL,
    tool_calling_supported boolean DEFAULT true NOT NULL,
    estimated_param_billions real,
    benchmark_score real,
    is_default_for_tier boolean DEFAULT false NOT NULL,
    config jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    workspace_slug text NOT NULL,
    tool_calling_quality public.tool_calling_quality DEFAULT 'none'::public.tool_calling_quality NOT NULL,
    tool_calling_last_verified date,
    domain_scores jsonb,
    cost_tier text DEFAULT 'standard'::text NOT NULL
);


--
-- Name: model_registry_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.model_registry_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: model_registry_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.model_registry_id_seq OWNED BY public.model_registry.id;


--
-- Name: needs_from_you_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.needs_from_you_items (
    id integer NOT NULL,
    workspace_slug text NOT NULL,
    agent_id integer,
    originating_human_id integer,
    message_id integer,
    item_type text NOT NULL,
    item_text text NOT NULL,
    linked_approval_id integer,
    outcome text DEFAULT 'pending'::text NOT NULL,
    resolved_at timestamp with time zone,
    resolved_by_user_id integer,
    resolution_context text,
    emitted_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    dedupe_key text
);


--
-- Name: needs_from_you_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.needs_from_you_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: needs_from_you_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.needs_from_you_items_id_seq OWNED BY public.needs_from_you_items.id;


--
-- Name: oauth_accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.oauth_accounts (
    id integer NOT NULL,
    user_id integer NOT NULL,
    provider character varying(50) NOT NULL,
    provider_user_id character varying(255) NOT NULL,
    provider_email character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: oauth_accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.oauth_accounts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: oauth_accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.oauth_accounts_id_seq OWNED BY public.oauth_accounts.id;


--
-- Name: oauth_states; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.oauth_states (
    id integer NOT NULL,
    state character varying(255) NOT NULL,
    code_verifier text DEFAULT ''::text NOT NULL,
    provider character varying(50) NOT NULL,
    redirect_url text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    beta_invite_code text
);


--
-- Name: oauth_states_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.oauth_states_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: oauth_states_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.oauth_states_id_seq OWNED BY public.oauth_states.id;


--
-- Name: participants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.participants (
    id bigint NOT NULL,
    workspace_slug text NOT NULL,
    channel_id bigint NOT NULL,
    external_participant_id text NOT NULL,
    display_name text,
    handle text,
    email text,
    phone text,
    avatar_url text,
    raw_profile jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: participants_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.participants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: participants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.participants_id_seq OWNED BY public.participants.id;


--
-- Name: payment_handoff_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment_handoff_events (
    id bigint NOT NULL,
    workspace_slug text NOT NULL,
    actor_user_id integer,
    agent_id integer,
    provider text NOT NULL,
    action_name text NOT NULL,
    handoff_url text NOT NULL,
    reason text NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: payment_handoff_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.payment_handoff_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payment_handoff_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.payment_handoff_events_id_seq OWNED BY public.payment_handoff_events.id;


--
-- Name: principals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.principals (
    id integer NOT NULL,
    workspace_slug text NOT NULL,
    principal_type public.principal_type NOT NULL,
    user_id integer,
    agent_id integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: principals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.principals_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: principals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.principals_id_seq OWNED BY public.principals.id;


--
-- Name: privacy_audit_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.privacy_audit_events (
    id bigint NOT NULL,
    workspace_slug text NOT NULL,
    actor_user_id integer,
    privacy_request_id bigint,
    event_type text NOT NULL,
    target_type text NOT NULL,
    target_id text,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: privacy_audit_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.privacy_audit_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: privacy_audit_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.privacy_audit_events_id_seq OWNED BY public.privacy_audit_events.id;


--
-- Name: privacy_purge_runs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.privacy_purge_runs (
    id bigint NOT NULL,
    workspace_slug text NOT NULL,
    privacy_request_id bigint,
    purge_type text NOT NULL,
    status text NOT NULL,
    purged_rows integer DEFAULT 0 NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: privacy_purge_runs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.privacy_purge_runs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: privacy_purge_runs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.privacy_purge_runs_id_seq OWNED BY public.privacy_purge_runs.id;


--
-- Name: privacy_request_appeals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.privacy_request_appeals (
    id bigint NOT NULL,
    workspace_slug text NOT NULL,
    privacy_request_id bigint,
    requester_user_id integer,
    status text DEFAULT 'submitted'::text NOT NULL,
    reason text NOT NULL,
    resolution_notes text,
    resolved_by_user_id integer,
    resolved_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: privacy_request_appeals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.privacy_request_appeals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: privacy_request_appeals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.privacy_request_appeals_id_seq OWNED BY public.privacy_request_appeals.id;


--
-- Name: privacy_request_verifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.privacy_request_verifications (
    id bigint NOT NULL,
    workspace_slug text NOT NULL,
    privacy_request_id bigint,
    requester_user_id integer,
    verification_method text DEFAULT 'authenticated_session'::text NOT NULL,
    status text DEFAULT 'verified'::text NOT NULL,
    verified_at timestamp with time zone,
    expires_at timestamp with time zone,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: privacy_request_verifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.privacy_request_verifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: privacy_request_verifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.privacy_request_verifications_id_seq OWNED BY public.privacy_request_verifications.id;


--
-- Name: privacy_requests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.privacy_requests (
    id bigint NOT NULL,
    workspace_slug text NOT NULL,
    requester_user_id integer,
    request_type text NOT NULL,
    status text DEFAULT 'pending'::text NOT NULL,
    scope jsonb DEFAULT '{}'::jsonb NOT NULL,
    requested_at timestamp with time zone DEFAULT now() NOT NULL,
    due_at timestamp with time zone NOT NULL,
    completed_at timestamp with time zone,
    backup_purge_due_at timestamp with time zone,
    backup_purged_at timestamp with time zone,
    last_error text,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL
);


--
-- Name: privacy_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.privacy_requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: privacy_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.privacy_requests_id_seq OWNED BY public.privacy_requests.id;


--
-- Name: proactive_tasks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.proactive_tasks (
    id integer NOT NULL,
    user_id integer NOT NULL,
    name character varying(200) NOT NULL,
    prompt text NOT NULL,
    frequency public.task_frequency DEFAULT 'weekly'::public.task_frequency NOT NULL,
    day_of_week integer,
    day_of_month integer,
    preferred_hour integer DEFAULT 9 NOT NULL,
    timezone character varying(100) DEFAULT 'America/Denver'::character varying NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    last_run_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    concurrency_policy public.concurrency_policy DEFAULT 'coalesce_if_active'::public.concurrency_policy NOT NULL,
    catch_up_policy public.catch_up_policy DEFAULT 'skip_missed'::public.catch_up_policy NOT NULL,
    assignee_agent_id integer,
    project_id integer,
    goal_id integer,
    routine_status public.routine_status DEFAULT 'active'::public.routine_status NOT NULL,
    workspace_slug text NOT NULL,
    catch_up_max integer DEFAULT 3 NOT NULL
);


--
-- Name: proactive_tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.proactive_tasks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: proactive_tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.proactive_tasks_id_seq OWNED BY public.proactive_tasks.id;


--
-- Name: project_storylines; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.project_storylines (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    workspace_slug text NOT NULL,
    project_id bigint NOT NULL,
    body text NOT NULL,
    base_generated_at timestamp with time zone DEFAULT now() NOT NULL,
    last_appended_at timestamp with time zone DEFAULT now() NOT NULL,
    append_count integer DEFAULT 0 NOT NULL,
    model text NOT NULL,
    total_input_tokens integer DEFAULT 0 NOT NULL,
    total_output_tokens integer DEFAULT 0 NOT NULL,
    generation_in_progress boolean DEFAULT false NOT NULL,
    generation_lock_acquired_at timestamp with time zone,
    last_error text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: projects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.projects (
    id integer NOT NULL,
    user_id integer NOT NULL,
    goal_id integer,
    name text NOT NULL,
    description text,
    status public.project_status DEFAULT 'backlog'::public.project_status NOT NULL,
    lead_agent_id integer,
    target_date date,
    color text,
    pause_reason text,
    paused_at timestamp with time zone,
    archived_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    workspace_slug text NOT NULL,
    originating_human_id integer,
    copy_voice_id integer,
    origin_thread_id text,
    objective_mode text DEFAULT 'one_time'::text NOT NULL,
    stopped_at timestamp with time zone,
    stop_reason text,
    iteration_count integer DEFAULT 0 NOT NULL,
    max_iterations integer,
    max_spend_cents integer,
    approval_message_id text
);


--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.projects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- Name: provider_exclusions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.provider_exclusions (
    id bigint NOT NULL,
    workspace_slug text NOT NULL,
    provider text NOT NULL,
    reason text,
    created_by_user_id integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: provider_exclusions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.provider_exclusions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: provider_exclusions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.provider_exclusions_id_seq OWNED BY public.provider_exclusions.id;


--
-- Name: provider_model_pricing; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.provider_model_pricing (
    provider text NOT NULL,
    model_id text NOT NULL,
    input_price_per_million_micros integer NOT NULL,
    output_price_per_million_micros integer NOT NULL,
    effective_at timestamp with time zone NOT NULL,
    superseded_at timestamp with time zone
);


--
-- Name: publish_drafts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.publish_drafts (
    id bigint NOT NULL,
    workspace_slug text NOT NULL,
    user_id integer NOT NULL,
    issue_id integer,
    agent_id integer,
    platform text NOT NULL,
    action_type text NOT NULL,
    status text DEFAULT 'draft'::text NOT NULL,
    version integer DEFAULT 1 NOT NULL,
    content_payload jsonb DEFAULT '{}'::jsonb NOT NULL,
    revision_notes text,
    external_execution_payload jsonb DEFAULT '{}'::jsonb NOT NULL,
    external_result jsonb,
    approved_at timestamp with time zone,
    published_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: publish_drafts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.publish_drafts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: publish_drafts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.publish_drafts_id_seq OWNED BY public.publish_drafts.id;


--
-- Name: publish_policies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.publish_policies (
    id bigint NOT NULL,
    workspace_slug text NOT NULL,
    user_id integer NOT NULL,
    default_mode text DEFAULT 'require_approval'::text NOT NULL,
    platform_modes jsonb DEFAULT '{}'::jsonb NOT NULL,
    auto_publish_unlock_threshold integer DEFAULT 5 NOT NULL,
    auto_publish_unlocked_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: publish_policies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.publish_policies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: publish_policies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.publish_policies_id_seq OWNED BY public.publish_policies.id;


--
-- Name: publish_quality_counters; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.publish_quality_counters (
    id bigint NOT NULL,
    workspace_slug text NOT NULL,
    user_id integer NOT NULL,
    approved_publish_count integer DEFAULT 0 NOT NULL,
    approved_by_platform jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: publish_quality_counters_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.publish_quality_counters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: publish_quality_counters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.publish_quality_counters_id_seq OWNED BY public.publish_quality_counters.id;


--
-- Name: rate_limit_entries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rate_limit_entries (
    id bigint NOT NULL,
    scope text NOT NULL,
    key text NOT NULL,
    attempted_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: rate_limit_entries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rate_limit_entries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rate_limit_entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rate_limit_entries_id_seq OWNED BY public.rate_limit_entries.id;


--
-- Name: raw_integration_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.raw_integration_events (
    id bigint NOT NULL,
    workspace_slug text,
    provider text NOT NULL,
    event_type text,
    external_event_id text,
    payload jsonb DEFAULT '{}'::jsonb NOT NULL,
    processing_status text DEFAULT 'pending'::text NOT NULL,
    processed_at timestamp with time zone,
    error text,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: raw_integration_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.raw_integration_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: raw_integration_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.raw_integration_events_id_seq OWNED BY public.raw_integration_events.id;


--
-- Name: realtime_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realtime_events (
    id bigint NOT NULL,
    workspace_slug text NOT NULL,
    event_type text NOT NULL,
    entity_type text NOT NULL,
    entity_id integer,
    payload jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: realtime_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.realtime_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: realtime_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.realtime_events_id_seq OWNED BY public.realtime_events.id;


--
-- Name: referral_rewards; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.referral_rewards (
    id bigint NOT NULL,
    invitation_id bigint NOT NULL,
    referrer_user_id integer NOT NULL,
    referrer_workspace_slug text NOT NULL,
    referred_user_id integer NOT NULL,
    referred_workspace_slug text NOT NULL,
    referrer_amount_cents integer DEFAULT 0 NOT NULL,
    referred_amount_cents integer DEFAULT 0 NOT NULL,
    status text DEFAULT 'granted'::text NOT NULL,
    denial_reason text,
    granted_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: referral_rewards_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.referral_rewards ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.referral_rewards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: root_skills; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.root_skills (
    id integer NOT NULL,
    slug text NOT NULL,
    name text NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    content text DEFAULT ''::text NOT NULL,
    tags jsonb DEFAULT '[]'::jsonb NOT NULL,
    sources jsonb DEFAULT '[]'::jsonb NOT NULL,
    version integer DEFAULT 1 NOT NULL,
    status text DEFAULT 'active'::text NOT NULL,
    origin text DEFAULT 'user'::text NOT NULL,
    created_by_user_id integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: root_skills_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.root_skills_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: root_skills_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.root_skills_id_seq OWNED BY public.root_skills.id;


--
-- Name: routine_runs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.routine_runs (
    id integer NOT NULL,
    user_id integer NOT NULL,
    proactive_task_id integer NOT NULL,
    trigger_id integer,
    source text DEFAULT 'schedule'::text NOT NULL,
    status public.routine_run_status DEFAULT 'received'::public.routine_run_status NOT NULL,
    triggered_at timestamp with time zone DEFAULT now() NOT NULL,
    idempotency_key text,
    linked_issue_id integer,
    failure_reason text,
    completed_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    workspace_slug text NOT NULL
);


--
-- Name: routine_runs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.routine_runs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: routine_runs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.routine_runs_id_seq OWNED BY public.routine_runs.id;


--
-- Name: routine_triggers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.routine_triggers (
    id integer NOT NULL,
    user_id integer NOT NULL,
    proactive_task_id integer NOT NULL,
    kind public.routine_trigger_kind DEFAULT 'schedule'::public.routine_trigger_kind NOT NULL,
    label text,
    cron_expression text,
    timezone text,
    enabled boolean DEFAULT true NOT NULL,
    next_run_at timestamp with time zone,
    last_fired_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    workspace_slug text NOT NULL,
    webhook_secret_encrypted text,
    webhook_url_token text
);


--
-- Name: routine_triggers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.routine_triggers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: routine_triggers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.routine_triggers_id_seq OWNED BY public.routine_triggers.id;


--
-- Name: routing_log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.routing_log (
    id integer NOT NULL,
    user_id integer NOT NULL,
    agent_id integer,
    routing_preference public.routing_preference NOT NULL,
    requested_tier public.capability_tier NOT NULL,
    resolved_provider text,
    resolved_model text,
    resolved_config jsonb,
    was_fallback boolean DEFAULT false NOT NULL,
    fallback_reason text,
    latency_ms integer,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    workspace_slug text NOT NULL,
    classifier_domain text,
    agent_primary_domains jsonb,
    classifier_confidence real,
    candidate_providers jsonb,
    priority_applied boolean DEFAULT false NOT NULL
);


--
-- Name: routing_log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.routing_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: routing_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.routing_log_id_seq OWNED BY public.routing_log.id;


--
-- Name: sanctions_screening_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sanctions_screening_events (
    id bigint NOT NULL,
    workspace_slug text,
    user_id integer,
    subject_type text DEFAULT 'user'::text NOT NULL,
    subject_id text,
    email text,
    name text,
    country_code text,
    region text,
    source text NOT NULL,
    status text NOT NULL,
    reasons jsonb DEFAULT '[]'::jsonb NOT NULL,
    matches jsonb DEFAULT '[]'::jsonb NOT NULL,
    screened_at timestamp with time zone DEFAULT now() NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL
);


--
-- Name: sanctions_screening_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sanctions_screening_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sanctions_screening_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sanctions_screening_events_id_seq OWNED BY public.sanctions_screening_events.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    id text NOT NULL,
    applied_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: seat_addon_invoice_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.seat_addon_invoice_items (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    workspace_slug text NOT NULL,
    seats_purchased integer NOT NULL,
    period_start timestamp with time zone NOT NULL,
    period_end timestamp with time zone NOT NULL,
    stripe_invoice_item_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: server_access_grants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.server_access_grants (
    id bigint NOT NULL,
    server_id text NOT NULL,
    grantee_user_id bigint NOT NULL,
    role text NOT NULL,
    workspace_scope text,
    granted_by_user_id bigint,
    expires_at timestamp with time zone,
    revoked_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: server_access_grants_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.server_access_grants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: server_access_grants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.server_access_grants_id_seq OWNED BY public.server_access_grants.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sessions (
    id text NOT NULL,
    user_id integer NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    last_accessed timestamp with time zone DEFAULT now()
);


--
-- Name: skill_proposals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.skill_proposals (
    id integer NOT NULL,
    canonical_key text NOT NULL,
    proposed_slug text NOT NULL,
    name text NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    content text DEFAULT ''::text NOT NULL,
    tags jsonb DEFAULT '[]'::jsonb NOT NULL,
    sources jsonb DEFAULT '[]'::jsonb NOT NULL,
    relationship text DEFAULT 'new'::text NOT NULL,
    target_root_skill_id integer,
    origin_workspace_slug text NOT NULL,
    proposed_by_agent_id integer,
    proposed_by_user_id integer,
    status text DEFAULT 'chief_proposed'::text NOT NULL,
    demand_count integer DEFAULT 1 NOT NULL,
    supporting_contexts jsonb DEFAULT '[]'::jsonb NOT NULL,
    judge_verdict jsonb,
    ceo_verdict jsonb,
    decided_by_user_id integer,
    decided_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    blocker_id bigint
);


--
-- Name: skill_proposals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.skill_proposals_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: skill_proposals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.skill_proposals_id_seq OWNED BY public.skill_proposals.id;


--
-- Name: skills; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.skills (
    id integer NOT NULL,
    workspace_slug text NOT NULL,
    slug text NOT NULL,
    name text NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    frontmatter jsonb DEFAULT '{}'::jsonb NOT NULL,
    content text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    user_id integer,
    is_system boolean DEFAULT false NOT NULL,
    root_skill_id integer,
    customization text,
    tags jsonb,
    sources jsonb,
    status text DEFAULT 'active'::text NOT NULL,
    version integer DEFAULT 1 NOT NULL,
    origin text DEFAULT 'user'::text NOT NULL
);


--
-- Name: skills_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.skills_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: skills_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.skills_id_seq OWNED BY public.skills.id;


--
-- Name: stripe_webhook_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stripe_webhook_events (
    id text NOT NULL,
    event_type text NOT NULL,
    processed_at timestamp with time zone DEFAULT now() NOT NULL,
    payload_summary jsonb
);


--
-- Name: subscription_tiers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.subscription_tiers (
    tier_id text NOT NULL,
    display_name text NOT NULL,
    monthly_price_cents integer,
    annual_price_cents integer,
    concurrent_executions integer NOT NULL,
    seats_included integer NOT NULL,
    additional_seat_price_cents integer,
    workspaces_allowed integer NOT NULL,
    hot_storage_mb integer NOT NULL,
    archive_storage_mb integer NOT NULL,
    retention_days integer NOT NULL,
    llm_markup_basis_points integer NOT NULL,
    default_daily_spend_cap_cents integer NOT NULL,
    max_daily_spend_cap_cents integer NOT NULL,
    soc2_access boolean NOT NULL,
    support_tier text NOT NULL,
    stripe_monthly_price_id text,
    stripe_annual_price_id text,
    stripe_seat_addon_price_id text,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    integration_actions_per_day integer DEFAULT 1000 NOT NULL,
    allow_uncapped_integrations boolean DEFAULT false NOT NULL
);


--
-- Name: sync_oplog; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sync_oplog (
    seq bigint NOT NULL,
    workspace_slug text NOT NULL,
    table_name text NOT NULL,
    pk text NOT NULL,
    op text NOT NULL,
    payload jsonb,
    lease_epoch bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    synced_at timestamp with time zone
);


--
-- Name: sync_oplog_seq_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sync_oplog_seq_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sync_oplog_seq_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sync_oplog_seq_seq OWNED BY public.sync_oplog.seq;


--
-- Name: system_flags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.system_flags (
    key text NOT NULL,
    value text NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: task_dedup_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.task_dedup_events (
    id bigint NOT NULL,
    workspace_slug text NOT NULL,
    duplicate_issue_id integer,
    canonical_issue_id integer NOT NULL,
    project_id integer,
    surface text NOT NULL,
    stage text NOT NULL,
    assignee_agent_id integer,
    duplicate_title text,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: task_dedup_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.task_dedup_events ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.task_dedup_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: team_members; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.team_members (
    id integer NOT NULL,
    user_id integer NOT NULL,
    name text NOT NULL,
    role_title text DEFAULT ''::text NOT NULL,
    email text DEFAULT ''::text NOT NULL,
    responsibilities text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    workspace_slug text NOT NULL
);


--
-- Name: team_members_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.team_members_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: team_members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.team_members_id_seq OWNED BY public.team_members.id;


--
-- Name: token_balance_transactions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.token_balance_transactions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    workspace_slug text NOT NULL,
    kind text NOT NULL,
    amount_cents integer NOT NULL,
    running_balance_cents integer NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: token_topup_prices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.token_topup_prices (
    amount_cents integer NOT NULL,
    stripe_price_id text,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: tool_call_repair_investigations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tool_call_repair_investigations (
    id bigint NOT NULL,
    provider text NOT NULL,
    model_id text NOT NULL,
    model_family text NOT NULL,
    error_kind text NOT NULL,
    error_signature text NOT NULL,
    status text DEFAULT 'queued'::text NOT NULL,
    failure_count integer DEFAULT 1 NOT NULL,
    first_seen_at timestamp with time zone DEFAULT now() NOT NULL,
    last_seen_at timestamp with time zone DEFAULT now() NOT NULL,
    last_run_id bigint,
    sample_run_ids jsonb DEFAULT '[]'::jsonb NOT NULL,
    raw_error_excerpt text,
    redacted_error_excerpt text,
    model_health_snapshot jsonb DEFAULT '{}'::jsonb NOT NULL,
    current_rule_snapshot jsonb,
    webhook_url text,
    webhook_triggered_at timestamp with time zone,
    webhook_attempt_count integer DEFAULT 0 NOT NULL,
    last_webhook_error text,
    next_webhook_attempt_at timestamp with time zone,
    github_issue_url text,
    kilo_branch text,
    resolution text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    github_pr_url text,
    artifact_reconciled_at timestamp with time zone,
    kilo_request_id text,
    kilo_session_id text,
    kilo_response_status text,
    kilo_response_body_excerpt text,
    kilo_captured_at timestamp with time zone,
    kilo_lifecycle_status text,
    claimed_at timestamp with time zone,
    claim_expires_at timestamp with time zone,
    claim_token text,
    claim_heartbeat_at timestamp with time zone,
    registry_snapshot_id text,
    kilo_trigger_mode text
);


--
-- Name: tool_call_repair_investigations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tool_call_repair_investigations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tool_call_repair_investigations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tool_call_repair_investigations_id_seq OWNED BY public.tool_call_repair_investigations.id;


--
-- Name: tool_write_grants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tool_write_grants (
    id bigint NOT NULL,
    workspace_slug text NOT NULL,
    app_slug text NOT NULL,
    project_id integer,
    covered_classes jsonb DEFAULT '["outbound", "golive"]'::jsonb NOT NULL,
    granted_by_user_id integer NOT NULL,
    revoked_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: tool_write_grants_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.tool_write_grants ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tool_write_grants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: trial_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.trial_events (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    workspace_slug text NOT NULL,
    event text NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: user_api_keys; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_api_keys (
    id integer NOT NULL,
    user_id integer NOT NULL,
    provider text NOT NULL,
    api_key text NOT NULL,
    label text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    workspace_slug text NOT NULL,
    key_hint character varying(10) DEFAULT ''::character varying,
    billing_model public.billing_model DEFAULT 'pay_per_token'::public.billing_model NOT NULL
);


--
-- Name: user_api_keys_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_api_keys_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_api_keys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_api_keys_id_seq OWNED BY public.user_api_keys.id;


--
-- Name: user_passwords; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_passwords (
    id integer NOT NULL,
    user_id integer NOT NULL,
    password_hash text NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


--
-- Name: user_passwords_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_passwords_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_passwords_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_passwords_id_seq OWNED BY public.user_passwords.id;


--
-- Name: user_workspace_preferences; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_workspace_preferences (
    workspace_slug text NOT NULL,
    user_id integer NOT NULL,
    artifact_destination_preferences jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    billing_banner_dismissals jsonb DEFAULT '{}'::jsonb NOT NULL,
    unified_inbox_channels jsonb DEFAULT '[]'::jsonb NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    display_name text NOT NULL,
    avatar_url text,
    role public.user_role DEFAULT 'user'::public.user_role NOT NULL,
    onboarding_completed boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    neon_auth_id text,
    stripe_customer_id text,
    beta_status public.beta_status_type DEFAULT 'waitlisted'::public.beta_status_type NOT NULL,
    invite_limit integer,
    sanctions_status text DEFAULT 'unscreened'::text NOT NULL,
    sanctions_screened_at timestamp with time zone,
    session_idle_timeout_seconds integer DEFAULT 7200 NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: waitlist_entries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.waitlist_entries (
    id bigint NOT NULL,
    email text NOT NULL,
    full_name text,
    company text,
    phone_encrypted text,
    use_case text,
    source text,
    status text DEFAULT 'pending'::text NOT NULL,
    notes text,
    invitation_id bigint,
    ip_hash text,
    user_agent text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: waitlist_entries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.waitlist_entries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: waitlist_entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.waitlist_entries_id_seq OWNED BY public.waitlist_entries.id;


--
-- Name: wake_outbox; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.wake_outbox (
    id bigint NOT NULL,
    workspace_slug text NOT NULL,
    user_id integer NOT NULL,
    target_agent_id integer NOT NULL,
    calling_agent_id integer,
    reason text NOT NULL,
    entity_id integer,
    chain_depth integer DEFAULT 0 NOT NULL,
    event_idempotency_key text NOT NULL,
    dedupe_key text,
    status text DEFAULT 'pending'::text NOT NULL,
    attempt_count integer DEFAULT 0 NOT NULL,
    next_attempt_at timestamp with time zone DEFAULT now() NOT NULL,
    last_error text,
    last_event_id text,
    dispatched_at timestamp with time zone,
    acknowledged_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: wake_outbox_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.wake_outbox_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wake_outbox_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.wake_outbox_id_seq OWNED BY public.wake_outbox.id;


--
-- Name: web_search_cache; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.web_search_cache (
    id bigint NOT NULL,
    kind text NOT NULL,
    cache_key text NOT NULL,
    result text NOT NULL,
    recency_class text NOT NULL,
    backend text,
    hits integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone NOT NULL
);


--
-- Name: web_search_cache_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.web_search_cache_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: web_search_cache_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.web_search_cache_id_seq OWNED BY public.web_search_cache.id;


--
-- Name: workspace_concurrency_slots; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.workspace_concurrency_slots (
    workspace_slug text NOT NULL,
    active_slots integer DEFAULT 0 NOT NULL,
    peak_today integer DEFAULT 0 NOT NULL,
    last_peak_reset timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: workspace_connected_integrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.workspace_connected_integrations (
    id integer NOT NULL,
    workspace_slug text NOT NULL,
    toolkit_slug text NOT NULL,
    connected_account_id text NOT NULL,
    provider text DEFAULT 'composio'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: workspace_connected_integrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.workspace_connected_integrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: workspace_connected_integrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.workspace_connected_integrations_id_seq OWNED BY public.workspace_connected_integrations.id;


--
-- Name: workspace_credentials; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.workspace_credentials (
    id bigint NOT NULL,
    workspace_slug text NOT NULL,
    service text NOT NULL,
    encrypted_credential text NOT NULL,
    credential_metadata jsonb DEFAULT '{}'::jsonb NOT NULL,
    connected_by_user_id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: workspace_credentials_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.workspace_credentials_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: workspace_credentials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.workspace_credentials_id_seq OWNED BY public.workspace_credentials.id;


--
-- Name: workspace_draft_push_preferences; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.workspace_draft_push_preferences (
    id bigint NOT NULL,
    workspace_slug text NOT NULL,
    app_slug text NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    created_by_user_id bigint,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: workspace_draft_push_preferences_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.workspace_draft_push_preferences_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: workspace_draft_push_preferences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.workspace_draft_push_preferences_id_seq OWNED BY public.workspace_draft_push_preferences.id;


--
-- Name: workspace_execution_lease; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.workspace_execution_lease (
    workspace_slug text NOT NULL,
    owner_site_id text NOT NULL,
    lease_epoch bigint DEFAULT 1 NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    last_renewed_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: workspace_execution_slot_reservations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.workspace_execution_slot_reservations (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    workspace_slug text NOT NULL,
    run_id bigint,
    agent_id bigint,
    issue_id bigint,
    heartbeat_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone DEFAULT (now() + '00:10:00'::interval) NOT NULL,
    released_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: workspace_execution_state; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.workspace_execution_state (
    workspace_slug text NOT NULL,
    state text DEFAULT 'active'::text NOT NULL,
    paused_at timestamp with time zone,
    pause_reason jsonb,
    last_probe_at timestamp with time zone,
    last_probe_result jsonb,
    resumed_at timestamp with time zone,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT workspace_execution_state_state_check CHECK ((state = ANY (ARRAY['active'::text, 'paused_model_exhaustion'::text])))
);


--
-- Name: workspace_integration_policies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.workspace_integration_policies (
    workspace_slug text NOT NULL,
    backend text NOT NULL,
    app_slug text NOT NULL,
    policy_mode text NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    admin_connection_id text,
    admin_configured_by_user_id bigint,
    requires_user_connection boolean DEFAULT true NOT NULL,
    review_required boolean DEFAULT false NOT NULL,
    single_user_bootstrapped boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    action_slug text,
    gate_class_override public.gate_class,
    override_rationale text,
    override_source public.policy_source DEFAULT 'curated'::public.policy_source
);


--
-- Name: workspace_invites; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.workspace_invites (
    id integer NOT NULL,
    workspace_slug text NOT NULL,
    email text NOT NULL,
    role public.workspace_role DEFAULT 'member'::public.workspace_role NOT NULL,
    token_hash text NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    accepted_at timestamp with time zone,
    revoked_at timestamp with time zone,
    invited_by_user_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: workspace_invites_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.workspace_invites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: workspace_invites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.workspace_invites_id_seq OWNED BY public.workspace_invites.id;


--
-- Name: workspace_members; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.workspace_members (
    id integer NOT NULL,
    workspace_slug text NOT NULL,
    user_id integer NOT NULL,
    role text DEFAULT 'owner'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    capability_overrides jsonb DEFAULT '{}'::jsonb NOT NULL,
    seat_status text DEFAULT 'active'::text NOT NULL,
    inactive_since timestamp with time zone,
    released_at timestamp with time zone
);


--
-- Name: workspace_members_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.workspace_members_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: workspace_members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.workspace_members_id_seq OWNED BY public.workspace_members.id;


--
-- Name: workspace_storage_usage; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.workspace_storage_usage (
    workspace_slug text NOT NULL,
    hot_storage_mb integer DEFAULT 0 NOT NULL,
    archive_storage_mb integer DEFAULT 0 NOT NULL,
    last_measured_at timestamp with time zone DEFAULT now() NOT NULL,
    read_only_since timestamp with time zone
);


--
-- Name: workspace_subscriptions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.workspace_subscriptions (
    workspace_slug text NOT NULL,
    tier_id text DEFAULT 'team'::text NOT NULL,
    status text DEFAULT 'trialing'::text NOT NULL,
    trial_started_at timestamp with time zone,
    trial_ends_at timestamp with time zone,
    current_period_start timestamp with time zone,
    current_period_end timestamp with time zone,
    billing_cadence text,
    seats_purchased integer DEFAULT 0 NOT NULL,
    stripe_subscription_id text,
    stripe_customer_id text,
    cancel_at_period_end boolean DEFAULT false NOT NULL,
    downgraded_from_tier text,
    downgraded_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    is_byok boolean DEFAULT false NOT NULL
);


--
-- Name: workspace_token_balance; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.workspace_token_balance (
    workspace_slug text NOT NULL,
    balance_cents integer DEFAULT 0 NOT NULL,
    lifetime_funded_cents integer DEFAULT 0 NOT NULL,
    lifetime_consumed_cents integer DEFAULT 0 NOT NULL,
    lifetime_markup_collected_cents integer DEFAULT 0 NOT NULL,
    auto_recharge_enabled boolean DEFAULT false NOT NULL,
    auto_recharge_threshold_cents integer DEFAULT 500 NOT NULL,
    auto_recharge_amount_cents integer DEFAULT 2500 NOT NULL,
    daily_spend_cap_cents integer DEFAULT 2500 NOT NULL,
    today_spent_cents integer DEFAULT 0 NOT NULL,
    today_reset_at timestamp with time zone DEFAULT now() NOT NULL,
    velocity_paused_until timestamp with time zone,
    paused_reason text,
    today_integration_actions integer DEFAULT 0 NOT NULL,
    uncapped_integrations_enabled boolean DEFAULT false NOT NULL,
    plan_granted_cents integer DEFAULT 0 NOT NULL
);


--
-- Name: workspaces; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.workspaces (
    id integer NOT NULL,
    slug text NOT NULL,
    name text NOT NULL,
    owner_user_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    onboarding_completed_at timestamp with time zone,
    business_phase public.business_phase,
    stripe_subscription_id text,
    plan_tier text DEFAULT 'free'::text NOT NULL,
    plan_status text DEFAULT 'active'::text NOT NULL,
    trial_ends_at timestamp with time zone,
    current_period_start timestamp with time zone,
    current_period_end timestamp with time zone
);


--
-- Name: workspaces_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.workspaces_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: workspaces_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.workspaces_id_seq OWNED BY public.workspaces.id;


--
-- Name: accessibility_audit_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accessibility_audit_items ALTER COLUMN id SET DEFAULT nextval('public.accessibility_audit_items_id_seq'::regclass);


--
-- Name: activity_log id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.activity_log ALTER COLUMN id SET DEFAULT nextval('public.activity_log_id_seq'::regclass);


--
-- Name: agent_backlog id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_backlog ALTER COLUMN id SET DEFAULT nextval('public.agent_backlog_id_seq'::regclass);


--
-- Name: agent_execution_locks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_execution_locks ALTER COLUMN id SET DEFAULT nextval('public.agent_execution_locks_id_seq'::regclass);


--
-- Name: agent_keys id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_keys ALTER COLUMN id SET DEFAULT nextval('public.agent_keys_id_seq'::regclass);


--
-- Name: agent_model_config id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_model_config ALTER COLUMN id SET DEFAULT nextval('public.agent_model_config_id_seq'::regclass);


--
-- Name: agent_runs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_runs ALTER COLUMN id SET DEFAULT nextval('public.agent_runs_id_seq'::regclass);


--
-- Name: agent_skills id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_skills ALTER COLUMN id SET DEFAULT nextval('public.agent_skills_id_seq'::regclass);


--
-- Name: agent_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_tokens ALTER COLUMN id SET DEFAULT nextval('public.agent_tokens_id_seq'::regclass);


--
-- Name: agent_wakeup_requests id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_wakeup_requests ALTER COLUMN id SET DEFAULT nextval('public.agent_wakeup_requests_id_seq'::regclass);


--
-- Name: agents id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agents ALTER COLUMN id SET DEFAULT nextval('public.agents_id_seq'::regclass);


--
-- Name: approvals id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.approvals ALTER COLUMN id SET DEFAULT nextval('public.approvals_id_seq'::regclass);


--
-- Name: beta_access_log id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.beta_access_log ALTER COLUMN id SET DEFAULT nextval('public.beta_access_log_id_seq'::regclass);


--
-- Name: beta_invitations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.beta_invitations ALTER COLUMN id SET DEFAULT nextval('public.beta_invitations_id_seq'::regclass);


--
-- Name: blocker_digests id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blocker_digests ALTER COLUMN id SET DEFAULT nextval('public.blocker_digests_id_seq'::regclass);


--
-- Name: business_profiles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.business_profiles ALTER COLUMN id SET DEFAULT nextval('public.business_profiles_id_seq'::regclass);


--
-- Name: channels id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.channels ALTER COLUMN id SET DEFAULT nextval('public.channels_id_seq'::regclass);


--
-- Name: communication_compliance_events id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.communication_compliance_events ALTER COLUMN id SET DEFAULT nextval('public.communication_compliance_events_id_seq'::regclass);


--
-- Name: communication_consents id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.communication_consents ALTER COLUMN id SET DEFAULT nextval('public.communication_consents_id_seq'::regclass);


--
-- Name: communication_suppressions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.communication_suppressions ALTER COLUMN id SET DEFAULT nextval('public.communication_suppressions_id_seq'::regclass);


--
-- Name: compliance_access_events id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.compliance_access_events ALTER COLUMN id SET DEFAULT nextval('public.compliance_access_events_id_seq'::regclass);


--
-- Name: compliance_incidents id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.compliance_incidents ALTER COLUMN id SET DEFAULT nextval('public.compliance_incidents_id_seq'::regclass);


--
-- Name: compliance_monitor_runs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.compliance_monitor_runs ALTER COLUMN id SET DEFAULT nextval('public.compliance_monitor_runs_id_seq'::regclass);


--
-- Name: compliance_uptime_checks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.compliance_uptime_checks ALTER COLUMN id SET DEFAULT nextval('public.compliance_uptime_checks_id_seq'::regclass);


--
-- Name: composio_recommendations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.composio_recommendations ALTER COLUMN id SET DEFAULT nextval('public.composio_recommendations_id_seq'::regclass);


--
-- Name: config_versions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.config_versions ALTER COLUMN id SET DEFAULT nextval('public.config_versions_id_seq'::regclass);


--
-- Name: connected_accounts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.connected_accounts ALTER COLUMN id SET DEFAULT nextval('public.connected_accounts_id_seq'::regclass);


--
-- Name: copy_voices id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.copy_voices ALTER COLUMN id SET DEFAULT nextval('public.copy_voices_id_seq'::regclass);


--
-- Name: cost_events id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cost_events ALTER COLUMN id SET DEFAULT nextval('public.cost_events_id_seq'::regclass);


--
-- Name: customer_notification_obligations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_notification_obligations ALTER COLUMN id SET DEFAULT nextval('public.customer_notification_obligations_id_seq'::regclass);


--
-- Name: deliverable_proposed_tasks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deliverable_proposed_tasks ALTER COLUMN id SET DEFAULT nextval('public.deliverable_proposed_tasks_id_seq'::regclass);


--
-- Name: deliverable_sections id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deliverable_sections ALTER COLUMN id SET DEFAULT nextval('public.deliverable_sections_id_seq'::regclass);


--
-- Name: deliverables id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deliverables ALTER COLUMN id SET DEFAULT nextval('public.deliverables_id_seq'::regclass);


--
-- Name: delivery_problem_reports id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_problem_reports ALTER COLUMN id SET DEFAULT nextval('public.delivery_problem_reports_id_seq'::regclass);


--
-- Name: execution_blockers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.execution_blockers ALTER COLUMN id SET DEFAULT nextval('public.execution_blockers_id_seq'::regclass);


--
-- Name: global_model_catalog id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.global_model_catalog ALTER COLUMN id SET DEFAULT nextval('public.global_model_catalog_id_seq'::regclass);


--
-- Name: goal_archetypes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.goal_archetypes ALTER COLUMN id SET DEFAULT nextval('public.goal_archetypes_id_seq'::regclass);


--
-- Name: goal_measurements id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.goal_measurements ALTER COLUMN id SET DEFAULT nextval('public.goal_measurements_id_seq'::regclass);


--
-- Name: goals id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.goals ALTER COLUMN id SET DEFAULT nextval('public.goals_id_seq'::regclass);


--
-- Name: high_risk_gate_events id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.high_risk_gate_events ALTER COLUMN id SET DEFAULT nextval('public.high_risk_gate_events_id_seq'::regclass);


--
-- Name: hub_channels id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_channels ALTER COLUMN id SET DEFAULT nextval('public.hub_channels_id_seq'::regclass);


--
-- Name: hub_conversations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_conversations ALTER COLUMN id SET DEFAULT nextval('public.hub_conversations_id_seq'::regclass);


--
-- Name: hub_internal_comments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_internal_comments ALTER COLUMN id SET DEFAULT nextval('public.hub_internal_comments_id_seq'::regclass);


--
-- Name: hub_message_attachments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_message_attachments ALTER COLUMN id SET DEFAULT nextval('public.hub_message_attachments_id_seq'::regclass);


--
-- Name: hub_message_participants id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_message_participants ALTER COLUMN id SET DEFAULT nextval('public.hub_message_participants_id_seq'::regclass);


--
-- Name: hub_messages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_messages ALTER COLUMN id SET DEFAULT nextval('public.hub_messages_id_seq'::regclass);


--
-- Name: hub_routing_rules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_routing_rules ALTER COLUMN id SET DEFAULT nextval('public.hub_routing_rules_id_seq'::regclass);


--
-- Name: hub_tags id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_tags ALTER COLUMN id SET DEFAULT nextval('public.hub_tags_id_seq'::regclass);


--
-- Name: idempotency_ledger id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.idempotency_ledger ALTER COLUMN id SET DEFAULT nextval('public.idempotency_ledger_id_seq'::regclass);


--
-- Name: inbox_conversations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inbox_conversations ALTER COLUMN id SET DEFAULT nextval('public.inbox_conversations_id_seq'::regclass);


--
-- Name: inbox_messages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inbox_messages ALTER COLUMN id SET DEFAULT nextval('public.inbox_messages_id_seq'::regclass);


--
-- Name: inbox_notifications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inbox_notifications ALTER COLUMN id SET DEFAULT nextval('public.inbox_notifications_id_seq'::regclass);


--
-- Name: integration_action_policies id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.integration_action_policies ALTER COLUMN id SET DEFAULT nextval('public.integration_action_policies_id_seq'::regclass);


--
-- Name: issue_comments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issue_comments ALTER COLUMN id SET DEFAULT nextval('public.issue_comments_id_seq'::regclass);


--
-- Name: issue_decompositions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issue_decompositions ALTER COLUMN id SET DEFAULT nextval('public.issue_decompositions_id_seq'::regclass);


--
-- Name: issue_review_attempts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issue_review_attempts ALTER COLUMN id SET DEFAULT nextval('public.issue_review_attempts_id_seq'::regclass);


--
-- Name: issues id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issues ALTER COLUMN id SET DEFAULT nextval('public.issues_id_seq'::regclass);


--
-- Name: legal_acceptances id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.legal_acceptances ALTER COLUMN id SET DEFAULT nextval('public.legal_acceptances_id_seq'::regclass);


--
-- Name: login_attempts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.login_attempts ALTER COLUMN id SET DEFAULT nextval('public.login_attempts_id_seq'::regclass);


--
-- Name: memory_entries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.memory_entries ALTER COLUMN id SET DEFAULT nextval('public.memory_entries_id_seq'::regclass);


--
-- Name: message_delivery_attempts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message_delivery_attempts ALTER COLUMN id SET DEFAULT nextval('public.message_delivery_attempts_id_seq'::regclass);


--
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- Name: model_registry id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.model_registry ALTER COLUMN id SET DEFAULT nextval('public.model_registry_id_seq'::regclass);


--
-- Name: needs_from_you_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.needs_from_you_items ALTER COLUMN id SET DEFAULT nextval('public.needs_from_you_items_id_seq'::regclass);


--
-- Name: oauth_accounts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_accounts ALTER COLUMN id SET DEFAULT nextval('public.oauth_accounts_id_seq'::regclass);


--
-- Name: oauth_states id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_states ALTER COLUMN id SET DEFAULT nextval('public.oauth_states_id_seq'::regclass);


--
-- Name: participants id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.participants ALTER COLUMN id SET DEFAULT nextval('public.participants_id_seq'::regclass);


--
-- Name: payment_handoff_events id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_handoff_events ALTER COLUMN id SET DEFAULT nextval('public.payment_handoff_events_id_seq'::regclass);


--
-- Name: principals id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.principals ALTER COLUMN id SET DEFAULT nextval('public.principals_id_seq'::regclass);


--
-- Name: privacy_audit_events id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.privacy_audit_events ALTER COLUMN id SET DEFAULT nextval('public.privacy_audit_events_id_seq'::regclass);


--
-- Name: privacy_purge_runs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.privacy_purge_runs ALTER COLUMN id SET DEFAULT nextval('public.privacy_purge_runs_id_seq'::regclass);


--
-- Name: privacy_request_appeals id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.privacy_request_appeals ALTER COLUMN id SET DEFAULT nextval('public.privacy_request_appeals_id_seq'::regclass);


--
-- Name: privacy_request_verifications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.privacy_request_verifications ALTER COLUMN id SET DEFAULT nextval('public.privacy_request_verifications_id_seq'::regclass);


--
-- Name: privacy_requests id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.privacy_requests ALTER COLUMN id SET DEFAULT nextval('public.privacy_requests_id_seq'::regclass);


--
-- Name: proactive_tasks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.proactive_tasks ALTER COLUMN id SET DEFAULT nextval('public.proactive_tasks_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- Name: provider_exclusions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.provider_exclusions ALTER COLUMN id SET DEFAULT nextval('public.provider_exclusions_id_seq'::regclass);


--
-- Name: publish_drafts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.publish_drafts ALTER COLUMN id SET DEFAULT nextval('public.publish_drafts_id_seq'::regclass);


--
-- Name: publish_policies id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.publish_policies ALTER COLUMN id SET DEFAULT nextval('public.publish_policies_id_seq'::regclass);


--
-- Name: publish_quality_counters id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.publish_quality_counters ALTER COLUMN id SET DEFAULT nextval('public.publish_quality_counters_id_seq'::regclass);


--
-- Name: rate_limit_entries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rate_limit_entries ALTER COLUMN id SET DEFAULT nextval('public.rate_limit_entries_id_seq'::regclass);


--
-- Name: raw_integration_events id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.raw_integration_events ALTER COLUMN id SET DEFAULT nextval('public.raw_integration_events_id_seq'::regclass);


--
-- Name: realtime_events id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realtime_events ALTER COLUMN id SET DEFAULT nextval('public.realtime_events_id_seq'::regclass);


--
-- Name: root_skills id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.root_skills ALTER COLUMN id SET DEFAULT nextval('public.root_skills_id_seq'::regclass);


--
-- Name: routine_runs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.routine_runs ALTER COLUMN id SET DEFAULT nextval('public.routine_runs_id_seq'::regclass);


--
-- Name: routine_triggers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.routine_triggers ALTER COLUMN id SET DEFAULT nextval('public.routine_triggers_id_seq'::regclass);


--
-- Name: routing_log id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.routing_log ALTER COLUMN id SET DEFAULT nextval('public.routing_log_id_seq'::regclass);


--
-- Name: sanctions_screening_events id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sanctions_screening_events ALTER COLUMN id SET DEFAULT nextval('public.sanctions_screening_events_id_seq'::regclass);


--
-- Name: server_access_grants id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.server_access_grants ALTER COLUMN id SET DEFAULT nextval('public.server_access_grants_id_seq'::regclass);


--
-- Name: skill_proposals id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.skill_proposals ALTER COLUMN id SET DEFAULT nextval('public.skill_proposals_id_seq'::regclass);


--
-- Name: skills id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.skills ALTER COLUMN id SET DEFAULT nextval('public.skills_id_seq'::regclass);


--
-- Name: sync_oplog seq; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sync_oplog ALTER COLUMN seq SET DEFAULT nextval('public.sync_oplog_seq_seq'::regclass);


--
-- Name: team_members id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.team_members ALTER COLUMN id SET DEFAULT nextval('public.team_members_id_seq'::regclass);


--
-- Name: tool_call_repair_investigations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tool_call_repair_investigations ALTER COLUMN id SET DEFAULT nextval('public.tool_call_repair_investigations_id_seq'::regclass);


--
-- Name: user_api_keys id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_api_keys ALTER COLUMN id SET DEFAULT nextval('public.user_api_keys_id_seq'::regclass);


--
-- Name: user_passwords id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_passwords ALTER COLUMN id SET DEFAULT nextval('public.user_passwords_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: waitlist_entries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.waitlist_entries ALTER COLUMN id SET DEFAULT nextval('public.waitlist_entries_id_seq'::regclass);


--
-- Name: wake_outbox id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wake_outbox ALTER COLUMN id SET DEFAULT nextval('public.wake_outbox_id_seq'::regclass);


--
-- Name: web_search_cache id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.web_search_cache ALTER COLUMN id SET DEFAULT nextval('public.web_search_cache_id_seq'::regclass);


--
-- Name: workspace_connected_integrations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workspace_connected_integrations ALTER COLUMN id SET DEFAULT nextval('public.workspace_connected_integrations_id_seq'::regclass);


--
-- Name: workspace_credentials id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workspace_credentials ALTER COLUMN id SET DEFAULT nextval('public.workspace_credentials_id_seq'::regclass);


--
-- Name: workspace_draft_push_preferences id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workspace_draft_push_preferences ALTER COLUMN id SET DEFAULT nextval('public.workspace_draft_push_preferences_id_seq'::regclass);


--
-- Name: workspace_invites id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workspace_invites ALTER COLUMN id SET DEFAULT nextval('public.workspace_invites_id_seq'::regclass);


--
-- Name: workspace_members id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workspace_members ALTER COLUMN id SET DEFAULT nextval('public.workspace_members_id_seq'::regclass);


--
-- Name: workspaces id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workspaces ALTER COLUMN id SET DEFAULT nextval('public.workspaces_id_seq'::regclass);


--
-- Name: account account_pkey; Type: CONSTRAINT; Schema: neon_auth; Owner: -
--

ALTER TABLE ONLY neon_auth.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);


--
-- Name: invitation invitation_pkey; Type: CONSTRAINT; Schema: neon_auth; Owner: -
--

ALTER TABLE ONLY neon_auth.invitation
    ADD CONSTRAINT invitation_pkey PRIMARY KEY (id);


--
-- Name: jwks jwks_pkey; Type: CONSTRAINT; Schema: neon_auth; Owner: -
--

ALTER TABLE ONLY neon_auth.jwks
    ADD CONSTRAINT jwks_pkey PRIMARY KEY (id);


--
-- Name: member member_pkey; Type: CONSTRAINT; Schema: neon_auth; Owner: -
--

ALTER TABLE ONLY neon_auth.member
    ADD CONSTRAINT member_pkey PRIMARY KEY (id);


--
-- Name: organization organization_pkey; Type: CONSTRAINT; Schema: neon_auth; Owner: -
--

ALTER TABLE ONLY neon_auth.organization
    ADD CONSTRAINT organization_pkey PRIMARY KEY (id);


--
-- Name: organization organization_slug_key; Type: CONSTRAINT; Schema: neon_auth; Owner: -
--

ALTER TABLE ONLY neon_auth.organization
    ADD CONSTRAINT organization_slug_key UNIQUE (slug);


--
-- Name: project_config project_config_endpoint_id_key; Type: CONSTRAINT; Schema: neon_auth; Owner: -
--

ALTER TABLE ONLY neon_auth.project_config
    ADD CONSTRAINT project_config_endpoint_id_key UNIQUE (endpoint_id);


--
-- Name: project_config project_config_pkey; Type: CONSTRAINT; Schema: neon_auth; Owner: -
--

ALTER TABLE ONLY neon_auth.project_config
    ADD CONSTRAINT project_config_pkey PRIMARY KEY (id);


--
-- Name: session session_pkey; Type: CONSTRAINT; Schema: neon_auth; Owner: -
--

ALTER TABLE ONLY neon_auth.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (id);


--
-- Name: session session_token_key; Type: CONSTRAINT; Schema: neon_auth; Owner: -
--

ALTER TABLE ONLY neon_auth.session
    ADD CONSTRAINT session_token_key UNIQUE (token);


--
-- Name: user user_email_key; Type: CONSTRAINT; Schema: neon_auth; Owner: -
--

ALTER TABLE ONLY neon_auth."user"
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- Name: user user_phoneNumber_key; Type: CONSTRAINT; Schema: neon_auth; Owner: -
--

ALTER TABLE ONLY neon_auth."user"
    ADD CONSTRAINT "user_phoneNumber_key" UNIQUE ("phoneNumber");


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: neon_auth; Owner: -
--

ALTER TABLE ONLY neon_auth."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: verification verification_pkey; Type: CONSTRAINT; Schema: neon_auth; Owner: -
--

ALTER TABLE ONLY neon_auth.verification
    ADD CONSTRAINT verification_pkey PRIMARY KEY (id);


--
-- Name: accessibility_audit_items accessibility_audit_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accessibility_audit_items
    ADD CONSTRAINT accessibility_audit_items_pkey PRIMARY KEY (id);


--
-- Name: activity_log activity_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.activity_log
    ADD CONSTRAINT activity_log_pkey PRIMARY KEY (id);


--
-- Name: agent_backlog agent_backlog_agent_id_issue_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_backlog
    ADD CONSTRAINT agent_backlog_agent_id_issue_id_key UNIQUE (agent_id, issue_id);


--
-- Name: agent_backlog agent_backlog_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_backlog
    ADD CONSTRAINT agent_backlog_pkey PRIMARY KEY (id);


--
-- Name: agent_execution_locks agent_execution_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_execution_locks
    ADD CONSTRAINT agent_execution_locks_pkey PRIMARY KEY (id);


--
-- Name: agent_keys agent_keys_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_keys
    ADD CONSTRAINT agent_keys_pkey PRIMARY KEY (id);


--
-- Name: agent_model_config agent_model_config_agent_id_profile_key_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_model_config
    ADD CONSTRAINT agent_model_config_agent_id_profile_key_key UNIQUE (agent_id, profile_key);


--
-- Name: agent_model_config agent_model_config_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_model_config
    ADD CONSTRAINT agent_model_config_pkey PRIMARY KEY (id);


--
-- Name: agent_runs agent_runs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_runs
    ADD CONSTRAINT agent_runs_pkey PRIMARY KEY (id);


--
-- Name: agent_skills agent_skills_agent_id_skill_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_skills
    ADD CONSTRAINT agent_skills_agent_id_skill_id_key UNIQUE (agent_id, skill_id);


--
-- Name: agent_skills agent_skills_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_skills
    ADD CONSTRAINT agent_skills_pkey PRIMARY KEY (id);


--
-- Name: agent_tokens agent_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_tokens
    ADD CONSTRAINT agent_tokens_pkey PRIMARY KEY (id);


--
-- Name: agent_wakeup_requests agent_wakeup_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_wakeup_requests
    ADD CONSTRAINT agent_wakeup_requests_pkey PRIMARY KEY (id);


--
-- Name: agents agents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agents
    ADD CONSTRAINT agents_pkey PRIMARY KEY (id);


--
-- Name: app_cache app_cache_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_cache
    ADD CONSTRAINT app_cache_pkey PRIMARY KEY (cache_key);


--
-- Name: app_settings app_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.app_settings
    ADD CONSTRAINT app_settings_pkey PRIMARY KEY (key);


--
-- Name: approvals approvals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.approvals
    ADD CONSTRAINT approvals_pkey PRIMARY KEY (id);


--
-- Name: archived_objects archived_objects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.archived_objects
    ADD CONSTRAINT archived_objects_pkey PRIMARY KEY (id);


--
-- Name: beta_access_log beta_access_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.beta_access_log
    ADD CONSTRAINT beta_access_log_pkey PRIMARY KEY (id);


--
-- Name: beta_invitations beta_invitations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.beta_invitations
    ADD CONSTRAINT beta_invitations_pkey PRIMARY KEY (id);


--
-- Name: beta_invitations beta_invitations_token_hash_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.beta_invitations
    ADD CONSTRAINT beta_invitations_token_hash_key UNIQUE (token_hash);


--
-- Name: blocker_digests blocker_digests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blocker_digests
    ADD CONSTRAINT blocker_digests_pkey PRIMARY KEY (id);


--
-- Name: blog_posts blog_posts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_posts
    ADD CONSTRAINT blog_posts_pkey PRIMARY KEY (id);


--
-- Name: blog_posts blog_posts_slug_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_posts
    ADD CONSTRAINT blog_posts_slug_key UNIQUE (slug);


--
-- Name: business_profiles business_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.business_profiles
    ADD CONSTRAINT business_profiles_pkey PRIMARY KEY (id);


--
-- Name: business_profiles business_profiles_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.business_profiles
    ADD CONSTRAINT business_profiles_user_id_key UNIQUE (user_id);


--
-- Name: channels channels_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_pkey PRIMARY KEY (id);


--
-- Name: chat_threads chat_threads_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.chat_threads
    ADD CONSTRAINT chat_threads_pkey PRIMARY KEY (id, workspace_slug);


--
-- Name: communication_compliance_events communication_compliance_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.communication_compliance_events
    ADD CONSTRAINT communication_compliance_events_pkey PRIMARY KEY (id);


--
-- Name: communication_consents communication_consents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.communication_consents
    ADD CONSTRAINT communication_consents_pkey PRIMARY KEY (id);


--
-- Name: communication_suppressions communication_suppressions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.communication_suppressions
    ADD CONSTRAINT communication_suppressions_pkey PRIMARY KEY (id);


--
-- Name: compliance_access_events compliance_access_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.compliance_access_events
    ADD CONSTRAINT compliance_access_events_pkey PRIMARY KEY (id);


--
-- Name: compliance_incidents compliance_incidents_incident_key_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.compliance_incidents
    ADD CONSTRAINT compliance_incidents_incident_key_key UNIQUE (incident_key);


--
-- Name: compliance_incidents compliance_incidents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.compliance_incidents
    ADD CONSTRAINT compliance_incidents_pkey PRIMARY KEY (id);


--
-- Name: compliance_monitor_runs compliance_monitor_runs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.compliance_monitor_runs
    ADD CONSTRAINT compliance_monitor_runs_pkey PRIMARY KEY (id);


--
-- Name: compliance_uptime_checks compliance_uptime_checks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.compliance_uptime_checks
    ADD CONSTRAINT compliance_uptime_checks_pkey PRIMARY KEY (id);


--
-- Name: composio_recommendations composio_recommendations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.composio_recommendations
    ADD CONSTRAINT composio_recommendations_pkey PRIMARY KEY (id);


--
-- Name: config_versions config_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.config_versions
    ADD CONSTRAINT config_versions_pkey PRIMARY KEY (id);


--
-- Name: connected_account_identity connected_account_identity_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.connected_account_identity
    ADD CONSTRAINT connected_account_identity_pkey PRIMARY KEY (connected_account_id);


--
-- Name: connected_accounts connected_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.connected_accounts
    ADD CONSTRAINT connected_accounts_pkey PRIMARY KEY (id);


--
-- Name: copy_voices copy_voices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.copy_voices
    ADD CONSTRAINT copy_voices_pkey PRIMARY KEY (id);


--
-- Name: copy_voices copy_voices_workspace_slug_key_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.copy_voices
    ADD CONSTRAINT copy_voices_workspace_slug_key_key UNIQUE (workspace_slug, key);


--
-- Name: cost_events cost_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cost_events
    ADD CONSTRAINT cost_events_pkey PRIMARY KEY (id);


--
-- Name: cron_run_log cron_run_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cron_run_log
    ADD CONSTRAINT cron_run_log_pkey PRIMARY KEY (id);


--
-- Name: customer_notification_obligations customer_notification_obligations_dedupe_key_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_notification_obligations
    ADD CONSTRAINT customer_notification_obligations_dedupe_key_key UNIQUE (dedupe_key);


--
-- Name: customer_notification_obligations customer_notification_obligations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer_notification_obligations
    ADD CONSTRAINT customer_notification_obligations_pkey PRIMARY KEY (id);


--
-- Name: deliverable_proposed_tasks deliverable_proposed_tasks_deliverable_id_position_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deliverable_proposed_tasks
    ADD CONSTRAINT deliverable_proposed_tasks_deliverable_id_position_key UNIQUE (deliverable_id, "position");


--
-- Name: deliverable_proposed_tasks deliverable_proposed_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deliverable_proposed_tasks
    ADD CONSTRAINT deliverable_proposed_tasks_pkey PRIMARY KEY (id);


--
-- Name: deliverable_sections deliverable_sections_deliverable_id_position_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deliverable_sections
    ADD CONSTRAINT deliverable_sections_deliverable_id_position_key UNIQUE (deliverable_id, "position");


--
-- Name: deliverable_sections deliverable_sections_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deliverable_sections
    ADD CONSTRAINT deliverable_sections_pkey PRIMARY KEY (id);


--
-- Name: deliverables deliverables_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deliverables
    ADD CONSTRAINT deliverables_pkey PRIMARY KEY (id);


--
-- Name: delivery_problem_reports delivery_problem_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_problem_reports
    ADD CONSTRAINT delivery_problem_reports_pkey PRIMARY KEY (id);


--
-- Name: execution_blockers execution_blockers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.execution_blockers
    ADD CONSTRAINT execution_blockers_pkey PRIMARY KEY (id);


--
-- Name: feedback_reports feedback_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feedback_reports
    ADD CONSTRAINT feedback_reports_pkey PRIMARY KEY (id);


--
-- Name: free_tier_ledger free_tier_ledger_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.free_tier_ledger
    ADD CONSTRAINT free_tier_ledger_pkey PRIMARY KEY (workspace_slug, period_key);


--
-- Name: global_model_catalog global_model_catalog_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.global_model_catalog
    ADD CONSTRAINT global_model_catalog_pkey PRIMARY KEY (id);


--
-- Name: global_model_catalog global_model_catalog_provider_id_model_id_capability_tier_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.global_model_catalog
    ADD CONSTRAINT global_model_catalog_provider_id_model_id_capability_tier_key UNIQUE (provider_id, model_id, capability_tier);


--
-- Name: goal_archetypes goal_archetypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.goal_archetypes
    ADD CONSTRAINT goal_archetypes_pkey PRIMARY KEY (id);


--
-- Name: goal_measurements goal_measurements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.goal_measurements
    ADD CONSTRAINT goal_measurements_pkey PRIMARY KEY (id);


--
-- Name: goals goals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.goals
    ADD CONSTRAINT goals_pkey PRIMARY KEY (id);


--
-- Name: high_risk_gate_events high_risk_gate_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.high_risk_gate_events
    ADD CONSTRAINT high_risk_gate_events_pkey PRIMARY KEY (id);


--
-- Name: hub_channels hub_channels_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_channels
    ADD CONSTRAINT hub_channels_pkey PRIMARY KEY (id);


--
-- Name: hub_channels hub_channels_webhook_token_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_channels
    ADD CONSTRAINT hub_channels_webhook_token_key UNIQUE (webhook_token);


--
-- Name: hub_conversation_reads hub_conversation_reads_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_conversation_reads
    ADD CONSTRAINT hub_conversation_reads_pkey PRIMARY KEY (member_id, conversation_id);


--
-- Name: hub_conversation_tags hub_conversation_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_conversation_tags
    ADD CONSTRAINT hub_conversation_tags_pkey PRIMARY KEY (conversation_id, tag_id);


--
-- Name: hub_conversations hub_conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_conversations
    ADD CONSTRAINT hub_conversations_pkey PRIMARY KEY (id);


--
-- Name: hub_internal_comments hub_internal_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_internal_comments
    ADD CONSTRAINT hub_internal_comments_pkey PRIMARY KEY (id);


--
-- Name: hub_message_attachments hub_message_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_message_attachments
    ADD CONSTRAINT hub_message_attachments_pkey PRIMARY KEY (id);


--
-- Name: hub_message_participants hub_message_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_message_participants
    ADD CONSTRAINT hub_message_participants_pkey PRIMARY KEY (id);


--
-- Name: hub_messages hub_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_messages
    ADD CONSTRAINT hub_messages_pkey PRIMARY KEY (id);


--
-- Name: hub_routing_rules hub_routing_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_routing_rules
    ADD CONSTRAINT hub_routing_rules_pkey PRIMARY KEY (id);


--
-- Name: hub_routing_rules hub_routing_rules_workspace_slug_match_type_match_value_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_routing_rules
    ADD CONSTRAINT hub_routing_rules_workspace_slug_match_type_match_value_key UNIQUE (workspace_slug, match_type, match_value);


--
-- Name: hub_tags hub_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_tags
    ADD CONSTRAINT hub_tags_pkey PRIMARY KEY (id);


--
-- Name: hub_tags hub_tags_workspace_slug_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_tags
    ADD CONSTRAINT hub_tags_workspace_slug_name_key UNIQUE (workspace_slug, name);


--
-- Name: idempotency_ledger idempotency_ledger_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.idempotency_ledger
    ADD CONSTRAINT idempotency_ledger_pkey PRIMARY KEY (id);


--
-- Name: idempotency_ledger idempotency_ledger_workspace_slug_entity_type_fingerprint_h_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.idempotency_ledger
    ADD CONSTRAINT idempotency_ledger_workspace_slug_entity_type_fingerprint_h_key UNIQUE (workspace_slug, entity_type, fingerprint_hash, scope_key);


--
-- Name: inbox_conversations inbox_conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inbox_conversations
    ADD CONSTRAINT inbox_conversations_pkey PRIMARY KEY (id);


--
-- Name: inbox_messages inbox_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inbox_messages
    ADD CONSTRAINT inbox_messages_pkey PRIMARY KEY (id);


--
-- Name: inbox_notifications inbox_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inbox_notifications
    ADD CONSTRAINT inbox_notifications_pkey PRIMARY KEY (id);


--
-- Name: inbox_notifications inbox_notifications_workspace_slug_source_brief_id_type_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inbox_notifications
    ADD CONSTRAINT inbox_notifications_workspace_slug_source_brief_id_type_key UNIQUE (workspace_slug, source_brief_id, type);


--
-- Name: integration_action_failures integration_action_failures_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.integration_action_failures
    ADD CONSTRAINT integration_action_failures_pkey PRIMARY KEY (id);


--
-- Name: integration_action_policies integration_action_policies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.integration_action_policies
    ADD CONSTRAINT integration_action_policies_pkey PRIMARY KEY (id);


--
-- Name: integration_action_policies integration_action_policies_provider_action_slug_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.integration_action_policies
    ADD CONSTRAINT integration_action_policies_provider_action_slug_key UNIQUE (provider, action_slug);


--
-- Name: integration_action_schemas integration_action_schemas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.integration_action_schemas
    ADD CONSTRAINT integration_action_schemas_pkey PRIMARY KEY (provider, action_slug);


--
-- Name: integration_whoami_registry integration_whoami_registry_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.integration_whoami_registry
    ADD CONSTRAINT integration_whoami_registry_pkey PRIMARY KEY (provider, toolkit_slug);


--
-- Name: issue_comments issue_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issue_comments
    ADD CONSTRAINT issue_comments_pkey PRIMARY KEY (id);


--
-- Name: issue_decompositions issue_decompositions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issue_decompositions
    ADD CONSTRAINT issue_decompositions_pkey PRIMARY KEY (id);


--
-- Name: issue_decompositions issue_decompositions_workspace_slug_goal_id_plan_fingerprin_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issue_decompositions
    ADD CONSTRAINT issue_decompositions_workspace_slug_goal_id_plan_fingerprin_key UNIQUE (workspace_slug, goal_id, plan_fingerprint);


--
-- Name: issue_review_attempts issue_review_attempts_attempt_token_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issue_review_attempts
    ADD CONSTRAINT issue_review_attempts_attempt_token_key UNIQUE (attempt_token);


--
-- Name: issue_review_attempts issue_review_attempts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issue_review_attempts
    ADD CONSTRAINT issue_review_attempts_pkey PRIMARY KEY (id);


--
-- Name: issue_storylines issue_storylines_issue_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issue_storylines
    ADD CONSTRAINT issue_storylines_issue_id_key UNIQUE (issue_id);


--
-- Name: issue_storylines issue_storylines_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issue_storylines
    ADD CONSTRAINT issue_storylines_pkey PRIMARY KEY (id);


--
-- Name: issues issues_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issues
    ADD CONSTRAINT issues_pkey PRIMARY KEY (id);


--
-- Name: kilo_tool_call_repair_dispatch_state kilo_tool_call_repair_dispatch_state_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.kilo_tool_call_repair_dispatch_state
    ADD CONSTRAINT kilo_tool_call_repair_dispatch_state_pkey PRIMARY KEY (webhook_url);


--
-- Name: legal_acceptances legal_acceptances_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.legal_acceptances
    ADD CONSTRAINT legal_acceptances_pkey PRIMARY KEY (id);


--
-- Name: local_servers local_servers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.local_servers
    ADD CONSTRAINT local_servers_pkey PRIMARY KEY (id);


--
-- Name: login_attempts login_attempts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.login_attempts
    ADD CONSTRAINT login_attempts_pkey PRIMARY KEY (id);


--
-- Name: memory_entries memory_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.memory_entries
    ADD CONSTRAINT memory_entries_pkey PRIMARY KEY (id);


--
-- Name: message_attachments message_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message_attachments
    ADD CONSTRAINT message_attachments_pkey PRIMARY KEY (id);


--
-- Name: message_delivery_attempts message_delivery_attempts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message_delivery_attempts
    ADD CONSTRAINT message_delivery_attempts_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: model_health model_health_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.model_health
    ADD CONSTRAINT model_health_pkey PRIMARY KEY (workspace_slug, provider, model_id);


--
-- Name: model_registry model_registry_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.model_registry
    ADD CONSTRAINT model_registry_pkey PRIMARY KEY (id);


--
-- Name: model_registry model_registry_user_id_provider_model_id_capability_tier_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.model_registry
    ADD CONSTRAINT model_registry_user_id_provider_model_id_capability_tier_key UNIQUE (user_id, provider, model_id, capability_tier);


--
-- Name: model_registry model_registry_user_id_workspace_slug_provider_model_id_cap_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.model_registry
    ADD CONSTRAINT model_registry_user_id_workspace_slug_provider_model_id_cap_key UNIQUE (user_id, workspace_slug, provider, model_id, capability_tier);


--
-- Name: needs_from_you_items needs_from_you_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.needs_from_you_items
    ADD CONSTRAINT needs_from_you_items_pkey PRIMARY KEY (id);


--
-- Name: oauth_accounts oauth_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_accounts
    ADD CONSTRAINT oauth_accounts_pkey PRIMARY KEY (id);


--
-- Name: oauth_accounts oauth_accounts_provider_provider_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_accounts
    ADD CONSTRAINT oauth_accounts_provider_provider_user_id_key UNIQUE (provider, provider_user_id);


--
-- Name: oauth_accounts oauth_accounts_provider_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_accounts
    ADD CONSTRAINT oauth_accounts_provider_user_id_key UNIQUE (provider, user_id);


--
-- Name: oauth_states oauth_states_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_states
    ADD CONSTRAINT oauth_states_pkey PRIMARY KEY (id);


--
-- Name: oauth_states oauth_states_state_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_states
    ADD CONSTRAINT oauth_states_state_key UNIQUE (state);


--
-- Name: participants participants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.participants
    ADD CONSTRAINT participants_pkey PRIMARY KEY (id);


--
-- Name: payment_handoff_events payment_handoff_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_handoff_events
    ADD CONSTRAINT payment_handoff_events_pkey PRIMARY KEY (id);


--
-- Name: principals principals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.principals
    ADD CONSTRAINT principals_pkey PRIMARY KEY (id);


--
-- Name: privacy_audit_events privacy_audit_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.privacy_audit_events
    ADD CONSTRAINT privacy_audit_events_pkey PRIMARY KEY (id);


--
-- Name: privacy_purge_runs privacy_purge_runs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.privacy_purge_runs
    ADD CONSTRAINT privacy_purge_runs_pkey PRIMARY KEY (id);


--
-- Name: privacy_request_appeals privacy_request_appeals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.privacy_request_appeals
    ADD CONSTRAINT privacy_request_appeals_pkey PRIMARY KEY (id);


--
-- Name: privacy_request_verifications privacy_request_verifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.privacy_request_verifications
    ADD CONSTRAINT privacy_request_verifications_pkey PRIMARY KEY (id);


--
-- Name: privacy_requests privacy_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.privacy_requests
    ADD CONSTRAINT privacy_requests_pkey PRIMARY KEY (id);


--
-- Name: proactive_tasks proactive_tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.proactive_tasks
    ADD CONSTRAINT proactive_tasks_pkey PRIMARY KEY (id);


--
-- Name: project_storylines project_storylines_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_storylines
    ADD CONSTRAINT project_storylines_pkey PRIMARY KEY (id);


--
-- Name: project_storylines project_storylines_project_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.project_storylines
    ADD CONSTRAINT project_storylines_project_id_key UNIQUE (project_id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: provider_exclusions provider_exclusions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.provider_exclusions
    ADD CONSTRAINT provider_exclusions_pkey PRIMARY KEY (id);


--
-- Name: provider_exclusions provider_exclusions_workspace_slug_provider_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.provider_exclusions
    ADD CONSTRAINT provider_exclusions_workspace_slug_provider_key UNIQUE (workspace_slug, provider);


--
-- Name: provider_model_pricing provider_model_pricing_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.provider_model_pricing
    ADD CONSTRAINT provider_model_pricing_pkey PRIMARY KEY (provider, model_id, effective_at);


--
-- Name: publish_drafts publish_drafts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.publish_drafts
    ADD CONSTRAINT publish_drafts_pkey PRIMARY KEY (id);


--
-- Name: publish_policies publish_policies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.publish_policies
    ADD CONSTRAINT publish_policies_pkey PRIMARY KEY (id);


--
-- Name: publish_policies publish_policies_workspace_slug_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.publish_policies
    ADD CONSTRAINT publish_policies_workspace_slug_user_id_key UNIQUE (workspace_slug, user_id);


--
-- Name: publish_quality_counters publish_quality_counters_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.publish_quality_counters
    ADD CONSTRAINT publish_quality_counters_pkey PRIMARY KEY (id);


--
-- Name: publish_quality_counters publish_quality_counters_workspace_slug_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.publish_quality_counters
    ADD CONSTRAINT publish_quality_counters_workspace_slug_user_id_key UNIQUE (workspace_slug, user_id);


--
-- Name: rate_limit_entries rate_limit_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rate_limit_entries
    ADD CONSTRAINT rate_limit_entries_pkey PRIMARY KEY (id);


--
-- Name: raw_integration_events raw_integration_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.raw_integration_events
    ADD CONSTRAINT raw_integration_events_pkey PRIMARY KEY (id);


--
-- Name: realtime_events realtime_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realtime_events
    ADD CONSTRAINT realtime_events_pkey PRIMARY KEY (id);


--
-- Name: referral_rewards referral_rewards_invitation_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.referral_rewards
    ADD CONSTRAINT referral_rewards_invitation_unique UNIQUE (invitation_id);


--
-- Name: referral_rewards referral_rewards_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.referral_rewards
    ADD CONSTRAINT referral_rewards_pkey PRIMARY KEY (id);


--
-- Name: root_skills root_skills_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.root_skills
    ADD CONSTRAINT root_skills_pkey PRIMARY KEY (id);


--
-- Name: root_skills root_skills_slug_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.root_skills
    ADD CONSTRAINT root_skills_slug_key UNIQUE (slug);


--
-- Name: routine_runs routine_runs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.routine_runs
    ADD CONSTRAINT routine_runs_pkey PRIMARY KEY (id);


--
-- Name: routine_triggers routine_triggers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.routine_triggers
    ADD CONSTRAINT routine_triggers_pkey PRIMARY KEY (id);


--
-- Name: routing_log routing_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.routing_log
    ADD CONSTRAINT routing_log_pkey PRIMARY KEY (id);


--
-- Name: sanctions_screening_events sanctions_screening_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sanctions_screening_events
    ADD CONSTRAINT sanctions_screening_events_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (id);


--
-- Name: seat_addon_invoice_items seat_addon_invoice_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.seat_addon_invoice_items
    ADD CONSTRAINT seat_addon_invoice_items_pkey PRIMARY KEY (id);


--
-- Name: server_access_grants server_access_grants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.server_access_grants
    ADD CONSTRAINT server_access_grants_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: skill_proposals skill_proposals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.skill_proposals
    ADD CONSTRAINT skill_proposals_pkey PRIMARY KEY (id);


--
-- Name: skills skills_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_pkey PRIMARY KEY (id);


--
-- Name: skills skills_workspace_slug_slug_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_workspace_slug_slug_key UNIQUE (workspace_slug, slug);


--
-- Name: stripe_webhook_events stripe_webhook_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stripe_webhook_events
    ADD CONSTRAINT stripe_webhook_events_pkey PRIMARY KEY (id);


--
-- Name: subscription_tiers subscription_tiers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subscription_tiers
    ADD CONSTRAINT subscription_tiers_pkey PRIMARY KEY (tier_id);


--
-- Name: sync_oplog sync_oplog_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sync_oplog
    ADD CONSTRAINT sync_oplog_pkey PRIMARY KEY (seq);


--
-- Name: system_flags system_flags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.system_flags
    ADD CONSTRAINT system_flags_pkey PRIMARY KEY (key);


--
-- Name: task_dedup_events task_dedup_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.task_dedup_events
    ADD CONSTRAINT task_dedup_events_pkey PRIMARY KEY (id);


--
-- Name: team_members team_members_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.team_members
    ADD CONSTRAINT team_members_pkey PRIMARY KEY (id);


--
-- Name: token_balance_transactions token_balance_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.token_balance_transactions
    ADD CONSTRAINT token_balance_transactions_pkey PRIMARY KEY (id);


--
-- Name: token_topup_prices token_topup_prices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.token_topup_prices
    ADD CONSTRAINT token_topup_prices_pkey PRIMARY KEY (amount_cents);


--
-- Name: tool_call_repair_investigations tool_call_repair_investigations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tool_call_repair_investigations
    ADD CONSTRAINT tool_call_repair_investigations_pkey PRIMARY KEY (id);


--
-- Name: tool_write_grants tool_write_grants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tool_write_grants
    ADD CONSTRAINT tool_write_grants_pkey PRIMARY KEY (id);


--
-- Name: tool_write_grants tool_write_grants_workspace_slug_app_slug_project_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tool_write_grants
    ADD CONSTRAINT tool_write_grants_workspace_slug_app_slug_project_id_key UNIQUE NULLS NOT DISTINCT (workspace_slug, app_slug, project_id);


--
-- Name: trial_events trial_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trial_events
    ADD CONSTRAINT trial_events_pkey PRIMARY KEY (id);


--
-- Name: user_api_keys user_api_keys_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_api_keys
    ADD CONSTRAINT user_api_keys_pkey PRIMARY KEY (id);


--
-- Name: user_api_keys user_api_keys_user_id_provider_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_api_keys
    ADD CONSTRAINT user_api_keys_user_id_provider_key UNIQUE (user_id, provider);


--
-- Name: user_passwords user_passwords_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_passwords
    ADD CONSTRAINT user_passwords_pkey PRIMARY KEY (id);


--
-- Name: user_passwords user_passwords_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_passwords
    ADD CONSTRAINT user_passwords_user_id_key UNIQUE (user_id);


--
-- Name: user_workspace_preferences user_workspace_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_workspace_preferences
    ADD CONSTRAINT user_workspace_preferences_pkey PRIMARY KEY (workspace_slug, user_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_neon_auth_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_neon_auth_id_key UNIQUE (neon_auth_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_stripe_customer_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_stripe_customer_id_key UNIQUE (stripe_customer_id);


--
-- Name: waitlist_entries waitlist_entries_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.waitlist_entries
    ADD CONSTRAINT waitlist_entries_email_key UNIQUE (email);


--
-- Name: waitlist_entries waitlist_entries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.waitlist_entries
    ADD CONSTRAINT waitlist_entries_pkey PRIMARY KEY (id);


--
-- Name: wake_outbox wake_outbox_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wake_outbox
    ADD CONSTRAINT wake_outbox_pkey PRIMARY KEY (id);


--
-- Name: web_search_cache web_search_cache_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.web_search_cache
    ADD CONSTRAINT web_search_cache_pkey PRIMARY KEY (id);


--
-- Name: workspace_concurrency_slots workspace_concurrency_slots_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workspace_concurrency_slots
    ADD CONSTRAINT workspace_concurrency_slots_pkey PRIMARY KEY (workspace_slug);


--
-- Name: workspace_connected_integrations workspace_connected_integrati_workspace_slug_toolkit_slug_p_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workspace_connected_integrations
    ADD CONSTRAINT workspace_connected_integrati_workspace_slug_toolkit_slug_p_key UNIQUE (workspace_slug, toolkit_slug, provider);


--
-- Name: workspace_connected_integrations workspace_connected_integrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workspace_connected_integrations
    ADD CONSTRAINT workspace_connected_integrations_pkey PRIMARY KEY (id);


--
-- Name: workspace_credentials workspace_credentials_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workspace_credentials
    ADD CONSTRAINT workspace_credentials_pkey PRIMARY KEY (id);


--
-- Name: workspace_credentials workspace_credentials_workspace_slug_service_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workspace_credentials
    ADD CONSTRAINT workspace_credentials_workspace_slug_service_key UNIQUE (workspace_slug, service);


--
-- Name: workspace_draft_push_preferences workspace_draft_push_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workspace_draft_push_preferences
    ADD CONSTRAINT workspace_draft_push_preferences_pkey PRIMARY KEY (id);


--
-- Name: workspace_draft_push_preferences workspace_draft_push_preferences_workspace_slug_app_slug_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workspace_draft_push_preferences
    ADD CONSTRAINT workspace_draft_push_preferences_workspace_slug_app_slug_key UNIQUE (workspace_slug, app_slug);


--
-- Name: workspace_execution_lease workspace_execution_lease_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workspace_execution_lease
    ADD CONSTRAINT workspace_execution_lease_pkey PRIMARY KEY (workspace_slug);


--
-- Name: workspace_execution_slot_reservations workspace_execution_slot_reservations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workspace_execution_slot_reservations
    ADD CONSTRAINT workspace_execution_slot_reservations_pkey PRIMARY KEY (id);


--
-- Name: workspace_execution_state workspace_execution_state_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workspace_execution_state
    ADD CONSTRAINT workspace_execution_state_pkey PRIMARY KEY (workspace_slug);


--
-- Name: workspace_integration_policies workspace_integration_policies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workspace_integration_policies
    ADD CONSTRAINT workspace_integration_policies_pkey PRIMARY KEY (workspace_slug, backend, app_slug);


--
-- Name: workspace_invites workspace_invites_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workspace_invites
    ADD CONSTRAINT workspace_invites_pkey PRIMARY KEY (id);


--
-- Name: workspace_members workspace_members_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workspace_members
    ADD CONSTRAINT workspace_members_pkey PRIMARY KEY (id);


--
-- Name: workspace_members workspace_members_workspace_slug_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workspace_members
    ADD CONSTRAINT workspace_members_workspace_slug_user_id_key UNIQUE (workspace_slug, user_id);


--
-- Name: workspace_storage_usage workspace_storage_usage_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workspace_storage_usage
    ADD CONSTRAINT workspace_storage_usage_pkey PRIMARY KEY (workspace_slug);


--
-- Name: workspace_subscriptions workspace_subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workspace_subscriptions
    ADD CONSTRAINT workspace_subscriptions_pkey PRIMARY KEY (workspace_slug);


--
-- Name: workspace_subscriptions workspace_subscriptions_stripe_subscription_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workspace_subscriptions
    ADD CONSTRAINT workspace_subscriptions_stripe_subscription_id_key UNIQUE (stripe_subscription_id);


--
-- Name: workspace_token_balance workspace_token_balance_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workspace_token_balance
    ADD CONSTRAINT workspace_token_balance_pkey PRIMARY KEY (workspace_slug);


--
-- Name: workspaces workspaces_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workspaces
    ADD CONSTRAINT workspaces_pkey PRIMARY KEY (id);


--
-- Name: workspaces workspaces_slug_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workspaces
    ADD CONSTRAINT workspaces_slug_key UNIQUE (slug);


--
-- Name: workspaces workspaces_stripe_subscription_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.workspaces
    ADD CONSTRAINT workspaces_stripe_subscription_id_key UNIQUE (stripe_subscription_id);


--
-- Name: account_userId_idx; Type: INDEX; Schema: neon_auth; Owner: -
--

CREATE INDEX "account_userId_idx" ON neon_auth.account USING btree ("userId");


--
-- Name: invitation_email_idx; Type: INDEX; Schema: neon_auth; Owner: -
--

CREATE INDEX invitation_email_idx ON neon_auth.invitation USING btree (email);


--
-- Name: invitation_organizationId_idx; Type: INDEX; Schema: neon_auth; Owner: -
--

CREATE INDEX "invitation_organizationId_idx" ON neon_auth.invitation USING btree ("organizationId");


--
-- Name: member_organizationId_idx; Type: INDEX; Schema: neon_auth; Owner: -
--

CREATE INDEX "member_organizationId_idx" ON neon_auth.member USING btree ("organizationId");


--
-- Name: member_userId_idx; Type: INDEX; Schema: neon_auth; Owner: -
--

CREATE INDEX "member_userId_idx" ON neon_auth.member USING btree ("userId");


--
-- Name: organization_slug_uidx; Type: INDEX; Schema: neon_auth; Owner: -
--

CREATE UNIQUE INDEX organization_slug_uidx ON neon_auth.organization USING btree (slug);


--
-- Name: session_userId_idx; Type: INDEX; Schema: neon_auth; Owner: -
--

CREATE INDEX "session_userId_idx" ON neon_auth.session USING btree ("userId");


--
-- Name: verification_identifier_idx; Type: INDEX; Schema: neon_auth; Owner: -
--

CREATE INDEX verification_identifier_idx ON neon_auth.verification USING btree (identifier);


--
-- Name: activity_log_user_created_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX activity_log_user_created_idx ON public.activity_log USING btree (user_id, created_at);


--
-- Name: activity_log_workspace_tool_day_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX activity_log_workspace_tool_day_idx ON public.activity_log USING btree (workspace_slug, created_at) WHERE (action = 'tool_executed'::public.activity_action);


--
-- Name: agent_model_config_agent_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX agent_model_config_agent_idx ON public.agent_model_config USING btree (agent_id);


--
-- Name: agent_runs_issue_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX agent_runs_issue_idx ON public.agent_runs USING btree (issue_id);


--
-- Name: agent_runs_user_agent_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX agent_runs_user_agent_idx ON public.agent_runs USING btree (user_id, agent_id, created_at);


--
-- Name: agent_runs_user_status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX agent_runs_user_status_idx ON public.agent_runs USING btree (user_id, status);


--
-- Name: agents_user_reports_to_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX agents_user_reports_to_idx ON public.agents USING btree (user_id, reports_to);


--
-- Name: agents_user_status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX agents_user_status_idx ON public.agents USING btree (user_id, status);


--
-- Name: approvals_user_status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX approvals_user_status_idx ON public.approvals USING btree (user_id, status);


--
-- Name: blocker_digests_open_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX blocker_digests_open_key ON public.blocker_digests USING btree (workspace_slug, group_key) WHERE (status = 'open'::text);


--
-- Name: connected_account_identity_ws_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX connected_account_identity_ws_idx ON public.connected_account_identity USING btree (workspace_slug);


--
-- Name: cost_events_user_agent_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX cost_events_user_agent_idx ON public.cost_events USING btree (user_id, agent_id, occurred_at);


--
-- Name: cost_events_user_occurred_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX cost_events_user_occurred_idx ON public.cost_events USING btree (user_id, occurred_at);


--
-- Name: cron_run_log_job_started_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX cron_run_log_job_started_idx ON public.cron_run_log USING btree (job_name, started_at DESC);


--
-- Name: cron_run_log_problems_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX cron_run_log_problems_idx ON public.cron_run_log USING btree (started_at DESC) WHERE (ok = false);


--
-- Name: execution_blockers_open_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX execution_blockers_open_unique ON public.execution_blockers USING btree (workspace_slug, blocker_key) WHERE (status = 'open'::text);


--
-- Name: execution_blockers_workspace_status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX execution_blockers_workspace_status_idx ON public.execution_blockers USING btree (workspace_slug, status, blocks_new_work);


--
-- Name: goals_user_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX goals_user_idx ON public.goals USING btree (user_id);


--
-- Name: hub_channels_account_uniq; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX hub_channels_account_uniq ON public.hub_channels USING btree (workspace_slug, integration_provider, connected_account_id) WHERE (connected_account_id IS NOT NULL);


--
-- Name: hub_channels_blocker_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX hub_channels_blocker_id_idx ON public.hub_channels USING btree (blocker_id);


--
-- Name: idx_accessibility_audit_items_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_accessibility_audit_items_status ON public.accessibility_audit_items USING btree (workspace_slug, status, severity);


--
-- Name: idx_activity_log_ws; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_activity_log_ws ON public.activity_log USING btree (workspace_slug);


--
-- Name: idx_agent_backlog_pick; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_agent_backlog_pick ON public.agent_backlog USING btree (agent_id, priority, enqueued_at);


--
-- Name: idx_agent_execution_locks_active_issue_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_agent_execution_locks_active_issue_unique ON public.agent_execution_locks USING btree (workspace_slug, agent_id, issue_id) WHERE (released_at IS NULL);


--
-- Name: idx_agent_execution_locks_active_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_agent_execution_locks_active_unique ON public.agent_execution_locks USING btree (workspace_slug, agent_id, issue_id, lock_kind) WHERE (released_at IS NULL);


--
-- Name: idx_agent_execution_locks_expires; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_agent_execution_locks_expires ON public.agent_execution_locks USING btree (expires_at) WHERE (released_at IS NULL);


--
-- Name: idx_agent_execution_locks_run; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_agent_execution_locks_run ON public.agent_execution_locks USING btree (run_id) WHERE (run_id IS NOT NULL);


--
-- Name: idx_agent_keys_agent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_agent_keys_agent ON public.agent_keys USING btree (workspace_slug, agent_id);


--
-- Name: idx_agent_keys_hash; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_agent_keys_hash ON public.agent_keys USING btree (key_hash) WHERE (revoked_at IS NULL);


--
-- Name: idx_agent_keys_workspace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_agent_keys_workspace ON public.agent_keys USING btree (workspace_slug);


--
-- Name: idx_agent_model_config_ws; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_agent_model_config_ws ON public.agent_model_config USING btree (workspace_slug);


--
-- Name: idx_agent_runs_ws; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_agent_runs_ws ON public.agent_runs USING btree (workspace_slug);


--
-- Name: idx_agent_runs_ws_status_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_agent_runs_ws_status_created ON public.agent_runs USING btree (workspace_slug, status, created_at DESC);


--
-- Name: idx_agent_skills_agent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_agent_skills_agent ON public.agent_skills USING btree (agent_id);


--
-- Name: idx_agent_skills_skill; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_agent_skills_skill ON public.agent_skills USING btree (skill_id);


--
-- Name: idx_agent_skills_workspace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_agent_skills_workspace ON public.agent_skills USING btree (workspace_slug);


--
-- Name: idx_agent_tokens_agent_workspace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_agent_tokens_agent_workspace ON public.agent_tokens USING btree (agent_id, workspace_slug);


--
-- Name: idx_agent_tokens_token_hash; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_agent_tokens_token_hash ON public.agent_tokens USING btree (token_hash);


--
-- Name: idx_agents_ws; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_agents_ws ON public.agents USING btree (workspace_slug);


--
-- Name: idx_approvals_deliverable_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_approvals_deliverable_id ON public.approvals USING btree (deliverable_id) WHERE (deliverable_id IS NOT NULL);


--
-- Name: idx_approvals_ws; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_approvals_ws ON public.approvals USING btree (workspace_slug);


--
-- Name: idx_beta_access_log_action; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_beta_access_log_action ON public.beta_access_log USING btree (action, created_at DESC);


--
-- Name: idx_beta_access_log_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_beta_access_log_email ON public.beta_access_log USING btree (lower(email));


--
-- Name: idx_beta_invitations_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_beta_invitations_email ON public.beta_invitations USING btree (lower(email));


--
-- Name: idx_beta_invitations_inviter; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_beta_invitations_inviter ON public.beta_invitations USING btree (invited_by_user_id, created_at DESC);


--
-- Name: idx_beta_invitations_workspace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_beta_invitations_workspace ON public.beta_invitations USING btree (workspace_slug);


--
-- Name: idx_blog_posts_published_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_blog_posts_published_at ON public.blog_posts USING btree (published_at DESC);


--
-- Name: idx_blog_posts_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_blog_posts_slug ON public.blog_posts USING btree (slug);


--
-- Name: idx_blog_posts_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_blog_posts_status ON public.blog_posts USING btree (status);


--
-- Name: idx_business_profiles_ws; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_business_profiles_ws ON public.business_profiles USING btree (workspace_slug);


--
-- Name: idx_channels_account; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_channels_account ON public.channels USING btree (connected_account_id, type);


--
-- Name: idx_channels_external; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_channels_external ON public.channels USING btree (connected_account_id, external_channel_id) WHERE (external_channel_id IS NOT NULL);


--
-- Name: idx_channels_ws; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_channels_ws ON public.channels USING btree (workspace_slug);


--
-- Name: idx_chat_threads_user_workspace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_chat_threads_user_workspace ON public.chat_threads USING btree (user_id, workspace_slug, updated_at DESC);


--
-- Name: idx_communication_compliance_events_workspace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_communication_compliance_events_workspace ON public.communication_compliance_events USING btree (workspace_slug, created_at DESC);


--
-- Name: idx_communication_consents_recipient; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_communication_consents_recipient ON public.communication_consents USING btree (workspace_slug, lower(recipient_address), recipient_type, revoked_at);


--
-- Name: idx_communication_suppressions_recipient; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_communication_suppressions_recipient ON public.communication_suppressions USING btree (workspace_slug, lower(recipient_address), recipient_type, expires_at);


--
-- Name: idx_composio_recommendations_outcome; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_composio_recommendations_outcome ON public.composio_recommendations USING btree (workspace_slug, outcome, emitted_at);


--
-- Name: idx_composio_recommendations_toolkit; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_composio_recommendations_toolkit ON public.composio_recommendations USING btree (workspace_slug, toolkit_slug);


--
-- Name: idx_composio_recommendations_workspace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_composio_recommendations_workspace ON public.composio_recommendations USING btree (workspace_slug);


--
-- Name: idx_config_versions_entity; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_config_versions_entity ON public.config_versions USING btree (entity_type, entity_id);


--
-- Name: idx_config_versions_workspace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_config_versions_workspace ON public.config_versions USING btree (workspace_slug);


--
-- Name: idx_connected_accounts_provider; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_connected_accounts_provider ON public.connected_accounts USING btree (workspace_slug, provider);


--
-- Name: idx_connected_accounts_ws; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_connected_accounts_ws ON public.connected_accounts USING btree (workspace_slug);


--
-- Name: idx_copy_voice_approval_dedup; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_copy_voice_approval_dedup ON public.approvals USING btree (workspace_slug, ((payload ->> 'projectId'::text))) WHERE ((type = 'copy_voice_select'::public.approval_type) AND (status = 'pending'::public.approval_status));


--
-- Name: idx_copy_voices_workspace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_copy_voices_workspace ON public.copy_voices USING btree (workspace_slug);


--
-- Name: idx_cost_events_agent_month; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_cost_events_agent_month ON public.cost_events USING btree (agent_id, occurred_at);


--
-- Name: idx_cost_events_ws; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_cost_events_ws ON public.cost_events USING btree (workspace_slug);


--
-- Name: idx_deliverable_sections_deliverable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_deliverable_sections_deliverable ON public.deliverable_sections USING btree (deliverable_id, "position");


--
-- Name: idx_deliverable_tasks_deliverable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_deliverable_tasks_deliverable ON public.deliverable_proposed_tasks USING btree (deliverable_id, "position");


--
-- Name: idx_deliverables_category; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_deliverables_category ON public.deliverables USING btree (user_id, category);


--
-- Name: idx_deliverables_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_deliverables_created_at ON public.deliverables USING btree (user_id, created_at DESC);


--
-- Name: idx_deliverables_goal; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_deliverables_goal ON public.deliverables USING btree (goal_id) WHERE (goal_id IS NOT NULL);


--
-- Name: idx_deliverables_group_latest; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_deliverables_group_latest ON public.deliverables USING btree (deliverable_group_id, is_latest);


--
-- Name: idx_deliverables_is_latest; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_deliverables_is_latest ON public.deliverables USING btree (is_latest) WHERE (is_latest = true);


--
-- Name: idx_deliverables_originating_human; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_deliverables_originating_human ON public.deliverables USING btree (originating_human_id);


--
-- Name: idx_deliverables_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_deliverables_user_id ON public.deliverables USING btree (user_id);


--
-- Name: idx_deliverables_ws; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_deliverables_ws ON public.deliverables USING btree (workspace_slug);


--
-- Name: idx_deliverables_ws_goal_updated; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_deliverables_ws_goal_updated ON public.deliverables USING btree (workspace_slug, goal_id, updated_at DESC) WHERE (goal_id IS NOT NULL);


--
-- Name: idx_delivery_attempts_msg; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_delivery_attempts_msg ON public.message_delivery_attempts USING btree (message_id);


--
-- Name: idx_delivery_attempts_ws; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_delivery_attempts_ws ON public.message_delivery_attempts USING btree (workspace_slug);


--
-- Name: idx_delivery_problem_reports_issue; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_delivery_problem_reports_issue ON public.delivery_problem_reports USING btree (issue_id);


--
-- Name: idx_delivery_problem_reports_workspace_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_delivery_problem_reports_workspace_status ON public.delivery_problem_reports USING btree (workspace_slug, status);


--
-- Name: idx_feedback_reports_status_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_feedback_reports_status_created ON public.feedback_reports USING btree (status, created_at DESC);


--
-- Name: idx_ftl_period; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ftl_period ON public.free_tier_ledger USING btree (period_key);


--
-- Name: idx_global_model_catalog_canonical; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_global_model_catalog_canonical ON public.global_model_catalog USING btree (canonical_id);


--
-- Name: idx_global_model_catalog_provider; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_global_model_catalog_provider ON public.global_model_catalog USING btree (provider_id);


--
-- Name: idx_global_model_catalog_tier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_global_model_catalog_tier ON public.global_model_catalog USING btree (capability_tier);


--
-- Name: idx_goal_archetypes_category; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_goal_archetypes_category ON public.goal_archetypes USING btree (category);


--
-- Name: idx_goal_measurements_goal_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_goal_measurements_goal_time ON public.goal_measurements USING btree (goal_id, recorded_at DESC);


--
-- Name: idx_goal_measurements_workspace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_goal_measurements_workspace ON public.goal_measurements USING btree (workspace_slug, recorded_at DESC);


--
-- Name: idx_goals_conversation_proposed; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_goals_conversation_proposed ON public.goals USING btree (workspace_slug, conversation_id, lower(title)) WHERE ((conversation_id IS NOT NULL) AND (status = 'proposed'::public.goal_status));


--
-- Name: idx_goals_owner_agent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_goals_owner_agent ON public.goals USING btree (owner_agent_id) WHERE (owner_agent_id IS NOT NULL);


--
-- Name: idx_goals_ws; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_goals_ws ON public.goals USING btree (workspace_slug);


--
-- Name: idx_high_risk_gate_events_workspace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_high_risk_gate_events_workspace ON public.high_risk_gate_events USING btree (workspace_slug, created_at DESC);


--
-- Name: idx_hub_channels_composio_trigger_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_hub_channels_composio_trigger_id ON public.hub_channels USING btree (composio_trigger_id) WHERE (composio_trigger_id IS NOT NULL);


--
-- Name: idx_hub_channels_workspace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_hub_channels_workspace ON public.hub_channels USING btree (workspace_slug);


--
-- Name: idx_hub_comments_convo; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_hub_comments_convo ON public.hub_internal_comments USING btree (conversation_id);


--
-- Name: idx_hub_conversations_audience; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_hub_conversations_audience ON public.hub_conversations USING btree (workspace_slug, audience);


--
-- Name: idx_hub_convos_channel; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_hub_convos_channel ON public.hub_conversations USING btree (channel_id);


--
-- Name: idx_hub_convos_last_msg; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_hub_convos_last_msg ON public.hub_conversations USING btree (workspace_slug, last_message_at DESC);


--
-- Name: idx_hub_convos_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_hub_convos_status ON public.hub_conversations USING btree (workspace_slug, status);


--
-- Name: idx_hub_convos_workspace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_hub_convos_workspace ON public.hub_conversations USING btree (workspace_slug);


--
-- Name: idx_hub_msg_attach_message; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_hub_msg_attach_message ON public.hub_message_attachments USING btree (message_id);


--
-- Name: idx_hub_msg_parts_message; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_hub_msg_parts_message ON public.hub_message_participants USING btree (message_id);


--
-- Name: idx_hub_msgs_conversation; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_hub_msgs_conversation ON public.hub_messages USING btree (conversation_id);


--
-- Name: idx_hub_msgs_external; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_hub_msgs_external ON public.hub_messages USING btree (external_message_id);


--
-- Name: idx_hub_msgs_workspace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_hub_msgs_workspace ON public.hub_messages USING btree (workspace_slug);


--
-- Name: idx_hub_routing_rules_workspace_match; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_hub_routing_rules_workspace_match ON public.hub_routing_rules USING btree (workspace_slug, match_type);


--
-- Name: idx_iaf_last_seen; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_iaf_last_seen ON public.integration_action_failures USING btree (last_seen_at DESC);


--
-- Name: idx_iaf_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_iaf_status ON public.integration_action_failures USING btree (status);


--
-- Name: idx_iap_action_slug_permission; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_iap_action_slug_permission ON public.integration_action_policies USING btree (action_slug, permission_type);


--
-- Name: idx_iap_gate_class; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_iap_gate_class ON public.integration_action_policies USING btree (gate_class);


--
-- Name: idx_iap_provider; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_iap_provider ON public.integration_action_policies USING btree (provider);


--
-- Name: idx_idempotency_ledger_workspace_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_idempotency_ledger_workspace_type ON public.idempotency_ledger USING btree (workspace_slug, entity_type, created_at DESC);


--
-- Name: idx_inbox_conv_channel; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_inbox_conv_channel ON public.inbox_conversations USING btree (owner_user_id, channel_type);


--
-- Name: idx_inbox_conv_goal_dept; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_inbox_conv_goal_dept ON public.inbox_conversations USING btree (workspace_slug, owner_user_id, linked_goal_id, participant_name) WHERE (linked_goal_id IS NOT NULL);


--
-- Name: idx_inbox_conv_last_msg; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_inbox_conv_last_msg ON public.inbox_conversations USING btree (owner_user_id, last_message_at DESC);


--
-- Name: idx_inbox_conv_owner; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_inbox_conv_owner ON public.inbox_conversations USING btree (workspace_slug, owner_user_id);


--
-- Name: idx_inbox_conv_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_inbox_conv_status ON public.inbox_conversations USING btree (workspace_slug, owner_user_id, status);


--
-- Name: idx_inbox_messages_pending_action_dedupe; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_inbox_messages_pending_action_dedupe ON public.inbox_messages USING btree (workspace_slug, action_type, action_dedupe_key) WHERE ((action_dedupe_key IS NOT NULL) AND (COALESCE(action_status, 'pending'::text) = 'pending'::text));


--
-- Name: idx_inbox_msg_action; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_inbox_msg_action ON public.inbox_messages USING btree (conversation_id, action_type) WHERE (action_type IS NOT NULL);


--
-- Name: idx_inbox_msg_conv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_inbox_msg_conv ON public.inbox_messages USING btree (conversation_id, created_at);


--
-- Name: idx_inbox_msg_pending_dedupe; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_inbox_msg_pending_dedupe ON public.inbox_messages USING btree (workspace_slug, action_type, action_dedupe_key) WHERE ((action_dedupe_key IS NOT NULL) AND (COALESCE(action_status, 'pending'::text) = 'pending'::text));


--
-- Name: idx_inbox_notifications_user_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_inbox_notifications_user_status ON public.inbox_notifications USING btree (user_id, workspace_slug, status, created_at DESC);


--
-- Name: idx_integration_action_schemas_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_integration_action_schemas_slug ON public.integration_action_schemas USING btree (action_slug);


--
-- Name: idx_invites_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_invites_email ON public.workspace_invites USING btree (email);


--
-- Name: idx_invites_token; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_invites_token ON public.workspace_invites USING btree (token_hash);


--
-- Name: idx_invites_workspace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_invites_workspace ON public.workspace_invites USING btree (workspace_slug);


--
-- Name: idx_issue_comments_issue; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_issue_comments_issue ON public.issue_comments USING btree (issue_id, created_at);


--
-- Name: idx_issue_comments_parent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_issue_comments_parent ON public.issue_comments USING btree (parent_comment_id);


--
-- Name: idx_issue_comments_workspace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_issue_comments_workspace ON public.issue_comments USING btree (workspace_slug);


--
-- Name: idx_issue_decompositions_goal; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_issue_decompositions_goal ON public.issue_decompositions USING btree (workspace_slug, goal_id);


--
-- Name: idx_issue_review_attempts_issue_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_issue_review_attempts_issue_created ON public.issue_review_attempts USING btree (workspace_slug, issue_id, created_at DESC);


--
-- Name: idx_issue_review_attempts_one_running; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_issue_review_attempts_one_running ON public.issue_review_attempts USING btree (workspace_slug, issue_id) WHERE (status = 'running'::text);


--
-- Name: idx_issue_review_attempts_reviewer_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_issue_review_attempts_reviewer_status ON public.issue_review_attempts USING btree (workspace_slug, reviewer_agent_id, status, started_at DESC);


--
-- Name: idx_issue_review_attempts_status_updated; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_issue_review_attempts_status_updated ON public.issue_review_attempts USING btree (workspace_slug, status, updated_at DESC);


--
-- Name: idx_issue_storylines_workspace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_issue_storylines_workspace ON public.issue_storylines USING btree (workspace_slug);


--
-- Name: idx_issues_claimed; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_issues_claimed ON public.issues USING btree (claimed_by_agent_id, claimed_at) WHERE (claimed_by_agent_id IS NOT NULL);


--
-- Name: idx_issues_originating_human; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_issues_originating_human ON public.issues USING btree (originating_human_id);


--
-- Name: idx_issues_ws; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_issues_ws ON public.issues USING btree (workspace_slug);


--
-- Name: idx_issues_ws_goal_status_updated; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_issues_ws_goal_status_updated ON public.issues USING btree (workspace_slug, goal_id, status, updated_at DESC) WHERE (goal_id IS NOT NULL);


--
-- Name: idx_lazy_channels_ws; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_lazy_channels_ws ON public.channels USING btree (workspace_slug);


--
-- Name: idx_lazy_connected_accounts_provider; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_lazy_connected_accounts_provider ON public.connected_accounts USING btree (workspace_slug, provider);


--
-- Name: idx_lazy_connected_accounts_ws; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_lazy_connected_accounts_ws ON public.connected_accounts USING btree (workspace_slug);


--
-- Name: idx_lazy_participants_channel_ext_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_lazy_participants_channel_ext_id ON public.participants USING btree (channel_id, external_participant_id);


--
-- Name: idx_lazy_raw_events_pending; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_lazy_raw_events_pending ON public.raw_integration_events USING btree (processing_status, created_at) WHERE (processing_status = 'pending'::text);


--
-- Name: idx_legal_acceptances_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_legal_acceptances_user ON public.legal_acceptances USING btree (user_id);


--
-- Name: idx_legal_acceptances_user_doc; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_legal_acceptances_user_doc ON public.legal_acceptances USING btree (user_id, document_slug, document_version);


--
-- Name: idx_memory_entries_user_category; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_memory_entries_user_category ON public.memory_entries USING btree (user_id, category);


--
-- Name: idx_memory_entries_user_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_memory_entries_user_status ON public.memory_entries USING btree (user_id, status);


--
-- Name: idx_memory_entries_ws; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_memory_entries_ws ON public.memory_entries USING btree (workspace_slug);


--
-- Name: idx_messages_cos_unprocessed; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_messages_cos_unprocessed ON public.messages USING btree (workspace_slug, kind, cos_processed_at) WHERE ((kind = 'issue_comment'::public.message_kind) AND (cos_processed_at IS NULL));


--
-- Name: idx_messages_thread_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_messages_thread_id ON public.messages USING btree (thread_id);


--
-- Name: idx_messages_user_id_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_messages_user_id_created ON public.messages USING btree (user_id, created_at);


--
-- Name: idx_messages_user_kind; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_messages_user_kind ON public.messages USING btree (user_id, kind, created_at DESC);


--
-- Name: idx_messages_user_kind_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_messages_user_kind_created ON public.messages USING btree (user_id, kind, created_at DESC);


--
-- Name: idx_messages_user_thread; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_messages_user_thread ON public.messages USING btree (user_id, workspace_slug, thread_id, created_at);


--
-- Name: idx_messages_user_visibility; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_messages_user_visibility ON public.messages USING btree (user_id, visibility);


--
-- Name: idx_messages_workspace_issue_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_messages_workspace_issue_created ON public.messages USING btree (workspace_slug, issue_id, created_at DESC) WHERE (issue_id IS NOT NULL);


--
-- Name: idx_messages_ws; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_messages_ws ON public.messages USING btree (workspace_slug);


--
-- Name: idx_messages_ws_user_thread_created_desc; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_messages_ws_user_thread_created_desc ON public.messages USING btree (workspace_slug, user_id, thread_id, created_at DESC);


--
-- Name: idx_model_health_disabled; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_model_health_disabled ON public.model_health USING btree (disabled_until_at) WHERE (disabled_until_at IS NOT NULL);


--
-- Name: idx_model_health_tc_disabled; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_model_health_tc_disabled ON public.model_health USING btree (tool_calling_disabled_until_at) WHERE (tool_calling_disabled_until_at IS NOT NULL);


--
-- Name: idx_model_health_workspace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_model_health_workspace ON public.model_health USING btree (workspace_slug);


--
-- Name: idx_model_registry_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_model_registry_user ON public.model_registry USING btree (user_id);


--
-- Name: idx_model_registry_user_tier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_model_registry_user_tier ON public.model_registry USING btree (user_id, capability_tier);


--
-- Name: idx_model_registry_ws; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_model_registry_ws ON public.model_registry USING btree (workspace_slug);


--
-- Name: idx_nfy_dedup; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_nfy_dedup ON public.needs_from_you_items USING btree (workspace_slug, item_type, outcome);


--
-- Name: idx_nfy_human; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_nfy_human ON public.needs_from_you_items USING btree (originating_human_id, outcome);


--
-- Name: idx_nfy_message; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_nfy_message ON public.needs_from_you_items USING btree (message_id);


--
-- Name: idx_nfy_pending_dedupe_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_nfy_pending_dedupe_key ON public.needs_from_you_items USING btree (workspace_slug, item_type, dedupe_key) WHERE ((dedupe_key IS NOT NULL) AND (outcome = 'pending'::text));


--
-- Name: idx_nfy_workspace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_nfy_workspace ON public.needs_from_you_items USING btree (workspace_slug);


--
-- Name: idx_oauth_accounts_provider; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_oauth_accounts_provider ON public.oauth_accounts USING btree (provider);


--
-- Name: idx_oauth_accounts_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_oauth_accounts_user_id ON public.oauth_accounts USING btree (user_id);


--
-- Name: idx_oauth_states_expires_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_oauth_states_expires_at ON public.oauth_states USING btree (expires_at);


--
-- Name: idx_oauth_states_state; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_oauth_states_state ON public.oauth_states USING btree (state);


--
-- Name: idx_participants_channel; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_participants_channel ON public.participants USING btree (channel_id);


--
-- Name: idx_participants_channel_ext_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_participants_channel_ext_id ON public.participants USING btree (channel_id, external_participant_id);


--
-- Name: idx_participants_ws; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_participants_ws ON public.participants USING btree (workspace_slug);


--
-- Name: idx_payment_handoff_events_workspace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_payment_handoff_events_workspace ON public.payment_handoff_events USING btree (workspace_slug, created_at DESC);


--
-- Name: idx_principals_agent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_principals_agent ON public.principals USING btree (agent_id) WHERE (agent_id IS NOT NULL);


--
-- Name: idx_principals_unique_agent; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_principals_unique_agent ON public.principals USING btree (workspace_slug, agent_id) WHERE (agent_id IS NOT NULL);


--
-- Name: idx_principals_unique_user; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_principals_unique_user ON public.principals USING btree (workspace_slug, user_id) WHERE (user_id IS NOT NULL);


--
-- Name: idx_principals_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_principals_user ON public.principals USING btree (user_id) WHERE (user_id IS NOT NULL);


--
-- Name: idx_principals_workspace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_principals_workspace ON public.principals USING btree (workspace_slug);


--
-- Name: idx_privacy_audit_events_workspace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_privacy_audit_events_workspace ON public.privacy_audit_events USING btree (workspace_slug, created_at DESC);


--
-- Name: idx_privacy_request_appeals_request; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_privacy_request_appeals_request ON public.privacy_request_appeals USING btree (workspace_slug, privacy_request_id, created_at DESC);


--
-- Name: idx_privacy_request_verifications_request; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_privacy_request_verifications_request ON public.privacy_request_verifications USING btree (workspace_slug, privacy_request_id, created_at DESC);


--
-- Name: idx_privacy_requests_workspace_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_privacy_requests_workspace_status ON public.privacy_requests USING btree (workspace_slug, status, due_at);


--
-- Name: idx_proactive_tasks_enabled; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_proactive_tasks_enabled ON public.proactive_tasks USING btree (enabled, frequency);


--
-- Name: idx_proactive_tasks_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_proactive_tasks_user_id ON public.proactive_tasks USING btree (user_id);


--
-- Name: idx_proactive_tasks_ws; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_proactive_tasks_ws ON public.proactive_tasks USING btree (workspace_slug);


--
-- Name: idx_project_storylines_workspace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_project_storylines_workspace ON public.project_storylines USING btree (workspace_slug);


--
-- Name: idx_projects_originating_human; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_projects_originating_human ON public.projects USING btree (originating_human_id);


--
-- Name: idx_projects_ws; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_projects_ws ON public.projects USING btree (workspace_slug);


--
-- Name: idx_provider_exclusions_workspace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_provider_exclusions_workspace ON public.provider_exclusions USING btree (workspace_slug, provider);


--
-- Name: idx_publish_drafts_issue; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_publish_drafts_issue ON public.publish_drafts USING btree (workspace_slug, issue_id, created_at DESC);


--
-- Name: idx_publish_drafts_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_publish_drafts_status ON public.publish_drafts USING btree (workspace_slug, user_id, status, updated_at DESC);


--
-- Name: idx_publish_drafts_workspace_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_publish_drafts_workspace_user ON public.publish_drafts USING btree (workspace_slug, user_id, created_at DESC);


--
-- Name: idx_rate_limit_scope_key_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_rate_limit_scope_key_at ON public.rate_limit_entries USING btree (scope, key, attempted_at);


--
-- Name: idx_raw_events_dedupe; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_raw_events_dedupe ON public.raw_integration_events USING btree (provider, external_event_id) WHERE (external_event_id IS NOT NULL);


--
-- Name: idx_raw_events_provider; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_raw_events_provider ON public.raw_integration_events USING btree (workspace_slug, provider);


--
-- Name: idx_raw_events_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_raw_events_status ON public.raw_integration_events USING btree (processing_status, created_at) WHERE (processing_status = 'pending'::text);


--
-- Name: idx_raw_events_ws; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_raw_events_ws ON public.raw_integration_events USING btree (workspace_slug);


--
-- Name: idx_realtime_events_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realtime_events_created_at ON public.realtime_events USING btree (created_at);


--
-- Name: idx_realtime_events_workspace_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realtime_events_workspace_id ON public.realtime_events USING btree (workspace_slug, id);


--
-- Name: idx_realtime_events_ws_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realtime_events_ws_type_id ON public.realtime_events USING btree (workspace_slug, event_type, id);


--
-- Name: idx_routine_runs_workspace_idempotency; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_routine_runs_workspace_idempotency ON public.routine_runs USING btree (workspace_slug, idempotency_key) WHERE (idempotency_key IS NOT NULL);


--
-- Name: idx_routine_runs_ws; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_routine_runs_ws ON public.routine_runs USING btree (workspace_slug);


--
-- Name: idx_routine_triggers_webhook_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_routine_triggers_webhook_token ON public.routine_triggers USING btree (webhook_url_token) WHERE (webhook_url_token IS NOT NULL);


--
-- Name: idx_routine_triggers_webhook_url_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_routine_triggers_webhook_url_token ON public.routine_triggers USING btree (webhook_url_token) WHERE (webhook_url_token IS NOT NULL);


--
-- Name: idx_routine_triggers_ws; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_routine_triggers_ws ON public.routine_triggers USING btree (workspace_slug);


--
-- Name: idx_routing_log_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_routing_log_created ON public.routing_log USING btree (created_at DESC);


--
-- Name: idx_routing_log_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_routing_log_user ON public.routing_log USING btree (user_id);


--
-- Name: idx_routing_log_ws; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_routing_log_ws ON public.routing_log USING btree (workspace_slug);


--
-- Name: idx_sanctions_screening_events_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_sanctions_screening_events_user ON public.sanctions_screening_events USING btree (user_id, screened_at DESC);


--
-- Name: idx_sanctions_screening_events_workspace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_sanctions_screening_events_workspace ON public.sanctions_screening_events USING btree (workspace_slug, screened_at DESC);


--
-- Name: idx_sessions_expires_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_sessions_expires_at ON public.sessions USING btree (expires_at);


--
-- Name: idx_sessions_last_accessed; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_sessions_last_accessed ON public.sessions USING btree (last_accessed);


--
-- Name: idx_sessions_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_sessions_user_id ON public.sessions USING btree (user_id);


--
-- Name: idx_skills_workspace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_skills_workspace ON public.skills USING btree (workspace_slug);


--
-- Name: idx_stripe_webhook_events_processed; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_stripe_webhook_events_processed ON public.stripe_webhook_events USING btree (processed_at);


--
-- Name: idx_team_members_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_team_members_user_id ON public.team_members USING btree (user_id);


--
-- Name: idx_team_members_ws; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_team_members_ws ON public.team_members USING btree (workspace_slug);


--
-- Name: idx_token_balance_transactions_workspace_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_token_balance_transactions_workspace_created ON public.token_balance_transactions USING btree (workspace_slug, created_at DESC);


--
-- Name: idx_tool_call_repair_claim_expiry; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tool_call_repair_claim_expiry ON public.tool_call_repair_investigations USING btree (claim_expires_at) WHERE ((status = 'in_flight'::text) AND (kilo_trigger_mode = 'scheduled'::text));


--
-- Name: idx_tool_call_repair_claimable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tool_call_repair_claimable ON public.tool_call_repair_investigations USING btree (status, next_webhook_attempt_at, failure_count DESC, created_at) WHERE (status = 'queued'::text);


--
-- Name: idx_tool_call_repair_investigations_active_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_tool_call_repair_investigations_active_key ON public.tool_call_repair_investigations USING btree (provider, model_id, error_kind, error_signature) WHERE (status = ANY (ARRAY['queued'::text, 'in_flight'::text, 'awaiting_review'::text]));


--
-- Name: idx_tool_call_repair_investigations_provider_model; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tool_call_repair_investigations_provider_model ON public.tool_call_repair_investigations USING btree (provider, model_id, updated_at DESC);


--
-- Name: idx_tool_call_repair_investigations_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tool_call_repair_investigations_status ON public.tool_call_repair_investigations USING btree (status, next_webhook_attempt_at, updated_at DESC);


--
-- Name: idx_tool_write_grants_lookup; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tool_write_grants_lookup ON public.tool_write_grants USING btree (workspace_slug, app_slug) WHERE (revoked_at IS NULL);


--
-- Name: idx_tool_write_grants_workspace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_tool_write_grants_workspace ON public.tool_write_grants USING btree (workspace_slug) WHERE (revoked_at IS NULL);


--
-- Name: idx_trial_events_once_per_workspace; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_trial_events_once_per_workspace ON public.trial_events USING btree (workspace_slug, event) WHERE (event = ANY (ARRAY['reminder_sent_day_11'::text, 'reminder_sent_day_13'::text, 'trial_ended_downgrade'::text, 'trial_ended_upgrade'::text]));


--
-- Name: idx_user_api_keys_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_api_keys_user_id ON public.user_api_keys USING btree (user_id);


--
-- Name: idx_user_api_keys_ws; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_api_keys_ws ON public.user_api_keys USING btree (workspace_slug);


--
-- Name: idx_user_workspace_preferences_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_workspace_preferences_user ON public.user_workspace_preferences USING btree (user_id);


--
-- Name: idx_users_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_users_email ON public.users USING btree (email);


--
-- Name: idx_users_stripe_customer; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_users_stripe_customer ON public.users USING btree (stripe_customer_id) WHERE (stripe_customer_id IS NOT NULL);


--
-- Name: idx_waitlist_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_waitlist_email ON public.waitlist_entries USING btree (lower(email));


--
-- Name: idx_waitlist_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_waitlist_status ON public.waitlist_entries USING btree (status, created_at DESC);


--
-- Name: idx_wake_outbox_status_next_attempt; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_wake_outbox_status_next_attempt ON public.wake_outbox USING btree (status, next_attempt_at, created_at);


--
-- Name: idx_wake_outbox_target_agent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_wake_outbox_target_agent ON public.wake_outbox USING btree (workspace_slug, target_agent_id, status, next_attempt_at);


--
-- Name: idx_wake_outbox_workspace_dedupe; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_wake_outbox_workspace_dedupe ON public.wake_outbox USING btree (workspace_slug, dedupe_key);


--
-- Name: idx_wake_outbox_workspace_event_idempotency; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_wake_outbox_workspace_event_idempotency ON public.wake_outbox USING btree (workspace_slug, event_idempotency_key);


--
-- Name: idx_wakeup_requests_active_idempotency_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_wakeup_requests_active_idempotency_unique ON public.agent_wakeup_requests USING btree (workspace_slug, idempotency_key) WHERE ((idempotency_key IS NOT NULL) AND (status = ANY (ARRAY['pending'::text, 'claimed'::text])));


--
-- Name: idx_wakeup_requests_active_issue_tuple_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_wakeup_requests_active_issue_tuple_unique ON public.agent_wakeup_requests USING btree (workspace_slug, agent_id, COALESCE(reason, ''::text), ((payload ->> 'issueId'::text))) WHERE ((status = ANY (ARRAY['pending'::text, 'claimed'::text])) AND ((payload ->> 'issueId'::text) ~ '^[0-9]+$'::text));


--
-- Name: idx_wakeup_requests_agent_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_wakeup_requests_agent_status ON public.agent_wakeup_requests USING btree (agent_id, status);


--
-- Name: idx_wakeup_requests_idempotency; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_wakeup_requests_idempotency ON public.agent_wakeup_requests USING btree (workspace_slug, idempotency_key) WHERE (idempotency_key IS NOT NULL);


--
-- Name: idx_wakeup_requests_workspace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_wakeup_requests_workspace ON public.agent_wakeup_requests USING btree (workspace_slug);


--
-- Name: idx_wci_workspace_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_wci_workspace_slug ON public.workspace_connected_integrations USING btree (workspace_slug);


--
-- Name: idx_wip_ws_action_override; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_wip_ws_action_override ON public.workspace_integration_policies USING btree (workspace_slug, backend, app_slug, action_slug) WHERE (action_slug IS NOT NULL);


--
-- Name: idx_workspace_credentials_workspace; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_workspace_credentials_workspace ON public.workspace_credentials USING btree (workspace_slug);


--
-- Name: idx_workspace_execution_slot_reservations_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_workspace_execution_slot_reservations_active ON public.workspace_execution_slot_reservations USING btree (workspace_slug, expires_at) WHERE (released_at IS NULL);


--
-- Name: idx_workspace_members_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_workspace_members_slug ON public.workspace_members USING btree (workspace_slug);


--
-- Name: idx_workspace_members_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_workspace_members_user ON public.workspace_members USING btree (user_id);


--
-- Name: idx_workspace_members_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_workspace_members_user_id ON public.workspace_members USING btree (user_id);


--
-- Name: idx_workspace_members_workspace_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_workspace_members_workspace_slug ON public.workspace_members USING btree (workspace_slug);


--
-- Name: idx_workspaces_owner; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_workspaces_owner ON public.workspaces USING btree (owner_user_id);


--
-- Name: idx_workspaces_stripe_sub; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_workspaces_stripe_sub ON public.workspaces USING btree (stripe_subscription_id) WHERE (stripe_subscription_id IS NOT NULL);


--
-- Name: integration_action_failures_recent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX integration_action_failures_recent ON public.integration_action_failures USING btree (last_seen_at DESC) WHERE (status = 'open'::text);


--
-- Name: integration_action_failures_uniq; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX integration_action_failures_uniq ON public.integration_action_failures USING btree (provider, action_slug, error_signature);


--
-- Name: issues_blocker_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX issues_blocker_id_idx ON public.issues USING btree (blocker_id);


--
-- Name: issues_open_origin_uq; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX issues_open_origin_uq ON public.issues USING btree (workspace_slug, origin_kind, origin_id, origin_fingerprint) WHERE ((origin_id IS NOT NULL) AND (status <> ALL (ARRAY['done'::public.issue_status, 'cancelled'::public.issue_status])));


--
-- Name: issues_user_assignee_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX issues_user_assignee_idx ON public.issues USING btree (user_id, assignee_agent_id, status);


--
-- Name: local_servers_owner_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX local_servers_owner_idx ON public.local_servers USING btree (owner_user_id);


--
-- Name: local_servers_workspace_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX local_servers_workspace_idx ON public.local_servers USING btree (workspace_slug);


--
-- Name: message_attachments_msg_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX message_attachments_msg_idx ON public.message_attachments USING btree (workspace_slug, message_id);


--
-- Name: message_attachments_user_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX message_attachments_user_idx ON public.message_attachments USING btree (workspace_slug, user_id);


--
-- Name: messages_workspace_role_created_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX messages_workspace_role_created_at_idx ON public.messages USING btree (workspace_slug, role, created_at);


--
-- Name: referral_rewards_referrer_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX referral_rewards_referrer_idx ON public.referral_rewards USING btree (referrer_user_id, created_at);


--
-- Name: root_skills_trgm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX root_skills_trgm ON public.root_skills USING gin ((((name || ' '::text) || description)) public.gin_trgm_ops);


--
-- Name: server_access_grants_grantee_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX server_access_grants_grantee_idx ON public.server_access_grants USING btree (grantee_user_id);


--
-- Name: server_access_grants_server_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX server_access_grants_server_idx ON public.server_access_grants USING btree (server_id);


--
-- Name: server_access_grants_unique_active; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX server_access_grants_unique_active ON public.server_access_grants USING btree (server_id, grantee_user_id, COALESCE(workspace_scope, ''::text)) WHERE (revoked_at IS NULL);


--
-- Name: skill_proposals_blocker_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX skill_proposals_blocker_id_idx ON public.skill_proposals USING btree (blocker_id);


--
-- Name: skill_proposals_open_unique; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX skill_proposals_open_unique ON public.skill_proposals USING btree (canonical_key) WHERE (status = ANY (ARRAY['chief_proposed'::text, 'pending'::text]));


--
-- Name: skill_proposals_trgm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX skill_proposals_trgm ON public.skill_proposals USING gin ((((name || ' '::text) || description)) public.gin_trgm_ops);


--
-- Name: sync_oplog_unsynced_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sync_oplog_unsynced_idx ON public.sync_oplog USING btree (workspace_slug, seq) WHERE (synced_at IS NULL);


--
-- Name: sync_oplog_workspace_seq_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sync_oplog_workspace_seq_idx ON public.sync_oplog USING btree (workspace_slug, seq);


--
-- Name: users_sanctions_stale_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX users_sanctions_stale_idx ON public.users USING btree (sanctions_screened_at NULLS FIRST) WHERE (sanctions_status <> 'blocked'::text);


--
-- Name: web_search_cache_expiry; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX web_search_cache_expiry ON public.web_search_cache USING btree (expires_at);


--
-- Name: web_search_cache_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX web_search_cache_key ON public.web_search_cache USING btree (kind, cache_key);


--
-- Name: whoami_registry_attempt_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX whoami_registry_attempt_idx ON public.integration_whoami_registry USING btree (attempted_at NULLS FIRST);


--
-- Name: workspace_execution_lease_expires_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX workspace_execution_lease_expires_idx ON public.workspace_execution_lease USING btree (expires_at);


--
-- Name: account account_userId_fkey; Type: FK CONSTRAINT; Schema: neon_auth; Owner: -
--

ALTER TABLE ONLY neon_auth.account
    ADD CONSTRAINT "account_userId_fkey" FOREIGN KEY ("userId") REFERENCES neon_auth."user"(id) ON DELETE CASCADE;


--
-- Name: invitation invitation_inviterId_fkey; Type: FK CONSTRAINT; Schema: neon_auth; Owner: -
--

ALTER TABLE ONLY neon_auth.invitation
    ADD CONSTRAINT "invitation_inviterId_fkey" FOREIGN KEY ("inviterId") REFERENCES neon_auth."user"(id) ON DELETE CASCADE;


--
-- Name: invitation invitation_organizationId_fkey; Type: FK CONSTRAINT; Schema: neon_auth; Owner: -
--

ALTER TABLE ONLY neon_auth.invitation
    ADD CONSTRAINT "invitation_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES neon_auth.organization(id) ON DELETE CASCADE;


--
-- Name: member member_organizationId_fkey; Type: FK CONSTRAINT; Schema: neon_auth; Owner: -
--

ALTER TABLE ONLY neon_auth.member
    ADD CONSTRAINT "member_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES neon_auth.organization(id) ON DELETE CASCADE;


--
-- Name: member member_userId_fkey; Type: FK CONSTRAINT; Schema: neon_auth; Owner: -
--

ALTER TABLE ONLY neon_auth.member
    ADD CONSTRAINT "member_userId_fkey" FOREIGN KEY ("userId") REFERENCES neon_auth."user"(id) ON DELETE CASCADE;


--
-- Name: session session_userId_fkey; Type: FK CONSTRAINT; Schema: neon_auth; Owner: -
--

ALTER TABLE ONLY neon_auth.session
    ADD CONSTRAINT "session_userId_fkey" FOREIGN KEY ("userId") REFERENCES neon_auth."user"(id) ON DELETE CASCADE;


--
-- Name: accessibility_audit_items accessibility_audit_items_owner_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accessibility_audit_items
    ADD CONSTRAINT accessibility_audit_items_owner_user_id_fkey FOREIGN KEY (owner_user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: activity_log activity_log_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.activity_log
    ADD CONSTRAINT activity_log_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.agents(id) ON DELETE SET NULL;


--
-- Name: activity_log activity_log_issue_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.activity_log
    ADD CONSTRAINT activity_log_issue_id_fkey FOREIGN KEY (issue_id) REFERENCES public.issues(id) ON DELETE SET NULL;


--
-- Name: activity_log activity_log_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.activity_log
    ADD CONSTRAINT activity_log_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON DELETE SET NULL;


--
-- Name: activity_log activity_log_run_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.activity_log
    ADD CONSTRAINT activity_log_run_id_fkey FOREIGN KEY (run_id) REFERENCES public.agent_runs(id) ON DELETE SET NULL;


--
-- Name: activity_log activity_log_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.activity_log
    ADD CONSTRAINT activity_log_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: activity_log activity_log_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.activity_log
    ADD CONSTRAINT activity_log_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug) ON UPDATE CASCADE;


--
-- Name: agent_execution_locks agent_execution_locks_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_execution_locks
    ADD CONSTRAINT agent_execution_locks_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.agents(id) ON DELETE CASCADE;


--
-- Name: agent_execution_locks agent_execution_locks_issue_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_execution_locks
    ADD CONSTRAINT agent_execution_locks_issue_id_fkey FOREIGN KEY (issue_id) REFERENCES public.issues(id) ON DELETE CASCADE;


--
-- Name: agent_execution_locks agent_execution_locks_run_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_execution_locks
    ADD CONSTRAINT agent_execution_locks_run_id_fkey FOREIGN KEY (run_id) REFERENCES public.agent_runs(id) ON DELETE SET NULL;


--
-- Name: agent_execution_locks agent_execution_locks_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_execution_locks
    ADD CONSTRAINT agent_execution_locks_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: agent_execution_locks agent_execution_locks_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_execution_locks
    ADD CONSTRAINT agent_execution_locks_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug) ON DELETE CASCADE;


--
-- Name: agent_keys agent_keys_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_keys
    ADD CONSTRAINT agent_keys_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.agents(id) ON DELETE CASCADE;


--
-- Name: agent_keys agent_keys_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_keys
    ADD CONSTRAINT agent_keys_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug) ON DELETE CASCADE;


--
-- Name: agent_model_config agent_model_config_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_model_config
    ADD CONSTRAINT agent_model_config_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.agents(id) ON DELETE CASCADE;


--
-- Name: agent_model_config agent_model_config_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_model_config
    ADD CONSTRAINT agent_model_config_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug) ON UPDATE CASCADE;


--
-- Name: agent_runs agent_runs_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_runs
    ADD CONSTRAINT agent_runs_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.agents(id) ON DELETE CASCADE;


--
-- Name: agent_runs agent_runs_issue_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_runs
    ADD CONSTRAINT agent_runs_issue_id_fkey FOREIGN KEY (issue_id) REFERENCES public.issues(id) ON DELETE SET NULL;


--
-- Name: agent_runs agent_runs_parent_run_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_runs
    ADD CONSTRAINT agent_runs_parent_run_id_fkey FOREIGN KEY (parent_run_id) REFERENCES public.agent_runs(id) ON DELETE SET NULL;


--
-- Name: agent_runs agent_runs_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_runs
    ADD CONSTRAINT agent_runs_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: agent_runs agent_runs_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_runs
    ADD CONSTRAINT agent_runs_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug) ON UPDATE CASCADE;


--
-- Name: agent_skills agent_skills_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_skills
    ADD CONSTRAINT agent_skills_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.agents(id) ON DELETE CASCADE;


--
-- Name: agent_skills agent_skills_granted_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_skills
    ADD CONSTRAINT agent_skills_granted_by_user_id_fkey FOREIGN KEY (granted_by_user_id) REFERENCES public.users(id);


--
-- Name: agent_skills agent_skills_skill_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_skills
    ADD CONSTRAINT agent_skills_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES public.skills(id) ON DELETE CASCADE;


--
-- Name: agent_skills agent_skills_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_skills
    ADD CONSTRAINT agent_skills_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug);


--
-- Name: agent_tokens agent_tokens_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_tokens
    ADD CONSTRAINT agent_tokens_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.agents(id) ON DELETE CASCADE;


--
-- Name: agent_tokens agent_tokens_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_tokens
    ADD CONSTRAINT agent_tokens_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug) ON DELETE CASCADE;


--
-- Name: agent_wakeup_requests agent_wakeup_requests_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agent_wakeup_requests
    ADD CONSTRAINT agent_wakeup_requests_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.agents(id);


--
-- Name: agents agents_reports_to_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agents
    ADD CONSTRAINT agents_reports_to_fkey FOREIGN KEY (reports_to) REFERENCES public.agents(id) ON DELETE SET NULL;


--
-- Name: agents agents_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agents
    ADD CONSTRAINT agents_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: agents agents_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agents
    ADD CONSTRAINT agents_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug) ON UPDATE CASCADE;


--
-- Name: approvals approvals_deliverable_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.approvals
    ADD CONSTRAINT approvals_deliverable_id_fkey FOREIGN KEY (deliverable_id) REFERENCES public.deliverables(id) ON DELETE CASCADE;


--
-- Name: approvals approvals_related_issue_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.approvals
    ADD CONSTRAINT approvals_related_issue_id_fkey FOREIGN KEY (related_issue_id) REFERENCES public.issues(id) ON DELETE SET NULL;


--
-- Name: approvals approvals_requested_by_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.approvals
    ADD CONSTRAINT approvals_requested_by_agent_id_fkey FOREIGN KEY (requested_by_agent_id) REFERENCES public.agents(id) ON DELETE SET NULL;


--
-- Name: approvals approvals_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.approvals
    ADD CONSTRAINT approvals_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: approvals approvals_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.approvals
    ADD CONSTRAINT approvals_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug) ON UPDATE CASCADE;


--
-- Name: archived_objects archived_objects_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.archived_objects
    ADD CONSTRAINT archived_objects_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug) ON DELETE CASCADE;


--
-- Name: beta_access_log beta_access_log_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.beta_access_log
    ADD CONSTRAINT beta_access_log_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: beta_access_log beta_access_log_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.beta_access_log
    ADD CONSTRAINT beta_access_log_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug) ON DELETE SET NULL;


--
-- Name: beta_invitations beta_invitations_accepted_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.beta_invitations
    ADD CONSTRAINT beta_invitations_accepted_by_user_id_fkey FOREIGN KEY (accepted_by_user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: beta_invitations beta_invitations_invited_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.beta_invitations
    ADD CONSTRAINT beta_invitations_invited_by_user_id_fkey FOREIGN KEY (invited_by_user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: beta_invitations beta_invitations_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.beta_invitations
    ADD CONSTRAINT beta_invitations_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug) ON DELETE SET NULL;


--
-- Name: business_profiles business_profiles_default_copy_voice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.business_profiles
    ADD CONSTRAINT business_profiles_default_copy_voice_id_fkey FOREIGN KEY (default_copy_voice_id) REFERENCES public.copy_voices(id);


--
-- Name: business_profiles business_profiles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.business_profiles
    ADD CONSTRAINT business_profiles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: business_profiles business_profiles_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.business_profiles
    ADD CONSTRAINT business_profiles_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug) ON UPDATE CASCADE;


--
-- Name: channels channels_connected_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_connected_account_id_fkey FOREIGN KEY (connected_account_id) REFERENCES public.connected_accounts(id) ON DELETE CASCADE;


--
-- Name: channels channels_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.channels
    ADD CONSTRAINT channels_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug) ON DELETE CASCADE;


--
-- Name: chat_threads chat_threads_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.chat_threads
    ADD CONSTRAINT chat_threads_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: communication_compliance_events communication_compliance_events_actor_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.communication_compliance_events
    ADD CONSTRAINT communication_compliance_events_actor_user_id_fkey FOREIGN KEY (actor_user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: communication_consents communication_consents_granted_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.communication_consents
    ADD CONSTRAINT communication_consents_granted_by_user_id_fkey FOREIGN KEY (granted_by_user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: communication_suppressions communication_suppressions_created_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.communication_suppressions
    ADD CONSTRAINT communication_suppressions_created_by_user_id_fkey FOREIGN KEY (created_by_user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: composio_recommendations composio_recommendations_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.composio_recommendations
    ADD CONSTRAINT composio_recommendations_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.agents(id);


--
-- Name: composio_recommendations composio_recommendations_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.composio_recommendations
    ADD CONSTRAINT composio_recommendations_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug) ON UPDATE CASCADE;


--
-- Name: config_versions config_versions_changed_by_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.config_versions
    ADD CONSTRAINT config_versions_changed_by_agent_id_fkey FOREIGN KEY (changed_by_agent_id) REFERENCES public.agents(id);


--
-- Name: config_versions config_versions_changed_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.config_versions
    ADD CONSTRAINT config_versions_changed_by_user_id_fkey FOREIGN KEY (changed_by_user_id) REFERENCES public.users(id);


--
-- Name: config_versions config_versions_reverted_from_version_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.config_versions
    ADD CONSTRAINT config_versions_reverted_from_version_id_fkey FOREIGN KEY (reverted_from_version_id) REFERENCES public.config_versions(id);


--
-- Name: config_versions config_versions_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.config_versions
    ADD CONSTRAINT config_versions_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug);


--
-- Name: connected_accounts connected_accounts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.connected_accounts
    ADD CONSTRAINT connected_accounts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: connected_accounts connected_accounts_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.connected_accounts
    ADD CONSTRAINT connected_accounts_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug) ON DELETE CASCADE;


--
-- Name: copy_voices copy_voices_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.copy_voices
    ADD CONSTRAINT copy_voices_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug);


--
-- Name: cost_events cost_events_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cost_events
    ADD CONSTRAINT cost_events_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.agents(id) ON DELETE CASCADE;


--
-- Name: cost_events cost_events_issue_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cost_events
    ADD CONSTRAINT cost_events_issue_id_fkey FOREIGN KEY (issue_id) REFERENCES public.issues(id) ON DELETE SET NULL;


--
-- Name: cost_events cost_events_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cost_events
    ADD CONSTRAINT cost_events_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON DELETE SET NULL;


--
-- Name: cost_events cost_events_run_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cost_events
    ADD CONSTRAINT cost_events_run_id_fkey FOREIGN KEY (run_id) REFERENCES public.agent_runs(id) ON DELETE SET NULL;


--
-- Name: cost_events cost_events_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cost_events
    ADD CONSTRAINT cost_events_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: cost_events cost_events_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cost_events
    ADD CONSTRAINT cost_events_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug) ON UPDATE CASCADE;


--
-- Name: deliverable_proposed_tasks deliverable_proposed_tasks_deliverable_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deliverable_proposed_tasks
    ADD CONSTRAINT deliverable_proposed_tasks_deliverable_id_fkey FOREIGN KEY (deliverable_id) REFERENCES public.deliverables(id) ON DELETE CASCADE;


--
-- Name: deliverable_proposed_tasks deliverable_proposed_tasks_materialized_issue_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deliverable_proposed_tasks
    ADD CONSTRAINT deliverable_proposed_tasks_materialized_issue_id_fkey FOREIGN KEY (materialized_issue_id) REFERENCES public.issues(id) ON DELETE SET NULL;


--
-- Name: deliverable_proposed_tasks deliverable_proposed_tasks_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deliverable_proposed_tasks
    ADD CONSTRAINT deliverable_proposed_tasks_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug) ON DELETE CASCADE;


--
-- Name: deliverable_sections deliverable_sections_deliverable_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deliverable_sections
    ADD CONSTRAINT deliverable_sections_deliverable_id_fkey FOREIGN KEY (deliverable_id) REFERENCES public.deliverables(id) ON DELETE CASCADE;


--
-- Name: deliverable_sections deliverable_sections_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deliverable_sections
    ADD CONSTRAINT deliverable_sections_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug) ON DELETE CASCADE;


--
-- Name: deliverables deliverables_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deliverables
    ADD CONSTRAINT deliverables_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.agents(id) ON DELETE SET NULL;


--
-- Name: deliverables deliverables_approved_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deliverables
    ADD CONSTRAINT deliverables_approved_by_user_id_fkey FOREIGN KEY (approved_by_user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: deliverables deliverables_goal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deliverables
    ADD CONSTRAINT deliverables_goal_id_fkey FOREIGN KEY (goal_id) REFERENCES public.goals(id) ON DELETE SET NULL;


--
-- Name: deliverables deliverables_issue_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deliverables
    ADD CONSTRAINT deliverables_issue_id_fkey FOREIGN KEY (issue_id) REFERENCES public.issues(id) ON DELETE SET NULL;


--
-- Name: deliverables deliverables_linked_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deliverables
    ADD CONSTRAINT deliverables_linked_project_id_fkey FOREIGN KEY (linked_project_id) REFERENCES public.projects(id) ON DELETE SET NULL;


--
-- Name: deliverables deliverables_originating_human_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deliverables
    ADD CONSTRAINT deliverables_originating_human_id_fkey FOREIGN KEY (originating_human_id) REFERENCES public.users(id);


--
-- Name: deliverables deliverables_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deliverables
    ADD CONSTRAINT deliverables_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON DELETE SET NULL;


--
-- Name: deliverables deliverables_proposed_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deliverables
    ADD CONSTRAINT deliverables_proposed_project_id_fkey FOREIGN KEY (proposed_project_id) REFERENCES public.projects(id) ON DELETE SET NULL;


--
-- Name: deliverables deliverables_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deliverables
    ADD CONSTRAINT deliverables_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: deliverables deliverables_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deliverables
    ADD CONSTRAINT deliverables_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug) ON UPDATE CASCADE;


--
-- Name: delivery_problem_reports delivery_problem_reports_issue_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_problem_reports
    ADD CONSTRAINT delivery_problem_reports_issue_id_fkey FOREIGN KEY (issue_id) REFERENCES public.issues(id);


--
-- Name: delivery_problem_reports delivery_problem_reports_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_problem_reports
    ADD CONSTRAINT delivery_problem_reports_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: delivery_problem_reports delivery_problem_reports_resolved_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_problem_reports
    ADD CONSTRAINT delivery_problem_reports_resolved_by_user_id_fkey FOREIGN KEY (resolved_by_user_id) REFERENCES public.users(id);


--
-- Name: delivery_problem_reports delivery_problem_reports_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.delivery_problem_reports
    ADD CONSTRAINT delivery_problem_reports_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: feedback_reports feedback_reports_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.feedback_reports
    ADD CONSTRAINT feedback_reports_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: free_tier_ledger free_tier_ledger_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.free_tier_ledger
    ADD CONSTRAINT free_tier_ledger_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug) ON UPDATE CASCADE;


--
-- Name: goal_measurements goal_measurements_goal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.goal_measurements
    ADD CONSTRAINT goal_measurements_goal_id_fkey FOREIGN KEY (goal_id) REFERENCES public.goals(id) ON DELETE CASCADE;


--
-- Name: goals goals_owner_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.goals
    ADD CONSTRAINT goals_owner_agent_id_fkey FOREIGN KEY (owner_agent_id) REFERENCES public.agents(id) ON DELETE SET NULL;


--
-- Name: goals goals_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.goals
    ADD CONSTRAINT goals_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.goals(id) ON DELETE SET NULL;


--
-- Name: goals goals_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.goals
    ADD CONSTRAINT goals_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: goals goals_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.goals
    ADD CONSTRAINT goals_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug) ON UPDATE CASCADE;


--
-- Name: high_risk_gate_events high_risk_gate_events_actor_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.high_risk_gate_events
    ADD CONSTRAINT high_risk_gate_events_actor_user_id_fkey FOREIGN KEY (actor_user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: high_risk_gate_events high_risk_gate_events_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.high_risk_gate_events
    ADD CONSTRAINT high_risk_gate_events_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.agents(id) ON DELETE SET NULL;


--
-- Name: hub_channels hub_channels_blocker_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_channels
    ADD CONSTRAINT hub_channels_blocker_id_fkey FOREIGN KEY (blocker_id) REFERENCES public.execution_blockers(id) ON DELETE SET NULL;


--
-- Name: hub_channels hub_channels_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_channels
    ADD CONSTRAINT hub_channels_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug);


--
-- Name: hub_conversation_reads hub_conversation_reads_conversation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_conversation_reads
    ADD CONSTRAINT hub_conversation_reads_conversation_id_fkey FOREIGN KEY (conversation_id) REFERENCES public.hub_conversations(id) ON DELETE CASCADE;


--
-- Name: hub_conversation_reads hub_conversation_reads_last_read_message_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_conversation_reads
    ADD CONSTRAINT hub_conversation_reads_last_read_message_id_fkey FOREIGN KEY (last_read_message_id) REFERENCES public.hub_messages(id);


--
-- Name: hub_conversation_reads hub_conversation_reads_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_conversation_reads
    ADD CONSTRAINT hub_conversation_reads_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.workspace_members(id);


--
-- Name: hub_conversation_tags hub_conversation_tags_conversation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_conversation_tags
    ADD CONSTRAINT hub_conversation_tags_conversation_id_fkey FOREIGN KEY (conversation_id) REFERENCES public.hub_conversations(id) ON DELETE CASCADE;


--
-- Name: hub_conversation_tags hub_conversation_tags_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_conversation_tags
    ADD CONSTRAINT hub_conversation_tags_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.hub_tags(id) ON DELETE CASCADE;


--
-- Name: hub_conversations hub_conversations_assigned_to_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_conversations
    ADD CONSTRAINT hub_conversations_assigned_to_member_id_fkey FOREIGN KEY (assigned_to_member_id) REFERENCES public.workspace_members(id);


--
-- Name: hub_conversations hub_conversations_channel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_conversations
    ADD CONSTRAINT hub_conversations_channel_id_fkey FOREIGN KEY (channel_id) REFERENCES public.hub_channels(id);


--
-- Name: hub_conversations hub_conversations_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_conversations
    ADD CONSTRAINT hub_conversations_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug);


--
-- Name: hub_internal_comments hub_internal_comments_author_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_internal_comments
    ADD CONSTRAINT hub_internal_comments_author_member_id_fkey FOREIGN KEY (author_member_id) REFERENCES public.workspace_members(id);


--
-- Name: hub_internal_comments hub_internal_comments_conversation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_internal_comments
    ADD CONSTRAINT hub_internal_comments_conversation_id_fkey FOREIGN KEY (conversation_id) REFERENCES public.hub_conversations(id) ON DELETE CASCADE;


--
-- Name: hub_message_attachments hub_message_attachments_message_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_message_attachments
    ADD CONSTRAINT hub_message_attachments_message_id_fkey FOREIGN KEY (message_id) REFERENCES public.hub_messages(id) ON DELETE CASCADE;


--
-- Name: hub_message_participants hub_message_participants_message_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_message_participants
    ADD CONSTRAINT hub_message_participants_message_id_fkey FOREIGN KEY (message_id) REFERENCES public.hub_messages(id) ON DELETE CASCADE;


--
-- Name: hub_messages hub_messages_channel_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_messages
    ADD CONSTRAINT hub_messages_channel_id_fkey FOREIGN KEY (channel_id) REFERENCES public.hub_channels(id);


--
-- Name: hub_messages hub_messages_conversation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_messages
    ADD CONSTRAINT hub_messages_conversation_id_fkey FOREIGN KEY (conversation_id) REFERENCES public.hub_conversations(id) ON DELETE CASCADE;


--
-- Name: hub_routing_rules hub_routing_rules_created_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_routing_rules
    ADD CONSTRAINT hub_routing_rules_created_by_user_id_fkey FOREIGN KEY (created_by_user_id) REFERENCES public.users(id);


--
-- Name: hub_tags hub_tags_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hub_tags
    ADD CONSTRAINT hub_tags_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug);


--
-- Name: idempotency_ledger idempotency_ledger_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.idempotency_ledger
    ADD CONSTRAINT idempotency_ledger_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug) ON DELETE CASCADE;


--
-- Name: inbox_conversations inbox_conversations_linked_approval_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inbox_conversations
    ADD CONSTRAINT inbox_conversations_linked_approval_id_fkey FOREIGN KEY (linked_approval_id) REFERENCES public.approvals(id) ON DELETE SET NULL;


--
-- Name: inbox_conversations inbox_conversations_linked_goal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inbox_conversations
    ADD CONSTRAINT inbox_conversations_linked_goal_id_fkey FOREIGN KEY (linked_goal_id) REFERENCES public.goals(id) ON DELETE SET NULL;


--
-- Name: inbox_conversations inbox_conversations_linked_issue_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inbox_conversations
    ADD CONSTRAINT inbox_conversations_linked_issue_id_fkey FOREIGN KEY (linked_issue_id) REFERENCES public.issues(id) ON DELETE SET NULL;


--
-- Name: inbox_conversations inbox_conversations_owner_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inbox_conversations
    ADD CONSTRAINT inbox_conversations_owner_user_id_fkey FOREIGN KEY (owner_user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: inbox_conversations inbox_conversations_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inbox_conversations
    ADD CONSTRAINT inbox_conversations_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug) ON DELETE CASCADE;


--
-- Name: inbox_messages inbox_messages_conversation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inbox_messages
    ADD CONSTRAINT inbox_messages_conversation_id_fkey FOREIGN KEY (conversation_id) REFERENCES public.inbox_conversations(id) ON DELETE CASCADE;


--
-- Name: inbox_messages inbox_messages_linked_approval_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inbox_messages
    ADD CONSTRAINT inbox_messages_linked_approval_id_fkey FOREIGN KEY (linked_approval_id) REFERENCES public.approvals(id) ON DELETE SET NULL;


--
-- Name: inbox_messages inbox_messages_sender_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inbox_messages
    ADD CONSTRAINT inbox_messages_sender_agent_id_fkey FOREIGN KEY (sender_agent_id) REFERENCES public.agents(id) ON DELETE SET NULL;


--
-- Name: inbox_messages inbox_messages_sender_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inbox_messages
    ADD CONSTRAINT inbox_messages_sender_user_id_fkey FOREIGN KEY (sender_user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: inbox_messages inbox_messages_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inbox_messages
    ADD CONSTRAINT inbox_messages_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug) ON DELETE CASCADE;


--
-- Name: inbox_notifications inbox_notifications_source_brief_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inbox_notifications
    ADD CONSTRAINT inbox_notifications_source_brief_id_fkey FOREIGN KEY (source_brief_id) REFERENCES public.issues(id) ON DELETE CASCADE;


--
-- Name: inbox_notifications inbox_notifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inbox_notifications
    ADD CONSTRAINT inbox_notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: inbox_notifications inbox_notifications_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inbox_notifications
    ADD CONSTRAINT inbox_notifications_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug) ON DELETE CASCADE;


--
-- Name: issue_comments issue_comments_author_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issue_comments
    ADD CONSTRAINT issue_comments_author_agent_id_fkey FOREIGN KEY (author_agent_id) REFERENCES public.agents(id);


--
-- Name: issue_comments issue_comments_author_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issue_comments
    ADD CONSTRAINT issue_comments_author_user_id_fkey FOREIGN KEY (author_user_id) REFERENCES public.users(id);


--
-- Name: issue_comments issue_comments_issue_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issue_comments
    ADD CONSTRAINT issue_comments_issue_id_fkey FOREIGN KEY (issue_id) REFERENCES public.issues(id) ON DELETE CASCADE;


--
-- Name: issue_comments issue_comments_parent_comment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issue_comments
    ADD CONSTRAINT issue_comments_parent_comment_id_fkey FOREIGN KEY (parent_comment_id) REFERENCES public.issue_comments(id) ON DELETE CASCADE;


--
-- Name: issue_decompositions issue_decompositions_goal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issue_decompositions
    ADD CONSTRAINT issue_decompositions_goal_id_fkey FOREIGN KEY (goal_id) REFERENCES public.goals(id);


--
-- Name: issue_decompositions issue_decompositions_source_issue_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issue_decompositions
    ADD CONSTRAINT issue_decompositions_source_issue_id_fkey FOREIGN KEY (source_issue_id) REFERENCES public.issues(id);


--
-- Name: issue_decompositions issue_decompositions_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issue_decompositions
    ADD CONSTRAINT issue_decompositions_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug);


--
-- Name: issue_review_attempts issue_review_attempts_issue_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issue_review_attempts
    ADD CONSTRAINT issue_review_attempts_issue_id_fkey FOREIGN KEY (issue_id) REFERENCES public.issues(id) ON DELETE CASCADE;


--
-- Name: issue_review_attempts issue_review_attempts_reviewer_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issue_review_attempts
    ADD CONSTRAINT issue_review_attempts_reviewer_agent_id_fkey FOREIGN KEY (reviewer_agent_id) REFERENCES public.agents(id) ON DELETE CASCADE;


--
-- Name: issue_review_attempts issue_review_attempts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issue_review_attempts
    ADD CONSTRAINT issue_review_attempts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: issue_storylines issue_storylines_issue_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issue_storylines
    ADD CONSTRAINT issue_storylines_issue_id_fkey FOREIGN KEY (issue_id) REFERENCES public.issues(id) ON DELETE CASCADE;


--
-- Name: issues issues_assignee_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issues
    ADD CONSTRAINT issues_assignee_agent_id_fkey FOREIGN KEY (assignee_agent_id) REFERENCES public.agents(id) ON DELETE SET NULL;


--
-- Name: issues issues_blocker_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issues
    ADD CONSTRAINT issues_blocker_id_fkey FOREIGN KEY (blocker_id) REFERENCES public.execution_blockers(id) ON DELETE SET NULL;


--
-- Name: issues issues_claimed_by_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issues
    ADD CONSTRAINT issues_claimed_by_agent_id_fkey FOREIGN KEY (claimed_by_agent_id) REFERENCES public.agents(id) ON DELETE SET NULL;


--
-- Name: issues issues_created_by_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issues
    ADD CONSTRAINT issues_created_by_agent_id_fkey FOREIGN KEY (created_by_agent_id) REFERENCES public.agents(id) ON DELETE SET NULL;


--
-- Name: issues issues_goal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issues
    ADD CONSTRAINT issues_goal_id_fkey FOREIGN KEY (goal_id) REFERENCES public.goals(id) ON DELETE SET NULL;


--
-- Name: issues issues_originating_human_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issues
    ADD CONSTRAINT issues_originating_human_id_fkey FOREIGN KEY (originating_human_id) REFERENCES public.users(id);


--
-- Name: issues issues_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issues
    ADD CONSTRAINT issues_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.issues(id) ON DELETE SET NULL;


--
-- Name: issues issues_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issues
    ADD CONSTRAINT issues_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON DELETE SET NULL;


--
-- Name: issues issues_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issues
    ADD CONSTRAINT issues_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: issues issues_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.issues
    ADD CONSTRAINT issues_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug) ON UPDATE CASCADE;


--
-- Name: legal_acceptances legal_acceptances_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.legal_acceptances
    ADD CONSTRAINT legal_acceptances_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: memory_entries memory_entries_source_message_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.memory_entries
    ADD CONSTRAINT memory_entries_source_message_id_fkey FOREIGN KEY (source_message_id) REFERENCES public.messages(id) ON DELETE SET NULL;


--
-- Name: memory_entries memory_entries_superseded_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.memory_entries
    ADD CONSTRAINT memory_entries_superseded_by_fkey FOREIGN KEY (superseded_by) REFERENCES public.memory_entries(id) ON DELETE SET NULL;


--
-- Name: memory_entries memory_entries_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.memory_entries
    ADD CONSTRAINT memory_entries_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: memory_entries memory_entries_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.memory_entries
    ADD CONSTRAINT memory_entries_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug) ON UPDATE CASCADE;


--
-- Name: message_delivery_attempts message_delivery_attempts_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.message_delivery_attempts
    ADD CONSTRAINT message_delivery_attempts_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug) ON DELETE CASCADE;


--
-- Name: messages messages_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.agents(id) ON DELETE SET NULL;


--
-- Name: messages messages_issue_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_issue_id_fkey FOREIGN KEY (issue_id) REFERENCES public.issues(id) ON DELETE SET NULL;


--
-- Name: messages messages_run_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_run_id_fkey FOREIGN KEY (run_id) REFERENCES public.agent_runs(id) ON DELETE SET NULL;


--
-- Name: messages messages_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: messages messages_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug) ON UPDATE CASCADE;


--
-- Name: model_registry model_registry_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.model_registry
    ADD CONSTRAINT model_registry_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: model_registry model_registry_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.model_registry
    ADD CONSTRAINT model_registry_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug) ON UPDATE CASCADE;


--
-- Name: needs_from_you_items needs_from_you_items_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.needs_from_you_items
    ADD CONSTRAINT needs_from_you_items_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.agents(id);


--
-- Name: needs_from_you_items needs_from_you_items_linked_approval_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.needs_from_you_items
    ADD CONSTRAINT needs_from_you_items_linked_approval_id_fkey FOREIGN KEY (linked_approval_id) REFERENCES public.approvals(id);


--
-- Name: needs_from_you_items needs_from_you_items_message_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.needs_from_you_items
    ADD CONSTRAINT needs_from_you_items_message_id_fkey FOREIGN KEY (message_id) REFERENCES public.messages(id);


--
-- Name: needs_from_you_items needs_from_you_items_originating_human_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.needs_from_you_items
    ADD CONSTRAINT needs_from_you_items_originating_human_id_fkey FOREIGN KEY (originating_human_id) REFERENCES public.users(id);


--
-- Name: needs_from_you_items needs_from_you_items_resolved_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.needs_from_you_items
    ADD CONSTRAINT needs_from_you_items_resolved_by_user_id_fkey FOREIGN KEY (resolved_by_user_id) REFERENCES public.users(id);


--
-- Name: needs_from_you_items needs_from_you_items_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.needs_from_you_items
    ADD CONSTRAINT needs_from_you_items_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug);


--
-- Name: oauth_accounts oauth_accounts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_accounts
    ADD CONSTRAINT oauth_accounts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: participants participants_workspace_slug_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.participants
    ADD CONSTRAINT participants_workspace_slug_fkey FOREIGN KEY (workspace_slug) REFERENCES public.workspaces(slug) ON DELETE CASCADE;


--
-- Name: payment_handoff_events payment_handoff_events_actor_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_handoff_events
    ADD CONSTRAINT payment_handoff_events_actor_user_id_fkey FOREIGN KEY (actor_user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: payment_handoff_events payment_handoff_events_agent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_handoff_events
    ADD CONSTRAINT payment_handoff_events_agent_id_fkey FOREIGN KEY (agent_id) REFERENCES public.agents(id) ON DELETE SET NULL;


--
-- Name: privacy_request_appeals privacy_request_appeals_privacy_request_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.privacy_request_appeals
    ADD CONSTRAINT privacy_request_appeals_privacy_request_id_fkey FOREIGN KEY (privacy_request_id) REFERENCES public.privacy_requests(id) ON DELETE CASCADE;


--
-- Name: privacy_request_appeals privacy_request_appeals_requester_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.privacy_request_appeals
    ADD CONSTRAINT privacy_request_appeals_requester_user_id_fkey FOREIGN KEY (requester_user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: privacy_request_appeals privacy_request_appeals_resolved_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.privacy_request_appeals
    ADD CONSTRAINT privacy_request_appeals_resolved_by_user_id_fkey FOREIGN KEY (resolved_by_user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: privacy_request_verifications privacy_request_verifications_privacy_request_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.privacy_request_verifications
    ADD CONSTRAINT privacy_request_verifications_privacy_request_id_fkey FOREIGN KEY (privacy_request_id) REFERENCES public.privacy_requests(id) ON DELETE CASCADE;


--
-- Name: privacy_request_verifications privacy_request_verifications_requester_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.privacy_request_verifications
    ADD CONSTRAINT privacy_request_verifications_requester_user_id_fkey FOREIGN KEY (requester_user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: provider_exclusions provider_exclusions_created_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.provider_exclusions
    ADD CONSTRAINT provider_exclusions_created_by_user_id_fkey FOREIGN KEY (created_by_user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: sanctions_screening_events sanctions_screening_events_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sanctions_screening_events
    ADD CONSTRAINT sanctions_screening_events_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: skill_proposals skill_proposals_blocker_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.skill_proposals
    ADD CONSTRAINT skill_proposals_blocker_id_fkey FOREIGN KEY (blocker_id) REFERENCES public.execution_blockers(id) ON DELETE SET NULL;


--
-- Name: skill_proposals skill_proposals_target_root_skill_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.skill_proposals
    ADD CONSTRAINT skill_proposals_target_root_skill_id_fkey FOREIGN KEY (target_root_skill_id) REFERENCES public.root_skills(id);


--
-- Name: skills skills_root_skill_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_root_skill_id_fkey FOREIGN KEY (root_skill_id) REFERENCES public.root_skills(id);


--
-- Name: tool_write_grants tool_write_grants_granted_by_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tool_write_grants
    ADD CONSTRAINT tool_write_grants_granted_by_user_id_fkey FOREIGN KEY (granted_by_user_id) REFERENCES public.users(id);


--
-- Name: tool_write_grants tool_write_grants_project_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tool_write_grants
    ADD CONSTRAINT tool_write_grants_project_id_fkey FOREIGN KEY (project_id) REFERENCES public.projects(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--


