This is an exercise in developing [testable Ruby code](https://www.oreilly.com/library/view/ruby-best-practices/9780596157487/ch01.html).

It consists in writing test code for a given JSON API server, and to make the server more robust.

The JSON API server is a very simple [Sinatra](https://github.com/sinatra/sinatra) app, consisting of only one file. It takes as input a JSON-array numbers and adds them up.

Let's run through a demo.

# Demo of the sample server

Install required gems and start the server
```
$ bundle install
:
:
$ bundle exec ruby json-api-adder.rb 
[2021-07-26 07:11:15] INFO  WEBrick 1.3.1
[2021-07-26 07:11:15] INFO  ruby 2.4.4 (2018-03-28) [x86_64-linux]
== Sinatra (v2.1.0) has taken the stage on 4567 for development with backup from WEBrick
[2021-07-26 07:11:15] INFO  WEBrick::HTTPServer#start: pid=117739 port=4567
```

Then use `curl` to submit various JSON requests:


```
$ curl -X POST -H "Content-Type: application/json" -d '[1,2]' http://localhost:4567
3
```

1 + 2 = 3, so this is nice.

```
$ curl -X POST -H "Content-Type: application/json" -d '[1,2,3]' http://localhost:4567
6
```
1 + 2 + 3 = 6, also nice.

Basic input checking is performed:

```
$ curl -X POST -H "Content-Type: application/json" -d '"a"' http://localhost:4567
{"error":"Invalid input"}
```

But the server crashes on inputs like this (stacktrace not shown):

```
$ curl -X POST -H "Content-Type: application/json" -d 'a' http://localhost:4567     
JSON::ParserError: 809: unexpected token at 'a'
```

# Exercise / tasks

1. Refactor the code so that existing, and new, functionality can be tested. (Pull the functionality out of the `post '/' do`).
2. Add tests:
    1. One passing test for the 1+2+3=6 case above.
    2. Another passing test for the "a" input..
3. Add a `Rakefile` with a rake task that invokes the tests: `$ rake`  => the tests are executed
4. Add a failing test: invalid JSON ("a") should not crash the server, but respond with the same invalid input error.
5. Change the server code so that the new test passes.

Test framework is up to you (except, needs to be based on Ruby). When refactoring, feel free to add new Ruby classes / files as you prefer.
This test has no right/wrong answer, some of it is a matter of taste.
