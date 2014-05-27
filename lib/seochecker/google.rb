require 'google-search'

class SEOChecker::Google

  def initialize(keyword)
    @keyword = keyword
  end

  def fetch_results
    @results ||= ::Google::Search::Web.new(query: keyword)
  end

  private

  attr_reader :keyword

end
