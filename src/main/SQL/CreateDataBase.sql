DROP DATABASE if exists DKAvisen;
CREATE DATABASE DKAvisen;
USE DKAvisen;
CREATE TABLE Newspaper(
    Title varchar(255) PRIMARY KEY,
    Founding_date date NOT NULL,
    Periodicity smallint
);
CREATE TABLE owns
(
    Title varchar(255),
    Release_date date,
    FOREIGN KEY (Title) REFERENCES Newspaper (Title),
    FOREIGN KEY (Release_date) REFERENCES Edition (Release_date),
    PRIMARY KEY (Title, Release_date)
);

CREATE TABLE Edition (
    Release_date date PRIMARY KEY,
    Editor_ID smallint NOT NULL,
    FOREIGN KEY (Editor_ID) REFERENCES Editor(Editor_ID)
);
CREATE TABLE Address (
    address_id INT PRIMARY KEY,
    street_name VARCHAR(255),
    civic_number VARCHAR(20),
    city VARCHAR(100),
    zip_code VARCHAR(20),
    country VARCHAR(100)
);
CREATE TABLE Journalist (
    CPR_NUMBER smallint(10) PRIMARY KEY,
    First_name varchar(255) NOT NULL,
    Last_name varchar(255) NOT NULL,
    {Phone_numbers} smallint(15) NOT NULL,
    Email_address varchar(255) NOT NULL,
    Address_ID smallint not null,
    FOREIGN KEY (Address_ID) REFERENCES Address(address_id)
);
CREATE TABLE Worker(
    Worker_ID smallint PRIMARY KEY,
    FOREIGN KEY (Worker_ID) REFERENCES Journalist(CPR_NUMBER),
    is_editor BOOLEAN,
    is_reporter BOOLEAN,
    is_photographer BOOLEAN
);

CREATE TABLE Image (
    img_id INT PRIMARY KEY,
    date_taken DATE NOT NULL,
    reporter_id INT NOT NULL,
    FOREIGN KEY (reporter_id) REFERENCES Worker(Worker_ID)
);