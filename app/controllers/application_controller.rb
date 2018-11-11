class ApplicationController < ActionController::Base
  before_action :set_user_authentication

  helper_method :current_authentication

  def current_authentication
    @_current_authentication
  end

  def set_user_authentication
    @_current_authentication = verify_user
  end

  def verify_user
    # if we want to change the sign-in strategy, this is 
    # the place to do it
    tok = request.headers['session-token']
    user_id = nil
    if !tok.present?
      if Rails.env.development?
        # For dev testing i may send a user id.
        user_id = id_verification
      end
    end

    unless user_id.present? || tok.present?
      # No user_id or token...
      return Struct::UserAuthentication.new(
        nil,
        'not_avail'
      )
    end

    if tok.present?
      crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
      token = crypt.decrypt_and_verify(tok)
      user_id = token.gsub('user-id:', '').to_i
    end
    # Return user.
    Struct::UserAuthentication.new(
      ::User.find(user_id),
      'success'
    )
  rescue ActiveSupport::MessageVerifier::InvalidSignature, ActiveRecord::RecordNotFound
    Struct::UserAuthentication.new(
      nil,
      'failed'
    )
  end

  def id_verification
    request.headers['dev-header-user']
  end

end
