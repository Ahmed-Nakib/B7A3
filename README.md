# ⚽ Football Ticket Booking System (Database Design & SQL)

## 📌 Project Overview

This project is a relational database system for a Football Ticket Booking platform.  
It demonstrates database design, ERD relationships, and advanced SQL queries including joins, subqueries, aggregations, and NULL handling.

The system manages:
- Users (Football Fans & Ticket Managers)
- Football Matches
- Ticket Bookings

---

## 🎯 Objectives

This project helps to understand:

- Database schema design
- Primary Key & Foreign Key relationships
- One-to-Many & Many-to-One relationships
- SQL querying techniques:
  - JOINs (INNER, LEFT)
  - Subqueries
  - Aggregation (AVG)
  - Pattern matching (LIKE / ILIKE)
  - NULL handling (COALESCE)
  - Pagination (LIMIT / OFFSET)

---

## 🗂️ Database Schema

### 1️⃣ Users Table
| Field | Description |
|------|------------|
| user_id | Unique ID for each user |
| full_name | Full name of user |
| email | Unique email address |
| role | User role (Football Fan / Ticket Manager) |
| phone_number | Contact number |

---

### 2️⃣ Matches Table
| Field | Description |
|------|------------|
| match_id | Unique match ID |
| fixture | Teams playing |
| tournament_category | League name |
| base_ticket_price | Ticket price |
| match_status | Availability status |

---

### 3️⃣ Bookings Table
| Field | Description |
|------|------------|
| booking_id | Unique booking ID |
| user_id | References Users |
| match_id | References Matches |
| seat_number | Assigned seat |
| payment_status | Payment state |
| total_cost | Final cost |

---

## 🔗 Relationships

- Users → Bookings = One-to-Many  
- Matches → Bookings = One-to-Many  
- Each booking links one user + one match  

---

## 🧠 ERD Summary

- Primary Keys: user_id, match_id, booking_id  
- Foreign Keys: user_id, match_id in Bookings  
- Constraints:
  - UNIQUE email
  - CHECK role values
  - CHECK match status values
  - CHECK payment status values

---

## 📊 SQL Queries Included

### Query 1: Champions League Available Matches
Filters Champions League matches with Available status.

### Query 2: User Search (LIKE / ILIKE)
Search users by name pattern (case-insensitive).

### Query 3: NULL Payment Handling
Uses COALESCE to show "Action Required".

### Query 4: INNER JOIN
Joins Users, Bookings, Matches.

### Query 5: LEFT JOIN
Shows all users even without bookings.

### Query 6: Above Average Bookings
Finds bookings above average cost.

### Query 7: Top 2 Expensive Matches
Uses ORDER BY + OFFSET + LIMIT.

---

## 🧾 How to Run

### 1. Clone Repository
```bash
git clone https://github.com/your-username/football-ticket-system.git