# Library Database — SQL & Relational Algebra

Library data — books, authors, branches, borrowers, and loan records — is spread across many interrelated tables. Without the right queries, simple operational questions like *"which borrowers currently have more than 5 books checked out?"* or *"how many copies of a book are available at each branch?"* become slow to answer and error-prone if done manually.

This project designs a library database schema (7 interrelated tables, including a many-to-many relationship between Book and Author) and writes 7 SQL queries to answer those operational questions, using a range of techniques: aggregation (SUM, COUNT), multi-table JOINs, subqueries (NOT IN, NOT EXISTS), and UNION ALL to handle empty-result edge cases. Each query is also mapped back to its corresponding **relational algebra** operation (σ, π, ⋈, γ, etc.) as its theoretical foundation.

As a result, information that would otherwise require manually cross-referencing multiple tables can now be retrieved with a single query — an approach that can be directly adapted to a real library information system or similar relational data management use cases.

This project was completed for the **Database Technology** course, Department of Mathematics, Institut Teknologi Sepuluh Nopember.

**Author:** Raissa Undita Estiningtyas

## Database Structure

The database consists of 7 tables:
- `Publisher` — publisher data
- `Author` — author data
- `Book` — book data (linked to Publisher)
- `Book_Authors` — junction table linking Book ↔ Author (many-to-many relationship)
- `Library_Branch` — library branch data
- `Borrower` — borrower data
- `Book_Copies` — number of copies of each book per branch
- `Book_Loans` — book loan records

## SQL Output Overview

<p align="center"> <img src="overview/tabel publisher.png" width="60%"> </p>
<p align="center"> <em>Sample content of a database table.</em> </p>

<p align="center"> <img src="overview/sql no 5.png" width="60%"> </p>
<p align="center"> <em>Result table answering query No. 5.</em> </p>

## Repository Contents

```
library-database-sql/
├── README.md
├── schema/
│   └── create_tables.sql   -- table structure + sample data
├── queries/
│   └── queries.sql          -- 7 analysis queries
```

## Questions & Queries

| No | Question | Query |
|----|------|-------|
| 1 | Number of copies of "The Lost Tribe" at the "Sharpstown" branch | [queries.sql](queries/queries.sql#L8) |
| 2 | Number of copies of "The Lost Tribe" per branch | [queries.sql](queries/queries.sql#L18) |
| 3 | Borrowers who do not currently have any books checked out | [queries.sql](queries/queries.sql#L27) |
| 4 | Books due today at the "Sharpstown" branch | [queries.sql](queries/queries.sql#L38) |
| 5 | Total books loaned per branch | [queries.sql](queries/queries.sql#L55) |
| 6 | Borrowers currently holding more than 5 books | [queries.sql](queries/queries.sql#L68) |
| 7 | Books by Stephen King and their stock at the "Central" branch | [queries.sql](queries/queries.sql#L97) |

## Relational Algebra to SQL Mapping

| Symbol | Operation | SQL Equivalent |
|--------|--------------|-------------|
| σ | Selection | `WHERE` |
| π | Projection | `SELECT` |
| ⋈ | Join (Inner Join) | `INNER JOIN ... ON ...` |
| ⟗ | Full Outer Join | `FULL JOIN ... ON ...` |
| ⟖ | Right Outer Join | `RIGHT JOIN ... ON ...` |
| ⟕ | Left Outer Join | `LEFT JOIN ... ON ...` |
| − | Difference | `EXCEPT` (or `NOT IN`, `NOT EXISTS`) |
| ⋃ | Union | `UNION` |
| ∩ | Intersection | `INTERSECT` |
| γ | Aggregation/Grouping | `GROUP BY` + aggregate functions (`COUNT`, `SUM`, `AVG`, `MIN`, `MAX`) |
| ρ | Rename | `AS` |
| → | Assignment | `CREATE VIEW` or `WITH ... AS ...` (CTE) |

## How to Run

1. Run `schema/create_tables.sql` to create the tables and populate them with sample data.
2. Run any query in `queries/queries.sql` corresponding to the question number you want to see.
