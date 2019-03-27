class TransactionsController < ApplicationController

  def index
    @transactions = Transaction.where(status: Transaction::STATUS[:unverified])
  end

  def new
    @transaction = Transaction.new
  end

  def create
    Transaction.create_with_sign! params
    redirect_to action: "index"
  end

end