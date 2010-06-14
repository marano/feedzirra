module Feedzirra
  
  module Parser
  
    class Youtube
      include SAXMachine
      include FeedUtilities
      element :id
      element :updated
      element :title
      element :name, :as => :author
      element :link, :as => :feed_url, :value => :href, :with => { :rel => "http://schemas.google.com/g/2005#feed" }
      element :link, :as => :url, :value => :href, :with => { :rel => "alternate" }
      elements :entry, :as => :entries, :class => YoutubeEntry
 
 
      def self.able_to_parse?(xml) #:nodoc:
        xml =~ /xmlns:yt=\'http:\/\/gdata.youtube.com\/schemas\/2007\'/im
      end
      
    end
  end
end
