class RunEntriesStat < ActiveRecord::Base
  set_primary_key "rn_id"
  belongs_to :group
  belongs_to :run_name
end
