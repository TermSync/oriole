$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "oriole/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "oriole"
  s.version     = Oriole::VERSION
  s.authors     = ["nbdavies"]
  s.email       = ["nbdavies@gmail.com"]
  s.homepage    = "https://www.github.com/termsync/oriole"
  s.summary     = "Allows cleaner syntax for simple OR conjunctions in ActiveRecord queries"
  s.description = <<~HEREDOC
    This gem adds an `or` method to ActiveRecord::WhereChain (best known for `not`).
    It's intended to allow cleaner syntax when you're writing a query in ActiveRecord
    and you just want to use OR between two or more simple conditions.

    For example:
      Post.where.or({ author_id: [100, 101] }, ["created_at > ?", Date.today])

    The individual arguments match the types/syntax that you would pass to `where`.

    This added method may not be advantageous in all situations. There may still be
    cases where you would prefer to use the standard ActiveRecord.or:

      people_i_trust = User.where(admin: true)
      people_i_respect = User.where(permissions: 888)
      permitted_users = people_i_trust.or(people_i_respect)

    ...or there may be cases where you may still want to write the "OR" condition yourself.
  HEREDOC
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.6"

  s.add_development_dependency "sqlite3"
end
