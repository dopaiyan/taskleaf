class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    task = Task.find(params[:id])
    task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{task.name}」を更新しました。"
  end

  def new
    # @はインスタンス変数であり、インスタンス変数はビューからも参照することができる
    @task = Task.new
  end

  def create
    #task_paramsで安全化させてインスタンス化
    @task = Task.new(task_params)
    
    if @task.save
      redirect_to @task, notice: "タスク「#{@task.name}」を登録しました。"
    else
      render :new
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to tasks_url, notice: "タスク「#{task.name}」を削除しました。"
  end
  
  # フォームからの情報が安全かどうかをチェックするメソッド
  private
  def task_params
    params.require(:task).permit(:name, :description)
  end

  
end
