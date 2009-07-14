class PoolController < ApplicationController
  #require 'rubygems' # added jkc
  #require 'ferret' # added jkc
 # include Ferret # added jkc
  before_filter :login_required
  
  
  def index

    puts 'INDEX'
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












    def decide_case_based_or_common
        pool_id = params[:pool_id]
        topic_id = params[:topic_id]

        if pool_id.nil? or pool_id.empty?

              redirect_to :action => "index"
              return
        end
        if topic_id.nil? or topic_id.empty?

              redirect_to :action => "showtopic", :pool_id => pool_id
            return
        end

          #actual decision if casebased or not (topic rs start and end casebased are set in environment.rb)
          iclef_topic_number = Topic.find(topic_id).iclef_topic_number
          if (iclef_topic_number >= ICLEF_TOPIC_NUMBER_CASE_BASED_START and
              iclef_topic_number <= ICLEF_TOPIC_NUMBER_CASE_BASED_END )
               if params[:rsvp]
                 redirect_to :action => "showpoolentries_casebased", :pool_id => pool_id, :topic_id => topic_id, :rsvp => 't'
                return
               else
                  redirect_to :action => "showpoolentries_casebased", :pool_id => pool_id, :topic_id => topic_id
                return
               end
               

           
          else
            if params[:rsvp]
                 redirect_to :action => "showpoolentries", :pool_id => pool_id, :topic_id => topic_id, :rsvp => 't'
                return
               else
                  redirect_to :action => "showpoolentries", :pool_id => pool_id, :topic_id => topic_id
                return
               end

          end
    end #END METHOD







    def showpoolentries_casebased
        @pool_id = params[:pool_id]
        @topic_id = params[:topic_id]

        if @pool_id.nil? or @pool_id.empty?

              redirect_to :action => "index"
              return
        end

          iclef_topic_number = Topic.find(@topic_id).iclef_topic_number
          if (iclef_topic_number < ICLEF_TOPIC_NUMBER_CASE_BASED_START or
              iclef_topic_number > ICLEF_TOPIC_NUMBER_CASE_BASED_END )

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
          @entriesToShow = PoolEntry.find_all_by_pool_id_and_topic_id(@pool_id, @topic_id,:order => "frequency DESC, pool_entries.created_at asc",:include => [:topic, :record, :judgments], :conditions => conds )

        end
#        @entriesToShow = PoolEntry.find_all_by_pool_id_and_topic_id(@pool_id, @topic_id,:order => "frequency DESC",:include => [:topic, :record, :judgments], :conditions => ['judgments.user_id = ?', current_user.id])


        @page_number = params[:page]

        if params[:rsvp]
          @entries = @entriesToShow
        else
          @entries = @entriesToShow.paginate :page => @page_number, :per_page => 20
        end
        @topicImages=TopicSampleImage.find_all_by_topic_id(@topic_id)

        #By Ivan Eggel, 2009-------------------------------------------------------------------------

       @records_by_article_url = {} #Hashmap (key: article_url, value: records contained in the article)
       for entry in @entries
          record  = entry.record

          #all image-records that contains the article_url (from the pool_entry record)
          records = Record.find_all_by_article_url(entry.record.article_url,
            :conditions => 'records.figure_id is not null')

        @records_by_article_url[record.article_url]= records

       end
       #-----------------------------------------------------------------------------------------
        if params[:rsvp]
          render :action => "rsvp_show_pool_casebased"

          return
        end

    end




end
