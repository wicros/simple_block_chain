class Block < ApplicationRecord
  include Concerns::Security
  has_many :transactions
  STATUS = { verified: "verified", unverified: "unverified" }.freeze

  before_create :initialize_hash

  private

  def initialize_hash
    self.previous_hash = Block.find(id - 1).current_hash
    self.timestamp = Time.zone.now
    self.nonce = calculate_nonce
    self.hash = calculate_hash(self)
    self.status = STATUS[:unverified]
  end
end