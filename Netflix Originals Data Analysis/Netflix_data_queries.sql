create schema platform;
use platform;
select * from netflix;
select * from genre_name;
alter table genre rename to genre_name;
--  What are the average IMDb scores for each genre of Netflix Originals?
select g.genre, round(avg(n.imdbscore),2) avg_imdb from netflix n inner join genre_name g on n.genreid = g.genreid group by g.genre order by g.genre;
--  Which genres have an average IMDb score higher than 7.5?
select g.genre, round(avg(n.imdbscore),2) avg_imdb from netflix n inner join genre_name g on n.genreid = g.genreid group by g.genre having round(avg(n.imdbscore),2) > 7.5 order by g.genre;
-- List Netflix Original titles in descending order of their IMDb scores.
select title, imdbscore from netflix order by imdbscore desc;
-- Retrieve the top 10 longest Netflix Originals by runtime.
select * from netflix order by runtime desc limit 10;
-- Retrieve the titles of Netflix Originals along with their respective genres
select n.title, g.genre from netflix n inner join genre_name g on n.genreid = g.genreid order by g.genre; 
-- Rank Netflix Originals based on their IMDb scores within each genre
select n.title, g.genre, n.imdbscore, rank() over (partition  by g.genre order by n.imdbscore) as rankIMDB from netflix n inner join genre_name g on n.genreid = g.genreid order by g.genre; 
-- Which Netflix Originals have IMDb scores higher than the average IMDb score of all titles?
select title, imdbscore from netflix where imdbscore > (select avg(imdbscore) from netflix);
-- How many Netflix Originals are there in each genre?
select g.genre, count(n.title) title_count from netflix n join genre_name g on n.genreid = g.genreid group by g.genre order by title_count;
-- Which genres have more than 5 Netflix Originals with an IMDb score higher than 8?
select g.genre, count(n.title) title_count from netflix n join genre_name g on n.genreid = g.genreid where n.title > 5 and imdbscore > 8 group by g.genre order by title_count;
-- What are the top 3 genres with the highest average IMDb scores, and how many Netflix Originals do they have?
select g.genre, max(imdbscore) max_imdb, count(n.title) title_count from netflix n join genre_name g on n.genreid = g.genreid group by g.genre order by max_imdb desc limit 3;