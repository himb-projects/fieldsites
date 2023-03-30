class SitesController < ApplicationController
  before_action :logged_in_user, only: [:show, :index, :new, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  # GET /sites
  # GET /sites.json
  def index
    # @sites = Site.all
    @sites = Site.search(params[:search]).order('site_name ASC')
    # @sites = @sites.paginate(page: params[:page])
    respond_to do |format|
      format.html
      format.csv { send_data @sites.to_csv, filename: "sites-#{Date.today}.csv" }
    end
  end

  # GET /sites/1
  # GET /sites/1.json
  def show
    @site = Site.find(params[:id])
    @projects = @site.projects.order('project_name ASC')
  end

  # GET /sites/new
  def new
    @site = Site.new
  end

  # GET /sites/1/edit
  def edit
    @site = Site.find(params[:id])
    if @site.persisted?  && !current_user?(@site.user)
      flash.now[:danger] = "Careful. You are editing someone elses site. Have you talked with " + @site.user.name + " about what you're doing?"
    end
  end

  # POST /sites
  # POST /sites.json
  def create
    @site = Site.new(site_params)

    respond_to do |format|
      if @site.save
        format.html { redirect_to @site }
        format.json { render :show, status: :created, location: @site }
        flash[:success] = "Site was successfully created."
      else
        format.html { render :new }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sites/1
  # PATCH/PUT /sites/1.json
  def update
    @site = Site.find(params[:id])
    respond_to do |format|
      if @site.update(site_params)
        format.html { redirect_to @site }
        format.json { render :show, status: :ok, location: @site }
        flash[:success] = "Site was successfully updated."
      else
        format.html { render :edit }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    @site = Site.find(params[:id])
    @site.destroy
    respond_to do |format|
      format.html { redirect_to sites_url }
      format.json { head :no_content }
      flash[:warning] = "Site was successfully destroyed."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site
      @site = Site.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def site_params
      params.require(:site).permit(:site_name, :site_description, :latitude, :longitude, :color, :shared, :user_id)
    end

    # Confirms the correct user.
    def correct_user
      @user = Site.find(params[:id]).user
      if not current_user.admin?
        if not current_user?(@user)
          flash[:danger] = "This isn't your site to edit. Please get in touch with the site Contact listed below."
          redirect_to(site_url)
        end
      end
    end

end
