-- Question 1
-- Find the names of all reviewers who rated Gone with the Wind.
select name
from Reviewer
where rID in(select distinct rID 
             from Rating 
             where mID = (select mID from Movie where title = 'Gone with the Wind'))

select distinct Reviewer.name
from Reviewer, Rating, Movie
where Reviewer.rID = Rating.rID and Movie.mID = Rating.mID and Movie.title = 'Gone with the Wind'

-- Question 2
-- For any rating where the reviewer is the same as the director of the movie, return the reviewer name, movie title, and number of stars.
select Reviewer.name, Movie.title, Rating.stars
from Reviewer, Rating, Movie
where Reviewer.rID = Rating.rID and Movie.mID = Rating.mID and Movie.director = Reviewer.name


-- Question 3
-- Return all reviewer names and movie names together in a single list, alphabetized.  (Sorting by the first name of the reviewer and first word in the title is fine; no need for special processing on last names or removing "The".)
select name from Reviewer
union
select title from Movie 

select name
from (select name
      from Reviewer
      union
      select title as name
      from Movie) as Name
order by name


-- Question 4
-- Find the titles of all movies not reviewed by Chris Jackson.
select title
from Movie
except
select title
from Reviewer, Rating, Movie
where Reviewer.rID = Rating.rID and Movie.mID = Rating.mID and name = 'Chris Jackson'

select title
from Movie
where mID not in(select mID
                 from Reviewer, Rating
                 where Reviewer.rID = Rating.rID and name = 'Chris Jackson')
                 
 -- Question 5
-- For all pairs of reviewers such that both reviewers gave a rating to the same movie, return the names of both reviewers. Eliminate duplicates, don't pair reviewers with themselves, and include each pair only once. For each pair, return the names in the pair in alphabetical order.
select distinct RR1.name, RR2.name
from Rating R1, Rating R2, Reviewer RR1, Reviewer RR2
where R1.mID = R2.mID and R1.rID <> R2.rID and RR1.rID = R1.rID and RR2.rID = R2.rID and RR1.name < RR2.name

-- Question 6
-- For each rating that is the lowest (fewest stars) currently in the database, return the reviewer name, movie title, and number of stars.
select name, title, stars
from Reviewer, Movie, Rating
where stars = ( select min(stars) from Rating)
and Reviewer.rID = Rating.rID 
and Rating.mID = Movie.mID
