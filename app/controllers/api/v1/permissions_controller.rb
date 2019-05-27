class Api::V1::PermissionsController < Api::V1::ApiController
  before_action :set_permission, only: [:show, :update, :destroy]

  # GET /permissions
  def index
    @permissions = Permission.all

    render json: @permissions
  end

  # GET /permissions/1
  def show
    render json: @permission
  end

  # POST /permissions
  def create
    @permission = Permission.new(permission_params)

    if @permission.save
      render json: @permission, status: :created, location: @permission
    else
      render json: @permission.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /permissions/1
  def update
    if @permission.update(permission_params)
      render json: @permission
    else
      render json: @permission.errors, status: :unprocessable_entity
    end
  end

  # DELETE /permissions/1
  def destroy
    @permission.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_permission
      @permission = Permission.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def permission_params
      params.require(:permission).permit(:title, :description)
    end
end
