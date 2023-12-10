# clickhouse в docker + dbt

## создание среды окружения и загрузка библиотек
```code
conda create --name detestenv
conda activate detestenv
conda install --yes --file requirements.txt
```

## запуск clickhouse в docker

```code
docker-compose up -d
```

## подключение к БД

хост localhost:8123
имя пользователя/пароль de/de

при создании создается БД dedb
с двумя таблицами manager_departments и payments 

скрипт инициализации БД /docker-entrypoint-initdb.d/de_clickhouse.sql

## запуск dbt

```code
dbt run
```

## результаты

sql скрипты с запросами de_test/models/tasks/

результат каждого запроса компилируется в материализованное view в БД
