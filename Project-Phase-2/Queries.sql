/* Calculate  the total value of accounts associated with each branch */

SELECT B.BranchID, SUM(A.BALANCE) AS Total_Account_Value
FROM ACCOUNT A, MANAGES M, CUSTOMER C, BRANCH B
WHERE A.ACCOUNTNO = M.ACCOUNTNO AND M.CUSTOMERSSN = C.SSN AND C.BRANCHID = B.BRANCHID
GROUP BY B.BranchID;

/* Only display the branches with employees that have more than 1 dependent and the number of dependents*/

SELECT B.BranchID, COUNT(*) as Number_of_Dependents
FROM BRANCH B, Employee E, Dependent D
WHERE B.BranchID = E.BranchID AND D.ESSN = E.SSN 
GROUP BY B.BranchID
HAVING COUNT(*) > 1;

/* Select the employees salaries higher than all of the employees in Branch 1 */

SELECT E.SSN, E.FNAME, E.SALARY, E.BRANCHID
FROM EMPLOYEE E
WHERE E.SALARY > ALL 
                 (SELECT SALARY
                  FROM EMPLOYEE
                  WHERE BranchID = 'B001');
                  
/* Select the customers that have Loan Accounts */

SELECT C.SSN, C.FNAME, C.LNAME, M.ACCOUNTNO
FROM CUSTOMER C, MANAGES M
WHERE C.SSN = M.CUSTOMERSSN AND M.ACCOUNTNO IN 
              (SELECT ACCOUNTNO
               FROM ACCOUNT
               WHERE TYPE = 'Loan Account');