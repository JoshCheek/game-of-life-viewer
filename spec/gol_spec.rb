require 'gol'

RSpec.describe 'Gol' do
  describe 'tick' do
    it 'returns a new world without affecting the previous world' do
      old = Set[[0, 0]]
      new = Gol.tick old
      expect(old).to eq Set[[0, 0]]
      expect(new).to_not eq Set[[0, 0]]
    end

    specify 'each cell in the new world lives based on the rules, as applied to the state of the previous world' do
      # the blinker
      horizontal = Set[[0, 1], [1, 1], [2, 1]]
      vertical   = Set[[1, 0], [1, 1], [1, 2]]
      expect(Gol.tick horizontal).to eq vertical
      expect(Gol.tick vertical).to eq horizontal
    end
  end

  describe 'rules' do
    it 'considers neighbours to be any of the cells directly adjacent horizontally, vertically, and diagonally' do
      expectations = {
        [0, 0] => 3, [1, 0] => 5, [2, 0] => 3,
        [0, 1] => 5, [1, 1] => 8, [2, 1] => 5,
        [0, 2] => 3, [1, 2] => 5, [2, 2] => 3,
      }
      world = Set.new expectations.keys
      expectations.each do |cell, num_neighbours|
        expect(Gol.num_neighbours cell, world).to eq num_neighbours
      end
    end

    context 'when a cell is alive' do
      it 'lives if it has 2 or 3 neighbours' do
        expect(Gol.lives? true, 2).to eq true
        expect(Gol.lives? true, 3).to eq true
      end
      it 'dies otherwise' do
        expect(Gol.lives? true, 0).to eq false
        expect(Gol.lives? true, 1).to eq false
        expect(Gol.lives? true, 4).to eq false
        expect(Gol.lives? true, 5).to eq false
        expect(Gol.lives? true, 6).to eq false
        expect(Gol.lives? true, 7).to eq false
        expect(Gol.lives? true, 8).to eq false
      end
    end

    context 'when a cell is dead' do
      it 'comes to life if it has 3 neighbours' do
        expect(Gol.lives? false, 3).to eq true
      end
      it 'stays dead otherwise' do
        expect(Gol.lives? false, 0).to eq false
        expect(Gol.lives? false, 1).to eq false
        expect(Gol.lives? false, 2).to eq false
        expect(Gol.lives? false, 4).to eq false
        expect(Gol.lives? false, 5).to eq false
        expect(Gol.lives? false, 6).to eq false
        expect(Gol.lives? false, 7).to eq false
        expect(Gol.lives? false, 8).to eq false
      end
    end
  end
end
