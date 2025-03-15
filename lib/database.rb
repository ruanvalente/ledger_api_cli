require 'sqlite3'

module Database
  DB_PATH = File.expand_path('../ledger.db', __dir__)

  def self.connection
    @db ||= SQLite3::Database.new(DB_PATH)
  end
end
