DECLARE
    CURSOR c_due_loans IS
        SELECT c.Name, l.LoanID, l.LoanAmount, l.DueDate
        FROM Loans l
        JOIN Customers c ON l.CustomerID = c.CustomerID
        WHERE l.DueDate BETWEEN SYSDATE AND SYSDATE + 30;
    v_count NUMBER := 0;
BEGIN
    FOR r_loan IN c_due_loans LOOP
        DBMS_OUTPUT.PUT_LINE('Reminder: Dear ' || r_loan.Name || ', your loan ' || r_loan.LoanID || 
                             ' of $' || r_loan.LoanAmount || ' is due on ' || TO_CHAR(r_loan.DueDate, 'YYYY-MM-DD'));
        v_count := v_count + 1;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('Total reminders: ' || v_count);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
