# SA imports
from sqlalchemy import *
from sqlalchemy.orm import mapper

# python imports
import datetime 
from time import time

# create metadata object, bind to connection.  Create session.
metadata = MetaData()
engine = create_engine('postgres://scuser@127.0.0.1/sctest')
metadata.bind = engine

# play
test = Table('testing'\
			,metadata\
			,Column('id',Integer)\
			,Column('value',Numeric))

# Do a quick insert of a single value.
i = test.insert()
i.execute(id=1,value=2.3)


# Works beautifully.