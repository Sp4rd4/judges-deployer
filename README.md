Scheduled deployment of judges and webhook for redeployment
=========================

## Setup:
On dokku server:
```
dokku apps:create autodeploy
dokku config:set autodeploy GITHUB_TOKEN=token
dokku docker-options:add autodeploy build '--build-arg SECRET_TOKEN=123 --build-arg STEWARD_TOKEN=token --build-arg STEWARD_JOB=job_id'
```

Set dokku user crontab as [next](dokku_crontab)

To trigger the redeploy webhook you need POST host:9000/hooks/redeploy with any body and header `X-Signature` that contains HMAC-sha1 of body.
To get this header content for specific body and secret you can execute next ruby code:
```
require 'openssl'

body = "body"
secret = "123"

signature = 'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), secret, body)
puts signature
```
