SET SERVEROUTPUT ON SIZE 1000000;

PROMPT ===================================================
PROMPT INITIAL STATE
PROMPT ===================================================
SELECT CustomerID, Name, DOB, Balance, IsVIP FROM Customers;
SELECT AccountID, CustomerID, AccountType, Balance, LastInterestApplied FROM Accounts;
SELECT LoanID, CustomerID, LoanAmount, InterestRate, DueDate FROM Loans;
SELECT EmployeeID, Name, Department, Salary FROM Employees;

PROMPT ===================================================
PROMPT EXERCISE 1: CONTROL STRUCTURES
PROMPT ===================================================

DECLARE
    CURSOR c_customers IS
        SELECT CustomerID, Name, DOB FROM Customers;
    v_age NUMBER;
    v_loans_updated NUMBER := 0;
BEGIN
    FOR r_cust IN c_customers LOOP
        v_age := FLOOR(MONTHS_BETWEEN(SYSDATE, r_cust.DOB) / 12);
        IF v_age > 60 THEN
            UPDATE Loans
            SET InterestRate = InterestRate - 1
            WHERE CustomerID = r_cust.CustomerID;
            
            IF SQL%ROWCOUNT > 0 THEN
                v_loans_updated := v_loans_updated + SQL%ROWCOUNT;
                DBMS_OUTPUT.PUT_LINE('Customer ' || r_cust.Name || ' (Age: ' || v_age || ') discount applied.');
            END IF;
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Discount process completed. Updated: ' || v_loans_updated);
    COMMIT;
END;
/

DECLARE
    CURSOR c_customers IS
        SELECT CustomerID, Name, Balance, IsVIP FROM Customers FOR UPDATE OF IsVIP;
    v_vip_count NUMBER := 0;
BEGIN
    FOR r_cust IN c_customers LOOP
        IF r_cust.Balance > 10000 THEN
            UPDATE Customers
            SET IsVIP = 'TRUE'
            WHERE CURRENT OF c_customers;
            v_vip_count := v_vip_count + 1;
            DBMS_OUTPUT.PUT_LINE('Customer ' || r_cust.Name || ' promoted to VIP.');
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('VIP promotion completed. Promoted: ' || v_vip_count);
    COMMIT;
END;
/

DECLARE
    CURSOR c_due_loans IS
        SELECT c.Name, l.LoanID, l.LoanAmount, l.DueDate
        FROM Loans l
        JOIN Customers c ON l.CustomerID = c.CustomerID
        WHERE l.DueDate BETWEEN SYSDATE AND SYSDATE + 30;
BEGIN
    FOR r_loan IN c_due_loans LOOP
        DBMS_OUTPUT.PUT_LINE('Reminder: Dear ' || r_loan.Name || ', your loan ' || r_loan.LoanID || 
                             ' of $' || r_loan.LoanAmount || ' is due on ' || TO_CHAR(r_loan.DueDate, 'YYYY-MM-DD'));
    END LOOP;
END;
/

PROMPT ===================================================
PROMPT EXERCISE 3: STORED PROCEDURES
PROMPT ===================================================

BEGIN
    ProcessMonthlyInterest;
END;
/
SELECT AccountID, CustomerID, AccountType, Balance, LastInterestApplied FROM Accounts;

BEGIN
    UpdateEmployeeBonus('IT', 10);
END;
/
SELECT EmployeeID, Name, Department, Salary FROM Employees;

BEGIN
    TransferFunds(101, 102, 1500);
END;
/
SELECT AccountID, CustomerID, AccountType, Balance FROM Accounts;

BEGIN
    TransferFunds(102, 101, 50000);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Caught exception: ' || SQLERRM);
END;
/

BEGIN
    TransferFunds(999, 101, 100);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Caught exception: ' || SQLERRM);
END;
/
