require 'rails_helper'

describe 'Admin view lessons' do
  it '- Should be able create and view a lesson' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033',
                            instructor: instructor)
    other_course = Course.create!(name: 'Rails', description: 'Um curso de Ruby',
                                  code: 'RAILS', price: 10,
                                  enrollment_deadline: '22/12/2033',
                                  instructor: instructor)
    Lesson.create!(name: 'Classes e Objetos', duration: 10,
                   content: 'Uma aula de Ruby', course: course)
    Lesson.create!(name: 'Orientação a Objetos', duration: 1,
                   content: 'Uma aula sobre Orientação a Objetos', course: course)
    Lesson.create!(name: 'Aula para não ver', duration: 40,
                   content: 'Uma aula sobre Orientação a Objeto', course: other_course)

    visit course_path(course)

    expect(page).to have_link('Classes e Objetos')
    expect(page).to have_text('10 minutos')
    expect(page).to have_link('Orientação a Objetos')
    expect(page).to have_text('1 minuto')
    expect(page).to_not have_text('Uma aula para não ver')
    expect(page).to_not have_text('40 minutos')
  end

  xit 'and does not have lessons' do
  end

  xit 'and view content' do
  end
end