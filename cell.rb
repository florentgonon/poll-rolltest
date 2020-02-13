class Cell
  attr_reader :populations, :x, :y

  def initialize(populations, x, y)
    @populations = populations
    @populations_update = populations
    @x = x
    @y = y
    @live = false
  end

  def dead?
    !@live
  end

  def live?
    @live
  end

  def neighbours_coordinates(x, y)
    neighbours = []
    neighbours << [x - 1, y - 1]
    neighbours << [x - 1, y]
    neighbours << [x - 1, y + 1]

    neighbours << [x, y - 1]
    neighbours << [x, y + 1]

    neighbours << [x + 1, y - 1]
    neighbours << [x + 1, y]
    neighbours << [x + 1, y + 1]
  end

  def neighbour_count(x, y)
    neighbours_coordinates(x, y).select do |neighbour|
      neighbour[0] >= 0 && neighbour[0] <= 15 && neighbour[1] >= 0 && neighbour[1] <= 15
    end
  end

  def neighbour_alive(x, y)
    sum_alive_neighbour = 0
    neighbour_count(x, y).each do |coord|
      if @populations[coord[0]][coord[1]] == 1
        sum_alive_neighbour += 1
      else
      end
    end
    return sum_alive_neighbour
  end

  def change_statement(iterator)
    nb = 0
    iterator.times do
      @populations.each_with_index do |population, x|
        population.each_with_index do |value, y|
          if value == 1 && neighbour_alive(x, y) < 2
            @populations_update[x][y] = 0
          elsif value == 1 && (neighbour_alive(x, y) == 2 || neighbour_alive(x, y) == 3)
            @populations_update[x][y] = 1
          elsif neighbour_alive(x, y) > 3
            @populations_update[x][y] = 0
          elsif value.zero? && neighbour_alive(x, y) == 3
            @populations_update[x][y] = 1
          end
        end
      end
      # p @populations_update
      nb += 1
      puts "################ Génération - #{nb} ################"
      @populations_update.each do |row|
        puts "#{row}"
      end
    end
  end

  def game
    puts "How many generation you want ?"
    iterator = gets.chomp.to_i
    change_statement(iterator)
  end
end

populations = [[0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0],
              [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1],
              [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
              [1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0],
              [1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 0, 0, 0],
              [0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0],
              [0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0],
              [0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0],
              [0, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1],
              [0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0],
              [1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1],
              [0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0],
              [0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 0, 0],
              [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1],
              [0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 1],
              [0, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 0, 0, 1, 1, 1]]

Cell.new(populations, 3, 3).game
