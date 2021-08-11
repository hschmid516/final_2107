require './lib/item'
require './lib/auction'
require './lib/attendee'

RSpec.describe Auction do
  it 'exists' do
    auction = Auction.new

    expect(auction).to be_a(Auction)
  end

  it 'can add items' do
    item1 = Item.new('Chalkware Piggy Bank')
    item2 = Item.new('Bamboo Picture Frame')
    attendee = Attendee.new(name: 'Megan', budget: '$50')
    auction = Auction.new

    expect(auction.items).to eq([])

    auction.add_item(item1)
    auction.add_item(item2)

    expect(auction.items).to eq([item1, item2])
  end
end
