module BlocRecord
  def self.connect_to(dbname, dbType)
    @db_type = dbType.to_s
    @database_name = dbname
  end

  def self.db_type
    @db_type
  end

  def self.db_name
    @database_name
  end

end
