create type spotify_plan as enum (
  'free',
  'student_premium',
  'standart_premium',
  'family_premium',
  'duo_premium'
);

CREATE TYPE public.playlist_match_status AS ENUM (
  'active',
  'expired',
  'disbanded'
);
