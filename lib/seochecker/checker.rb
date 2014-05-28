class SEOChecker::Checker

  def process
    keywords.each do |keyword|
      google_results(keyword).each do |result|
        create_result('Google', keyword, result)
      end

      bing_results(keyword).each do |result|
        create_result('Bing', keyword, result)
      end
    end
  end

  private

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
