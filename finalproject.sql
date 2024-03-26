IF EXISTS (SELECT * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where 
constraint_name = 'fk_students_parent_id')
alter table patients DROP 
CONSTRAINT fk_students_parent_id

IF EXISTS (SELECT * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where 
constraint_name = 'fk_students_instructor_id')
alter table patients DROP 
CONSTRAINT fk_students_instructor_id

IF EXISTS (SELECT * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where 
constraint_name = 'fk_students_group_id')
alter table patients DROP 
CONSTRAINT fk_students_group_id

IF EXISTS (SELECT * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where 
constraint_name = 'fk_groups_level_id')
alter table patients DROP 
CONSTRAINT fk_groups_level_id   

IF EXISTS (SELECT * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
where 
constraint_name = 'fk_groups_instructor_id')
alter table patients DROP 
CONSTRAINT fk_groups_instructor_id


GO

DROP TABLE IF EXISTS students

DROP TABLE IF EXISTS parents

DROP TABLE IF EXISTS instructors

DROP TABLE IF EXISTS groups

DROP TABLE IF EXISTS levels

GO


-- Creating tables

-- Students table
CREATE TABLE students (
  student_id INT PRIMARY KEY,
  first_name VARCHAR(30) NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  age INT NOT NULL,
  phone_number CHAR(10),
  email VARCHAR(50),
  StreetAddress VARCHAR(255),
  City VARCHAR(100),
  StateOrRegion VARCHAR(50),
  PostalCode VARCHAR(20),
  Country VARCHAR(50),
  student_parent_id INT NOT NULL,
  student_group_id INT NOT NULL,
  instructor_id INT NOT NULL
);

-- Parents table
CREATE TABLE parents (
  parent_id INT PRIMARY KEY,
  first_name VARCHAR(30) NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  phone_number CHAR(10),
  email VARCHAR(50),
  StreetAddress VARCHAR(255),
  City VARCHAR(100),
  StateOrRegion VARCHAR(50),
  PostalCode VARCHAR(20),
  Country VARCHAR(50),
  UNIQUE (phone_number, email)
);

-- Instructors table
CREATE TABLE instructors (
  instructor_id INT PRIMARY KEY,
  first_name VARCHAR(30) NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  phone_number CHAR(10),
  email VARCHAR(50),
  UNIQUE (phone_number, email)
);

-- Groups table
CREATE TABLE groups (
  group_id INT PRIMARY KEY,
  level_id INT NOT NULL,
  total_students INT NOT NULL,
  instructor_id INT NOT NULL,
  meeting_day VARCHAR(20) NOT NULL,
  meeting_time TIME NOT NULL
);

-- Levels (Lookup Table)
CREATE TABLE levels (
  level_id INT PRIMARY KEY,
  level_name VARCHAR(30) NOT NULL
);

-- Creating relationships

-- Student-Parent relationship
ALTER TABLE students
ADD CONSTRAINT fk_students_parent_id FOREIGN KEY (student_parent_id)
REFERENCES parents(parent_id);

-- Student-Instructor relationship
ALTER TABLE students
ADD CONSTRAINT fk_students_instructor_id FOREIGN KEY (instructor_id)
REFERENCES instructors(instructor_id);

-- Student-Group relationship
ALTER TABLE students
ADD CONSTRAINT fk_students_group_id FOREIGN KEY (student_group_id)
REFERENCES groups(group_id);

-- Group-Level relationship
ALTER TABLE groups
ADD CONSTRAINT fk_groups_level_id FOREIGN KEY (level_id)
REFERENCES levels(level_id);

-- Instructor-Group relationship
ALTER TABLE groups
ADD CONSTRAINT fk_groups_instructor_id FOREIGN KEY (instructor_id)
REFERENCES instructors(instructor_id);

-- inserting values
go

INSERT INTO students(student_id,first_name,last_name,age,phone_number,email,streetAddress,city,StateOrRegion,postalcode,country,student_parent_id,student_group_id,instructor_id) VALUES
(1, 'John', 'Doe', 20, '1234567890', 'john.doe@example.com', '456 Oak St', 'Anytown', 'CA', '12345', 'USA', 101, 401, 301),
(2, 'Jane', 'Smith', 22, '9876543210', 'jane.smith@example.com', '789 Maple Ave', 'Othertown', 'NY', '54321', 'USA', 102, 402, 302),
(3, 'Bob', 'Johnson', 19, '5551234567', 'bob.johnson@example.com', '321 Pine Ln', 'Smalltown', 'TX', '67890', 'USA', 103, 403, 303),
(4, 'Emily', 'Williams', 21, '4447890123', 'emily.williams@example.com', '987 Birch Rd', 'Newtown', 'FL', '98765', 'USA', 104, 404, 304),
(5, 'Alex', 'Davis', 23, '2223334444', 'alex.davis@example.com', '654 Cedar Blvd', 'Sometown', 'WA', '54321', 'USA', 105, 405, 305),
(6, 'Megan', 'Brown', 20, '1112223333', 'megan.brown@example.com', '789 Elm St', 'Cityville', 'IL', '87654', 'USA', 106, 406, 306),
(7, 'Chris', 'Jones', 22, '9998887777', 'chris.jones@example.com', '234 Oak Ave', 'Metroville', 'CA', '34567', 'USA', 107, 407, 307),
(8, 'Amanda', 'Miller', 19, '7778889999', 'amanda.miller@example.com', '876 Pine Rd', 'Villagetown', 'NY', '23456', 'USA', 108, 408, 308),
(9, 'Daniel', 'Clark', 21, '3334445555', 'daniel.clark@example.com', '543 Maple Ln', 'Hometown', 'TX', '76543', 'USA', 109, 409, 309),
(10, 'Sophia', 'Lee', 20, '6667778888', 'sophia.lee@example.com', '123 Cedar Ave', 'Suburbia', 'FL', '43210', 'USA', 110, 410, 310);


GO
INSERT INTO parents(parent_id,first_name,last_name,phone_number,email,streetAddress,city,StateOrRegion,postalcode,country) VALUES
(101, 'Alice', 'Doe', '1112223333', 'alice.doe@example.com', '123 Pine St', 'Anytown', 'CA', '12345', 'USA'),
(102, 'Bob', 'Smith', '2223334444', 'bob.smith@example.com', '456 Oak Ave', 'Othertown', 'NY', '54321', 'USA'),
(103, 'Charlie', 'Johnson', '3334445555', 'charlie.johnson@example.com', '789 Maple Ln', 'Smalltown', 'TX', '67890', 'USA'),
(104, 'David', 'Williams', '4445556666', 'david.williams@example.com', '987 Cedar Blvd', 'Newtown', 'FL', '98765', 'USA'),
(105, 'Eva', 'Davis', '5556667777', 'eva.davis@example.com', '654 Birch Rd', 'Sometown', 'WA', '54321', 'USA'),
(106, 'Frank', 'Brown', '6667778888', 'frank.brown@example.com', '321 Elm St', 'Cityville', 'IL', '87654', 'USA'),
(107, 'Grace', 'Jones', '7778889999', 'grace.jones@example.com', '876 Pine Ave', 'Metroville', 'CA', '34567', 'USA'),
(108, 'Harry', 'Miller', '8889990000', 'harry.miller@example.com', '234 Oak Ln', 'Villagetown', 'NY', '23456', 'USA'),
(109, 'Ivy', 'Clark', '9990001111', 'ivy.clark@example.com', '543 Cedar Rd', 'Hometown', 'TX', '76543', 'USA'),
(110, 'Jack', 'Lee', '1234567890', 'jack.lee@example.com', '789 Maple Blvd', 'Suburbia', 'FL', '43210', 'USA');

GO

INSERT INTO instructors(instructor_id,first_name,last_name,phone_number,email)VALUES
(301, 'Michael', 'Smith', '1112223333', 'michael.smith@example.com'),
(302, 'Jennifer', 'Johnson', '2223334444', 'jennifer.johnson@example.com'),
(303, 'Matthew', 'Williams', '3334445555', 'matthew.williams@example.com'),
(304, 'Emily', 'Davis', '4445556666', 'emily.davis@example.com'),
(305, 'Andrew', 'Brown', '5556667777', 'andrew.brown@example.com'),
(306, 'Olivia', 'Jones', '6667778888', 'olivia.jones@example.com'),
(307, 'Daniel', 'Miller', '7778889999', 'daniel.miller@example.com'),
(308, 'Sophia', 'Clark', '8889990000', 'sophia.clark@example.com'),
(309, 'James', 'Lee', '9990001111', 'james.lee@example.com'),
(310, 'Emma', 'Smith', '1234567890', 'emma.smith@example.com');

GO
INSERT INTO groups(group_id,level_id,total_students,instructor_id,meeting_day,meeting_time) VALUES
(401, 501, 20, 301, 'Monday', '10:00 AM'),
(402, 502, 18, 302, 'Tuesday', '2:00 PM'),
(403, 503, 22, 303, 'Wednesday', '4:30 PM'),
(404, 504, 15, 304, 'Thursday', '1:00 PM'),
(405, 505, 25, 305, 'Friday', '3:45 PM'),
(406, 506, 21, 306, 'Saturday', '9:30 AM'),
(407, 507, 19, 307, 'Sunday', '11:15 AM'),
(408, 508, 23, 308, 'Monday', '8:00 AM'),
(409, 509, 17, 309, 'Tuesday', '12:45 PM'),
(410, 510, 24, 310, 'Wednesday', '6:15 PM');

GO

INSERT INTO levels(level_id,level_name)VALUES
(501, 'Beginner'),
(502, 'Intermediate'),
(503, 'Advanced'),
(504, 'Expert'),
(505, 'Intermediate'),
(506, 'Beginner'),
(507, 'Advanced'),
(508, 'Expert'),
(509, 'Beginner'),
(510, 'Intermediate');

-- View for instructors
CREATE VIEW instructor_view AS
SELECT
    i.instructor_id,
    i.first_name AS instructor_first_name,
    i.last_name AS instructor_last_name,
    i.phone_number AS instructor_phone_number,
    i.email AS instructor_email,
    g.group_id,
    g.meeting_day,
    g.meeting_time,
    l.level_name
FROM
    instructors i
JOIN
    groups g ON i.instructor_id = g.instructor_id
JOIN
    levels l ON g.level_id = l.level_id;

select * from instructor_view




CREATE VIEW parent_view AS
SELECT 
    s.student_id,
    s.first_name + ' ' + s.last_name as student_name,  
    s.age as student_age, 
    s.phone_number as student_phone_number, 
    s.email as student_email, 
    s.StreetAddress,
    s.StateOrRegion,
    s.PostalCode,
    s.country,
    i.first_name + ' ' + i.last_name as instructor_name,
    i.phone_number as instructor_phone_number,
    i.email as instructor_email,
    g.group_id,
    l.level_name,
    CONVERT(VARCHAR(10), g.meeting_day) + ' ' + CONVERT(VARCHAR(8), g.meeting_time, 108) as weekly_group_meeting
FROM students s
JOIN parents p ON s.student_parent_id = p.parent_id 
JOIN instructors i ON s.instructor_id = i.instructor_id
JOIN groups g ON g.group_id = s.student_group_id
JOIN levels l ON g.level_id = l.level_id;

GO
select * from parent_view


-- drop procedure if exists p_upsert_parent_details
-- GO
-- create procedure p_upsert_parent_details (
--     @student_email varchar(50),
--     @student_phonenumber char(3),
--     @student_id VARCHAR(20)
-- ) as begin
--     if exists(select * from parent_view where student_email =@parent_email ) begin 
--         update parent_view set student_phone_number =   @student_phonenumber, student_id = @student_id
--             where student_id = @student_id
--     end
--     else begin
--         insert into parent_view  (student_id,student_email, student_phone_number) 
--             values (@student_id@student_email,@student_phonenumber )
--     end
-- end 
-- GO

CREATE VIEW student_view AS
SELECT
    s.student_id,
    s.first_name AS student_first_name,
    s.last_name AS student_last_name,
    s.age AS student_age,
    s.phone_number AS student_phone_number,
    s.email AS student_email,
    s.StreetAddress AS student_StreetAddress,
    s.City AS student_City,
    s.StateOrRegion AS student_StateOrRegion,
    s.PostalCode AS student_PostalCode,
    s.Country AS student_Country,
    p.parent_id,
    p.first_name AS parent_first_name,
    p.last_name AS parent_last_name,
    p.phone_number AS parent_phone_number,
    p.email AS parent_email,
    i.instructor_id,
    i.first_name AS instructor_first_name,
    i.last_name AS instructor_last_name,
    g.group_id,
    g.level_id,
    g.total_students,
    g.meeting_day,
    g.meeting_time,
    l.level_name
FROM
    students s
JOIN
    parents p ON s.student_parent_id = p.parent_id
JOIN
    instructors i ON s.instructor_id = i.instructor_id
JOIN
    groups g ON s.student_group_id = g.group_id
JOIN
    levels l ON g.level_id = l.level_id;


SELECT * FROM student_view;


select * from parent_view 
-- Declare variables
DECLARE @student_email VARCHAR(50) = 'john.doe@example.com';
DECLARE @student_phonenumber CHAR(10) = '1234567890';
DECLARE @student_id VARCHAR(20) = '1';

-- Execute the stored procedure
EXEC p_upsert_parent_details @student_email, @student_phonenumber, @student_id;



DROP PROCEDURE IF EXISTS p_upsert_parent_details;
GO

CREATE PROCEDURE p_upsert_parent_details (
    @student_email VARCHAR(50),
    @student_phonenumber CHAR(10),
    @student_id VARCHAR(20)
) AS 
BEGIN
    IF EXISTS (SELECT * FROM parent_view WHERE student_email = @student_email)
    BEGIN
        UPDATE parent_view 
        SET student_phone_number = @student_phonenumber
        WHERE student_id = @student_id;
    END
    ELSE
    BEGIN
        INSERT INTO parent_view (student_id, student_email, student_phone_number) 
        VALUES (@student_id, @student_email, @student_phonenumber);
    END
END;
GO

--List of students in a group 
SELECT s.student_id, s.first_name, s.last_name, s.age, s.phone_number, s.email
FROM students s
WHERE s.student_group_id = 401;

--parent information for a students 
SELECT p.parent_id, p.first_name, p.last_name, p.phone_number, p.email
FROM parents p
JOIN students s ON p.parent_id = s.student_parent_id
WHERE s.student_id = student_id;

--List of group with instructor Details
SELECT g.group_id, g.meeting_day, g.meeting_time, i.instructor_id, i.first_name AS instructor_first_name, i.last_name AS instructor_last_name
FROM groups g
JOIN instructors i ON g.instructor_id = i.instructor_id;

--Total Students per Level
SELECT l.level_name, COUNT(s.student_id) AS total_students
FROM levels l
JOIN groups g ON l.level_id = g.level_id
JOIN students s ON g.group_id = s.student_group_id
GROUP BY l.level_name;

-- --update Students Details
-- UPDATE students
-- SET age = <new_age>, phone_number = '<new_phone_number>', email = '<new_email>'
-- WHERE student_id = <student_id>;

-- --Delete a Group
-- DELETE FROM groups
-- WHERE group_id = <group_id>;




--Student Information Retrieval
SELECT * FROM students WHERE student_id = student_id;

--Parent Contact Information/--list of parents in a group
SELECT p.parent_id, p.first_name, p.last_name, p.phone_number, p.email
FROM parents p
JOIN students s ON p.parent_id = s.student_parent_id
WHERE s.student_group_id = student_group_id;

--Group Schedule
SELECT g.group_id, g.meeting_day, g.meeting_time
FROM groups g
WHERE g.group_id = group_id;

-- List of Instructors and Assigned Groups
SELECT i.instructor_id, i.first_name, i.last_name, g.group_id
FROM instructors i
JOIN groups g ON i.instructor_id = g.instructor_id;

-- Parental Contact Duplication Check
SELECT phone_number, email, COUNT(*)
FROM parents
GROUP BY phone_number, email
HAVING COUNT(*) > 1;


--Students without Assigned Parents
SELECT s.student_id, s.first_name, s.last_name
FROM students s
LEFT JOIN parents p ON s.student_parent_id = p.parent_id
WHERE p.parent_id IS NULL;

--Meeting Conflict Check
SELECT g.group_id, g.meeting_day, g.meeting_time, COUNT(*)
FROM groups g
GROUP BY g.group_id, g.meeting_day, g.meeting_time
HAVING COUNT(*) > 1;




--group summary
CREATE VIEW GroupSummary AS
SELECT
  g.group_id, g.level_id, l.level_name, g.total_students,
  g.instructor_id, i.first_name AS instructor_first_name, i.last_name AS instructor_last_name,
  g.meeting_day, g.meeting_time
FROM
  groups g
JOIN levels l ON g.level_id = l.level_id
JOIN instructors i ON g.instructor_id = i.instructor_id;

SELECT * from GroupSummary


CREATE PROCEDURE EditInstructorDetails(
    @instructor_id INT,
    @new_meeting_day VARCHAR(20) = NULL,
    @new_meeting_time TIME = NULL,
    @new_email VARCHAR(50) = NULL,
    @new_level_name VARCHAR(30) = NULL
)
AS
BEGIN
    -- Update meeting schedule if provided
    IF @new_meeting_day IS NOT NULL OR @new_meeting_time IS NOT NULL
    BEGIN
        UPDATE groups
        SET
            meeting_day = ISNULL(@new_meeting_day, meeting_day),
            meeting_time = ISNULL(@new_meeting_time, meeting_time)
        WHERE instructor_id = @instructor_id;
    END;

    -- Update email if provided
    IF @new_email IS NOT NULL
    BEGIN
        UPDATE instructors
        SET email = @new_email
        WHERE instructor_id = @instructor_id;
    END;

    -- Update level name if provided
    IF @new_level_name IS NOT NULL
    BEGIN
        UPDATE levels
        SET level_name = @new_level_name
        WHERE level_id = (SELECT level_id FROM instructor_view WHERE instructor_id = @instructor_id);
    END;
END;

-- Edit meeting schedule for instructor with ID 301
EXEC EditInstructorDetails @instructor_id = 301, @new_meeting_day = 'Friday', @new_meeting_time = '2:30 PM';

select * from instructor_view

-- Edit email for instructor with ID 302
EXEC EditInstructorDetails @instructor_id = 302, @new_email = 'new_email@example.com';

-- Edit level name for instructor with ID 303
EXEC EditInstructorDetails @instructor_id = 303, @new_level_name = 'Advanced';

--it will show the phone number is different or same
SELECT
    s.student_id,
    s.first_name AS student_first_name,
    s.last_name AS student_last_name,
    s.phone_number AS student_phone_number,
    i.instructor_id,
    i.first_name AS instructor_first_name,
    i.last_name AS instructor_last_name,
    i.phone_number AS instructor_phone_number,
    CASE
        WHEN s.phone_number = i.phone_number THEN 'Same'
        ELSE 'Different'
    END AS phone_numbers_comparison
FROM
    students s
JOIN
    instructors i ON s.instructor_id = i.instructor_id;

