require 'pg'
require 'sqlite3'
require 'bloc_record/utility'

module Schema
  def table
    BlocRecord::Utility.underscore(name)
  end

  def columns
    schema.keys
  end

  def attributes
    columns - ["id"]
  end

  def schema
    unless @schema
      @schema = {}
      if BlocRecord.db_type == 'pg'
        cols = connection.exec <<-SQL
           SELECT *
           FROM #{table}
           WHERE Id=0;
        SQL
        p PG::Connection.column_definitions("address_book")
        # p cols.public_methods.sort
        p cols.values
        p cols.fields

        cols.fields.each do |col|
          p col
          @schema[col["name"]] = col["type"]
        end
        p @schema
      else
        connection.table_info(table) do |col|
          @schema[col["name"]] = col["type"]
        end
      end
    end
    @schema
  end

  def count
    connection.execute(<<-SQL)[0][0]
       SELECT COUNT(*) FROM #{table}
    SQL
  end
end
