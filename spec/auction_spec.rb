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
    auction = Auction.new

    expect(auction.items).to eq([])

    auction.add_item(item1)
    auction.add_item(item2)

    expect(auction.items).to eq([item1, item2])
  end

  it 'can show item names' do
    item1 = Item.new('Chalkware Piggy Bank')
    item2 = Item.new('Bamboo Picture Frame')
    auction = Auction.new
    auction.add_item(item1)
    auction.add_item(item2)

    expect(auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame"])
  end

  context 'bidding' do
    before(:each) do
      @item1 = Item.new('Chalkware Piggy Bank')
      @item2 = Item.new('Bamboo Picture Frame')
      @item3 = Item.new('Homemade Chocolate Chip Cookies')
      @item4 = Item.new('2 Days Dogsitting')
      @item5 = Item.new('Forever Stamps')
      @attendee1 = Attendee.new(name: 'Megan', budget: '$50')
      @attendee2 = Attendee.new(name: 'Bob', budget: '$75')
      @attendee3 = Attendee.new(name: 'Mike', budget: '$100')
      @auction = Auction.new
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)
      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)
      @item4.add_bid(@attendee3, 50)
    end

    it 'shows unpopular_items' do

    end
  end
end
