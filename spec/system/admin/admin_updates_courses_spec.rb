require 'rails_helper'

describe 'Admin updates courses' do
    it '- Should be able update a course' do
        instructor = Instructor.create!(name: 'Jonh Doe', email: 'jonh@doe.com')
        course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                                 code: 'RUBYBASIC', price: 10,
                                 enrollment_deadline: '22/12/2033', instructor: instructor)
        Instructor.create!(name: 'Jane Doe', email: 'jane@codeplay.com.br')  

        visit admin_course_path(course)
        click_on 'Editar'
        fill_in 'Nome', with: 'Ruby on Rails'
        fill_in 'Descrição', with: 'Um curso de Ruby'
        fill_in 'Código', with: 'RUBYBASIC'
        fill_in 'Preço', with: '30'
        fill_in 'Data limite de matrícula', with: Date.current.strftime('%d/%m/%Y')
        select 'Jane Doe - jane@codeplay.com.br', from: 'Instrutor(a)'
        click_on 'Salvar'

        expect(page).to have_text('Ruby on Rails')
        expect(page).to have_text('Um curso de Ruby')
        expect(page).to have_text('Jane Doe')
        expect(page).to have_text('RUBYBASIC')
        expect(page).to have_text('30')
        expect(page).to have_text(Date.current.strftime('%d/%m/%Y'))
        expect(page).to have_text('Curso atualizado com sucesso')
    end
end