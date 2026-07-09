-- modificacao necessaria para ter uma playlist blend do spotify
ALTER TABLE playlists
ADD COLUMN is_match_playlist BOOLEAN DEFAULT FALSE;

CREATE TYPE match_status AS ENUM ('pending', 'accepted', 'declined');

CREATE TABLE user_matches (
    match_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_1_id INT NOT NULL, -- o usuario que enviou o convite
    user_2_id INT NOT NULL, -- o usuario que recebeu o convite
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
