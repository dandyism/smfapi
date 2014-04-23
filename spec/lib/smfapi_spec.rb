require "spec_helper"

describe SMFForum do

  before :each do
    @agent = Mechanize.new
    @forum = SMFForum.new "(root)", "forum.com"

    index_file = File.new Dir.pwd + '/spec/lib/index.txt'
    stub_request(:any, "forum.com").to_return(index_file)

    board_file = File.new Dir.pwd + '/spec/lib/generic_board.txt'
    stub_request(:any, /.*board=.*/).to_return(board_file)
  end

  it "generates an array of subforums" do
    @forum.subforums.size.should == 17
    a_request(:any, "forum.com").should have_been_made
  end

  it "doesn't populate the subforums more than once" do
    @forum.subforums
    @forum.subforums
    a_request(:any, "forum.com").should have_been_made.times(1)
    # NOTE: Assumes the forum's url is unique
  end

  it "recursively populates subforums" do
    last_forum = @forum.subforums.last
    last_forum.subforums.size.should == 2
  end

end
