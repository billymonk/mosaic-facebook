require File.expand_path('../../spec_helper.rb', __FILE__)

describe Mosaic::Facebook::Graph::Post do
  context "given a page with posts" do
    before(:all) do
      @page = Mosaic::Facebook::Graph::Page.new(:id => RSpec.configuration.page_id)
      # FIXME: limit=10 work-around for facebook bug as per:
      #        https://developers.facebook.com/bugs/525301577527928?browse=search_516709daab5da1453067889
      @posts = @page.feed.all(:access_token => RSpec.configuration.access_token, :limit => 10)
    end

    it "should retrieve the user who posted it" do
      post = @posts.first
      expect(post.from.all).to be_an_instance_of Mosaic::Facebook::Graph::User
      STDERR.puts post.from.all.inspect
    end

    # FIXME: requires a comment to actually exist in the retrieved posts...
    #        maybe find a comment through another means first, and follow it to the post?
    context "and a post with comments" do
      before(:all) do
        @post = @posts.find { |post| post.comments.all.any? }
      end

      it "should retrieve the post's comments" do
        comments = @post.comments.all
        expect(comments).to be_an_instance_of Array
        expect(comments.first).to be_an_instance_of Mosaic::Facebook::Graph::Comment
      end
    end
  end
end
