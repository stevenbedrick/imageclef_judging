class PoolEntry < ActiveRecord::Base
  belongs_to :pool
  belongs_to :topic
  belongs_to :record
  has_many :judgments
  
  # http://groups.google.com/group/rubyonrails-talk/browse_thread/thread/7f7f715d917b9faa
  def self.with_assoc_conditions(assoc, conditions)
    
    options = reflect_on_association(assoc).options
    orig_conditions = options[:conditions]
    options[:conditions] = conditions
    yield
    options[:conditions] = orig_conditions
    
  end
  
  
  
  def judgmentForUser(usr)
    return Judgment.find_by_pool_entry_id_and_user_id(self.id, usr.id)

  end
  
end
