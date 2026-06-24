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
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
