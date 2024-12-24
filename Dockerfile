# Первая стадия: Сборка
FROM alpine as builder

RUN apk add --no-cache git gcc musl-dev

WORKDIR /app

RUN git clone https://github.com/Gogf21/shell.git .
RUN gcc -o app/shell/app/main.c -static

RUN chmod +x your_program.sh

# Вторая стадия: Финальный образ
FROM alpine

WORKDIR /app
RUN apk add --no-cache bash
COPY --from=builder /app/shell/app/main.c /app/app/main.c
# Копируем программу из стадии сборки
COPY --from=builder /app/shell/your_program.sh .

# Убедимся, что программа исполняемая
RUN chmod +x your_program.sh

# Команда для запуска приложения
CMD ["./your_program.sh"]
