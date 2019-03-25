# Ten-Pin Bowling API

[![Build Status](https://travis-ci.org/dogweather/bowling-api.svg?branch=master)](https://travis-ci.org/dogweather/bowling-api) [![Maintainability](https://api.codeclimate.com/v1/badges/a3e5c9c337305129b87b/maintainability)](https://codeclimate.com/github/dogweather/bowling-api/maintainability)


Creating a Game API as an exercise.

```
          Prefix Verb   URI Pattern                                          Controller#Action
game_frame_rolls GET    /games/:game_id/frames/:frame_id/rolls(.:format)     rolls#index
                 POST   /games/:game_id/frames/:frame_id/rolls(.:format)     rolls#create
 game_frame_roll GET    /games/:game_id/frames/:frame_id/rolls/:id(.:format) rolls#show
     game_frames GET    /games/:game_id/frames(.:format)                     frames#index
      game_frame GET    /games/:game_id/frames/:id(.:format)                 frames#show
           games GET    /games(.:format)                                     games#index
                 POST   /games(.:format)                                     games#create
            game GET    /games/:id(.:format)                                 games#show
                 DELETE /games/:id(.:format)                                 games#destroy

```

The `:game_id` is an internal id.  The `:frame_id` and `rolls/:id` are external id's,
corresponding to the natural numbering of frames and balls. E.g., if a game's id is
`12345`, then the endpoint to retrieve its first roll in the first frame would be:

```
GET /games/12345/frames/1/rolls/1
```

## Development environment set up and launch

```bash
docker-compose up
```

The API server will be avaiable at http://localhost:3000.

Run with specs with:

```bash
docker-compose exec web rspec
```
