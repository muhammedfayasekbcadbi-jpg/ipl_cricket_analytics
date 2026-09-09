select * from matches;
select match_id from matches;
select 	match_date,event_name,match_number from matches;

rules of sql:
	1)sql command should be capital
	2)sql query should end with ";"
	3)anything after "--" are ignored
	4)line breaks are free

select * from matches limit 10;
select distinct city from matches;
SELECT match_id,season,match_winner FROM matches
WHERE match_winner='Chennai Super Kings';
SELECT match_id FROM matches 
WHERE season='2019' OR result='win'
LIMIT 5;

SELECT match_id,match_winner,win_by_runs FROM matches WHERE WIN_BY_RUNS>100;
ORDER BY <column>  — sort the result by that column, smallest first. – DESC  — added after the column, sorts largest first. – It goes near the end, after WHERE and before LIMIT.
SELECT match_id,season,win_by_runs FROM matches
WHERE win_by_runs IS NOT NULL
ORDER BY win_by_runs ASC
LIMIT 5;
 
COUNT(*) is used to count the number of rows (records) in a table or result
AS <name> _ renames a col
SELECT COUNT(player_name) AS no_players FROM players;
SELECT COUNT(*) AS ties
FROM matches WHERE result = 'tie';
SELECT COUNT(DISTINCT(city)) AS total_cities
FROM matches; 