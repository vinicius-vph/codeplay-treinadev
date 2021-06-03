class AddStudentToEnrollment < ActiveRecord::Migration[6.1]
  def change
    add_reference :enrollments, :student, null: false, foreign_key: true
  end
end
