# Lunch and Learn (Backend)

## About This Project
### Overview
This project is built to satisfy the requirements of the Turing School of Software and Design's [Lunch and Learn Project](https://backend.turing.edu/module3/projects/lunch_and_learn/requirements). This is the backend repo for an SOA app with a theoretical frontend. It creates endpoints that would send responses to the frontend with aggregated data from multiple external APIs and/or data created and stored in the local database.

### Authentication
Users of this application get authenticated on the backend using functionality from the bcrypt gem. A user is assigned a randomly generated API key upon registration that can be used to favorite recipes.

### Testing
RSpec is utilized as the testing framework, and the VCR gem leverages cassette functionality to stub the testing of external API consumption in fixture files.

## <b>Getting Started</b>

To get a local copy, follow these simple instructions

### <b>Installation</b>

1. Fork the Project
2. Clone the repo 
``` 
git clone git@github.com:lanebret85/lunch_and_learn.git
```
3. Install the gems
```
bundle install
```
4. Create the database
```
rails db:{create,migrate}
```
5. Request your unique API keys at the following links:
- [Edamam](https://developer.edamam.com/edamam-recipe-api) (Requires both an Application ID and an Application Key)
- [YouTube](https://developers.google.com/youtube/v3/getting-started)
- [Unsplash](https://unsplash.com/documentation#getting-started)
6. RAILS CREDENTIALS STEPS
Run this command in the terminal to open your credentials file:
```
$ EDITOR="code --wait" bin/rails credentials:edit
```

Add your API keys to the credentials file, formatted something like this:
```
edamam:
  app_id: 934786012394687
  key: hg39874yt1vfh394uhi
youtube:
  key: fau92ku0s0fd832a7de2
unsplash:
  key: pu20d92k4uyz9d3qp03v
```

You can then call on these API keys anytime like this!:
```
Rails.application.credentials.edamam[:app_id]
Rails.application.credentials.edamam[:key]
Rails.application.credentials.youtube[:key]
Rails.application.credentials.unsplash[:key]
```
7. Run Tests in the terminal to verify everything was set up correctly
```
$ bundle exec rspec
```
- All tests should be passing
8. Run Rails Server from the terminal to verify expected results for endpoint consumption
```
$ rails s
```
- Open a new request in Postman and add the necessary parameters to your request to see the expected response
