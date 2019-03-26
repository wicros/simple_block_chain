class BlockchainController < ApplicationController

  def home; end

  def index
    @blocks = Block.includes(:transactions).all
  end

  def create
    Block.mine_block
    redirect_to action: "index"
  end

end