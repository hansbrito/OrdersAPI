class Api::V1::AuthenticationController < Api::V1::ApiController
    skip_before_action :authenticate_request

    def authenticate
        _command = AuthenticateUser.call(params[:email], params[:password])
        
        if _command.success?
            render json: _command.result
        else
            render json: { :error => _command.errors }, status: :unauthorized
        end
    end
end