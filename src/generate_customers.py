import math
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

state_weights = [
    0.12,
    0.30,
    0.12,
    0.12,
    0.10,
    0.09,
    0.08,
    0.07
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

    age = int(
        random.gauss(38, 12)
    )

    age = max(
        18,
        min(age, 75)
    )

    birth_date = signup_date - timedelta(
        days=int(age * 365.25)
        )

    state = random.choices(
        states,
        weights=state_weights,
        k=1
    )[0]

    base_income = random.lognormvariate(
        math.log(4000),
        0.6
    )

    age_factor = 1 + (
        (age - 30) * 0.015
    )

    income = base_income * age_factor

    income = max(
        1500,
        min(income, 50000)
    )

    income = round(
        income,
        2
    )

    if age < 30:

        channels = [
            "social_media",
            "paid_search",
            "organic"
        ]

    elif age < 50:

        channels = [
            "organic",
            "paid_search",
            "referral",
            "partner"
        ]

    else:

        channels = [
            "referral",
            "partner",
            "organic"
        ]

    acquisition_channel = random.choice(
        channels
    )

    customer = {
        "customer_id": customer_id,
        "signup_date": signup_date.date(),
        "birth_date": birth_date.date(),
        "age": age,
        "state": state,
        "income": income,
        "acquisition_channel": acquisition_channel
    }

    customers.append(customer)


df = pd.DataFrame(customers)


assert df["customer_id"].is_unique

assert df["customer_id"].notna().all()

assert (df["income"] > 0).all()

assert (
    df["age"].between(18, 75)
).all()


df.to_csv(
    "data/raw/customers_v2.csv",
    index=False
)


print(df.head())

print(
    df["income"].describe()
)

print(
    df["age"].describe()
)

print(
    df["state"].value_counts(normalize=True)
)

print(
    df["acquisition_channel"].value_counts()
)