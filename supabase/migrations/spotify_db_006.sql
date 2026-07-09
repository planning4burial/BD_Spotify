-- POPULAR O BANCO

-- ============================================================================
-- 2. POPULAR ARTISTAS (10 registros)
-- ============================================================================
INSERT INTO public.artists (name, bio, verified, profile_image_url) VALUES
('The Midnight Resonance', 'Banda de synthwave formada em 2018.', true, 'https://images.example.com/artists/midnight.jpg'),
('Aline Souza', 'Cantora e compositora brasileira de MPB contemporânea.', true, 'https://images.example.com/artists/aline_souza.jpg'),
('Cyberpunk Orchestra', 'Projeto de música eletrônica industrial de Berlim.', false, 'https://images.example.com/artists/cyber_orch.jpg'),
('Luna & O Mar', 'Duo de indie folk acústico.', true, 'https://images.example.com/artists/luna_mar.jpg'),
('MC Flash', 'Produtor e artista de Funk de SP.', false, 'https://images.example.com/artists/mc_flash.jpg'),
('Iron Horizon', 'Grupo de heavy metal clássico.', true, 'https://images.example.com/artists/iron_horizon.jpg'),
('DJ Kaelen', 'DJ e produtor de Lo-Fi Hip Hop.', false, 'https://images.example.com/artists/dj_kaelen.jpg'),
('Symphony of Stars', 'Orquestra neoclássica focada em trilhas sonoras.', true, 'https://images.example.com/artists/symphony_stars.jpg'),
('Vibe Positiva', 'Banda de Reggae raiz.', true, 'https://images.example.com/artists/vibe_pos.jpg'),
('The Glitch Core', 'Trio focado em Hyperpop experimental.', false, 'https://images.example.com/artists/glitch_core.jpg');

-- ============================================================================
-- 3. POPULAR USUÁRIOS (11 registros - Incluindo o 'jean')
-- ============================================================================
INSERT INTO public.users (username, email, password_hash, country_code, date_of_birth, is_premium, plan_type) VALUES
('jean', 'jean@email.com', '$2b$12$J1e2a3n...', 'BR', '1996-06-15', true, 'standart_premium'),
('joao_silva', 'joao@email.com', '$2b$12$K3j8sh...', 'BR', '1995-04-12', false, 'free'),
('mari_oliveira', 'mari@email.com', '$2b$12$L9k2js...', 'BR', '1998-11-23', true, 'student_premium'),
('john_doe', 'john@example.com', '$2b$12$M1o0pl...', 'US', '1990-01-15', true, 'standart_premium'),
('yuki_tanaka', 'yuki@email.jp', '$2b$12$N4p1qa...', 'JP', '2001-08-05', false, 'free'),
('pedro_alvares', 'pedro@email.com', '$2b$12$O5q2ws...', 'PT', '1988-05-20', true, 'family_premium'),
('ana_costa', 'ana.costa@email.com', '$2b$12$P6r3ed...', 'BR', '2003-03-30', false, 'free'),
('carlos_m', 'carlos_m@email.com', '$2b$12$Q7t4rf...', 'AR', '1997-12-01', true, 'duo_premium'),
('clara_b', 'clara.b@email.com', '$2b$12$R8y5tg...', 'BR', '1999-07-14', false, 'free'),
('lucas_v', 'lucas.v@email.com', '$2b$12$S9u6yh...', 'BR', '1994-09-09', true, 'standart_premium'),
('elena_r', 'elena.r@example.com', '$2b$12$T0i7uj...', 'ES', '2002-02-22', false, 'free');

-- ============================================================================
-- 4. POPULAR ÁLBUNS (Associados aos artistas inseridos acima)
-- ============================================================================
INSERT INTO public.albums (title, release_date, cover_art_url, artist_id, genre) VALUES
('Neon Dreams', '2022-03-15', 'https://images.example.com/covers/neon.jpg', 1, 'Synthwave'),
('Cores da Terra', '2021-08-20', 'https://images.example.com/covers/cores.jpg', 2, 'MPB'),
('Grid Runner', '2023-01-10', 'https://images.example.com/covers/grid.jpg', 3, 'Electronic'),
('Eco dos Vales', '2020-05-04', 'https://images.example.com/covers/eco.jpg', 4, 'Indie Folk'),
('Coffee & Beats', '2022-10-01', 'https://images.example.com/covers/coffee.jpg', 7, 'Lo-Fi Hip Hop');

-- ============================================================================
-- 5. POPULAR MÚSICAS (Tracks)
-- ============================================================================
INSERT INTO public.tracks (title, duration_seconds, explicit, audio_file_url, album_id, playback_count) VALUES
('Sunset Cruise', 245, false, 'https://audio.example.com/sunset.mp3', 1, 150),
('Midnight Driver', 210, false, 'https://audio.example.com/midnight.mp3', 1, 320),
('Flor de Maracujá', 185, false, 'https://audio.example.com/flor.mp3', 2, 85),
('Data Stream', 305, true, 'https://audio.example.com/data.mp3', 3, 410),
('Vento Norte', 222, false, 'https://audio.example.com/vento.mp3', 4, 120),
('Rainy Window', 160, false, 'https://audio.example.com/rainy.mp3', 5, 240),
('Café Amargo', 145, false, 'https://audio.example.com/cafe.mp3', 5, 195);

-- ============================================================================
-- 6. VÍNCULO DE ARTISTAS DA MÚSICA (track_artists)
-- ============================================================================
INSERT INTO public.track_artists (track_id, artist_id, is_primary_artist) VALUES
(1, 1, true),
(2, 1, true),
(3, 2, true),
(4, 3, true),
(5, 4, true),
(6, 7, true),
(7, 7, true);

-- ============================================================================
-- 7. HISTÓRICO DE REPRODUÇÃO (Dando volume para testar a sua query do Jean)
-- ============================================================================
-- O 'jean' possui user_id = 1. Vamos fazê-lo ouvir várias músicas para ranquear.
INSERT INTO public.user_track_playback (track_id, user_id, created_at) VALUES
(1, 1, NOW() - INTERVAL '5 days'), (1, 1, NOW() - INTERVAL '4 days'), (1, 1, NOW() - INTERVAL '3 days'), -- 'Sunset Cruise' ouvida 3 vezes
(2, 1, NOW() - INTERVAL '2 days'), (2, 1, NOW() - INTERVAL '1 day'),                                  -- 'Midnight Driver' ouvida 2 vezes
(6, 1, NOW() - INTERVAL '6 hours'), (6, 1, NOW() - INTERVAL '5 hours'), (6, 1, NOW() - INTERVAL '4 hours'), (6, 1, NOW() - INTERVAL '3 hours'), -- 'Rainy Window' ouvida 4 vezes (Top 1)
(3, 1, NOW() - INTERVAL '1 hour'),                                                                     -- 'Flor de Maracujá' ouvida 1 vez
(7, 1, NOW() - INTERVAL '30 minutes'), (7, 1, NOW() - INTERVAL '10 minutes'),                          -- 'Café Amargo' ouvida 2 vezes
(4, 2, NOW()); -- Reprodução de outro usuário para testar o filtro do WHERE

-- ============================================================================
-- 8. PLAYLISTS E MAIS RELACIONAMENTOS (Opcional, para fechar o ecossistema)
-- ============================================================================
INSERT INTO public.playlists (title, description, is_public, user_id, is_match_playlist) VALUES
('Chill Noite', 'Músicas para relaxar', true, 1, false),
('Match Semanal', 'Playlist gerada pelo algoritmo Blend', false, 2, true);

INSERT INTO public.playlist_tracks (playlist_id, track_id, track_order) VALUES
(1, 6, 1),
(1, 7, 2);

INSERT INTO public.user_saved_tracks (user_id, track_id) VALUES
(1, 1),
(1, 2),
(3, 6);
