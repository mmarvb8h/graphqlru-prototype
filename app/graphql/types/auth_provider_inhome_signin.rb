module Types
  class AuthProviderInhomeSignin < BaseInputObject

    argument :user_name, String, "name used for authentication", required: true
    argument :password, String, "password", required: true

    def to_signin_hash
      {
        provider_name: 'inhome',
        user_name: user_name,
        password: password
      }
    end
  end
end
