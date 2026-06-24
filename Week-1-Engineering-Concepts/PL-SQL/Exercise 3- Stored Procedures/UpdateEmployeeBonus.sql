CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
    p_department IN VARCHAR2,
    p_bonus_percentage IN NUMBER
) IS
    v_rows_updated NUMBER := 0;
BEGIN
    IF p_department IS NULL OR TRIM(p_department) = '' THEN
        RAISE_APPLICATION_ERROR(-20001, 'Department cannot be null or empty.');
    END IF;
    
    IF p_bonus_percentage IS NULL OR p_bonus_percentage < 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Bonus percentage must be non-negative.');
    END IF;

    UPDATE Employees
    SET Salary = Salary * (1 + p_bonus_percentage / 100)
    WHERE Department = p_department;
    
    v_rows_updated := SQL%ROWCOUNT;
    DBMS_OUTPUT.PUT_LINE('Bonus update completed. Updated: ' || v_rows_updated);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RAISE;
END UpdateEmployeeBonus;
/
