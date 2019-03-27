require "digest"
module Concerns::Security
  extend ActiveSupport::Concern

  def calculate_hash(block, nonce)
    Digest::SHA256.hexdigest(block.timestamp.to_s +
                               block.transactions.count.to_s +
                               block.transactions.to_json +
                               block.previous_hash +
                               nonce.to_s)
  end

  def self.generate_key_pair
    OpenSSL::PKey::RSA.new 2048
  end

  def hash_text(transaction)
    Digest::SHA256.hexdigest [transaction.from, transaction.to, transaction.amount].join
  end

  def sign(transaction, private_key)
    Base64.encode64(OpenSSL::PKey::RSA.new(private_key).private_encrypt(hash_text(transaction)))
  end

  def plaintext(signature, public_key)
    OpenSSL::PKey::RSA.new(public_key).public_decrypt Base64.decode64(signature)
  end

  def valid_signature?(transaction)
    hash_text(transaction) == plaintext(transaction.signature, transaction.from)
  end

end