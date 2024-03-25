DROP DATABASE IF EXISTS DKAvisen;
CREATE DATABASE DKAvisen;
USE DKAvisen;

CREATE TABLE Address
(
    address_id   INT PRIMARY KEY,
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
    Edition_ID      INT PRIMARY KEY,
    Newspaper_Title VARCHAR(255),
    Release_date    DATE NOT NULL,
    Editor_ID       INT NOT NULL,
    FOREIGN KEY (Newspaper_Title) REFERENCES Newspaper (Title),
    FOREIGN KEY (Editor_ID) REFERENCES Editor (Editor_ID)
);
CREATE TABLE Image
(
    img_id      INT PRIMARY KEY,
    date_taken  DATE NOT NULL,
    reporter_id INT  NOT NULL,
    FOREIGN KEY (reporter_id) REFERENCES Reporter (reporter_id)
);

CREATE TABLE Journalist
(
    CPR_NUMBER    INT PRIMARY KEY,
    First_name    VARCHAR(255) NOT NULL,
    Last_name     VARCHAR(255) NOT NULL,
    Primary_phone VARCHAR(15)  NOT NULL,
    Email_address VARCHAR(255) NOT NULL,
    Address_ID    INT          NOT NULL,
    FOREIGN KEY (Primary_phone) REFERENCES JournalistPhoneNumbers (Phone_number),
    FOREIGN KEY (Address_ID) REFERENCES Address (address_id)
);
CREATE TABLE JournalistPhoneNumbers
(
    Phone_number VARCHAR(15) primary key,
    CPR_NUMBER INT NOT NULL,
    FOREIGN KEY (CPR_NUMBER) REFERENCES Journalist(CPR_NUMBER)
);

CREATE TABLE Writes (
    journalist_id VARCHAR(20),
    article_id INT,
    Role VARCHAR(20),
    PRIMARY KEY (journalist_id, article_id),
    FOREIGN KEY (journalist_id) REFERENCES Journalist (CPR_NUMBER),
    FOREIGN KEY (article_id) REFERENCES Article (Article_id)
);

CREATE TABLE Article
(
    Article_id   INT PRIMARY KEY,
    Release_Date DATE         NOT NULL,
    Author_id    INT          NOT NULL,
    Title        VARCHAR(255) NOT NULL,
    View_Count   INT DEFAULT 0
);

CREATE TABLE Editor
(
    Editor_ID  INT PRIMARY KEY,
    FOREIGN KEY (Editor_ID) REFERENCES Journalist (CPR_NUMBER),
    Edition_ID INT NOT NULL,
    FOREIGN KEY (Edition_ID) REFERENCES Edition (Edition_ID)
);

CREATE TABLE Reporter
(
    Reporter_ID INT PRIMARY KEY,
    FOREIGN KEY (Reporter_ID) REFERENCES Journalist (CPR_NUMBER),
    Edition_ID  INT NOT NULL,
    FOREIGN KEY (Edition_ID) REFERENCES Edition (Edition_ID)
);
