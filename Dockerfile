# Первая стадия: Сборка
FROM gcc:latest as builder

RUN apk add --no-cache git 

WORKDIR /app

RUN git clone https://github.com/Gogf21/shell.git .
RUN gcc -o mypr app/main.c -static

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
