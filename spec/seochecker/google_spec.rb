require 'spec_helper'

describe SEOChecker::Google do

  let(:keyword) { 'keyword' }
  let(:google) { SEOChecker::Google.new(keyword) }

  describe 'initialization' do
    it 'initializes a new `SEOChecker::Google` object' do
      expect(google).to be_a(SEOChecker::Google)
    end
  end

  describe '#fetch_results' do
    it 'calls `Google::Search::Web` to fetch results' do
      google_search = double('Google::Search::Web')

      expect(::Google::Search::Web).to receive(:new).with(query: keyword).and_return(google_search)

      google.fetch_results
    end
  end

end
