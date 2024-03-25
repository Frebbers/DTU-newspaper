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
    Release_date DATE PRIMARY KEY,
    Editor_ID    INT NOT NULL,
    FOREIGN KEY (Editor_ID) REFERENCES Worker (Worker_ID)
);

CREATE TABLE owns
(
    Title        VARCHAR(255),
    Release_date DATE,
    FOREIGN KEY (Title) REFERENCES Newspaper (Title),
    FOREIGN KEY (Release_date) REFERENCES Edition (Release_date),
    PRIMARY KEY (Title, Release_date)
);

CREATE TABLE Image
(
    img_id      INT PRIMARY KEY,
    date_taken  DATE NOT NULL,
    reporter_id INT  NOT NULL,
    FOREIGN KEY (reporter_id) REFERENCES Worker (Worker_ID)
);

CREATE TABLE Journalist
(
    CPR_NUMBER    INT PRIMARY KEY,
    First_name    VARCHAR(255) NOT NULL,
    Last_name     VARCHAR(255) NOT NULL,
    Phone_numbers VARCHAR(15)  NOT NULL,
    Email_address VARCHAR(255) NOT NULL,
    Address_ID    INT          NOT NULL,
    FOREIGN KEY (Address_ID) REFERENCES Address (address_id)
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
    View_Count   INT DEFAULT 0,
);
