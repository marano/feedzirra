module Feedzirra

  module Parser
    
    class FlickrEntry
      include SAXMachine
      include FeedEntryUtilities
      element :guid, :as => :id
      
      element :title
      element :"media:title", :as => :title
      
      element :link, :as => :url
      
      element :pubDate, :as => :published
      element :pubdate, :as => :published
      
      element :"media:description", :as => :summary
      
      element :"media:credit", :as => :author, :with => { :role => "photographer" }
      element :"media:thumbnail", :as => :thumbnail, :value => :url
      
      element :"media:content", :as => :content, :value => :url
      
      element :"media:category", :as => :categories, :with => { :scheme => "urn:flickr:tags" }
      
      def tags
        @categories.blank? ? [] : @categories.split(" ")
      end
      
    end
  end
end
