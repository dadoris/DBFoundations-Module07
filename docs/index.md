### David Doris
##### May 31, 2022
Foundations of Databases and SQL Programming
Assignment 07

# Module 07: Functions

## Introduction
This week’s topic is Functions including scalar, table, and user defined functions. (UDF).  In addition to posting to the GitHub repository, I will create a GitHub webpage for review.  In addition, I will answer the following questions: 
•	Explain when you would use a SQL UDF.
•	Explain are the differences between Scalar, Inline, and Multi-Statement Functions.
###
### When to use a SQL User Defined Function (UDF)
I would use a User Defined Function: 

*•	for calculations frequently repeated in my database or 

*•	to implement capabilities not addressed by built-in functions.  

For example, if my requirements included a Check constraint, I would use a custom scalar function to reference a column in another table because such a reference would not otherwise be possible as noted in the Module07Notes.docx file, page 18.
###
### Differences between Scalar, Inline, and Multi-Statement Functions
* •	A Scalar function returns a single value.
*•	Inline and Multi-statement functions return tables, also known as recordsets.  
*     o	Inline functions are similar to Views because they “can only contain a single SELECT statement, and the columns in the SELECT statement implicitly define the             columns of the returned table set of the function.” 
*o  Multi-statement functions are also known as table-valued functions and return the result of multiple statements.  These functions are essentially “a stored               procedure that accepts arguments and returns a table recordset, defined as a table variable. The table value function can contain multiple statements and flow             control logic, just like a regular stored procedure. The last statement of the procedure needs to be a RETURN statement, at which point the declared table                 variable is returned to the calling context.”
###
### Table value functions vs Inline functions, SQLSUNDAY.COM. 
In SQL Server 2019, The difference between single value and table functons is blurred because both can be inlined. Scalar function inlining in SQL Server 2019, SQLSUNDAY.COM.
###
### Weekly Progress 
As the end of the course approaches, I’m pleased to have studied the topics in this module.  In the past, I’ve worked with basic SQL SELECT queries, but not with Views, Functions, or Stored Procedures.  I’ve worked with recordsets while programming in Visual Basic, and that’s given me some reference points.  But my coursework is the beginning, not the end, of the process and expect to explore these new concepts and tools well beyond June. 
###
### GitHub Link
https://github.com/dadoris/module07_functions
@@
## Summary 
This week dealt with Views, Functions, and Stored Procedures and continued posting coursework on GitHub and added creating a GitHub webpage to my deliverables.  



# Title
## Introduction
## Topic 1
### Subtopic
## Summary

