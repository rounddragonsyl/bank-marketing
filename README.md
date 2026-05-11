# Retail Banking Customer Analytics

A SQL analytics project examining customer segmentation, product uptake, campaign performance, and credit risk using a Portuguese retail bank dataset (~45,000 records).

**Resume bullet:**
> Conducted retail banking customer analytics using PostgreSQL across 11,000+ customer records, writing 15 business-focused SQL queries covering customer profiling, product conversion analysis, campaign performance, and risk segmentation using window functions and CTEs.

---

## Business Question

**"Which customer segments are most valuable to the bank, and what factors drive product uptake and churn risk?"**

---

## Dataset

[Bank Marketing Dataset](https://www.kaggle.com/datasets/janiobachmann/bank-marketing-dataset) — UCI Machine Learning Repository via Kaggle.

| Field | Description |
|---|---|
| `age` | Customer age |
| `job` | Occupation type |
| `marital` | Marital status |
| `education` | Education level |
| `default` | Has credit in default? |
| `balance` | Average annual account balance (EUR) |
| `housing` | Has housing loan? |
| `loan` | Has personal loan? |
| `contact` | Contact communication type |
| `month` | Last contact month |
| `campaign` | Number of contacts during this campaign |
| `previous` | Number of contacts before this campaign |
| `deposit` | **Target** — subscribed to term deposit? |

---

## Project Structure

```
bank-marketing/
├── sql/
│   ├── 00_setup.sql                          # Table creation & data load
│   ├── 01_age_distribution_by_job.sql
│   ├── 02_avg_balance_by_education.sql
│   ├── 03_loan_default_rate_by_job.sql
│   ├── 04_housing_vs_personal_loan.sql
│   ├── 05_term_deposit_conversion_by_segment.sql
│   ├── 06_conversion_rate_by_contact_method.sql
│   ├── 07_campaign_contacts_and_success_rate.sql
│   ├── 08_conversion_rate_by_month.sql
│   ├── 09_previous_contacts_vs_conversion.sql
│   ├── 10_default_rate_by_age_group_and_job.sql
│   ├── 11_high_balance_high_default_segments.sql
│   ├── 12_rank_customers_by_balance_within_job.sql
│   ├── 13_running_total_conversions_by_month.sql
│   ├── 14_top3_balance_customers_per_job.sql
│   └── 15_month_over_month_balance_change.sql
├── notebooks/
│   └── bank_marketing_analysis.ipynb         # Full analysis with commentary
├── data/                                     # Place bank.csv here (not committed)
└── README.md
```

---

## Setup Instructions

### 1. Install PostgreSQL
Download from [postgresql.org](https://www.postgresql.org/download/). During setup, note your password for the `postgres` user.

### 2. Install pgAdmin 4
Installed automatically with PostgreSQL. Open pgAdmin 4 from the Start menu and connect to `localhost:5432` with your credentials.

### 3. Download the dataset
Download `bank.csv` from Kaggle and place it in the `data/` folder.

### 4. Create the database and table
Open DBeaver or `psql` and run:
```sql
CREATE DATABASE bank_marketing;
```
Then connect to `bank_marketing` and run `sql/00_setup.sql`.

### 5. Load the CSV
In psql:
```bash
\copy bank FROM 'data/bank.csv' CSV HEADER DELIMITER ',';
```
Or use pgAdmin 4's Import/Export Data wizard (right-click the table).

### 6. Run the analysis queries
Execute each `.sql` file in order, or run all queries inside the Jupyter notebook.

### 7. Install Python dependencies (for the notebook)
```bash
pip install psycopg2-binary pandas matplotlib seaborn jupyter
```
Update the connection credentials in the first cell of the notebook, then run all cells.

---

## The 15 Queries

### Customer Profiling
| # | Query | Business Purpose |
|---|---|---|
| 1 | Age distribution by job type | Life-stage targeting for campaigns |
| 2 | Average balance by education level | Wealth management product targeting |
| 3 | Loan default rate by job segment | Credit risk policy calibration |

### Product Analytics
| # | Query | Business Purpose |
|---|---|---|
| 4 | Housing loan vs personal loan penetration | Cross-sell opportunity sizing |
| 5 | Term deposit conversion by segment | Deposit acquisition focus areas |
| 6 | Conversion rate by contact method | Channel strategy & budget allocation |

### Campaign Performance
| # | Query | Business Purpose |
|---|---|---|
| 7 | Contacts per campaign vs success rate | Optimal call cadence policy |
| 8 | Conversion rate by month | Campaign calendar planning |
| 9 | Prior contacts vs conversion rate | Re-engagement strategy |

### Risk Analysis
| # | Query | Business Purpose |
|---|---|---|
| 10 | Default rate by age group and job | Credit scoring model calibration |
| 11 | High balance + high default segments | Early intervention targeting |

### Advanced — Window Functions
| # | Query | Business Purpose |
|---|---|---|
| 12 | Balance rank within job segment | Priority tiering for relationship managers |
| 13 | Running total of conversions by month | Campaign pacing vs annual targets |
| 14 | Top 3 balance customers per job | Premium product outreach lists |
| 15 | Month-over-month balance change | Deposit health trend tracking |

---

## Key Findings

### 1. Customer Profiling

**Age by Job Segment**
Retired customers are the oldest segment (avg 65, median 64), followed by housemaids (47) and entrepreneurs (43). Students are the youngest at 26. Management is the largest segment at 2,566 customers. The bank's core mass-market demographic is mid-career professionals aged 37–42.

**Balance by Education**
Tertiary-educated customers hold the highest average balances (€1,846) — 42% more than secondary-educated customers (€1,296). However, a primary-educated customer holds the single highest balance in the dataset (€66,653), suggesting wealth is not exclusively tied to education level.

**Default Rate by Job**
Entrepreneurs carry the highest default risk at 3.05%, followed by housemaids (2.92%) and the unemployed (2.24%). Students are the safest segment at just 0.28%. Retired customers also default very rarely (0.64%) despite being the oldest group.

---

### 2. Product Analytics

**Loan Penetration**
- 47.3% of customers have a housing loan
- 13.1% have a personal loan
- 7.5% hold both simultaneously
- 47.1% have no loans at all — a significant cross-sell opportunity

**Term Deposit Conversion — Top Segments**
The highest converting segments are students with secondary education (79.9%), retired tertiary-educated customers (72.1%), and students with tertiary education (71.1%). Students and retirees convert best — likely because they have simpler financial needs and more time to engage.

**Contact Method**
Cellular contact converts at 54.3% vs telephone at 50.4%. Customers with unknown contact method convert at only 22.6% — having proper contact data on file is itself a strong predictor of engagement.

---

### 3. Campaign Performance

**Call Cadence**
Conversion drops sharply after the first contact: 53.4% on the first call, falling to 41.1% by the 4th and 25% by the 8th. The bank should set a hard stop at 3–4 contacts per customer to avoid diminishing returns.

**Best Months to Campaign**
December (90.9%), March (89.9%), September (84.3%) and October (82.4%) are the best months. May is the worst at 32.8% — yet it is the most active month (2,824 contacts). The bank is spending the most effort in its least effective month.

**Prior Contact Effect**
Customers contacted 3–5 times in prior campaigns convert at 69.4%, vs only 40.7% for those never previously contacted. Re-engaging warm leads is nearly twice as effective as cold outreach.

---

### 4. Risk Analysis

**Highest Risk Age-Job Combinations**
Young housemaids aged 25–34 have an 8.57% default rate — the highest of any segment. Self-employed customers aged 35–44 (3.97%) and middle-aged entrepreneurs (3.1–3.5%) are also elevated risk.

**High Balance + High Default — The Paradox Segments**
Six segments hold above-average balances but also default above the overall rate of 1.62%:
- Tertiary-educated entrepreneurs — avg balance €2,090, default rate 6.06%
- Unemployed primary-educated — avg balance €1,607, default rate 7.14%
- Technicians with unknown education — avg balance €2,919, default rate 3.85%

These segments appear wealthy but carry hidden risk. Early intervention programmes should target these customers specifically.

---

### 5. Balance Trends

Average balances are highly volatile month-to-month. The sharpest drops occur in May (−31.3%) and July (−33.7%), coinciding with the bank's heaviest campaign months. The strongest recovery is in Q4 (Oct–Dec), with balances climbing steadily and peaking in December at €2,735.

---

### Key Recommendations

| Priority | Recommendation |
|---|---|
| High | Shift campaign activity from May to Sep/Oct/Mar — conversion rates are 2.5× higher |
| High | Cap outreach at 3 contacts per customer — beyond that, ROI collapses |
| High | Flag tertiary entrepreneurs and unemployed-primary segments for enhanced credit review |
| Medium | Target students and retirees for term deposit campaigns — conversion rates above 65% |
| Medium | Invest in capturing contact method data — unknown contact customers convert at half the rate |
| Low | Develop cross-sell campaigns for the 47% of customers with no loans |

---

## Tools Used

- **PostgreSQL** — primary query engine
- **pgAdmin 4** — SQL client for query development
- **Python** (pandas, matplotlib, seaborn) — result visualisation
- **Jupyter Notebook** — analysis documentation
