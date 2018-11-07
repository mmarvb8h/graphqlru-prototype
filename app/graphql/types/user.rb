module Types
  class User < BaseObject

    field :id, ID, null: false,
      description: "unique db id."
    field :email, String, null: false,
      description: "email address."
    field :name, String, null: false,
      description: "email address owner."
  end
end
