import random
from datetime import datetime, timedelta

import pandas as pd


NUM_CUSTOMERS = 10_000

random.seed(42)


states = [
    "PE",
    "SP",
    "RJ",
    "MG",
    "BA",
    "PR",
    "RS",
    "CE"
]


channels = [
    "organic",
    "paid_search",
    "social_media",
    "referral",
    "partner"
]


def random_date(start, end):
    delta = end - start

    random_days = random.randint(
        0,
        delta.days
    )

    return start + timedelta(days=random_days)


customers = []


for customer_id in range(1, NUM_CUSTOMERS + 1):

    signup_date = random_date(
        datetime(2023, 1, 1),
        datetime(2026, 9, 1)
    )

    birth_date = random_date(
        datetime(1951, 1, 1),
        datetime(2008, 1, 1)
    )

    customer = {
        "customer_id": customer_id,
        "signup_date": signup_date.date(),
        "birth_date": birth_date.date(),
        "state": random.choice(states),
        "income": round(
            random.uniform(1500, 30000),
            2
        ),
        "acquisition_channel": random.choice(channels)
    }

    customers.append(customer)


df = pd.DataFrame(customers)


df.to_csv(
    "data/raw/customers.csv",
    index=False
)


print(df.head())

print(
    f"\nTotal customers: {len(df)}"
)