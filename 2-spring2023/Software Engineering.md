# Software Engineering

> multi-person construction of multi-version software 

*Author: Daria Shutina*



[TOC]



## 23-02-02

### Organization stuff

Course link: https://peter-baumann.org/Courses/SoftwareEngineering/index.php



**Project:**

A group of 4-5 people submit a design doc, then there are 2-week phases: 

- Specification & design (teams of 5 – free to join up) 
- Code sprints Implementation (teams of 2 – random)



**Grading:**

Software Engineering *lecture* (2.5 CP) = 33%

Software Engineering *project* (5 CP)    = 67%





### Failures and Catastrophes

http://catless.ncl.ac.uk/Risks/



Lessons from cases:

1. ***don't optimize to death.***

   Y2K: "1997" in COBOL stored as "97", and "2000" -- as "00".

2. ***be careful with guessing user intent. Users need guidance.***

   a bug in FORTRAN code: "DO 20 I = 1,100" and "DO 20 I = 1.100"





### How to Program?

1. Write code
2. Test it on a few samples 
3. Bug fixing, improving efficiency
4. GOTO 1

This is usually appropriate for 1-person projects. In real-life projects there are different people $\Rightarrow$ different ideas through years. Also, if developer $\neq$ user, there is a frequent dissent about expected vs. implemented functionality. 

Common problems for SE projects are mostly about organization: 

- Complexity of the idea
- Communication (b2b, b2c)
- Flexibility: change of requirements, components, methods, tools over lifetime
- Lack of education
- Bad project management

