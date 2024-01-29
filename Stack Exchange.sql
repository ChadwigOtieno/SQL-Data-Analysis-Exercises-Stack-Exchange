-- Basic Analysis

-- how many posts were made each year

SELECT COUNT( DISTINCT Id) AS posts_made, YEAR(CreationDate) AS years
FROM [data_analysis_stack_exchange_movies].[dbo].[posts]
GROUP BY YEAR(CreationDate)
ORDER BY YEAR(CreationDate) DESC


-- How many votes were made in each day of the week (Sunday, Monday, Tuesday, etc.) ?

SELECT *
FROM
	[data_analysis_stack_exchange_movies].[dbo].[Votes]

SELECT
    COUNT(Id) AS votes_made,
    DATENAME(dw, CreationDate) AS day_of_week
FROM
    [data_analysis_stack_exchange_movies].[dbo].[Votes]
GROUP BY
    DATENAME(dw, CreationDate);


-- List all comments created on September 19th, 2012

SELECT text, CreationDate
FROM [dbo].[Comments]
WHERE CAST(CreationDate AS DATE) = '2012/09/19'

-- List all users under the age of 33, living in London

SELECT *
FROM [dbo].[Users]

SELECT Id, Location, DisplayName, Age
FROM [dbo].[Users]
WHERE Age < 33 AND location LIKE '%London%'

-- Advance Analysis

-- Display the number of votes for each post title

SELECT *
FROM [dbo].[posts]

SELECT *
FROM [dbo].[Votes]

SELECT 
	v.Id,
	p.Title,
	p.score
FROM
	[dbo].[posts] p
JOIN
	[dbo].[Votes] v
ON
	v.Id = p.Id
ORDER BY score DESC


-- Display posts with comments created by users living in the same location as the post creator

SELECT *
FROM [dbo].[posts]

SELECT *
FROM [dbo].[Comments]

SELECT *
FROM [dbo].[Users]

SELECT
    p.Id AS PostId,
    c.Id AS CommentId,
    p.OwnerUserId AS PostOwnerId,
    c.UserId AS CommenterUserId,
    u.Location
FROM
    [dbo].[posts] p
JOIN
    [dbo].[Comments] c ON p.Id = c.PostId
JOIN
    [dbo].[Users] u ON u.Id = c.UserId
WHERE
    u.Location = (SELECT Location FROM [dbo].[Users] WHERE Id = p.OwnerUserId);


-- How many users have never voted ?

SELECT *
FROM
	[dbo].[Votes]

SELECT *
FROM
	[dbo].[Users]

WITH users_not_vote AS 
(SELECT
    u.Id AS UserId,
    u.DisplayName
FROM
    [dbo].[Users] u
LEFT JOIN
    [dbo].[Votes] v ON u.Id = v.UserId
WHERE
    v.UserId IS NULL
)

SELECT COUNT(*) AS users_not_voted
FROM
	users_not_vote


-- Display all posts having the highest amount of comments

SELECT *
FROM
	[dbo].[Comments]

SELECT *
FROM
	[dbo].[posts]

WITH CommentCounts AS (
    SELECT
        PostId,
        COUNT(*) AS NumComments
    FROM
        [dbo].[Comments]
    GROUP BY
        PostId
)
SELECT
    p.*
FROM
    [dbo].[posts] p
JOIN
    CommentCounts cc ON p.Id = cc.PostId
WHERE
    cc.NumComments = (SELECT MAX(NumComments) FROM CommentCounts);


-- For each post, how many votes are coming from users living in Canada ? What’s their percentage of the total number of votes

SELECT *
FROM
	[dbo].[posts]

SELECT *
FROM
	[dbo].[Votes]

SELECT *
FROM
	[dbo].[Users]

WITH VotesPerPost AS (
    SELECT
        PostId,
        COUNT(*) AS TotalVotes
    FROM
        [dbo].[Votes]
    GROUP BY
        PostId
),
CanadaVotes AS (
    SELECT
        v.PostId,
        COUNT(*) AS CanadaVotesCount
    FROM
        [dbo].[Votes] v
    JOIN
        [dbo].[Users] u ON v.UserId = u.Id
    WHERE
        u.Location = 'Canada'
    GROUP BY
        v.PostId
)
SELECT
    vp.PostId,
    vp.TotalVotes AS TotalVotesForPost,
    ISNULL(cv.CanadaVotesCount, 0) AS CanadaVotesCount,
    ISNULL((cv.CanadaVotesCount * 100.0 / vp.TotalVotes), 0) AS CanadaVotesPercentage
FROM
    VotesPerPost vp
LEFT JOIN
    CanadaVotes cv ON vp.PostId = cv.PostId;


-- How many hours in average, it takes to the first comment to be posted after a creation of a new post

WITH post_creation_time AS (
    SELECT
        Id,
        CreationDate
    FROM
        [dbo].[posts]
),
comment_creation_time AS (
    SELECT
        Id,
        PostId,
        CreationDate
    FROM
        [dbo].[Comments]
)
SELECT
    AVG(DATEDIFF(HOUR, pct.CreationDate, cct.CreationDate)) AS avg_time_difference
FROM
    comment_creation_time cct
JOIN
    post_creation_time pct ON cct.PostId = pct.Id


-- Whats the most common post tag ? (I have provided the top 5)

SELECT TOP 5
    Tags,
    COUNT(*) AS tag_count
FROM
    [dbo].[posts]
GROUP BY
    Tags
ORDER BY
    COUNT(*) DESC;

-- Create a pivot table displaying how many posts were created for each year (Y axis) and each month (X axis)

SELECT *
FROM
	[dbo].[posts]

SELECT
    YearMonth,
    ISNULL([1], 0) AS January,
    ISNULL([2], 0) AS February,
    ISNULL([3], 0) AS March,
    ISNULL([4], 0) AS April,
    ISNULL([5], 0) AS May,
    ISNULL([6], 0) AS June,
    ISNULL([7], 0) AS July,
    ISNULL([8], 0) AS August,
    ISNULL([9], 0) AS September,
    ISNULL([10], 0) AS October,
    ISNULL([11], 0) AS November,
    ISNULL([12], 0) AS December
FROM (
    SELECT
        CONCAT(YEAR(CreationDate), '-', MONTH(CreationDate)) AS YearMonth,
        MONTH(CreationDate) AS Month,
        COUNT(*) AS NumPosts
    FROM
        [dbo].[posts]
    GROUP BY
        YEAR(CreationDate),
        MONTH(CreationDate)
) AS SourceTable
PIVOT (
    SUM(NumPosts)
    FOR Month IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
) AS PivotTable
ORDER BY
    YearMonth;



	