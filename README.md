## Setup

### Requirements

* Ruby 3.0.0
* Bundler 2

### Setup steps

* Clone repo `git clone <link to repo>`
* Run `bundle install`·
* Setup database `rails db:setup`
* Run server `rails s`

### API testing
* In order to test the API - please use the postman file that is part of the repository (recruitment-task.postman_collection.json)

### TODO
* Add sidekiq and redis in order for the ReservationWorker to run,
* Supplement and fix specs,
* Add users with auth,
* Supplement necessary ENVs and configs,
* Deploy
