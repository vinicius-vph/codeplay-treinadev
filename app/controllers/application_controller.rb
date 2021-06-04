class ApplicationController < ActionController::Base
    def after_sign_in_path_for(resource)
        return student_courses_path if student_signed_in?
        return admin_courses_path if user_signed_in?
    end
end
