module Mixins
  module UserAuthentication

    def authenticate
      authentication = context[:authentication]
      raise ArgumentError.new('AuthenticationError') unless authentication&.user_available
    end

  end
end