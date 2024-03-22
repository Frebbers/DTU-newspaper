DROP DATABASE if exists DKAvisen;
CREATE DATABASE DKAvisen;
USE DKAvisen;
CREATE TABLE Newspaper(
    Title varchar(255) PRIMARY KEY,
    Founding_date date NOT NULL,
    Periodicity smallint
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

CREATE TABLE Editor(
    Editor_ID smallint PRIMARY KEY,
    FOREIGN KEY (Editor_ID) REFERENCES Journalist(CPR_NUMBER)
)


