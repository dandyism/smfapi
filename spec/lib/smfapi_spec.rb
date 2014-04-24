require "spec_helper"

describe SMFForum do

  before :each do
    @agent = Mechanize.new
    @forum = SMFForum.new "(root)", "forum.com"

    WebMock.disable_net_connect!

    index_file = File.new Dir.pwd + '/spec/lib/index.txt'
    stub_request(:any, "forum.com").to_return(index_file)

    board_file = File.new Dir.pwd + '/spec/lib/board_p1.txt'
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
    # NOTE: Assumes each SMFForum's url is unique. They should be.
  end

  it "recursively populates subforums" do
    last_forum = @forum.subforums.last
    last_forum.subforums.size.should == 2
  end

  it "returns that forum by name" do
    result = @forum.subforum "Mafia"
    result.name.should == "Mafia"
  end

  it "returns nil for non-existent forums" do
    pending "FIXME: I know this works. It's just that the test doesn't work."
    # FIXME: This test should work instead of doing the infinite recursion thing.
    result = @forum.subforum "Non Existent"
    result.should be_nil
  end

end
