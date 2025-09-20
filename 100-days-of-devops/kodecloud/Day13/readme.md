Day 13: IPtables Installation And Configuration

>The things always happens that you really believe in; and the belief in a thing makes it happen.
>
>– Frank Lloyd Wright

We have one of our websites up and running on our Nautilus infrastructure in `Stratos DC`. Our security team has raised a concern that right now Apache's port i.e `8087` is open for all since there is no firewall installed on these hosts. So we have decided to add some security layer for these hosts and after discussions and recommendations we have come up with the following requirements:

1.) Install `iptables` and all its dependencies on each app host.

2.) Block incoming port `8087` on all apps for everyone except for LBR host.

3.) Make sure the rules remain, even after system reboot.

## Relevant Infrastructure Details

| Server    | Hostname                        | User    | Password   | Purpose           |
|-----------|----------------------------------|---------|------------|-------------------|
| stapp01   | stapp01.stratos.xfusioncorp.com  | tony    | Ir0nM@n    | Nautilus App 1    |
| stapp02   | stapp02.stratos.xfusioncorp.com  | steve   | Am3ric@    | Nautilus App 2    |
| stapp03   | stapp03.stratos.xfusioncorp.com  | banner  | BigGr33n   | Nautilus App 3    |
| stlb01    | stlb01.stratos.xfusioncorp.com   | loki    | Mischi3f   | Nautilus HTTP LBR |

`Note:` The `kubectl` utility on `jump_host` has been configured to work with the kubernetes cluster.

## Solution

### How to SSH to Each App Server

1.) SSH to stapp01:
```bash
ssh tony@stapp01.stratos.xfusioncorp.com
# password: Ir0nM@n
```

2.) SSH to stapp02:
```bash
ssh steve@stapp02.stratos.xfusioncorp.com
# password: Am3ric@
```

3.) SSH to stapp03:
```bash
ssh banner@stapp03.stratos.xfusioncorp.com
# password: BigGr33n
```

Run the following steps on each app server:
```bash
# 1. Install iptables and its services
sudo yum install -y iptables iptables-services

# 2. Allow loopback and SSH (always allow these before applying firewall)
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# 3. Allow incoming port 8087 only from Load Balancer (LBR) IP
sudo iptables -A INPUT -p tcp -s 172.16.238.14 --dport 8087 -j ACCEPT

# 4. Block all other traffic to port 8087
sudo iptables -A INPUT -p tcp --dport 8087 -j DROP

# 5. Allow already established or related connections
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# 6. (Optional) Drop all other inbound traffic — use with caution
# sudo iptables -A INPUT -j DROP

# 7. Save the rules so they persist after reboot
sudo service iptables save
sudo systemctl enable iptables
sudo systemctl restart iptables

# 8. Verify iptables rules
sudo iptables -L -n --line-numbers

# 9. Test from LBR and from other hosts to confirm only LBR can access port 8087
ssh loki@stlb01.stratos.xfusioncorp.com
# password: Mischi3f

## and try to do this 
curl http://stapp01:8087 # this should work and if you try on any other server it should fail, or timemout
```