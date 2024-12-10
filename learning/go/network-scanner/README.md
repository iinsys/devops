**Project: Basic Network Scanner**

**Objectives:**

* Build a command-line tool to scan for open ports on a target machine or network.
* Learn basic networking and concurrency in Go.
* Keep the project modular and easy to extend.

**Features:**

* **Input:**
    * IP address or hostname.
    * Port range (e.g., 20-80).
* **Output:**
    * A list of open ports on the specified target.
* **Implementation:**
    * Concurrency with goroutines to scan multiple ports simultaneously.
    * Timeout for each port check to ensure efficiency.
    * Simple CLI-based interaction.

**How to Test the Scanner Externally**

**Start the Test Server:**
```bash
go run test-target/server.go 22 80 443
#or
sudo go run test-target/server.go 22 80 443

```
This will keep the server running on ports `22`, `80`, and `443`.

**Run the Network Scanner:**
```bash
go run main.go localhost 20-100
```
**Expected Output:**
```bash
[OPEN] Port 22 is open on localhost
[OPEN] Port 80 is open on localhost
[OPEN] Port 443 is open on localhost
Scan complete
```

**Use Non-Privileged Ports for Testing:** 
Update the test server to use ports above 1024 (e.g., `8080`, `8081`, `8082`). This avoids requiring elevated permissions:
```bash
go run test-target/server.go 8080 8081 8082
```
Test it
```bash
go run main.go localhost 8080-8082
```

**Grant Permission to Bind Privileged Ports:**
 If you frequently work with privileged ports, you can grant specific binaries permission to bind them using setcap (Linux only):
 ```bash
sudo setcap 'cap_net_bind_service=+ep' $(which go)
```
**Note:** This allows go to bind privileged ports without requiring sudo, but it should be done cautiously and only if necessary.