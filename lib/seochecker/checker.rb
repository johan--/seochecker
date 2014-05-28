class SEOChecker::Checker

  def process
    remove_existing_results
    process_keywords
  end

  private

  def remove_existing_results
    SEOChecker::Result.destroy_all
  end

  def process_keywords
    threads = []

    threads << Thread.new { process_google }
    threads << Thread.new { process_bing }

    threads.each { |thread| thread.join }
  end

  def process_google
    keywords.each do |keyword|
      google_results(keyword).each do |result|
        create_result('Google', keyword, result)
      end
    end
  end

  def process_bing
    keywords.each do |keyword|
      bing_results(keyword).each do |result|
        create_result('Bing', keyword, result)
      end
    end
  end

  def keywords
    @keywords ||= SEOChecker::Keywords.new
  end

  def google_results(keyword)
    SEOChecker::Google.new(keyword).fetch_results
  end

  def bing_results(keyword)
    SEOChecker::Bing.new(keyword).fetch_results
  end

  def create_result(site, keyword, result)
    SEOChecker::Result.create({
      site: site,
      keyword: keyword,
      position: result.index + 1, # results are 0-indexed
      url: result.uri,
      title: result.title,
      description: result.content,
    })
  end

end
