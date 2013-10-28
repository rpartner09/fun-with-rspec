fun-with-rspec
==============

Practice creating ActiveRecord models and using rSpec to test them. 

The goal of this lab is to familiarize yourself with:

* Rails migrations
* ActiveRecord Models
* rSpec specs and tests. 

## Completing the assignment
Follow setup below. As before, you should fork this repo, and submit your work as a pull request against the master branch of this repo.

## Setup

I recomend you have a specific directory dedicated to your code/class assignments, something like this: 
```
	$ mkdir code
	$ cd code
```

Make sure you are using rails 4.0:
	$ rvm use ruby-2.0.0 ## or whatever version you have installed. 
	$ rails --version

If you see anything less than 4.0, run the following command: 

	$ gem install rails

Create a new rails project: 

	$ rails new fun-with-rspec

Change to that directory:
	
	$ cd fun-with-rspec

Create an RVM gemset (and use it):

	$ rvm use ruby-2.0.0@fun-with-rspec --create
	$ echo "ruby-2.0.0@fun-with-rspec" > .ruby-version

Set up rails to use rSpec and factory girl: edit your Gemfile to include the following code:
```
group :development, :test do
  gem 'rspec-rails', '~> 2.0'
  gem 'factory_girl'
end
```

Run budler:

	$ bundle

Setup the rspec helper files:

	$ bundle exec rails generate rspec:install

## Part 1
You will now build a basic object model. I will walk you through the first one. We will recreate our reddit clone object model.

Create the user model:

	$ bundle exec rails generate model user email:string first_name:string last_name:string

*Make sure it's creating the `/spec/models/user_spec.rb` file for you. You may have forgotten to run `bundle install`*

Create the status model: 
	
	$ bundle exec rails generate model link url:string user:belongs_to score:integer

Make sure the `Link` model contains `belongs_to :user`

Makre sure the `User` model contains `has_many :links`


