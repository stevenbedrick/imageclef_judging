class RunEntry < ActiveRecord::Base
  belongs_to :run_name
  belongs_to :topic
  belongs_to :record
end
