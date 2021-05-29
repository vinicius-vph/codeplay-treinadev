require 'rails_helper'

describe 'Admin registers courses' do
  it '- Should be access courses from index page' do
    visit root_path
    click_on 'Ver Cursos'

    expect(page).to have_link('Registrar um Curso',
                              href: new_course_path)
  end

  it '- Should be able create a course with instructor and see last created' do
    instructor = Instructor.create!(name: 'Jonh Doe', email: 'jonh@doe.com')

    visit root_path
    click_on 'Ver Cursos'
    click_on 'Registrar um Curso'

    fill_in 'Nome', with: 'Ruby on Rails'
    fill_in 'Descrição', with: 'Um curso de Ruby on Rails'
    fill_in 'Código', with: 'RUBYONRAILS'
    fill_in 'Preço', with: '30'
    fill_in 'Data limite de matrícula', with: '22/12/2033'
    select "#{instructor.name} - #{instructor.email}", from: 'Instrutor(a)'
    attach_file 'Banner', Rails.root.join('tmp/img/teste.png')
    click_on 'Criar curso'

    expect(current_path).to eq(course_path(Course.last))
    expect(page).to have_content('Ruby on Rails') 
    expect(page).to have_content('Um curso de Ruby on Rails')
    expect(page).to have_content('RUBYONRAILS')
    expect(page).to have_content('R$ 30,00')
    expect(page).to have_content('22/12/2033')
    expect(page).to have_css('img[src*="teste.png"]')
    expect(page).to have_link('Voltar')
  end

  it '- Should be able to see that course attributes cannot be blank' do
    visit root_path
    click_on 'Ver Cursos'
    click_on 'Registrar um Curso'
    click_on 'Criar curso'

    expect(page).to have_content('não pode ficar em branco', count: 3)
    expect(page).to have_content('Instrutor(a) é obrigatório(a)')
  end

  it '- Should be able to see that a course code must be unique' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033', instructor: instructor)

    visit root_path
    click_on 'Ver Cursos'
    click_on 'Registrar um Curso'
    fill_in 'Código', with: 'RUBYBASIC'
    click_on 'Criar curso'

    expect(page).to have_content('já está em uso')
  end
end