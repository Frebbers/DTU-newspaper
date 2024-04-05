use dkavisen;

INSERT INTO Article (Release_Date, Title, Topic, View_Count)
VALUES ('2024-04-05', 'Spring Festival', 'Culture', 0);

UPDATE Article
SET View_Count = View_Count + 20
WHERE Title = 'Article 1';


SELECT * FROM editor WHERE Editor_ID = (SELECT CPR_NUMBER FROM journalist WHERE First_name = 'Jack' AND Last_name = 'Brown');
DELETE FROM editor WHERE  Editor_ID = (SELECT CPR_NUMBER FROM journalist WHERE First_name = 'Jack' AND Last_name = 'Brown');
SELECT * FROM journalistphonenumbers WHERE CPR_NUMBER = (SELECT  CPR_NUMBER FROM journalist WHERE First_name = 'Jack' AND Last_name = 'Brown');
DELETE FROM journalistphonenumbers WHERE CPR_NUMBER = (SELECT  CPR_NUMBER FROM journalist WHERE First_name = 'Jack' AND Last_name = 'Brown');
DELETE FROM reporter WHERE Reporter_id = (SELECT CPR_NUMBER FROM journalist WHERE First_name = 'Jack' AND Last_name = 'Brown');
DELETE FROM writes WHERE journalist_id = (SELECT CPR_NUMBER FROM journalist WHERE First_name = 'Jack' AND Last_name = 'Brown');
DELETE FROM Journalist
WHERE First_name = 'Jack' AND Last_name = 'Brown';