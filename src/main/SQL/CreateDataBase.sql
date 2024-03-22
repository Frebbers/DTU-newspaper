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
CREATE TABLE Journalist (
    CPR_NUMBER smallint(10) PRIMARY KEY,
    First_name varchar(255) NOT NULL,
    Last_name varchar(255) NOT NULL,


    -- NICO laver en foreign key til Address
)

