class Block < ApplicationRecord
  include Concerns::Security
  has_many :transactions
  accepts_nested_attributes_for :transactions

  STATUS = { verified: "verified", unverified: "unverified" }.freeze

  before_create :initialize_hash

  private

  def initialize_hash
    self.previous_hash = Block.last!.current_hash
    self.timestamp = Time.zone.now
    self.nonce = calculate_nonce
    self.current_hash = calculate_hash(self)
    self.status = STATUS[:unverified]
  end
end