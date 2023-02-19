class InstructorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  # GET /instructors
  def index
    @instructors = Instructor.all 
    render json: @instructors
  end

  # UPDATE /instructors/:id
  def update
    @instructor = find_instructor
    @instructor.update!(instructor_params)
    render json: @instructor
  rescue ActiveRecord::RecordInvalid => invalid
    render json: { errors: [invalid.record.errors] }, status: :unprocessable_entity
  end

  # DELETE /instructors/:id
  def destroy
    @instructor = find_instructor
    @instructor.destroy
    header :no_content
  end

  #SHOW /instructor/:id
  def show
    @instructors = find_instructor
    render json: @instructors
  end

  #POST /instructors
  def create
    @instructor = Instructor.create!(instructor_params)
    render json: @instructor, status: :created
  rescue ActiveRecord::RecordInvalid => invalid
    render json: { errors: [invalid.record.errors] }, status: :unprocessable_entity
  end

  private

  #instructor params
  def instructor_params
    params.permit(:name)
  end

  def find_instructor
    Instructor.all.find(params[:id])
  end

  def render_not_found_response
    render json: { error: "Instructor not found" }, status: :not_found
  end

end
