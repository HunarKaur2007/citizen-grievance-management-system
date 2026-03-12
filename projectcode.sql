/*CREATE TABLE Citizen (
    Citizen_ID NUMBER PRIMARY KEY,
    Name VARCHAR2(100) NOT NULL,
    Email VARCHAR2(100) UNIQUE NOT NULL,
    Phone VARCHAR2(20),
    Address VARCHAR2(255)
);
CREATE TABLE Department (
    Department_ID NUMBER PRIMARY KEY,
    Department_Name VARCHAR2(100) NOT NULL
);*/
/*CREATE TABLE Officer (
    Officer_ID NUMBER PRIMARY KEY,
    Name_O VARCHAR2(100) NOT NULL,
    Email_O VARCHAR2(100) UNIQUE NOT NULL,
    Department_ID NUMBER NOT NULL,
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)
);*/
/*CREATE TABLE Grievance (
    Grievance_ID NUMBER PRIMARY KEY,
    Citizen_ID NUMBER NOT NULL,
    Department_ID NUMBER NOT NULL,
    Officer_ID NUMBER,
    Title VARCHAR2(200),
    Description VARCHAR2(500),
    Status VARCHAR2(50),
    Created_Date DATE,
    FOREIGN KEY (Citizen_ID) REFERENCES Citizen(Citizen_ID),
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID),
    FOREIGN KEY (Officer_ID) REFERENCES Officer(Officer_ID)
);*/
/*CREATE TABLE Escalation (
    Escalation_ID NUMBER PRIMARY KEY,
    Grievance_ID NUMBER NOT NULL,
    Escalation_Date DATE,
    Reason VARCHAR2(300),
    FOREIGN KEY (Grievance_ID) REFERENCES Grievance(Grievance_ID)
);*/
/*CREATE TABLE Feedback (
    Feedback_ID NUMBER PRIMARY KEY,
    Grievance_ID NUMBER UNIQUE NOT NULL,
    Rating NUMBER CHECK (Rating BETWEEN 1 AND 5),
    Comments VARCHAR2(300),
    FOREIGN KEY (Grievance_ID) REFERENCES Grievance(Grievance_ID)
);*/
/*CREATE SEQUENCE Escalation_SEQ
START WITH 1
INCREMENT BY 1;*/
/*CREATE OR REPLACE PROCEDURE Insert_Citizen(
    p_Citizen_ID NUMBER,
    p_Name VARCHAR2,
    p_Email VARCHAR2,
    p_Phone VARCHAR2,
    p_Address VARCHAR2
)
IS
BEGIN
    INSERT INTO Citizen
    VALUES (p_Citizen_ID, p_Name, p_Email, p_Phone, p_Address);
END;
/*/
/*CREATE OR REPLACE PROCEDURE Insert_Department(
    p_Department_ID NUMBER,
    p_Department_Name VARCHAR2
)
IS
BEGIN
    INSERT INTO Department
    VALUES (p_Department_ID, p_Department_Name);
END;
/*/
/*CREATE OR REPLACE PROCEDURE Insert_Officer(
    p_Officer_ID NUMBER,
    p_Name VARCHAR2,
    p_Email VARCHAR2,
    p_Department_ID NUMBER
)
IS
BEGIN
    INSERT INTO Officer
    VALUES (p_Officer_ID, p_Name, p_Email, p_Department_ID);
END;
/*/
/*CREATE OR REPLACE PROCEDURE Insert_Grievance(
    p_Grievance_ID NUMBER,
    p_Citizen_ID NUMBER,
    p_Department_ID NUMBER,
    p_Officer_ID NUMBER,
    p_Title VARCHAR2,
    p_Description VARCHAR2
)
IS
BEGIN
    INSERT INTO Grievance
    VALUES (
        p_Grievance_ID,
        p_Citizen_ID,
        p_Department_ID,
        p_Officer_ID,
        p_Title,
        p_Description,
        'Pending',
        SYSDATE
    );
END;
/*/
/*CREATE OR REPLACE TRIGGER Auto_Escalation
AFTER UPDATE OF Status ON Grievance
FOR EACH ROW
BEGIN
    IF :NEW.Status = 'Escalated' THEN
        INSERT INTO Escalation
        VALUES (
            Escalation_SEQ.NEXTVAL,
            :NEW.Grievance_ID,
            SYSDATE,
            'Automatically escalated due to delay'
        );
    END IF;
END;
/*/
/*CREATE OR REPLACE TRIGGER Check_Feedback
BEFORE INSERT ON Feedback
FOR EACH ROW
DECLARE
    v_status VARCHAR2(50);
BEGIN
    SELECT Status INTO v_status
    FROM Grievance
    WHERE Grievance_ID = :NEW.Grievance_ID;

    IF v_status <> 'Resolved' THEN
        RAISE_APPLICATION_ERROR(-20001,
        'Feedback allowed only after grievance resolution');
    END IF;
END;
/*/
-- BEGIN
--     Insert_Department(1, 'Water Supply');
--     Insert_Department(2, 'Electricity');
-- END;
-- /
-- BEGIN
--     Insert_Officer(1, 'Mr. Sharma', 'sharma@gov.in', 1);
--     Insert_Officer(2, 'Ms. Verma', 'verma@gov.in', 2);
-- END;
-- /

-- BEGIN
--     Insert_Citizen(1, 'Aman', 'aman@gmail.com', '9876543210', 'Delhi');
--     Insert_Citizen(2, 'Riya', 'riya@gmail.com', '9123456789', 'Mumbai');
-- END;
-- /

-- BEGIN
--     Insert_Grievance(1, 1, 1, 1, 'Water leakage', 'Pipe leakage near home');
--     Insert_Grievance(2, 2, 2, 2, 'Power cut', 'No electricity since morning');
-- END;
-- /
-- UPDATE Grievance
-- SET Status = 'Escalated'
-- WHERE Grievance_ID = 1;
-- SELECT * FROM Escalation;
-- SELECT c.Name, g.Title, g.Status
-- FROM Citizen c
-- JOIN Grievance g ON c.Citizen_ID = g.Citizen_ID;
-- SELECT d.Department_Name, COUNT(g.Grievance_ID) AS Total_Grievances
-- FROM Department d
-- LEFT JOIN Grievance g ON d.Department_ID = g.Department_ID
-- GROUP BY d.Department_Name;
-- SELECT o.Name_O
-- FROM Officer o
-- LEFT JOIN Grievance g ON o.Officer_ID = g.Officer_ID
-- WHERE g.Grievance_ID IS NULL;

-- SELECT c.Name, g.Grievance_ID, g.Title, g.Status
-- FROM Citizen c
-- JOIN Grievance g ON c.Citizen_ID = g.Citizen_ID;

-- SELECT d.Department_Name, COUNT(g.Grievance_ID) AS Total_Grievances
-- FROM Department d
-- LEFT JOIN Grievance g ON d.Department_ID = g.Department_ID
-- GROUP BY d.Department_Name;

-- SELECT g.Grievance_ID, e.Escalation_Date, e.Reason
-- FROM Grievance g
-- JOIN Escalation e ON g.Grievance_ID = e.Grievance_ID;

-- SELECT o.Officer_ID, o.Name_O
-- FROM Officer o
-- LEFT JOIN Grievance g ON o.Officer_ID = g.Officer_ID
-- WHERE g.Grievance_ID IS NULL;

SELECT g.Grievance_ID, f.Rating, f.Comments
FROM Grievance g
JOIN Feedback f ON g.Grievance_ID = f.Grievance_ID;
















