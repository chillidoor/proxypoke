# Proxy Poke

Proxy Poke is a simple CLI program that lets you "poke" a proxy (such as [Squid](https://www.squid-cache.org/)) to check that is working.


## Installation

```bash
gem install proxypoke
```

Usage:

```bash 
# proxypoke -h
Usage: proxypass [options]
    -u, --url URL                    Test URL to query. Required.
    -o, --proxy-host HOST            Proxy hostname or IP address. Defaults to 'localhost'.
    -p, --proxy-port PORT            Port to connect to on the proxy host. Defaults to 3128.
    -t, --timeout                    Request timeout value. Defaults to 3 seconds
    -s, --string STRING              Search for a specific string in the response body
    -h, --help                       Prints this help.
``` 

