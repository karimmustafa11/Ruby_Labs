require_relative 'logger'
require_relative 'user'
require_relative 'transaction'
require_relative 'bank'
require 'time'

class CBABank < Bank
  include Logger

  def initialize(users)
    @users = users
  end

  def process_transactions(transactions, &callback)
    transaction_descriptions = transactions.map(&:to_s).join(", ")
    log_info("Processing Transactions #{transaction_descriptions}...")

    transactions.each do |transaction|
      user = transaction.user
      value = transaction.value

      unless @users.include?(user)
        error_message = "#{user.name} not exist in the bank!!"
        log_error("User #{user.name} transaction with value #{value} failed with message #{error_message}")
        callback.call("failure of User #{user.name} transaction with value #{value} with reason #{error_message}")
        next
      end

      begin
        if user.balance + value < 0
          raise "Not enough balance"
        end

        user.balance += value

        if user.balance == 0
          log_warning("#{user.name} has 0 balance")
        end

        log_info("User #{user.name} transaction with value #{value} succeeded")
        callback.call("success of User #{user.name} transaction with value #{value}")
      rescue => e
        log_error("User #{user.name} transaction with value #{value} failed with message #{e.message}")
        callback.call("failure of User #{user.name} transaction with value #{value} with reason #{e.message}")
      end
    end
  end
end
