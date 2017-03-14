module BlocRecord
  def self.connect_to(filename, dbType)
    if dbType.to_s == ':pg'
      @database_tableName = filename
    else
      @database_filename = filename
    end
  end

  if @database_tableName
    def self.database_tableName
      @database_tableName
    end
  else
    def self.database_filename
      @database_filename
    end
  end

end
