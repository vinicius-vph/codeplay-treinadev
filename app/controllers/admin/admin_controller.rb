class Admin::AdminController < ActionController::Base
    before_action :authenticate_user!
    
    layout 'admin'

    def index
      @courses = Course.available.min_to_max    
      render 'admin/index' 
    end
end