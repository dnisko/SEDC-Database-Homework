USE Homework01
ALTER TABLE [Student]

	ADD DateOfBirth datetime NOT NULL,
	EnrolledDate datetime NOT NULL,
	Gender bit NOT NULL, --or nvarchar
	NationalIDNumber nvarchar(50) NOT NULL,
	StudentCargNumber nvarchar(50) NOT NULL


CREATE TABLE Teacher
(
	TeacherId int IDENTITY (1, 1) NOT NULL,
	FirsName nvarchar(50) NOT NULL,
	LastName nvarchar(50) NOT NULL,
	DateOfBirth datetime NOT NULL,
	AcademicRank nvarchar(50) NOT NULL,
	HireDate datetime NOT NULL
)

CREATE TABLE Grade
(
	GradeId int IDENTITY (1, 1) NOT NULL,
	StudentID int NOT NULL,
	CourseID int NOT NULL,
	TeacherID int NOT NULL,
	Grade nvarchar(50) NOT NULL,
	Comment datetime NULL,
	CreatedDate datetime NOT NULL
)

CREATE TABLE Course
(
	CourseId int IDENTITY (1, 1) NOT NULL,
	[Name] nvarchar(50) NOT NULL,
	Credit int NOT NULL,
	AcademicYear date NOT NULL,
	Semester int NOT NULL
)

CREATE TABLE GradeDetails
(
	GradeDetailsId int IDENTITY (1, 1) NOT NULL,
	GradeID int NOT NULL,
	AchievmentTypeID int NOT NULL,
	AchievmentPoints int NOT NULL,
	AchievmentMaxPoints int NOT NULL,
	AchievmentDate datetime NOT NULL
)

CREATE TABLE AchievmentType
(
	AchievmentTypeId int IDENTITY (1, 1) NOT NULL,
	[Name] nvarchar(50) NOT NULL,
	[Description] nvarchar(50) NOT NULL,
	ParticipationRate int NOT NULL
)