# Sequra Backend Challenge

This project is a backend challenge for a position at Sequra. The challenge involves implementing a system to automate the calculation of merchants’ disbursements payouts and Sequra commissions for both existing and new orders.

## Problem to Solve:

### Context

Sequra provides e-commerce shops with a flexible payment method, allowing shoppers to split their purchases into three monthly payments without any cost. In return, Sequra earns a fee for each purchase.

When shoppers use this payment method, they pay directly to Sequra. Sequra then disburses payments to merchants with different frequencies and pricing models.

This challenge focuses on implementing the process of disbursing payments to merchants.

### Problem Statement

We need to implement a system that automates the calculation of merchants' disbursements and Sequra's commissions for both existing and new orders (present in CSV files).

The system must adhere to the following requirements:

- **All orders** must be disbursed exactly once.
- Each disbursement (i.e., group of orders paid to a merchant on the same date) must have a **unique alphanumerical reference**.
- Orders, amounts, and fees included in disbursements must be easily identifiable for **reporting purposes**.
- The disbursement calculation process must be completed **by 8:00 UTC daily**. Only merchants that meet the requirements for disbursement that day should be processed.
- Merchants may be disbursed either **daily** or **weekly**.
  - Weekly disbursements will occur on the same weekday as their `live_on` date (the date when the merchant started using Sequra, present in the CSV files).
  - Disbursements group all orders for a merchant over the course of a day or week.
  
For each order included in a disbursement, Sequra will take a **commission**, which is subtracted from the merchant's order value before disbursement. The pricing is as follows:

1. **1.00% fee** for orders with an amount strictly less than 50 €.
2. **0.95% fee** for orders with an amount between 50 € and 300 €.
3. **0.85% fee** for orders with an amount of 300 € or more.

When handling monetary values, rounding must be done **to two decimal places** following proper rounding rules.

Lastly, on the first disbursement of each month, we need to verify whether the **minimum monthly fee** for the previous month was reached for each merchant. The minimum monthly fee ensures that Sequra earns at least a specified amount from each merchant.

- If a merchant generates less than the minimum monthly fee from commissions in the previous month, the difference (up to the minimum monthly fee) will be recorded as a **"monthly fee"**.
- No charge is made if the merchant generates more than the minimum monthly fee.

**Note:** Charging the minimum monthly fee is out of the scope of this challenge. We only need to calculate and store it for future use.

---

## Requirements

- **Ruby 3.2**
- **PostgreSQL**
- **Redis** (optional)

## How to Run the System

1. Clone the repository:
   ```bash
   git clone <repository_url>
   ```
2. Start Redis: (optional)
   - If you want to start using Sidekiq-cron and redis, uncomment the Sidekiq-Cron code in `config/initializers/sidekiq`.
    ```bash
   redis-server
   ```
   
3.  Install required gems
  ```bash
   bundle install
   ```
   
4.  Create DataBase
  ```bash
   rails db:create
   ```
   
5.  Create migrations
  ```bash
   rails db:migrate
   ```
 
6.  Create seeds
  ```bash
   rails db:seed
   ```
   This command will load the two CSV files included in the repository, as required for the challenge.
   
7.  Start Sidekiq (Optional)

    To run Sidekiq, open a new terminal window and run:

    ```bash
   bundle exec sidekiq
   ```


## Running the Tests

To run the tests, you need to use RSpec. After setting up the project, run the following command:

 ```bash
   bundle exec rspec
 ```

 ## How to Run historical data

 To run historical data, you need to use the `orders_history` rake task. After setting up the project, run the following command:

 ```bash
    bundle exec rake orders_history:create_disbursements
 ```

 ## How to Run the Analytics

 To run the analytics, you need to use the `analytics` end point.

 http://localhost:3000/analytics

 and the response is:

 | Year  | Number of Disbursements | Total Amount Merchants       | Total Commission Amount       | Number of Minimum Fees  | Total Minimum Fees        |
|-------|-------------------------|-------------------------------|-------------------------------|-------------------------|---------------------------|
| 2023  | 10,363                  | 187,985,178.07                | 1,698,407.74                  | 120                     | 3,000.00                  |
| 2022  | 1,547                   | 37,514,640.36                 | 337,951.01                    | 31                      | 795.00                    |

**Note:** all the money values are in cents in the system.

## About cron jobs (optional)

I know that it wasn't necesary for the challenge, but I have added it anyway
