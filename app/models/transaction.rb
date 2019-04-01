class Transaction < ApplicationRecord
  include Concerns::Security
  belongs_to :block, optional: true
  STATUS = {verified: "verified", unverified: "unverified"}.freeze

  before_save :create_with_sign

  def create_with_sign
    key_pair = generate_key_pair
    private_key = key_pair.to_pem
    public_key = key_pair.public_key.to_pem
    self.from = public_key
    self.signature = sign(private_key)
  end
end