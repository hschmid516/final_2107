class Item
  attr_reader :name, :bids

  def initialize(name)
    @name = name
    @bids = {}
  end

  def add_bid(attendee, bid)
    @bids[attendee] = bid
  end

  def current_high_bid
    current_high_bidder[1]
  end

  def current_high_bidder
    @bids.max_by do |attendee, bid|
      bid
    end
  end

  def bidders
    @bids.keys.map do |bidder|
      bidder.name
    end
  end
end
