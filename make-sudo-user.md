# Create a User with Sudo Privileges on Linux Ubuntu

```
adduser emcdaniel
usermod -aG sudo emcdaniel
su - emcdaniel
```

1. Make the username
2. Give a password, and leave the rest blank
3. Give sudo privileges
4. Switch over and use sudo 

Mount the fileshare with the sudo user, not with root. 