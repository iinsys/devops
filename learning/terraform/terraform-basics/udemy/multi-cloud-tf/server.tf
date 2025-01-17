provider "packet" {
    auth_token = "INSERT YOUR TOKEN HERE"
}

resource "packet_project" "bansikahdev" {
    name = "bansikahdev"
}

resource "packet_project_ssh_key" "bansikahdev" {
    name = "bansikahdev"
    public_key = file("~/.ssh/id_rsa.pub")
    project_id = packet_project.bansikahdev.id  
}

resource "packet_device" "test" {
    hostname         = "bansikahdev.test"
    plan             = "t1.small.x86"
    facilities = ["ams1"]
    operating_system = "centos_7"
    billing_cycle = "hourly"
    packet_project_ssh_key_ids = [packet_project.bansikahdev.id]
    project_id = packet_project.bansikahdev.id

}

output "public_ip" {
    value = packet_device.test.access_public_ipv4
}