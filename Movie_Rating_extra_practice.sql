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
select distinct name, title, stars
