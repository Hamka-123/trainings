# STAGE 1: Компиляция бинарника
FROM golang:1.22-alpine AS builder

WORKDIR /app

# Копируем зависимости и исходники
COPY go.mod ./
COPY . .

# Сборка чистого статически слинкованного бинарника без CGO
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -o /app/server ./cmd/app/main.go

# STAGE 2: Финальный ультра-минималистичный образ
FROM scratch

# Копируем CA-сертификаты на случай, если приложению понадобятся внешние HTTPS-запросы
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

# Копируем скомпилированный бинарник
COPY --from=builder /app/server /server

EXPOSE 8080

ENTRYPOINT ["/server"]