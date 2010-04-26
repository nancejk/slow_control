# SA imports
from sqlalchemy import *
from sqlalchemy.orm import mapper

# python imports
from datetime import datetime, timedelta
from time import time, sleep
from random import uniform, randint

# The base date.
td_base = datetime(year=2010,month=1,day=1)

# create metadata object, bind to connection.  Create session.
metadata = MetaData()
engine = create_engine('postgres://scuser@127.0.0.1/big_table', echo=True)
metadata.bind = engine

# table description
data_table = Table('data', metadata, autoload=True)

numpush = 0
i = data_table.insert()
                  
# Stick 10^4 records in the database using my favorite list comprehension
for iteration in range(10):
  tlist = [{'value':uniform(-10,10),'chan_id':randint(1,10),'dt':datetime(year=2010,month=1,day=1) + timedelta(days=5*uniform(0,365))} for placeholder in range(1000)]
  i.execute(tlist)
