module Types
  class SigninVerification < BaseInputObject

    argument :inhome, AuthProviderInhomeSignin, required: false,
      description: "my in-house sign in."

    def get_verification_info
      return inhome.to_signin_hash if inhome.present?
    end

  end
end
