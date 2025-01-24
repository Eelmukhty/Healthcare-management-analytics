SELECT * 
FROM [Health_care management system].DBO.Patient;

SELECT * 
FROM Billing;

SELECT *
FROM Appointment;

SELECT * 
FROM Doctor; 

SELECT *
FROM [Medical Procedure];

-- TO FIND OUT PATIENTs THAT UNDERGO ANY FORM OF SURGERY
SELECT [Appointment].AppointmentID,
       [Patient].PatientID,
	   [Patient].firstname,
	   [Patient].lastname,
	   p.ProcedureName Procedures

FROM [Health_care management system].dbo.Appointment as Appointment
INNER JOIN Patient
ON Appointment.PatientID = Patient.PatientID
INNER JOIN [Medical Procedure] p
ON p.AppointmentID = Appointment.AppointmentID
WHERE p.ProcedureName LIKE '%surgery'
ORDER BY p.ProcedureName ASC;


-- To find out the Doctors whose specialization is surgery
SELECT DoctorID,
       DoctorName Names,
	   Specialization
FROM Doctor
WHERE Specialization = 'Surgery';

-- TO FIND OUT WHICH PROCEDURE COST MORE AND WHICH COST LESS AND THE PATIENTS WHO UNDERGOES THESE PROCEDURES
-- For the Most Expensive
SELECT MP.ProcedureID,
       Patient.PatientID,
       MP.ProcedureName as Procedures,
	   Patient.firstname,
	   Patient.lastname,
	  Billing.Amount Cost
FROM [Health_care management system].dbo.[Medical Procedure] as MP
INNER JOIN Appointment a
ON MP.AppointmentID = a.AppointmentID
INNER JOIN Patient
ON patient.PatientID = a.PatientID
INNER JOIN Billing
ON Patient.PatientID = Billing.PatientID
ORDER BY Billing.Amount DESC;

-- for the less expensive procedure
SELECT MP.ProcedureID,
       Patient.PatientID,
       MP.ProcedureName as Procedures,
	   Patient.firstname,
	   Patient.lastname,
	   Billing.Amount cost
FROM [Health_care management system].dbo.[Medical Procedure] as MP
INNER JOIN Appointment a
ON MP.AppointmentID = a.AppointmentID
INNER JOIN Patient
ON patient.PatientID = a.PatientID
INNER JOIN Billing
ON Patient.PatientID = Billing.PatientID
ORDER BY Billing.Amount ASC;

-- or using Window function\
-- for the most expensive procedure
SELECT TOP 1
       MP.ProcedureID,
       Patient.PatientID,
       MP.ProcedureName as Procedures,
	   Patient.firstname,
	   Patient.lastname,
	   Billing.Amount as Cost
FROM [Health_care management system].dbo.[Medical Procedure] as MP
INNER JOIN Appointment a
ON MP.AppointmentID = a.AppointmentID
INNER JOIN Patient
ON patient.PatientID = a.PatientID
INNER JOIN Billing
ON Patient.PatientID = Billing.PatientID
ORDER BY Billing.Amount DESC;

---- And for the Top less expensive procedure
SELECT TOP 1
       MP.ProcedureID,
       Patient.PatientID,
       MP.ProcedureName as Procedures,
	   Patient.firstname,
	   Patient.lastname,
	   Billing.Amount Cost
FROM [Health_care management system].dbo.[Medical Procedure] as MP
INNER JOIN Appointment a
ON MP.AppointmentID = a.AppointmentID
INNER JOIN Patient
ON patient.PatientID = a.PatientID
INNER JOIN Billing
ON Patient.PatientID = Billing.PatientID
ORDER BY Billing.Amount ASC;

SELECT * 
FROM [Health_care management system].DBO.[Medical Procedure]

--- To find out the cost distribution by procedure type
--TOP 10
SELECT TOP 10
           ProcedureName as Procedures, AVG(B.Amount) as Cost
FROM      [Medical Procedure] M
INNER JOIN Appointment A
ON        A.AppointmentID = m.[AppointmentID]
INNER JOIN Billing B
ON        A.PatientID = B.PatientID
GROUP BY  ProcedureName
ORDER BY  Cost DESC;

-- Billing Analysis for frequent patients to Identify patients with multiple procedures and high cumulative 
--billing amounts
SELECT p.PatientID, p.firstname+' '+p.lastname as full_name, SUM(B.Amount) as cumulative_cost
FROM Patient P
INNER JOIN Billing B
ON P.PatientID = B.PatientID
GROUP BY p.PatientID,p.firstname,p.lastname
ORDER BY cumulative_cost DESC;

--- To find out if there are specific months with more appointments than others
SELECT 
    DATENAME(MONTH, Appointment.Date) AS MonthName,
    COUNT(AppointmentID) AS AppointmentCount
FROM Appointment
GROUP BY DATENAME(MONTH, Appointment.Date), MONTH(Date)
ORDER BY AppointmentCount DESC ;


---To categorize each appointment by season
SELECT 
    AppointmentID,
    Date,
    DATENAME(MONTH, Date) AS MonthName,
    CASE 
        WHEN MONTH(Date) IN (12, 1, 2) THEN 'Winter'
        WHEN MONTH(Date) BETWEEN 3 AND 5 THEN 'Spring'
        WHEN MONTH(Date) BETWEEN 6 AND 8 THEN 'Summer'
        WHEN MONTH(Date) BETWEEN 9 AND 11 THEN 'Fall'
        ELSE 'Unknown' 
    END AS Season
FROM Appointment;

 

---To find out number of appointments based on seasons
SELECT 
    CASE 
        WHEN MONTH(Date) IN (12, 1, 2) THEN 'Winter'
        WHEN MONTH(Date) BETWEEN 3 AND 5 THEN 'Spring'
        WHEN MONTH(Date) BETWEEN 6 AND 8 THEN 'Summer'
        WHEN MONTH(Date) BETWEEN 9 AND 11 THEN 'Fall'
        ELSE 'Unknown'
    END AS Season,
    COUNT(AppointmentID) AS AppointmentCount
FROM Appointment
GROUP BY 
    CASE 
        WHEN MONTH(Date) IN (12, 1, 2) THEN 'Winter'
        WHEN MONTH(Date) BETWEEN 3 AND 5 THEN 'Spring'
        WHEN MONTH(Date) BETWEEN 6 AND 8 THEN 'Summer'
        WHEN MONTH(Date) BETWEEN 9 AND 11 THEN 'Fall'
        ELSE 'Unknown'
    END;
---To find out Doctor's performances and procedure counts
SELECT
       DISTINCT d.DoctorID,
	   d.doctorName,
	   m.procedureName,
       m.AppointmentID as Appointments,
	   COUNT(m.ProcedureID) AS procedureCount
FROM Doctor d
INNER JOIN Appointment a
ON d.DoctorID = a.DoctorID
INNER JOIN [Medical Procedure] m
ON m.AppointmentID = a.AppointmentID
GROUP BY M.AppointmentID, d.DoctorID, DoctorName, m.procedureName
ORDER BY Appointments DESC;




