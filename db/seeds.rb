require "digest"
Block.skip_callback(:create, :before, :initialize_hash)
block = Block.new
block.previous_hash = "0"
block.nonce = 0
block.timestamp = Time.zone.now
block.status = "verified"
block.current_hash = Digest::SHA256.hexdigest(block.id.to_s +
                                      block.timestamp.to_s +
                                      block.transactions.count.to_s +
                                      block.transactions.to_json +
                                      block.previous_hash +
                                      block.nonce.to_s
)
block.save!
Block.set_callback(:create, :before, :initialize_hash)
