module Mutations
  class SigninUser < BaseMutation

    null true

    argument :email, String, required: true,
      description: "email address."
    argument :signin, Types::SigninVerification, required: true,
      description: "sign in to secure user access."

    field :token, String, null: true,
      description: 'Authentication token'
    field :user_identity, String, null: true

    def resolve(email:, signin:)
      byebug
      user = ::User.find_by_email(email)
      return {token: nil, user_identity: nil} unless user
      # User found.
      # Authenticate.
      return unless user.authenticate(signin: signin.get_verification_info)
  
      # Generate and return token.
      # Use Ruby on Rails, ActiveSupport::MessageEncryptor, to build a token.
      # See https://www.howtographql.com/graphql-ruby/4-authentication/
      crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
      {
        token: crypt.encrypt_and_sign("user-id:#{ user.id }"),
        user_identity: email
      }
    end

  end
end