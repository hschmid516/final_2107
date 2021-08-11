class Item
  attr_reader :name, :bids, :open

  def initialize(name)
    @name = name
    @bids = {}
    @open = true
  end

  def add_bid(attendee, bid)
    @bids[attendee] = bid if @open
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

  def close_bidding
    @open = false
  end
end
