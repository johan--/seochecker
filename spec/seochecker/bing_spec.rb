require 'spec_helper'

describe SEOChecker::Bing do

  let(:keyword) { 'keyword' }
  let(:bing) { SEOChecker::Bing.new(keyword) }

  describe 'initialization' do
    it 'initializes a new `SEOChecker::Bing` object' do
      expect(bing).to be_a(SEOChecker::Bing)
    end
  end

  describe '#fetch_results' do
    it 'calls `Bing` to fetch results and parses them to return an array of OpenStructs' do
      bing_search = double('Bing')

      title = 'RankAbove: SEO Platform'
      description = 'RankAbove'
      url = 'http://rankabove.com'

      bing_result = {
        Title: title,
        Description: description,
        Url: url
      }

      bing_results = [{ Web: [bing_result] }]

      expect(::Bing).to receive(:new).and_return(bing_search)
      expect(bing_search).to receive(:search).with(keyword, 0).and_return(bing_results)
      expect(bing_search).to receive(:search).with(keyword, SEOChecker::Bing::MAX_RESULTS).and_return([{ Web: [] }])

      results = bing.fetch_results
      result = results.first

      expect(result.index).to eql(0)
      expect(result.title).to eql(title)
      expect(result.content).to eql(description)
      expect(result.uri).to eql(url)
    end
  end

end
