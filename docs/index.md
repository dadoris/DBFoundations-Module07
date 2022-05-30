David Doris<br/>
May  31, 2022<br/>
Foundations of Databases and SQL Programming<br/>
Assignment 07<br/>

# Module 07: Functions
## Introduction
This week’s topic is Functions including scalar, table, and user defined functions (UDF).  In addition to posting to the GitHub repository as I did for module 06, I've  created this GitHub webpage for review.  This week's questions are: 
- Explain when you would use a SQL UDF.
- Explain are the differences between Scalar, Inline, and Multi-Statement Functions.

### When to use a SQL User Defined Function (UDF)
I would use a User Defined Function: 
- for calculations frequently repeated in my database or 
- to implement capabilities not addressed by built-in functions.  
For example, if my requirements included a Check constraint, I would use a custom scalar function to reference a column in another table because such a reference would not otherwise be possible as noted in the Module07Notes.docx file, page 18.

### Differences between Scalar, Inline, and Multi-Statement Functions
- A Scalar function returns a single value.
- Inline and Multi-statement functions return tables, also known as recordsets:
  - **Inline functions** are similar to **Views** because they “can only contain a single SELECT statement, and the columns in the SELECT statement implicitly define the columns of the returned table set of the function.”
  - **Multi-statement** functions are also known as table-valued functions and return the result of multiple statements.  These functions are essentially “**a stored procedure** that accepts arguments and returns a table recordset, defined as a table variable. The table value function can contain multiple statements and flow control logic, just like a regular stored procedure. The last statement of the procedure needs to be a RETURN statement, at which point the declared table variable is returned to the calling context.” 
##### Table value functions vs Inline functions, https://sqlsunday.com/2013/05/05/table-value-vs-inline-table-functions/, SQLSUNDAY.COM. 
In SQL Server 2019, The difference between single value and table functons is blurred because both can be inlined. 
##### Scalar function inlining in SQL Server 2019, https://sqlsunday.com/2019/04/08/scalar-function-inlining-in-sql-server-2019/, SQLSUNDAY.COM.
  
### Weekly Progress 
As the end of the course approaches, I’m pleased to have studied the topics in this module.  In the past, I’ve worked with basic SQL SELECT queries, but not with Views, Functions, or Stored Procedures.  I’ve worked with recordsets while programming in Visual Basic, and that’s given me some reference points.  But my coursework is the beginning, not the end, of the process and expect to explore these new concepts and tools well beyond June. 

### GitHub Link
SQL script & writeup files: https://github.com/dadoris/module07_functions
GitHub webpage: https://github.com/dadoris/module07_functions/blob/main/docs/index.md

## Summary 
This week dealt with Functions, and presented further details about Views and Stored Procedures,  continued posting coursework on GitHub, and added creating a GitHub webpage to my deliverables.  

## my SQL Hero:
![this is my sql hero:](pexels-public-domain-pictures-68136.jpg)
