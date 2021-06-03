require 'rails_helper'

describe 'Account Management' do
  context 'Registration' do
    it '- Should be able register a user with email and password' do
      visit root_path
      click_on 'Registrar-me'
      fill_in 'Email', with: 'jane@doe.com.br'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação de Senha', with: '123456'
      click_on 'Criar conta'

      expect(page).to have_text('Login efetuado com sucesso')
      expect(page).to have_text('jane@doe.com.br')
      expect(current_path).to eq(root_path)
      expect(page).to_not have_link('Registrar-me')
      expect(page).to have_link('Sair')
    end

    it '- Should be able register a user with valid fields email and password' do
      visit root_path
      click_on 'Registrar-me'
      fill_in 'Email', with: 'jane_doe.com.br'
      fill_in 'Senha', with: '123'
      fill_in 'Confirmação de Senha', with: '123'
      click_on 'Criar conta'

      expect(page).to have_text('Senha é muito curto')
      expect(page).to_not have_text('Login efetuado com sucesso')
      expect(page).to_not have_link('Sair')
    end

    it '- Should not be able to register if password not match confirmation' do
      visit root_path
      click_on 'Registrar-me'
      fill_in 'Email', with: 'jane@doe.com.br'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação de Senha', with: '654321'
      click_on 'Criar conta'

      expect(page).to have_text('Confirmação de Senha não é igual a Senha')
      expect(page).to_not have_text('Login efetuado com sucesso')
      expect(page).to have_link('Registrar-me')
    end

    it '- Should not be able to register if email is already in use' do
      user = User.create!(email: 'jane@test.com.br', password: '123456')
  
      visit root_path
      click_on 'Registrar-me'
      fill_in 'Email', with: 'jane@test.com.br'
      fill_in 'Senha', with: '123456'
      fill_in 'Confirmação de Senha', with: '123456'
      click_on 'Criar conta'

      expect(page).to have_text('Email já está em uso')
      expect(page).to_not have_text('Login efetuado com sucesso')
      expect(page).to_not have_link('Sair')
    end
  end

  context 'Sign in' do
    it '- Should be able to sign in a user with valid email and password' do
      User.create!(email: 'jane@doe.com.br', password: '123456')

      visit root_path
      click_on 'Entrar'
      fill_in 'Email', with: 'jane@doe.com.br'
      fill_in 'Senha', with: '123456'
      within 'form' do
        click_on 'Entrar'
      end

      expect(page).to have_text('Login efetuado com sucesso')
      expect(page).to have_text('jane@doe.com.br')
      expect(current_path).to eq(root_path)
      expect(page).to_not have_link('Registrar-me')
      expect(page).to_not have_link('Entrar')
      expect(page).to have_link('Sair')
    end

    it '- Should not be able to sign in without valid field' do
      User.create!(email: 'jane@doe.com.br', password: '123456')

      visit root_path
      click_on 'Entrar'
      fill_in 'Email', with: 'jane@doe.com.br'
      fill_in 'Senha', with: '123'
      within 'form' do
        click_on 'Entrar'
      end

      expect(page).to have_text('Email ou senha inválida')
      expect(page).to_not have_text('Login efetuado com sucesso')
    end
  end

  context 'Logout' do
    it '- Should be able to logout a user' do
      user = User.create!(email: 'jane@test.com.br', password: '123456')

      login_as user, scope: :user
      visit root_path
      click_on 'Sair'

      expect(page).to have_text('Saiu com sucesso')
      expect(page).to_not have_text('jane@test.com.br')
      expect(current_path).to eq(root_path)
      expect(page).to_not have_link('Registrar-me')
      expect(page).to have_link('Entrar')
      expect(page).to_not have_link('Sair')
    end
  end
end