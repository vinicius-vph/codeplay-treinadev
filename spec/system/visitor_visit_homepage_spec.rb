require 'rails_helper'

describe 'Visitor visit homepage' do
   it '- Should be able to access homepage' do
        visit root_path

        expect(page).to have_css('h1', text: 'Codeplay')
        expect(page).to have_css('h2', text: 'Boas vindas ao sistema de gestão de '\
                                        'cursos e aulas')
  end
end