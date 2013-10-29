fun-with-rspec
==============

Practice creating ActiveRecord models and using rSpec to test them. 

The goal of this lab is to familiarize yourself with:

* Rails migrations
* ActiveRecord Models
* rSpec specs and tests. 

## Completing the assignment
Follow setup below. As before, you should fork this repo, and submit your work as a pull request against the master branch of this repo.

All console/command line commands include the `$` character to indicate that it is the unix command shell. Make sure you do *NOT* include the `$` when you type the commands. (I also encourage you to type them out, and not copy and paste, so that you internalize what you are infact doing).

## Setup

I recomend you have a specific directory dedicated to your code/class assignments, something like this: 

	$ mkdir code
	$ cd code


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

Make sure the `User` model contains `has_many :links`

Run your migrations to create the tables: 
	
	$ bundle exec rake db:migrate

Oops, looks like we forgot to add password to the user model, lets create a migration to do that: 

	$ bundle exec rails generate migration add_password_to_users

Add the following line inside the `change` method of the migration class:

	add_column :users, :password, :string

Run migrations:
	
	$ bundle exec rake db:migrate 

Create the comments model: 
	
	$ bundle exec rails generate model comment comment:text link_id:integer score:integer

_Note that in this migration we have used link_id:integer, instead of link:belongs_to. Both are valid, but I wanted to show you choice. It never hurts to be more specific, and a bit aware of what is going on under the hood. But by the same measure, you don't want to waist your time doing trivial tasks that the framework can handle for you._

Run migrations:
	
	$ bundle exec rake db:migrate 



