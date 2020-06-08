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
end