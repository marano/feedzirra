require File.join(File.dirname(__FILE__), %w[.. .. spec_helper])

describe Feedzirra::Parser::FlickrEntry do
  before(:each) do
    @item = Feedzirra::Parser::FlickrEntry.parse(sample_flickr_feed).entries.first
  end

  it "should parse the guid" do
    @item.entry_id.should == "tag:flickr.com,2004:/photo/4623307984"
  end

end
