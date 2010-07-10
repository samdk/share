require 'digest/sha1'

class User < ActiveRecord::Base
  # username, entries, password, salt
  has_many :transactions
  has_many :entries, :through => :transactions
  has_many :paid_entries, :class_name => 'Entry'

  validates_presence_of :username, :crypted_password, :salt

  def generate_salt!
    salt = Digest::SHA1.hexdigest(Time.now.to_s + rand.to_s)
  end

  def generate_crypted_password!(plaintext)
    crypted_password = Digest::SHA1.hexdigest(plaintext + salt) if salt
  end

  def salted_crypted_password!(plaintext)
    generate_salt!
    generate_crypted_password!(plaintext)
  end

  def salted_password(plaintext)
    salt = self.salt ? self.salt : Digest::SHA1.hexdigest(Time.now.to_s + rand.to_s)
    crypted_password = Digest::SHA1.hexdigest(plaintext + self.salt)
  end

  def salted_password!(plaintext)
    self.salt = Digest::SHA1.hexdigest(Time.now.to_s + rand.to_s) unless self.salt
    self.crypted_password = Digest::SHA1.hexdigest(plaintext + self.salt)
  end

  def password_matches?(plaintext)
    self.crypted_password == salted_password(plaintext)
  end

  def total_paid
    sum = 0
    paid_entries.each {|e| sum += e.total}
    sum
  end

  def total_spent
    sum = 0
    entries.each {|e| sum += (e.total / e.users.size) if e.users.include? self}
    sum
  end

end

class Entry < ActiveRecord::Base
  # total, payer, beneficiaries, description
  has_many :transactions
  has_many :users, :through => :transactions
  belongs_to :user
  belongs_to :restaurant_entry

  validates_presence_of :total

  def date
    created_at
  end
end

class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :entry
end

class RestaurantEntry < ActiveRecord::Base
  # entries, tip, tax, description
  has_many :entries

end

