# SA imports
from sqlalchemy import *
from sqlalchemy.orm import mapper

# python imports
from datetime import datetime, timedelta
from time import time, sleep
from random import uniform, randint

# create metadata object, bind to connection.  Create session.
metadata = MetaData()
engine = create_engine('postgres://scuser@127.0.0.1/sctest', echo=False)
metadata.bind = engine

# table description
interface = Table('interface'\
			,metadata\
			,Column('channel',String)\
			,Column('id',Sequence('master_id_seq'))\
			,Column('value',Numeric)\
			,Column('time',TIMESTAMP))		

# convenience class for adding objects.

tlist = []
numpush = 0
i = interface.insert()
while True:
	tlist = [] 
	for num in range(5000):
		val = uniform(-10,10)
		td = datetime(year=2010,month=1,day=1)+timedelta(days=5*randint(0,365))
		ch = 'channel' + str(randint(0,99))
		tlist.append({'value':val,'time':td,'channel':ch})  
	i.execute(tlist)
	numpush += 5000 
	print("{0} records pushed.".format(numpush))     