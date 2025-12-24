USE IMDB;

SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE `Oscar_Awards`;
TRUNCATE TABLE `Nominations`;
TRUNCATE TABLE Ratings;
TRUNCATE TABLE Actor;
TRUNCATE TABLE Director;
TRUNCATE TABLE Movie;

SET FOREIGN_KEY_CHECKS = 1;

-- ============================================
-- Movie
-- ============================================
INSERT INTO Movie (idMovie, Title, Year, Genre, Country, Budget, Revenue) VALUES
(1, 'Fight Club',               1999, 'Drama',     'USA',             63000000, 100853753),
(2, 'The Matrix',               1999, 'Action',    'USA',             63000000, 463517383),
(3, 'Pulp Fiction',             1994, 'Thriller',  'USA',              8000000, 213928762),
(4, 'The Shawshank Redemption', 1994, 'Drama',     'France',          25000000,  28341469),
(5, 'Forrest Gump',             1994, 'Comedy',    'USA',             55000000, 677945399),
(6, 'Titanic',                  1997, 'Drama',     'Canada',         200000000,1845034188),
(7, 'Se7en',                    1995, 'Crime',     'USA',             33000000, 327311859),
(8, 'Gladiator',                2000, 'Action',    'United Kingdom', 103000000, 457640427),
(9, 'The Lion King',            1994, 'Family',    'USA',             45000000, 788241776),
(10,'Toy Story',                1995, 'Animation', 'USA',             30000000, 373554033);

-- ============================================
-- Director   (note: BirthDtae, not BirthDate)
-- ============================================
INSERT INTO Director
  (idDirector, FullName, Country, BirthDtae, NumMoviesDirected, Movie_idMovie)
VALUES
(1,  'David Fincher',        'USA',            '1962-08-28',  9,  1),
(2,  'Lilly Wachowski',      'USA',            '1967-12-29', 13,  2),
(3,  'Quentin Tarantino',    'USA',            '1963-03-27', 11,  3),
(4,  'Frank Darabont',       'France',         '1959-01-28', 15,  4),
(5,  'Robert Zemeckis',      'USA',            '1952-05-14',  8,  5),
(6,  'James Cameron',        'Canada',         '1954-08-16',  7,  6),
(7,  'David Fincher',        'USA',            '1962-08-28',  4,  7),
(8,  'Ridley Scott',         'United Kingdom', '1937-11-30', 16,  8),
(9,  'Roger Allers',         'USA',            '1949-06-29', 14,  9),
(10, 'John Lasseter',        'USA',            '1957-01-12', 10, 10);

-- ============================================
-- Actor  (here the column *is* BirthDate)
-- ============================================
INSERT INTO Actor
  (idActor, FullName, Country, BirthDate, NumOfMoviesActed, Movie_idMovie)
VALUES
(1,  'Edward Norton',            'USA',            '1969-08-18', '35',  1),
(2,  'Keanu Reeves',             'Lebanon',        '1964-09-02', '23',  2),
(3,  'John Travolta',            'USA',            '1954-02-18', '38',  3),
(4,  'Tim Robbins',              'USA',            '1958-10-16', '27',  4),
(5,  'Tom Hanks',                'USA',            '1956-07-09', '32',  5),
(6,  'Kate Winslet',             'United Kingdom', '1975-10-05', '24',  6),
(7,  'Brad Pitt',                'USA',            '1963-12-18', '39',  7),
(8,  'Russell Crowe',            'New Zealand',    '1964-04-07', '34',  8),
(9,  'Jonathan Taylor Thomas',   'USA',            '1981-09-08', '22',  9),
(10, 'Tom Hanks',                'USA',            '1956-07-09', '45', 10);

-- ============================================
-- Ratings  (Rate is DECIMAL(50) with no decimals)
-- ============================================
ALTER TABLE Ratings
MODIFY COLUMN Rate DECIMAL(3,1);

INSERT INTO Ratings (idRatings, NumOfVotes, Rate, Movie_idMovie) VALUES
(1, 9413, 8.3, 1),
(2, 8907, 7.9, 2),
(3, 8428, 8.3, 3),
(4, 8205, 8.5, 4),
(5, 7927, 8.2, 5),
(6, 7562, 7.5, 6),
(7, 5765, 8.1, 7),
(8, 5439, 7.9, 8),
(9, 5376, 8.0, 9),
(10, 5269, 7.7, 10);

-- ============================================
-- Naminations
-- ============================================
INSERT INTO `Nominations`
  (`idNominationEvent`, `NumOscarNominations`,  `Movie_idMovie`)
VALUES
(1,  1,  1),
(2,  4,  2),
(3,  7,  3),
(4,  7,  4),
(5, 13,  5),
(6, 14,  6),
(7,  1,  7),
(8, 12,  8),
(9,  4,  9),
(10, 3, 10);

-- ============================================
-- Oscar Awards
-- ============================================
-- ============================================
-- Oscar Awards  (one row = one category won)
-- ============================================
TRUNCATE TABLE Oscar_Awards;

INSERT INTO Oscar_Awards
  (idOscarAwards, CategoryWon, NominationEvent_idNominationEvent)
VALUES
  -- Movie 1 (NominationEvent 1): no wins → no rows

  -- Movie 2 (NominationEvent 2): 4 wins
  (1,  'Best Picture',                      2),
  (2,  'Best Director',                     2),
  (3,  'Best Actor in a Leading Role',      2),
  (4,  'Best Original Screenplay',          2),

  -- Movie 3 (NominationEvent 3): 1 win
  (5,  'Best Original Screenplay',          3),

  -- Movie 4 (NominationEvent 4): no wins → no rows

  -- Movie 5 (NominationEvent 5): 6 wins
  (6,  'Best Picture',                      5),
  (7,  'Best Director',                     5),
  (8,  'Best Cinematography',               5),
  (9,  'Best Film Editing',                 5),
  (10, 'Best Original Score',               5),
  (11, 'Best Sound Mixing',                 5),

  -- Movie 6 (NominationEvent 6): 11 wins
  (12, 'Best Picture',                      6),
  (13, 'Best Director',                     6),
  (14, 'Best Adapted Screenplay',           6),
  (15, 'Best Film Editing',                 6),
  (16, 'Best Original Score',               6),
  (17, 'Best Sound Mixing',                 6),
  (18, 'Best Sound Editing',                6),
  (19, 'Best Visual Effects',               6),
  (20, 'Best Costume Design',               6),
  (21, 'Best Makeup and Hairstyling',       6),
  (22, 'Best Production Design',            6),

  -- Movie 7 (NominationEvent 7): no wins → no rows

  -- Movie 8 (NominationEvent 8): 5 wins
  (23, 'Best Picture',                      8),
  (24, 'Best Director',                     8),
  (25, 'Best Supporting Actor',             8),
  (26, 'Best Cinematography',               8),
  (27, 'Best Original Score',               8),

  -- Movie 9 (NominationEvent 9): 2 wins
  (28, 'Best Visual Effects',               9),
  (29, 'Best Sound Editing',                9);

  -- Movie 10 (NominationEvent 10): no wins → no rows
