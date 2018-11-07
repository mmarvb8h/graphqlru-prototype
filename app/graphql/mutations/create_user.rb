module Mutations
  class CreateUser < BaseMutation

    null true

    argument :email, String, required: true,
      description: "email address."
    argument :name, String, required: true,
      description: "owner of email address."
    argument :signin, Types::SigninVerification, required: true,
      description: "sign in to secure user access."

    field :user, Types::User, null: true,
      description: 'The user record created and saved.'
    field :errors, [String], null: false

    def resolve(email:, name:, signin:)
      user = ::User.new(
        {
          email: email,
          name: name,
          auth_signin: signin.get_verification     
        }
      )
      if user.save
        # Successful creation, return the created object with no errors
        {
          user: user,
          errors: [],
        }
      else
        # Failed save, return the errors to the client
        {
          user: nil,
          errors: ['User record not saved, error occurred.']
        }
      end
    end

  end
end