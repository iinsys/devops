# Stage 1: Build the Go application
FROM golang:1.23 AS builder
WORKDIR /app

COPY go.mod go.sum ./
RUN go mod tidy
RUN go mod download

COPY . ./
# Build a statically linked binary
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o server .

# Stage 2: Create a smaller image for running the application
FROM alpine:latest
WORKDIR /root/

COPY --from=builder /app/server .
COPY --from=builder /app/web ./web/

EXPOSE 8080

CMD ["./server"]
