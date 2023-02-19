class StudentsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  # GET /students
  def index
    @students = Student.all
    render json: @students
  end

  #GET /Student:id
  def show
    @student = find_student
    render json: @student
  end

  #POST /students
  def create
    @student = Student.create!(student_params)
    render json: @student, status: :created
  rescue ActiveRecord::RecordInvalid => invalid
    render json: { errors: [invalid.record.errors] }, status: :unprocessable_entity
  end

  #UPDATE /students/:id
  def update
    @student = find_student
    @student.update!(student_params)
    render json: @student
  rescue ActiveRecord::RecordInvalid => invalid
    render json: { errors: [invalid.record.errors] }, status: :unprocessable_entity
  end

  #Destroy /student/:id
  def destroy
    @student = find_student
    @student.destroy
    header :no_content
  end

  private
  def render_not_found_response
    render json: { error: "Student not found" }, status: :not_found
  end

  def find_student
    Student.all.find(params[:id])
  end

  def student_params
    params.permit(:name, :major, :age, :instructor_id)
  end

end
