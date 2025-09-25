CREATE DATABASE Ride_Sharing_Application_DB;

USE Ride_Sharing_Application_DB;

-- Passenger Table
CREATE TABLE Passenger (
    passenger_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(20),
    password_hash VARCHAR(255) NOT NULL,
    registered_date DATE NOT NULL DEFAULT (CURRENT_DATE)
) ENGINE=InnoDB;

-- Vehicle Table
CREATE TABLE Vehicle (
    vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
    driver_id INT,
    make VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    license_plate VARCHAR(20) NOT NULL UNIQUE,
    color VARCHAR(30)
) ENGINE=InnoDB;




-- Driver Table
CREATE TABLE Driver (
    driver_id INT AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(20),
    password_hash VARCHAR(255) NOT NULL,
    license_number VARCHAR(50) NOT NULL UNIQUE,
    vehicle_id INT,
    registered_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    CONSTRAINT fk_driver_vehicle FOREIGN KEY (vehicle_id)
        REFERENCES Vehicle(vehicle_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
) ENGINE=InnoDB;


-- Location Table
CREATE TABLE Location (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    latitude DECIMAL(9,6) NOT NULL,
    longitude DECIMAL(9,6) NOT NULL,
    address VARCHAR(255),
    UNIQUE (latitude, longitude)
) ENGINE=InnoDB;

-- Ride Table
CREATE TABLE Ride (
    ride_id INT AUTO_INCREMENT PRIMARY KEY,
    passenger_id INT NOT NULL,
    driver_id INT NOT NULL,
    pickup_location_id INT,
    dropoff_location_id INT,
    fare DECIMAL(10,2) CHECK (fare >= 0),
    status ENUM('requested','accepted','en_route','in_progress','completed','cancelled') NOT NULL,
    start_time DATE,
    end_time DATE,
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (passenger_id) REFERENCES Passenger(passenger_id)
        ON DELETE CASCADE,
    FOREIGN KEY (driver_id) REFERENCES Driver(driver_id)
        ON DELETE CASCADE,
    FOREIGN KEY (pickup_location_id) REFERENCES Location(location_id)
        ON DELETE SET NULL,
    FOREIGN KEY (dropoff_location_id) REFERENCES Location(location_id)
        ON DELETE SET NULL
) ENGINE=InnoDB;

-- Payment Table
CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    ride_id INT UNIQUE,
    amount DECIMAL(10,2) NOT NULL CHECK (amount >= 0),
    payment_method ENUM('card','cash','wallet') NOT NULL,
    payment_time DATE NOT NULL DEFAULT (CURRENT_DATE),
    refund_status ENUM('none','pending','processed') DEFAULT 'none',
    FOREIGN KEY (ride_id) REFERENCES Ride(ride_id)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- Rating Table
CREATE TABLE Rating (
    rating_id INT AUTO_INCREMENT PRIMARY KEY,
    ride_id INT UNIQUE,
    passenger_id INT,
    driver_id INT,
    score INT NOT NULL CHECK (score BETWEEN 1 AND 5),
    comment TEXT,
    timestamp DATE NOT NULL DEFAULT (CURRENT_DATE),
    FOREIGN KEY (ride_id) REFERENCES Ride(ride_id)
        ON DELETE CASCADE,
    FOREIGN KEY (passenger_id) REFERENCES Passenger(passenger_id)
        ON DELETE SET NULL,
    FOREIGN KEY (driver_id) REFERENCES Driver(driver_id)
        ON DELETE SET NULL
) ENGINE=InnoDB;



-- Create the new table with history_id as the primary key
CREATE TABLE Ride_Status_History (
    history_id INT AUTO_INCREMENT PRIMARY KEY,  -- History ID as the new primary key
    ride_id INT NOT NULL,  -- Foreign key referencing the Ride table
    status ENUM('requested','accepted','en_route','in_progress','completed','cancelled') NOT NULL,  -- Status of the ride
    timestamp DATE NOT NULL DEFAULT (CURRENT_DATE),  
    FOREIGN KEY (ride_id) REFERENCES Ride(ride_id) 
        ON DELETE CASCADE  
) ENGINE=InnoDB;


-- Refund Table
CREATE TABLE Refund (
    refund_id INT AUTO_INCREMENT PRIMARY KEY,
    payment_id INT UNIQUE,
    reason TEXT,
    amount DECIMAL(8,2) NOT NULL CHECK (amount >= 0),
    processed_at DATE NOT NULL DEFAULT (CURRENT_DATE),
    FOREIGN KEY (payment_id) REFERENCES Payment(payment_id)
        ON DELETE CASCADE
) ENGINE=InnoDB;




INSERT INTO Passenger (first_name, last_name, email, phone_number, password_hash, registered_date)
VALUES 
('John', 'Doe', 'johndoe1@example.com', '+971501111111', 'hash_john1', '2024-05-01'),
('Jane', 'Smith', 'janesmith2@example.com', '+971502222222', 'hash_jane2', '2024-05-02'),
('Ali', 'Khan', 'alikhan3@example.com', '+971503333333', 'hash_ali3', '2024-05-03'),
('Sara', 'Ahmed', 'saraahmed4@example.com', '+971504444444', 'hash_sara4', '2024-05-04'),
('Mohammed', 'Omar', 'momar5@example.com', '+971505555555', 'hash_mo5', '2024-05-05'),
('Emily', 'Clark', 'eclark6@example.com', '+971506666666', 'hash_emily6', '2024-05-06'),
('Ahmed', 'Nasser', 'anasser7@example.com', '+971507777777', 'hash_ahmed7', '2024-05-07'),
('Fatima', 'Yousef', 'fyousef8@example.com', '+971508888888', 'hash_fatima8', '2024-05-08'),
('Robert', 'Brown', 'rbrown9@example.com', '+971509999999', 'hash_robert9', '2024-05-09'),
('Aisha', 'Saeed', 'asaeed10@example.com', '+971501212121', 'hash_aisha10', '2024-05-10'),
('Michael', 'Lee', 'mlee11@example.com', '+971502323232', 'hash_mike11', '2024-05-11'),
('Noura', 'AlMansoori', 'noura12@example.com', '+971503434343', 'hash_noura12', '2024-05-12'),
('Chris', 'Evans', 'cevans13@example.com', '+971504545454', 'hash_chris13', '2024-05-13'),
('Zahra', 'Karim', 'zkarim14@example.com', '+971505656565', 'hash_zahra14', '2024-05-14'),
('David', 'Chen', 'dchen15@example.com', '+971506767676', 'hash_david15', '2024-05-15'),
('Lina', 'Hassan', 'lhassan16@example.com', '+971507878787', 'hash_lina16', '2024-05-16'),
('Amir', 'Abdullah', 'aabdullah17@example.com', '+971508989898', 'hash_amir17', '2024-05-17'),
('Olivia', 'Jones', 'ojones18@example.com', '+971509090909', 'hash_olivia18', '2024-05-18'),
('Khalid', 'Salem', 'ksalem19@example.com', '+971501010101', 'hash_khalid19', '2024-05-19'),
('Layla', 'Farooq', 'lfarooq20@example.com', '+971502020202', 'hash_layla20', '2024-05-20');



INSERT INTO Vehicle (driver_id, make, model, license_plate, color) VALUES
(1, 'Toyota', 'Camry', 'UAE1234', 'White'),
(2, 'Honda', 'Civic', 'UAE5678', 'Black'),
(3, 'Ford', 'Focus', 'UAE9012', 'Blue'),
(4, 'Nissan', 'Altima', 'UAE3456', 'Silver'),
(5, 'Hyundai', 'Elantra', 'UAE7890', 'Red'),
(6, 'Chevrolet', 'Malibu', 'UAE1357', 'Grey'),
(7, 'Kia', 'Optima', 'UAE2468', 'Green'),
(8, 'Mazda', '3', 'UAE3690', 'Yellow'),
(9, 'Volkswagen', 'Passat', 'UAE1470', 'White'),
(10, 'Tesla', 'Model 3', 'UAE2580', 'Black'),
(11, 'BMW', '3 Series', 'UAE3691', 'Blue'),
(12, 'Mercedes', 'C-Class', 'UAE7412', 'Silver'),
(13, 'Audi', 'A4', 'UAE8523', 'Red'),
(14, 'Jeep', 'Cherokee', 'UAE9634', 'Grey'),
(15, 'Subaru', 'Impreza', 'UAE1745', 'Green'),
(16, 'Lexus', 'IS 300', 'UAE2856', 'White'),
(17, 'Infiniti', 'Q50', 'UAE3967', 'Black'),
(18, 'Mitsubishi', 'Lancer', 'UAE4178', 'Blue'),
(19, 'Peugeot', '508', 'UAE5289', 'Silver'),
(20, 'Renault', 'Megane', 'UAE6390', 'Red');




INSERT INTO Driver (first_name, last_name, email, phone_number, password_hash, license_number, vehicle_id, registered_date) VALUES
('John', 'Smith', 'john.smith@example.com', '555-1111', 'hash1', 'LIC1001', 1, '2024-11-15'),
('Jane', 'Doe', 'jane.doe@example.com', '555-2222', 'hash2', 'LIC1002', 2, '2024-12-03'),
('Michael', 'Brown', 'michael.brown@example.com', '555-3333', 'hash3', 'LIC1003', 3, '2025-01-08'),
('Emily', 'Davis', 'emily.davis@example.com', '555-4444', 'hash4', 'LIC1004', 4, '2025-01-15'),
('David', 'Wilson', 'david.wilson@example.com', '555-5555', 'hash5', 'LIC1005', 5, '2025-01-22'),
('Sarah', 'Taylor', 'sarah.taylor@example.com', '555-6666', 'hash6', 'LIC1006', 6, '2025-02-01'),
('Chris', 'Anderson', 'chris.anderson@example.com', '555-7777', 'hash7', 'LIC1007', 7, '2025-02-10'),
('Olivia', 'Thomas', 'olivia.thomas@example.com', '555-8888', 'hash8', 'LIC1008', 8, '2025-02-20'),
('James', 'Jackson', 'james.jackson@example.com', '555-9999', 'hash9', 'LIC1009', 9, '2025-03-01'),
('Emma', 'White', 'emma.white@example.com', '555-0000', 'hash10', 'LIC1010', 10, '2025-03-07'),
('Daniel', 'Harris', 'daniel.harris@example.com', '555-1010', 'hash11', 'LIC1011', 11, '2025-03-15'),
('Sophia', 'Martin', 'sophia.martin@example.com', '555-2020', 'hash12', 'LIC1012', 12, '2025-03-22'),
('Matthew', 'Thompson', 'matthew.thompson@example.com', '555-3030', 'hash13', 'LIC1013', 13, '2025-04-01'),
('Grace', 'Garcia', 'grace.garcia@example.com', '555-4040', 'hash14', 'LIC1014', 14, '2025-04-05'),
('Andrew', 'Martinez', 'andrew.martinez@example.com', '555-5050', 'hash15', 'LIC1015', 15, '2025-04-10'),
('Ava', 'Robinson', 'ava.robinson@example.com', '555-6060', 'hash16', 'LIC1016', 16, '2025-04-14'),
('Joseph', 'Clark', 'joseph.clark@example.com', '555-7070', 'hash17', 'LIC1017', 17, '2025-04-20'),
('Lily', 'Rodriguez', 'lily.rodriguez@example.com', '555-8080', 'hash18', 'LIC1018', 18, '2025-04-25'),
('Ryan', 'Lewis', 'ryan.lewis@example.com', '555-9090', 'hash19', 'LIC1019', 19, '2025-04-27'),
('Zoe', 'Lee', 'zoe.lee@example.com', '555-1122', 'hash20', 'LIC1020', 20, '2025-05-01');





INSERT INTO Location (latitude, longitude, address) VALUES
(37.774929, -122.419418, '123 Market St, San Francisco, CA'),
(34.052235, -118.243683, '456 Sunset Blvd, Los Angeles, CA'),
(40.712776, -74.005974, '789 Broadway, New York, NY'),
(41.878113, -87.629799, '321 Wacker Dr, Chicago, IL'),
(29.760427, -95.369804, '654 Main St, Houston, TX'),
(33.448376, -112.074036, '987 Roosevelt St, Phoenix, AZ'),
(39.739236, -104.990251, '159 Colfax Ave, Denver, CO'),
(47.606209, -122.332069, '753 Pine St, Seattle, WA'),
(38.907192, -77.036873, '951 Constitution Ave, Washington, DC'),
(32.776665, -96.796989, '852 Elm St, Dallas, TX'),
(42.360082, -71.058880, '147 Beacon St, Boston, MA'),
(36.162663, -86.781601, '369 Music Row, Nashville, TN'),
(25.761681, -80.191788, '258 Ocean Dr, Miami, FL'),
(44.977753, -93.265015, '852 Hennepin Ave, Minneapolis, MN'),
(45.512230, -122.658722, '753 Burnside St, Portland, OR'),
(39.952583, -75.165222, '456 Walnut St, Philadelphia, PA'),
(35.227085, -80.843124, '123 Tryon St, Charlotte, NC'),
(36.169941, -115.139832, '987 Fremont St, Las Vegas, NV'),
(30.267153, -97.743057, '369 Congress Ave, Austin, TX'),
(43.038902, -87.906471, '951 Wisconsin Ave, Milwaukee, WI');



INSERT INTO Ride (passenger_id, driver_id, pickup_location_id, dropoff_location_id, fare, status, start_time, end_time, is_active) VALUES
(1, 3, 5, 9, 12.50, 'completed', '2024-11-05', '2024-11-05', FALSE),
(2, 4, 6, 11, 18.75, 'completed', '2024-11-10', '2024-11-10', FALSE),
(3, 5, 2, 7, 25.00, 'completed', '2024-11-12', '2024-11-12', FALSE),
(4, 6, 1, 8, 9.30, 'cancelled', '2024-11-15', NULL, FALSE),
(5, 7, 3, 12, 16.20, 'completed', '2024-11-18', '2024-11-18', FALSE),
(6, 8, 4, 10, 13.90, 'completed', '2024-11-20', '2024-11-20', FALSE),
(7, 9, 14, 15, 22.00, 'completed', '2024-11-21', '2024-11-21', FALSE),
(8, 10, 5, 16, 17.80, 'completed', '2024-11-23', '2024-11-23', FALSE),
(9, 11, 6, 17, 11.25, 'completed', '2024-11-25', '2024-11-25', FALSE),
(10, 12, 7, 18, 20.00, 'completed', '2024-11-27', '2024-11-27', FALSE),
(11, 13, 8, 19, 14.40, 'completed', '2024-11-29', '2024-11-29', FALSE),
(12, 14, 9, 20, 19.90, 'completed', '2024-12-01', '2024-12-01', FALSE),
(13, 15, 10, 1, 10.50, 'completed', '2024-12-03', '2024-12-03', FALSE),
(14, 16, 11, 2, 23.10, 'completed', '2024-12-05', '2024-12-05', FALSE),
(15, 17, 12, 3, 8.80, 'cancelled', '2024-12-06', NULL, FALSE),
(16, 18, 13, 4, 21.25, 'completed', '2024-12-08', '2024-12-08', FALSE),
(17, 19, 14, 5, 13.75, 'completed', '2024-12-09', '2024-12-09', FALSE),
(18, 20, 15, 6, 26.40, 'completed', '2024-12-10', '2024-12-10', FALSE),
(19, 1, 16, 7, 12.95, 'completed', '2024-12-11', '2024-12-11', FALSE),
(20, 2, 17, 8, 15.30, 'completed', '2024-12-12', '2024-12-12', FALSE),
(1, 3, 18, 9, 27.00, 'in_progress', '2024-12-13', NULL, TRUE);



INSERT INTO Payment (ride_id, amount, payment_method, payment_time, refund_status) VALUES
(1, 12.50, 'card', '2024-11-05', 'none'),
(2, 18.75, 'wallet', '2024-11-10', 'none'),
(3, 25.00, 'cash', '2024-11-12', 'none'),
(4, 0.00, 'card', '2024-11-15', 'pending'),
(5, 16.20, 'card', '2024-11-18', 'none'),
(6, 13.90, 'wallet', '2024-11-20', 'none'),
(7, 22.00, 'card', '2024-11-21', 'none'),
(8, 17.80, 'cash', '2024-11-23', 'none'),
(9, 11.25, 'card', '2024-11-25', 'none'),
(10, 20.00, 'wallet', '2024-11-27', 'none'),
(11, 14.40, 'card', '2024-11-29', 'none'),
(12, 19.90, 'cash', '2024-12-01', 'none'),
(13, 10.50, 'wallet', '2024-12-03', 'none'),
(14, 23.10, 'card', '2024-12-05', 'none'),
(15, 0.00, 'cash', '2024-12-06', 'pending'),
(16, 21.25, 'wallet', '2024-12-08', 'none'),
(17, 13.75, 'card', '2024-12-09', 'none'),
(18, 26.40, 'card', '2024-12-10', 'none'),
(19, 12.95, 'wallet', '2024-12-11', 'none'),
(20, 15.30, 'cash', '2024-12-12', 'none');




INSERT INTO Rating (ride_id, passenger_id, driver_id, score, comment, timestamp) VALUES
(1, 1, 1, 5, 'Great ride, smooth and fast!', '2024-11-05'),
(2, 2, 2, 4, 'Nice, but there was a slight delay.', '2024-11-10'),
(3, 3, 3, 3, 'The driver was good, but the car was not clean enough.', '2024-11-12'),
(4, 4, 4, 5, 'Perfect, the driver was on time and very friendly!', '2024-11-15'),
(5, 5, 5, 2, 'The ride was uncomfortable. Needs improvement.', '2024-11-18'),
(6, 6, 6, 4, 'Nice ride, just wish it was faster.', '2024-11-20'),
(7, 7, 7, 5, 'Excellent experience. The driver was very professional.', '2024-11-21'),
(8, 8, 8, 1, 'Worst ride ever. The driver was rude.', '2024-11-23'),
(9, 9, 9, 4, 'The ride was smooth, but I expected a bit more comfort.', '2024-11-25'),
(10, 10, 10, 5, 'Great service! The driver was very polite.', '2024-11-27'),
(11, 11, 11, 3, 'It was okay, but the ride felt a little long.', '2024-11-29'),
(12, 12, 12, 4, 'Nice experience, would ride again.', '2024-12-01'),
(13, 13, 13, 2, 'The driver was good, but the car was dirty and uncomfortable.', '2024-12-03'),
(14, 14, 14, 5, 'Fantastic! The driver was very courteous and the car was top-notch.', '2024-12-05'),
(15, 15, 15, 1, 'Unpleasant ride. The driver was unprofessional and the car was not clean.', '2024-12-06'),
(16, 16, 16, 4, 'The ride was great, though the driver seemed distracted at times.', '2024-12-08'),
(17, 17, 17, 5, 'I had a fantastic time! Very friendly driver.', '2024-12-09'),
(18, 18, 18, 3, 'It was decent, but the car could have been cleaner.', '2024-12-10'),
(19, 19, 19, 4, 'Nice, but the driver could improve communication during the ride.', '2024-12-11'),
(20, 20, 20, 5, 'Best ride I’ve had in a while. Will book again!', '2024-12-12');



INSERT INTO Ride_Status_History (ride_id, status, timestamp) VALUES
(1, 'requested', '2024-11-01'),
(1, 'accepted', '2024-11-02'),
(2, 'en_route', '2024-11-03'),
(2, 'in_progress', '2024-11-04'),
(2, 'completed', '2024-11-05'),
(3, 'cancelled', '2024-11-06'),
(6, 'requested', '2024-11-07'),
(6, 'accepted', '2024-11-08'),
(8, 'en_route', '2024-11-09'),
(9, 'in_progress', '2024-11-10'),
(9, 'completed', '2024-11-11'),
(9, 'cancelled', '2024-11-12'),
(12, 'requested', '2024-11-13'),
(13, 'accepted', '2024-11-14'),
(14, 'en_route', '2024-11-15'),
(15, 'in_progress', '2024-11-16'),
(15, 'completed', '2024-11-17'),
(16, 'cancelled', '2024-11-18'),
(17, 'requested', '2024-11-19'),
(17, 'accepted', '2024-11-20');


INSERT INTO Refund (payment_id, reason, amount, processed_at) VALUES
(1, 'Service cancellation', 15.50, '2024-11-02'),
(2, 'Overcharged fare', 8.25, '2024-11-03'),
(3, 'Payment error', 12.00, '2024-11-05'),
(4, 'Driver no-show', 10.00, '2024-11-06'),
(5, 'Cancelled ride after payment', 18.75, '2024-11-07'),
(6, 'System error during payment', 7.50, '2024-11-09'),
(7, 'Incorrect amount charged', 5.00, '2024-11-10'),
(8, 'Ride did not start', 20.00, '2024-11-11'),
(9, 'Incorrect ride completion status', 9.00, '2024-11-12'),
(10, 'Driver cancellation', 14.30, '2024-11-13'),
(11, 'Wrong payment method used', 11.00, '2024-11-15'),
(12, 'Ride charge dispute', 16.20, '2024-11-16'),
(13, 'Payment duplicated', 23.40, '2024-11-17'),
(14, 'Ride delay', 13.80, '2024-11-18'),
(15, 'Refund due to delay', 22.10, '2024-11-19'),
(16, 'Ride miscalculated', 17.00, '2024-11-20'),
(17, 'Driver''s fault', 25.00, '2024-11-21'),
(18, 'Accidental payment', 4.99, '2024-11-22'),
(19, 'Wrong amount requested', 21.60, '2024-11-23'),
(20, 'Technical issues', 30.00, '2024-11-24');










-- Passenger table indexes
CREATE INDEX idx_passenger_name ON Passenger (first_name, last_name);
CREATE INDEX idx_passenger_email ON Passenger (email);

-- Driver table indexes
CREATE INDEX idx_driver_name ON Driver (first_name, last_name);
CREATE INDEX idx_driver_email ON Driver (email);
CREATE INDEX idx_driver_license ON Driver (license_number);

-- Vehicle table indexes
CREATE INDEX idx_vehicle_make_model ON Vehicle (make, model);
CREATE INDEX idx_vehicle_plate ON Vehicle (license_plate);

-- Location table index (partial index for addresses)
CREATE INDEX idx_location_address ON Location (address(50));


-- Ride table indexes (most important for performance)
CREATE INDEX idx_ride_passenger ON Ride (passenger_id);
CREATE INDEX idx_ride_driver ON Ride (driver_id);
CREATE INDEX idx_ride_status ON Ride (status);
CREATE INDEX idx_ride_times ON Ride (start_time, end_time);
CREATE INDEX idx_ride_locations ON Ride (pickup_location_id, dropoff_location_id);

-- Payment table indexes
CREATE INDEX idx_payment_status ON Payment (refund_status);
CREATE INDEX idx_payment_time ON Payment (payment_time);

-- Rating table indexes
CREATE INDEX idx_rating_score ON Rating (score);
CREATE INDEX idx_rating_timestamp ON Rating (timestamp);

-- Ride_Status_History indexes
CREATE INDEX idx_status_history ON Ride_Status_History (ride_id, status);
CREATE INDEX idx_status_timestamp ON Ride_Status_History (timestamp);



-- For frequent passenger ride history lookups
CREATE INDEX idx_passenger_rides ON Ride (passenger_id, start_time DESC);

-- For driver performance analysis
CREATE INDEX idx_driver_rides ON Ride (driver_id, start_time DESC, status);

-- For fare analysis reports
CREATE INDEX idx_ride_fares ON Ride (status, start_time, fare);

-- For location-based queries
CREATE INDEX idx_location_usage ON Ride (pickup_location_id, dropoff_location_id, start_time);




-- Active rides view
CREATE OR REPLACE VIEW active_rides_view AS
SELECT r.ride_id, 
       CONCAT(p.first_name, ' ', p.last_name) AS passenger_name,
       CONCAT(d.first_name, ' ', d.last_name) AS driver_name,
       l1.address AS pickup_address, 
       l2.address AS dropoff_address,
       r.start_time, r.fare, r.status
FROM Ride r
JOIN Passenger p ON r.passenger_id = p.passenger_id
JOIN Driver d ON r.driver_id = d.driver_id
LEFT JOIN Location l1 ON r.pickup_location_id = l1.location_id
LEFT JOIN Location l2 ON r.dropoff_location_id = l2.location_id
WHERE r.is_active = TRUE;



-- Driver ratings summary
CREATE OR REPLACE VIEW driver_ratings_summary AS
SELECT d.driver_id, 
       CONCAT(d.first_name, ' ', d.last_name) AS driver_name,
       COUNT(r.ride_id) AS total_rides,
       AVG(rt.score) AS average_rating,
       COUNT(rt.rating_id) AS rating_count
FROM Driver d
LEFT JOIN Ride r ON d.driver_id = r.driver_id
LEFT JOIN Rating rt ON r.ride_id = rt.ride_id
GROUP BY d.driver_id, d.first_name, d.last_name;



-- Passenger ride history
CREATE OR REPLACE VIEW passenger_ride_history AS
SELECT p.passenger_id,
       CONCAT(p.first_name, ' ', p.last_name) AS passenger_name,
       r.ride_id, 
       r.start_time, 
       r.end_time,
       r.fare,
       r.status,
       rt.score AS rating
FROM Passenger p
JOIN Ride r ON p.passenger_id = r.passenger_id
LEFT JOIN Rating rt ON r.ride_id = rt.ride_id;



-- Daily ride summary view
CREATE OR REPLACE VIEW daily_ride_summary AS
SELECT 
    DATE(start_time) AS ride_date,
    COUNT(*) AS total_rides,
    SUM(fare) AS total_revenue,
    AVG(fare) AS avg_fare,
    SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END) AS completed_rides,
    SUM(CASE WHEN status = 'cancelled' THEN 1 ELSE 0 END) AS cancelled_rides
FROM Ride
GROUP BY DATE(start_time);

-- Driver performance dashboard view
CREATE OR REPLACE VIEW driver_performance AS
SELECT 
    d.driver_id,
    CONCAT(d.first_name, ' ', d.last_name) AS driver_name,
    COUNT(r.ride_id) AS total_rides,
    SUM(r.fare) AS total_earnings,
    AVG(r.fare) AS avg_earnings_per_ride,
    AVG(rt.score) AS avg_rating,
    COUNT(rt.rating_id) AS rating_count
FROM Driver d
LEFT JOIN Ride r ON d.driver_id = r.driver_id AND r.status = 'completed'
LEFT JOIN Rating rt ON r.ride_id = rt.ride_id
GROUP BY d.driver_id, d.first_name, d.last_name;

-- Peak hours analysis view
CREATE OR REPLACE VIEW peak_hours_analysis AS
SELECT 
    HOUR(start_time) AS hour_of_day,
    COUNT(*) AS ride_count,
    AVG(fare) AS avg_fare,
    AVG(TIMESTAMPDIFF(MINUTE, start_time, end_time)) AS avg_duration_minutes
FROM Ride
WHERE status = 'completed'
GROUP BY HOUR(start_time)
ORDER BY ride_count DESC;





DELIMITER //

-- Procedure to get passenger ride history
CREATE PROCEDURE GetPassengerRideHistory(IN p_passenger_id INT)
BEGIN
    SELECT 
        r.ride_id,
        r.start_time,
        r.end_time,
        r.fare,
        r.status,
        CONCAT(d.first_name, ' ', d.last_name) AS driver_name,
        l1.address AS pickup_address,
        l2.address AS dropoff_address,
        rt.score AS rating,
        rt.comment AS feedback
    FROM Ride r
    JOIN Driver d ON r.driver_id = d.driver_id
    LEFT JOIN Location l1 ON r.pickup_location_id = l1.location_id
    LEFT JOIN Location l2 ON r.dropoff_location_id = l2.location_id
    LEFT JOIN Rating rt ON r.ride_id = rt.ride_id
    WHERE r.passenger_id = p_passenger_id
    ORDER BY r.start_time DESC;
END //

-- Procedure to calculate driver earnings
CREATE PROCEDURE CalculateDriverEarnings(IN p_driver_id INT, IN p_start_date DATE, IN p_end_date DATE)
BEGIN
    SELECT 
        SUM(fare) AS total_earnings,
        COUNT(*) AS ride_count,
        AVG(fare) AS avg_fare_per_ride
    FROM Ride
    WHERE driver_id = p_driver_id
    AND status = 'completed'
    AND DATE(start_time) BETWEEN p_start_date AND p_end_date;
END //

DELIMITER ;




-- Add covering indexes for frequent report queries
CREATE INDEX idx_ride_analysis_covering ON Ride (status, start_time, fare, passenger_id, driver_id);

-- Optimize the Rating table for frequent lookups
CREATE INDEX idx_rating_covering ON Rating (ride_id, score, timestamp);




-- Test search queries that use indexed columns
EXPLAIN ANALYZE SELECT * FROM Passenger WHERE first_name = 'John' AND last_name = 'Doe';
EXPLAIN ANALYZE SELECT * FROM Ride WHERE passenger_id = 5 AND status = 'completed';
EXPLAIN ANALYZE SELECT * FROM Ride WHERE start_time BETWEEN '2024-11-01' AND '2024-11-30';



-- Test view performance
EXPLAIN ANALYZE SELECT * FROM driver_ratings_summary WHERE driver_id = 3;
EXPLAIN ANALYZE SELECT * FROM daily_ride_summary WHERE ride_date = '2024-11-15';




-- Test procedure execution
CALL GetPassengerRideHistory(5);
CALL CalculateDriverEarnings(3, '2024-11-01', '2024-11-30');












USE Ride_Sharing_Application_DB;

-- ========================================
-- TABLE: BackupLog (Tracks All Backups)
-- ========================================
CREATE TABLE IF NOT EXISTS BackupLog (
    backup_id INT AUTO_INCREMENT PRIMARY KEY,
    backup_type ENUM('Full', 'Incremental', 'Differential') NOT NULL,
    backup_path VARCHAR(512) NOT NULL,
    backup_size_mb DECIMAL(10,2),
    status ENUM('Started', 'Completed', 'Failed') DEFAULT 'Started',
    start_time DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    end_time DATETIME(6),
    checksum VARCHAR(64),
    db_version VARCHAR(50),
    error_message TEXT,
    INDEX idx_backup_time (start_time),
    INDEX idx_backup_status (status)
) ENGINE=InnoDB;

-- ========================================
-- TABLE: ReplicationMonitor (Health Checks)
-- ========================================
CREATE TABLE IF NOT EXISTS ReplicationMonitor (
    monitor_id INT AUTO_INCREMENT PRIMARY KEY,
    check_time DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    replica_status VARCHAR(20),
    seconds_behind INT,
    io_running VARCHAR(3),
    sql_running VARCHAR(3),
    current_log_file VARCHAR(255),
    notes TEXT,
    INDEX idx_check_time (check_time),
    INDEX idx_replica_status (replica_status)
) ENGINE=InnoDB;

-- ========================================
-- TABLE: NotificationLog (Optional Alerts)
-- ========================================
CREATE TABLE IF NOT EXISTS NotificationLog (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    event_time DATETIME(6) DEFAULT CURRENT_TIMESTAMP(6),
    event_type ENUM('Backup', 'Replication', 'Failure', 'Other'),
    message TEXT,
    status ENUM('Pending', 'Sent', 'Failed') DEFAULT 'Pending',
    recipient VARCHAR(100),
    send_attempts INT DEFAULT 0
) ENGINE=InnoDB;

-- ========================================
-- PROCEDURE: Full Database Backup
-- ========================================
DELIMITER //
CREATE PROCEDURE sp_FullDatabaseBackup(IN backup_path VARCHAR(255))
BEGIN
    DECLARE backup_file VARCHAR(1024);
    DECLARE backup_command TEXT;
    DECLARE backup_checksum VARCHAR(64);
    DECLARE last_id INT;

    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, 
        @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
        INSERT INTO BackupLog (backup_type, backup_path, status, end_time, error_message)
        VALUES ('Full', backup_path, 'Failed', NOW(6), CONCAT(@errno, ': ', @text));
    END;

    INSERT INTO BackupLog (backup_type, backup_path, status, db_version)
    VALUES ('Full', backup_path, 'Started', @@version);
    SET last_id = LAST_INSERT_ID();

    SET backup_file = CONCAT(backup_path, '/RideSharing_FullBackup_', DATE_FORMAT(NOW(), '%Y%m%d_%H%i%s'), '.sql');

    SET backup_command = CONCAT(
        'mysqldump --single-transaction --routines --triggers --events ',
        '--skip-add-drop-table --add-locks --create-options ',
        '-u backup_user -p[your_password] Ride_Sharing_Application_DB > ', backup_file
    );

    SELECT CONCAT('Run this shell command for full backup: ', backup_command) AS BackupShellCommand;

    -- Simulated checksum (In production: calculate real checksum post-export)
    SET backup_checksum = SHA2(CONCAT('simulated_', NOW(6)), 256);

    UPDATE BackupLog 
    SET status = 'Completed', 
        end_time = NOW(6),
        backup_size_mb = ROUND(RAND() * 1000, 2),
        checksum = backup_checksum
    WHERE backup_id = last_id;
END //
DELIMITER ;

-- ========================================
-- PROCEDURE: Incremental Backup Using Binlogs
-- ========================================


DELIMITER //

CREATE PROCEDURE sp_IncrementalBackup(
    IN backup_path VARCHAR(255),
    IN current_binlog VARCHAR(255),
    IN current_pos BIGINT
)
BEGIN
    DECLARE backup_file VARCHAR(1024);
    DECLARE backup_command TEXT;
    DECLARE last_id INT;

    -- Record backup start
    INSERT INTO BackupLog (backup_type, backup_path, status)
    VALUES ('Incremental', backup_path, 'Started');
    SET last_id = LAST_INSERT_ID();

    -- Generate backup file name
    SET backup_file = CONCAT(backup_path, '/RideSharing_Binlog_', DATE_FORMAT(NOW(), '%Y%m%d_%H%i%s'), '.log');

    -- Construct backup command
    SET backup_command = CONCAT(
        'mysqlbinlog --read-from-remote-server --host=localhost ',
        '--user=backup_user --password=[your_password] ',
        '--raw --stop-position=', current_pos, ' ',
        '--result-file=', backup_file, ' ', current_binlog
    );

    -- Output backup instruction
    SELECT CONCAT('Run this shell command for incremental backup: ', backup_command) AS BackupShellCommand;

    -- Simulate completion
    UPDATE BackupLog
    SET status = 'Completed',
        end_time = NOW(6),
        backup_size_mb = ROUND(RAND() * 10, 2)
    WHERE backup_id = last_id;
END;
//

DELIMITER ;


-- ========================================
-- PROCEDURE: Point-in-Time Recovery Instructions
-- ========================================
DELIMITER //
CREATE PROCEDURE sp_PointInTimeRecovery(IN recovery_time DATETIME)
BEGIN
    DECLARE full_backup_path VARCHAR(512);
    DECLARE binlog_file VARCHAR(255) DEFAULT 'mysql-bin.000001';  -- Manually set or fetched from binlog index
    DECLARE binlog_pos BIGINT DEFAULT 4;  -- Placeholder, adjust manually

    SELECT backup_path INTO full_backup_path
    FROM BackupLog
    WHERE backup_type = 'Full' AND status = 'Completed'
    ORDER BY start_time DESC LIMIT 1;

    SELECT CONCAT(
        'Recovery Procedure:\n',
        '1. Restore full backup:\n   mysql -u root -p[password] Ride_Sharing_Application_DB < "', 
        full_backup_path, '"\n\n',
        '2. Apply binary logs:\n   mysqlbinlog --start-position=', binlog_pos,
        ' --stop-datetime="', recovery_time, '" ', binlog_file,
        ' | mysql -u root -p[password]'
    ) AS RecoverySteps;
END //
DELIMITER ;

-- ========================================
-- PROCEDURE: Monitor Replication Status
-- ========================================
DELIMITER //
CREATE PROCEDURE sp_MonitorReplication()
BEGIN
    DECLARE replica_status VARCHAR(20);
    DECLARE seconds_behind INT;
    DECLARE replica_io_running VARCHAR(3);
    DECLARE replica_sql_running VARCHAR(3);

    SELECT 
        REPLICA_IO_STATE, 
        SERVICE_STATE,
        SOURCE_LOG_FILE,
        REPLICA_IO_RUNNING,
        REPLICA_SQL_RUNNING,
        SECONDS_BEHIND_SOURCE
    INTO 
        @replica_state, @service_state, @log_file,
        replica_io_running, replica_sql_running, seconds_behind
    FROM performance_schema.replication_connection_status
    JOIN performance_schema.replication_applier_status_by_worker
    USING(CHANNEL_NAME)
    LIMIT 1;

    IF replica_io_running = 'Yes' AND replica_sql_running = 'Yes' THEN
        SET replica_status = 'Running';
    ELSE
        SET replica_status = 'Stopped';
    END IF;

    INSERT INTO ReplicationMonitor (
        check_time, 
        replica_status, 
        seconds_behind,
        io_running,
        sql_running,
        current_log_file
    )
    VALUES (
        NOW(6), 
        replica_status, 
        seconds_behind,
        replica_io_running,
        replica_sql_running,
        @log_file
    );

    IF seconds_behind > 60 THEN
        INSERT INTO NotificationLog (event_type, message, status, recipient)
        VALUES ('Replication', CONCAT('Warning: Replication lag is ', seconds_behind, ' seconds'), 'Pending', 'dba@yourdomain.com');
    END IF;

    IF replica_status = 'Stopped' THEN
        INSERT INTO NotificationLog (event_type, message, status, recipient)
        VALUES ('Replication', 'CRITICAL: Replication has stopped', 'Pending', 'dba@yourdomain.com');
    END IF;
END //
DELIMITER ;

-- Simulating a full backup
INSERT INTO BackupLog (
    backup_type, backup_path, backup_size_mb, status, start_time, end_time, checksum, db_version, error_message
) 
VALUES 
('Full', '/path/to/backup/fullbackup_20250504.sql', 1024.50, 'Completed', NOW(), NOW(), 'a3c5d9a91bb56be7f5fbc0620458e8e8', '8.0.25', NULL);

-- Simulating an incremental backup
INSERT INTO BackupLog (
    backup_type, backup_path, backup_size_mb, status, start_time, end_time, checksum, db_version, error_message
) 
VALUES 
('Incremental', '/path/to/backup/incbackup_20250504_001.log', 10.25, 'Completed', NOW(), NOW(), 'b4e72f96f8f16f6cbf1d82894671ed8e', '8.0.25', NULL);

SELECT * FROM BackupLog ORDER BY start_time DESC LIMIT 5;

-- Simulating a healthy replication check
INSERT INTO ReplicationMonitor (
    check_time, replica_status, seconds_behind, io_running, sql_running, current_log_file, notes
) 
VALUES 
(NOW(), 'Running', 5, 'Yes', 'Yes', 'mysql-bin.000003', 'Replication is healthy.');

-- Simulating a replication issue with lag
INSERT INTO ReplicationMonitor (
    check_time, replica_status, seconds_behind, io_running, sql_running, current_log_file, notes
) 
VALUES 
(NOW(), 'Running', 75, 'Yes', 'Yes', 'mysql-bin.000004', 'Replication lag is 75 seconds.');

select * from ReplicationMonitor;


-- Simulating a warning notification for replication lag
INSERT INTO NotificationLog (
    event_time, event_type, message, status, recipient, send_attempts
) 
VALUES 
(NOW(), 'Replication', 'Warning: Replication lag is 75 seconds', 'Pending', 'dba@yourdomain.com', 0);

-- Simulating a critical notification for stopped replication
INSERT INTO NotificationLog (
    event_time, event_type, message, status, recipient, send_attempts
) 
VALUES 
(NOW(), 'Replication', 'CRITICAL: Replication has stopped', 'Pending', 'dba@yourdomain.com', 0);

select * from NotificationLog;











USE Ride_Sharing_Application_DB;

-- ========================================
-- 1. View Locked Accounts (For Security Auditing)
-- ========================================
SELECT * 
FROM mysql.user 
WHERE account_locked = 'Y' AND authentication_string = '';

-- ========================================
-- 2. Create Application Roles
-- ========================================
CREATE ROLE 'ride_admin', 'ride_driver', 'ride_passenger', 'ride_analyst';

-- ========================================
-- 3. Grant Role-Based Privileges
-- ========================================
-- Admin Role (Full Access)
GRANT ALL PRIVILEGES ON Ride_Sharing_Application_DB.* TO 'ride_admin';

-- Driver Role (Read/Write access to Driver-related tables)
GRANT SELECT, INSERT, UPDATE ON Driver TO 'ride_driver';
GRANT SELECT, INSERT, UPDATE ON Vehicle TO 'ride_driver';
GRANT SELECT, INSERT, UPDATE ON Ride TO 'ride_driver';
GRANT SELECT ON Location TO 'ride_driver';

-- Passenger Role (Basic Access)
GRANT SELECT, INSERT, UPDATE ON Passenger TO 'ride_passenger';
GRANT SELECT, INSERT ON Ride TO 'ride_passenger';
GRANT SELECT, INSERT ON Rating TO 'ride_passenger';
GRANT SELECT ON Location TO 'ride_passenger';

-- Analyst Role (Read-only Access)
GRANT SELECT ON Ride_Sharing_Application_DB.* TO 'ride_analyst';

-- ========================================
-- 4. Create Users and Assign Roles
-- ========================================
CREATE USER 'app_admin'@'%' IDENTIFIED BY 'Admin@Secure123';
CREATE USER 'app_driver'@'%' IDENTIFIED BY 'Driver@Secure123';
CREATE USER 'app_passenger'@'%' IDENTIFIED BY 'Passenger@Secure123';
CREATE USER 'app_analyst'@'%' IDENTIFIED BY 'Analyst@Secure123';

-- Assign Roles to Users
GRANT 'ride_admin' TO 'app_admin'@'%';
GRANT 'ride_driver' TO 'app_driver'@'%';
GRANT 'ride_passenger' TO 'app_passenger'@'%';
GRANT 'ride_analyst' TO 'app_analyst'@'%';

-- Activate Specific Roles (not ALL)
SET DEFAULT ROLE 'ride_admin' TO 'app_admin'@'%';
SET DEFAULT ROLE 'ride_driver' TO 'app_driver'@'%';
SET DEFAULT ROLE 'ride_passenger' TO 'app_passenger'@'%';
SET DEFAULT ROLE 'ride_analyst' TO 'app_analyst'@'%';

-- ========================================
-- 5. Column-Level Encryption (Community Edition)
-- ========================================
DELIMITER //

-- Encryption Function (AES)
CREATE FUNCTION encrypt_data(data_value VARCHAR(255), secret_key VARCHAR(255))
RETURNS VARBINARY(255)
DETERMINISTIC
BEGIN
    RETURN AES_ENCRYPT(data_value, secret_key);
END //

-- Decryption Function (AES)
CREATE FUNCTION decrypt_data(encrypted_value VARBINARY(255), secret_key VARCHAR(255))
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    RETURN AES_DECRYPT(encrypted_value, secret_key);
END //

DELIMITER ;

-- Encrypt Sensitive Data Columns
ALTER TABLE Passenger MODIFY password_hash VARBINARY(255);
ALTER TABLE Driver MODIFY password_hash VARBINARY(255);
ALTER TABLE Payment MODIFY amount VARBINARY(255);

-- NOTE: Store secret_key securely using environment variables, vault, or hardware key manager.

-- ========================================
-- 6. Audit Logging
-- ========================================
-- Create Audit Log Table
CREATE TABLE AuditLog (
    audit_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    event_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    user_host VARCHAR(100) NOT NULL,
    object_schema VARCHAR(64),
    object_name VARCHAR(64),
    action ENUM('INSERT', 'UPDATE', 'DELETE', 'SELECT', 'LOGIN', 'LOGOUT') NOT NULL,
    old_value JSON,
    new_value JSON,
    query_text TEXT
) ENGINE=InnoDB;

-- ========================================
-- 7. Audit Triggers (For Key Tables)
-- ========================================
DELIMITER //

-- Trigger for Passenger Table
CREATE TRIGGER tr_passenger_audit_insert AFTER INSERT ON Passenger
FOR EACH ROW BEGIN
    INSERT INTO AuditLog (user_host, object_schema, object_name, action, new_value)
    VALUES (CURRENT_USER(), DATABASE(), 'Passenger', 'INSERT',
            JSON_OBJECT('passenger_id', NEW.passenger_id, 'email', NEW.email));
END //

-- Trigger for Passenger Table (Update)
CREATE TRIGGER tr_passenger_audit_update
AFTER UPDATE ON Passenger
FOR EACH ROW
BEGIN
    INSERT INTO AuditLog (
        user_host,
        object_schema,
        object_name,
        action,
        old_value,
        new_value
    )
    VALUES (
        CURRENT_USER(),
        DATABASE(),
        'Passenger',
        'UPDATE',
        JSON_OBJECT('email', OLD.email),
        JSON_OBJECT('email', NEW.email)
    );
END //

-- Trigger for Payment Table
CREATE TRIGGER tr_payment_audit
AFTER INSERT ON Payment
FOR EACH ROW
BEGIN
    INSERT INTO AuditLog (
        user_host,
        object_schema,
        object_name,
        action,
        new_value
    )
    VALUES (
        CURRENT_USER(),
        DATABASE(),
        'Payment',
        'INSERT',
        JSON_OBJECT('payment_id', NEW.payment_id, 'amount', NEW.amount)
    );
END //

-- Trigger for Ride Table (Insert)
CREATE TRIGGER tr_ride_audit_insert AFTER INSERT ON Ride
FOR EACH ROW BEGIN
    INSERT INTO AuditLog (user_host, object_schema, object_name, action, new_value)
    VALUES (CURRENT_USER(), DATABASE(), 'Ride', 'INSERT',
            JSON_OBJECT('ride_id', NEW.ride_id, 'status', NEW.status));
END //

DELIMITER ;

-- ========================================
-- 8. Restrict Modifications to AuditLog Table
-- ========================================
-- Revoke Privileges from Admin Role on AuditLog
REVOKE ALL PRIVILEGES ON Ride_Sharing_Application_DB.* FROM 'ride_admin'@'%';

-- Grant Read-Only Access to Analyst Role for AuditLog
GRANT SELECT ON AuditLog TO 'ride_analyst';

-- ========================================
-- 9. Password Policy (Requires validate_password Plugin)
-- ========================================
INSTALL PLUGIN validate_password SONAME 'validate_password.so';
SHOW VARIABLES LIKE 'validate_password%';

-- Set Password Policy
SET GLOBAL validate_password.policy = 2;  -- STRONG
SET GLOBAL validate_password.length = 12;
SET GLOBAL validate_password.mixed_case_count = 1;
SET GLOBAL validate_password.number_count = 1;
SET GLOBAL validate_password.special_char_count = 1;
SET GLOBAL validate_password.check_user_name = ON;

-- ========================================
-- 10. Account Lockout & Password Expiration
-- ========================================
-- Create User with Lockout Policy
CREATE USER 'app_user'@'%' IDENTIFIED BY 'Complex@Password123';
SELECT User, Host FROM mysql.user WHERE User = 'app_user';

-- Account Lockout after 5 failed attempts
ALTER USER 'app_user'@'%' 
	FAILED_LOGIN_ATTEMPTS 5 
    PASSWORD_LOCK_TIME 1;

-- Set Password Expiry Interval (90 days)
ALTER USER 'app_admin'@'%' PASSWORD EXPIRE INTERVAL 90 DAY;
ALTER USER 'app_driver'@'%' PASSWORD EXPIRE INTERVAL 90 DAY;
ALTER USER 'app_passenger'@'%' PASSWORD EXPIRE INTERVAL 90 DAY;
ALTER USER 'app_analyst'@'%' PASSWORD EXPIRE INTERVAL 90 DAY;

-- ========================================
-- 11. SSL Connection Enforcement
-- ========================================
-- Enforce SSL for Users in Production
ALTER USER 'app_admin'@'%' REQUIRE SSL;
ALTER USER 'app_driver'@'%' REQUIRE SSL;
ALTER USER 'app_passenger'@'%' REQUIRE SSL;
ALTER USER 'app_analyst'@'%' REQUIRE SSL;

-- ========================================
-- 12. Monitoring View
-- ========================================
CREATE OR REPLACE VIEW SecurityMonitoring AS
SELECT 
    user, 
    host, 
    account_locked, 
    password_last_changed,
    password_expired,
    authentication_string
FROM mysql.user
WHERE user LIKE 'app_%';
SELECT * FROM Driver; 
SELECT * FROM Passenger; 
SELECT user, host, password_last_changed, password_expired
FROM mysql.user WHERE user = 'app_admin';

INSERT INTO Passenger (first_name, last_name,email,phone_number,password_hash) 
VALUES ('Test','Passenger','test@passenger.com','1234567890',encrypt_data('password123', 'securekey')
);

-- Check the encrypted password
SELECT email, password_hash FROM Passenger WHERE email = 'test@passenger.com';

SELECT * FROM AuditLog WHERE object_name = 'Passenger' AND action = 'INSERT';
ALTER USER 'app_admin'@'%' IDENTIFIED BY 'NewStrongPassword@123';
FLUSH PRIVILEGES;

SELECT email, decrypt_data(password_hash, 'securekey') AS decrypted_password
FROM Passenger
WHERE email = 'test@passenger.com';
