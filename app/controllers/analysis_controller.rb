class AnalysisController < ApplicationController
require 'rubygems'
require 'ferret' 
include Ferret 
before_filter :login_required

	def index
		flash[:notice] = "Flash notice"
	end
	
	def upload_run
		session[:image_array] = nil
	end
	
	
	def view_run
		
		myf = params[:upload][:file] rescue nil
		#Check to see if they uploaded a file
		if myf.class == ActionController::UploadedTempfile and myf.size < 3*10**6
			#Process the file, unless it has already been processed
			@image_array = process_file(myf) unless @image_array
			myf.close
			#update (save) the file to session data
			session[:image_array] = @image_array
		else
			#no file submitted, check for it in session data
			#flash[:notice] = "Within Session"
			@image_array = session[:image_array]
		end
		#Debug...
		#flash[:notice] = "#{myf.class}<BR>#{@image_array.class}<BR>#{@images.class}"
		
		myf = nil
		#params[:upload][:file] = nil if params[:upload][:file]
		
		@topic = 1
		@topic = params[:topic_id].to_i if params[:topic_id]
		
		
		#peter piper paginated pickled pages when there was a pickled page to paginate
		@images = @image_array[@topic].paginate(:page => params[:page], :per_page => 50) if @image_array
		flash[:notice] = Record.connection.select_rows('select id from records where image_local_name = \'r07ja36g01d\'').inspect
	end

private
	def process_file(myf)
		#A named hash array that contains topic #s as hash names,
		#Each topic number containing an array of image names that we
		#Can later access, in order.
		image_names = Hash.new
		
		
		sep = nil
		myf.each do |xx|
			unless sep
				if xx.split(" ").size > 0 then
					sep = " "
				else
					sep = "\t"
				end
			end
			#extract the base name of the image
			base_name = xx.split(sep)[2].sub("images/","")
			topic = xx.split(sep)[0].to_i
			
			if base_name																#If we got an image name
				if base_name.size < 60													#And its not too long, Add it to the array
					image_names[topic] = Array.new unless image_names[topic] 			#Check hash to see if it exists
					image_names[topic].push(base_name)									#push a name to end of hash(Array)
					#The Slower and Safer Route, Need to Speed this up
					#image_names.push(ActiveRecord::Base.sanitize(base_name)) if base_name.size < 60
				end
			end 
		end
		
		#- Sanitize the object before we keep it
		return image_names
	end


end
