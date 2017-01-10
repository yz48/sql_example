select title, spread
from Movie, (select mID, max(stars)-min(stars) as spread
from Rating
group by mID) T
where Movie.mID = T.mID
order by spread DESC, title
