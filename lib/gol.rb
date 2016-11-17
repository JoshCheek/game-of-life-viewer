require 'set'

module Gol
  def self.tick(old_world)
    new_world = Set.new
    tomorrows_potentials(old_world).each do |cell|
      alive      = old_world.include?(cell)
      neighbours = num_neighbours(cell, old_world)
      new_world << cell if lives? alive, neighbours
    end
    new_world
  end

  def self.num_neighbours(cell, world)
    neighbours_of(cell).count &world.method(:include?)
  end

  def self.lives?(is_alive, num_neighbours)
    num_neighbours == 3 || (is_alive && num_neighbours == 2)
  end

  private

  def self.neighbours_of(cell)
    x, y = cell
    [ [x-1, y-1], [x, y-1], [x+1, y-1],
      [x-1, y  ],           [x+1, y  ],
      [x-1, y+1], [x, y+1], [x+1, y+1],
    ]
  end

  def self.tomorrows_potentials(world)
    potentials = Set.new
    world.each do |cell|
      potentials << cell
      neighbours_of(cell).each &potentials.method(:<<)
    end
    potentials
  end
end
