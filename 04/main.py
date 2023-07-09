import sqlalchemy
from sqlalchemy.orm import sessionmaker

from models import create_tables, Course, Homework

DSN = 'postgresql://postgres:fur2529@localhost:5432/orm_db'
engine = sqlalchemy.create_engine(DSN)

create_tables(engine)

Session = sessionmaker(bind=engine)
session = Session()

course1 = Course(name='Python')
print(course1.id)

session.add(course1)
session.commit()

print(course1.id)

print(course1)

Homework(mnu)
session.close()