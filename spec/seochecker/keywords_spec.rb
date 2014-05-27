require 'spec_helper'

describe SEOChecker::Keywords do

  let(:path) { 'spec/fixtures/keywords.xml' }
  let(:keywords) { SEOChecker::Keywords.new(path) }

  describe 'initialization' do
    it 'initializes a new `SEOChecker::Keywords` object' do
      expect(keywords).to be_a(SEOChecker::Keywords)
    end
  end

  describe '#each' do
    context 'when the block is given' do
      it 'yields each element to the block' do
        keywords.each do |keyword|
          expect(keyword).to be_a(String)
        end
      end
    end

    context 'when there is no block' do
      it 'returns an Enumerator' do
        expect(keywords.each).to be_an(Enumerator)
      end

      it "allows you to use returned Enumerator's methods" do
        enumerator = keywords.each

        expect(enumerator.first).to match(/[\w]+/)
        expect(enumerator.count).to be > 1
      end
    end
  end

end
