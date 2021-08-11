require './lib/item'
require './lib/auction'
require './lib/attendee'
require 'date'

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
      expect(@auction.unpopular_items).to eq([@item2, @item3, @item5])

      @item3.add_bid(@attendee2, 15)

      expect(@auction.unpopular_items).to eq([@item2, @item5])
    end

    it 'shows potential revenue' do
      @item3.add_bid(@attendee2, 15)

      expect(@auction.potential_revenue).to eq(87)
    end
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
      @item1.add_bid(@attendee1, 22)
      @item1.add_bid(@attendee2, 20)
      @item4.add_bid(@attendee3, 50)
      @item3.add_bid(@attendee2, 15)
    end

    it 'it shows bidders' do
      expect(@auction.bidders).to eq(["Megan", "Bob", "Mike"])
    end

    it 'shows bidder info' do
      expected = {
          @attendee1 =>
            {
              :budget => 50,
              :items => [@item1]
            },
          @attendee2 =>
            {
              :budget => 75,
              :items => [@item1, @item3]
            },
          @attendee3 =>
            {
              :budget => 100,
              :items => [@item4]
            }
         }

      expect(@auction.bidder_info).to eq(expected)
    end

    it 'shows attendees' do
      expect(@auction.attendees).to eq([@attendee1, @attendee2, @attendee3])
    end

    it 'shows items by bidders' do
      expect(@auction.items_by_bidder(@attendee1)).to eq([@item1])
    end
  end

  context 'close auction' do
    it 'has a date' do
      item1 = Item.new('Chalkware Piggy Bank')
      item2 = Item.new('Bamboo Picture Frame')
      item3 = Item.new('Homemade Chocolate Chip Cookies')
      item4 = Item.new('2 Days Dogsitting')
      item5 = Item.new('Forever Stamps')
      attendee1 = Attendee.new(name: 'Megan', budget: '$50')
      attendee2 = Attendee.new(name: 'Bob', budget: '$75')
      attendee3 = Attendee.new(name: 'Mike', budget: '$100')
      auction = Auction.new
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)

      expect(auction.date).to eq(Date.today.strftime('%d/%m/%Y'))

      allow(auction).to receive(:date).and_return('11/08/2020')

      expect(auction.date).to eq('11/08/2020')
    end

    it 'can close the auction' do
      item1 = Item.new('Chalkware Piggy Bank')
      item2 = Item.new('Bamboo Picture Frame')
      item3 = Item.new('Homemade Chocolate Chip Cookies')
      item4 = Item.new('2 Days Dogsitting')
      item5 = Item.new('Forever Stamps')
      attendee1 = Attendee.new(name: 'Megan', budget: '$50')
      attendee2 = Attendee.new(name: 'Bob', budget: '$75')
      attendee3 = Attendee.new(name: 'Mike', budget: '$100')
      auction = Auction.new
      auction.add_item(item1)
      auction.add_item(item2)
      auction.add_item(item3)
      auction.add_item(item4)
      auction.add_item(item5)
      item1.add_bid(attendee1, 22)
      item1.add_bid(attendee2, 20)
      item4.add_bid(attendee2, 30)
      item4.add_bid(attendee3, 50)
      item3.add_bid(attendee2, 15)
      item5.add_bid(attendee1, 35)
      auction.close_auction

      expected =  {
        item1 => attendee1,
        item2 => 'Not Sold',
        item3 => attendee2,
        item4 => attendee3,
        item5 => attendee1
      }
      expect(auction.close_auction).to eq(expected)
    end
  end
end
