-- ============================================================
-- 00_extensions.sql
-- Extensões necessárias: busca fulltext, bcrypt para admin, uuid
-- ============================================================

create extension if not exists pgcrypto;
create extension if not exists pg_trgm;
create extension if not exists "uuid-ossp";