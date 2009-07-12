class RunName < ActiveRecord::Base
  belongs_to :group
  has_many :run_entries
  has_many :topics, :through => :run_entries, :uniq => true
  has_many :results


  def mode
    
    if self.visual?
      return "Visual"
    end
    
    if self.mixed?
      return "Mixed"
    end
    
    if self.text?
      return "Text"
    end
    
  end
  
  def mode=(new_mode)
    
    raise ArgumentError unless ['visual','mixed','text'].include? new_mode.downcase
    
    # first, clear out whatever our mode had been:
    
    cur_mode = self.mode
    
    if cur_mode == "Visual"
      self.visual = nil
    end
    
    if cur_mode == "Mixed"
      self.mixed = nil
    end
    
    if cur_mode == "Text"
      self.text = nil
    end
    
    # next, figure out what to do:
    temp = new_mode.downcase
    if temp == 'text'
      self.text = true
    end
    
    if temp == 'visual'
      self.visual = true
    end
    
    if temp == 'mixed'
      self.mixed = true
    end
    
  end
  
  def auto_manual
    
    if self.automatic?
      return "Automatic"
    end
    
    if self.manual?
      return "Manual"
    end
    
  end
  
  def auto_manual=(new_am)
    
    raise ArgumentError unless ['automatic','manual'].include? new_am.downcase
    
    # same as above- first clear out original state
    cur_am = self.auto_manual
    
    if cur_am == "Automatic"
      self.automatic = false
    end
    
    if cur_am == "Manual"
      self.manual = false
    end
    
    temp = new_am.downcase
    
    if temp == "automatic"
      self.automatic = true
    end
    
    if temp == "manual"
      self.manual = true
    end
    
  end

end
