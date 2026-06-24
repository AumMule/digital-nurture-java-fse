CREATE OR REPLACE PROCEDURE TransferFunds (
    p_from_account IN NUMBER,
    p_to_account IN NUMBER,
    p_amount IN NUMBER
) IS
    v_from_balance NUMBER;
    v_dummy NUMBER;
BEGIN
    IF p_amount <= 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 'Amount must be greater than zero.');
    END IF;

    IF p_from_account = p_to_account THEN
        RAISE_APPLICATION_ERROR(-20007, 'Source and destination accounts must be different.');
    END IF;

    BEGIN
        SELECT Balance INTO v_from_balance FROM Accounts WHERE AccountID = p_from_account FOR UPDATE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20005, 'Source account ' || p_from_account || ' does not exist.');
    END;

    BEGIN
        SELECT AccountID INTO v_dummy FROM Accounts WHERE AccountID = p_to_account FOR UPDATE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20006, 'Destination account ' || p_to_account || ' does not exist.');
    END;

    IF v_from_balance < p_amount THEN
        RAISE_APPLICATION_ERROR(-20003, 'Insufficient funds.');
    END IF;

    UPDATE Accounts SET Balance = Balance - p_amount WHERE AccountID = p_from_account;
    UPDATE Accounts SET Balance = Balance + p_amount WHERE AccountID = p_to_account;

    DBMS_OUTPUT.PUT_LINE('Transferred $' || p_amount || ' from ' || p_from_account || ' to ' || p_to_account);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        RAISE;
END TransferFunds;
/
