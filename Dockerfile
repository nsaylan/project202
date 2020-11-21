FROM python:alpine
COPY . .


ENV MYSQL_DATABASE_HOST database
ENV MYSQL_DATABASE_USER admin
ENV MYSQL_DATABASE_PASSWORD Clarusway_1
ENV MYSQL_DATABASE_DB phonebook_db
ENV MYSQL_DATABASE_PORT 3306

RUN pip install -r requirements.txt
EXPOSE 80
ENTRYPOINT [ "python" ]
CMD ["app/phonebook-app.py"]
