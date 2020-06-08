require './enumerables.rb'
describe Enumerable do
  let(:number) { [1, 2, 3, 4, 2] }
  let(:string) { %w[cat bear rat] } 

  describe "#my_each" do
    it 'enumerable when no block is given' do
      expect((1..4).my_each).to be_instance_of(Enumerator)
    end

    it 'should not modify an array' do
      expect((number.my_each {|x| x * x})).to match(number)
    end
  end 
  describe "#my_each_with_index" do
    it 'enumerable when no block is given' do
      expect((1..4).my_each).to be_instance_of(Enumerator)
    end
     
    it 'returns an item and its index' do
      hash = {}
      %w[bread blueband toothpaste].my_each_with_index do |item, index|
        hash[item] = index
      end
      expect(hash).to include('bread' => 0, 'blueband' => 1, 'toothpaste' => 2)
    end
  end
  describe "#my_select" do
  it 'enumerable when no block is given' do
    expect((1..4).my_each).to be_instance_of(Enumerator)
  end
  end
end