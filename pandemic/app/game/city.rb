class City
  attr_accessor :name, :color, :connecting_cities, :cubes, :has_research_station

  def initialize(name, color)
    @name = name
    @visible_name = name.gsub("_", " ").titleize
    @color = color
    @cubes = {"blue" => 0, "yellow" => 0, "black" => 0, "red" => 0}
    @has_research_station = false
  end

  def add_cube
    add_colored_cube(@color)
  end

  def add_colored_cube(color)
    current_cubes = @cubes[color]
    if (current_cubes == 3)
      return true
    else
      @cubes[color] = current_cubes + 1
      return false
    end
  end

  def add_epidemic_cubes
    previous_count = @cubes[@color]
    @cubes[@color] = 3
    return 3 - previous_count
  end
end