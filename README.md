# SEO Checker

This applications queries Google and Bing to check what websites are returned
as top results for predefined queries (parsed from XML file).


## Installation

You need to create a new MySQL database. You can do that with the following command:

```bash
mysql --default-character-set=UTF8 -h localhost -u root -p < config/database.sql
```


## Caveats

* Google returns only 64 results; This is Google limitation and I haven't
  found an easy way to bypass it (although I'm sure there is one)
* There should be a config/database.yml file with database access credentials
  (since my local MySQL installation has an empty root password, I decided
  to skip it).
