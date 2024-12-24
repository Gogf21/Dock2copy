# Первая стадия: Сборка
FROM alpine as builder

RUN apk add --no-cache git musl-dev

WORKDIR /app

RUN git clone https://github.com/Gogf21/shell.git .
RUN gcc app/app/mainpidr.c

RUN chmod +x your_program.sh

# Вторая стадия: Финальный образ
FROM alpine

WORKDIR /app
RUN apk add --no-cache bash
COPY --from=builder /app/your_program .
# Копируем программу из стадии сборки
COPY --from=builder /app/your_program.sh .

# Убедимся, что программа исполняемая
RUN chmod +x your_program.sh

# Команда для запуска приложения
CMD ["./your_program.sh"]
