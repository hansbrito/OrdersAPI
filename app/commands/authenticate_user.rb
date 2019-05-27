class AuthenticateUser
    prepend SimpleCommand
  
    def initialize(email, password)
        @email = email
        @password = password
    end
  
    def call
        _profile_with_permissions = user.attributes.except('password_digest', 'auth_token', 'profile_id').as_json
        _profile_with_permissions['role'] = user.profile.attributes.slice('id', 'title').as_json

        _permissions = []
        user.profile.permissions.select(:id, :title).each do |p|
            _permissions.push(p[:title])
        end
        
        _profile_with_permissions['permissions'] = _permissions
        _profile_with_permissions['auth_token'] = JsonWebToken.encode(user_id: _profile_with_permissions)
        
        return _profile_with_permissions if user
    end
  
    private
  
    attr_accessor :email, :password
  
    def user
        user = User.find_by_email(email)
        return user if user && user.authenticate(password)
        errors.add :user_authentication, 'invalid credentials'
        nil
    end
end