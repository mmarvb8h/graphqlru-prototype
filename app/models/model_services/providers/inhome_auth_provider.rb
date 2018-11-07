require 'json'

module ModelServices::Providers
  class InhomeAuthProvider
    include BCrypt
    def to_db(signin_data:)
      ret = {
        arg1: Password.create(signin_data[:user_name]),
        arg0: Password.create(signin_data[:password])
      }
      {
        provider_name: 'inhome',
        signin: JSON.fast_generate(ret)
      }
    end

    def authenticate
    end
  end
end
