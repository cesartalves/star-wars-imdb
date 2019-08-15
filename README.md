# Star Wars Movie Rating

[![Build Status](https://travis-ci.org/cesartalves/star-wars-imdb.svg?branch=master)](https://travis-ci.org/cesartalves/star-wars-imdb) [![Maintainability](https://api.codeclimate.com/v1/badges/969571e33b4e32f76f2b/maintainability)](https://codeclimate.com/github/cesartalves/star-wars-imdb/maintainability)

## Description

This simply Ruby on Rails application consumes data from the Star Wars API (https://swapi.co/api/films?format=json).
It allows logged users to vote on their favorite movies (two votes per user) and see the ranking of most/least liked.

-   Bootstrap 4.0
-   i18n/i18n_devise
-   CI/CD Setup with travis CI
-   Maintainability grade setup with Codeclimate


## Done

- Data Modeling
- Devise / User configuration
- Routes: get /movies, get /ranking, post /vote, get /ranking/details

## To-Do

- Customize views further
- Translate some of the devise error messages 
- Translate date lançamento on details

### Tests

#### Unit

##### Movie:
    
##### Vote:
- field validations

##### User?

#### Routes:
- /movies: 404(3) if user not logged
- /movies: 200 if user logged
- /ranking: same as above
- /vote: same as above
- /vote: success if user voted less than UserVotePolicy
- /vote: failure if user voted more than UserVotePolicy
- /vote: failure if user already voted on movie
- /vote: success if they still didn't

#### Integration / Controllers:

- TBD

## Possible improvements:

- add resilience to failure on calls to API
- Could use Single Page Application (react or vue) to load votes / movies using ajax
- add code coverage with code-climate
- use rspec


