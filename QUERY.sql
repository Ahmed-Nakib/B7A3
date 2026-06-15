-- =========================================================================
-- SYSTEM: Football Ticket Booking System Database Design & Implementation

-- =========================================================================
-- RESET DATABASE (SAFE DROP)
-- =========================================================================

DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS matches;
DROP TABLE IF EXISTS users;


-- =========================================================================
-- 1. USERS TABLE
-- =========================================================================

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    role VARCHAR(50),
    phone_number VARCHAR(15),

    CHECK (role IN ('Football Fan', 'Ticket Manager'))
);


-- =========================================================================
-- 2. MATCHES TABLE (FIXED)
-- =========================================================================

CREATE TABLE matches (
    match_id SERIAL PRIMARY KEY,
    fixture VARCHAR(255),
    tournament_category VARCHAR(100),
    base_ticket_price NUMERIC(10,2),
    match_status VARCHAR(50),

    CHECK (base_ticket_price >= 0),

    CHECK (
        match_status IN (
            'Available',
            'Selling Fast',
            'Sold Out',
            'Postponed'
        )
    )
);


-- =========================================================================
-- 3. BOOKINGS TABLE
-- =========================================================================

CREATE TABLE bookings (
    booking_id SERIAL PRIMARY KEY,
    user_id INT,
    match_id INT,
    seat_number VARCHAR(10),
    payment_status VARCHAR(20),
    total_cost NUMERIC(10,2),

    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (match_id) REFERENCES matches(match_id),

    CHECK (total_cost >= 0),
    CHECK (payment_status IN ('Confirmed', 'Pending', 'Cancelled', 'Refunded'))
);


-- =========================================================================
-- SAMPLE DATA: USERS
-- =========================================================================

INSERT INTO users (user_id, full_name, email, role, phone_number) VALUES
(1, 'Tanvir Rahman', 'tanvir@mail.com', 'Football Fan', '+8801711111111'),
(2, 'Asif Haque', 'asif@mail.com', 'Football Fan', '+8801722222222'),
(3, 'Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
(4, 'Jannat Ara', 'jannat@mail.com', 'Football Fan', NULL);


-- =========================================================================
-- SAMPLE DATA: MATCHES
-- =========================================================================

INSERT INTO matches (match_id, fixture, tournament_category, base_ticket_price, match_status) VALUES
(101, 'Real Madrid vs Barcelona', 'Champions League', 150.00, 'Available'),
(102, 'Man City vs Liverpool', 'Premier League', 120.00, 'Selling Fast'),
(103, 'Bayern Munich vs PSG', 'Champions League', 130.00, 'Available'),
(104, 'AC Milan vs Inter Milan', 'Serie A', 90.00, 'Sold Out'),
(105, 'Juventus vs Roma', 'Serie A', 80.00, 'Available');


-- =========================================================================
-- SAMPLE DATA: BOOKINGS
-- =========================================================================

INSERT INTO bookings (booking_id, user_id, match_id, seat_number, payment_status, total_cost) VALUES
(501, 1, 101, 'A-12', 'Confirmed', 150.00),
(502, 1, 102, 'B-04', 'Confirmed', 120.00),
(503, 2, 101, 'A-13', 'Confirmed', 150.00),
(504, 2, 101, NULL, NULL, 150.00),
(505, 3, 102, 'C-20', 'Pending', 120.00);


-- =========================================================================
-- QUERY 1: Champions League + Available Matches
-- =========================================================================

SELECT match_id, fixture, base_ticket_price
FROM matches
WHERE tournament_category = 'Champions League'
AND match_status = 'Available';


-- =========================================================================
-- QUERY 2: User Search (LIKE / ILIKE)
-- =========================================================================

SELECT user_id, full_name, email
FROM users
WHERE full_name ILIKE 'Tanvir%'
   OR full_name ILIKE '%Haque%';


-- =========================================================================
-- QUERY 3: NULL Payment Status Handling
-- =========================================================================

SELECT
    booking_id,
    user_id,
    match_id,
    COALESCE(payment_status, 'Action Required') AS systematic_status
FROM bookings
WHERE payment_status IS NULL;


-- =========================================================================
-- QUERY 4: INNER JOIN (User + Booking + Match)
-- =========================================================================

SELECT
    b.booking_id,
    u.full_name,
    m.fixture,
    b.total_cost
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN matches m ON b.match_id = m.match_id;


-- =========================================================================
-- QUERY 5: LEFT JOIN (All Users + Bookings)
-- =========================================================================

SELECT
    u.user_id,
    u.full_name,
    b.booking_id
FROM users u
LEFT JOIN bookings b ON u.user_id = b.user_id
ORDER BY u.user_id;


-- =========================================================================
-- QUERY 6: Above Average Booking Cost
-- =========================================================================

SELECT
    booking_id,
    match_id,
    total_cost
FROM bookings
WHERE total_cost > (
    SELECT AVG(total_cost) FROM bookings
);


-- =========================================================================
-- QUERY 7: Top 2 Expensive Matches (Skip Highest)
-- =========================================================================

SELECT
    match_id,
    fixture,
    base_ticket_price
FROM matches
ORDER BY base_ticket_price DESC
OFFSET 1
LIMIT 2;