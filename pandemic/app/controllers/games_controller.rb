class GamesController < ApplicationController

  require 'json'

  def start
    board = GameBoard.new(params[:players].to_i)
    GameFactory.instance.add_game(board)
    render(
      status: 200,
      json: board.to_json
    )
  end

  def infect
    board = GameFactory.instance.get_game(params[:id])
    board.infect
    GameFactory.instance.save_game(board)
    render(
      status: 200,
      json: board.to_json
    )
  end

end
