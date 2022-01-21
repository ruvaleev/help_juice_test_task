# Search Box

[![Actions Status](https://github.com/ruvaleev/help_juice_test_task/workflows/NPM%20tests/badge.svg)](https://github.com/ruvaleev/help_juice_test_task/actions)
[![Actions Status](https://github.com/ruvaleev/help_juice_test_task/workflows/Ruby/badge.svg)](https://github.com/ruvaleev/help_juice_test_task/actions)

## What this application does

We collect requests of users to be able to analyse them. Frontend reports about your queries every 5 seconds (which can easily be adjusted by environment variables), but only in case if you **have** any queries may be new for backend. If all of your queries we already have received, Frontend won't disturb the server. If you have any new queries, then backend write them to DB. On this step we also care of disk space and check there are no doubles. So we reduce number of excess records in our database, and reduce number of queries, composing them to bunches on Frontend and sending with predictable periods. The main work is implemented on client side, therefore backend is ready for other users.

## Development

To install project:
1) Install Ruby, Rails and gems
2) Setup database

```bash
bundle exec rake db:create
bundle exec rake db:migrate
```

3) Run server

```
bundle exec rails s
```

## Testing

### Ruby specs

1) Install [chromedriver](https://www.selenium.dev/documentation/webdriver/getting_started/install_drivers/) to be able to run acceptance tests. 
2) Now you can run tests with following command:
```
bundle exec rspec spec/
```

### Javascript tests

1) Install necessary modules

```
npm install
```

2) Now you can run tests with following command:

```
npm test
```
