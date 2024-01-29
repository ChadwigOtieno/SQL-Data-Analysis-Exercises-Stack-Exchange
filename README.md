# SQL Data Analysis Exercises – Stack Exchange

This repository contains SQL exercises related to data analysis tasks based on the structure of the Movies & TV Stack Exchange site.

## Database Structure
The database consists of four tables:
- `Posts`: Contains information about each post, including post ID, title, and creation date.
- `Votes`: Stores details about votes made on posts, including the voting ID, user number, post number, and creation date.
- `Comments`: Contains details regarding comments made on posts, including comment ID, post number, user number, and creation date.
- `Users`: Stores information about users, including user ID, username, age, location, etc.

## Exercises
### Basic Analysis
1. **How many posts were made each year?**
   - A query to count the number of posts created each year.

2. **How many votes were made on each day of the week?**
   - A query to count the number of votes made on each day of the week (Sunday, Monday, Tuesday, etc.).

3. **List all comments created on September 19th, 2012.**
   - A query to retrieve all comments created on September 19th, 2012.

4. **List all users under the age of 33 living in London.**
   - A query to list all users under the age of 33 who are living in London.

### Advanced Analysis
5. **Display the number of votes for each post title.**
   - A query to display the number of votes for each post title.

6. **Display posts with comments created by users living in the same location as the post creator.**
   - A query to display posts with comments created by users living in the same location as the post creator.

7. **How many users have never voted?**
   - A query to count the number of users who have never voted.

8. **Display all posts having the highest amount of comments.**
   - A query to display all posts with the highest amount of comments.

9. **For each post, how many votes are coming from users living in Canada? What’s their percentage of the total number of votes?**
   - A query to calculate the number of votes for each post coming from users living in Canada and their percentage of the total number of votes.

10. **How many hours on average does it take for the first comment to be posted after the creation of a new post?**
    - A query to calculate the average time it takes for the first comment to be posted after the creation of a new post.

11. **What's the most common post tag?**
    - A query to find the most common post tag.

12. **Create a pivot table displaying how many posts were created for each year (Y-axis) and each month (X-axis).**
    - A query to create a pivot table displaying the number of posts created for each year on the Y-axis and each month on the X-axis.

Feel free to use and modify these queries for your own data analysis tasks.
