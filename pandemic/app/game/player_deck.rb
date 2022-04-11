class PlayerDeck

  def initialize()
    @player_deck = []
    @player_discard = []
    @pre_deck = %w[san_francisco chicago montreal new_york atlanta washington london madrid essen paris milan
                 st_petersburg los_angeles miami bogota lima santiago sao_paulo
                 buenos_aires lagos khartoum kinshasa johannesburg mexico_city algiers istanbul moscow tehran
                 baghdad riyadh karachi delhi mumbai cairo chennai kolkata beijing seoul shanghai tokyo bangkok
                 hong_kong taipei osaka jakarta ho_chi_minh_city manila sydney]
    @pre_deck = @pre_deck.shuffle

  end

  def get_starter_hand(num_of_players)
    if (num_of_players == 2)
      hand1= []
      hand2= []
      4.times do
        hand1.push(@pre_deck.pop)
        hand2.push(@pre_deck.pop)
      end
      player_hands = [hand1, hand2]
    elsif  (num_of_players == 3)
      hand1 = []
      hand2 = []
      hand3 = []
      3.times do
        hand1.push(@pre_deck.pop)
        hand2.push(@pre_deck.pop)
        hand3.push(@pre_deck.pop)
      end
      player_hands = [hand1, hand2, hand3]
    else
      hand1 = []
      hand2 = []
      hand3 = []
      hand4 = []
      2.times do
        hand1.push(@pre_deck.pop)
        hand2.push(@pre_deck.pop)
        hand3.push(@pre_deck.pop)
        hand4.push(@pre_deck.pop)
      end
      player_hands = [hand1, hand2, hand3, hand4]
    end

    sliced_deck = @pre_deck.each_slice(6).to_a
    excess = sliced_deck.pop
    excess.each_index do |i|
      @player_deck.push(excess[i])
    end
    sliced_deck.each do |pile|
      pile.push("epidemic")
      pile = pile.shuffle
      pile.each do |card|
        @player_deck.push(card)
      end
    end
    return player_hands
  end

end