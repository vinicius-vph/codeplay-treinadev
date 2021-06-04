class Student::StudentController < ActionController::Base
    layout 'student'
    before_action :authenticate_student!

end