DROP DATABASE if exists DKAvisen;
CREATE DATABASE DKAvisen;
USE DKAvisen;
CREATE TABLE Newspaper(
    Title varchar(255) PRIMARY KEY,
    Founding_date date NOT NULL,
    Periodicity smallint
)

CREATE TABLE Edition (
    Release date PRIMARY KEY,
    Editor_ID SMALLINT FOREIGN KEY REFERENCES Editor(ID)

)

CREATE TABLE Address (
    address_id INT PRIMARY KEY,
    street_name VARCHAR(255),
    civic_number VARCHAR(20),
    city VARCHAR(100),
    zip_code VARCHAR(20),
    country VARCHAR(100)
)
CREATE TABLE Journalist (
    CPR_NUMBER smallint(10) PRIMARY KEY,
    First_name varchar(255) NOT NULL,
    Last_name varchar(255) NOT NULL,
    address_id INT NOT NULL,
    FOREIGN KEY (address_id) REFERENCES Address(address_id)
)

CREATE TABLE Image (
    img_id INT PRIMARY KEY,
    date_taken DATE NOT NULL,
    reporter_id INT NOT NULL,
    FOREIGN KEY (reporter_id) REFERENCES Journalist(CPR)
)