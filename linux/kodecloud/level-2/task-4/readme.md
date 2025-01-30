There is some data on `Nautilus App Server 2` in `Stratos DC`. Data needs to be altered in several of the files. On `Nautilus App Server 2`, alter the `/home/BSD.txt` file as per details given below:


a. Delete all lines containing word `following` and save results in `/home/BSD_DELETE.txt` file. (Please be aware of case sensitivity)

b. Replace all occurrence of word `and` to `them` and save results in `/home/BSD_REPLACE.txt` file.

`Note:` Let's say you are asked to replace word `to` with `from`. In that case, make sure not to alter any words containing the string itself; for example upto, contributor etc.

```bash
# Delete lines containing "following" and save to /home/BSD_DELETE.txt
# Since redirection (>) happens before sudo is applied, you need to use tee:
sudo grep -v 'following' /home/BSD.txt | sudo tee /home/BSD_DELETE.txt
# For the replacement task:
#  Replace all occurrences of "and" with "them" and save to /home/BSD_REPLACE.txt
sudo sed 's/\band\b/them/g' /home/BSD.txt | sudo tee /home/BSD_REPLACE.txt

## Verify changes
cat /home/BSD_DELETE.txt
cat /home/BSD_REPLACE.txt

```