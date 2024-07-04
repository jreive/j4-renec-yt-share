# Simple youtube video share
Simple system allow user to login/register and share their videos with others.

> Main purpose of this repo is that show how to use Websocket, React and Rails; so it only use Sqlite to demonstrate database connection.
> 
> You could implement other database type since there is not specular query to any db

## Prerequisites

    Ruby: 3.3.2
    Rails: 7
    Node: 20
    SQLite3
    Google Youtube Data API v3

## Installation & Configuration
### Clone repository
```bash
    git clone https://github.com/jreive/j4-renec-yt-share.git
```
### Bundle and package install
```bash
    bundle install
    yarn install
```
### Database Setup
This project are using SQLite3, save in `storage` folder
```bash
    rake db:drop
    rake db:create
    rake db:migrate
```
### Google API
I use Youtube Data API v3 to fetch youtube video snippet. You can create an API key from [here](https://console.cloud.google.com/apis/credentials). Follow this [guides](https://developers.google.com/youtube/registering_an_application). Remember to add restrictions to `Youtube Data API v3` only to prevent any accident with your GG account when use the API.

The API key must store in `env` with key `YOUTUBE_API_KEY`
                            
    YOUTUBE_API_KEY=AIzxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

You can insert multiple key to `app/services/youtube_video_service.rb`
```ruby
    @key_rotation = KeyRotationService.new([
                                             ENV['YOUTUBE_API_KEY']
                                          ])
```

## Running the Application

### For linux-base
```bash
    bin/dev
```
### For windows
You must run following command in separate cmd windows, since windows don't actually have sh/bash (even with gitBash)
```bash
    yarn build --watch
```
```bash
    yarn watch:css
```
```bash
    rails server
```

## Docker Deployment

## Usage
### Testing
```bash
    rake test:prepare
    rake db:migrate RAILS_ENV=test
    rails test
```

## Troubleshooting
### Limitation
- Only keep last 10 notification
### Known issues
- To saving database space, there is not relate table between user and video shared, so when user share a new video during disconnect. They could miss other update
- When drop db with `rake db:drop`, there may have permission error so you must locate to `./storage` folder to delete them manually