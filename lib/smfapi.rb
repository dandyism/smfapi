require "smfapi/version"

# TODO: Should probably go in another file.
class Class
  def attr_populate(*args)
    # TODO: Make sure arguments are actually symbols

    args.each do |arg|
      self.class_eval("def #{arg};populate_#{arg};@#{arg};end")
    end
  end
end


module SMFAPI
  class SMFForum

    attr_populate :subforums

    def initialize(name, url)
      @name = name
      @url = url
      @url = "http://" + @url unless @url.start_with? "http"
      @agent = Mechanize.new
    end

    def populate_subforums
      unless @subforums_populated
        page = @agent.get @url
        nodes = page.search('//h4/a[contains(@href,"board=")]')
        @subforums = []
        nodes.each do |node|
          subforum = SMFForum.new node.inner_text, node['href']
          @subforums << subforum
        end
        @subforums_populated = true
      end

      @subforums
    end
   
  end

end
