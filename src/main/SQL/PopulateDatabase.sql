USE dkavisen;
INSERT INTO Address(address_id, street_name, civic_number, city, zip_code, country) VALUES
(1, 'Baker Street', '221B', 'London', 'NW1 6XE', 'United Kingdom'),
(2, 'Fifth Avenue', '350', 'New York', '10018', 'United States'),
(3, 'Champs-Élysées', '70', 'Paris', '75008', 'France'),
(4, 'Via Condotti', '56', 'Rome', '00187', 'Italy'),
(5, 'Bahnhofstrasse', '30', 'Zurich', '8001', 'Switzerland');

INSERT INTO Newspaper(Title, Founding_date, Periodicity) VALUES
('The Times', '1785-01-01', 1),
('The New York Times', '1851-09-18', 1),
('Le Monde', '1944-12-19', 1),
('La Repubblica', '1976-01-14', 1),
('Neue Zürcher Zeitung', '1780-01-12', 1);

INSERT INTO Edition(Edition_ID, Newspaper_Title, Release_date) VALUES
(1, 'The Times', '2023-01-01'),
(2, 'The New York Times', '2023-01-02'),
(3, 'Le Monde', '2023-01-03'),
(4, 'La Repubblica', '2023-01-04'),
(5, 'Neue Zürcher Zeitung', '2023-01-05');

INSERT INTO Image(ID, Date_Taken, Reporter_id) VALUES
(1, '2023-01-01', 1),
(2, '2023-01-02', 2),
(3, '2023-01-03', 3),
(4, '2023-01-04', 4),
(5, '2023-01-05', 5);

INSERT INTO Journalist(CPR_NUMBER, First_name, Last_name, Email_address, Address_ID) VALUES
(1, 'John', 'Doe', 'john.doe@example.com', 1),
(2, 'Jane', 'Doe', 'jane.doe@example.com', 2),
(3, 'Jim', 'Smith', 'jim.smith@example.com', 3),
(4, 'Jill', 'Johnson', 'jill.johnson@example.com', 4),
(5, 'Jack', 'Brown', 'jack.brown@example.com', 5);

INSERT INTO JournalistPhoneNumbers(Phone_number, CPR_NUMBER) VALUES
('+44 20 1234 5678', 1),
('+1 212 123 4567', 2),
('+33 1 23 45 67 89', 3),
('+39 06 1234 5678', 4),
('+41 44 123 45 67', 5);

INSERT INTO Article(ID, Release_Date, Title, Topic, View_Count) VALUES
(1, '2023-01-06', 'Article 1', 'Crime', 100),
(2, '2023-01-07', 'Article 2', 'Crime', 200),
(3, '2023-01-08', 'Article 3', 'Gossip', 300),
(4, '2023-01-09', 'Article 4', 'Politics', 400),
(5, '2023-01-10', 'Article 5', 'Business',500);

INSERT INTO Editor(Editor_ID, Edition_ID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO Reporter(Reporter_ID, Image_ID) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO Writes(journalist_id, article_id, Role) VALUES
(1, 1, 'Author'),
(1, 2, 'Advisor'),
(2, 2, 'Author'),
(3, 3, 'Author'),
(4, 4, 'Author'),
(5, 5, 'Author');

INSERT INTO ArticlePhotos(Article_id, img_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);