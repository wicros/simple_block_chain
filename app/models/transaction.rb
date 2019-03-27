class Transaction < ApplicationRecord
  include Concerns::Security
  belongs_to :block, optional: true
  STATUS = {verified: "verified", unverified: "unverified"}.freeze

  def sign_valid?
    valid_signature? self
  end

  def self.create_with_sign!(params)
    key_pair = generate_key_pair
    private_key = key_pair.to_pem
    public_key = key_pair.public_key.to_pem
    transaction = new
    transaction.to = params[:transaction][:to]
    transaction.from = public_key
    transaction.amount = params[:transaction][:amount].to_i
    transaction.signature = transaction.sign(transaction, private_key)
    transaction.save!
  end
end