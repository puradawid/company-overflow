class Invitation < ActiveRecord::Base
  validates :email, email: true
  
  before_create do
    self.secret = generate_secret
  end

  private

  def generate_secret
    o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    (0..50).map { o[rand(o.length)] }.join
  end
end
