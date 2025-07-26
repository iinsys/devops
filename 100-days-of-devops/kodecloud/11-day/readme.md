>Study hard what interests you the most in the most undisciplined, irreverent and original manner possible.
>
>– Richard P. Feynman

>I am experienced enough to do this. I am knowledgeable enough to do this. I am prepared enough to do this. I am mature enough to do this. I am brave enough to do this.
>
>– Alexandria Ocasio-Cortez

>The beautiful thing about learning is that nobody can take it away from you.

---

The Nautilus application development team recently finished the beta version of one of their Java-based applications, which they are planning to deploy on one of the app servers in Stratos DC. After an internal team meeting, they have decided to use the tomcat application server. Based on the requirements mentioned below complete the task:

---

a. **Install tomcat server on App Server 3.**

```sh
# SSH to Jump Host
ssh thor@jump_host.stratos.xfusioncorp.com
# Password: mjolnir123

# SSH to App Server 3
ssh banner@stapp03
# Password: BigGr33n

# Install Tomcat (CentOS/RHEL)
sudo yum install -y tomcat

# Or for Ubuntu/Debian
# sudo apt-get update
# sudo apt-get install -y tomcat9
```

---

b. **Configure it to run on port 3001.**

```sh
# Edit the Tomcat server.xml file
sudo vi /etc/tomcat/server.xml
# Change the following line:
# <Connector port="8080" protocol="HTTP/1.1"
# To:
# <Connector port="3001" protocol="HTTP/1.1"
```

---

c. **There is a ROOT.war file on Jump host at location /tmp.**

```sh
# On Jump Host, copy the ROOT.war to App Server 3
scp /tmp/ROOT.war banner@stapp03:/tmp/
# Password: BigGr33n

# On stapp03, move the WAR file to Tomcat's webapps directory
sudo mv /tmp/ROOT.war /usr/share/tomcat/webapps/ROOT.war
sudo chown tomcat:tomcat /usr/share/tomcat/webapps/ROOT.war
```

---

d. **Start/Restart Tomcat**

```sh
sudo systemctl restart tomcat
sudo systemctl enable tomcat
```

---

e. **Test the deployment**

```sh
curl http://stapp03:3001
```
You should see the deployed application's web page.

---

**Summary:**  
- Tomcat is installed and running on port 3001.
- The ROOT.war is deployed as the base app.
- The application is accessible at `http://stapp03:3001`.