# Базовый Image
FROM python:3.9-alpine3.16

# Копируем файл requirements.txt  из корня проекта в папку temp и также его называем - requirements.txt
COPY requirements.txt /temp/requirements.txt

# Копируем нашу дерикторию service (здесь будет лежать наше джанго приложение) в докер контейнера и также называем ее - service
COPY service /service

# WORKDIR - необходимо для того, чтобы когда мы будем передавать какие-либо команды во
# внутрь докер контейнера чтобы они запускались из этой дериктории где у нас лежит жданго приложение
# Проще говоря нам не нужно будет писать полный путь до manage.py
WORKDIR /service

# Открываем порт
EXPOSE 8000

# Команда по установке зависимостей, указываем из какого файла нужно это сделать (/temp/requirements.txt)
RUN pip install -r /temp/requirements.txt

# Данная команда создаст нам пользователя в операционной системе
# --disabled-password  - означает что нам не нужен пароль чтобы под ним авторизовываться
# service-user  -  как будет назаваться юзер
RUN adduser --disabled-password service-user

# Это пользователь под которым должны запускаться все команды
USER service-user