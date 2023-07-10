import sqlalchemy as sq
from sqlalchemy.orm import declarative_base, relationship

Base = declarative_base()

class Publisher(Base):
    __tablename__ = "publisher"
    id = sq.Column(sq.Integer, primary_key=True)
    name = sq.Column(sq.String(length=40), unique=True, nullable=False)
    def __str__(self):
        return f'Publisher {self.id}: {self.name}'

class Stock(Base):
    __tablename__ = "stock"
    id = sq.Column(sq.Integer, primary_key=True)
    id_book = sq.Column(sq.Integer, sq.ForeignKey("book.id", nullable=False))
    id_shop = sq.Column(sq.Integer, sq.ForeignKey("shop.id", nullable=False))
    count = sq.Column(sq.Integer, nullable=False)

class Book(Base):
    __tablename__ = "book"
    id = sq.Column(sq.Integer, primary_key=True)
    title = sq.Column(sq.String(length=250), nullable=False)
    id_publisher = sq.Column(sq.Integer, sq.ForeignKey("publisher.id", nullable=False))
    publisher = relationship("Publisher", backref="book")
    shop = relationship("Stock", backref="book")
    def __str__(self):
        return f'Book {self.id}: {self.title}'
    
class Shop(Base):
    __tablename__ = "shop"
    id = sq.Column(sq.Integer, primary_key=True)
    name = sq.Column(sq.String(length=100), unique=True, nullable=False)
    book = relationship("Stock", backref="shop")
    def __str__(self):
        return f'Shop {self.id}: {self.name}'
    
class Sale(Base):
    __tablename__ = "sale"
    id = sq.Column(sq.Integer, primary_key=True)
    prise = 





class Course(Base):
    __tablename__ = "course" # это название таблицы

    id = sq.Column(sq.Integer, primary_key=True) # колонка ID с соответствующими атрибутами
    name = sq.Column(sq.String(length=40), unique=True) # колонка name с соответствующими атрибутами

    # homeworks = relationship("Homework", back_populates="course")

    def __str__(self):
        return f'Course {self.id}: {self.name}'

class Homework(Base):
    __tablename__ = "homework"

    id = sq.Column(sq.Integer, primary_key=True)
    number = sq.Column(sq.Integer, nullable=False)
    description = sq.Column(sq.Text, nullable=False)
    course_id = sq.Column(sq.Integer, sq.ForeignKey("course.id"), nullable=False)

    # course = relationship(Course, back_populates="homeworks")
    course = relationship(Course, backref="homeworks")
    def __str__(self):
        return f'Homework {self.id}: ({self.number}, {self.description}, {self.course_id})'

def create_tables(engine):
    Base.metadata.drop_all(engine) # удаляет данные из базы данных
    Base.metadata.create_all(engine) # создает таблицы