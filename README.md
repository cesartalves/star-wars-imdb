# Star Wars Movie Rating APi

[![Build Status](https://travis-ci.org/cesartalves/star-wars-imdb.svg?branch=master)](https://travis-ci.org/cesartalves/star-wars-imdb)

## Done

### Data Modeling

Requisitos:

Models:

User
Movie - primary_key: id
    data which will come from api: Nome do filme, episódio, diretor e o ano do filme.
Vote - foregin_key: user_id, movie_id,
   


4. Crie uma opção na listagem/tela conforme acima para que o usuário logado possa votar no filme desejado (like/dislike por filme)

5. Each user can only vote twice: Vote.count user_id < UserVotePolicy (canvote?)
6. Report (movies ranked by vote/downvote)
     type: like, dislike

Could do: Vote.count where (movie.id & like) - Vote.count where(movie.id & dislike)

7. Nos dois primeiros filmes mais votados, disponibilizar um link para visualizar os dados completos dos filmes (usar a API de detalhes). Informações a mais: atores, planetas, etc. 

### Devise / User configuration

- Create user models

### Routes:

get films: 
    shows all filmes from the list with number of votes
    shows two highest voted movies for visualization of (this could probably be shared by films and report routes)

get report:
    filmes ranked by vote

resource: user
post vote: id of the filme and type (like | dislike)
report:

### Templates:

movies.index
movies.report

navbar: todos os filmes / ranking / Usuário


### Deploy

- Mailer production
- Configure Heroku

## To-Do

### Devise / User configuration

- Customize views

### Tests

films: 
    404 if user not logged
    200 if user logged

votes:
    success if user voted less than UserVotePolicy
    failure if user voted more than UserVotePolicy

### CI/CD

### SPWA?

    - Could use react or vue to load votes / movies on the fly


