A container named `kke-container` was created by one of the Nautilus project developers on `App Server 2`. It was solely for testing purposes and now requires deletion. Execute the following task:

Delete the `kke-container`` on App Server 2 `in Stratos DC.

## Solution
```bash
## ssh to app server 2
ssh steve@stapp02.stratos.xfusioncorp.com
Password: <put password>

### verify containers
docker ps -a

## stop and remove container
docker stop kke-container
docker rm kke-container
docker ps -a
exit
```




