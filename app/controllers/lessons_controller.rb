class LessonsController < ApplicationController
    before_action :set_course, only: %i[new create]
    before_action :set_lesson, only: %i[show]

    def new
        @lesson = Lesson.new
    end

    def show
    end

    def create
        @lesson = @course.lessons.new(lesson_params)
        
        if @lesson.save
            redirect_to @course, notice: 'Aula cadastrada com sucesso'
        else
            render :new
        end
    end

    private

    def set_lesson
        @lesson = Lesson.find(params[:id])
    end
    
    def set_course
        @course = Course.find(params[:course_id])
    end
    
    def lesson_params
        params.require(:lesson).permit(:name, :duration, :content)
    end

end 
