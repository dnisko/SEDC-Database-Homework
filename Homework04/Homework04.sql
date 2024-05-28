--Homework 02.1
--• Create new procedure called CreateGrade;
--• Procedure should create only Grade header info (not Grade Details);
--• Procedure should return the total number of grades in the system for the Student on input (from the CreateGrade);
--• Procedure should return second resultset with the MAX Grade of all grades for the Student and Teacher on input (regardless the Course).
CREATE PROCEDURE sp_CreateGrade (@StudentId int, @TeacherId int)
AS
BEGIN

SELECT SUM(Grade)
FROM Grade
WHERE StudentID = @StudentId

SELECT MAX(Grade)
FROM Grade
Where StudentId = @StudentId AND TeacherID = @TeacherId

END
EXEC	sp_CreateGrade
		@StudentId = 5,
		@TeacherId = 6
--Homework 02.2
--• Create new procedure called CreateGradeDetail;
--• Procedure should add details for specific Grade (new record for new AchievementTypeID, Points, MaxPoints, Date for specific Grade);
--• Output from this procedure should be resultset with SUM of GradePoints calculated with formula
--AchievementPoints/AchievementMaxPoints*ParticipationRate for specific Grade

CREATE PROCEDURE sp_CreateGradeDetail (@GradeId int, @AchievementTypeID int, @Points int, @MaxPoints int, @Date date)
AS
BEGIN

DECLARE @SumOfGradePoints decimal(18,2);
-- for some reason I had to cast all numbers to decimal and put them in seperate variables...
DECLARE @AchievementPoints decimal(18,2);
DECLARE @AchievementMaxPoints decimal(18,2);
DECLARE @ParticipationRate decimal(18,2);

INSERT INTO GradeDetails (GradeID, AchievementTypeID, AchievementPoints, AchievementMaxPoints, AchievementDate)
VALUES (@GradeId, @AchievementTypeID, @Points, @MaxPoints, @Date)


SELECT @AchievementPoints = CAST(gd.AchievementPoints as decimal(18,2)),
       @AchievementMaxPoints = CAST(gd.AchievementMaxPoints as decimal(18,2)),
       @ParticipationRate = CAST(atype.ParticipationRate as decimal(18,2))
FROM GradeDetails as gd INNER JOIN AchievementType as atype
ON gd.AchievementTypeID = atype.ID
WHERE gd.GradeID = @GradeId AND gd.AchievementTypeID = @AchievementTypeID

SET @SumOfGradePoints = @AchievementPoints / @AchievementMaxPoints * @ParticipationRate;

SELECT @SumOfGradePoints as SumOfGradePoints

--this returnes 0 or NULL
--SELECT @SumOfGradePoints = gd.AchievementPoints / gd.AchievementMaxPoints * atype.ParticipationRate
--FROM GradeDetails as gd INNER JOIN AchievementType as atype
--ON gd.AchievementTypeID = atype.ID
--WHERE GradeID = @GradeId AND AchievementTypeID = @AchievementTypeID

END

EXEC	sp_CreateGradeDetail
		@GradeId = 1,
		@AchievementTypeID = 5,
		@Points = 80,
		@MaxPoints = 100,
		@Date = '20240528'