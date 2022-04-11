require 'singleton'

class GameFactory
  include Singleton

  @games = {}

  def add_game(game)
    if (@games == nil)
      @games = {}
    end
    @games[game.id] = game
  end

  def get_game(id)
    return @games[id]
  end

  def save_game(game)
    @games[game.id] = game
  end

end
