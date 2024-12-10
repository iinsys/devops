package main

import (
	"fmt"
	"net"
	"os"
	"strconv"
	"strings"
	"sync"
	"time"
)

// Scan a single port
func scanPort(ip string, port int, wg *sync.WaitGroup) {
	defer wg.Done()
	address := fmt.Sprintf("%s:%d", ip, port)
	conn, err := net.DialTimeout("tcp", address, 1*time.Second)
	if err != nil {
		// Port is closed or unreachable
		return
	}
	conn.Close()
	fmt.Printf("[OPEN] Port %d is open on %s\n", port, ip)
}

// Main function
func main() {
	if len(os.Args) != 3 {
		fmt.Println("Usage: go run main.go <IP> <port-range>")
		fmt.Println("Example: go run main.go 192.168.1.1 20-80")
		return
	}

	ip := os.Args[1]
	portRange := os.Args[2]

	ports := strings.Split(portRange, "-")
	if len(ports) != 2 {
		fmt.Println("Invalid port range. Use format: start-end (e.g., 20-100)")
		return
	}

	startPort, err := strconv.Atoi(ports[0])
	if err != nil || startPort < 1 || startPort > 65535 {
		fmt.Println("Invalid start port")
		return
	}

	endPort, err := strconv.Atoi(ports[1])
	if err != nil || endPort < 1 || endPort > 65535 {
		fmt.Println("Invalid end port")
		return
	}

	var wg sync.WaitGroup
	for port := startPort; port <= endPort; port++ {
		wg.Add(1)
		go scanPort(ip, port, &wg)
	}

	wg.Wait()
	fmt.Println("Scan complete")
}
