CREATE DATABASE jiohotstar;
USE jiohotstar;
CREATE TABLE jiohotstar_details(
 JioHotstar_id BIGINT,
 Title VARCHAR(100),
 Description_detail TEXT,
 Genre VARCHAR(50),
 Release_year INT,
 age_rating VARCHAR(20),
 Running_time INT,
 content_Type VARCHAR(20)
 );
 

 -- SECTION 1: DATA VALIDATION
 -- Q.1 What is the total number of records in the dataset?
SELECT count(*) AS total
FROM jiohotstar_details;

--  Q.2 Are there any NULL values in key columns (Title, Genre, Release_year, age_rating, Running_time, content_Type)? If yes, how many per column?
SELECT 
SUM(CASE WHEN jiohotstar_id IS NULL THEN 1 ELSE 0 END) AS null_jiohotstar_id,
SUM(CASE WHEN Title IS NULL THEN 1 ELSE 0 END) AS null_Title,
SUM(CASE WHEN Description_detail IS NULL THEN 1 ELSE 0 END) AS null_Description_detail,
SUM(CASE WHEN Genre IS NULL THEN 1 ELSE 0 END) AS null_Genre,
SUM(CASE WHEN Release_year IS NULL THEN 1 ELSE 0 END) AS null_Release_year,
SUM(CASE WHEN age_rating IS NULL THEN 1 ELSE 0 END) AS null_age_rating,
SUM(CASE WHEN Running_time IS NULL THEN 1 ELSE 0 END) AS null_Running_time,
SUM(CASE WHEN content_Type IS NULL THEN 1 ELSE 0 END) AS null_content_Type
FROM jiohotstar_details;

-- Q.3 Are there any duplicate titles in the dataset?
SELECT Title,count(*) AS occurance
FROM jiohotstar_details
GROUP BY Title
HAVING count(*)>1
ORDER BY occurance DESC;

SELECT Title, Genre,Release_year, content_Type
FROM jiohotstar_details
WHERE Title IN(
        SELECT Title 
        FROM jiohotstar_details
        GROUP BY Title 
        HAVING count(*)>1
        )
ORDER BY Title;

--  Q.4 How many distinct content types exist, and what are they?
SELECT  DISTINCT content_type, COUNT(content_Type)
FROM jiohotstar_details
GROUP BY content_Type;
        
--  Q.5 How many distinct genres exist in the dataset?
SELECT  DISTINCT Genre, count(genre)
FROM jiohotstar_details
GROUP BY Genre; 

--  Q.6 What is the minimum and maximum release year present in the data?
SELECT MIN(Release_year) AS min_year, MAX(Release_year) AS max_year
FROM jiohotstar_details;

-- Q.7 Are there any records with unrealistic or invalid running times (e.g., 0 or negative)?
SELECT Title, content_Type,Running_time
FROM jiohotstar_details
WHERE Running_time <= 0 OR Running_time IS NULL
ORDER BY Running_time;


                         -- SECTION : B BASIC BUSINESS ANALYSIS
                         
-- Q.8 What is the total count of Movies vs TV Shows?   
-- Answer: Same as Q4 — refer to Q4's result. Dataset has only 2 content 
-- types, so Q4's query already answers this.
                      
-- Q.9 Which are the top 10 genres by number of titles?
SELECT Genre, COUNT(Title) AS number_of_title
FROM jiohotstar_details
GROUP BY Genre
ORDER BY number_of_title DESC
LIMIT 10;

-- Q.10 How many titles exist for each age rating category?
SELECT age_rating, COUNT(Title) AS Title
FROM jiohotstar_details
GROUP BY age_rating
ORDER BY age_rating ASC;

-- Q.11 Which release year has the highest number of titles?
SELECT Release_year, COUNT(Title) AS  higHest_number_of_title
FROM jiohotstar_details
GROUP BY Release_year
ORDER BY higHest_number_of_title DESC
LIMIT 1;

-- Q.12What is the average running time of all movies?
SELECT AVG(Running_time) AS Runnig_time
FROM jiohotstar_details
WHERE  content_type = "movie" ;

-- Q.13 What is the average running time of TV Shows (if applicable)? 
SELECT content_Type, AVG(Running_time) AS Runnig_time
FROM jiohotstar_details
WHERE  content_type = "Tv";

-- Q.14  How many titles were released each year?
SELECT Release_year, COUNT(Title) AS number_of_title
FROM jiohotstar_details
GROUP BY Release_year;

                                 -- SECTION C INTERMEDIATE SQL
-- Q.15 What are the 10 longest movies by running time?
SELECT Title, Running_time
FROM jiohotstar_details
WHERE  content_type = "movie"
ORDER BY Running_time DESC
LIMIT 10;                                  
 
 -- Q.16 What are the 10 shortest movies by running time?
SELECT Title, Running_time
FROM jiohotstar_details
WHERE  content_type = "movie"
ORDER BY Running_time ASC
LIMIT 10;

-- Q.17 How many titles were released in the last 5 years?
SELECT COUNT(*) AS total_titles
FROM jiohotstar_details
WHERE Release_year >= (SELECT MAX(Release_year) FROM jiohotstar_details) - 5 ;
 


-- Q.18 Which genres have more than 100 titles? 
SELECT Genre, COUNT(Title) AS Total_titles
FROM jiohotstar_details
GROUP BY Genre
HAVING COUNT(Title) >100;
 
-- Q.19 What is the average running time by genre, for movies only?
SELECT Genre, AVG(Running_time) AS AVG_RUNNING_TIME
FROM jiohotstar_details
WHERE content_Type="movie"
GROUP BY Genre;

-- Q.20 Which genres appear only in Movies but not in TV Shows (or vice versa)?
SELECT DISTINCT Genre
FROM jiohotstar_details
WHERE content_Type="movie"
AND Genre NOT IN (
         SELECT DISTINCT Genre FROM jiohotstar_details WHERE content_Type="Tv"
);


 -- Q.21 How many movies have a running time greater than the overall average running time?
SELECT COUNT(*) AS movies_above_avg
FROM jiohotstar_details
WHERE Running_time > (SELECT AVG(Running_time) FROM jiohotstar_details WHERE content_Type="movie")
AND content_Type ="movie";


-- Q.22 What is the single most popular genre (highest count)?
SELECT Genre, COUNT(Title) AS total_titles
FROM jiohotstar_details
GROUP BY Genre
ORDER BY total_titles DESC
LIMIT 1; 


-- Q.23 Which content type (Movie/TV Show) has more titles for each age rating?
 SELECT age_rating, content_Type, COUNT(Title) AS total_titles
FROM jiohotstar_details
GROUP BY age_rating, content_Type
ORDER BY age_rating, content_Type;
 


                                    --  SECTION : D
-- Q.24 Rank all genres by total number of titles, from highest to lowest.
  WITH genre_count AS (
    SELECT Genre, COUNT(*) AS total_titles
    FROM jiohotstar_details
    GROUP BY Genre
)
SELECT Genre, total_titles,
       RANK() OVER (ORDER BY total_titles DESC) AS genre_rank
FROM genre_count;

                                  
-- Q.25 Calculate the year-over-year change in number of titles released.
WITH yearly_counts AS (
    SELECT Release_year, COUNT(*) AS titles_released
    FROM jiohotstar_details
    GROUP BY Release_year
)
SELECT Release_year, titles_released,
       LAG(titles_released) OVER (ORDER BY Release_year) AS prev_year_titles,
       titles_released - LAG(titles_released) OVER (ORDER BY Release_year) AS yoy_change
FROM yearly_counts
ORDER BY Release_year;

-- Q.26 Find the top 3 longest movies within each genre.
WITH ranked_movies AS (
    SELECT Title, Genre, Running_time,
           ROW_NUMBER() OVER (PARTITION BY Genre ORDER BY Running_time DESC) AS rn
    FROM jiohotstar_details
    WHERE content_Type = 'movie'
)
SELECT Genre, Title, Running_time
FROM ranked_movies
WHERE rn <= 3
ORDER BY Genre, Running_time DESC;

-- Q.27 Calculate a running total of titles released, ordered by year.
WITH yearly_counts AS (
    SELECT Release_year, COUNT(*) AS titles_released
    FROM jiohotstar_details
    GROUP BY Release_year
)
SELECT Release_year, titles_released,
       SUM(titles_released) OVER (ORDER BY Release_year) AS running_total
FROM yearly_counts
ORDER BY Release_year;

-- Q.28 Calculate each genre's percentage share of total content.
WITH genre_count AS (
    SELECT Genre, COUNT(*) AS total_titles
    FROM jiohotstar_details
    GROUP BY Genre
)
SELECT Genre, total_titles,
       ROUND(total_titles * 100.0 / SUM(total_titles) OVER (), 2) AS pct_share
FROM genre_count
ORDER BY pct_share DESC;

-- Q.29 For each release year, rank genres by popularity within that year specifically.
WITH yearwise_genre_count AS (
    SELECT Release_year, Genre, COUNT(*) AS total_titles
    FROM jiohotstar_details
    GROUP BY Release_year, Genre
)
SELECT Release_year, Genre, total_titles,
       RANK() OVER (PARTITION BY Release_year ORDER BY total_titles DESC) AS genre_rank_in_year
FROM yearwise_genre_count
ORDER BY Release_year, genre_rank_in_year;
