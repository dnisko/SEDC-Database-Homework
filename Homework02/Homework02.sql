--HOMEWORK REQUIREMENTS
USE SEDCHome

--● Calculate the count of all grades per Teacher in the system
SELECT Count(g.Grade) as [Total Grades Per Teacher]
FROM Grade as g INNER JOIN Teacher as t
ON g.TeacherID = t.ID
WHERE g.Grade <> '*'

--● Calculate the count of all grades per Teacher in the system for first 100 Students (ID < 100)
SELECT Count(g.Grade) as [Total Grades Per Teacher For First 100 Students]
FROM Grade as g INNER JOIN Teacher as t
ON g.TeacherID = t.ID
WHERE g.Grade <> '*' and g.StudentID <= 100

--● Find the Maximal Grade, and the Average Grade per Student on all grades in the system
SELECT Max(g.Grade) as [Max Grade], Avg(convert(int, g.Grade)) as [Average Grade], s.FirstName as [Student FirstName], s.LastName as [Student LastName]
FROM Grade as g INNER JOIN Student as s
ON g.StudentID = s.ID
WHERE g.Grade <> '*'
GROUP BY s.FirstName, s.LastName

--● Calculate the count of all grades per Teacher in the system and filter only grade count greater then 200
SELECT Count(g.Grade) as [Grades per Teacher Grater Than 200], t.FirstName as [Teacher FirstName], t.LastName as [Teacher LastName]
FROM Grade as g INNER JOIN Teacher as t
ON g.TeacherID = t.ID
GROUP BY t.FirstName, t.LastName
HAVING Count(g.Grade) > 200
ORDER BY [Grades per Teacher Grater Than 200] DESC

--● Find the Grade Count, Maximal Grade, and the Average Grade per Student on all grades in the system. Filter only records where Maximal Grade is equal to Average Grade
SELECT Count(g.Grade) as [Total Grades], Max(g.Grade) as [Max Grade], Avg(convert(int, g.Grade)) as [Average Grade]
FROM Grade as g INNER JOIN Student as s
ON g.StudentID = s.ID
WHERE g.Grade <> '*'
GROUP BY s.ID
HAVING Max(g.Grade) = Avg(convert(int, g.Grade))

--● List Student First Name and Last Name next to the other details from previous query
SELECT Count(g.Grade) as [Total Grades], Max(g.Grade) as [Max Grade], Avg(convert(int, g.Grade)) as [Average Grade], s.FirstName as [Student FirstName], s.LastName as [Student LastName]
FROM Grade as g INNER JOIN Student as s
ON g.StudentID = s.ID
WHERE g.Grade <> '*'
GROUP BY s.FirstName, s.LastName
HAVING Max(g.Grade) = Avg(convert(int, g.Grade))

--● Create new view (vv_StudentGrades) that will List all StudentIds and count of Grades per student
CREATE VIEW vv_StudentGrades
AS
SELECT s.ID, Count(g.Grade) as [Grades per Student]
FROM Grade as g INNER JOIN Student as s
ON g.StudentID = s.ID
GROUP BY s.ID
--● Change the view to show Student First and Last Names instead of StudentID
ALTER VIEW vv_StudentGrades
AS
SELECT s.FirstName, s.LastName, Count(g.Grade) as [Grades per Student]
FROM Grade as g INNER JOIN Student as s
ON g.StudentID = s.ID
GROUP BY s.FirstName, s.LastName
--● List all rows from view ordered by biggest Grade Count
SELECT *
FROM vv_StudentGrades
ORDER BY [Grades per Student] DESC