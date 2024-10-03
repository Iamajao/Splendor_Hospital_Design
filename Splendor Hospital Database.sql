 CREATE DATABASE Splendor_Hospital_Database;

 USE Splendor_Hospital_Database

 --STEP 1: I will be defining the tables I would be creating.
-- Patients Table : This would store the patients details iin the hospital.
-- Doctors Table : This would store the details about doctors in the hospital.
-- Appointments Table : This would store the appointment details encountered in the hospital
-- Department Table : This would store the information about hospital departments.
-- Medical Records Table : This would store the medical history,allergies,diagnoses,prescribed medicines,etc.

  CREATE TABLE Patients (
	Patients_ID INT PRIMARY KEY IDENTITY (1, 1),
	Full_Name VARCHAR(50) NOT NULL,
	Address VARCHAR(100) NOT NULL,
	Date_Of_Birth DATE NOT NULL,
	Gender CHAR (1),
	Insurance VARCHAR(50),
	Username VARCHAR(50) UNIQUE NOT NULL,
	Password VARCHAR(50) not null,
	Email VARCHAR (100),
	Phone_Number VARCHAR (15),
	Date_Left DATE
);
-- Add new column called marital_status
ALTER TABLE Patients
ADD Marital_Status VARCHAR(25) CHECK (Marital_Status IN('Married','Single','Divorced','Separated'));

-- -- I need to check if my table as been created by running a query to see all the columns in the patient table.

SELECT * FROM Patients;



-- DEPARTMENTS TABLE
-- I used INT datatype for the DepartmentID and set is as the primary key while using the IDENTITY function for the autoincrement.
-- I used VARCHAR for the text column Department_Name and set it to NOT NULL to avoid blanks.

CREATE TABLE Departments (
    Department_ID INT PRIMARY KEY IDENTITY(1,1),
    Department_Name NVARCHAR(100) NOT NULL
);

SELECT * FROM Departments ;


-- Doctors Table
-- I used the VARCHAR datatype for the text column (full_name,specialty) and INT datatype for the DoctorID & DepartmentID,
---while setting the text column to NOT NULL.
 --The DoctorID is the primary key and I will be using an IDENTITY function to set it to autoincrement , in order to connect the table,
 --I will be using the DepartmentID as the FOREIGN KEY while REFERENCING it on the Departments table.
 

 CREATE TABLE Doctors (
	Doctor_ID INT PRIMARY KEY IDENTITY (1, 1),
	Full_Name VARCHAR (100) NOT NULL,
	Specialty VARCHAR (50) NOT NULL,
	Department_ID INT,
	Rank VARCHAR(50) CHECK (Rank IN('Senior','Specialist', 'Consultant','Junior'))
	FOREIGN KEY (Department_ID) REFERENCES Departments(Department_ID)
);

SELECT * FROM Doctors;


-- APPOINTMENT TABLE
-- I used the appointmentID as the primary key with INT datatype, patientID & doctorID was set to be foreign key and the REFERENCES constraints was used to reference the patients table and doctors table.
-- I used the datetime datatype for the AppointmentDate while using  the CHECK constraints to validate the status has one of the valued allowed (Pending,Cancelled & Completed), 
-- I set the text column to VARCHAR datatype (Status)

CREATE TABLE Appointments (
    Appointment_ID INT PRIMARY KEY IDENTITY(1,1),
    Patients_ID INT NOT NULL,
    Doctor_ID INT NOT NULL,
    AppointmentDate DATETIME NOT NULL,
	CONSTRAINT chk_appointment_date CHECK (AppointmentDate >= GETDATE()),
    Status NVARCHAR(20) CHECK (Status IN ('pending', 'cancelled', 'completed')),
    FOREIGN KEY (Patients_ID) REFERENCES Patients(Patients_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctors(Doctor_ID),
);

SELECT * FROM Appointments;

-- MEDICAL RECORDS

-- Record_ID was used as the primary key for the table while using the INT datatype and setting the IDENTITY constraints for autoincrement.
-- Patient_ID was set to NOT NULL and INT datatype was used.
-- AppointmentId was set to NUT NULL and INT datatype was used.
-- Diagnosis, Medicines & Allergies was set to VARCHAR(255) as they are a text column.
-- The DATE datatype was used for the Prescribed_Date 
-- I used the TEXT datatype for the Diagnosis History
-- I made the patient_id and appointment_id a foreign key so I can reference it in the two tables( Patient and Appointment).

CREATE TABLE Medical_Records (
	Record_ID INT PRIMARY KEY IDENTITY (1, 1),
	Patients_ID INT NOT NULL,
	Appointment_ID INT NOT NULL,
	Diagnosis VARCHAR (255),
	Medicines VARCHAR (255),
	Allergies VARCHAR (255),
	Prescribed_Date DATE,
	Diagnosis_History TEXT,
	Department_ID INT NOT NULL,
	FOREIGN KEY (Department_ID) REFERENCES Departments(Department_ID),
	FOREIGN KEY (Patients_ID) REFERENCES Patients(Patients_ID),
	FOREIGN KEY (Appointment_ID) REFERENCES Appointments(Appointment_ID)
);

SELECT* FROM Medical_Records;


-- Inserting value into the tables.

-- PATIENTS TABLE

INSERT INTO Patients (Full_Name, Address, Date_Of_Birth, Gender, Insurance, Username, Password, Email, Phone_Number, Date_Left, Marital_Status)
VALUES 
('John Doe', '123 Elm St', '1980-01-01', 'M', 'Insurance A', 'johndoe1', 'password1', 'johndoe1@example.com', '1234567890', NULL, 'Single'),
('Jane Smith', '456 Oak St', '1990-02-02', 'F', 'Insurance B', 'janesmith2', 'password2', 'janesmith2@example.com', '0987654321', NULL, 'Married'),
('Michael Johnson', '789 Pine St', '1985-03-03', 'M', 'Insurance C', 'michaelj3', 'password3', 'michaelj3@example.com', '2345678901', NULL, 'Divorced'),
('Emily Davis', '321 Maple St', '1995-04-04', 'F', 'Insurance D', 'emilyd4', 'password4', 'emilyd4@example.com', '3456789012', NULL, 'Separated'),
('Chris Brown', '654 Cedar St', '1982-05-05', 'M', 'Insurance E', 'chrisb5', 'password5', 'chrisb5@example.com', '4567890123', NULL, 'Single'),
('Olivia Wilson', '987 Birch St', '1993-06-06', 'F', 'Insurance F', 'oliviaw6', 'password6', 'oliviaw6@example.com', '5678901234', NULL, 'Married'),
('James Miller', '135 Spruce St', '1988-07-07', 'M', 'Insurance G', 'jamesm7', 'password7', 'jamesm7@example.com', '6789012345', NULL, 'Divorced'),
('Sophia Garcia', '246 Walnut St', '1992-08-08', 'F', 'Insurance H', 'sophiag8', 'password8', 'sophiag8@example.com', '7890123456', NULL, 'Separated'),
('William Martinez', '369 Chestnut St', '1987-09-09', 'M', 'Insurance I', 'williamm9', 'password9', 'williamm9@example.com', '8901234567', NULL, 'Single'),
('Ava Hernandez', '159 Fir St', '1994-10-10', 'F', 'Insurance J', 'avah10', 'password10', 'avah10@example.com', '9012345678', NULL, 'Married'),
('Noah Anderson', '753 Ash St', '1981-11-11', 'M', 'Insurance K', 'noaha11', 'password11', 'noaha11@example.com', '0123456789', NULL, 'Divorced'),
('Isabella Thomas', '852 Palm St', '1996-12-12', 'F', 'Insurance L', 'isabellat12', 'password12', 'isabellat12@example.com', '1231231234', NULL, 'Separated'),
('Liam Jackson', '963 Maplewood St', '1984-01-13', 'M', 'Insurance M', 'liamj13', 'password13', 'liamj13@example.com', '2342342345', NULL, 'Single'),
('Mia White', '147 Maple Grove St', '1997-02-14', 'F', 'Insurance N', 'miaw14', 'password14', 'miaw14@example.com', '3453453456', NULL, 'Married'),
('Elijah Harris', '258 Cedar Hollow St', '1991-03-15', 'M', 'Insurance O', 'elijahh15', 'password15', 'elijahh15@example.com', '4564564567', NULL, 'Divorced'),
('Charlotte Clark', '369 Birch Ridge St', '1983-04-16', 'F', 'Insurance P', 'charlottec16', 'password16', 'charlottec16@example.com', '5675675678', NULL, 'Separated'),
('Lucas Lewis', '147 Ash Valley St', '1989-05-17', 'M', 'Insurance Q', 'lucasl17', 'password17', 'lucasl17@example.com', '6786786789', NULL, 'Single'),
('Amelia Lee', '258 Pine River St', '1998-06-18', 'F', 'Insurance R', 'amelial18', 'password18', 'amelial18@example.com', '7897897890', NULL, 'Married'),
('Aiden Walker', '369 Cedar Creek St', '1986-07-19', 'M', 'Insurance S', 'aidenw19', 'password19', 'aidenw19@example.com', '8908908901', NULL, 'Divorced'),
('Harper Hall', '456 Oak Hill St', '1992-08-20', 'F', 'Insurance T', 'harperh20', 'password20', 'harperh20@example.com', '9019019012', NULL, 'Separated');


SELECT * FROM Patients;


--INSERT INTO DEPARTMENT TABLE

INSERT INTO Departments(Department_Name)
VALUES 
('Cardiology'),
('Neurology'),
('Pediatrics'),
('Orthopedics'),
('Oncology'),
('Dermatology'),
('Radiology'),
('Emergency Medicine'),
('Internal Medicine'),
('Gastroenterology'),
('Endocrinology'),
('Psychiatry'),
('Ophthalmology'),
('Anesthesiology'),
('Pathology'),
('Urology'),
('Rheumatology'),
('Obstetrics'),
('Gynecology'),
('Family Medicine'),
('Pulmonology');

SELECT * FROM Departments;


--INSERT INTO DOCTORS TABLE


INSERT INTO Doctors (Full_Name, Specialty, Department_ID, Rank) 
VALUES 
    ('Dr. John Smith', 'Cardiology', 1, 'Consultant'),
    ('Dr. Emily Davis', 'Neurology', 2, 'Senior'),
    ('Dr. Michael Brown', 'Pediatrics', 3, 'Specialist'),
    ('Dr. Sarah Wilson', 'Orthopedics', 1, 'Junior'),
    ('Dr. David Johnson', 'Oncology', 2, 'Consultant'),
    ('Dr. Laura Martinez', 'Dermatology', 3, 'Senior'),
    ('Dr. Daniel Garcia', 'Radiology', 1, 'Specialist'),
    ('Dr. Jessica Lee', 'Emergency Medicine', 2, 'Junior'),
    ('Dr. Thomas Hall', 'Gastroenterology', 3, 'Consultant'),
    ('Dr. Mary Robinson', 'Anesthesiology', 1, 'Senior'),
    ('Dr. William Clark', 'Psychiatry', 2, 'Specialist'),
    ('Dr. Patricia Lewis', 'Pathology', 3, 'Junior'),
    ('Dr. Charles Walker', 'Urology', 1, 'Consultant'),
    ('Dr. Barbara Allen', 'Obstetrics', 2, 'Senior'),
    ('Dr. Joseph Young', 'Endocrinology', 3, 'Specialist'),
    ('Dr. Elizabeth King', 'Infectious Disease', 1, 'Junior'),
    ('Dr. Kevin Wright', 'Ophthalmology', 2, 'Consultant'),
    ('Dr. Jennifer Scott', 'Family Medicine', 3, 'Senior'),
    ('Dr. George Hill', 'Surgery', 1, 'Specialist'),
    ('Dr. Nancy Adams', 'Pulmonology', 2, 'Junior');


	SELECT * FROM Doctors;

-- INSERT INTO APPOINTMENTS TABLE

INSERT INTO Appointments(Patients_ID,Doctor_ID, AppointmentDate, Status)
VALUES
(21, 1, '2024-10-05 10:00:00', 'pending'),
(22, 2, '2024-10-06 11:30:00', 'completed'),
(23, 3, '2024-10-07 09:15:00', 'pending'),
(24, 4, '2024-10-08 14:00:00', 'cancelled'),
(25, 5, '2024-10-09 13:45:00', 'pending'),
(26, 6, '2024-10-10 08:30:00', 'completed'),
(27, 7, '2024-10-11 10:45:00', 'pending'),
(28, 8, '2024-10-12 12:00:00', 'cancelled'),
(29, 9, '2024-10-13 15:15:00', 'pending'),
(30, 10, '2024-10-14 16:30:00', 'completed'),
(31, 11, '2024-10-15 09:00:00', 'pending'),
(32, 12, '2024-10-16 11:00:00', 'completed'),
(33, 13, '2024-10-17 14:45:00', 'cancelled'),
(34, 14, '2024-10-18 08:15:00', 'pending'),
(35, 15, '2024-10-19 10:30:00', 'completed'),
(36, 16, '2024-10-20 13:00:00', 'pending'),
(37, 17, '2024-10-21 16:45:00', 'cancelled'),
(38, 18, '2024-10-22 12:30:00', 'completed'),
(39, 19, '2024-10-23 09:45:00', 'pending'),
(40, 20, '2024-10-24 15:30:00', 'completed');


SELECT * FROM Appointments;



-- INSERT INTO MEDICAL_RECORDS

INSERT INTO Medical_Records(Patients_ID, Appointment_ID, Diagnosis, Medicines, Allergies, Prescribed_Date, Diagnosis_History, Department_ID)
VALUES
(21, 3, 'Hypertension', 'Lisinopril', 'None', '2024-09-01', 'Patient has a history of high blood pressure.', 1),
(22, 4, 'Diabetes', 'Metformin', 'Peanuts', '2024-09-02', 'Patient diagnosed with Type 2 Diabetes.', 2),
(23, 5, 'Asthma', 'Albuterol', 'None', '2024-09-03', 'Patient has a history of asthma.', 1),
(24, 6, 'Bronchitis', 'Bronchodilators', 'None', '2024-09-04', 'Patient presents with chronic cough.', 3),
(25, 7, 'Flu', 'Oseltamivir', 'Eggs', '2024-09-05', 'Patient shows symptoms of flu.', 2),
(26, 8, 'Allergic Rhinitis', 'Antihistamines', 'Dust', '2024-09-06', 'Patient has seasonal allergies.', 1),
(27, 9, 'Gastritis', 'Proton Pump Inhibitors', 'None', '2024-09-07', 'Patient reports stomach discomfort.', 3),
(28, 10, 'Arthritis', 'Ibuprofen', 'Aspirin', '2024-09-08', 'Patient has joint pain.', 2),
(29, 11, 'Hyperlipidemia', 'Statins', 'None', '2024-09-09', 'Patient has high cholesterol.', 1),
(30, 12, 'Migraine', 'Triptans', 'None', '2024-09-10', 'Patient reports frequent headaches.', 3),
(31, 13, 'Hypothyroidism', 'Levothyroxine', 'None', '2024-09-11', 'Patient has low thyroid hormone.', 2),
(32, 14, 'Osteoporosis', 'Calcium Supplements', 'None', '2024-09-12', 'Patient has low bone density.', 1),
(33, 15, 'Anxiety', 'SSRIs', 'None', '2024-09-13', 'Patient has anxiety disorder.', 3),
(34, 16, 'Depression', 'Antidepressants', 'None', '2024-09-14', 'Patient reports feeling down.', 2),
(35, 17, 'Psoriasis', 'Topical Steroids', 'None', '2024-09-15', 'Patient has skin condition.', 1),
(36, 18, 'Chronic Fatigue Syndrome', 'Lifestyle Changes', 'None', '2024-09-16', 'Patient has ongoing fatigue.', 3),
(37, 19, 'Gout', 'Colchicine', 'None', '2024-09-17', 'Patient presents with joint swelling.', 2),
(38, 20, 'Sleep Apnea', 'CPAP Machine', 'None', '2024-09-18', 'Patient has trouble sleeping.', 1),
(39, 21, 'Irritable Bowel Syndrome', 'Dietary Changes', 'None', '2024-09-19', 'Patient has gastrointestinal issues.', 3),
(40, 22, 'Dementia', 'Cognitive Enhancers', 'None', '2024-09-20', 'Patient shows signs of memory loss.', 2);

SELECT * FROM Medical_Records;

-- List all Patients older than 30 with Asthma in their Diagnosis
-- I used the JOIN function between the medical_records and patients table



SELECT P.Full_Name, P.Date_Of_Birth, MR.Diagnosis
FROM Patients P
JOIN Medical_Records MR ON P.Patients_ID = MR.Patients_ID
WHERE MR.Diagnosis LIKE '%Asthma%'
AND DATEDIFF(YEAR, P.Date_Of_Birth, GETDATE()) > 30;


--  Query to Identify Number of Completed Appointments for Pathology

SELECT COUNT(*) AS Completed_Appointments
FROM Appointments A
JOIN Doctors D ON A.Doctor_ID = D.Doctor_ID
WHERE A.Status = 'completed'
AND D.Specialty = 'Pathology';