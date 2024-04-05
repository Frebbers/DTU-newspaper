USE dkavisen;
DROP PROCEDURE IF EXISTS calculatePeriodicity;
DROP FUNCTION IF EXISTS countJournalists;
DROP TRIGGER IF EXISTS triggerCalculatePeriodicity;
DROP TRIGGER IF EXISTS Image_Before_Delete;
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

CREATE TRIGGER Image_After_Delete
AFTER DELETE ON dkavisen.reporter FOR EACH ROW
BEGIN
    UPDATE dkavisen.image SET Reporter_id = null WHERE Reporter_id = OLD.Reporter_ID;
END //

CREATE FUNCTION countJournalists() RETURNS INT
BEGIN
    DECLARE vJourns INT;
    SELECT COUNT(*) INTO vJourns FROM journalist;
    RETURN vJourns;
END //

DELIMITER ;