-- Question 1
-- find the titles of all movies directed by steven spielberg
select title
from Movie
where director='Steven Spielberg';

-- Question 2
-- Find all years that have a movie that received a rating of 4 or 5, 
-- and sort them in increasing order. 

select distinct year
from Movie, Rating
where Rating.mID = Movie.mID and stars >= 4
order by YEar;
