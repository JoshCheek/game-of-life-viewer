require 'set'

module Gol
  def self.tick(old_world)
    new_world = Set.new
    new_world
  end

  def self.num_neighbours(cell, world)
    x, y = cell
    [ [x-1, y-1], [x, y-1], [x+1, y-1],
      [x-1, y  ],           [x+1, y  ],
      [x-1, y+1], [x, y+1], [x+1, y+1],
    ].count(&world.method(:include?))
  end
end
