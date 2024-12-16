-- Query to generate supplier payment plans 
--------------------------------------------------------------------------------------
-- Result:
--   - supplier - the `SUPPLIER.name` of the `SUPPLIER.supplier_id`.
--   - payment_amount - the sum of all uniform monthly payments to fully pay the `SUPPLIER` for any `INVOICE` 
--                      before the `INVOICE.due_date`. If a supplier has multiple invoices, the aggregate monthly payments may be uneven. 
--   - balance_outstanding - total balance outstanding across ALL `INVOICE`s for the `SUPPLIER.supplier_id`
--   - payment_date - the last day of the month for any payment for any invoice


USE memory.default;


WITH PaymentSchedule AS (
    -- Calculate invoice payments and distribute them across months until the due date
    SELECT
        inv.supplier_id,
        inv.invoice_amount / DATE_DIFF('month', CURRENT_DATE, inv.due_date) AS monthly_invoice,
        last_day_of_month(DATE_ADD('month', offset - 1, CURRENT_DATE)) AS payment_date
    FROM memory.default.INVOICE inv,
         UNNEST(SEQUENCE(1, DATE_DIFF('month', CURRENT_DATE, inv.due_date))) AS t(offset) -- Alias the unnest result
),
MonthlyPayments AS (
    -- Aggregate monthly payments for each supplier
    SELECT
        ps.supplier_id,
        sup.name AS supplier_name,
        ps.payment_date,
        SUM(ps.monthly_invoice) AS total_monthly_payment,
        SUM(SUM(ps.monthly_invoice)) OVER (PARTITION BY ps.supplier_id 
                                          ORDER BY ps.payment_date 
                                          ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
         ) AS cumulative_payments,
        GREATEST(
            SUM(SUM(ps.monthly_invoice)) OVER (PARTITION BY ps.supplier_id) 
            - SUM(SUM(ps.monthly_invoice)) OVER (PARTITION BY ps.supplier_id 
                                                 ORDER BY ps.payment_date 
                                                 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),
            0
        ) AS balance_outstanding
    FROM PaymentSchedule ps
    JOIN memory.default.SUPPLIER sup ON ps.supplier_id = sup.supplier_id
    GROUP BY ps.supplier_id, ps.payment_date, sup.name
)
-- Payment schedule
SELECT
    supplier_id,
    supplier_name,
    total_monthly_payment as payment_amount,
    balance_outstanding,
    payment_date
FROM MonthlyPayments
ORDER BY supplier_id, payment_date;
