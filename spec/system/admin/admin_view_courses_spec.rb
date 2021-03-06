require 'rails_helper'

describe 'Admin view courses' do
  it '- Should be able create a course' do
    instructor = Instructor.create!(name: 'Jonh Doe', email: 'jonh@doe.com')
    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033', instructor: instructor)
    Course.create!(name: 'Ruby on Rails',
                   description: 'Um curso de Ruby on Rails',
                   code: 'RUBYONRAILS', price: 20,
                   enrollment_deadline: '20/12/2033', instructor: instructor)

    user_login
    visit root_path
    click_on 'Ver Cursos'

    expect(page).to have_content('Ruby')
    expect(page).to have_content('Um curso de Ruby')
    expect(page).to have_content('R$ 10,00')
    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content('Um curso de Ruby on Rails')
    expect(page).to have_content('R$ 20,00')
  end

  it '- Should be able create a course and view details' do
    instructor = Instructor.create!(name: 'Jonh Doe', email: 'jonh@doe.com')
    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033', instructor: instructor)
    Course.create!(name: 'Ruby on Rails',
                   description: 'Um curso de Ruby on Rails',
                   code: 'RUBYONRAILS', price: 20,
                   enrollment_deadline: '20/12/2033', instructor: instructor)
    
    user_login    
    visit root_path
    click_on 'Ver Cursos'
    click_on 'Ruby on Rails'

    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content('Um curso de Ruby on Rails')
    expect(page).to have_content('RUBYONRAILS')
    expect(page).to have_content('R$ 20,00')
    expect(page).to have_content('20/12/2033')
  end

  it '- Should be able to see no course available' do
    user_login
    visit root_path
    click_on 'Ver Cursos'

    expect(page).to have_content('Nenhum curso dispon??vel')
  end

  it '- Should be able return to home page' do
    instructor = Instructor.create!(name: 'Jonh Doe', email: 'jonh@doe.com')
    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033', instructor: instructor)
    
    
    user_login
    visit root_path
    click_on 'Ver Cursos'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  it '- Should be able return to promotions page' do
    instructor = Instructor.create!(name: 'Jonh Doe', email: 'jonh@doe.com')
    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033', instructor: instructor)
    
    user_login
    visit root_path
    click_on 'Ver Cursos'
    click_on 'Ruby'
    click_on 'Voltar'

    expect(current_path).to eq admin_courses_path
  end

  it '- Should be able create a course with banner' do
    instructor = Instructor.create!(name: 'Jonh Doe', email: 'jonh@doe.com')

    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
      code: 'RUBYBASIC', price: 100,
      enrollment_deadline: '22/12/2033', instructor: instructor)

    Course.create!(name: 'Ruby on Rails',
      description: 'Um curso de Ruby on Rails',
      code: 'RUBYONRAILS', price: 20,
      enrollment_deadline: '20/12/2033',
      instructor: instructor,
      banner: fixture_file_upload(Rails.root.join('tmp/img/teste.png')))
    
    user_login
    
    visit root_path
    click_on 'Ver Cursos'
    click_on 'Ruby on Rails'

    expect(page).to have_css('img[src*="teste.png"]')
    expect(page).to have_content('Jonh Doe')
    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content('Um curso de Ruby on Rails')
    expect(page).to have_content('RUBYONRAILS')
    expect(page).to have_content('R$ 20,00')
    expect(page).to have_content('20/12/2033')

  end
  
  it 'must be logged in to view courses button' do
    visit root_path

    expect(page).to_not have_link('Cursos')
  end

  it 'must be logged in to view courses through route' do
    visit admin_courses_path

    expect(current_path).to eq(new_user_session_path)
  end

  it 'must be logged in to view courses detail through route' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', instructor: instructor)

     visit admin_course_path(course)

     expect(current_path).to eq(new_user_session_path)
  end
end