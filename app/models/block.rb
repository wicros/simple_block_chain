class Block < ApplicationRecord
  include Concerns::Security
  has_many :transactions

  DIFFICULITY = "0"

  before_create :initialize_hash

  def self.mine_block
    block = new
    block.timestamp = Time.zone.now
    block.previous_hash = Block.last!.current_hash
    work_result = proof_of_work(block)
    block.nonce = work_result[0]
    block.current_hash = work_result[1]
    block.difficulty = DIFFICULITY
    block.save!
  end

  def self.proof_of_work(block)
    nonce = 0
    loop do
      hash = calculate_hash(block, nonce)
      return [nonce, hash] if hash.start_with?(DIFFICULITY)
      nonce += 1
    end
  end
end