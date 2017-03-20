module BlocRecord
  def self.connect_to(dbname, db_type)
    @db_type = db_type.to_s
    @database_name = dbname
  end

  def self.db_type
    @db_type
  end

  def self.db_name
    @database_name
  end

end
