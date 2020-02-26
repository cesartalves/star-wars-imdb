# Star Wars Movie Rating

[![Build Status](https://travis-ci.org/cesartalves/star-wars-imdb.svg?branch=master)](https://travis-ci.org/cesartalves/star-wars-imdb) [![Maintainability](https://api.codeclimate.com/v1/badges/969571e33b4e32f76f2b/maintainability)](https://codeclimate.com/github/cesartalves/star-wars-imdb/maintainability)[![Test Coverage](https://api.codeclimate.com/v1/badges/969571e33b4e32f76f2b/test_coverage)](https://codeclimate.com/github/cesartalves/star-wars-imdb/test_coverage)

## Description

This simple Ruby on Rails application consumes data from the Star Wars API (https://swapi.co/api/films?format=json).
It allows logged users to vote on their favorite movies (two votes per user) and see the ranking of most/least liked.

-   Bootstrap 4.0
-   i18n/i18n_devise
-   CI/CD Setup with travis CI
-   Maintainability / Code Coverage grade setup with Codeclimate


## Done

- Data Modeling
- Devise / User configuration
- Routes: get /movies, get /ranking, post /vote, get /ranking/details

## To-Do

- Customize views further
- Translate some of the devise error messages 
- Translate date lançamento on details

## Possible improvements:

- ranking/any_invalid_id raises error (500)
- add resilience to failure on calls to API
- add controller test with mock service. Here's reference on accomplishing it: https://content.pivotal.io/blog/object-oriented-rails-writing-better-controllers
- Could use Single Page Application (react or vue) to load votes / movies using ajax
