class User < ActiveRecord::Base
  # username, entries, password, salt
  has_many :entries, :through => :transactions
  has_many :entries, :as => :paid_entries

end

class Entry < ActiveRecord::Base
  # total, payer, beneficiaries
  has_many :users, :through => :transactions
  belongs_to :user, :as => :payer
  belongs_to :restaurant_entry

end

class Transaction
  belongs_to :user
  belongs_to :entry
end

class RestaurantEntry < ActiveRecord::Base
  # entries, tip, tax
  has_many :entries

end

