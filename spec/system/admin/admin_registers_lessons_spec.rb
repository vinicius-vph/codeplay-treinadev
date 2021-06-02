require 'rails_helper'

describe 'Admin registers lessons' do
  it '- Should be able create a lesson' do
    instructor = Instructor.create!(name: 'Jonh Doe',
                                    email: 'jonh@doe.com')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', instructor: instructor)

    visit admin_course_path(course)
    click_on 'Registrar uma aula'
    fill_in 'Nome', with: 'Datilografia'
    fill_in 'Duração', with: '10'
    fill_in 'Conteúdo', with: 'Uma aula muito legal'
    click_on 'Cadastrar'

    expect(page).to have_text('Datilografia')
    expect(page).to have_text('10 minutos')
    expect(page).to have_text('Aula cadastrada com sucesso')
    expect(current_path).to eq(admin_course_path(course))
  end

  it '- Should be able to see that lesson attributes cannot be blank' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
      email: 'fulano@codeplay.com.br')
      course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
      code: 'RUBYBASIC', price: 10,
      enrollment_deadline: '22/12/2033', instructor: instructor)

    visit admin_course_path(course)
    click_on 'Registrar uma aula'
    click_on 'Cadastrar'

    expect(page).to have_text('Nome não pode ficar em branco')
    expect(page).to have_text('Duração não pode ficar em branco')
    expect(page).to have_text('Conteúdo não pode ficar em branco')
  end
end 