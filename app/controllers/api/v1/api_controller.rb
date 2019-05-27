module Api::V1
    class ApiController < ApplicationController
        before_action :authenticate_request
        attr_reader :current_user

        private

        # Valida se o usuário tem a permissão apropriada
        # Mudanças nas permissões só são assumidas no re-login porque as permissões são armazenadas no TOKEN para evitar questionar o BD toda hora
        def authenticate_request
            # Troco o SLASH por UNDELINE para não ter que ficar escapando no banco de dados, mas isso desvia um pouco do padrão de regex
            # METHOD_api_v1_RESOURCE
            # METHOD_api_v1_RESOURCE_PARAM
            # METHOD_api_v1_RESOURCE_\d$ <--- FIM DE CURSO
            _replaced = request.method + request.path.to_s.gsub('/', '_') 
            
            _validated = false
            @current_user = AuthorizeApiRequest.call(request.headers).result
            @current_user[:permissions].each do |p|
                _validated = true if _replaced =~ Regexp.new(p)
               break if _validated == true
            end

            render json: { error: 'Not Authorized' }, status: 401 unless _validated
        end
    end
end