class SEOChecker::Checker

  def process
    keywords.each do |keyword|
      google_results(keyword).each do |result|
        create_result(keyword, result)
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

  def create_result(keyword, result)
    SEOChecker::Result.create({
      site: 'Google',
      keyword: keyword,
      position: result.index + 1, # returned index is 0 indexed
      url: result.uri,
      title: result.title,
      description: result.content,
    })
  end

end
