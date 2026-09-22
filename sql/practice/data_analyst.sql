
-- 1. Find the top 10 grounds by number of matches
SELECT
	venue,
	COUNT(DISTINCT match_id) AS match_count
FROM matches
GROUP BY venue
ORDER BY match_count DESC
LIMIT 10;

-- COUNT(DISTINCT match_id) counts unique matches. GROUP BY groups by ground,
-- ORDER BY ranks the grounds, and LIMIT returns only the top 10.

-- 2. Find grounds with an average innings score above 165,
--    using a minimum of 25 matches
SELECT
	m.venue,
	AVG(i.total_runs) AS average_score,
	COUNT(DISTINCT m.match_id) AS match_count
FROM matches AS m
JOIN innings AS i
	ON m.match_id = i.match_id
GROUP BY m.venue
HAVING COUNT(DISTINCT m.match_id) >= 25
   AND AVG(i.total_runs) > 165
ORDER BY average_score DESC;

-- HAVING filters grouped results after the join and aggregation.

-- 3. Calculate the chase win percentage for grounds with at least 50 matches
SELECT
	venue,
	COUNT(DISTINCT match_id) AS match_count,
	ROUND(
		100.0 * SUM(CASE WHEN win_type = 'wickets' THEN 1 ELSE 0 END)
		/ COUNT(DISTINCT match_id),
		2
	) AS chase_win_percentage
FROM matches
GROUP BY venue
HAVING COUNT(DISTINCT match_id) >= 50
ORDER BY chase_win_percentage DESC;

-- A win by wickets is treated as a successful chase.

-- 4. Count the number of unique cleaned venues
SELECT COUNT(DISTINCT cleaned_venue) AS unique_cleaned_venues
FROM matches
WHERE cleaned_venue IS NOT NULL;

-- 5. Find the five grounds with the lowest powerplay run rate
SELECT
	m.venue,
	SUM(i.powerplay_runs) / SUM(i.powerplay_overs) AS powerplay_run_rate
FROM matches AS m
JOIN innings AS i
	ON m.match_id = i.match_id
GROUP BY m.venue
ORDER BY powerplay_run_rate ASC
LIMIT 5;

-- 6. COUNT(DISTINCT match_id) is safer than COUNT(*) after a JOIN
-- because one match can produce multiple rows in deliveries.
SELECT
	m.venue,
	COUNT(DISTINCT m.match_id) AS matches
FROM matches AS m
JOIN deliveries AS d
	ON m.match_id = d.match_id
GROUP BY m.venue;

-- 7. Day/night cannot be answered from match_date alone.
-- Additional fields such as match_start_time or day_night are required.
SELECT
	match_date,
	match_start_time,
	day_night
FROM matches;
