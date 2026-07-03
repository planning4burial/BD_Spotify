-- TOCAR UMA MÚSICA -- 
-- Quando um usuário aperta PLAY, o spotify registra a tocagem e adiciona no playback count. --
UPDATE tracks 
SET playback_count = playback_count + 1 
WHERE track_id = 5;

-- TELA DE MÚSICA TOCANDO --
-- Quando uma música toca, o spotify retorna o nome da música, os artistas e a arte do album. --
SELECT 
    t.title AS track_name, 
    a.name AS artist_name, 
    al.title AS album_name, 
    al.cover_art_url
FROM tracks t
INNER JOIN track_artists ta ON t.track_id = ta.track_id
INNER JOIN artists a ON ta.artist_id = a.artist_id
INNER JOIN albums al ON t.album_id = al.album_id
WHERE t.track_id = 5;

-- SIMULAÇÃO BARRA DE PESQUISA --
-- Quando o usuário digita algo na barra de pequisa, o spotify busca com base em regex do que você digitou --
SELECT t.title, t.duration_seconds
FROM tracks t
WHERE t.title LIKE '%Sun%'
ORDER BY t.playback_count DESC
LIMIT 10;

-- PERFIL DO ARTISTA --
-- Quando o usuário clica no nome do artista, você vê os albums ordenados por data de lançamento --
SELECT title, release_date, cover_art_url
FROM albums
WHERE artist_id = 1
ORDER BY release_date DESC;

-- TOCAR PLAYLIST --
-- Quando o usuário abre uma playlist, spotify faz uma busca pra saber a exata ordem que o usuário montou -- 
SELECT t.title, t.duration_seconds, t.explicit
FROM playlists p
INNER JOIN playlist_tracks pt ON p.playlist_id = pt.playlist_id
INNER JOIN tracks t ON pt.track_id = t.track_id
WHERE p.playlist_id = 2
ORDER BY pt.track_order;

-- BUSCAR COM MODO PARA MENORES DE 18 --
-- Usuários podem desligar conteúdo explicito, o spotify só adiciona a condição explicit = false --
SELECT t.title, a.name
FROM tracks t
INNER JOIN track_artists ta ON t.track_id = ta.track_id
INNER JOIN artists a ON ta.artist_id = a.artist_id
WHERE t.explicit = FALSE
ORDER BY t.playback_count DESC
LIMIT 20;


-- SIMULAR MAIS TOCADAS --
FROM tracks
ORDER BY playback_count DESC
LIMIT 50;

-- DISCOVER DE ARTISTAS --
-- Encontrar os artistas com maiores quantidades de música --
SELECT a.name, COUNT(t.track_id) AS total_tracks
FROM artists a
INNER JOIN track_artists ta ON a.artist_id = ta.artist_id
INNER JOIN tracks t ON ta.track_id = t.track_id
GROUP BY a.artist_id, a.name
ORDER BY total_tracks DESC;

-- ENCONTRANDO PLAYLISTS GRANDES PARA AUTOPLAY --
-- Spotify permite buscar playlists grandes com altas quantidades de música --
SELECT p.title, COUNT(pt.track_id) AS number_of_tracks
FROM playlists p
INNER JOIN playlist_tracks pt ON p.playlist_id = pt.playlist_id
GROUP BY p.playlist_id, p.title
HAVING COUNT(pt.track_id) > 50;