class Attendee
  attr_reader :name, :budget

  def initialize(params)
    @name = params[:name]
    @budget = params[:budget]
  end
end
