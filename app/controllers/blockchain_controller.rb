class BlockchainController < ApplicationController

  def index
    @blocks = Block.all
  end
end