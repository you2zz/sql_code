import sqlalchemy
from sqlalchemy.orm import sessionmaker

from models import create_tables, Course, Homework

DSN = 'postgresql://postgres:fur2529@localhost:5432/orm_db'
engine = sqlalchemy.create_engine(DSN)

create_tables(engine)

Session = sessionmaker(bind=engine)
session = Session()

course1 = Course(name='Python')
# print(course1.id)

session.add(course1)
session.commit()

# print(course1.id)

# print(course1)

hw1 = Homework(number = 1, description = 'простая домашняя работа', course = course1)
hw2 = Homework(number = 2, description = 'сложная домашняя работа', course = course1)

session.add_all([hw1, hw2])
session.commit()

# for c in session.query(Course).all(): # запрашиваем все курсы
#     print(c)

# for c in session.query(Homework).all(): # запрашиваем все домашние работы
#     print(c)

# for c in session.query(Homework).filter(Homework.number > 1).all(): # запрашиваем необходимые работы через фильтр
#     print(c)

# for c in session.query(Homework).filter(Homework.description.like('%прост%')).all(): # запрашиваем необходимые работы через фильтр
#     print(c)

# for c in session.query(Course).join(Homework.course).filter(Homework.number == 2).all():
#     print(c)

course2 = Course(name='Java')
session.add(course2)
session.commit()   

# subq = session.query(Homework).filter(Homework.description.like('%сложн%')).subquery() # создаем подзапрос
# for c in session.query(Course).join(subq, Course.id == subq.c.course_id): # объединяем с подзапросом
#     print(c)


session.query(Course).filter(Course.name == 'Java').update({'name': 'JavaScript'})
session.commit() 

session.query(Course).filter(Course.name == 'JavaScript').delete()
session.commit() 

for c in session.query(Course).all():
    print(c)

session.close()