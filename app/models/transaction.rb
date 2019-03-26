class Transaction < ApplicationRecord
  belongs_to :block

  def self.vaild_params?(params)
    params[:from].present? &&
      params[:to].present? &&
      params[:amount].present?
  end
end