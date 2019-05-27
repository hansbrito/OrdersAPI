class Api::V1::ProfilesController < Api::V1::ApiController
  before_action :set_profile, only: [:show, :update, :destroy]

  # GET /profiles
  def index
    @profiles = Profile.all
    render json: @profiles
  end

  # GET /profiles/1
  def show
    _profile_with_permissions = @profile.as_json
    _profile_with_permissions['permissions'] = @profile.permissions.as_json
    render json: _profile_with_permissions
  end

  # POST /profiles
  def create
    @profile = Profile.new(profile_params)

    if @profile.save
      _profile_with_permissions = @profile.as_json
      _profile_with_permissions['permissions'] = @profile.permissions.as_json
      render json: _profile_with_permissions, status: :created
    else
      render json: @profile.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /profiles/1
  def update
    if @profile.update(profile_params)
      _profile_with_permissions = @profile.as_json
      _profile_with_permissions['permissions'] = @profile.permissions.as_json
      render json: _profile_with_permissions
    else
      render json: @profile.errors, status: :unprocessable_entity
    end
  end

  # DELETE /profiles/1
  def destroy
    @profile.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
      # .joins(:permissions)
      # .select('profiles.id, profiles.title, profiles.description, permissions.title permission_title')
      # .where(id: params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def profile_params
      params.permit(:title, :description, :permission_ids => [])
    end
end
