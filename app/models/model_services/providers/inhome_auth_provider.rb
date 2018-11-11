require 'json'

module ModelServices::Providers
  class InhomeAuthProvider
    include BCrypt
    
    def to_db(signin_data:)
      ret = {
        arg0: Password.create(signin_data[:password])
      }
      {
        provider_name: 'inhome',
        signin: JSON.fast_generate(ret)
      }
    end

    def authenticate(signin_data:, db_signin:)
      signin_hash = JSON.parse(db_signin)
      pwd_verify = Password.new(signin_hash['arg0'])
      pwd_verify == signin_data[:password]
    end
  end
end
