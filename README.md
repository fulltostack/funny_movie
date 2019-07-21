## FunnyMovies
### Environment
* Ruby version : 2.5.1
* Rails version : 5.2.3

### Dependencies
Install bundler and run `bundle install`:
```bash
gem install bundler
bundle install
```
### Database
```bash
rake db:create
rake db:migrate
```
### Run the application
```bash
rails s
```
### Run background-job(sidekiq) service
```bash
sidekiq
```

### Run test suite
```bash
rspec
```
