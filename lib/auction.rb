class Auction
  attr_reader :items, :date

  def initialize
    @items = []
    @date = Date.today.strftime('%d/%m/%Y')
  end

  def add_item(item)
    @items << item
  end

  def item_names
    @items.map do |item|
      item.name
    end
  end

  def unpopular_items
    @items.find_all do |item|
      item.bids == {}
    end
  end

  def potential_revenue
    potential_revenue = 0
    @items.each do |item|
      if item.bids != {}
        potential_revenue += item.current_high_bid
      end
    end
    potential_revenue
  end

  def bidders
    @items.flat_map do |item|
      item.bidders
    end.uniq
  end

  def bidder_info
    attendees.each_with_object({}) do |attendee, acc|
      acc[attendee] ||= {budget: 0, items: []}
      acc[attendee][:budget] = attendee.budget
      items_by_bidder(attendee).each do |item|
        acc[attendee][:items] << item
      end
    end
  end

  def attendees
    @items.compact.flat_map do |item|
      item.bidders_info
    end.uniq
  end

  def items_by_bidder(attendee)
    @items.find_all do |item|
      item.bidders.include?(attendee.name)
    end
  end

  def close_auction
    sell_items
    @items.each_with_object({}) do |item, acc|
      if item.bids == {}
        acc[item] = 'Not Sold'
      else
        acc[item] = item.current_high_bidder[0]
      end
    end
  end

  def sell_items
    @items.each do |item|
      item.close_bidding
    end
  end
end
