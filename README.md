# Oriole

This gem is an extension for ActiveRecord in Rails 5. It automatically adds the method `or`, to use after `where` in the context of an ActiveRecord query, similar to how you use `not`. In many cases where your query needs an "OR" operator, this will allow you to write that query in a simpler, more flexible way.

Once you add this gem to your project, the method will be available to use wherever it makes sense. 

## Usage

Previously, you could have this:
```ruby
  Post.where(author_id: [1, 3, 5]).or(Post.where(title: 'Hello'))
```
But this requires you to repeat the part of the scope that both halves of the "or" share (in this case `Post`). This syntax can get messier when that scope is more complex.

You could write the same query this way:
```ruby
  Post.where("author_id IN (1, 3, 5) OR title = 'hello'")
```
This doesn't require repeating the scope, but you don't get to use all of the types of arguments that `where` can take. You're locked into writing raw SQL, no matter how long the statement gets.

This gem allows for another syntax that's useful for when you want a simple OR condition in your query:
```ruby
  Post.where.or({ author_id: [1, 3, 5] }, { title: 'Hello' })
```
It can take 2 or more arguments, where each argument can be anything that you are used to passing to `where`: an array, a hash, a string, etc. And the result is the same.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'oriole', git: 'https://github.com/termsync/oriole.git'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install oriole
```

## Contributing
Initial contributions by Esker, Inc. Feel free to fork, create a PR, etc.

## Tests
To run automated tests, clone the repo. In the repo, run this from the command line:
```bash
$ bin/test
```

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
