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
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
