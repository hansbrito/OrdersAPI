class AuthorizeApiRequest
    prepend SimpleCommand
  
    def initialize(headers = {})
      @headers = headers
    end
  
    def call
      user
    end
  
    private
  
    attr_reader :headers
    # Para poder atualizar as permissões precisa refazer o login, caso contrário não serão carregadas. Para não ter esse efeitos teríamos de fazer uma requisição adicional aqui para buscar as permissões a todo tempo
    def user
      @user ||= decoded_auth_token[:user_id] if decoded_auth_token
      @user || errors.add(:token, 'Invalid token') && nil
    end
    
    # decodifica o token enviado no header e envia o hash com os dados. coloquei as permissões no token para obtê-las de forma fácil para validar as permissões de acesso
    def decoded_auth_token
      @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
    end
  
    # extrai o token do header para poder ser decodificado
    def http_auth_header
      if headers['Authorization'].present?
        return headers['Authorization'].split(' ').last
      else
        errors.add(:token, 'Missing token')
      end
      nil
    end
end