class Pool < ActiveRecord::Base
  has_many :pool_entries
   has_many :topics, :through => :pool_entries, :uniq => true
end
