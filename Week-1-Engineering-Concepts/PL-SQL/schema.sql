BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Loans';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Accounts';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Customers';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Employees';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN RAISE; END IF;
END;
/

CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    Name VARCHAR2(100) NOT NULL,
    DOB DATE NOT NULL,
    Balance NUMBER(15, 2) NOT NULL,
    IsVIP VARCHAR2(5) DEFAULT 'FALSE' CHECK (IsVIP IN ('TRUE', 'FALSE'))
);

CREATE TABLE Accounts (
    AccountID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    AccountType VARCHAR2(50) NOT NULL,
    Balance NUMBER(15, 2) NOT NULL,
    LastInterestApplied DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Loans (
    LoanID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    LoanAmount NUMBER(15, 2) NOT NULL,
    InterestRate NUMBER(5, 2) NOT NULL,
    DueDate DATE NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Employees (
    EmployeeID NUMBER PRIMARY KEY,
    Name VARCHAR2(100) NOT NULL,
    Department VARCHAR2(50) NOT NULL,
    Salary NUMBER(15, 2) NOT NULL
);

INSERT INTO Customers (CustomerID, Name, DOB, Balance, IsVIP)
VALUES (1, 'Alice Smith', TO_DATE('1955-05-15', 'YYYY-MM-DD'), 12000.00, 'FALSE');

INSERT INTO Customers (CustomerID, Name, DOB, Balance, IsVIP)
VALUES (2, 'Bob Jones', TO_DATE('1981-08-20', 'YYYY-MM-DD'), 8500.00, 'FALSE');

INSERT INTO Customers (CustomerID, Name, DOB, Balance, IsVIP)
VALUES (3, 'Charlie Brown', TO_DATE('1960-01-10', 'YYYY-MM-DD'), 15000.00, 'FALSE');

INSERT INTO Customers (CustomerID, Name, DOB, Balance, IsVIP)
VALUES (4, 'Diana Prince', TO_DATE('1996-12-05', 'YYYY-MM-DD'), 25000.00, 'FALSE');

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastInterestApplied)
VALUES (101, 1, 'Savings', 12000.00, SYSDATE - 30);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastInterestApplied)
VALUES (102, 2, 'Savings', 8500.00, SYSDATE - 30);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastInterestApplied)
VALUES (103, 3, 'Checking', 15000.00, SYSDATE - 30);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastInterestApplied)
VALUES (104, 4, 'Savings', 25000.00, SYSDATE - 30);

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, DueDate)
VALUES (201, 1, 5000.00, 8.0, SYSDATE + 20);

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, DueDate)
VALUES (202, 2, 10000.00, 7.5, SYSDATE + 45);

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, DueDate)
VALUES (203, 3, 8000.00, 9.5, SYSDATE + 10);

INSERT INTO Employees (EmployeeID, Name, Department, Salary)
VALUES (301, 'John Doe', 'IT', 50000.00);

INSERT INTO Employees (EmployeeID, Name, Department, Salary)
VALUES (302, 'Jane Smith', 'HR', 60000.00);

INSERT INTO Employees (EmployeeID, Name, Department, Salary)
VALUES (303, 'Mike Johnson', 'IT', 55000.00);

COMMIT;
