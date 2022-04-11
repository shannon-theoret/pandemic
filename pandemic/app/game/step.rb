class Step

  def initialize(number_of_players)
    @current_step = "infect"
    @current_times = 1
    @infection_rate_scale = [2, 2, 2, 3, 3, 4, 4]
    @infection_rate_index = 0
    @current_plauer = 1
    @number_of_players = number_of_players
  end

  def complete_step
    if (@current_step == "infect")
      if (@current_times < @infection_rate_scale[@infection_rate_index])
        @current_times = @current_times + 1
      else
        @current_step = "plauer_move"
        @current_times = 1
      end
    elsif (@current_step == "player_move")
      if (@current_times < 4)
        @current_times = @current_times + 1
      else
        @current_step = "draw_cards"
        @current_times = 1
      end
    elsif (@current_step == "draw_cards")
      if (@current_times < 2)
        @current_times = @current_times + 1
      else
        @current_step = "infect"
        @current_times = 1
        if (@current_plauer < @number_of_players)
          @current_plauer = @current_plauer + 1
        else
          @current_plauer = 1
        end
      end
    end
  end
end