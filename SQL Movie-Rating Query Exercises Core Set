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

select R1.name, M.title, R2.stars, R2.ratingDate
from Movie M, Reviewer R1, Rating R2
where M.mID = R2.mID and R1.rID = r2.rID
order by R1.name, M.title, R2.stars

-- Question 6
-- For all cases where the same reviewer rated the same movie twice and 
-- gave it a higher rating the second time, return the reviewer's name and the title of the movie.
select Reviewer.name, Movie.title
from Movie, Reviewer, Rating R1 join Rating R2 on R1.rID = R2.rID and R1.mID = R2.mID 
and Movie.mID = R1.mID and Reviewer.rID = R1.rID
where R1.ratingDate < R2.ratingDate and R2.stars > R1.stars

select Reviewer.name, Movie.title
from Movie, Reviewer, (select R1.rID, R1.mID
                       from Rating R1 join Rating R2 on R1.rID = R2.rID and R1.mID = R2.mID 
                       where R1.ratingDate < R2.ratingDate and R2.stars > R1.stars) T
where Movie.mID = T.mID and Reviewer.rID = T.rID


-- Question 7
-- For each movie that has at least one rating, 
-- find the highest number of stars that movie received. 
-- Return the movie title and number of stars. Sort by movie title. 
select title, max(stars)
from Rating join Movie using (mID)
group by mID
order by title


select title, stars
from Movie M, (select mID, stars
               from Rating join Movie using (mID)
               except
               select R1.mID, R1.stars
               from Rating R1 join Rating R2 on R1.mID = R2.mID 
               where R1.stars < R2.stars) T
               where M.mID = T.mID
order by title


-- Question 8
-- List movie titles and average ratings, 
-- from highest-rated to lowest-rated. 
-- If two or more movies have the same average rating, list them in alphabetical order. 
select title, avg(stars)
from Rating join Movie using (mID)
group by mID
order by avg(stars) desc, title

select title, average
from Movie, (select mID, avg(stars) as average
             from Rating
             group by mID) T
where Movie.mID = T.mID
order by average desc, title


-- Question 9
-- Find the names of all reviewers who have contributed three or more ratings. 
-- (As an extra challenge, try writing the query without HAVING or without COUNT.) 
select name
from Reviewer, (select rID
                from Rating
                group by rID
                having count(*) >= 3) T
where T.rID = Reviewer.rID

select name
from Reviewer, (select distinct R1.rID
                from Rating R1, Rating R2, Rating R3
                where R1.rID = R2.rID and (R1.mID <> R2.mID or R1.ratingDate <> R2.ratingDate)
                and R1.rID = R3.rID and (R1.mID <> R3.mID or R1.ratingDate <> R3.ratingDate)
                and R3.rID = R2.rID and (R3.mID <> R2.mID or R3.ratingDate <> R2.ratingDate)) T
where Reviewer.rID = T.rID
