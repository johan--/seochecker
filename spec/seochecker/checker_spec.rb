require 'spec_helper'

describe SEOChecker::Checker do

  describe '#process' do
    it 'processes keywords and stores results in a database' do
      keyword = 'SEO'

      index = 0
      uri = 'http://rankabove.com'
      title = 'RankAbove: SEO Platform'
      content = 'RankAbove'

      google = double('SEOChecker::Google')
      bing = double('SEOChecker::Bing')

      result = OpenStruct.new({
        index: index,
        uri: uri,
        title: title,
        content: content,
      })

      expect(SEOChecker::Keywords).to receive(:new).and_return([keyword])

      expect(SEOChecker::Google).to receive(:new).with(keyword).and_return(google)
      expect(SEOChecker::Bing).to receive(:new).with(keyword).and_return(bing)

      expect(google).to receive(:fetch_results).and_return([result])
      expect(bing).to receive(:fetch_results).and_return([result])

      expect(SEOChecker::Result).to receive(:create).with({
        site: 'Google',
        keyword: keyword,
        position: index + 1,
        url: uri,
        title: title,
        description: content,
      })

      expect(SEOChecker::Result).to receive(:create).with({
        site: 'Bing',
        keyword: keyword,
        position: index + 1,
        url: uri,
        title: title,
        description: content,
      })

      checker = SEOChecker::Checker.new
      checker.process
    end
  end

end
