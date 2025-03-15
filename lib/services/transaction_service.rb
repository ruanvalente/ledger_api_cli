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

  def self.filtered(type: nil, start_date: nil, end_date: nil)
    query = 'SELECT * FROM transactions'
    conditions = []
    params = []

    if type
      conditions << (type == 'entrada' ? 'value > 0' : 'value < 0')
    end

    if start_date
      conditions << 'date >= ?'
      params << start_date
    end

    if end_date
      conditions << 'date <= ?'
      params << end_date
    end

    query += " WHERE #{conditions.join(' AND ')}" unless conditions.empty?
    query += ' ORDER BY date DESC, id DESC'

    Database.connection.execute(query, params).map do |row|
      Transaction.new(id: row[0], value: row[1], date: row[2], description: row[3])
    end
  end
end
