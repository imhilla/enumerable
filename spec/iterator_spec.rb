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
      expect((1..4).my_select).to be_instance_of(Enumerator)
    end

    it 'should return new array with selected values' do
      a = [1,2,3,4,5]
      b = a.my_select { |num|  num.even?  } 
      expect(b).not_to eql(a)
    end

    it 'returns a new hash for which the block returns true' do
      options = { font_size: 10, font_family: "Arial" }
      c = options[:font_size] 
      expect(c).to eql(10)
    end
  end

  describe "my_all?" do
    it 'returns true when no block is given' do
      expect([].my_all?).to eql(true)
    end

    it 'returns false if the block never returns true' do
      expect([nil, true, 99].my_all?).to eql(false)
    end

    it 'returns false unless value matches pattern' do
      expect(%w[ant bear cat].my_all?(/t/)).to eql(false)
    end

    it 'returns false unless value yields a value and matches pattern' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 4 }).to eql(false)
    end

    it 'returns false unless value == pattern' do 
      expect([1, 2i, 3.14].my_all?(Numeric)).to eql(true)
    end
  end

  describe "#my_any?" do
    it 'returns true if the block ever returns a value other than false or nil' do
      expect([nil, true, 99].my_any?(Integer)).to eql(true)
    end

    it 'returns false if the block never returns true' do
      expect(%w[ant bear cat].my_any?(/d/)).to eql(false)
    end

    it 'returns false unless value == pattern' do 
      expect([nil, true, 99].my_any?).to eql(true)
    end

    it 'returns true if pattern value of block matches pattern given' do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 4 }).to eql(true)
    end
  end

  describe "#my_none?" do
    it 'returns true if the block never returns true for all elements' do
      expect(%w{ant bear cat}.my_none? { |word| word.length == 5 }).to eql(true)
    end
    it 'returns false if the block returns true for some elements' do
      expect(%w{ant beard cat}.my_none? { |word| word.length == 5 }).to eql(false)
    end
    it 'method returns whether pattern === element for none of the collection members' do
      expect([nil, false, true].my_none?).to eql(false)
    end
    it 'If the block is not given it will return true only if none of the collection members is true' do
      expect([].my_none?).to eql(true)
    end
  end
end