module Types
  class AuthProviderInhomeSignin < BaseInputObject

    argument :password, String, "password", required: true

    def to_signin_hash
      {
        provider_name: 'inhome',
        password: password
      }
    end
  end
end
