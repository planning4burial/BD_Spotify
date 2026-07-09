-- 1. Atualizar a tabela de usuários (users)
ALTER TABLE users 
ADD COLUMN IF NOT EXISTS plan_type spotify_plan DEFAULT 'free',
ADD COLUMN IF NOT EXISTS account_creation_date DATE DEFAULT CURRENT_DATE;


-- 2. Atualizar a tabela de álbuns (albums)
ALTER TABLE albums 
ADD COLUMN IF NOT EXISTS genre VARCHAR(255);


-- 3. Atualizar a tabela de playlists (playlists)
ALTER TABLE playlists 
ADD COLUMN IF NOT EXISTS is_match_playlist BOOLEAN DEFAULT FALSE;


-- 4. Criar a tabela de histórico de reprodução (user_track_playback)
CREATE TABLE IF NOT EXISTS user_track_playback (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    track_id INT NOT NULL,
    user_id INT NOT NULL,
    
    CONSTRAINT fk_playback_track FOREIGN KEY (track_id) REFERENCES tracks(track_id) ON DELETE CASCADE,
    CONSTRAINT fk_playback_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);


-- Usamos um bloco DO para evitar erros caso o tipo já exista no banco remoto
DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'match_status') THEN
        CREATE TYPE match_status AS ENUM ('pending', 'accepted', 'declined');
    END IF;
END $$;


-- 6. Criar a tabela de gerenciamento do Match (user_matches)
CREATE TABLE IF NOT EXISTS user_matches (
    match_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_1_id INT NOT NULL,
    user_2_id INT NOT NULL,
    status match_status DEFAULT 'pending',
    playlist_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_match_user_1 FOREIGN KEY (user_1_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_match_user_2 FOREIGN KEY (user_2_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_match_playlist FOREIGN KEY (playlist_id) REFERENCES playlists(playlist_id) ON DELETE SET NULL,
    
    CONSTRAINT chk_different_users CHECK (user_1_id <> user_2_id),
    CONSTRAINT unique_user_pair UNIQUE (user_1_id, user_2_id)
);
