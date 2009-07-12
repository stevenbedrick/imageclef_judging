class RecordController < ApplicationController
  
  def show
    
    id = params[:id]
    
    @record = Record.find(id)
    
  end
end
