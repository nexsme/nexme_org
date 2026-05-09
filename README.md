install package for django environ

pip install django-environ==0.9.0

Create an file named .env in project directory and add following into it 

DEBUG=on
SECRET_KEY='django-insecure-6fgn@gaj_&_p3pnit#)3y--ud^@ry6$1hu^nl(wjkqrt!+ggx8'
ALLOWED_HOSTS=*, .localhost, .127.0.0.1,
SERVER=off
DATABASE_URL=psql://user:password@127.0.0.1:5432/database

add your username and password in the positions of user and password 
set port as 5432 for postgres 
add your database name after the /  