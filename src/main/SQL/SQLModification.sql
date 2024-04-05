use dkavisen;

INSERT INTO Article (Release_Date, Title, Edition_Title, Edition_Release_date, Topic, View_Count)
VALUES ('2023-01-06', 'Article 11', 'The Times', '2023-01-01', 'Crime', 0);

UPDATE Article
SET View_Count = View_Count + 20
WHERE Title = 'Article 1';


SELECT * FROM editor WHERE Editor_ID = (SELECT CPR_NUMBER FROM journalist WHERE First_name = 'Jack' AND Last_name = 'Brown');
DELETE FROM editor WHERE  Editor_ID = (SELECT CPR_NUMBER FROM journalist WHERE First_name = 'Jack' AND Last_name = 'Brown');
SELECT * FROM journalistphonenumbers WHERE CPR_NUMBER = (SELECT  CPR_NUMBER FROM journalist WHERE First_name = 'Jack' AND Last_name = 'Brown');
DELETE FROM journalistphonenumbers WHERE CPR_NUMBER = (SELECT  CPR_NUMBER FROM journalist WHERE First_name = 'Jack' AND Last_name = 'Brown');
DELETE FROM reporter WHERE Reporter_id = (SELECT CPR_NUMBER FROM journalist WHERE First_name = 'Jack' AND Last_name = 'Brown');
DELETE FROM writes WHERE journalist_CPR = (SELECT CPR_NUMBER FROM journalist WHERE First_name = 'Jack' AND Last_name = 'Brown');
DELETE FROM Journalist
WHERE First_name = 'Jack' AND Last_name = 'Brown';