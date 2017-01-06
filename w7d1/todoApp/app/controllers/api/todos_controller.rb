class Api::TodosController < ApplicationController
  before_action :get_todo, only: [:show, :update, :destroy]

  def show
    render json: @todo
  end

  def index
    render json: Todo.all
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      render json: @todo
    else
      render json: @todo.errors.full_messages, status: 422
    end
  end

  def update
    if @todo.update(todo_params)
      render json: @todo
    else
      render json: @todo.errors.full_messages, status: 422
    end
  end

  def destroy
    @todo.destroy
    render json: @todo
  end

  private

  def todo_params
    params.require(:todo).permit(:body, :title, :done)
  end

  def get_todo
    @todo = Todo.find(params[:id])
  end
end
