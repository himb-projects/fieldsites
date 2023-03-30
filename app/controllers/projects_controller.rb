class ProjectsController < ApplicationController
  before_action :logged_in_user, only: [:show, :index, :new, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all.order('project_name ASC')
    respond_to do |format|
      format.html
      format.csv { send_data @projects.to_csv, filename: "projects-#{Date.today}.csv" }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
    respond_to do |format|
      format.html
      format.csv { send_data @project.sites.to_csv, filename: "project-sites-#{Date.today}.csv" }
    end
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
    if @project.persisted?  && !current_user?(@project.user)
      flash.now[:danger] = "Careful. You are editing someone elses project. Have you talked with " + @project.user.name + " about what you're doing?"
    end
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project }
        format.json { render :show, status: :created, location: @project }
        flash[:success] = "Project was successfully created."
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    @project = Project.find(params[:id])
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project }
        format.json { render :show, status: :ok, location: @project }
        flash[:success] = "Project was successfully updated."
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
      flash[:warning] = "Project was successfully destroyed."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:project_name, :project_details, :permit, :start_date, :end_date, :user_id, project_sites_attributes: [:id, :_destroy, :site_id, site_attributes: [:id, :_destroy, :site_name]])
    end

    # Before filters

    # Confirms the correct user.
    def correct_user
      @user = Project.find(params[:id]).user
      if not (current_user?(@user) or current_user.admin?)
        flash[:danger] = "This isn't your project to edit. Please get in touch with the project Contact listed below."
        redirect_to(project_url)
      end
    end
end
