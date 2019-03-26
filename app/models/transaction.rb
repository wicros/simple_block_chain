class Transaction < ApplicationRecord
  belongs_to :block, optional: true
  STATUS = { verified: "verified", unverified: "unverified" }.freeze
end