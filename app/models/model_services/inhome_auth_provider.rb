module Services
  class InhomeAuthProvider
    include BCrypt
    def to_db
      password = Password.create("my grand secret")
      byebug
    end
  end
end

