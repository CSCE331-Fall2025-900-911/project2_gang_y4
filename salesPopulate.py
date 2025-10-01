import csv
import random
from datetime import datetime, timedelta

# Load inventoryReal.csv to get unit prices
inventory_prices = {}
with open('inventoryReal.csv', newline='') as invfile:
    reader = csv.DictReader(invfile)
    for row in reader:
        inventory_prices[int(row['ItemID'])] = float(row['Unit_Price'])

# Parameters
num_days = 365
num_inventory = max(inventory_prices.keys())
num_customers = 75
num_employees = 7
total_sales_target = 755000
peak_days = [0, 30, 60, 120, 240]  # e.g., semester start, game days (indexes into days)
peak_multiplier = 5  # Sales are 5x on peak days

# Generate sales
sales = []
sales_id = 1
start_date = datetime.now() - timedelta(days=num_days)
total_sales = 0

for day in range(num_days):
    date = start_date + timedelta(days=day)
    # Determine if this is a peak day
    is_peak = day in peak_days
    # Base sales per day
    base_sales = random.randint(45, 65)
    if is_peak:
        base_sales *= peak_multiplier
    for _ in range(base_sales):
        # Each sale (transaction) can have multiple items (line items)
        cust_id = random.randint(1, num_customers)
        employee_id = random.randint(1, num_employees)
        num_items = random.randint(1, 5)  # Number of different items in this sale
        sale_line_items = []
        for _ in range(num_items):
            inventory_id = random.randint(1, num_inventory)
            unit_price = inventory_prices[inventory_id]
            quantity = random.randint(1, 4)
            price = round(unit_price * quantity, 2)
            sale_line_items.append([
                sales_id, inventory_id, cust_id, employee_id, price, unit_price,
                date.strftime('%Y-%m-%d'), quantity
            ])
            total_sales += price
        sales.extend(sale_line_items)
        sales_id += 1
        if total_sales >= total_sales_target:
            break
    if total_sales >= total_sales_target:
        break

# Write to CSV
with open('salesPopulate.csv', 'w', newline='') as csvfile:
    writer = csv.writer(csvfile)
    writer.writerow(['SalesID', 'InventoryID', 'CustID', 'EmployeeID', 'Price', 'Unit_Price', 'Sale_Date', 'quantity'])
    writer.writerows(sales)

print(f"Generated {len(sales)} sales line items, total sales: ${total_sales:,.2f}")