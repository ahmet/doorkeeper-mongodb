# frozen_string_literal: true
case DOORKEEPER_ORM.to_s
when /mongoid/
  class User
    include Mongoid::Document
    include Mongoid::Timestamps

    field :name, type: String
    field :password, type: String
  end
when "mongo_mapper"
  class User
    include MongoMapper::Document
    timestamps!

    key :name,     String
    key :password, String
  end
end

class User
  if ::Rails.version.to_i < 4 || defined?(::ProtectedAttributes)
    attr_accessible :name, :password
  end

  def self.authenticate!(name, password)
    User.where(name: name, password: password).first
  end
end
