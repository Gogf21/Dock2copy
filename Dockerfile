# Первая стадия: Сборка
FROM alpine as builder

RUN apk add --no-cache git gcc musl-dev

WORKDIR /app

RUN git clone https://github.com/Gogf21/shell.git .
RUN gcc -o mypr app/app/main.c -static

RUN chmod +x mypr

# Вторая стадия: Финальный образ
FROM alpine

WORKDIR /app
RUN apk add --no-cache bash
COPY --from=builder ./app/mypr .


# Убедимся, что программа исполняемая
RUN chmod +x mypr

# Команда для запуска приложения
CMD ["./mypr"]
