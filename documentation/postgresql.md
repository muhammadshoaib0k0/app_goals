# PostgreSQL

## How to install PostgreSQL?

```shell
brew install postgresql
```

As of now you don't need to install a specific version for compatibility

## PostgreSQL not available if started/restarted

```shell
brew services list
```

PostgreSQL is *yellow* instead of *green*?  
Rebooting the operating system doesn't help?

## Fix by removing the .pid for postgres

```shell
rm -f /usr/local/var/postgres/postmaster.pid
```

Now your postgres client should be available after restarting it

```shell
brew services start postgresql
```
