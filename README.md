# SEO Checker

This applications queries Google and Bing to check what websites are returned
as top results for predefined queries (parsed from XML file).


## Installation

You need to create a new MySQL database. You can do that with the following command:

```bash
mysql --default-character-set=UTF8 -h localhost -u root -p < config/database.sql
```

After that you need to bundle gems:

```bash
bundle install
```


## Usage

### From `irb`

Run `irb`:

```ruby
$:.unshift('./lib')
require 'seochecker'
# loads our app

SEOChecker::Google.new('SEO').fetch_results.each { |result| puts result.uri }
# queries Google for 'SEO' keyword and prints returned urls

SEOChecker::Bing.new('SEO').fetch_results.each { |result| puts result.uri }
# queries Bing for 'SEO' keyword and prints returned urls

SEOChecker::Checker.new.process
# loads keywords from XML file, queries Google and Bing for positions and
# saves results in `results` database table

SEOChecker::Result.all
# prints all results from the database

SEOChecker::Export.new.process
# exports values from `results` table to the tmp/positions.csv file
```


## Caveats

* Google returns only 64 results; This is Google limitation and I haven't
  found an easy way to bypass it (although I'm sure there is one)
* `Result` model doesn't have any validations (it should have them)
* There should be a config/database.yml file with database access credentials
  (since my local MySQL installation has an empty root password, I decided
  to skip it).
