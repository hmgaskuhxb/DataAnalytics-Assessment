# DataAnalytics-Assessment
DataAnalytics-Assessment# DataAnalytics-Assessment

## Overview

This repository contains SQL solutions to four analytical queries using a banking dataset. The focus is on customer behavior analysis, transaction activity, and value prediction.

---

## Q1: High-Value Customers with Multiple Products

**Objective:** Identify customers who have both a funded savings and funded investment plan.

**Approach:**
- Join the `savings_savingsaccount` and `plans_plan` tables with `users_customuser`.
- Filter savings accounts with `is_regular_savings = 1` and confirmed amount > 0.
- Filter investment plans with `is_a_fund = 1` and confirmed amount > 0.
- Group by customer and count each type of plan.

---

## Q2: Transaction Frequency Analysis

**Objective:** Categorize users based on average transaction frequency per month.

**Approach:**
- Count total transactions per user.
- Calculate average monthly transactions since their first transaction.
- Categorize customers into High, Medium, or Low frequency based on thresholds.

---

## Q3: Account Inactivity Alert

**Objective:** Identify accounts with no inflow transactions for over a year.

**Approach:**
- Use the last transaction date from both `savings_savingsaccount` and `plans_plan`.
- Filter out accounts with inactivity greater than 365 days.

---

## Q4: Customer Lifetime Value Estimation

**Objective:** Estimate CLV based on transaction history and tenure.

**Approach:**
- Calculate tenure in months using the `date_joined` field.
- Aggregate total transactions and value.
- Use the given CLV formula and round the final result to two decimal places.

