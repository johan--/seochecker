require 'searchbing'

class SEOChecker::Bing

  MAX_RESULTS = 50

  def initialize(keyword)
    @keyword = keyword
    @results = []
  end

  # will return the following structure (matching the one we have from Google):
  # [
  #   OpenStruct.new({
  #     index: 0,
  #     uri: ...,
  #     title: ...,
  #     content: ...,
  #     ...
  #   }),
  #   ...
  # ]
  def fetch_results
    fetch_first_batch
    fetch_second_batch
    results
  end

  private

  attr_reader :keyword, :results

  def fetch_first_batch
    parse_results(search_bing)
  end

  def fetch_second_batch
    params = { offset: MAX_RESULTS }
    parse_results(search_bing(params), params)
  end

  def parse_results(bing_results, offset: 0)
    bing_results.first[:Web].each_with_index do |element, index|
      result = OpenStruct.new({
        index: index + offset,
        uri: element[:Url],
        title: element[:Title],
        content: element[:Description],
      })

      results << result
    end
  end

  # will return the following structure (only "interesting" fields are shown here):
  #  [
  #    {
  #      Title: ...,
  #      Description: ...,
  #      Url: ...,
  #    },
  #    ...
  #  ]
  def search_bing(offset: 0)
    bing.search(keyword, offset)
  end

  def bing
    @bing ||= ::Bing.new('0OR+TwpjWd7MthZ1KelQjhbYL/5PX8QbaVZjVwte80A', MAX_RESULTS, 'Web')
  end

end
