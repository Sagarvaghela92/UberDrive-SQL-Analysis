<div align="center">

# 🚗 Ride-Sharing Marketplace Analytics
### Advanced SQL Portfolio Project — Operations, Revenue & Retention Intelligence

**Turning raw relational data into executive-ready business strategy.**

<div align="center">

[Key Results](#-core-analytical-queries--business-insights) • [Detailed Analysis](#-core-analytical-queries--business-insights) • [How to Review](#%EF%B8%8F-how-to-review-this-project) • [Connect](#-connect-with-me)

</div>

---

## 📌 Project Overview

This project simulates the backend database of a real-world ride-sharing marketplace — comparable to platforms like Uber or Ola — and applies **advanced SQL analytics** to solve **6 high-priority operational challenges** that mobility companies face every day.

Rather than writing queries for the sake of syntax, every query here was built to answer one question: ***"What should the business do next?"***

By querying relational tables containing trip logs, payment records, driver profiles, user data, geospatial location data, and cancellation logs, this project extracts insights on:

- 📍 **Supply-demand imbalance** → surge pricing patterns
- 💸 **Revenue leakage** → unpaid long-distance trips
- 🚗 **Fleet quality** → vehicle brand performance
- 👑 **Driver retention** → identifying & rewarding top performers
- ⚠️ **Risk management** → flagging underperforming drivers
- 🔄 **Marketplace friction** → rider vs. driver cancellation dynamics

> 📝 **Note:** All data used in this project is synthetically generated for portfolio and educational purposes.

---

## 📊 Key Results at a Glance

| # | Business Challenge | Key Finding | Recommended Business Action |
|---|---|---|---|
| 1 | Surge Demand Analysis | **New York → 1.27x** avg. surge (highest of all cities) | Launch targeted driver onboarding in NY |
| 2 | Revenue Leakage | Top unpaid trip: **59.24 km** with Pending/Failed payment | Introduce pre-ride wallet hold / pre-auth |
| 3 | Fleet Performance | **Ford → 4.40★** avg. rating (top-rated brand) | Prioritize Ford in future fleet expansion |
| 4 | Driver Retention | **Andrew Myers → 90 trips** (top elite driver) | Launch tiered loyalty bonus program |
| 5 | Risk & Quality Audit | **107 legacy drivers** flagged, lowest rating **2.59** | Automated retraining & review pipeline |
| 6 | Cancellation Dynamics | **2,069 rider vs. 897 driver** cancellations | Recalibrate cancellation penalty policy |

---

## 🛠️ Tech Stack & Key Concepts

| Category | Details |
|---|---|
| **Database Engines** | MySQL |
| **Core SQL Concepts** | Multi-table `JOIN`s, `GROUP BY` aggregations, subqueries, conditional (`WHERE`/`OR`) logic, date-based filtering, `ORDER BY` + `LIMIT` optimization |
| **Aggregation Functions** | `AVG()`, `COUNT()` applied directly to business KPIs |
| **Business Frameworks** | Revenue leakage analysis, churn prevention, supply-demand calibration, risk segmentation |

---

## 🗄️ Database Schema

The project runs on **6 interconnected relational tables**:

| Table | Key Columns | Purpose |
|---|---|---|
| `users` | `user_id`, `name`, `email`, `city`, `is_driver` | Rider & driver account information |
| `drivers` | `driver_id`, `user_id`, `vehicle_make`, `rating`, `is_active`, `join_date` | Driver profiles, vehicle & rating data |
| `trips` | `trip_id`, `driver_id`, `pickup_location_id`, `distance_km`, `surge_multiplier`, `status` | Trip-level transactional logs |
| `locations` | `location_id`, `city` | Geospatial city / location mapping |
| `payments` | `payment_id`, `trip_id`, `status`, `amount` | Payment & transaction status |
| `cancellations` | `cancel_id`, `trip_id`, `cancelled_by` | Cancellation logs by rider / driver |

---

## 🚀 Detailed Analysis

### 1️⃣ Top Demand Cities — Surge Multiplier Analysis

**🎯 Business Objective**
Identify geographic areas with high demand-supply mismatch to optimize driver onboarding.

```sql
SELECT l.city, AVG(t.surge_multiplier) AS average_surge
FROM trips t
JOIN locations l ON t.pickup_location_id = l.location_id
WHERE t.status = 'completed'
GROUP BY l.city
ORDER BY average_surge DESC;
```

**💡 Insight**
New York recorded the highest average surge multiplier at **1.27x**, signaling a structural supply deficit in the city.

**📈 Business Action**
Launch targeted driver onboarding campaigns in New York to close the supply-demand gap and reduce surge-driven customer drop-off.

---

### 2️⃣ Unpaid Long Trips — Revenue Leakage Identification

**🎯 Business Objective**
Track high-value long-distance trips with failed payments to protect company margins.

```sql
SELECT t.trip_id, t.distance_km, p.status AS payment_status
FROM trips t
JOIN payments p ON t.trip_id = p.trip_id
WHERE p.status = 'Pending' OR p.status = 'Failed'
ORDER BY t.distance_km DESC
LIMIT 10;
```

**💡 Insight**
The single largest revenue leak was a **59.24 km** trip stuck in Pending/Failed payment status — and it wasn't an isolated case.

**📈 Business Action**
Introduce an in-app **Wallet Hold / Pre-Authorization** feature for long-distance bookings to eliminate unpaid-trip revenue loss.

---

### 3️⃣ Fleet Performance by Vehicle Brand

**🎯 Business Objective**
Evaluate customer satisfaction by vehicle make to guide fleet expansion policy.

```sql
SELECT vehicle_make, COUNT(*) AS total_active_drivers, AVG(rating) AS average_rating
FROM drivers
WHERE is_active = 1
GROUP BY vehicle_make
ORDER BY average_rating DESC;
```

**💡 Insight**
**Ford** vehicles topped the rankings with a **4.40★** average rating across all active drivers — the highest of any brand.

**📈 Business Action**
Prioritize Ford (or comparably-rated models) in future fleet onboarding and offer incentives to drivers operating these vehicles.

---

### 4️⃣ Top 5 Elite Drivers — Retention Focus

**🎯 Business Objective**
Identify and reward top-performing drivers to reduce platform churn.

```sql
SELECT u.name, u.email, COUNT(d.driver_id) AS total_trips
FROM users u
JOIN drivers d ON u.user_id = d.user_id
JOIN trips t ON d.driver_id = t.driver_id
WHERE t.status = 'completed'
GROUP BY u.user_id, u.name, u.email
ORDER BY total_trips DESC
LIMIT 5;
```

**💡 Insight**
**Andrew Myers** leads the platform with **90 completed trips**, anchoring the top-5 cohort of elite drivers.

**📈 Business Action**
Introduce structured loyalty bonuses and performance-tier payouts for this cohort to prevent competitor poaching and reduce driver churn.

---

### 5️⃣ Fleet Quality Audit — Risk Management

**🎯 Business Objective**
Filter underperforming legacy drivers to protect brand reputation and rider safety.

```sql
SELECT u.user_id, u.name, u.email, d.join_date, d.rating
FROM users u
JOIN drivers d ON u.user_id = d.user_id
WHERE d.join_date <= '2024-12-31' AND d.rating < 3.8
ORDER BY d.rating ASC;
```

**💡 Insight**
**107 legacy drivers** (onboarded on or before 2024) fell below the **3.8** rating threshold — with the lowest score recorded at **2.59**.

**📈 Business Action**
Automatically dispatch this list to a quality review pipeline, with mandatory retraining and performance warnings for flagged drivers.

---

### 6️⃣ Cancellation Split Dynamics

**🎯 Business Objective**
Understand rider vs. driver cancellation patterns to calibrate penalty policy.

```sql
SELECT cancelled_by, COUNT(*) AS total_cancellations
FROM cancellations
GROUP BY cancelled_by;
```

**💡 Insight**
Riders initiated **2,069** cancellations vs. **897** by drivers — a **2.3x** gap suggesting very different root causes on each side of the marketplace.

**📈 Business Action**
Recalibrate cancellation penalty thresholds separately for riders and drivers, and feed this split into the pricing sensitivity model.

---

## 🧠 Skills Demonstrated

- ✅ Multi-table relational JOINs across 6 interconnected tables
- ✅ Aggregate functions (`AVG`, `COUNT`) applied to real business KPIs
- ✅ Conditional filtering & threshold-based risk segmentation
- ✅ Date-based historical filtering for cohort analysis
- ✅ Translating raw SQL output into business-ready recommendations
- ✅ Marketplace analytics — surge pricing, churn, revenue leakage, fleet ops

---

## 🔮 Future Enhancements

- 📊 Build an interactive **Power BI / Tableau dashboard** on top of these queries
- 📈 Add **window functions** for month-over-month surge trend analysis
- 🤖 Automate flagged-driver alerts via **stored procedures / triggers**
- 🌍 Expand geospatial analysis with city-level demand forecasting

---

## ⚙️ How to Review This Project

1. Open the **`SQL Uber-Analysis Project.sql`** file in this repository to view the optimized SQL scripts.
2. The complete analysis, business objectives, and strategic insights for all 6 subjects are documented above in this README.
```

> 📁 All 6 queries are organized individually inside the `SQL Uber-Analysis Project` file for easy review.

---

## 👥 Connect With Me

If you have any questions about this project or would like to discuss Data Analyst opportunities, feel free to reach out:

- **LinkedIn:** [linkedin.com/in/sagarvaghela007](https://linkedin.com/in/sagarvaghela007)
- **Email:** s56813307@gmail.com
- **Phone:** +91 9265812246

---
*Thank you for visiting my repository!*
⭐ If you found this project useful, consider giving it a star!
