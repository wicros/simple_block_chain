class BlockchainController < ApplicationController

  def home; end

  def index
    @blocks = Block.includes(:transactions).all
  end

  def new
    Block.new.mine_block
    redirect_to action: "index"
  end

  def valid
    render plain: Block.all.each_cons(2).all? { |a, b| a.current_hash == b.previous_hash }
  end

end