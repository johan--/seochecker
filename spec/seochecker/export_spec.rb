require 'spec_helper'

describe SEOChecker::Export do

  describe 'ATTRIBUTES' do
    it "holds all result's attributes that are about to be exported" do
      attributes = SEOChecker::Export::ATTRIBUTES

      expect(attributes).to be_an(Array)
      expect(attributes.first).to match(/[\w]+/)
    end
  end

  describe '#process' do
    it 'writes results to CSV file' do
      csv = double('CSV')
      export = SEOChecker::Export.new

      attributes = {
        'site' => 'Google',
        'keyword' => 'SEO',
        'position' => 1,
        'url' => 'http://rankabove.com/',
        'title' => 'RankAbove',
        'description' => 'RankAbove',
      }

      result = double('Result', attributes: attributes)

      SEOChecker::Result.stub_chain(:order, :each).and_yield(result)

      expect(CSV).to receive(:open).and_yield(csv)
      expect(csv).to receive(:<<).with(SEOChecker::Export::ATTRIBUTES)
      expect(csv).to receive(:<<).with(attributes.values)

      export.process
    end
  end

end
