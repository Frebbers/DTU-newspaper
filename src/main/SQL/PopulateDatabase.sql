USE DKAvisen;

INSERT INTO Address(address_id, street_name, civic_number, city, zip_code, country) VALUES
(1, 'Street 1', '1', 'City 1', 'Zip 1', 'Country 1'),
(2, 'Street 2', '2', 'City 2', 'Zip 2', 'Country 2'),
(3, 'Street 3', '3', 'City 3', 'Zip 3', 'Country 3'),
(4, 'Street 4', '4', 'City 4', 'Zip 4', 'Country 4'),
(5, 'Street 5', '5', 'City 5', 'Zip 5', 'Country 5');

INSERT INTO Newspaper(Title, Founding_date, Periodicity) VALUES
('Newspaper 1', '2022-01-01', 1),
('Newspaper 2', '2022-02-01', 2),
('Newspaper 3', '2022-03-01', 3),
('Newspaper 4', '2022-04-01', 4),
('Newspaper 5', '2022-05-01', 5);

INSERT INTO Edition(Edition_ID, Newspaper_Title, Release_date, Editor_ID) VALUES
(1, 'Newspaper 1', '2022-01-02', 1),
(2, 'Newspaper 2', '2022-02-02', 2),
(3, 'Newspaper 3', '2022-03-02', 3),
(4, 'Newspaper 4', '2022-04-02', 4),
(5, 'Newspaper 5', '2022-05-02', 5);

INSERT INTO Image(img_id, date_taken, reporter_id) VALUES
(1, '2022-01-03', 1),
(2, '2022-02-03', 2),
(3, '2022-03-03', 3),
(4, '2022-04-03', 4),
(5, '2022-05-03', 5);

INSERT INTO Journalist(CPR_NUMBER, First_name, Last_name, Primary_phone, Email_address, Address_ID) VALUES
(1, 'First 1', 'Last 1', 'Phone 1', 'Email 1', 1),
(2, 'First 2', 'Last 2', 'Phone 2', 'Email 2', 2),
(3, 'First 3', 'Last 3', 'Phone 3', 'Email 3', 3),
(4, 'First 4', 'Last 4', 'Phone 4', 'Email 4', 4),
(5, 'First 5', 'Last 5', 'Phone 5', 'Email 5', 5);

INSERT INTO JournalistPhoneNumbers(Phone_number, CPR_NUMBER) VALUES
('Phone 1', 1),
('Phone 2', 2),
('Phone 3', 3),
('Phone 4', 4),
('Phone 5', 5);

INSERT INTO Writes(journalist_id, article_id, Role) VALUES
(1, 1, 'Role 1'),
(2, 2, 'Role 2'),
(3, 3, 'Role 3'),
(4, 4, 'Role 4'),
(5, 5, 'Role 5');

INSERT INTO Article(Article_id, Release_Date, Author_id, Title, View_Count) VALUES
(1, '2022-01-04', 1, 'Title 1', 1),
(2, '2022-02-04', 2, 'Title 2', 2),
(3, '2022-03-04', 3, 'Title 3', 3),
(4, '2022-04-04', 4, 'Title 4', 4),
(5, '2022-05-04', 5, 'Title 5', 5);

INSERT INTO Editor(Editor_ID, Edition_ID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO Reporter(Reporter_ID, Edition_ID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);