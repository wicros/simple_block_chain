class Block < ApplicationRecord
  include Concerns::Security
  has_many :transactions

  DIFFICULITY = "0"

  def mine_block
    transaction do
      self.timestamp = Time.zone.now
      self.previous_hash = Block.last!.current_hash
      work_result = proof_of_work(self)
      self.nonce = work_result[0]
      self.current_hash = work_result[1]
      self.difficulty = DIFFICULITY
      save!
      Transaction.where(status: Transaction::STATUS[:unverified]).each do |transaction|
        transaction.update!(block: self, status: Transaction::STATUS[:verified])
      end
    end
  end

  private

  def proof_of_work(block)
    nonce = 0
    loop do
      hash = calculate_hash(block, nonce)
      return [nonce, hash] if hash.start_with?(DIFFICULITY)
      nonce += 1
    end
  end
end