
-- Subject 1: Top Demand Cities (Surge)
-- Insight: New York 1.27 avg surge par hai; supply deficit control karne ke liye onboarding badhani hogi.
SELECT l.city, AVG(t.surge_multiplier) AS average_surge 
FROM trips t
JOIN locations l ON t.pickup_location_id = l.location_id
WHERE t.status = 'completed' 
GROUP BY l.city 
ORDER BY average_surge DESC;


-- Subject 2: Unpaid Long Trips (Revenue Leakage)
-- Insight: Badi rides me payment status failure bada loss hai; app me wallet hold feature lagana padega.
SELECT t.trip_id, t.distance_km, p.status AS payment_status 
FROM trips t
JOIN payments p ON t.trip_id = p.trip_id
WHERE p.status = 'Pending' OR p.status = 'Failed'
ORDER BY t.distance_km DESC 
LIMIT 10;

-- Subject 3: Fleet Performance by Brand
-- Insight: Ford vehicles top-rated hain; user comfort policy ke liye comfortable models ko priority dein.
SELECT vehicle_make, COUNT(*) AS total_active_drivers, AVG(rating) AS average_rating
FROM drivers 
WHERE is_active = 1 
GROUP BY vehicle_make 
ORDER BY average_rating DESC;


-- Subject 4: Top 5 Elite Drivers
-- Insight: Andrew Myers 90 trips ke sath top par hai; driver churn rokne ke liye loyalty bonus dena hoga.
SELECT u.name, u.email, COUNT(d.driver_id) AS total_trips 
FROM users u
JOIN drivers d ON u.user_id = d.user_id
JOIN trips t ON d.driver_id = t.driver_id 
WHERE t.status = 'completed'
GROUP BY u.user_id, u.name, u.email 
ORDER BY total_trips DESC 
LIMIT 5;


-- Subject 5: Fleet Quality Audit
-- Insight: 107 purane drivers 3.8 rating se niche hain; brand safety ke liye warning lists dispatch karni hain.
SELECT u.user_id, u.name, u.email, d.join_date, d.rating 
FROM users u
JOIN drivers d ON u.user_id = d.user_id
WHERE d.join_date <= '2024-12-31' AND d.rating < 3.8 
ORDER BY d.rating ASC;


-- Subject 6: Cancellation Split
-- Insight: Rider vs Driver dynamics se cancel penalty policy aur pricing sensitivity calibrate hogi.
SELECT cancelled_by, COUNT(*) AS total_cancellations 
FROM cancellations 
GROUP BY cancelled_by;