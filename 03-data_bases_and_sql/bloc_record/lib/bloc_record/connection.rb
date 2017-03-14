require 'sqlite3'

module Connection
  def connection
    if @database_tableName
      @connection ||= PG::Database.new(BlocRecord.database_tableName)
    else
      @connection ||= SQLite3::Database.new(BlocRecord.database_filename)
    end
  end
end
