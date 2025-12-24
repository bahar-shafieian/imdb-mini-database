USE IMDB;

-- ============================================
-- 1. List of Categories Won for Each Movie
-- ============================================
SELECT 
    M.Title, 
    O.CategoryWon
FROM Movie AS M
JOIN Nominations AS N
  ON M.idMovie = N.Movie_idMovie
JOIN Oscar_Awards AS O
  ON O.NominationEvent_idNominationEvent = N.idNominationEvent
ORDER BY M.Title, O.CategoryWon;


-- ============================================
-- 2. Oscar Categories Per Movie (Grouped)
-- ============================================
SELECT 
    M.Title,
    GROUP_CONCAT(
        O.CategoryWon 
        ORDER BY O.CategoryWon 
        SEPARATOR ', '
    ) AS CategoriesWon
FROM Movie AS M 
JOIN Nominations AS N
  ON M.idMovie = N.Movie_idMovie
JOIN Oscar_Awards AS O
  ON O.NominationEvent_idNominationEvent = N.idNominationEvent
GROUP BY M.idMovie, M.Title
ORDER BY M.Title;


-- ============================================
-- 3. Director of the Highest-Grossing Movie
-- ============================================
SELECT D.FullName AS Director, M.Title, M.Revenue
FROM Director AS D
JOIN Movie AS M
  ON D.Movie_idMovie = M.idMovie
ORDER BY M.Revenue DESC
LIMIT 1;

-- ============================================
-- 4. Average Rating per Genre
-- ============================================
SELECT M.Genre, AVG(R.Rate) AS AvgRating
FROM Movie M
JOIN Ratings R ON M.idMovie = R.Movie_idMovie
GROUP BY M.Genre
ORDER BY AvgRating DESC;

-- ============================================
-- 5. Movies with More than 5 Oscar Wins
-- ============================================
SELECT 
    M.Title,
    COUNT(O.idOscarAwards) AS TotalWins
FROM Movie AS M
JOIN Nominations AS N
  ON M.idMovie = N.Movie_idMovie
JOIN `Oscar_Awards` AS O
  ON O.NominationEvent_idNominationEvent = N.idNominationEvent
GROUP BY M.idMovie, M.Title
HAVING TotalWins > 5
ORDER BY TotalWins DESC;
