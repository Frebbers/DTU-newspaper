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
    Release_date    DATE NOT NULL
);
CREATE TABLE Image
(
    ID          INT PRIMARY KEY,
    Date_Taken  DATE NOT NULL,
    Reporter_id INT  NOT NULL
);

CREATE TABLE Journalist
(
    CPR_NUMBER    INT          NOT NULL PRIMARY KEY,
    First_name    VARCHAR(255) NOT NULL,
    Last_name     VARCHAR(255) NOT NULL,
    Email_address VARCHAR(255) NOT NULL,
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
    ID   INT PRIMARY KEY,
    Release_Date DATE         NOT NULL,
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
    Image_ID    INT NOT NULL,
    FOREIGN KEY (Image_ID) REFERENCES Image (ID)
);
CREATE TABLE Writes
(
    journalist_id INT,
    article_id    INT,
    Role          VARCHAR(20),
    PRIMARY KEY (journalist_id, article_id),
    FOREIGN KEY (journalist_id) REFERENCES Journalist (CPR_NUMBER),
    FOREIGN KEY (article_id) REFERENCES Article (ID)
);
CREATE TABLE ArticlePhotos
(
    Article_id INT,
    img_id     INT,
    PRIMARY KEY (Article_id, img_id),
    FOREIGN KEY (Article_id) REFERENCES Article (ID),
    FOREIGN KEY (img_id) REFERENCES Image (ID)
);

