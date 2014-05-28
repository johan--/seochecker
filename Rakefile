$:.unshift('./lib')
require 'seochecker'

desc 'Reads keywords from `data/keywords.xml` file, queries Google and Bing, saves results in the database and exports them to a CSV file'
task :run do
  SEOChecker::Checker.new.process
  SEOChecker::Export.new.process

  puts 'The results have been saved to `tmp/positions.csv` file'
end
