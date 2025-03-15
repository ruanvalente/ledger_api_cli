require 'date'
require_relative '../database'
require_relative '../services/transaction_service'

class Transaction
  attr_reader :id, :value, :date, :description

  def initialize(id:, value:, date:, description: nil)
    @id = id
    @value = value
    @date = date
    @description = description
  end

  def self.create_table
    Database.connection.execute(File.read(File.expand_path('../database/schema.sql', __dir__)))
  end

  def self.add(value:, description: nil)
    TransactionService.add(value: value, description: description)
  end

  def self.all
    TransactionService.all
  end

  def self.balance
    TransactionService.balance
  end
end
