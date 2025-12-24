USE IMDB;

DROP VIEW IF EXISTS v_Movie_Oscar_Summary;
DROP TABLE IF EXISTS v_Movie_Oscar_Summary;

CREATE OR REPLACE VIEW v_Movie_Oscar_Summary AS
SELECT 
    M.idMovie,
    M.Title,
    N.NumOscarNominations AS TotalNominations,
    COUNT(O.idOscarAwards) AS TotalWins
FROM Movie AS M
JOIN Nominations AS N
  ON M.idMovie = N.Movie_idMovie
LEFT JOIN Oscar_Awards AS O
  ON O.NominationEvent_idNominationEvent = N.idNominationEvent
GROUP BY M.idMovie, M.Title, N.NumOscarNominations;
-- Movies ordered by total Oscar wins
SELECT *
FROM v_Movie_Oscar_Summary
ORDER BY TotalWins DESC;


-- ============================================
-- View: Profit per Movie (Revenue - Budget)
-- ============================================
DROP VIEW IF EXISTS v_Movie_Profit;

CREATE VIEW v_Movie_Profit AS
SELECT
    Title,
    FORMAT(Revenue - Budget, 0) AS Profit   -- e.g. 1,234,567
FROM Movie;

SELECT * FROM v_Movie_Profit;



