## Load testing Phoenix and Rails scaffolds
### by Hugo Duksis

---

## Shameless plug!

https://www.honeypot.io

![Honeypot](https://www.honeypot.io/logo.png)

---

## Why?

* Inspired by last months Benchee talk
* Benchmarking is the most subjective thing in the world!
* You have to do it yourself

Note:
How did I end up doing this and

---

## The applications

* Simple Phoenix, Rails scaffolds
* 1 model 1 form 3 text fields
* new and create actions (no delete no update)

---

## Setup

* PostgreSQL
* Heroku (HashNuke and gjaldon)/ruby buildpacks
* Phoenix/Rails

---

## http benchmarking tools

* Tsung
* httperf
* wrk

---

## Simple GET with wrk

* 8 threads
* 100 connections
* 30 seconds

```shell
wrk -t8 -c100 -d30s 'http://phoenix-sample-app.herokuapp.com/'
```

---

## GET on Phoenix

```shell
$ wrk -t8 -c100 -d30s 'http://phoenix-sample-app.herokuapp.com/'

Running 30s test @ http://phoenix-sample-app.herokuapp.com/
  8 threads and 100 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   432.24ms  376.34ms   1.99s    63.30%
    Req/Sec    29.78     22.33   138.00     81.47%
  6606 requests in 30.10s, 49.98MB read
  Socket errors: connect 0, read 0, write 0, timeout 75
Requests/sec:    219.45
Transfer/sec:      1.66MB
```

---

## GET on Rails

```shell
$ wrk -t8 -c100 -d30s 'http://rails-sample-app0.herokuapp.com/'

Running 30s test @ http://rails-sample-app0.herokuapp.com/
  8 threads and 100 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   974.90ms  501.87ms   2.00s    61.32%
    Req/Sec    12.57      9.11    58.00     81.78%
  2468 requests in 30.06s, 19.58MB read
  Socket errors: connect 0, read 0, write 0, timeout 286
Requests/sec:     82.09
Transfer/sec:    666.91KB
```

---

## Simple POST with wrk

* 8 threads
* 100 connections
* 30 seconds

```shell
wrk -t8 -c100 -d30s -s ./post_phoenix.lua http://phoenix-sample-app.herokuapp.com/
```

---

## wrk POST lua config

```lua
-- HTTP POST script which is setting the
-- HTTP method, body, and adding a header

wrk.method = "POST"
wrk.body   = "_csrf_token=JzFfZiRnDSs6Jwo7GkIYCAgcUw0nAAAABynIt3LmVwn..."
wrk.headers["Content-Type"] = "application/x-www-form-urlencoded"
wrk.headers["Cookie"] = '_honeyworth_key=g3QAAAABbQAAAAtfY3NyZl...'
```

---

## POST on Phoenix

```shell
$ wrk -t8 -c100 -d30s -s ./post_phoenix.lua http://phoenix-sample-app.herokuapp.com

Running 30s test @ http://phoenix-sample-app.herokuapp.com
  8 threads and 100 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   432.96ms  176.09ms   1.62s    88.33%
    Req/Sec    29.34     13.69    80.00     72.19%
  6757 requests in 30.11s, 5.16MB read
  Socket errors: connect 0, read 0, write 0, timeout 5
Requests/sec:    224.42
Transfer/sec:    175.33KB
```

---

## POST on Rails

```shell
$ wrk -t8 -c100 -d30s -s ./post_rails.lua http://rails-sample-app0.herokuapp.com/

Running 30s test @ http://rails-sample-app0.herokuapp.com/
  8 threads and 100 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   430.28ms  221.64ms   1.97s    78.50%
    Req/Sec    28.99     15.64    90.00     64.55%
  6764 requests in 30.11s, 7.73MB read
  Socket errors: connect 0, read 0, write 0, timeout 8
Requests/sec:    224.68
Transfer/sec:    262.93KB
```

---

## Getting the max out of a Heroku dino with Phoenix

```
wrk -t12 -c300 -d60s http://phoenix-sample-app.herokuapp.com
  10810 requests in 1.00m, 82.46MB read
  Socket errors: connect 0, read 0, write 0, timeout 3225
wrk -t24 -c600 -d60s http://phoenix-sample-app.herokuapp.com
  10291 requests in 1.00m, 79.67MB read
  Socket errors: connect 0, read 0, write 0, timeout 4777

wrk -t12 -c300 -d60s -s ./post_phoenix.lua http://phoenix-sample-app.herokuapp.com
  23309 requests in 1.00m, 17.78MB read
  Socket errors: connect 0, read 0, write 0, timeout 1162
wrk -t24 -c600 -d60s -s ./post_phoenix.lua http://phoenix-sample-app.herokuapp.com
  24341 requests in 1.00m, 18.43MB read
  Socket errors: connect 0, read 1377, write 0, timeout 3722
  Non-2xx or 3xx responses: 1377
```

---

## Getting the max out of a Heroku dino with Rails

```
wrk -t12 -c300 -d60s 'http://rails-sample-app0.herokuapp.com/'
  5988 requests in 1.00m, 47.49MB read
  Socket errors: connect 0, read 0, write 0, timeout 3634
wrk -t24 -c600 -d60s 'http://rails-sample-app0.herokuapp.com/'
  7484 requests in 1.00m, 59.37MB read
  Socket errors: connect 0, read 0, write 0, timeout 6183

wrk -t12 -c300 -d60s -s ./post_rails.lua http://rails-sample-app0.herokuapp.com/
  6855 requests in 1.00m, 7.83MB read
  Socket errors: connect 0, read 0, write 0, timeout 3971
wrk -t24 -c600 -d60s -s ./post_rails.lua http://rails-sample-app0.herokuapp.com/
  7016 requests in 1.00m, 8.02MB read
  Socket errors: connect 0, read 0, write 0, timeout 6712
```

---

## Heroku metrics for Phoenix app



---

## Summary


---

## Q&A

---

## The END
