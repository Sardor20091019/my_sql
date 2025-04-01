

CREATE DATABASE SchoolDB

USE SchoolDB


CREATE TABLE Students (StudentID INT PRIMARY KEY, Name VARCHAR(50), Age INT)

INSERT INTO Students VALUES (1, 'Sardor Sunnatullayev', 16)
INSERT INTO Students VALUES (2, 'Akmal Karimov', 18)
INSERT INTO Students VALUES (3, 'Elina Vakhidova', 17)
INSERT INTO Students VALUES (4, 'Diyorbek Rasulov', 19)
INSERT INTO Students VALUES (5, 'Madina Yuldasheva', 16)
INSERT INTO Students VALUES (6, 'Jasur Murodov', 20)
INSERT INTO Students VALUES (7, 'Sabina Alimova', 18)
INSERT INTO Students VALUES (8, 'Rustam Saidov', 21)
INSERT INTO Students VALUES (9, 'Kamila Tursunova', 17)
INSERT INTO Students VALUES (10, 'Farhod Bekmurodov', 19)
INSERT INTO Students VALUES (11, 'Shahnoza Ismoilova', 16)



BACKUP DATABASE SchoolDB
TO DISK = 'C:\Backup\SchoolDB.bak'
WITH FORMAT, INIT, NAME = 'SchoolDB';
