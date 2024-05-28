--• Declare scalar variable for storing FirstName values
DECLARE @FirstName nvarchar(50)
--• Assign value ‘Antonio’ to the FirstName variable
SET @FirstName = N'Antonio'
--• Find all Students having FirstName same as the variable
SELECT *
FROM Student
WHERE FirstName = @FirstName

--• Declare table variable that will contain StudentId, StudentName and DateOfBirth
DECLARE @FemaleStudents TABLE (StudentId int, StudentName nvarchar(100), DateOfBirth date)
--• Fill the table variable with all Female students
INSERT INTO @FemaleStudents
SELECT Id, FirstName, DateOfBirth
FROM Student
WHERE Gender = N'F'

SELECT *
FROM @FemaleStudents

--• Declare temp table that will contain LastName and EnrolledDate columns
CREATE TABLE #MaleStudents (LastName nvarchar(150), EnrolledDate date)
--• Fill the temp table with all Male students having First Name starting with ‘A’
INSERT INTO #MaleStudents
SELECT LastName, EnrolledDate
FROM Student
WHERE Gender = N'M' AND LEFT(FirstName, 1) = N'A'
--• Retrieve the students from the table which last name is with 7 characters
SELECT *
FROM #MaleStudents
WHERE LEN(LastName) = 7
--DROP TABLE #MaleStudents

--• Find all teachers whose FirstName length is less than 5 and the first 3 characters of their FirstName and LastName are the same
SELECT *
FROM Teacher
WHERE LEN(FirstName) < 5 AND LEFT(FirstName, 3) = LEFT(LastName, 3)