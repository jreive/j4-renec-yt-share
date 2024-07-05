# Simple YouTube Video Share
A simple system that allows users to log in/register and share their videos with others.

The main purpose of this repository is to demonstrate how to use WebSocket, React, and Rails. Therefore, it only uses SQLite to demonstrate database connection.

You could implement other database types since there are no specific queries to any database.

## Prerequisites

    Ruby: 3.3.2
    Rails: 7
    Node: 20
    SQLite3
    Google Youtube Data API v3

## Installation & Configuration
### Clone the repository
```bash
    git clone https://github.com/jreive/j4-renec-yt-share.git
```
### Bundle and package installation
```bash
    bundle install
    yarn install
```
### Database Setup
This project uses SQLite3, saved in the `storage` folder.
```bash
    rake db:drop
    rake db:create
    rake db:migrate
```
### Google API
I use the YouTube Data API v3 to fetch YouTube video snippets. You can create an API key from here. Follow these guides. Remember to add restrictions to `YouTube Data API v3` only to prevent any accidental usage with your Google account when using the API.

The API key must be stored in the `.env` file with the key `YOUTUBE_API_KEY`:
                            
    YOUTUBE_API_KEY=AIzxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

You can insert multiple keys into `app/services/youtube_video_service.rb`
```ruby
    @key_rotation = KeyRotationService.new([
                                             ENV['YOUTUBE_API_KEY']
                                          ])
```

## Running the Application

### For Linux-based systems
```bash
    bin/dev
```
### For windows
You must run each the following commands in separate command prompt windows since Windows doesn't have sh/bash (even with GitBash).
```bash
    yarn build --watch
    yarn watch:css
    rails server
```
### Browser
When running locally, the default access is from http://localhost:3000. You can change the port later.
### Testing
```bash
    rake db:test:prepare
    rails test
```

## Docker Deployment
```bash
    docker build .
```

## Usage
### Authentication
This project use [Devise-JWT](https://rubygems.org/gems/devise-jwt) and session to authorize and use email to identify user.

In very first start, access http://localhost:3000/login to sign up. Your account will automate logged-in.
### Share video
Use Youtube API to retrieve video's data (title, description, thumb...), so only thing you need is just a link.

Already support two form: standard and short:
- Standard: https://www.youtube.com/watch?v=8MAXnu-8q1I&list=RDTY0&index=2
- Short: https://youtu.be/8MAXnu-8q1I?si=CZ6CW6Ryg4DpkxSu

## Troubleshooting
### Limitation
- When get notification, only the last 10 notifications are kept. You could change this behavior in `Api::NotificationController#fetch`
### Known issues
- To save database space, there is no relation table between users and shared videos. So, when a user shares a new video while disconnected, they might miss other updates.
- When dropping the database with `rake db:drop`, there might be permission errors, so you must navigate to the `./storage` folder to delete them manually.
