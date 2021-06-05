class HomeController < ApplicationController
    
  layout :verify_layout

    def index
      @courses = Course.available.min_to_max
      if user_signed_in?
        render 'admin/index' 

      elsif student_signed_in?
        render 'student/index' 
      else  
        'application'  
      end
    end
  
    private
  
    def verify_layout
      if user_signed_in?
        'admin' 
      elsif student_signed_in?
        'student'         
      else  
        'application'  
      end
    end
end 
