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

    visit root_path
    click_on 'Cursos'

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

    visit root_path
    click_on 'Cursos'
    click_on 'Ruby on Rails'

    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content('Um curso de Ruby on Rails')
    expect(page).to have_content('RUBYONRAILS')
    expect(page).to have_content('R$ 20,00')
    expect(page).to have_content('20/12/2033')
  end

  it '- Should be able to see no course available' do
    visit root_path
    click_on 'Cursos'

    expect(page).to have_content('Nenhum curso disponível')
  end

  it '- Should be able return to home page' do
    instructor = Instructor.create!(name: 'Jonh Doe', email: 'jonh@doe.com')
    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033', instructor: instructor)

    visit root_path
    click_on 'Cursos'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end

  it '- Should be able return to promotions page' do
    instructor = Instructor.create!(name: 'Jonh Doe', email: 'jonh@doe.com')
    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033', instructor: instructor)

    visit root_path
    click_on 'Cursos'
    click_on 'Ruby'
    click_on 'Voltar'

    expect(current_path).to eq courses_path
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

    visit root_path
    click_on 'Cursos'
    click_on 'Ruby on Rails'

    expect(page).to have_css('img[src*="teste.png"]')
    expect(page).to have_content('Jonh Doe')
    expect(page).to have_content('Ruby on Rails')
    expect(page).to have_content('Um curso de Ruby on Rails')
    expect(page).to have_content('RUBYONRAILS')
    expect(page).to have_content('R$ 20,00')
    expect(page).to have_content('20/12/2033')

  end
end