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
