class Student::StudentController < ActionController::Base
    before_action :authenticate_student!
    
    layout 'student'

    def index
        @courses = Course.available.min_to_max    
        render 'student/index' 
      end
end