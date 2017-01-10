-- Question 1
-- find the titles of all movies directed by steven spielberg
select title
from Movie
where director='Steven Spielberg'

-- Question 2
-- Find all years that have a movie that received a rating of 4 or 5, 
-- and sort them in increasing order. 

select distinct year
from Movie, Rating
where Rating.mID = Movie.mID and stars >= 4
order by year

select distinct year
from movie
where mID in 
            (select mID
             from Rating
             where stars >= 4)
order by year

-- Question 3
-- Find the titles of all movies that have no ratings.
select title
from Movie
where mID not in (select mID 
                  from Rating)

select title
from Movie left join Rating Using (mID)
where rID is null

-- Question 4
-- Some reviewers didn't provide a date with their rating. 
-- Find the names of all reviewers who have ratings with a NULL value for the date. 
select distinct name
from Reviewer join Rating using (rID)
where ratingDate is null

select name
from reviewer
where rID in (select rID
              from rating 
              where ratingDate is null)
              
-- Question 5

-- Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. 
-- Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars. 
