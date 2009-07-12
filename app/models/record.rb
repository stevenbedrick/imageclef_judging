class Record < ActiveRecord::Base
  
    def image_full_path
        "/images/images/"+self.image_local_name
#   "http://ir.ohsu.edu/sniqrs2/images/images/" + self.image_local_name
 #  "C:\\Documents and Settings\\kalpathy\\Desktop\\iclef08\\public\\images\\images" + self.image_local_name
  
  end
end
