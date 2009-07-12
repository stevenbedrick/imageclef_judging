class TopicSampleImage < ActiveRecord::Base
  belongs_to :topic
  
  def image_full_path
#        "/images/images/"+self.image_local_name
    "/images/topic_images/" + self.image_name
  
  end
end
