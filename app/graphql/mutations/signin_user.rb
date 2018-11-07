module Mutations
  class SigninUser < BaseMutation

    null true

    argument :email, String, required: true,
      description: "email address."
    argument :signin, Types::SigninVerification, required: true,
      description: "sign in to secure user access."

    field :token, String, null: true,
      description: 'Authentication token'
    field :errors, [String], null: false

    def resolve(email:, signin:)
      user = ::User.find(email: email)
      unless user.present?
        # User not found.
        return {
          token: nil,
          errors: [],
        }
      end
      # User found.
      # Generate and return token.

    end

  end
end