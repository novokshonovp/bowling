# README

Steps are necessary to get the
application up and running.

* Ruby version
`2.6.5`


* Database creation and initialization
`bundle exec rake db:create db:migrate`


* How to run the test suite

`RAILS_ENV=test bundle exec rake db:create db:migrate`

`bundle exec rspec --format doc`

* Usage example

```
 $curl -X POST localhost:3000/games
 {"id":1}

 $curl -X POST localhost:3000/games/1/balls?knocked_pins=1
 {"id":1,"frame_scores":{"1":1},"total_score":1}
 $curl -X POST localhost:3000/games/1/balls?knocked_pins=3
 {"id":1,"frame_scores":{"1":4},"total_score":4}
 $curl -X POST localhost:3000/games/1/balls?knocked_pins=7
 {"id":1,"frame_scores":{"1":4,"2":11},"total_score":11}

 $curl localhost:3000/games/1
 {"id":1,"frame_scores":{"1":4,"2":11},"total_score":11}

```