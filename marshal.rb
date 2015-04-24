require 'active_record'
require 'base64.rb'

class Base < ActiveRecord::Base
  self.abstract_class = true
  establish_connection adapter: 'sqlite3', database: 'play_time.db'
end

class User < Base
  connection.create_table table_name, force: true do |t|
    t.string :name
  end

  has_many :roles
end

class Role < Base
  connection.create_table table_name, force: true do |t|
    t.integer :user_id
    t.string :role
  end
end

role = Role.create(role: 'role')
user = User.create(name: 'bob')
user.roles << role
user.save

hash = {user: user, abc: :abc}

hash_s = Marshal.dump(hash)
hash_d = Marshal.load(hash_s)

puts hash.has_key?(:abc)
puts hash_d.has_key?(:abc)
puts hash_d
