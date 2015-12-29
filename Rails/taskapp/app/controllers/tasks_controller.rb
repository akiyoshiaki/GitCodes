class TasksController < ApplicationController

  #projects_controllerのコピペ.
  def create
    #submitでtaskを受け取って…
    #まずprojectを探さないとね…なんかidはxxx_idでとれるっぽいよ。
    @project = Project.find(params[:project_id])
    @task = @project.tasks.create(task_params)

    redirect_to project_path(@project)
  end

  #taskのdestroyだからprojectいらない
  #なんかいろいろアナロジーでできそう…
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    #taskの一覧画面 = projectの詳細画面にゆく
    redirect_to project_path(@task.project_id)
    # redirect_to project_path(params[:project_id])
  end

  def toggle
    #テンプレートを使わないことの宣言
    render nothing: true
    @task = Task.find(params[:id])
    @task.done = !@task.done
    @task.save
  end

  private
    #フォームから指定したパラメータ以外は許可しません、というフィルタリング
    #決まり文句
    def task_params
      params[:task].permit(:title)
    end


end
