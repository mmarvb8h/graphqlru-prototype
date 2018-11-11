class User < ApplicationRecord

  def auth_provider=(val)
    raise "You can't set this attribute. It is read-only."
  end

  def auth_signin=(signin)
    # Get correct authentication provider.
    provider = ModelServices::Providers::InhomeAuthProvider.new
    hash_to_db = provider.to_db(signin_data: signin)
    # Save auth provider signin stuff. It's up to the
    # provider to give us something we can save.
    self.write_attribute(:auth_provider, hash_to_db[:provider_name])
    super(hash_to_db[:signin])
  end

  def authenticate(signin:)
    provider = ModelServices::Providers::InhomeAuthProvider.new
    provider.authenticate(signin_data: signin, db_signin: self.auth_signin)
  end
end
