set echo ON

-- Exercise_6 Ch.4
-- Write a SELECT statement that returns two columns from the General_Ledger_Accounts table:
-- account_number and account_description. The result set should have one row for each account number
-- that has never been used. Sort the final result set account_number. 
-- Hint: Use an outer join to the Invoice_Line_Items table.

SELECT gl.account_number, gl.account_description
FROM general_ledger_accounts gl
LEFT OUTER JOIN
invoice_line_items il
ON gl.account_number = il.account_number
WHERE il.account_number IS NULL
ORDER BY gl.account_number;


-- Exercise_3 Ch.6
-- write a SELECT statement that returns two columns from the General_Ledger_Accounts table:
-- account_number and account_description. The result set should have one row for each account number
-- that has never been used. Use a subquery introduced with the NOT EXISTS opertor,
-- and sort the result set by account_number.

SELECT gl.account_number, gl.account_description
FROM general_ledger_accounts gl
WHERE NOT EXISTS (
    SELECT *
    FROM invoice_line_items il
    WHERE gl.account_number = il.account_number
    AND il.account_number IS NULL
)
ORDER BY gl.account_number;