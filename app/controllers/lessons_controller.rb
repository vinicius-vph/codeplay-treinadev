class LessonsController < ApplicationController
    def new
        @lessons = Lesson.new
    end
end 
