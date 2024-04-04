USE dkavisen;
DROP PROCEDURE IF EXISTS calculatePeriodicity;
DROP FUNCTION IF EXISTS countJournalists;
DROP TRIGGER IF EXISTS triggerCalculatePeriodicity;
DELIMITER //

CREATE PROCEDURE calculatePeriodicity(IN vTitle varchar(255))
BEGIN
    DECLARE r1,r2 DATE;

    SET r1 = (SELECT Release_Date FROM dkavisen.edition WHERE (Newspaper_Title = vTitle) ORDER BY Release_Date DESC LIMIT 1,1);
    SET r2 = (SELECT Release_Date FROM dkavisen.edition WHERE (Newspaper_Title = vTitle) ORDER BY Release_Date DESC LIMIT 1);

    UPDATE dkavisen.newspaper SET Periodicity = DATEDIFF(r2,r1) WHERE Title = vTitle;
END //

CREATE TRIGGER triggerCalculatePeriodicity
AFTER INSERT ON dkavisen.edition FOR EACH ROW
BEGIN
    DECLARE latestEdition varchar(255);

    SET latestEdition = (SELECT Newspaper_Title FROM dkavisen.edition WHERE Release_Date = (SELECT MAX(Release_date) FROM dkavisen.edition));

    CALL calculatePeriodicity(latestEdition);
END //

CREATE FUNCTION countJournalists() RETURNS INT
BEGIN
    DECLARE vJourns INT;
    SELECT COUNT(*) INTO vJourns FROM journalist;
    RETURN vJourns;
END //

DELIMITER ;


/*
INSERT, UPDATE and DELETE Statements
*/

INSERT INTO Article (Release_Date, Title, Topic, View_Count)
VALUES ('2024-04-05', 'Spring Festival', 'Culture', 0);

UPDATE Article
SET View_Count = View_Count + 20
WHERE Title = 'Article 1';


SELECT * FROM editor WHERE Editor_ID = (SELECT CPR_NUMBER FROM journalist WHERE First_name = 'Jack' AND Last_name = 'Brown');
DELETE FROM editor WHERE  Editor_ID = (SELECT CPR_NUMBER FROM journalist WHERE First_name = 'Jack' AND Last_name = 'Brown');
SELECT * FROM journalistphonenumbers WHERE CPR_NUMBER = (SELECT  CPR_NUMBER FROM journalist WHERE First_name = 'Jack' AND Last_name = 'Brown');
DELETE FROM journalistphonenumbers WHERE CPR_NUMBER = (SELECT  CPR_NUMBER FROM journalist WHERE First_name = 'Jack' AND Last_name = 'Brown');
DELETE FROM Journalist
WHERE First_name = 'Jack' AND Last_name = 'Brown';