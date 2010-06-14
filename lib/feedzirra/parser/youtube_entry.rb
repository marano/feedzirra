module Feedzirra
  
  module Parser
    
    class YoutubeEntry
      include SAXMachine
      include FeedEntryUtilities
      element :id
      
      element :title
      element :content, :as => :summary
      element :name, :as => :author

      element :link, :as => :url, :value => :href, :with => { :rel => "alternate" }
      
      element :published
      element :updated
            
      element :"media:player", :as => :url, :value => :url            
      element :"media:content", :as => :content, :value => :url, :with => { :type => "application/x-shockwave-flash" }
      element :"media:keywords", :as => :keyword_list
      element :"yt:duration", :as => :duration, :value => :seconds
      
      elements :category, :as => :keywords, :value => :term, :with => { :scheme => "http://gdata.youtube.com/schemas/2007/keywords.cat" } 
            
      elements :category, :as => :categories, :value => :term, :with => { :scheme => "http://gdata.youtube.com/schemas/2007/categories.cat" }
     
      elements :"media:thumbnail", :as => :thumbnails, :value => :url
      
      def embed_code
        "<object width=\"560\" height=\"340\"><param name=\"movie\" value=\"#{@content}\"></param><param name=\"allowFullScreen\" value=\"true\"></param><param name=\"allowscriptaccess\" value=\"always\"></param><embed src=\"#{@content}\" type=\"application/x-shockwave-flash\" allowscriptaccess=\"always\" allowfullscreen=\"true\" width=\"560\" height=\"340\"></embed></object>"
      end
      
      def thumbnail
        @thumbnails.reject { |t| t !~ /0.jpg/ }.to_s
      end
      
      def media_id
        if @id =~ /http:\/\/gdata.youtube.com\/feeds\/api\/videos\/(\S[^\/?]*)/i
          $1
        elsif @url =~ /http:\/\/www.youtube.com\/watch\?v\=(\S[^(&amp\;)]*)/i
          $1
        else
          ''
        end
      end
      
      def tags
        @keywords || @keyword_list.blank? ? [] : @keyword_list.split(",")
      end
      
    end
  end
end
