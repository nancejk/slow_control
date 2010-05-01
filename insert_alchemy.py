# SA imports
from sqlalchemy import *
from sqlalchemy.orm import mapper

# python imports
from datetime import datetime, timedelta
from time import time, sleep
from random import uniform, randint

# The base date
td_base = datetime(year=2010,month=1,day=1)

# create metadata object, bind to connection.  Create session.
metadata = MetaData()
engine = create_engine('postgres://scuser@192.168.56.101/joined_table', echo=False)
metadata.bind = engine

# table description
interface = Table('master',metadata,autoload=True)

# convenience class for adding objects.
i = interface.insert()
for num in range(1):
  print("working on {0}".format(num))
  tlist = [{'value':uniform(-10,10),'chan_id':randint(1,10),'dt':td_base + timedelta(days=5*uniform(0,365))} for placeholder in range(1000)]
  i.execute(tlist)
