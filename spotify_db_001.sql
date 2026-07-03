CREATE TABLE artists (
    artist_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    bio TEXT,
    verified BOOLEAN DEFAULT FALSE,
    profile_image_url VARCHAR(512),
);

CREATE TABLE users (
    user_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    country_code CHAR(2) NOT NULL,
    date_of_birth DATE NOT NULL,
);


CREATE TABLE albums (
    album_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_date DATE NOT NULL,
    cover_art_url VARCHAR(512),
    artist_id INT,
    CONSTRAINT fk_artist FOREIGN KEY (artist_id) REFERENCES artists(artist_id) ON DELETE SET NULL,
);


CREATE TABLE tracks (
    track_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    duration_seconds INT NOT NULL,
    explicit BOOLEAN DEFAULT FALSE,
    audio_file_url VARCHAR(512) NOT NULL,
    album_id INT NOT NULL,
    playback_count INT DEFAULT 0,
    CONSTRAINT fk_album FOREIGN KEY (album_id) REFERENCES albums(album_id) ON DELETE CASCADE
);


CREATE TABLE track_artists (
    track_id INT,
    artist_id INT,
    is_primary_artist BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (track_id, artist_id),
    CONSTRAINT fk_track FOREIGN KEY (track_id) REFERENCES tracks(track_id) ON DELETE CASCADE,
    CONSTRAINT fk_artist FOREIGN KEY (artist_id) REFERENCES artists(artist_id) ON DELETE CASCADE
);

CREATE TABLE playlists (
    playlist_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    is_public BOOLEAN DEFAULT TRUE,
    user_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE playlist_tracks (
    playlist_id INT,
    track_id INT,
    track_order INT NOT NULL,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (playlist_id, track_id),
    CONSTRAINT fk_playlist FOREIGN KEY (playlist_id) REFERENCES playlists(playlist_id) ON DELETE CASCADE,
    CONSTRAINT fk_track FOREIGN KEY (track_id) REFERENCES tracks(track_id) ON DELETE CASCADE
);
