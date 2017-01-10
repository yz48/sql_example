select H2.name
from Highschooler H1, Highschooler H2, Friend
where H1.ID = Friend.ID1
and H1.name = 'Gabriel'
and H2.ID = Friend.ID2;
