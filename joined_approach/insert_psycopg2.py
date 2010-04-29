import time, random
from datetime import datetime
from psycopg2 import *
try:
	conn = connect("dbname='sctest' user='scuser' host='localhost' password='dbpass'")
except:
	print('no go')

t = TimestampFromTicks(time.time())
print(t.getquoted())
cur = conn.cursor()                                                                    
cur.execute('select extract(hour from %(str)s::timestamp)',dict(str=t))
print(cur.fetchall())
cur.execute('insert into interface (time,value) values (%(time)s::timestamp, %(value)s::real)',dict(time=datetime.now(),value=1.203))