class Student::StudentController < ActionController::Base
    before_action :authenticate_student!

    layout 'student'
end