class Api::V1::StudentsController < ApplicationController
  before_action :authorize_account!

  def index
    students = Student.all
    render json: students
  end

  def create
    student = Student.create(student_params)
    render json: student
  end

  def update
    student = Student.find(params[:id])
    student.update(student_params)
    render json: student
  end

  def destroy
    student = Student.find(params[:id])
    student.destroy
    render json: student
  end

  private

  def student_params
    params.require(:student).permit(:name)
  end
end
