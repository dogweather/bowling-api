# Ten-Pin Bowling API

[![Build Status](https://travis-ci.org/dogweather/bowling-api.svg?branch=master)](https://travis-ci.org/dogweather/bowling-api) [![Maintainability](https://api.codeclimate.com/v1/badges/a3e5c9c337305129b87b/maintainability)](https://codeclimate.com/github/dogweather/bowling-api/maintainability)


Creating a Game API as an exercise.

```
          Prefix Verb   URI Pattern                                Controller#Action
game_frame_rolls GET    /games/:game_id/frames/:frame_id/rolls     rolls#index
                 POST   /games/:game_id/frames/:frame_id/rolls     rolls#create
 game_frame_roll GET    /games/:game_id/frames/:frame_id/rolls/:id rolls#show
     game_frames GET    /games/:game_id/frames                     frames#index
      game_frame GET    /games/:game_id/frames/:id                 frames#show
           games GET    /games                                     games#index
                 POST   /games                                     games#create
            game GET    /games/:id                                 games#show
                 DELETE /games/:id                                 games#destroy

```

## Design Choice: Deep vs. Shallow Nesting

I opted for "deep nesting" because of the strict definition of the game. E.g., there
are always ten frames, with 2 or 3 rolls. And by using "external id's", the client's
work is simpler because the endpoints are pre-determined. In essence, the API navigates
a large, finite data structure.

The `:game_id` is an internal id. (The `id` db column.) The `:frame_id` and `rolls/:id` are external id's, corresponding to the natural numbering of frames and balls. E.g., if a game's
 id is `12345`, then the endpoint to retrieve its first roll in the first frame would be:

```
GET /games/12345/frames/1/rolls/1
```

## Understanding the Code

Since this a JSON API, looking at just a few key places will
explain what this app does and how.

* The output of `rails routes`, above.
* The [request specs](https://github.com/dogweather/bowling-api/tree/master/spec/requests),
  because they test the app from the point of view of a client using the
  API.
* The [Bowling module](https://github.com/dogweather/bowling-api/blob/master/lib/bowling.rb),
  which contains the scoring logic.

## Development environment set up and launch

Docker is the only prerequisite to getting the dev environment
up and running.

```bash
docker-compose up
```

The API server will be avaiable at http://localhost:3000.

Run with specs with:

```bash
docker-compose exec web rspec
```

Execute tasks with, e.g.:

```bash
docker-compose exec rake -T
```
