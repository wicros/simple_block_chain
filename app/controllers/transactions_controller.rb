class TransactionsController < ApplicationController

  def index
    @transactions = Transaction.all
  end

  def new
    @transaction = Transaction.new
  end

  def create
    Transaction.create!(from: params[:transaction][:from],
                        to: params[:transaction][:to],
                        message: params[:transaction][:message],
                        amount: params[:transaction][:amount].to_i)
    redirect_to controller: "blockchain", action: "home"
  end

end