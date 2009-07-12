class Topic < ActiveRecord::Base
  belongs_to :topic_set
  has_many :topic_sample_images
end
