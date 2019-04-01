require "digest"
module Concerns::Security
  extend ActiveSupport::Concern

  def calculate_hash(nonce)
    Digest::SHA256.hexdigest(self.timestamp.to_s +
                               self.transactions.count.to_s +
                               self.transactions.to_json +
                               self.previous_hash +
                               nonce.to_s)
  end

  def generate_key_pair
    OpenSSL::PKey::RSA.new 2048
  end

  def hash_text(transaction)
    Digest::SHA256.hexdigest [transaction.from, transaction.to, transaction.amount].join
  end

  def sign(private_key)
    Base64.encode64(OpenSSL::PKey::RSA.new(private_key).private_encrypt(hash_text(self)))
  end

  def plaintext(signature, public_key)
    OpenSSL::PKey::RSA.new(public_key).public_decrypt Base64.decode64(signature)
  end

  def valid_signature?
    hash_text(self) == plaintext(self.signature, self.from)
  end

end