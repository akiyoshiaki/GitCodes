class ProjectsController < ApplicationController

  #共通項をまとめるよ。
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  #projectsというパスを指定したときのアクションメソッドだよ
  #一覧を表示したいから、複数形のインスタンス変数にデータベースから引っ張ってきたデータを入れるよ。
  def index
    @projects = Project.all
  end

  #これは個々のアイテム(project)を選択した時に呼ばれるよ
  #viewで/projects/:idというリンクを作ったので、:idでfindするよ
  #URL経由で渡されたパラメータを取得するのがparamsメソッドだよ
  def show
  end

  def new
    @project = Project.new
  end

  def create
    #フォームから受け取ってDBに保存して一覧にもどる
    @project = Project.new(project_params)
    #保存時にT/Fが帰ってくるので、それで遷移先を変えるよ。
    if  @project.save
      redirect_to projects_path
    else
      render action: "new"
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  #Edit画面からの更新
  def update
    #一覧 or とどまる
    if @project.update(project_params)
      redirect_to projects_path
    else
      render action: "edit"
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

  private
    #フォームから指定したパラメータ以外は許可しません、というフィルタリング
    #決まり文句
    def project_params
      params[:project].permit(:title)
    end

    def set_project
      @project = Project.find(params[:id])
    end

end
