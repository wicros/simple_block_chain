require "digest"
module Concerns::Security
  extend ActiveSupport::Concern

  def calculate_hash(block)
    Digest::SHA256.hexdigest(block.id.to_s +
                               block.timestamp.to_s +
                               block.transactions.count.to_s +
                               block.transactions.to_json +
                               block.previous_hash +
                               block.nonce.to_s)
  end

  def calculate_nonce
    Random.new.rand(100)
  end
end