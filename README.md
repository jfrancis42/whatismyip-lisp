# whatismyip-lisp
A Common Lisp client for retrieving your public IP address from various public API servers.

This library uses your choice of various public IP address APIs to determine your public IP. Some of these work with both IPv4 and IPv6, and some are IPv4 only.

You can simply call the get-public-ip function, and it will default to using the whatismyipaddress.com server:

````
CL-USER> (whatismyip:get-public-ip)
"50.34.150.131"
CL-USER>
````

You can also specify which public API server to use:

````
CL-USER> (whatismyip:get-public-ip :icanhazip)
"50.34.150.131"
CL-USER>
````

The public API servers currently supported are:

+ :ident-me - http://ident.me
+ :icanhazip - http://icanhazip.com
+ :ipify - http://api.ipify.org?format=json
+ :dyndns - http://checkip.dyndns.org
+ :ipinfo - http://ipinfo.io/ip
+ :infoip - http://api.infoip.io/ip
+ :trackip - http://www.trackip.net/ip?json
+ :whatismyipaddress - http://bot.whatismyipaddress.com
+ :ip-api - http://ip-api.com/json

Each of these services has various restrictions on how often and how many times per 24-hour period they may be queried. Please honor these restrictions, lest these sites be shut down.
