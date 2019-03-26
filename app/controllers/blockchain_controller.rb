class BlockchainController < ApplicationController

  def home; end

  def index
    @blocks = Block.includes(:transactions).all
  end

  def new
    Block.new.mine_block
    redirect_to action: "index"
  end

end