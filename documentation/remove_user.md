# Remove User Account from a Linux Server:
In order to remove a user account from a Linux server use the following commands in the specified order.
```bash
deluser --remove-home <username>
groupdel <group_name>
rm -rf <folder_path>
```

**Example:**

Let's say that we have a useless user in the `server.for.dummies` server, and its name is `dummy_user`.
First step is to connect as the `root` user with the desired server via `ssh`:
```
$ ssh root@server.for.dummies -p 123456
```
Every user is also associated with a group, that also needs to be deleted. To find out which group is associated with the user run `groups <username>`:
```
$ groups dummy_user
=> dummy_group: dummy_user
```
The last information we need is the `folder_path`, where the user's files are being saved.
In our server, this folder should have the same name as the user, and it is saved right after the root directory.

Now, we have all the information needed to delete the user correctly:
```
$ deluser --remove-home dummy_user
$ groupdel dummy_group
$ rm -rf dummy_user/
```

You might need to use `sudo deluser --remove-home <username>` instead of `deluser --remove-home <username>`.

**Extra info:**

* https://www.cyberciti.biz/faq/linux-remove-user-command/
