class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html do
        @tasks_done = Task.done
        @tasks_pedding  = Task.pedding
      end

      format.csv do
        send_data Task.to_csv
      end
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: 'Tarefa criada com sucesso'
    else
      flash.now[:error] = @task.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'Tarefa atualizada com sucesso'
    else
      flash.now[:error] = @task.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @task.destroy

    redirect_to tasks_path, notice: 'Tarefa removida com sucesso'
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :details, :due_date, :category_id, :done)
  end
end
