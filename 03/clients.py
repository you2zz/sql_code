import psycopg2

# Функция, создающая структуру БД (таблицы)
def create_db(conn):
    with conn.cursor() as cur:
        cur.execute("""
        CREATE TABLE IF NOT EXISTS clients (
            client_id  SERIAL PRIMARY KEY,
            first_name VARCHAR(60) NOT NULL,
            last_name VARCHAR(60) NOT NULL,
            e_mail  VARCHAR(60) NOT NULL UNIQUE
            CHECK (e_mail ~ '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$')
            );
        """)
        cur.execute("""
        CREATE TABLE IF NOT EXISTS phones(
            phone_id SERIAL PRIMARY KEY,
            client_id INTEGER REFERENCES clients (client_id) ON DELETE CASCADE,
            phone_number TEXT NOT NULL UNIQUE
            CHECK (phone_number ~ '^\d{10}$')
            );
        """)
        conn.commit()
    return 'Таблицы созданы'

# Функция, позволяющая добавить нового клиента
def add_client(conn, first_name, last_name, email, phones=None):
    with conn.cursor() as cur:
        cur.execute("""
            INSERT INTO clients(first_name, last_name, e_mail) VALUES
            (%s, %s, %s) RETURNING client_id;
            """, (first_name, last_name, email))
        client_id = cur.fetchone()
        if phones == None:
            log_info = f'Добавлен новый клиент c ID {client_id}, но он не указал телефон'
        else:
            list_phone =[]
            for num_phone in phones.split(','):
                cur.execute("""
                    INSERT INTO phones (client_id, phone_number) VALUES
                    (%s, %s);
                """, (client_id, num_phone.strip()))
                list_phone.append(num_phone.strip())
            conn.commit()
            log_info = f'Добавлен новый клиент c ID {client_id} и телефонные номера: {", ".join(list_phone)}'
    return log_info
   
# Функция, позволяющая добавить телефон для существующего клиента
def add_phone(conn, client_id, phone):
    with conn.cursor() as cur:
        cur.execute("""
        INSERT INTO phones (client_id, phone_number) VALUES
        (%s, %s);
        """, (client_id, phone))
    conn.commit()
    return f'Клиенту с ID {client_id} добавлен новый телефонный номер: {phone}'

# Функция, позволяющая изменить данные о клиенте
def change_client(conn, client_id, first_name=None, last_name=None, email=None, phone=None):
    with conn.cursor() as cur:
        log_list = []
        if first_name != None:
            cur.execute("""
            UPDATE clients SET first_name = %s WHERE client_id=%s;
            """, (first_name, client_id))
            log_list.append('имя изменено')            
        if last_name != None:
            cur.execute("""
            UPDATE clients SET last_name = %s WHERE client_id=%s;
            """, (last_name, client_id))
            log_list.append('фамилия изменена')  
        if email != None:
            cur.execute("""
            UPDATE clients SET e_mail = %s WHERE client_id=%s;
            """, ( email, client_id))
            log_list.append('email изменен')
        conn.commit()
        if phone != None:
            cur.execute("""
            SELECT phone_id, phone_number FROM phones
            WHERE client_id=%s
            GROUP BY phone_id;
            """, (client_id,))
            count_phone = cur.fetchall()
            if len(count_phone) < 1:
                cur.execute("""
                INSERT INTO phones (client_id, phone_number) VALUES
                (%s, %s);
                """, (client_id, phone))
                conn.commit()
                log_list.append('номер телефона отсутствовал - внесен новый')
            elif len(count_phone) == 1:
                cur.execute("""            
                UPDATE phones SET phone_number = %s WHERE client_id=%s
                """, (phone, client_id))
                conn.commit()
                log_list.append('номер телефона изменен')
            else:
                phone_id = int(input(f'У клиента ID {client_id} несколько номеров. Выберите ID телефонного номера, который необходимо изменить {count_phone}: ', ))
                cur.execute("""            
                UPDATE phones SET phone_number = %s WHERE phone_id=%s
                """, (phone, phone_id))
                conn.commit()
                log_list.append(f'номер телефона с ID {phone_id} изменен')
    return f'У клиента ID {client_id} {", ".join(log_list)}'

# Функция, позволяющая удалить телефон для существующего клиента    
def delete_phone(conn, client_id, phone):
    with conn.cursor() as cur:
        cur.execute("""
        SELECT phone_id, phone_number FROM phones
        WHERE client_id=%s
        GROUP BY phone_id;
        """, (client_id,))
        count_phone = cur.fetchall()
        list_phones = [i[1] for i in count_phone]
        if len(count_phone) < 1: # если нет телефона или клиента
            log_info = f'У клиента с ID {client_id} номер телефона отсутствует, или такого клиента нет в базе данных'
        else:               
            if phone in list_phones: # если номер указан верно
                cur.execute("""
                DELETE FROM phones WHERE phone_number = %s;
                """, (phone,))
                conn.commit()
                log_info = f'У клиента ID {client_id} телефонный номер {phone} удален'
            else: # если указан не верно
                phone_id = int(input(f'Указанный вами номер у клиента с ID {client_id} отсутствует. Если хотите удалить другой номер, укажите его ID {count_phone}: ', ))
                cur.execute("""
                DELETE FROM phones WHERE phone_id = %s;
                """, (phone_id,))
                conn.commit()
                log_info = f'У клиента ID {client_id} телефонный номер {count_phone[0][1]} удален'
    return log_info

# Функция, позволяющая удалить существующего клиента
def delete_client(conn, client_id):
    with conn.cursor() as cur:
        cur.execute("""
        SELECT client_id FROM clients
        WHERE client_id=%s;
        """, (client_id,))
        count_id = cur.fetchall()
        if len(count_id) == 0:
            log_info = f'Клиент с указанным ID {client_id} отсутствует в базе данных'
        else:
            cur.execute("""
            DELETE FROM clients WHERE client_id = %s;
            """, (client_id,))
            conn.commit()
            log_info = f'Клиент с указанным ID {client_id} удален'
        
    return log_info

# Функция, позволяющая найти клиента по его данным: имени, фамилии, email или телефону
def find_client(conn, first_name=None, last_name=None, email=None, phone=None):
    with conn.cursor() as cur:
        if phone != None:
            cur.execute("""
            SELECT c.client_id, first_name, last_name, e_mail, phone_number FROM clients c
            LEFT JOIN phones p ON c.client_id = p.client_id
            WHERE phone_number = %s;
            """, (phone,))
        if first_name != None and last_name != None:
            cur.execute("""
            SELECT c.client_id, first_name, last_name, e_mail, phone_number FROM clients c
            LEFT JOIN phones p ON c.client_id = p.client_id
            WHERE first_name~*%s and last_name~*%s;
            """, (first_name, last_name))
        if email != None:
            cur.execute("""
            SELECT c.client_id, first_name, last_name, e_mail, phone_number FROM clients c
            LEFT JOIN phones p ON c.client_id = p.client_id
            WHERE e_mail~*%s;
            """, (email,))
        if first_name != None:
            cur.execute("""
            SELECT c.client_id, first_name, last_name, e_mail, phone_number FROM clients c
            LEFT JOIN phones p ON c.client_id = p.client_id
            WHERE first_name~*%s; 
            """, (first_name,))
        if last_name != None:
            cur.execute("""
            SELECT c.client_id, first_name, last_name, e_mail, phone_number FROM clients c
            LEFT JOIN phones p ON c.client_id = p.client_id
            WHERE last_name~*%s; 
            """, (last_name,))
        res = cur.fetchall()
        return res   
    
with psycopg2.connect(database="clients_db", user="postgres", password="postgres") as conn:
    # # создаем таблицы
    print(create_db(conn))

    # # добавляем информацию о клиентах
    print(add_client(conn, 'Том', 'Круc', 'tomcruser@gmail.com', '9826153947'))
    print(add_client(conn, 'Дмитрий', 'Нагиев', 'dimadoma@gmail.com', '9826153946'))
    print(add_client(conn, 'Роберт', 'Де Ниро', 'deniroff@gmail.com'))
    print(add_client(conn, 'Александр', 'Домогаров', 'adomogarov@gmail.com', '9826153957'))
    print(add_client(conn, 'Джек', 'Николсон', 'dnick@gmail.com'))
    print(add_client(conn, 'Павел', 'Деревянко', 'derevo@gmail.com', '9821653957'))
    print(add_client(conn, 'Анжелина', 'Джоли', 'adjoli@gmail.com'))
    print(add_client(conn, 'Анастасия', 'Мельникова', 'melana@gmail.com', '9358741237, 9855641248, 9872545186'))
    print(add_client(conn, 'Павел', 'Прилучный', 'prilucha@gmail.com', '9321653954'))
    print(add_client(conn, 'Джулия', 'Робертс', 'rjuli@gmail.com', '9312655934'))
    print(add_client(conn, 'Роберт', 'Патрик', 'terminator@gmail.com', '3333333333'))

    # # добавляем телефон клиенту
    print(add_phone(conn, 3, '1111111111'))
    print(add_phone(conn, 8, '6594234718'))

    # # меняем информацию о клиенте
    print(change_client(conn, 3, first_name='Роберт', email='deniroff@yandex.ru', phone='1896153947'))
    print(change_client(conn, 1, last_name='Круз', email='tomcruser@mail.ru', phone='2896153947'))
    print(change_client(conn, 8, email='melanna@gmail.com', phone='9538743175'))

    # # удаляем телефон клиента
    print(delete_phone(conn, 30, '9826153957'))
    print(delete_phone(conn, 1, '2896153947'))
    print(delete_phone(conn, 8, '6594234718'))

    # # удаляем клиента
    print(delete_client(conn, 8))

    # ищем клиентов
    print(find_client(conn, first_name='РОБЕРТ', last_name='патрик'))
    print(find_client(conn, email='tomcruser@mail.ru'))
    print(find_client(conn, phone='9312655934'))
conn.close()