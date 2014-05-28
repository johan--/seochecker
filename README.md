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

### Using `rake`

Execute `rake run` from the command line to read XML keywords, query Google & Bing,
save results in the database and export them to a CSV file.


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

* Google returns only 64 results; I think this is Google's limitation and
  I haven't found an easy way to bypass it (although I'm sure there is one).
* `Result` model doesn't have any validations (it should have them).
* There should be a config/database.yml file with database access credentials
  (since my local MySQL installation has an empty root password, I decided
  to skip it).
* There are no integration/acceptance specs going through the full stack
  (there should be at least one). On the other hand, running this locally
  is a kind of an acceptance test.
* My Bing's API key is hardcoded in the `bing.rb`; Proper way would be to extract
  it into a separate file outside of git (this is intentional, so that you
  can run the app without too many "installation" steps).
* It does not check if Bing returned less than 50 results and will issue
  a second query (with offset = 50), to fetch the 2nd (empty) results page
* It does not use any form of html escaping (valid for the `description` attribute
  mostly), so html tags are stored directly in the database. This is potentially
  a security issue.
* CSV export uses commas, which are also present in `description` field. This is not
  a problem as it's the last field, but there might be a problem if there is a comma
  in the `title` field. Adding some escaping might be helpful.
* Bing uses some magic (probably by geolocating my IP address), to present me
  with results coming mostly from my country. Not sure if that's what you want.
* I'm using threads very conservatively, only spawning two of them (one for each
  search engine). This is intentional as I don't want to hammer search engines.
* There is no error checking whatsoever throughout the app. This is intentional
  as I'm not really a fan of defensive programming. Some error checking will
  probably be needed though, if this was to be something more than an interview
  project ;)

(c) 2014 Paweł Gościcki
