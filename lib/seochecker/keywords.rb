require 'nokogiri'

module SEOChecker

  class Keywords

    def initialize(path = 'data/keywords.xml')
      @path = path

      load_keywords
    end

    def each(&block)
      if block_given?
        keywords.each do |keyword|
          yield keyword
        end
      else
        enum_for(:each)
      end
    end

    private

    attr_reader :path, :doc

    def keywords
      @keywords ||= doc.xpath('//keywords/keyword').map(&:content)
    end

    def load_keywords
      @doc ||= Nokogiri::XML(xml_document)
    end

    def xml_document
      File.open(path)
    end

  end

end
