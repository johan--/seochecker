require 'spec_helper'

describe SEOChecker::Result do

  it 'is an ActiveRecord object' do
    site = 'Google'
    url = 'http://rankabove.com/'
    result = SEOChecker::Result.new(site: site, position: 1, url: url)

    expect(result.class.ancestors).to include(ActiveRecord::Base)

    expect(result.site).to eql(site)
    expect(result.url).to eql(url)
  end

end
