# ORGANIZER
A site for a billiard club that allows you to book services for a selected time.
## The most difficult task
Model and logic development for booking.
## The most interesting task
The most interesting was to work with elasticsearch and background jobs.
## What could be done if there was more time?
Implementation of the possibility to book services constantly at the same time. UI view of the site.

### To run
- git@github.com:iTechArt-RubyLab/organizer.git
- rails db:create
- rails db:migrate
- rails db:seed
- sudo systemctl start elasticsearch
- redis-server
- sidekiq
- minio server ~/mini0
- rails s
