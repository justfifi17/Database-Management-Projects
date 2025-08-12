
create database FourImagesStudio;

use FourImagesStudio;
-- create StudioAddress table
CREATE TABLE StudioAddress(
	zip CHAR(5) PRIMARY KEY,
    street VARCHAR(20),
    city VARCHAR(10),
    state CHAR(2)
);

-- insert values into studioAddress
INSERT INTO StudioAddress (zip, street, city, state) VALUES
( '10101', '123 Main Street', 'Fremont', 'CA');

select * from StudioAddress;

-- Create Studio table
CREATE TABLE Studio (
    StudioName VARCHAR(20) PRIMARY KEY,
    PhoneNumber1 VARCHAR(20),
    PhoneNumber2 VARCHAR(20),
    zip CHAR(5), 
    FOREIGN KEY (zip) REFERENCES StudioAddress(zip) 
);

-- insert values into studio
INSERT INTO Studio (StudioName, PhoneNumber1, PhoneNumber2, zip) VALUES
('Four Images Studio', '123-456-7890', '345-456-2345', '10101');

select * from Studio;

-- Create Staff table
CREATE TABLE Staff (
    StaffID CHAR(2) PRIMARY KEY,
    StafflastName VARCHAR(10),
	StaffFirstName VARCHAR(10),
    Email VARCHAR(100),
    StudioName VARCHAR(20),
    FOREIGN KEY (StudioName) REFERENCES Studio(StudioName)
);

INSERT INTO Staff (StaffID, StafflastName, StaffFirstName, Email, StudioName) VALUES
('s1', 'Liz',  'Davis', 'LizD@fourimage.studio', 'Four Images Studio'), -- manager 
('s2', 'Bob', 'Smith', 'bob.smith@fourimage.studio', 'Four Images Studio'), -- office manager 
('s3', 'Angel', 'Matt', 'mattAng@fourimages.studio', 'Four Images Studio'), -- receptionist
('s4', 'Jackob', 'Mariam', 'maryJ@fourimages.studio', 'Four Images Studio'), -- receptionist
('s5', 'Tim', 'Rose', 'rosiT@fourimages.studio', 'Four Images Studio'), -- receptionist
('s6', 'Alex', 'Ken', 'ken34@fourimages.studio', 'Four Images Studio'); -- receptionist

select * from Staff;


-- Create Service table
CREATE TABLE Service (
    ServiceID INT PRIMARY KEY,
    Type VARCHAR(100),
    StudioName VARCHAR(20),
    FOREIGN KEY (StudioName) REFERENCES Studio(StudioName)
);

select * from Service;

INSERT INTO Service (ServiceID, Type, StudioName) VALUES
(1, 'Individual Sitting',  'Four Images Studio'),
(2,  'Family Sitting', 'Four Images Studio'),
(3, 'Wedding Photography', 'Four Images Studio'),
(4, 'Business Conference',  'Four Images Studio'),
(5, 'Product Photography', 'Four Images Studio'),
(6,'Award Ceremony', 'Four Images Studio'),
(7,'Graduation Photoshoot', 'Four Images Studio'),
(8,'Fashion Photoshoot', 'Four Images Studio');


select * from Service;

-- Create Photographer table
CREATE TABLE Photographer (
    PhotographerID CHAR(2) PRIMARY KEY,
    PfirstName VARCHAR(20),
    PLastName VARCHAR(20),
    Pemail VARCHAR(30),
    Availability VARCHAR(100)
);

select * from Photographer;

INSERT INTO Photographer (PhotographerID, PfirstName, PlastName, Pemail, Availability) VALUES
('p1', 'Benjamin', 'Doe', 'benjd1@fourimages.studio', 'Monday, Tuesday, Friday'), -- photographer 
('p2', 'Mia', 'Smith', 'mia.smith2@fourimages.studio', 'Tuesday, Thursday, Saturday'), -- photographer 
('p3', 'Jacob', 'Johnson', 'jacob.john3@fourimages.studio', 'Monday, Wednesday, Saturday'), -- photographer 
('p4', 'Lily', 'Brown', 'lily.brown4@fourimages.studio', 'Tuesday, Thursday, Sunday'), -- photographer 
('p5', 'Andrew', 'Wilson', 'andrew.wil5@fourimages.studio', 'Monday, Wednesday, Sunday'), -- photographer 
('f1', 'Nate', 'Martinez', 'nate.mart@fourimages.studio', 'Tuesday, Thursday, Sunday'), -- freelancer 
('f2', 'Samuel', 'Lee', 'sam.lee@fourimages.studio', 'Wednesday, Friday, Sunday'), -- freelancer 
('f3', 'Bard', 'Taylor', 'bard.taylor@fourimages.studio', 'Monday, Thursday, Friday'), -- freelancer 
('f4', 'George', 'Rodriguez', 'george.rod@fourimages.studio', 'Tuesday, Friday, Sunday'), -- freelancer 
('f5', 'Joly', 'Garcia', 'jolyG@fourimages.studio', 'Monday, Saturday, Sunday'); -- freelancer 

-- Add the StaffID column to the Photographer table to make relation between them
ALTER TABLE Photographer ADD COLUMN StaffID CHAR(2);

-- Update  Photographer table to set the StaffID values 
-- for photographers, we will have the manager linked as foreign key
UPDATE Photographer 
SET StaffID = 
    's1' 
WHERE PhotographerID IN ('p1', 'p2', 'p3', 'p4', 'p5');

-- for freelancers, we will have the office manager linked as foreign key
UPDATE Photographer 
SET StaffID = 
    's2' 
WHERE PhotographerID IN ('f1', 'f2', 'f3', 'f4', 'f5');

select * from Photographer;


-- Create Client table
CREATE TABLE Client (
    ClientID VARCHAR(5) PRIMARY KEY,
    ClientlastName VARCHAR(10),
    ClientfirstName VARCHAR(10),
    ClientEmail VARCHAR(20),
    StudioName VARCHAR(20),
    selectedPhotographer CHAR(2),
    FOREIGN KEY (StudioName) REFERENCES Studio(StudioName),
	FOREIGN KEY (selectedPhotographer) REFERENCES Photographer(PhotographerID)
);
select * from Client;

INSERT INTO Client (ClientID, ClientlastName, ClientfirstName, ClientEmail, StudioName, selectedPhotographer) VALUES
('c1', 'John', 'Doe', 'john.doe@gmail.com', 'Four Images Studio', 'p3'),
('c2', 'Jane', 'Smith', 'jane.sm@gmail.com', 'Four Images Studio', 'p2'),
('c3', 'Michael', 'Johnson', 'mike.johns@gmail.com', 'Four Images Studio', 'p1'),
('c4', 'Emily', 'Brown', 'emily.br@gmail.com', 'Four Images Studio', 'p5'),
('c5', 'David', 'Wilson', 'david.wil@gmail.com', 'Four Images Studio', 'f2'),
('c6', 'Sarah', 'Martinez', 'sarah.mart@gmail.com', 'Four Images Studio', 'f4'),
('c7', 'Chris', 'Lee', 'chris.lee@gmail.com', 'Four Images Studio', 'f1'),
('c8', 'Amanda', 'Taylor', 'aman.tay@gmail.com', 'Four Images Studio', 'p4'),
('c9', 'Daniel', 'Rodriguez', 'dan.rodri@gmail.com', 'Four Images Studio', 'f3'),
('c10', 'Emma', 'Garcia', 'emma27@gmail.com', 'Four Images Studio', 'f5');
select * from Client;


-- Create Appointment table - assuming a client can only make one appointment in a day
CREATE TABLE Appointment (
	AppointmentID INT PRIMARY KEY, -- surrogate key 
    Date DATE,
    Time TIME,
    ClientID VARCHAR(5),
    FOREIGN KEY (ClientID) REFERENCES Client(ClientID)
);

Select * from Appointment;
INSERT INTO Appointment (AppointmentID, Date, Time, ClientID) VALUES
(100, '2024-01-27', '10:00:00', 'c3'),
(101, '2024-01-28', '11:00:00', 'c2'),
(102, '2024-01-28', '12:00:00', 'c1'),
(103, '2024-01-29', '13:00:00', 'c6'),
(104, '2024-01-29', '14:00:00', 'c5'),
(105, '2024-01-30', '15:00:00', 'c4'),
(106, '2024-02-01', '16:00:00', 'c10'),
(107, '2024-02-01', '17:00:00', 'c9'),
(108, '2024-02-02', '18:00:00', 'c8'),
(109, '2024-02-04', '19:00:00', 'c7');

select * from Appointment;

-- Create isGiven table that is the services that are and will be given for clients 
CREATE TABLE isGiven (
    ClientID VARCHAR(5),
    ServiceID INT,
    Rating INT,
    Date DATE,
    time TIME,
    Location VARCHAR(40),
    PRIMARY KEY (ClientID, ServiceID),
    FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
    FOREIGN KEY (ServiceID) REFERENCES Service(ServiceID)
);

select * from isGiven;
INSERT INTO isGiven (ClientID, ServiceID, Rating, Date, time, Location) VALUES
('c1', 2, 5, '2024-02-28', '11:00:00', 'Golden Gate Bridge, San Francisco' ),
('c2', 4, 4, '2024-02-20', '09:00:00', 'San Francisco Bay University, Fremont'),
('c3', 6, 5, '2024-02-27', '10:00:00', 'Moscone Center, San Francisco'),
('c4', 8, 3, '2024-02-25', '14:00:00','Studio' ),
('c5', 1, 5, '2024-02-23', '13:30:00','Studio'),
('c6', 5, 4, '2024-03-01', '11:00:00', 'Studio' ),
('c7', 3, 5, '2024-03-05', '10:00:00','Studio' ),
('c8', 7, 3, '2024-03-07', '11:00:00', 'San Jose University, San Jose'),
('c9', 2, 4, '2024-03-08', '14:00:00', 'Studio'),
('c10', 4, 5, '2024-03-10', '10:00:00', 'Studio');

select * from isGiven;

-- Create Contract table
CREATE TABLE Contract (
    ContractNumber VARCHAR(10) PRIMARY KEY,
    Date DATE,
    Terms VARCHAR(200),
    Deposit_in_$ DECIMAL (5,2),
    ClientID VARCHAR(5),
    StaffID CHAR(2),
    FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

select * from Contract;

INSERT INTO Contract (ContractNumber, Date, Terms, Deposit_in_$, ClientID, StaffID) VALUES
('C200', '2024-01-29', 'Final Package can be returned if not satisfied.', 100.00, 'c3', 's1'),
('C201', '2024-01-30', 'Final Package can be returned if not satisfied.', 100.00, 'c2', 's1'),
('C202', '2024-01-30', 'Deposit and Payments can not be refunded after service.', 100.00, 'c1', 's1'),
('C203', '2024-01-31', 'Deposit and Payments can not be refunded after service.', 100.00, 'c6', 's1' ),
('C204', '2024-01-31', 'Deposit and Payments can not be refunded after service.', 100.00, 'c5', 's1'),
('C205', '2024-02-01', 'Deposit and Payments can not be refunded after service.', 50.00, 'c4', 's1'),
('C206', '2024-02-03', 'Final Package can be returned if not satisfied.', 100.00, 'c10', 's1'),
('C207', '2024-02-03', 'Deposit and Payments can not be refunded after service.', 100.00, 'c9', 's1'),
('C208', '2024-02-04', 'Final Package can be returned if not satisfied.', 100.00, 'c8', 's1'),
('C209', '2024-02-05', 'Final Package can be returned if not satisfied.', 100.00, 'c7', 's1');

select * from Contract;


-- Create Schedule table of photographers 
CREATE TABLE Schedule (
    Date DATE,
    TimeSlot TIME,
    PhotographerID CHAR(2),
    Activity VARCHAR(200),
    PRIMARY KEY (Date, TimeSlot, PhotographerID),
    FOREIGN KEY (PhotographerID) REFERENCES Photographer(PhotographerID)
);

select * from Schedule;

INSERT INTO Schedule (Date, TimeSlot, PhotographerID, Activity) VALUES
('2024-02-27', '10:00:00', 'p1', 'Business Conference'), 
('2024-02-20', '11:00:00', 'p2', 'Graduation Photoshoot'), 
('2024-02-28', '12:00:00', 'p3', 'Wedding Photography'),
('2024-03-01', '13:00:00', 'f4', ' Fashion Photoshoot'), 
('2024-02-23', '14:00:00', 'f2', 'Family Sitting'), 
('2024-02-25', '15:00:00', 'p5', 'Group Portrait'), 
('2024-03-10', '16:00:00', 'f5', 'Fashion'),
('2024-03-08', '17:00:00', 'f3', 'Individual Sitting'), 
('2024-03-07', '18:00:00', 'p4', 'Award Ceremony'), 
('2024-03-05', '19:00:00', 'f1', 'Product Photography'); 

select * from Schedule;


-- Create Proof table
CREATE TABLE Proof (
    ProofNumber INT PRIMARY KEY,
    FileName VARCHAR(20),
    Type VARCHAR(10),
    ClientId VARCHAR(5),
    FOREIGN KEY (ClientId) REFERENCES Client(ClientID)
);

Select * from Proof;


INSERT INTO Proof (ProofNumber, FileName, Type, ClientId) VALUES
(1000, 'wedding', 'Digital', 'c1'),
(1001, 'wedding', 'Digital', 'c2'),
(1002, 'wedding', 'Digital', 'c3'),
(2000, 'graduation', 'Digital', 'c4'),
(2001, 'graduation', 'Digital', 'c5'),
(2002, 'graduation', 'Digital', 'c6'),
(3000, 'business_conference', 'Digital', 'c7'),
(3001, 'business_conference', 'Digital', 'c8'),
(3002, 'business_conference', 'Digital', 'c9'),
(4000, 'portrait', 'Digital', 'c10'),
(4001, 'portrait', 'Digital', 'c1'),
(4002, 'portrait', 'Digital', 'c2'),
(5000, 'family_sitting', 'Digital', 'c3'),
(5001, 'family_sitting', 'Digital', 'c4'),
(5002, 'family_sitting', 'Digital', 'c5'),
(6000, 'fashion_photoshoot', 'Digital', 'c6'),
(6001, 'fashion_photoshoot', 'Digital', 'c7'),
(6002, 'fashion_photoshoot', 'Digital', 'c8'),
(7000, 'product_photoshoot', 'Digital', 'c9'),
(7001, 'product_photoshoot', 'Digital', 'c10'),
(7002, 'product_photoshoot', 'Digital', 'c1'),
(8000, 'award_ceremony', 'Digital', 'c2'),
(8001, 'award_ceremony', 'Digital', 'c3'),
(8002, 'award_ceremony', 'Digital', 'c4'),
(9000, 'individual_sitting', 'Digital', 'c5'),
(9001, 'individual_sitting', 'Digital', 'c6'),
(9002, 'individual_sitting', 'Digital', 'c7'),
(10000, 'fashion', 'Digital', 'c8'),
(10001, 'fashion', 'Digital', 'c9'),
(10002, 'fashion', 'Digital', 'c10');

select * from Proof; 

-- Create Order table
CREATE TABLE ClientOrder (
    OrderNumber VARCHAR(10) PRIMARY KEY,
    OrderDate DATE,
    SelectedProofs VARCHAR(255),
    ClientId  VARCHAR(5),
    FOREIGN KEY (ClientId) REFERENCES Client(ClientID)
);

select * from ClientOrder;

INSERT INTO ClientOrder (OrderNumber, OrderDate, SelectedProofs, ClientId) VALUES
('o100', '2024-03-07', 'wedding_1000, wedding_1001', 'c1'),
('o101', '2024-03-08', 'graduation_2000, graduation_2002', 'c2'),
('o102', '2024-03-08', 'business_conference_3000, business_conference_3002', 'c3'),
('o103', '2024-03-09', 'portrait_4001, portrait_4002', 'c4'),
('o104',  '2024-03-10', 'family_sitting_5000, family_sitting_5002', 'c5'),
('o105', '2024-03-17', 'fashion_photoshoot_6001, fashion_photoshoot_6002', 'c6'),
('o106', '2024-03-17','product_photoshoot_7000, product_photoshoot_7002', 'c7'),
('o107', '2024-03-19', 'award_ceremony_8000, award_ceremony_8002', 'c8'),
('o108', '2024-03-20', 'individual_sitting_9000, individual_sitting_9002', 'c9'),
('o109', '2024-03-20', 'fashion_10001', 'c10');

select * from ClientOrder;


CREATE TABLE PackageOption (
    pOption VARCHAR (30) PRIMARY KEY,
    pPrice_in_$ DECIMAL(10, 2)
);


INSERT INTO PackageOption (pOption, pPrice_in_$) VALUES
('Standard Album', 299.49),
('Premium Album', 499.79),
('Digital Package', 199.99),
('Portrait Bundle', 100.59),
('Wedding Deluxe', 799.99),
('Family Photo Pack', 149.89),
('Business Conference Bundle', 399.69),
('Graduation Special', 179.39),
('Fashion Collection', 399.99),
('Product Photography Package', 299.99);

select * from PackageOption;

-- Create Package table
CREATE TABLE Package (
    PackageID VARCHAR(10) PRIMARY KEY,
    pOption VARCHAR (30),
    PhotographerId CHAR(2),
    FOREIGN KEY (pOption) REFERENCES PackageOption(pOption),
    FOREIGN KEY (PhotographerId) REFERENCES Photographer(PhotographerID)
);


INSERT INTO Package (PackageID, pOption, PhotographerId) VALUES
('p1000', 'Standard Album','p1'),
('p1001', 'Premium Album',  'p2'),
('p1002', 'Digital Package', 'p3'),
('p1003', 'Portrait Bundle', 'p4'),
('p1004', 'Wedding Deluxe', 'f5'),
('p1005', 'Family Photo Pack', 'f1'),
('p1006', 'Business Conference Bundle', 'f2'),
('p1007', 'Graduation Special', 'f3'),
('p1008', 'Fashion Collection', 'f4'),
('p1009', 'Product Photography Package', 'f5');

select * from Package;  


-- Create PrepareProof table
CREATE TABLE PrepareProof (
    PhotographerId VARCHAR(5),
    ProofNumber INT,
    Description VARCHAR (50),
    PRIMARY KEY (PhotographerId, ProofNumber),
    FOREIGN KEY (PhotographerId) REFERENCES Photographer(PhotographerID),
    FOREIGN KEY (ProofNumber) REFERENCES Proof(ProofNumber)
);

Select * from PrepareProof;


-- Insert records for PrepareProof table with Description
INSERT INTO PrepareProof (PhotographerId, ProofNumber, Description) VALUES
('p1', 1000, 'Wedding proofs for client c1'),
('p1', 1001, 'Wedding proofs for client c2'),
('p2', 1002, 'Wedding proofs for client c3'),
('p3', 2000, 'Graduation proofs for client c4'),
('p3', 2001, 'Graduation proofs for client c5'),
('p4', 2002, 'Graduation proofs for client c6'),
('f4', 3000, 'Business conference proofs for client c7'),
('f4', 3001, 'Business conference proofs for client c8'),
('f5', 3002, 'Business conference proofs for client c9'),
('p5', 4000, 'Portrait proofs for client c10'),
('p5', 4001, 'Portrait proofs for client c1'),
('f1', 4002, 'Portrait proofs for client c2'),
('p2', 5000, 'Family sitting proofs for client c3'),
('f2', 5001, 'Family sitting proofs for client c4'),
('f2', 5002, 'Family sitting proofs for client c5'),
('f3', 6000, 'Fashion photoshoot proofs for client c6'),
('f3', 6001, 'Fashion photoshoot proofs for client c7'),
('f4', 6002, 'Fashion photoshoot proofs for client c8'),
('p5', 7000, 'Product photoshoot proofs for client c9'),
('p5', 7001, 'Product photoshoot proofs for client c10'),
('p5', 7002, 'Product photoshoot proofs for client c1'),
('f5', 8000, 'Award ceremony proofs for client c2'),
('f5', 8001, 'Award ceremony proofs for client c3'),
('f5', 8002, 'Award ceremony proofs for client c4'),
('p1', 9000, 'Individual sitting proofs for client c5'),
('p1', 9001, 'Individual sitting proofs for client c6'),
('p1', 9002, 'Individual sitting proofs for client c7'),
('p2', 10000, 'Fashion proofs for client c8'),
('p2', 10001, 'Fashion proofs for client c9'),
('p2', 10002, 'Fashion proofs for client c10');

select * from PrepareProof;

-- Create Meeting table
CREATE TABLE Meeting (
    ClientId VARCHAR(5),
    StaffID CHAR(2),
    MeetingDate DATE,
    MeetingTime TIME,
    PRIMARY KEY (ClientId, StaffID),
    FOREIGN KEY (ClientId) REFERENCES Client(ClientID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

Select * from Meeting;

INSERT INTO Meeting (ClientId, StaffID, MeetingDate, MeetingTime) VALUES
('c1', 's1', '2024-01-28', '12:00:00'),
('c2', 's1', '2024-01-28', '11:00:00'),
('c3', 's1', '2024-01-27', '10:00:00'),
('c4', 's1', '2024-01-30', '15:00:00'),
('c5', 's2', '2024-01-29', '14:00:00'),
('c6', 's2', '2024-01-29', '13:30:00'),
('c7', 's2', '2024-02-04', '19:00:00'),
('c8', 's1', '2024-02-02', '18:00:00'),
('c9', 's2', '2024-02-01', '17:00:00'),
('c10', 's2', '2024-02-01', '16:00:00');

select * from Meeting;

-- Create ReceiveOrder table
CREATE TABLE ReceiveOrder (
    PhotographerId CHAR (2),
    OrderNumber VARCHAR(10),
    ClientId VARCHAR (5),
    PackageSelected VARCHAR(255),
    PRIMARY KEY (PhotographerId, OrderNumber),
    FOREIGN KEY (PhotographerId) REFERENCES Photographer(PhotographerID),
    FOREIGN KEY (OrderNumber) REFERENCES ClientOrder (OrderNumber),
    FOREIGN KEY (ClientId) REFERENCES Client(ClientID)
);

select * from ReceiveOrder;

INSERT INTO ReceiveOrder (PhotographerId, OrderNumber, ClientId, PackageSelected) VALUES
('p3', 'o100', 'c1', 'wedding_1000, wedding_1001'),
('p2', 'o101', 'c2', 'graduation_2000, graduation_2002'),
('p1', 'o102', 'c3', 'business_conference_3000, business_conference_3002'),
('p5', 'o103', 'c4', 'portrait_4001, portrait_4002'),
('f2', 'o104', 'c5', 'family_sitting_5000, family_sitting_5002'),
('f4', 'o105', 'c6', 'fashion_photoshoot_6001, fashion_photoshoot_6002'),
('f1', 'o106', 'c7', 'product_photoshoot_7000, product_photoshoot_7002'),
('p4', 'o107', 'c8', 'award_ceremony_8000, award_ceremony_8002'),
('f3', 'o108', 'c9', 'individual_sitting_9000, individual_sitting_9002'),
('f5', 'o109', 'c10', 'fashion_10001');

select * from ReceiveOrder;


-- Create Payment table
CREATE TABLE Payment (
    PaymentId VARCHAR(10) PRIMARY KEY,
    ClientId VARCHAR(5),
    ServiceID INT,
    Amount_in_$ DECIMAL(10, 2),
    PaymentDate DATE,
    FOREIGN KEY (ClientId) REFERENCES Client(ClientID),
    FOREIGN KEY (ServiceID) REFERENCES Service(ServiceID)
);
select * from Payment;

-- included 1$ tax in addition to the Final payment
INSERT INTO Payment (PaymentId, ClientId, ServiceID, Amount_in_$, PaymentDate) VALUES
('PAY00001', 'c1', 1, 700.99, '2024-03-20'), 
('PAY00002', 'c2', 1, 80.99, '2024-03-21'),
('PAY00003', 'c3', 1, 300.69, '2024-03-21'),
('PAY00004', 'c4', 1, 50.59, '2024-03-25'),
('PAY00005', 'c5', 1, 50.89, '2024-03-29');

-- assumed some of the services given to clinets are not paid yet 

select * from Payment;

-- ##########################################################################################
-- INDEXES 
CREATE UNIQUE INDEX StudioAddress_zip ON StudioAddress(zip);
CREATE UNIQUE INDEX Studio_StudioName ON Studio(StudioName);
CREATE INDEX Studio_zip ON Studio(zip);
CREATE UNIQUE INDEX Service_ServiceID ON Service(ServiceID);
CREATE INDEX Service_StudioName ON Service(StudioName);
CREATE UNIQUE INDEX Client_ClientID ON Client(ClientID);
CREATE INDEX Client_StudioName ON Client(StudioName);
CREATE UNIQUE INDEX Photographer_PhotographerID ON Photographer(PhotographerID);
CREATE UNIQUE INDEX Appointment_AppointmentID ON Appointment(AppointmentID);
CREATE INDEX Appointment_ClientID ON Appointment(ClientID);
CREATE UNIQUE INDEX SelectPhotographer_ClientId_PhotographerId ON SelectPhotographer(ClientId, PhotographerId);
CREATE UNIQUE INDEX isGiven_ClientID_ServiceID ON isGiven(ClientID, ServiceID);
CREATE UNIQUE INDEX Contract_ContractNumber ON Contract(ContractNumber);
CREATE INDEX Contract_ClientID ON Contract(ClientID);
CREATE INDEX Contract_StudioName ON Contract(StudioName);
CREATE UNIQUE INDEX Staff_StaffID ON Staff(StaffID);
CREATE UNIQUE INDEX Schedule_Date_TimeSlot_PhotographerID ON Schedule(Date, TimeSlot, PhotographerID);
CREATE UNIQUE INDEX Proof_ProofNumber ON Proof(ProofNumber);
CREATE UNIQUE INDEX ClientOrder_OrderNumber ON ClientOrder(OrderNumber);
CREATE INDEX ClientOrder_ClientId ON ClientOrder(ClientId);
CREATE UNIQUE INDEX Package_PackageID ON Package(PackageID);
CREATE UNIQUE INDEX PackageOption_pOption ON PackageOption(pOption);
CREATE UNIQUE INDEX PrepareProof_PhotographerId_ProofNumber ON PrepareProof(PhotographerId, ProofNumber);
CREATE UNIQUE INDEX Meeting_ClientId_StaffID ON Meeting(ClientId, StaffID);
CREATE UNIQUE INDEX ReceiveOrder_PhotographerId_OrderNumber ON ReceiveOrder(PhotographerId, OrderNumber);
CREATE INDEX ReceiveOrder_ClientId ON ReceiveOrder(ClientId);
CREATE UNIQUE INDEX Payment_PaymentId ON Payment(PaymentId);
CREATE INDEX Payment_ClientId ON Payment(ClientId);
CREATE INDEX Payment_ServiceID ON Payment(ServiceID);

-- ##########################################################################################
-- NON ROUTUNE REQUESTS 

-- 1. Photographers available in the weekends 
SELECT PfirstName, PLastName, Availability
FROM Photographer
WHERE Availability LIKE '%Saturday%' OR 
Availability LIKE '%Sunday%';

--  2. Average rating for each service type provided by the studio
SELECT s.Type, AVG(ig.Rating) AS AverageRating
FROM Service s
LEFT JOIN isGiven ig ON s.ServiceID = ig.ServiceID
GROUP BY s.Type;
 
 select * from Service;
 select * from isGiven;

-- 3. total revenue made by the business 
SELECT SUM(total_amount) AS Total_Revenue
FROM (
    SELECT SUM(amount_in_$) AS total_amount
    FROM Payment
    UNION 
    SELECT SUM(deposit_in_$)
    FROM Contract
) AS revenue;

-- 4. clients that havent made the final full payment yet 
SELECT c.ClientID, c.ClientlastName, c.ClientfirstName
FROM Client c
WHERE c.ClientID 
NOT IN (SELECT p.ClientID FROM Payment p);
    
-- 5. the top 3 highest rated services in the Studio
SELECT Type, AverageRating
FROM (
    SELECT s.Type, AVG(ig.Rating) AS AverageRating
    FROM Service s
    LEFT JOIN isGiven ig ON s.ServiceID = ig.ServiceID
    GROUP BY s.Type
    ORDER BY AVG(ig.Rating) DESC
    LIMIT 3
) AS HighestRatedService;
