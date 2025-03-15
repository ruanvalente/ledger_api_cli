require_relative '../database'

class TransactionService
  def self.add(value:, description: nil)
    date = Date.today.to_s
    Database.connection.execute('INSERT INTO transactions (value, date, description) VALUES (?, ?, ?)',
                                [value, date, description])
  end

  def self.all
    Database.connection.execute('SELECT * FROM transactions ORDER BY date DESC, id DESC').map do |row|
      Transaction.new(id: row[0], value: row[1], date: row[2], description: row[3])
    end
  end

  def self.balance
    Database.connection.get_first_value('SELECT SUM(value) FROM transactions').to_f
  end
end
