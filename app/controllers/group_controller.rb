class GroupController < ApplicationController
  
require 'rubygems' # added jkc
require 'ferret' # added jkc
include Ferret # added jkc
before_filter :login_required


    def index
        #@groups = Group.find(:all)
    end
      
    def showrunnames

		@runsNamesToShow = RunName.find_all_by_group_id(params[:group_id])

    end
      
    def showruns
		begin
		@runsToShow = RunEntriesStat.find_all_by_group_id(params[:group_id], :include => {:run_name => :results})
		rescue
			@test = "Bailed in controller"
			@runsToShow = nil
		end
    end
  
    def showruntopics
        @runID=params[:run_name_id]
        #@runEntriesByTopic = RunEntries.find_all_by_run_name_id(runID)
        @thisRunName=RunName.find_by_id(@runID)[:run_name]
        @runEntriesByTopic=RunEntry.connection.select_rows("select b.iclef_topic_number, a.* from topics b left outer join  (select topics.iclef_topic_number, count(run_entries.id), topics.id from run_entries, topics where run_name_id=#{@runID} and topics.id=run_entries.topic_id group by run_entries.topic_id, topics.iclef_topic_number, topics.id order by topic_id) a on b.id = a.id")
        
        
    end

    def runsSize(run_name_id)
      @runsize=RunEntries.find_all_by_run_name_id(run_name_id)
      
    end
    
	#wjh, Security note: Sample Usage, Disallow SQL Injection attacks
	#def self.authenticate_safely(user_name, password) #example usage
    #find(:first, :conditions => [ "user_name = ? AND password = ?", user_name, password ])
	
    def showrunentries
        topic=params[:topic_id]
        runID=params[:run_name_id]
		@entryToShow = RunEntry.find(:all, :conditions =>{:run_name_id=>runID, :topic_id=>topic}, :order => 'rank asc')

		#Query assumes pool_id = 2 AND that the Qrel_id = 1
		query = "SELECT j.relevance, ret.id, rec.image_local_name, ret.rank, j.user_id, ret.topic_id, po.pool_id
FROM (((((((SELECT ren.id, ren.record_id, ren.rank, ren.topic_id FROM run_entries ren WHERE ren.run_name_id = #{runID} AND ren.topic_id = #{topic}) AS ret
INNER JOIN records AS rec ON (rec.id = ret.record_id))
LEFT OUTER JOIN pool_entries AS po ON (po.record_id = rec.id AND po.topic_id = ret.topic_id AND po.pool_id = 2))
LEFT OUTER JOIN judgments AS j ON (j.pool_entry_id = po.id))
INNER JOIN qrel_entries AS qe ON (
									(j.user_id = qe.user_id OR j.user_id IS NULL)
									AND ret.topic_id = qe.topic_id
									AND qe.qrel_id = 1))
)
) ORDER BY ret.rank ASC"
		@test = RunEntry.connection.select_rows(query)

      @entries = @entryToShow.paginate :page => params[:page], :per_page => 50
	  @new_entries = @test.paginate :page => params[:page], :per_page => 50
    end
    
	def showgroupheader
		@topic=Topic.find(params[:topic_id])
        @topicImages=TopicSampleImage.find_all_by_topic_id(params[:topic_id])
	end
	
	def showgroupframes
		params[:inframes] = true
	end
	
	
	def frame_index
        @groups = Group.find(:all)
    end
	
end
