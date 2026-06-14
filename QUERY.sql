-- =========================================================================
-- SYSTEM: Football Ticket Booking System Database Setup
=========================================================================

-- DROP TABLES IF THEY EXIST (SAFE RESET)
DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Matches;
DROP TABLE IF EXISTS Users;

-- =========================================================================
-- 1. USERS TABLE
-- =========================================================================
CREATE TABLE Users (
    user_id SERIAL,
    full_name VARCHAR(255),
    email VARCHAR(255),
    role VARCHAR(50),
    phone_number VARCHAR(15),

    PRIMARY KEY (user_id),
    UNIQUE (email),
    CHECK (role IN ('Football Fan', 'Ticket Manager'))
);


-- =========================================================================
-- 2. MATCHES TABLE
-- =========================================================================
CREATE TABLE Matches (
    match_id SERIAL,
    fixture VARCHAR(255),
    tournament_category VARCHAR(100),
    base_ticket_price NUMERIC(10,2),
    match_status VARCHAR(50),

    PRIMARY KEY (match_id),
    CHECK (base_ticket_price >= 0),
    CHECK (match_status IN ('Available', 'Selling Fast', 'Sold Out'))
);

-- =========================================================================
-- 3. BOOKINGS TABLE
-- =========================================================================
CREATE TABLE Bookings (
    booking_id SERIAL,
    user_id INT,
    match_id INT,
    seat_number VARCHAR(10),
    payment_status VARCHAR(20),
    total_cost NUMERIC(10,2),

    PRIMARY KEY (booking_id),

    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (match_id) REFERENCES Matches(match_id),

    CHECK (total_cost >= 0),
    CHECK (payment_status IN ('Confirmed', 'Pending', 'Failed'))
);

-- =========================================================================
-- SAMPLE DATA: USERS
-- =========================================================================
INSERT INTO Users (user_id, full_name, email, role, phone_number) VALUES
(1, 'Tanvir Rahman', 'tanvir@mail.com', 'Football Fan', '+8801711111111'),
(2, 'Asif Haque', 'asif@mail.com', 'Football Fan', '+8801722222222'),
(3, 'Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
(4, 'Jannat Ara', 'jannat@mail.com', 'Football Fan', NULL);

-- =========================================================================
-- SAMPLE DATA: MATCHES
-- =========================================================================
INSERT INTO Matches (match_id, fixture, tournament_category, base_ticket_price, match_status) VALUES
(101, 'Real Madrid vs Barcelona', 'Champions League', 150.00, 'Available'),
(102, 'Man City vs Liverpool', 'Premier League', 120.00, 'Selling Fast'),
(103, 'Bayern Munich vs PSG', 'Champions League', 130.00, 'Available'),
(104, 'AC Milan vs Inter Milan', 'Serie A', 90.00, 'Sold Out'),
(105, 'Juventus vs Roma', 'Serie A', 80.00, 'Available');

-- =========================================================================
-- SAMPLE DATA: BOOKINGS
-- =========================================================================
INSERT INTO Bookings (booking_id, user_id, match_id, seat_number, payment_status, total_cost) VALUES
(501, 1, 101, 'A-12', 'Confirmed', 150.00),
(502, 1, 102, 'B-04', 'Confirmed', 120.00),
(503, 2, 101, 'A-13', 'Confirmed', 150.00),
(504, 2, 101, NULL, NULL, 150.00),
(505, 3, 102, 'C-20', 'Pending', 120.00);





-- Query 1:

SELECT match_id, fixture, base_ticket_price
FROM matches
WHERE tournament_category = 'Champions League'
AND match_status = 'Available'



