package main

import (
	"fmt"
	"net"
	"os"
)

func startServer(port int) {
	listener, err := net.Listen("tcp", fmt.Sprintf(":%d", port))
	if err != nil {
		fmt.Printf("Failed to start server on port %d: %v\n", port, err)
		return
	}
	defer listener.Close()

	fmt.Printf("Listening on port %d...\n", port)
	for {
		conn, err := listener.Accept()
		if err != nil {
			fmt.Printf("Error accepting connection on port %d: %v\n", port, err)
			continue
		}
		conn.Close()
	}
}

func main() {
	if len(os.Args) < 2 {
		fmt.Println("Usage: go run server.go <port1> <port2> ...")
		return
	}

	for _, arg := range os.Args[1:] {
		port := 0
		_, err := fmt.Sscanf(arg, "%d", &port)
		if err != nil || port < 1 || port > 65535 {
			fmt.Printf("Invalid port: %s\n", arg)
			continue
		}
		go startServer(port)
	}

	select {} // Keep the main function alive
}
