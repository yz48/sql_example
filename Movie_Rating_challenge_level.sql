-- Question 1
-- For each movie, return the title and the 'rating spread', that is, the difference between highest and lowest ratings given to that movie. Sort by rating spread from highest to lowest, then by movie title. 

select title, spread
from Movie, (select mID, max(stars)-min(stars) as spread
             from Rating
             group by mID) T
where Movie.mID = T.mID
order by spread DESC, title


-- Question 2
-- Find the difference between the average rating of movies released before 1980 and the average rating of movies released after 1980. (Make sure to calculate the average rating for each movie, then the average of those averages for movies before 1980 and movies after. Don't just calculate the overall average rating before and after 1980.) 

select avg(before_80.group_avg) - avg(post_80.group_avg)
from (select avg(stars) as group_avg
      from Rating, Movie
      where Rating.mID = Movie.mID
      and year <= 1980
      group by Rating.mID) as before_80,
      (select avg(stars) as group_avg
       from Rating, Movie
       where Rating.mID = Movie.mID
       and year > 1980
       group by Rating.mID) as post_80
       
-- Question 3
-- Some directors directed more than one movie. For all such directors, return the titles of all movies directed by them, along with the director name. Sort by director name, then movie title. (As an extra challenge, try writing the query both with and without COUNT.) 

select distinct M1.title, M1.director
from Movie M1, Movie M2
where M1.director = M2.director and M1.title <> M2.title
order by M1.director, M1.title

select Movie.title, Movie.director
from Movie, (select director, count(mID) as num
             from Movie
             group by director) as MovieCount
where Movie.director = MovieCount.director
and num >= 2
order by Movie.director, Movie.title


-- Question 4
-- Find the movie(s) with the highest average rating. Return the movie title(s) and average rating. 
-- (Hint: This query is more difficult to write in SQLite than other systems; you might think of it as finding the highest average rating and then choosing the movie(s) with that average rating.) 
select title, group_avg
from Movie, (select max(group_avg) as max_avg
             from Movie, (select mID, avg(stars) as group_avg
                          from Rating
                          group by mID) as GroupRating
             where GroupRating.mID = Movie.mID) as MaxRating,
             (select mID, avg(stars) as group_avg
              from Rating
              group by mID) as GroupRating
where GroupRating.group_avg = MaxRating.max_avg and Movie.mID = GroupRating.mID

select m.title, avg(r.stars) as strs 
from rating r join movie m on m.mid = r.mid 
group by r.mid
having strs = (select max(s.stars) as stars from (select mid, avg(stars) as stars from rating
group by mid) as s)

-- Question 5
-- Find the movie(s) with the lowest average rating. Return the movie title(s) and average rating. 
-- (Hint: This query may be more difficult to write in SQLite than other systems; you might think of it as finding the highest average rating and then choosing the movie(s) with that average rating.)
select title, group_avg
from Movie, (select min(group_avg) as min_avg
             from Movie, (select mID, avg(stars) as group_avg
                          from Rating
                          group by mID) as GroupRating
             where GroupRating.mID = Movie.mID) as MinRating,
             (select mID, avg(stars) as group_avg
              from Rating
              group by mID) as GroupRating
where GroupRating.group_avg = MinRating.max_avg and Movie.mID = GroupRating.mID

select m.title, avg(r.stars) as strs 
from rating r join movie m on m.mid = r.mid 
group by r.mid
having strs = (select min(s.stars) as stars from (select mid, avg(stars) as stars from rating
group by mid) as s)

-- Question 6
-- For each director, return the director's name together with the title(s) of the movie(s) they directed that received the highest rating among all of their movies, and the value of that rating. Ignore movies whose director is NULL. 
select title, max(stars) as max_star, director
from Movie, Rating
where Movie.mID = Rating.mID and director is not NULL
group by director

select distinct Movie.director, title, max_star
from Movie, Rating, (select max(stars) as max_star, director
                     from Movie, Rating
                     where Movie.mID = Rating.mID and director is not NULL
                     group by director) T
where Movie.mID = Rating.mID and Rating.stars = T.max_star and T.director = Movie.director

