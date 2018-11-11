module Resolvers
  class AllUsers < BaseResolver
    include Mixins::UserAuthentication

    type [Types::User], null: false

    def resolve()
      xx = authenticate()
      ::User.all
    end
  end
end