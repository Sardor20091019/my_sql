SELECT
    SUBSTRING_INDEX(Name, ',', 1) AS Name,
    SUBSTRING_INDEX(Name, ',', -1) AS Surname
FROM TestMultipleColumns;

SELECT Strs
FROM TestPercent
WHERE Strs LIKE '%#%%' ESCAPE '#';

SELECT
    SUBSTRING_INDEX(Vals, '.', 1) AS Part1,
    SUBSTRING_INDEX(SUBSTRING_INDEX(Vals, '.', 2), '.', -1) AS Part2,
    SUBSTRING_INDEX(Vals, '.', -1) AS Part3
FROM Splitter;

SELECT REGEXP_REPLACE('1234ABC123456XYZ1234567890ADS', '[0-9]', 'X');

SELECT *
FROM testDots
WHERE LENGTH(Vals) - LENGTH(REPLACE(Vals, '.', '')) > 2;

SELECT texts, LENGTH(texts) - LENGTH(REPLACE(texts, ' ', '')) AS SpaceCount
FROM CountSpaces;

SELECT e.Name
FROM Employee e
JOIN Employee m ON e.ManagerId = m.Id
WHERE e.Salary > m.Salary;

SELECT
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    HIRE_DATE,
    TIMESTAMPDIFF(YEAR, HIRE_DATE, CURDATE()) AS YearsOfService
FROM Employees
WHERE TIMESTAMPDIFF(YEAR, HIRE_DATE, CURDATE()) BETWEEN 10 AND 15;

SELECT
    REGEXP_REPLACE('rtcfvty34redt', '[^0-9]', '') AS IntegerValues,
    REGEXP_REPLACE('rtcfvty34redt', '[0-9]', '') AS CharacterValues;

SELECT w1.Id
FROM weather w1, weather w2
WHERE DATEDIFF(w1.RecordDate, w2.RecordDate) = 1 AND w1.Temperature > w2.Temperature;

SELECT player_id, MIN(event_date) AS first_login
FROM Activity
GROUP BY player_id;

SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(fruit_list, ',', 3), ',', -1) AS ThirdFruit
FROM fruits;

SELECT SUBSTRING('sdgfhsdgfhs@121313131', n, 1) AS Character
FROM (
    SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10 UNION ALL SELECT 11 UNION ALL SELECT 12 UNION ALL SELECT 13 UNION ALL SELECT 14 UNION ALL SELECT 15 UNION ALL SELECT 16 UNION ALL SELECT 17 UNION ALL SELECT 18 UNION ALL SELECT 19 UNION ALL SELECT 20
) numbers
WHERE n <= LENGTH('sdgfhsdgfhs@121313131');

SELECT p1.id, CASE WHEN p1.code = 0 THEN p2.code ELSE p1.code END AS code
FROM p1
JOIN p2 ON p1.id = p2.id;

SELECT
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    HIRE_DATE,
    CASE
        WHEN TIMESTAMPDIFF(YEAR, HIRE_DATE, CURDATE()) < 1 THEN 'New Hire'
        WHEN TIMESTAMPDIFF(YEAR, HIRE_DATE, CURDATE()) BETWEEN 1 AND 5 THEN 'Junior'
        WHEN TIMESTAMPDIFF(YEAR, HIRE_DATE, CURDATE()) BETWEEN 5 AND 10 THEN 'Mid-Level'
        WHEN TIMESTAMPDIFF(YEAR, HIRE_DATE, CURDATE()) BETWEEN 10 AND 20 THEN 'Senior'
        ELSE 'Veteran'
    END AS EmploymentStage
FROM Employees;

SELECT VALS, REGEXP_SUBSTR(VALS, '^[0-9]+') AS StartingInteger
FROM GetIntegers;

SELECT
    Id,
    CONCAT(SUBSTRING(SUBSTRING_INDEX(Vals, ',', 1), 2, 1), SUBSTRING(SUBSTRING_INDEX(Vals, ',', 1), 1, 1), SUBSTRING(Vals, INSTR(Vals, ','))) AS SwappedVals
FROM MultipleVals;

SELECT player_id, device_id
FROM (
    SELECT
        player_id,
        device_id,
        ROW_NUMBER() OVER (PARTITION BY player_id ORDER BY event_date) as rn
    FROM Activity
) ranked_activity
WHERE rn = 1;

SELECT
    Area,
    Date,
    SalesLocal,
    SalesRemote,
    DayName,
    DayOfWeek,
    FinancialWeek,
    MonthName,
    FinancialYear,
    (SalesLocal * 100.0) / SUM(SalesLocal + SalesRemote) OVER (PARTITION BY FinancialWeek, FinancialYear) AS PercentageSalesLocal,
    (SalesRemote * 100.0) / SUM(SalesLocal + SalesRemote) OVER (PARTITION BY FinancialWeek, FinancialYear) AS PercentageSalesRemote
FROM WeekPercentagePuzzle;
