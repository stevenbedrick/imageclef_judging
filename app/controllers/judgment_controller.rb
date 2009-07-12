class JudgmentController < ApplicationController
  before_filter :login_required
  def record_relevance_judgement


    poolEntry = PoolEntry.find(params['pool_entry_id'])
    
    confidenceScore = params['confidence']
    
    
    if confidenceScore.nil? or not ([0,1,2].include? confidenceScore.to_i)
      render :text => "Bad confidence score.", :status => 500
      return
    end
    
     

    thisJudg = Judgment.find(:first, :conditions => ["pool_entry_id = ? and user_id = ? ", poolEntry.id, current_user.id])
    
    if thisJudg.nil?
    

      thisJudg = Judgment.new
      
    end

    thisJudg.user_id = current_user.id
    thisJudg.pool_entry_id = poolEntry.id
    thisJudg.relevance = confidenceScore
   
    thisJudg.save
    
    render :text =>'worked'
    
   # render :partial => "mark_relevant", :locals => {:poolEntry_id => poolEntry.id, :confidence => confidenceScore}
        
  end
end
