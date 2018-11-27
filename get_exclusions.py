import pandas as pd
import psycopg2
from sqlalchemy import create_engine

excluded = pd.read_csv('UPDATED.csv')
# con = psycopg2.connect(host="localhost", user="postgres", password="Saad123", database="Medicare")

excluded["year"] = excluded.EXCLDATE.apply(lambda x: int(str(x)[:4]))
excluded = excluded[excluded["year"] > 2012]
print()

engine = create_engine('postgresql://postgres:Saad123@localhost:5432/Medicare')
excluded.to_sql('exclusions', engine)