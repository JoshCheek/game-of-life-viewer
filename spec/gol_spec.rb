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
    context 'when a cell is alive' do
      it 'lives if it has 2 or 3 neighbours'
      it 'dies otherwise'
    end

    context 'when a cell is dead' do
      it 'comes to life if it has 3 neighbours'
      it 'stays dead otherwise'
    end
  end
end
