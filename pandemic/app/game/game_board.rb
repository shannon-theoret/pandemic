require 'json'
require 'securerandom'

class GameBoard
  attr_accessor :id, :step, :cities, :infection_deck, :player_card_deck, :players, :cube_inventory, :cures,
                :eradications, :infection_rate_scale, :infection_rate_index, :outbreaks, :max_outbreaks

  def initialize(number_of_players)

    @id = SecureRandom.alphanumeric

    @step = Step.new(number_of_players)

    @cube_inventory = {"blue" => 24, "yellow" => 24, "black" => 24, "red" => 24}

    @cures = {"blue" => false, "yellow" => false, "black" => false, "red" => false}

    @eradications  = {"blue" => false, "yellow" => false, "black" => false, "red" => false}

    @outbreaks = 0
    @max_outbreaks = 8

    @cities = Hash.new
    @cities["san_francisco"] = City.new("san_francisco", "blue")
    @cities["chicago"] = City.new("chicago", "blue")
    @cities["montreal"] = City.new("montreal", "blue")
    @cities["new_york"] = City.new("new_york", "blue")
    @cities["atlanta"] = City.new("atlanta", "blue")
    @cities["washington"] = City.new("washington", "blue")
    @cities["london"] = City.new("london", "blue")
    @cities["madrid"] = City.new("madrid", "blue")
    @cities["essen"] = City.new("essen", "blue")
    @cities["paris"] = City.new("paris", "blue")
    @cities["milan"] = City.new("milan", "blue")
    @cities["st_petersburg"] = City.new("st_petersburg", "blue")
    @cities["los_angeles"] = City.new("los_angeles", "yellow")
    @cities["miami"] = City.new("miami", "yellow")
    @cities["bogota"] = City.new("bogota", "yellow")
    @cities["lima"] = City.new("lima", "yellow")
    @cities["santiago"] = City.new("santiago", "yellow")
    @cities["sao_paulo"] = City.new("sao_paulo", "yellow")
    @cities["buenos_aires"] = City.new("buenos_aires", "yellow")
    @cities["lagos"] = City.new("lagos", "yellow")
    @cities["khartoum"] = City.new("khartoum", "yellow")
    @cities["kinshasa"] = City.new("kinshasa", "yellow")
    @cities["johannesburg"] = City.new("johannesburg", "yellow")
    @cities["mexico_city"] = City.new("mexico_city", "yellow")
    @cities["algiers"] = City.new("algiers", "black")
    @cities["istanbul"] = City.new("istanbul", "black")
    @cities["moscow"] = City.new("moscow", "black")
    @cities["tehran"] = City.new("tehran", "black")
    @cities["baghdad"] = City.new("baghdad", "black")
    @cities["riyadh"] = City.new("riyadh", "black")
    @cities["karachi"] = City.new("karachi", "black")
    @cities["delhi"] = City.new("delhi", "black")
    @cities["mumbai"] = City.new("mumbai", "black")
    @cities["cairo"] = City.new("cairo", "black")
    @cities["chennai"] = City.new("chennai", "black")
    @cities["kolkata"] = City.new("kolkata", "black")
    @cities["beijing"] = City.new("beijing", "red")
    @cities["seoul"] = City.new("seoul", "red")
    @cities["shanghai"] = City.new("shanghai", "red")
    @cities["tokyo"] = City.new("tokyo", "red")
    @cities["bangkok"] = City.new("bangkok", "red")
    @cities["hong_kong"] = City.new("hong_kong", "red")
    @cities["taipei"] = City.new("taipei", "red")
    @cities["osaka"] = City.new("osaka", "red")
    @cities["jakarta"] = City.new("jakarta", "red")
    @cities["ho_chi_minh_city"] = City.new("ho_chi_minh_city", "red")
    @cities["manila"] = City.new("manila", "red")
    @cities["sydney"] = City.new("sydney", "red")

    @cities["atlanta"].has_research_station = true

    @infection_deck = InfectionDeck.new

    cubes_per_city = 3
    while cubes_per_city > 0
      j = 0
      while j < 3
        city_name = @infection_deck.get_city_to_infect
        city = @cities[city_name]
        k = 0
        while k < cubes_per_city
          city.add_cube
          k += 1
        end
        current_cubes = @cube_inventory[city.color]
        @cube_inventory[city.color] = current_cubes - cubes_per_city
        j += 1
      end
      cubes_per_city -= 1
    end

    @cities["san_francisco"].connecting_cities = ["tokyo", "manila"]
    @cities["san_francisco"].connecting_cities = ["tokyo","manila","los_angeles","chicago"]
    @cities["chicago"].connecting_cities = ["san_francisco","los_angeles","mexico_city","atlanta","montreal"]
    @cities["montreal"].connecting_cities = ["chicago","washington","new_york"]
    @cities["new_york"].connecting_cities = ["montreal","washington","london","madrid"]
    @cities["atlanta"].connecting_cities = ["chicago","washington","miami"]
    @cities["washington"].connecting_cities = ["atlanta","miami","montreal","new_york"]
    @cities["london"].connecting_cities = ["new_york","madrid","paris","essen"]
    @cities["madrid"].connecting_cities = ["new_york","london","paris","algiers"]
    @cities["essen"].connecting_cities = ["london","paris","milan","st_petersburg"]
    @cities["paris"].connecting_cities = ["madrid","london","essen","milan","algiers"]
    @cities["milan"].connecting_cities = ["paris","essen","istanbul"]
    @cities["st_petersburg"].connecting_cities = ["essen","istanbul","moscow"]
    @cities["los_angeles"].connecting_cities = ["san_francisco","chicago","mexico_city","sydney"]
    @cities["miami"].connecting_cities = ["mexico_city","atlanta","washington","bogota"]
    @cities["bogota"].connecting_cities = ["mexico_city","miami","sao_paulo","buenos_aires","lima"]
    @cities["lima"].connecting_cities = ["mexico_city","bogota","santiago"]
    @cities["santiago"].connecting_cities = ["lima"]
    @cities["sao_paulo"].connecting_cities = ["buenos_aires","bogota","madrid","lagos"]
    @cities["buenos_aires"].connecting_cities = ["bogota","sao_paulo"]
    @cities["lagos"].connecting_cities = ["sao_paulo","kinshasa","khartoum"]
    @cities["khartoum"].connecting_cities = ["lagos","kinshasa","johannesburg","cairo"]
    @cities["kinshasa"].connecting_cities = ["lagos","khartoum","johannesburg"]
    @cities["johannesburg"].connecting_cities = ["kinshasa","khartoum"]
    @cities["mexico_city"].connecting_cities = ["los_angeles","chicago","miami","bogota","lima"]
    @cities["algiers"].connecting_cities = ["madrid","paris","istanbul","cairo"]
    @cities["istanbul"].connecting_cities = ["algiers","milan","st_petersburg","moscow","baghdad","cairo"]
    @cities["moscow"].connecting_cities = ["istanbul","st_petersburg","tehran"]
    @cities["tehran"].connecting_cities = ["baghdad","moscow","delhi","karachi"]
    @cities["baghdad"].connecting_cities = ["cairo","istanbul","tehran","karachi","riyadh"]
    @cities["riyadh"].connecting_cities = ["cairo","baghdad","karachi"]
    @cities["karachi"].connecting_cities = ["riyadh","baghdad","tehran","delhi","mumbai"]
    @cities["delhi"].connecting_cities = ["mumbai","karachi","tehran","kolkata","chennai"]
    @cities["mumbai"].connecting_cities = ["karachi","delhi","chennai"]
    @cities["cairo"].connecting_cities = ["algiers","istanbul","baghdad","riyadh","khartoum"]
    @cities["chennai"].connecting_cities = ["mumbai","delhi","kolkata","bangkok","jakarta"]
    @cities["kolkata"].connecting_cities = ["chennai","delhi","hong_kong","bangkok"]
    @cities["beijing"].connecting_cities = ["shanghai","seoul"]
    @cities["seoul"].connecting_cities = ["beijing","shanghai","tokyo"]
    @cities["shanghai"].connecting_cities = ["beijing","seoul","tokyo","taipei","hong_kong"]
    @cities["tokyo"].connecting_cities = ["osaka","shanghai","seoul","san_francisco"]
    @cities["bangkok"].connecting_cities = ["chennai","kolkata","hong_kong","ho_chi_minh_city","jakarta"]
    @cities["hong_kong"].connecting_cities = ["kolkata","shanghai","taipei","manila","ho_chi_minh_city","bangkok"]
    @cities["taipei"].connecting_cities = ["hong_kong","shanghai","osaka","manila"]
    @cities["osaka"].connecting_cities = ["taipei","tokyo"]
    @cities["jakarta"].connecting_cities = ["chennai","bangkok","ho_chi_minh_city","sydney"]
    @cities["ho_chi_minh_city"].connecting_cities = ["jakarta","bangkok","hong_kong","manila"]
    @cities["manila"].connecting_cities = ["sydney","ho_chi_minh_city","hong_kong","taipei","san_francisco"]
    @cities["sydney"].connecting_cities = ["los_angeles","jakarta","manila"]

    #initialize player deck
    @player_card_deck = PlayerDeck.new
    player_hands = @player_card_deck.get_starter_hand(number_of_players)

    @players = {}

    number_of_players.times do |i|
      @players[i] = Player.new(i)
      @players[i].hand = player_hands[i]
    end


    #initialize players

  end

  def infect
    @last_move_summary = LastMoveSummary.new;
    name_of_city_to_infect = @infection_deck.get_city_to_infect
    @last_move_summary.infectioms.push(name_of_city_to_infect)
    city_to_infect = @cities[name_of_city_to_infect]
    current_cubes = @cube_inventory[city_to_infect.color]
    outbreak = city_to_infect.add_cube
    if (outbreak) then
      @last_move_summary.outbreaks.push(name_of_city_to_infect)
      resolved_outbreaks = []
      unresolved_outbreaks = []
      unresolved_outbreaks.push(city_to_infect)
      while (!unresolved_outbreaks.empty?) do
        current_outbreak_city = unresolved_outbreaks.pop
        resolved_outbreaks.push
        current_outbreak_city.connecting_cities.each { |city_name_affected_by_outbreak|
          @last_move_summary.outbreaks.push(city_name_affected_by_outbreak)
          city_affected_by_outbreak = @cities[city_name_affected_by_outbreak]
          if( !resolved_outbreaks.include? city_affected_by_outbreak ) then
            rippleOutbreak = city_affected_by_outbreak.add_colored_cube(city_to_infect.color)
            if (rippleOutbreak) then
              @last_move_summary.outbreaks.push(city_name_affected_by_outbreak)
              unresolved_outbreaks.push(city_affected_by_outbreak)
            else
              current_cubes = @cube_inventory[city_to_infect.color]
              @cube_inventory[city_to_infect.color] = current_cubes - 1
            end
          end
      } end
    else
      @cube_inventory[city_to_infect.color] = current_cubes - 1
    end
  end

end

