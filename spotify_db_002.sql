-- Spotify 002: Adicionar Gênero, Status PRemium e Funcionalidade de Músicas Salvas(Gostadas) --

-- 1. Adicionar o a coluna genre para a tabela de albums -- 
ALTER TABLE albums
ADD COLUMN genre VARCHAR(50);

-- 2. Adicionar o coluna de status premium para a tabela de usuário --
-- O DEFAULT é falso pois o tier gratuito é o padrão. --
ALTER TABLE users
ADD COLUMN is_premium BOOLEAN DEFAULT FALSE;

-- 3. Adicionar tabela de músicas salvas --
CREATE TABLE user_saved_tracks (
    user_id INT,
    track_id INT,
    saved_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, track_id),
    CONSTRAINT fk_saved_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_saved_track FOREIGN KEY (track_id) REFERENCES tracks(track_id) ON DELETE CASCADE
);