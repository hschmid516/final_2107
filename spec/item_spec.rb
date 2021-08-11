require './lib/item'

RSpec.describe Item do
  it 'exists' do
    item1 = Item.new('Chalkware Piggy Bank')

    expect(item1).to be_a(Item)
  end

  it 'has a name' do
    item1 = Item.new('Chalkware Piggy Bank')

    expect(item1.name).to eq('Chalkware Piggy Bank')
  end

  it 'starts with no bids' do
    item1 = Item.new('Chalkware Piggy Bank')

    expect(item1.bids).to eq({})
  end

  it 'can add bids' do
    item1 = Item.new('Chalkware Piggy Bank')
    attendee1 = Attendee.new(name: 'Megan', budget: '$50')
    attendee2 = Attendee.new(name: 'Bob', budget: '$75')

    item1.add_bid(attendee2, 20)
    item1.add_bid(attendee1, 22)

    expect(item1.bids).to eq({attendee2 => 20, attendee1 => 22})
  end

  it 'can show current high bid' do
    item1 = Item.new('Chalkware Piggy Bank')
    attendee1 = Attendee.new(name: 'Megan', budget: '$50')
    attendee2 = Attendee.new(name: 'Bob', budget: '$75')
    item1.add_bid(attendee2, 20)
    item1.add_bid(attendee1, 22)

    expect(item1.current_high_bid).to eq(22)
  end

  it 'can show current high bidder' do
    item1 = Item.new('Chalkware Piggy Bank')
    attendee1 = Attendee.new(name: 'Megan', budget: '$50')
    attendee2 = Attendee.new(name: 'Bob', budget: '$75')
    item1.add_bid(attendee2, 20)
    item1.add_bid(attendee1, 22)

    expect(item1.current_high_bidder).to eq([attendee1, 22])
  end

  it 'it shows bidders' do
    item1 = Item.new('Chalkware Piggy Bank')
    attendee1 = Attendee.new(name: 'Megan', budget: '$50')
    attendee2 = Attendee.new(name: 'Bob', budget: '$75')
    item1.add_bid(attendee2, 20)
    item1.add_bid(attendee1, 22)

    expect(item1.bidders).to eq(["Bob", "Megan"])
  end
end
