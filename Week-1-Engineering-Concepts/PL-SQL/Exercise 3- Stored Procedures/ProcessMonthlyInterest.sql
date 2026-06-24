CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest IS
    v_rows_updated NUMBER := 0;
BEGIN
    UPDATE Accounts
    SET Balance = Balance * 1.01,
        LastInterestApplied = SYSDATE
    WHERE AccountType = 'Savings';
    
    v_rows_updated := SQL%ROWCOUNT;
    DBMS_OUTPUT.PUT_LINE('Interest process completed. Updated: ' || v_rows_updated);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RAISE;
END ProcessMonthlyInterest;
/
