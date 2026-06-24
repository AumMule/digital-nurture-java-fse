package com.bank;

import static org.junit.Assert.*;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class BankAccountTest {

    private BankAccount account;

    @Before
    public void setUp() {
        account = new BankAccount(100.0);
    }

    @After
    public void tearDown() {
        account = null;
    }

    @Test
    public void testDeposit() {
        double depositAmount = 50.0;
        double expectedBalance = 150.0;

        account.deposit(depositAmount);

        assertEquals(expectedBalance, account.getBalance(), 0.001);
    }

    @Test
    public void testWithdraw() {
        double withdrawAmount = 40.0;
        double expectedBalance = 60.0;

        account.withdraw(withdrawAmount);

        assertEquals(expectedBalance, account.getBalance(), 0.001);
    }

    @Test(expected = IllegalArgumentException.class)
    public void testWithdrawInsufficientFunds() {
        double withdrawAmount = 150.0;
        account.withdraw(withdrawAmount);
    }

    @Test
    public void testDepositInvalidAmount() {
        double invalidAmount = -10.0;
        try {
            account.deposit(invalidAmount);
            fail("Expected IllegalArgumentException was not thrown");
        } catch (IllegalArgumentException e) {
            assertEquals("Deposit amount must be greater than zero", e.getMessage());
        }
    }
}
