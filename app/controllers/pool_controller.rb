class PoolController < ApplicationController
  require 'rubygems' # added jkc
  require 'ferret' # added jkc
  include Ferret # added jkc  
  before_filter :login_required
  
  
  def index
        
        @pools = Pool.find(:all)
        
    end
      
    def showtopic
      @pool_id=params[:pool_id]
      if @pool_id.nil? or @pool_id.empty?
    
          redirect_to :action => "index"
      return
    end #

          @thisPool=Pool.find_by_id(@pool_id)
          @topics=@thisPool.topics
      
  end
    
  def rsvp_show
    
  end
    
    def showpoolentries
        @pool_id=params[:pool_id]
        @topic_id=params[:topic_id]
        
        if @pool_id.nil? or @pool_id.empty?
    
              redirect_to :action => "index"
              return
        end
        if @topic_id.nil? or @topic_id.empty?
    
              redirect_to :action => "showtopic", :pool_id => @pool_id
            return
      end
        @topic=Topic.find(@topic_id)
        @entriesToShow = []
        
        
      
#          logger.debug 'here!!!!'          
        
        PoolEntry.with_assoc_conditions(:judgments, ['judgments.user_id = ?', current_user.id]) do
          if params[:non_judged] == 't'
            conds = ['judgments.id is null']
          else
            conds = nil
          end
#          @entriesToShow = PoolEntry.find_all_by_pool_id_and_topic_id(@pool_id, @topic_id,:order => "frequency DESC, pool_entries.created_at asc",:include => [:topic, :record, :judgments], :conditions => conds )
          @entriesToShow = PoolEntry.find_all_by_pool_id_and_topic_id(@pool_id, @topic_id,:order => "frequency DESC, pool_entries.id asc",:include => [:topic, :record, :judgments], :conditions => conds )
          
        end
#        @entriesToShow = PoolEntry.find_all_by_pool_id_and_topic_id(@pool_id, @topic_id,:order => "frequency DESC",:include => [:topic, :record, :judgments], :conditions => ['judgments.user_id = ?', current_user.id])

        @page_number = params[:page]

        if params[:rsvp]
          @entries = @entriesToShow
        else
          @entries = @entriesToShow.paginate :page => @page_number, :per_page => 20
        end
        @topicImages=TopicSampleImage.find_all_by_topic_id(@topic_id)
        
        if params[:rsvp]
          render :action => "rsvp_show_pool"
          return
        end
        
    end

    
    def showPoolHeader
        @topic=Topic.find(params[:topic_id])
        @topicImages=TopicSampleImage.find_all_by_topic_id(params[:topic_id])
    end
    

    def showPoolFrames
       render :layout=> false    
    end  

end
