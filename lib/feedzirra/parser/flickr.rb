module Feedzirra
  
  module Parser
  
    class Flickr
      include SAXMachine
      include FeedUtilities
      element :title
      
      element :link, :as => :url
      element :icon, :as => :avatar

      element :pubDate, :as => :published
      element :pubdate, :as => :published
      element :lastBuildDate, :as => :updated
      
      elements :item, :as => :entries, :class => FlickrEntry
 
      attr_accessor :feed_url
      
      def self.able_to_parse?(xml) #:nodoc:
        xml =~ /xmlns:flickr=\"urn:flickr:\"/im
      end
      
    end
  end
end
