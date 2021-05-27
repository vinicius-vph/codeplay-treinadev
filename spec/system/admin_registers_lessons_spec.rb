require 'rails_helper'

describe 'Admin registers lessons' do
  it '- Should be able create a lesson' do
    instructor = Instructor.create!(name: 'Jonh Doe',
                                    email: 'jonh@doe.com')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', instructor: instructor)

    visit course_path(course)
    click_on 'Registrar uma aula'
    fill_in 'Nome', with: 'Datilografia'
    fill_in 'Duração', with: '10'
    fill_in 'Conteúdo', with: 'Uma aula muito legal'
    click_on 'Cadastrar'

    expect(page).to have_text('Datilografia')
    expect(page).to have_text('10 minutos')
    expect(page).to have_text('Aula cadastrada com sucesso')
    expect(current_path).to eq(course_path(course))
  end

  xit 'and fill and fields' do
  end
end 