# As of 2018-11 define structs in one file for now.

Struct.new('UserAuthentication', :user, :status) do

  def user_available
    user.present?
  end
end
