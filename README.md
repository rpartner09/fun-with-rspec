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
  gem "factory_girl_rails", "~> 4.0"
end
```

Run bundler:

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


Make sure the `Comment` model has: `belongs_to :link` and the `Link` model has: `has_many :comments`

_Note that in this migration we have used link_id:integer, instead of link:belongs_to. Both are valid, but I wanted to show you choice. It never hurts to be more specific, and a bit aware of what is going on under the hood. But by the same measure, you don't want to waist your time doing trivial tasks that the framework can handle for you._

Run migrations:
	
	$ bundle exec rake db:migrate 

## Part 2 
Let's write some specs! Rememeber, while some of these tests may seem trivial (and to be honest, they may be, because of the novice level we are at.), keep in mind we are writing a specification of how our object model will work. So that we can reference it later. As a second bonus, you'd be surprised at the bugs these tests catch later on in your code lifecycle. 

Edit your `spec/models/user_spec.rb` to look like this: https://github.com/CUNY-TAP/fun-with-rspec/commit/84ce6b6a46ed8cfc0caa240f294d5188db67c479#diff-12b107c16792b9ecba685e51b51826f1

Run the specs
	$ bundle exec rspec

You should see the following output:

	4 examples, 0 failures, 1 pending

It seems like we may want to use the user object in more places, and possibly in more tests. Let's use some of the rspec and factory_firl framework to make this more DRY ("Don't Repeat Yourself"). 

Since we are using the factory girls gem, the User factory should already have been created for us when we used the model generator. Awesome! Let's update the factory to be a little more useful to our purposes. 

Edit the `spec/factories/users.rb` file to look like this:
```
FactoryGirl.define do
  factory :user do
  	first_name "Fred"
  	last_name "Stevens"
  	email "fred@gmail.com"
  end
end
```

Edit the `before` block to use the Factory:

	@user = FactoryGirl.create(:user)

Run the specs, should see the same tests passing. Progress! Now we have a _scientific_ benchmark to know that our changes and small improvments (which we often call refactoring) haven't broken anything. 

Okay, let's add to our user spec. 

Add the following test: 
```
it "has a fullname" do
  @user.fullname.should == "Fred Stevens"
end
```

If you run specs (`bundle exec rspec`), you should get an error, something like this: 
```
Failures:

  1) User has a fullname
     Failure/Error: @user.fullname.should == "Fred Stevens"
     NoMethodError:
       undefined method `fullname' for #<User:0x007fd49e34e3e0>
     # ./spec/models/user_spec.rb:21:in `block (2 levels) in <top (required)>'

Finished in 0.01588 seconds
5 examples, 1 failure, 1 pending

Failed examples:

rspec ./spec/models/user_spec.rb:20 # User has a fullname
```
Okay, we have a red light: it's telling us that the User object does not have a method named "fullname." Sweet, fix that!

Add the following to the user model (`app/models/user.rb`): 
```
def fullname
  return first_name + " " + self.last_name
end
```

At this point your code should be similar to this: https://github.com/CUNY-TAP/fun-with-rspec/blob/e9c916ce04ab6f55a52f30fe439465d079e17cae/app/models/user.rb

And this:
https://github.com/CUNY-TAP/fun-with-rspec/blob/e9c916ce04ab6f55a52f30fe439465d079e17cae/spec/models/user_spec.rb 


Save and re-run specs. Green light? Yes! But, wait, let's refactor a bit. We should take advantage of ruby's syntax goodness (otherwise known as "syntactic sugar").

The string concatenation is tedious, so lets use string interpolation. And, we don't need to explicitly say `return` (though it is good practice to do so if you are unsure), since a ruby funciton will always return the last statement of the function. 



Refactor your full name method to look like this. 
```
def fullname
  "#{first_name} #{last_name}"
end
```
Save and rerun specs. We still have a green light!

Okay, let's define the factories for our other models, and make a few more useful tests. And while we are at it, let's make the factories reflect the relationships of the objects. Read more about factory_girl here [https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md]

Update the links factory to look like: 
```
FactoryGirl.define do
  factory :link do
  	url "http://myfavorite.com/thing"
  	score 0
  end
end
```

And now, let's add a relationship to the users factory like this (don't worry too much about the syntax right now, just know how powerful this is!): 
```
FactoryGirl.define do
  factory :user do
  	first_name "Fred"
  	last_name "Stevens"
  	email "fred@gmail.com"
  end

  factory :user_with_link, parent: :user do
  	after(:create) do |user|
  	  FactoryGirl.create(:link, user:user)
  	end
  end
end
```


And lastly let's add a relationship to the links factory:
```
FactoryGirl.define do
  factory :link do
  	url "http://myfavorite.com/thing"
  	score 0
  end

  factory :link_with_comment, parent: :link do
  	after(:create) do |link|
  	  FactoryGirl.create(:comment, link:link)
  	end
  end
end
```

Let's test our relationship. Update your user_spec to have the following test: 
```
  context "with a link" do
    before(:each) do
      @user = FactoryGirl.create(:user_with_link)
    end
    it "has a link" do
      @user.links.count.should == 1
    end
  end
```  
Notice we used a context block here. The idea is that the context is a little different. The scenario, as it were, is a little different. Users with posts, and users without posts might have different requirements and different behaviors. Another good way to think about this is you start very simple, and basic--and then slowly add on more specific tests/code. 
Run tests... and .... GREEN LIGHT! 

## Part 3

It's time for you to write your own tests and implementations! I've added pending specs to the links and comments specs. It will be your job to suss out what and where implementation is necessary. 

The pending tests will look like 

	it "does something useful"

Make sure to turn them into actual blocks:
```
	it "does something useful" do
		##some code I actually wrote
		## man this test is super tight!
	end 
```

## Extra Credit
Try implementing a bank account object model, and it's requisite specs. Or if there is another object model you'd like to try, give it a shot. Point out the models/specs in your pull request comments. 
