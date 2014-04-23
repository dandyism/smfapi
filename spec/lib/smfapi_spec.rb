require "spec_helper"

describe SMFForum do

  before :each do
    @agent = Mechanize.new
    index_file = File.new Dir.pwd + '/spec/lib/index.txt'
    stub_request(:any, "forum.com").to_return(index_file)
  end

  it "generates an array of subforums" do
    forum = SMFForum.new "(root)", "forum.com"
    a_request(:any, "forum.com").should_not have_been_made
    forum.subforums.size.should == 17
    a_request(:any, "forum.com").should have_been_made
  end

  it "doesn't populate the subforums more than once" do
    forum = SMFForum.new "(root)", "forum.com"
    forum.subforums
    forum.subforums
    a_request(:any, "forum.com").should have_been_made.times(1)
  end

  it "has subforums with subforums" do
    pending
  end

end
