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

    visit admin_course_path(course)

    expect(page).to have_link('Classes e Objetos')
    expect(page).to have_text('10 minutos')
    expect(page).to have_link('Orientação a Objetos')
    expect(page).to have_text('1 minuto')
    expect(page).to_not have_text('Uma aula para não ver')
    expect(page).to_not have_text('40 minutos')
  end

  it '- Should be not have lessons' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
      email: 'fulano@codeplay.com.br')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
      code: 'RUBYBASIC', price: 10,
      enrollment_deadline: '22/12/2033',
      instructor: instructor)

    visit admin_course_path(course)
    expect(page).to have_content('Esse curso ainda não tem aulas cadastradas')
  end

  it '- Should be able to see lessons details' do
    user = User.create!(email: 'john.doe@test.com.br', password: '123456')
    instructor = Instructor.create!(name: 'Jonh Doe',
      email: 'jonh@doe.com')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
      code: 'RUBYBASIC', price: 10,
      enrollment_deadline: '22/12/2033',
      instructor: instructor)

    lesson = Lesson.create!(name: 'Classes e Objetos', duration: 10,
      content: 'Uma aula de Ruby', course: course)
    
    login_as user, scope: :user
    visit admin_course_path(course)
    click_on lesson.name

    expect(page).to have_text(lesson.name)
    expect(page).to have_text("#{lesson.duration} minutos")
    expect(page).to have_text(lesson.content)
    expect(page).to have_link('Voltar', href: admin_course_path(course))

  end
end