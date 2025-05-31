require_relative 'user'
require_relative 'transaction'
require_relative 'CBABank'

users = [
  User.new("Karim", 500),
  User.new("Ali", 200),
  User.new("Yousef", 100)
]

outside_bank_users = [
User.new("Menna", 400)
]

transactions = [
  Transaction.new(users[0], -20),
  Transaction.new(users[0], -30),
  Transaction.new(users[0], -50),
  Transaction.new(users[0], -100),
  Transaction.new(users[0], -100),
  Transaction.new(outside_bank_users[0], -100)
]

bank = CBABank.new(users)

bank.process_transactions(transactions) do |result|
  puts "Call endpoint for #{result}"
end
