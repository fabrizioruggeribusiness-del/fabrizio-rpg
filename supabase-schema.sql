-- ─────────────────────────────────────────────
-- Schema Supabase per Fabrizio RPG
-- Esegui questo nel SQL Editor di Supabase (una volta sola)
-- ─────────────────────────────────────────────

-- Tabella: un record per giorno, dati abitudini in JSON
create table if not exists habit_days (
  user_id    uuid not null references auth.users on delete cascade,
  day        date not null,
  data       jsonb not null default '{}',
  updated_at timestamptz not null default now(),
  primary key (user_id, day)
);

-- Sicurezza: ogni utente vede e modifica SOLO i propri dati
alter table habit_days enable row level security;

drop policy if exists "own_rows" on habit_days;
create policy "own_rows" on habit_days
  for all
  using  (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- Aggiorna updated_at ad ogni modifica
create or replace function touch_updated_at()
returns trigger as $$
begin new.updated_at = now(); return new; end;
$$ language plpgsql;

drop trigger if exists trg_touch on habit_days;
create trigger trg_touch before update on habit_days
  for each row execute function touch_updated_at();
