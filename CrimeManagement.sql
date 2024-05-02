CREATE DATABASE CrimeManagement
USE CrimeManagement

CREATE TABLE Crime (
 CrimeID INT PRIMARY KEY,
 IncidentType VARCHAR(255),
 IncidentDate DATE,
 Age INT,
 Location VARCHAR(255),
 Description TEXT,
 Status VARCHAR(20)
);
CREATE TABLE Victim (
 VictimID INT PRIMARY KEY,
 CrimeID INT,
 Name VARCHAR(255),
 ContactInfo VARCHAR(255),
 Injuries VARCHAR(255),
 Age INT,
 FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID)
);
CREATE TABLE Suspect (
 SuspectID INT PRIMARY KEY,
 CrimeID INT,
 Name VARCHAR(255),
 Description TEXT,
 CriminalHistory TEXT,
 Age INT,
 FOREIGN KEY (CrimeID) REFERENCES Crime(CrimeID)
);
-- Insert sample data
INSERT INTO Crime (CrimeID, IncidentType, IncidentDate,Age, Location, Description, Status)
VALUES
 (1, 'Robbery', '2023-09-15',23, '123 Main St, Cityville', 'Armed robbery at a convenience store', 'Open'),
 (2, 'Homicide', '2023-09-20',19, '456 Elm St, Townsville', 'Investigation into a murder case', 'Under
Investigation'),
 (3, 'Theft', '2023-09-10',11, '789 Oak St, Villagetown', 'Shoplifting incident at a mall', 'Closed');
INSERT INTO Victim (VictimID, CrimeID, Name, ContactInfo, Injuries,Age)
VALUES
 (1, 1, 'John Doe', 'johndoe@example.com', 'Minor injuries',30),
 (2, 2, 'Jane Smith', 'janesmith@example.com', 'Deceased',29),
 (3, 3, 'Alice Johnson', 'alicejohnson@example.com', 'None',41);
INSERT INTO Suspect (SuspectID, CrimeID, Name, Description, CriminalHistory,Age)
VALUES
 (1, 1, 'Robber 1', 'Armed and masked robber', 'Previous robbery convictions',21),
 (2, 2, 'Unknown', 'Investigation ongoing', NULL,42),
 (3, 3, 'Suspect 1', 'Shoplifting suspect', 'Prior shoplifting arrests',34);


 --1. Select all open incidents.
SELECT * FROM Crime WHERE Status = 'Open';

--2. Find the total number of incidents
SELECT COUNT(*) AS TotalIncidents FROM Crime;

--3. List all unique incident types
SELECT DISTINCT IncidentType FROM Crime;

--4. Retrieve incidents that occurred between '2023-09-01' and '2023-09-10'.
SELECT * FROM Crime WHERE IncidentDate BETWEEN '2023-09-01' AND '2023-09-10';

--5. List persons involved in incidents in descending order of age.
SELECT IncidentType , Age FROM Crime ORDER BY Age DESC

--6. Find the average age of persons involved in incidents.
FROM Crime
WHERE Status = 'Open'
GROUP BY IncidentType;

--8. Find persons with names containing 'Doe'.
SELECT v.Name , c.status
FROM Victim V 
JOIN Crime C ON V.CrimeID = C.CrimeID
WHERE C.Status = 'Open' ;

-- Names of persons involved in closed cases
SELECT v.Name , C.Status
FROM Victim V
JOIN Crime C ON V.CrimeID = C.CrimeID
WHERE C.Status = 'Closed';
--10. List incident types where there are persons aged 30 or 35 involved.
FROM Crime C
JOIN Victim V ON C.CrimeID = V.CrimeID
WHERE c.Age BETWEEN 30 AND 35 

--11. Find persons involved in incidents of the same type as 'Robbery'.
SELECT V.Name
FROM Victim V
JOIN Crime C ON V.CrimeID = C.CrimeID
WHERE C.IncidentType = 'Robbery';

FROM Crime
WHERE Status = 'Open'
GROUP BY IncidentType
HAVING COUNT(*) > 1;
FROM Crime C
JOIN Suspect S ON C.CrimeID = S.CrimeID
JOIN Victim V ON S.Name = V.Name

FROM Crime C
LEFT JOIN Victim V ON C.CrimeID = V.CrimeID
LEFT JOIN Suspect S ON C.CrimeID = S.CrimeID;
FROM Crime C
JOIN Suspect S ON C.CrimeID = S.CrimeID
JOIN Victim V ON C.CrimeID = V.CrimeID
WHERE S.Age > (SELECT MAX(Age) FROM Victim WHERE CrimeID = C.CrimeID);

FROM Suspect S
JOIN Crime C ON S.CrimeID = C.CrimeID
GROUP BY S.Name
HAVING COUNT(DISTINCT C.CrimeID) > 1;
FROM Crime C
LEFT JOIN Suspect S ON C.CrimeID = S.CrimeID
WHERE S.Name = 'Unknown';

--18. List all cases where at least one incident is of type 'Homicide' and all other incidents are of type 'Robbery'

SELECT C1.*
FROM Crime C1
INNER JOIN Crime C2 ON C1.CrimeID = C2.CrimeID
WHERE C1.IncidentType = 'Homicide' AND C2.IncidentType = 'Robbery';
--'No Suspect' if there are none.
       ISNULL(S.Name, 'No Suspect') AS SuspectName,
       ISNULL(S.Description, 'No Suspect Description') AS SuspectDescription
FROM Crime C
LEFT JOIN Suspect S ON C.CrimeID = S.CrimeID;
FROM Suspect S
JOIN Crime C ON S.CrimeID = C.CrimeID
WHERE C.IncidentType IN ('Robbery', 'Assault');
