class InfectionDeck
  attr_accessor :deck, :discard, :example

  def initialize
    @deck = %w[san_francisco chicago montreal new_york atlanta washington london madrid essen paris milan
                 st_petersburg los_angeles miami bogota lima santiago sao_paulo
                 buenos_aires lagos khartoum kinshasa johannesburg mexico_city algiers istanbul moscow tehran
                 baghdad riyadh karachi delhi mumbai cairo chennai kolkata beijing seoul shanghai tokyo bangkok
                 hong_kong taipei osaka jakarta ho_chi_minh_city manila sydney]
    @deck = @deck.shuffle
    @discard = Array.new
  end

  def get_city_to_infect
    city_to_infect = @deck.pop()
    @discard.push(city_to_infect)
    return city_to_infect
  end

  def get_city_for_epidemic
    city_for_epidemic = @deck.shift()
    @discard.push(city_for_epidemic)
  end

  def intensify
    @discard.shuffle
    @deck.push(*@discard)
  end
end