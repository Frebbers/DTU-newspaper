DROP DATABASE IF EXISTS DKAvisen;
CREATE DATABASE DKAvisen;
USE DKAvisen;

CREATE TABLE Address
(
    address_id   INT PRIMARY KEY AUTO_INCREMENT,
    street_name  VARCHAR(255),
    civic_number VARCHAR(20),
    city         VARCHAR(100),
    zip_code     VARCHAR(20),
    country      VARCHAR(100)
);

CREATE TABLE Newspaper
(
    Title         VARCHAR(255) PRIMARY KEY,
    Founding_date DATE NOT NULL,
    Periodicity   SMALLINT
);
CREATE TABLE Edition
(
    Newspaper_Title VARCHAR(255),
    Release_date    DATE NOT NULL,
    PRIMARY KEY (Newspaper_Title, Release_Date),
    FOREIGN KEY (Newspaper_Title) REFERENCES Newspaper (Title)
);
CREATE TABLE Image
(
    Title       VARCHAR(255) PRIMARY KEY,
    Date_Taken  DATE NOT NULL,
    Reporter_id INT
);

CREATE TABLE Journalist
(
    CPR_NUMBER    INT          NOT NULL PRIMARY KEY,
    First_name    VARCHAR(255) NOT NULL,
    Last_name     VARCHAR(255) NOT NULL,
    Email_address VARCHAR(255),
    Address_ID    INT          NOT NULL,
    FOREIGN KEY (Address_ID) REFERENCES Address (address_id)
);
CREATE TABLE JournalistPhoneNumbers
(
    Phone_number VARCHAR(20) primary key,
    CPR_NUMBER   INT NOT NULL,
    FOREIGN KEY (CPR_NUMBER) REFERENCES Journalist (CPR_NUMBER)
);

CREATE TABLE Article
(
    Title                VARCHAR(255),
    Edition_Title        VARCHAR(255),
    Edition_Release_date DATE,
    PRIMARY KEY (Title, Edition_Title, Edition_Release_date),
    Release_Date         DATE NOT NULL,
    View_Count           INT DEFAULT 0,
    Topic                VARCHAR(255),
    FOREIGN KEY (Edition_Title, Edition_Release_date) REFERENCES Edition (Newspaper_Title, Release_date)
);
CREATE TABLE Editor
(
    Editor_ID               INT,
    Edition_Newspaper_Title VARCHAR(255),
    Edition_Release_date    DATE NOT NULL,
    PRIMARY KEY (Editor_ID, Edition_Newspaper_Title, Edition_Release_date),
    FOREIGN KEY (Editor_ID) REFERENCES Journalist (CPR_NUMBER),
    FOREIGN KEY (Edition_Newspaper_Title, Edition_Release_date) REFERENCES Edition (Newspaper_Title, Release_date)
);
CREATE TABLE Reporter
(
    Reporter_ID INT,
    Image_Title VARCHAR(255),
    PRIMARY KEY (Reporter_ID, Image_Title),
    FOREIGN KEY (Reporter_ID) REFERENCES Journalist (CPR_NUMBER),
    FOREIGN KEY (Image_Title) REFERENCES Image (Title)
);
CREATE TABLE Writes
(
    Journalist_CPR       INT,
    Article_Title        VARCHAR(255),
    Edition_Title        VARCHAR(255),
    Edition_Release_date DATE,
    Role                 VARCHAR(20),
    PRIMARY KEY (Journalist_CPR, Article_Title, Edition_Title, Edition_Release_date),
    FOREIGN KEY (Journalist_CPR) REFERENCES Journalist (CPR_NUMBER),
    FOREIGN KEY (Article_Title, Edition_Title, Edition_Release_date) REFERENCES Article (Title, Edition_Title, Edition_Release_date)
);
CREATE TABLE ArticlePhotos
(
    Article_Title        VARCHAR(255),
    Edition_Title        VARCHAR(255),
    Edition_Release_date DATE,
    Image_Title          VARCHAR(255),
    PRIMARY KEY (Article_Title, Edition_Title, Edition_Release_date, Image_Title),
    FOREIGN KEY (Article_Title, Edition_Title, Edition_Release_date) REFERENCES Article (Title, Edition_Title, Edition_Release_date),
    FOREIGN KEY (Image_Title) REFERENCES Image (Title)
);
#Inserting data into the tables
INSERT INTO Address(street_name, civic_number, city, zip_code, country)
VALUES ('Baker Street', '221B', 'London', 'NW1 6XE', 'United Kingdom'),
       ('Fifth Avenue', '350', 'New York', '10018', 'United States'),
       ('Champs-Élysées', '70', 'Paris', '75008', 'France'),
       ('Via Condotti', '56', 'Rome', '00187', 'Italy'),
       ('Bahnhofstrasse', '30', 'Zurich', '8001', 'Switzerland');

INSERT INTO Newspaper(Title, Founding_date, Periodicity)
VALUES ('The Times', '1785-01-01', 1),
       ('The New York Times', '1851-09-18', 1),
       ('Le Monde', '1944-12-19', 1),
       ('La Repubblica', '1976-01-14', 1),
       ('Neue Zürcher Zeitung', '1780-01-12', 1);

INSERT INTO Edition(Newspaper_Title, Release_date)
VALUES ('The Times', '2023-01-01'),
       ('The New York Times', '2023-01-02'),
       ('Le Monde', '2023-01-03'),
       ('La Repubblica', '2023-01-04'),
       ('Neue Zürcher Zeitung', '2023-01-05');

INSERT INTO Image(Title, Date_Taken, Reporter_id)
VALUES ('Picture 1', '2023-01-01', 12345678),
       ('Picture 2', '2023-01-02', 23456789),
       ('Picture 3', '2023-01-03', 34567890),
       ('Picture 4', '2023-01-04', 45678901),
       ('Picture 5', '2023-01-05', 56789012);

INSERT INTO Journalist(CPR_NUMBER, First_name, Last_name, Email_address, Address_ID)
VALUES (12345678, 'John', 'Doe', 'john.doe@example.com', 1),
       (23456789, 'Jane', 'Doe', 'jane.doe@example.com', 2),
       (34567890, 'Jim', 'Smith', 'jim.smith@example.com', 3),
       (45678901, 'Jill', 'Johnson', 'jill.johnson@example.com', 4),
       (56789012, 'Jack', 'Brown', 'jack.brown@example.com', 5);

INSERT INTO Image(Title, Date_Taken, Reporter_id)
VALUES ('Protest in London', '2023-01-01', 12345678),
       ('New York City Skyline', '2023-01-02', 23456789),
       ('Eiffel Tower at Night', '2023-01-03', 34567890),
       ('Colosseum in Rome', '2023-01-04', 45678901),
       ('Swiss Alps', '2023-01-05', 56789012);

INSERT INTO Article(Release_Date, Title, Edition_Title, Edition_Release_date, Topic, View_Count)
VALUES ('2023-01-06', 'Brexit Impact on London Economy', 'The Times', '2023-01-01', 'Economy', 100),
       ('2023-01-07', 'New York City Housing Crisis', 'The New York Times', '2023-01-02', 'Housing', 200),
       ('2023-01-08', 'French Presidential Election', 'Le Monde', '2023-01-03', 'Politics', 300),
       ('2023-01-09', 'Italian Cuisine: More Than Just Pizza', 'La Repubblica', '2023-01-04', 'Food', 400),
       ('2023-01-10', 'Swiss Banking Secrecy', 'Neue Zürcher Zeitung', '2023-01-05', 'Finance', 500);

INSERT INTO JournalistPhoneNumbers(Phone_number, CPR_NUMBER)
VALUES ('+44 20 1234 5678', 12345678),
       ('+1 212 123 4567', 23456789),
       ('+33 1 23 45 67 89', 34567890),
       ('+39 06 1234 5678', 45678901),
       ('+41 44 123 45 67', 56789012);

INSERT INTO Reporter(Reporter_ID, Image_Title)
VALUES
    (12345678, 'Protest in London'),
    (23456789, 'New York City Skyline'),
    (34567890, 'Eiffel Tower at Night'),
    (45678901, 'Colosseum in Rome'),
    (56789012, 'Swiss Alps');


INSERT INTO Writes(Journalist_CPR, Article_Title, Edition_Title, Edition_Release_date, Role)
VALUES
    (12345678, 'Brexit Impact on London Economy', 'The Times', '2023-01-01', 'Author'),
    (23456789, 'New York City Housing Crisis', 'The New York Times', '2023-01-02', 'Author'),
    (34567890, 'French Presidential Election', 'Le Monde', '2023-01-03', 'Author'),
    (45678901, 'Italian Cuisine: More Than Just Pizza', 'La Repubblica', '2023-01-04', 'Author'),
    (56789012, 'Swiss Banking Secrecy', 'Neue Zürcher Zeitung', '2023-01-05', 'Author');

INSERT INTO ArticlePhotos(Article_Title, Edition_Title, Edition_Release_date, Image_Title)
VALUES
    ('Brexit Impact on London Economy', 'The Times', '2023-01-01', 'Picture 1'),
    ('New York City Housing Crisis', 'The New York Times', '2023-01-02', 'Picture 2'),
    ('French Presidential Election', 'Le Monde', '2023-01-03', 'Picture 3'),
    ('Italian Cuisine: More Than Just Pizza', 'La Repubblica', '2023-01-04', 'Picture 4'),
    ('Swiss Banking Secrecy', 'Neue Zürcher Zeitung', '2023-01-05', 'Picture 5');

INSERT INTO Editor(Editor_ID, Edition_Newspaper_Title, Edition_Release_date)
VALUES
    (12345678, 'The Times', '2023-01-01'),
    (23456789, 'The New York Times', '2023-01-02'),
    (34567890, 'Le Monde', '2023-01-03'),
    (45678901, 'La Repubblica', '2023-01-04'),
    (56789012, 'Neue Zürcher Zeitung', '2023-01-05');

CREATE VIEW WritesWithJournalistFullName AS
SELECT CONCAT(j.First_name, ' ', j.Last_name) AS Journalist_FullName,
       w.Article_Title,
       w.Edition_Title,
       w.Edition_Release_date,
       w.Role
FROM Writes w
         JOIN Journalist j ON w.Journalist_CPR = j.CPR_NUMBER;

CREATE VIEW ArticlesPerTopic AS
SELECT
    Topic,
    COUNT(*) AS ArticleCount,
    SUM(View_Count) AS TotalViews
FROM
    Article
GROUP BY
    Topic;
#Database instance
SELECT * FROM Address;
SELECT * FROM Newspaper;
SELECT * FROM Edition;
SELECT * FROM Image;
SELECT * FROM Journalist;
SELECT * FROM JournalistPhoneNumbers;
SELECT * FROM Article;
SELECT * FROM Editor;
SELECT * FROM Reporter;
SELECT * FROM Writes;
SELECT * FROM ArticlePhotos;
SELECT * FROM WritesWithJournalistFullName;
SELECT * FROM ArticlesPerTopic;