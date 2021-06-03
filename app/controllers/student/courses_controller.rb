class Student::CoursesController < Student::StudentController 
    before_action :set_course, only: %i[show enroll]

    def index
      @courses = Course.all
    end

    def show
    end
  
    def enroll
      current_student.enrollments.create!(course: @course, price: @course.price)
      redirect_to my_courses_courses_path, notice: 'Curso comprado com sucesso'
    end
  
    def my_courses
      @enrollments = current_student.enrollments
    end
  
    private
  
    def set_course
      @course = Course.find(params[:id])
    end
  
    # def course_params
    #   params
    #     .require(:course)
    #     .permit(:name, :description, :code, :price, :instructor_id,
    #             :enrollment_deadline, :banner)
    # end
  end