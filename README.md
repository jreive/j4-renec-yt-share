# Simple youtube video share
Simple system allow user to login/register and share their videos with others.

    Main purpose of this repo is that show how to use Websocket, React and Rails; so it only use Sqlite to demonstrate database connection.

## Prerequisites

## Installation & Configuration

## Database Setup

## Running the Application

## Docker Deployment

## Usage

### Testing
    
    rake test:prepare
    rake db:migrate RAILS_ENV=test

## Troubleshooting

To saving database space, there is not relate table between user and video shared, so when user share a new video during disconnect. They could miss other update