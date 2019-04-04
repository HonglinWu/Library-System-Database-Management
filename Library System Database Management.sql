--CREATE TEAM DATABASE
CREATE DATABASE Library_System_Team16;
USE Library_System_Team16;
-- Create DMK
CREATE MASTER KEY
ENCRYPTION BY PASSWORD = 'Test_P@sswOrd';

-- Create certificate to protect symmetric key
CREATE CERTIFICATE TestCertificate
WITH SUBJECT = 'Library System Certificate',
EXPIRY_DATE = '2029-12-31';
-- Create symmetric key to encrypt data
CREATE SYMMETRIC KEY TestSymmetricKey
WITH ALGORITHM = AES_128
ENCRYPTION BY CERTIFICATE TestCertificate;

-- Open symmetric key
OPEN SYMMETRIC KEY TestSymmetricKey
DECRYPTION BY CERTIFICATE TestCertificate;

--CREATE TABLES
USE Library_System_Team16;

--Admin

CREATE TABLE Admin
(AdminID INT NOT NULL PRIMARY KEY,
FirstName VARCHAR(40),
LastName VARCHAR(40),
Email VARCHAR(40),
AdminJob VARCHAR(40),
RecordID VARCHAR(40),
EncryptedPassword VARBINARY(250)
);
INSERT
INTO Admin
(AdminID, FirstName, LastName, Email, AdminJob, RecordID, EncryptedPassword)
VALUES
('001', 'Andy', 'Lu', 'an.lu@gmail.com', 'Manager', '20120101',EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary, 'PassTS1'))),
('002', 'Shiny', 'Yang', 'sh.yang@gmail.com', 'Executive','20121003',EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary, 'PassTS2'))),
('003', 'Steven', 'Chia', 'st.chia@gmail.com', 'Manager','20130508',EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary, 'PassTS3'))),
('004', 'Ankur', 'Kumar', 'An.kumar@gmail.com', 'Member','20140612',EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary, 'PassTS4'))),
('005', 'Barry', 'Rain', 'Ba.Rain@gmail.com', 'Member', '20140688',EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary, 'PassTS5'))),
('006', 'Camilo', 'Valencia', 'ca.valencia@gmail.com', 'Member', '20140923',EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary, 'PassTS6'))),
('007', 'Cecelia', 'chow', 'ce.chow@gmail.com', 'Member','20150202',EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary, 'PassTS7'))),
('008', 'Chris', 'Ayala', 'ch.ayala@gmail.com', 'Member','20150901',EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary, 'PassTS8'))),
('009', 'Eric', 'Rody', 'er.rody@gmail.com', 'Member', '20150902',EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary, 'PassTS9'))),
('010', 'Harold', 'Lorren', 'ha.lorren@gmail.com', 'Member', '20151212',EncryptByKey(Key_GUID(N'TestSymmetricKey'), convert(varbinary, 'PassTS10')));


DROP TABLE Admin

ALTER TABLE Admin
DROP COLUMN RecordID

--AdminJob

CREATE TABLE dbo.AdminJob
(JobTitle VARCHAR(40) PRIMARY KEY,
AdminID INT REFERENCES Admin(AdminID) ,
Department VARCHAR(40)
);
INSERT INTO dbo.AdminJob
VALUES
('M1','001','Management'),
('E1','002','EXE'),
('M2','003','Management'),
('C2','004','Science'),
('C4','005','Science'),
('C5','006','Psychology'),
('O1','007','Psychology'),
('C3','008','Literature'),
('O2','009','Literature'),
('O3','010','Literature');

DROP TABLE AdminJob

--AdminRecord

CREATE TABLE dbo.AdminRecord
(RecordID INT NOT NULL PRIMARY KEY,
IssueID INT REFERENCES Punishment(IssueID),
AdminID INT REFERENCES Admin(AdminID)
);
INSERT INTO dbo.AdminRecord
VALUES
('20120101','001','1'),
('20121003','002','2'),
('20130508','003','3'),
('20151212','004','3'),
('20120102','005','4'),
('20120103','006','4'),
('20120104','007','5'),
('20120105','008','5'),
('20120106','009','6'),
('20120107','010','6');

DROP TABLE AdminRecord

SELECT * FROM AdminRecord



--Libraries

CREATE TABLE dbo.Libraries
(LibraryID INT NOT NULL PRIMARY KEY,
AdminID INT REFERENCES Admin(AdminID),
Address VARCHAR(40),
);
INSERT INTO dbo.Libraries
VALUES
('221','001','NEU'),
('222','002','NEU'),
('112','003','MU'),
('114','004','MU'),
('117','005','MU'),
('333','006','BU'),
('655','007','MIT'),
('669','008','MIT'),
('666','009','MIT'),
('345','010','BU');

DROP TABLE Libraries


--- Create Table Pusblisher

CREATE TABLE Publisher
(
	PublisherID INT IDENTITY NOT NULL PRIMARY KEY,
	PublisherName VARCHAR(40),
	PublisherEmail VARCHAR(40)
);


INSERT
INTO Publisher
(PublisherName, PublisherEmail)
VALUES
('Penguin Random House', 'prh@gmail.com'),
('HarperCollins', 'collins@gmail.com'),
('Simon & Schuster', 's&s@gmail.com'),
('Hachette Book Group', 'hbg@gmail.com'),
('Macmillan', 'macmillan@gmail.com'),
('Scholastic', 'scholastic@gmail.com'),
('Disney Publishing Worldwide', 'disney@gmail.com'),
('Houghton Mifflin Harcourt', 'hmh@gmail.com'),
('Workman', 'workman@gmail.com'),
('Sterling', 'sterling@gmail.com')

DROP TABLE dbo.Publisher

--- Create Table Author

CREATE TABLE Author
(
	AuthorID INT IDENTITY NOT NULL PRIMARY KEY,
	AuthorName VARCHAR(40),
	Email VARCHAR(40)
)

INSERT
INTO Author
(AuthorName, Email)
VALUES
('Díaz.Junot', 'junot@gmail.com'),
('Jones.Edward', 'edward@gmail.com'),
('Mantel.Hilary', 'Hilary@gmail.com'),
('Robinson.Marilynne', 'Marilynne@gmail.com'),
('Franzen.Jonathan', 'Jonathan@gmail.com'),
('Chabon.Michael', 'Michael@gmail.com'),
('Egan.Jennifer', 'Jennifer@gmail.com'),
('Fountain.Ben', 'Ben@gmail.com'),
('McEwan.Ian', 'Ian@gmail.com'),
('Smith.Zadie', 'Zadie@gmail.com')


--- Create Table Category

CREATE TABLE Category
(
	CategoryID INT IDENTITY NOT NULL PRIMARY KEY,
	CategoryName VARCHAR(40),
	AdminID INT,
	Location VARCHAR(40)
)

INSERT
INTO Category
(CategoryName, AdminID, Location)
VALUES
('Novel', 1, 'N5'),
('History', 2, 'H8'),
('Fiction', 3, 'F3'),
('Diary', 4, 'D2'),
('Love', 5, 'L1'),
('Art', 6, 'A1'),
('Non-Fiction', 7, 'F2'),
('Mystery', 8, 'M1'),
('Thriller', 9, 'L2'),
('Poetry', 10, 'L3')

ALTER TABLE Category
ADD FOREIGN KEY (AdminID) REFERENCES Admin(AdminID);

DROP TABLE dbo.Category;


--- Create Table Book

CREATE TABLE Book
(
	BookID INT IDENTITY NOT NULL PRIMARY KEY,
	Name VARCHAR(40),
	CategoryID INT REFERENCES Category(CategoryID),
	AuthorID INT REFERENCES Author(AuthorID),
	PublisherID INT REFERENCES Publisher(PublisherID),
	AdminID INT,
	PublishDate DATE
)

INSERT
INTO Book
(Name, CategoryID, AuthorID, PublisherID, AdminID, PublishDate)
VALUES
('Life of Oscar Wao', 1, 1, 3, 3, '2007-06-03'),
('The Known World', 2, 2, 2, 7, '2003-03-28'),
('Wolf Hall', 3, 3, 7, 8, '2009-01-03'),
('Gilead', 4, 4, 9, 8, '2013-09-03'),
('The Corrections', 5, 5, 5, 2, '2013-12-02'),
('The Kavalier and Clay', 1, 6, 7, 5, '2014-01-01'),
('A Vist From The Goon Squad', 6, 7, 8, 3, '2017-02-10'),
('Billy Lynn Long Halftime Walk', 1, 6, 3, 2, '2017-02-17'),
('Atonement', 3, 9, 5, 8, '2018-08-17'),
('Half of A Yellow Sun', 1, 10, 3, 9, '1995-10-13')

ALTER TABLE Book
ADD FOREIGN KEY (AdminID) REFERENCES Admin(AdminID);

DROP TABLE dbo.Book





-- Copies
CREATE TABLE dbo.Copies
(CopyID INT NOT NULL PRIMARY KEY,
BookID INT 
REFERENCES Book(BookID),
Status BIT
);

/* Each book has 3 copies 
 * Status indicates whether it is currently available:
 * '1': available,
 * '0': unabailable
 */
INSERT
INTO dbo.Copies
(CopyID, BookID, Status)
VALUES
('0101', '1', '0'),
('0102', '1', '0'),
('0103', '1', '1'),
('0201', '2', '1'),
('0202', '2', '0'),
('0203', '2', '0'),
('0301', '3', '0'),
('0302', '3', '1'),
('0303', '3', '1'),
('0401', '4', '0'),
('0402', '4', '0'),
('0403', '4', '1'),
('0501', '5', '0'),
('0502', '5', '0'),
('0503', '5', '1'),
('0601', '6', '1'),
('0602', '6', '1'),
('0603', '6', '1'),
('0701', '7', '1'),
('0702', '7', '1'),
('0703', '7', '1'),
('0801', '8', '1'),
('0802', '8', '1'),
('0803', '8', '1'),
('0901', '9', '1'),
('0902', '9', '1'),
('0903', '9', '1'),
('1001', '10', '1'),
('1002', '10', '1'),
('1003', '10', '1');


--Borrower
CREATE TABLE dbo.Borrower
(BorrowerID INT NOT NULL PRIMARY KEY,
FirstName VARCHAR(40),
LastName VARCHAR(40),
Email VARCHAR(40),
PunishmentTimes INT
);

INSERT
INTO dbo.Borrower
(BorrowerID, FirstName, LastName, Email)
VALUES
('001', 'Eric', 'Li', 'er.li@gmail.com'),
('002', 'Soledad', 'Mateos', 'so.ma@gmail.com'),
('003', 'Barry', 'Karge', 'ba.ka@gmail.com'),
('004', 'Antonia', 'De luca', 'an.de@gmail.com'),
('005', 'Nick', 'Carrera', 'ni.ca@gmail.com'),
('006', 'Mariapia', 'Aparicio', 'ma.ap@gmail.com'),
('007', 'Rebecca', 'Barba', 're.ba@gmail.com'),
('008', 'Cilli', 'Weber', 'ci.we@gmail.com'),
('009', 'Angela', 'Lange', 'an.la@gmail.com'),
('010', 'Miriam', 'Phillips', 'mi.ph@gmail.com');


ALTER TABLE dbo.Borrower
DROP COLUMN PunishmentTimes


--Punishment
CREATE TABLE dbo.Punishment
(IssueID INT PRIMARY KEY,
AdminID INT
REFERENCES dbo.Admin(AdminID),
BorrowerID INT
REFERENCES dbo.Borrower(BorrowerID),
CopyID INT
REFERENCES dbo.Copies(CopyID),
PunishmentStatus BIT
);

INSERT
INTO dbo.Punishment
(IssueID, AdminID, BorrowerID, CopyID, PunishmentStatus)
VALUES
('001', '001', '005', '0501', '1'),
('002', '002', '005', '0102', '1'),
('003', '003', '005', '0203', '1'),
('004', '003', '004', '0502', '1'),
('005', '004', '006', '0302', '1'),
('006', '004', '007', '0303', '1'),
('007', '005', '008', '0403', '1'),
('008', '005', '009', '0601', '1'),
('009', '006', '010', '0701', '1'),
('010', '006', '010', '0702', '1');

SELECT * FROM Punishment



--Orders
create table dbo.Orders
(CopyID INT NOT NULL
REFERENCES Copies(CopyID),
BorrowerID INT NOT NULL
REFERENCES Borrower(BorrowerID),
BorrowDate DATE NOT NULL,
ReturnDeadline DATE NOT NULL,
RenewalTimes INT NOT NULL,

CONSTRAINT pk_Orders PRIMARY KEY (CopyID, BorrowerID)

);

--compute column of Orders
ALTER TABLE Orders
ADD DaySinceBorrow AS DATEDIFF(hour, BorrowDate, GETDATE())/24;

SELECT * FROM Orders

INSERT
INTO Orders
(CopyID, BorrowerID, BorrowDate, ReturnDeadline, RenewalTimes)
VALUES
('0101', '001',  '2019-03-09', '2019-04-09', '0'),
('0401', '002',  '2019-03-11', '2019-04-11', '0'),
('0201', '003',  '2019-02-28', '2019-03-28', '0'),
('0202', '004',  '2019-03-01', '2019-04-01', '0'),
('0502', '004',  '2019-02-11', '2019-03-11', '0'),
('0402', '001',  '2019-02-09', '2019-04-09', '1'),
('0102', '005',  '2019-01-21', '2019-03-21', '1'),
('0203', '005',  '2019-02-09', '2019-03-09', '0'),
('0301', '004',  '2019-03-01', '2019-04-01', '0'),
('0501', '005',  '2019-02-15', '2019-03-15', '0'),
('0302', '006',  '2019-02-09', '2019-03-09', '0'),
('0303', '007',  '2019-02-09', '2019-03-09', '0'),
('0403', '008',  '2019-02-09', '2019-03-09', '0'),
('0601', '009',  '2019-02-09', '2019-03-09', '0'),
('0701', '010',  '2019-02-09', '2019-03-09', '0'),
('0702', '010',  '2019-02-09', '2019-03-09', '0');


DROP TABLE dbo.Orders
DROP TABLE dbo.Borrower
DROP TABLE dbo.Punishment
DROP TABLE dbo.Copies


/* Create a function to count punishment times of a borrower
 * Function will return 1 if the punishment times exceed 3,
 * and return 0 else
 */
CREATE FUNCTION CountPunishmentTimes (@BorrID INT)
RETURNS INT
AS
BEGIN
	DECLARE @Count INT = 0;
	SELECT @Count = COUNT(p.BorrowerID)
		FROM dbo.Punishment p
		WHERE p.BorrowerID = @BorrID;
	RETURN @Count;
END

-- Add table-level CHECK constraint based on the function CountPunishmentTimes for the Order table
-- If the Borrower has already got punishment 3 times, he/she can no longer create order
ALTER TABLE Orders ADD CONSTRAINT OverPunishmentTimes CHECK (dbo.CountPunishmentTimes(BorrowerID) < 4);

DROP FUNCTION dbo.CountPunishmentTimes


-- Create Views
CREATE VIEW NovelBooks AS
	SELECT b.BookID, b.Name, c.CategoryName, c.Location
	FROM dbo.Book b
	JOIN dbo.Category c
		ON b.CategoryID = c.CategoryID
	WHERE b.CategoryID = '1';
	

CREATE VIEW BorrowRecords AS
	SELECT b.BorrowerID, b.FirstName, b.LastName, o.CopyID, o.BorrowDate, o.ReturnDeadline, o.RenewalTimes
	FROM Orders o
	JOIN Borrower b
		ON o.BorrowerID = b.BorrowerID;

CREATE VIEW BannedBorrowers AS
	SELECT b.BorrowerID, b.FirstName, b.LastName, COUNT(b.BorrowerID) AS 'PunishmentTimes'
	FROM Borrower b
	JOIN Punishment p
		ON p.BorrowerID = b.BorrowerID
	WHERE dbo.CountPunishmentTimes(p.BorrowerID) >= 3
	GROUP BY b.BorrowerID, b.FirstName, b.LastName;

	
SELECT * FROM NovelBooks;
SELECT * FROM BorrowRecords;
SELECT * FROM BannedBorrowers;
	
DROP VIEW NovelBooks
DROP VIEW BorrowRecords
DROP VIEW BannedBorrowers


