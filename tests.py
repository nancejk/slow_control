# SA imports
from sqlalchemy import *
from sqlalchemy.orm import mapper
from sqlalchemy.sql import text

# Python imports
import sys
from time import time, sleep
from datetime import datetime, timedelta
from random import uniform, randint

# create metadata object, bind to connection.  Create session.
metadata = MetaData()
engine = create_engine('postgres://scuser@192.168.56.101/joined_table', echo=False)
metadata.bind = engine

def raw_sql_benchmark(the_connection, the_statement):
  the_connection.execute(the_statement)
  

def main(argv=None):
  # The base date used as a reference for everything else
  td_base = datetime(year=2010,month=1,day=1)
  
  # create metadata object, bind to connection
  metadata = MetaData()
  engine = create_engine('postgres://scuser@192.168.56.101/joined_table', echo=False)
  metadata.bind = engine

  # OK, now create a connection to the database cluster
  conn = engine.connect()

  # Grab the table description
  master = Table('master',metadata,autoload=True)
  ins = master.insert()

  # This is the query we are interested in
  bench_query = 'select * from master where chan_id=1 and extract(month from dt)=1 and extract(year from dt)=2010'

  # And the object we are writing to.
  fobj = open('benchmarks.rawdat','w')
  fobj.flush()

  # We are going to do this a lot of times.  10000 inserts 10000 times
  for num in range(10000):
    recs = [{'value':uniform(-10,10), 'chan_id':randint(1,10),\
		'dt': td_base + timedelta(days=31) + timedelta(days=5*uniform(0,365))}\
		for placeholder in range(10000)]
    ins.execute(recs)
    # OK, now we start benchmarking
    begin = time()
    raw_sql_benchmark(conn,bench_query)
    t_execute = time() - begin
    print("Time to execute was {0}".format(t_execute))
    fobj.write("{0},{1}\n".format((num+1)*10000,t_execute))
    fobj.flush()

  # Close the file and we are done
  fobj.close()

if __name__ == "__main__":
  sys.exit(main())
