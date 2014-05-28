require 'google-search'

class SEOChecker::Google

  def initialize(keyword)
    @keyword = keyword
  end

  # will return the following structure:
  # [
  #   OpenStruct.new({
  #     index: 0,
  #     uri: ...,
  #     title: ...,
  #     content: ...,
  #     ...
  #   }),
  #   OpenStruct.new({
  #     index: 1,
  #     ...
  #   }),
  #   ...
  # ]
  def fetch_results
    @results ||= ::Google::Search::Web.new(query: keyword)
  end

  private

  attr_reader :keyword

end
