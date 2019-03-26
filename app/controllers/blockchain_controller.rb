class BlockchainController < ApplicationController

  def home;
  end

  def index
    @blocks = Block.includes(:transactions).all
  end

  def new
    @block = Block.new
    3.times {@block.transactions.build}
  end

  def create
    ApplicationRecord.transaction do
      @block = Block.new
      params[:block][:transactions_attributes].each do |_, transaction|
        next unless Transaction.vaild_params? transaction
        Transaction.create!(block: @block,
                             from: transaction[:from],
                             to: transaction[:to],
                             message: transaction[:message],
                             amount: transaction[:amount].to_i)
      end
      @block.save!
    end
    redirect_to action: "index"
  end

  def proof_of_work

  end
end