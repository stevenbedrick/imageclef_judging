class Judgment < ActiveRecord::Base
  belongs_to :user
  belongs_to :pool_entry
end
