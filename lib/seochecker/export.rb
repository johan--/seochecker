require 'csv'

class SEOChecker::Export

  ATTRIBUTES = ['site', 'keyword', 'position', 'url', 'title', 'description']

  def process
    CSV.open('tmp/positions.csv', 'wb') do |csv|
      write_header(csv)
      write_results(csv)
    end
  end

  private

  def write_header(csv)
    csv << ATTRIBUTES
  end

  def write_results(csv)
    SEOChecker::Result.order(:id).each do |result|
      csv << result.attributes.slice(*ATTRIBUTES).values
    end
  end

end
