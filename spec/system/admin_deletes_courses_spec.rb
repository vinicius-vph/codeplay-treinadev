require 'rails_helper'

describe 'admin deletes courses' do
    it '- Should be able delete a course' do
        instructor = Instructor.create!(name: 'Jonh Doe', email: 'jonh@doe.com')
        course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                                 code: 'RUBYBASIC', price: 10,
                                 enrollment_deadline: '22/12/2033', instructor: instructor)


        visit course_path(course)
        
        expect { click_on 'Apagar' }.to change {Course.count}.by(-1)
        expect(page).to have_text('Curso apagado com sucesso!')
        expect(current_path).to have_text(courses_path)
    end
end