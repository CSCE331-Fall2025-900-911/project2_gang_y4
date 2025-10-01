SELECT s.ItemNo, s.CustID, s.EmployeeId, s.SaleDate
FROM Sales s
LEFT JOIN Employees e ON s.EmployeeId = e.EmployeeId
WHERE e.Level = 'Manager';
