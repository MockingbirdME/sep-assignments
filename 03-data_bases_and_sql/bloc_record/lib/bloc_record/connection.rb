require 'sqlite3'
require 'pg'

module Connection
  def connection
    if BlocRecord.db_type == 'pg'
      @connection ||= PG.connect(dbname: BlocRecord.db_name)
    else
      @connection ||= SQLite3::Database.new(BlocRecord.db_name)
    end
  end

  def db_exec(command)
    if BlocRecord.db_type = 'pg'
      @connection.exec(command)
    else
      @connection.execute(command)
    end
  end
end
