# docker postgres scripts

docker postgres scripts

## running

To start up a Postgres instance:

```shell
./postgres.sh
```

Wait for everything to start. When you will see something like this:

```text
PostgreSQL init process complete; ready for start up.

2024-02-04 20:37:41.552 UTC [1] LOG:  listening on IPv4 address "0.0.0.0", port 5432
2024-02-04 20:37:41.552 UTC [1] LOG:  listening on IPv6 address "::", port 5432
2024-02-04 20:37:41.556 UTC [1] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
2024-02-04 20:37:41.581 UTC [50] LOG:  database system was shut down at 2024-02-04 20:37:41 UTC
2024-02-04 20:37:41.588 UTC [1] LOG:  database system is ready to accept connections
```

you know that the instance is ready.

To connect to the DB via `psql`, run in another terminal window:

```shell
./psql.sh "postgres://db_user:user_pass@localhost/my_db"
```

NOTE: The username and password come from the file `./sql/init.sql`. This script is used when initializing the Postgres instance.

## for reference

Below are the `docker build` options used in the scripts, and their explanation.

```text
 docker build [OPTIONS] PATH | URL | -

 -t
 --tag
   Name and optionally a tag in the ‘name:tag’ format

 -f
 --file
   Name of the Dockerfile (Default is ‘PATH/Dockerfile’).
```

Below are the `docker run` options used in the scripts, and their explanation.

```text
 docker run [OPTIONS] IMAGE [COMMAND] [ARG...]

 -t
 --tty
   Allocate a pseudo-TTY.

 -i
 --interactive
   Keep STDIN open even if not attached.

 --net
   Connect a container to a network. Possibilities:

   host
     If you use the `host` network mode for a container, that container’s network stack is not
     isolated from the Docker host (the container shares the host’s networking namespace), and
    the container does not get its own IP-address allocated. For instance, if you run a
     container which binds to port 80 and you use host networking, the container’s application
     is available on port 80 on the host’s IP address.

 -e
 --env
   Set environment variables. Use the -e, --env, and --env-file flags to set simple (non-array)
   environment variables in the container you’re running, or overwrite variables that are
   defined in the Dockerfile of the image you’re running.

 -v
 --volume
   Bind mount a volume.
```

Below are `pg_dump` options used in the scripts, and their explanation.

```text
 -h host
 --host=host
   Specifies the host name of the machine on which the server is running. If the value begins with
   a slash, it is used as the directory for the Unix domain socket. The default is taken from the
   PGHOST environment variable, if set, else a Unix domain socket connection is attempted.

 -d dbname
 --dbname=dbname
   Specifies the name of the database to connect to. This is equivalent to specifying dbname as
   the first non-option argument on the command line. If this parameter contains an = sign or starts
   with a valid URI prefix (postgresql:// or postgres://), it is treated as a conninfo string.

 -p port
 --port=port
   Specifies the TCP port or local Unix domain socket file extension on which the server is listening
   for connections. Defaults to the PGPORT environment variable, if set, or a compiled-in default.

 -U username
 --username=username
   User name to connect as.

 -N schema
 --exclude-schema=schema
   Do not dump any schemas matching the schema pattern. The pattern is interpreted according to the
   same rules as for -n. -N can be given more than once to exclude schemas matching any of several
   patterns.

 --exclude-table-data=table
   Do not dump data for any tables matching the table pattern. The pattern is interpreted according
   to the same rules as for -t. --exclude-table-data can be given more than once to exclude tables
   matching any of several patterns. This option is useful when you need the definition of a
   particular table even though you do not need the data in it.

 -F format
 --format=format
   Selects the format of the output. format can be one of the following:
     c
     custom
       Output a custom-format archive suitable for input into pg_restore. Together with the directory
       output format, this is the most flexible output format in that it allows manual selection and
       reordering of archived items during restore. This format is also compressed by default.

 -f file
 --file=file
   Send output to the specified file. This parameter can be omitted for file based output formats,
   in which case the standard output is used. It must be given for the directory output format however,
   where it specifies the target directory instead of a file. In this case the directory is created
   by pg_dump and must not exist before.
```
