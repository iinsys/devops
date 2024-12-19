# Stage 1: Build the Go application
FROM golang:1.23 as builder
WORKDIR /app

COPY go.mod go.sum ./
RUN go mod tidy
RUN go mod download

COPY . ./
RUN go build -o server .

# Stage 2: Create a smaller image for running the application
FROM alpine:latest
WORKDIR /root/

COPY --from=builder /app/server .
COPY --from=builder /app/web ./web/

EXPOSE 8080

CMD ["./server"]