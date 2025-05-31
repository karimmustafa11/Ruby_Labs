class User
  attr_reader :name
  attr_accessor :balance
  def initialize(name, balance)
    @name = name
    @balance = balance
  end

  def to_s
    puts "Name: #{@name}, Balance: #{@balance}"
  end
end
