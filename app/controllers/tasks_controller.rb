class TasksController < ApplicationController
  expose(:tasks) { |default| default.order(created_at: :desc) }
  expose(:task, attributes: :task_params)

  def index
    render json: tasks, status: :ok
  end

  def create
    return render json: task, states: :created if task.save
    render json: task.errors.full_messages, status: 422
  end

  def destroy
    task.destroy
    head(204)
  end

  alias update create

  private

  def task_params
    params.require(:task).permit(:name, :description, :done)
  end
end
