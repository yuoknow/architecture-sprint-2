# pymongo-api

## Как запустить

Запускаем mongodb и приложение

```shell
docker compose up -d
```

Заполняем mongodb данными

```shell
./scripts/mongo-init.sh
```

## Как проверить

### Если вы запускаете проект на локальной машине

Откройте в браузере http://localhost:8080

### Если вы запускаете проект на предоставленной виртуальной машине

Узнать белый ip виртуальной машины

```shell
curl --silent http://ifconfig.me
```

Откройте в браузере http://<ip виртуальной машины>:8080

## Доступные эндпоинты

Список доступных эндпоинтов, swagger http://<ip виртуальной машины>:8080/docs

## Проект с шардированием, репликацией и кешем

### Запуск

```shell
docker compose -f mongo-sharding-repl-cache/compose.yaml up -d
```

### Инициализация шардирования

```shell
./mongo-sharding-repl-cache/mongo-init.sh
```

### Наполнение данными
```shell
./mongo-sharding-repl-cache/mongo-add-data.sh
```

### Остановка

```shell
docker compose -f mongo-sharding-repl-cache/compose.yaml down
```

## Итоговая схема
[Ссылка на схему](https://drive.google.com/file/d/1ahREQUv_ZG-0HV9O96pb332uwwAoFE5-/view?usp=sharing)