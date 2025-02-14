tz-bot
===========

This repository contains a wrapper script that makes it easier to use 
Electronic Frontier Foundation's (EFF's) Certbot with the TRUSTZONE's ACME Pro GlobalSign server.
This wrapper is a fork of ZEROSSL's zerossl-bot

Installation
------------

1. Install the operating system packages for `curl`, `certbot` and `python3`.
2. Install the TrustZone wrapper script
   1. Quick: 
      1. run `bash <(wget -q -O - https://github.com/mattTrustzone/tz-bot/raw/master/get-tzbot.sh)`
      2. Done!
   2. Careful: 
      1. Run `wget -q -O - https://github.com/mattTrustzone/tz-bot/raw/master/get-tzbot.sh > get-tzbot.sh`
      2. Inspect the file to see that it does what it is supposed to do
      3. Run `source get-tzbot.sh`
      
Usage
-----

To use the TrustZone ACME server instead of running `certbot` run `tz-bot`.

**Important Note:** You should use the `--tz-api-key` argument in order to make sure you get a TrustZone certificate instead of a Let's Encrypt certificate.

### Examples

```bash
sudo tz-bot certonly --standalone -m anton@example.com -d mydomain.example.com
```

```bash
sudo tz-bot --apache -m barbara@example.com -d myotherdomain.example.com
```

```bash
sudo tz-bot --apache -d mythirddomain.example.com --tz-api-key 1234567890abcdef1234567890abcdef
```

```bash
sudo tz-bot certonly --dns-cloudflare --dns-cloudflare-credentials /root/.secrets/cloudflare-api-token \
                          --dns-cloudflare-propagation-seconds 60 -d fourth.example.com \
                          --tz-api-key=1234567890abcdef1234567890abcdef
```

Recommendations
----

Ensure correct ACME server URL is used (--server flag):

```
 --server https://emea.acme.atlas.globalsign.com/directory
```


Known issues
-----

There have been issues reported with certbot interactive prompt causing certificates of Let's Encrypt instead of TrustZone being issued. It is recommended to hand over parameters directly using the documented flags.
