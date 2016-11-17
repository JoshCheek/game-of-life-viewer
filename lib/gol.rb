require 'set'
require 'strscan'

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

  # RLE description (not really a spec, but w/e)
  # http://lifeconvert.wayneandlayne.com/
  #
  # Explanation of the B3/S23 thing (birth on 3 neighbours, survive on 2 and 3)
  # https://marcocrosa.wordpress.com/2012/09/25/the-b3s23-rule/
  #
  # I'm not taking this too seriously, just so long as it can parse a few examples
  # so that we have something interesting to display.
  #
  # You can get examples at this forum, eg I found one to test against from here:
  # http://www.conwaylife.com/forums/viewtopic.php?f=7&t=2036
  def self.parse(rle)
    lines = rle.lines.reject { |l| l[0] == '#' }.map(&:chomp)
    headers, *rest = lines
    args = {}
    headers.split(",").map do |header|
      key, value = header.split("=").map(&:strip)
      args[key.intern] = value.to_i
    end

    scanner = StringScanner.new(rest.join)
    world   = Set.new
    y       = 0
    x       = 0
    until scanner.eos?
      if scanner.scan(/b/) # dead
        x += 1
      elsif scanner.scan(/o/) # alive
        world << [x, y]
        x += 1
      elsif match = scanner.scan(/^\d+[bo$]/)
        times = match.to_i
        case match[/\D+/]
        when 'b' then x += times
        when 'o'
          times.times do
            world << [x, y]
            x += 1
          end
        when '$'
          x = 0
          y += times
        end
      elsif scanner.scan(/\$/)
        x = 0
        y += 1
      elsif scanner.scan(/!/)
        break
      else
        raise "Uhm, can't parse #{scanner.inspect}"
      end
    end
    args[:world] = world
    Game.new args
  end

  class Game
    attr_accessor :x, :y, :world
    def initialize(x:, y:, world:, rule: nil)
      self.x     = x
      self.y     = y
      self.world = world
    end
    def ==(other)
      x == other.x && y == other.y && world == other.world
    end
  end
end
