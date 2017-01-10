-- Question 1
-- Find the names of all students who are friends with someone named Gabriel.

select name
from Highschooler, Friend 
where ID1 = ID and ID2 in (select ID from Highschooler where name = 'Gabriel')

-- Question 2
-- For every student who likes someone 2 or more grades younger than themselves, return that student's name and grade, and the name and grade of the student they like.

select H1.name, H1.grade, H2.name, H2.grade
from Highschooler H1, Likes, Highschooler H2
where H1.ID = Likes.ID1 and H2.ID = Likes.ID2 and H1.grade-2 >= H2.grade

-- Question 3
-- For every pair of students who both like each other, return the name and grade of both students. Include each pair only once, with the two names in alphabetical order.
select H1.name, H1.grade, H2.name, H2.grade
from Likes L1, Likes L2, Highschooler H1, Highschooler H2
where L1.ID1 = L2.ID2 and L1.ID2 = L2.ID1 and H1.ID = L1.ID1 and H2.ID = L1.ID2 and H1.name < H2.name

-- Question 4
-- Find names and grades of students who only have friends in the same grade. Return the result sorted by grade, then by name within each grade.
select H1.name, H1.grade
from Friend F1, Highschooler H1, Highschooler H2
where H1.ID = F1.ID1 and H2.ID = F1.ID2
group by H1.ID
having max(H2.grade) = H1.grade and min(H2.grade) = H1.grade
order by H1.grade, H1.name

select name, grade
from Highschooler, (
  select ID1 from Friend
  except
  select ID1
  from Friend, Highschooler H1, Highschooler H2
  where Friend.ID1 = H1.ID
  and Friend.ID2 = H2.ID
  and H1.grade <> H2.grade
) as SameGrade
where SameGrade.ID1 = Highschooler.ID
order by grade, name

select name,grade
from Highschooler H1
where not exists (
select * from Highschooler H2, Friend F
where H2.ID = F.ID2 and H1.ID = F.ID1 and H2.grade <> H1.grade)
order by grade, name

-- Question 5
-- Find the name and grade of all students who are liked by more than one other student. 
select name, grade 
from Highschooler
where ID in (select ID2
from Likes
group by ID2
having count(distinct ID1) > 1)
