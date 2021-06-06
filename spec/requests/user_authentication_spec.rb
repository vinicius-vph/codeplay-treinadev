require 'rails_helper'

describe 'User authentication' do
  it 'cannot access create without login' do
    post admin_courses_path, params: { course: { name: 'Ruby' } }

    expect(response).to redirect_to(new_user_session_path)
  end

  it 'cannot access update without login' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033', instructor: instructor)

    patch admin_course_path(course), params: { course: { name: 'Ruby' } }

    expect(response).to redirect_to(new_user_session_path)
  end

  it 'cannot delete without login' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033', instructor: instructor)

    delete admin_course_path(course)

    expect(response).to redirect_to(new_user_session_path)
  end

  it 'cannot create lesson without login' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033',
                            instructor: instructor)

    post admin_course_lessons_path(course), params: { lesson: { name: 'Ruby' } }

    expect(response).to redirect_to(new_user_session_path)
  end
end