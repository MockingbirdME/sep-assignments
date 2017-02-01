require 'sqlite3'

module Selection

  def find(*ids)
   if ids.length == 1
     find_one(ids.first)
   else
     ids.each { |id| validate_id(id) }
     rows = connection.execute <<-SQL
       SELECT #{columns.join ","} FROM #{table}
       WHERE id IN (#{ids.join(",")});
     SQL

     rows_to_array(rows)
   end
  end

  def find_one(id)
    validate_id(id)
    row = connection.get_first_row <<-SQL
      SELECT #{columns.join ","} FROM #{table}
      WHERE id = #{id};
    SQL

    init_object_from_row(row)
   end

   def find_by(attribute, value)
     row = connection.get_first_row <<-SQL
       SELECT #{columns.join ","} FROM #{table}
       WHERE #{attribute} = #{BlocRecord::Utility.sql_strings(value)};
     SQL

     init_object_from_row(row)
   end


    def take_one
      row = connection.get_first_row <<-SQL
        SELECT #{columns.join ","} FROM #{table}
        ORDER BY random()
        LIMIT 1;
      SQL

      init_object_from_row(row)
    end

    def take(num=1)
      unless num.is_a(Integer)
        raise ArgumentError.new'argument for take must be a interger if one is supplied'
      end
      if num > 1
        rows = connection.execute <<-SQL
          SELECT #{columns.join ","} FROM #{table}
          ORDER BY random()
          LIMIT #{num};
        SQL

        rows_to_array(rows)
      else
        take_one
      end
    end

    def first
      row = connection.get_first_row <<-SQL
        SELECT #{columns.join ","} FROM #{table}
        ORDER BY id
        ASC LIMIT 1;
      SQL

      init_object_from_row(row)
    end

    def last
      row = connection.get_first_row <<-SQL
        SELECT #{columns.join ","} FROM #{table}
        ORDER BY id
        DESC LIMIT 1;
      SQL

      init_object_from_row(row)
    end

    def all
      rows = connection.execute <<-SQL
        SELECT #{columns.join ","} FROM #{table};
      SQL

      rows_to_array(rows)
    end

    def find_each(hashed_params)
      find_in_batches(hashed_params) do |batch|
        batch.each { |row| yield(row)}
    end

    def find_in_batches(hashed_params)
      hashed_params[:start] = 0 if hashed_params[:start] == nil
      hashed_params[:batch_size] = 5000 if hashed_params[:batch_size] == nil
      rows = connection.execute <<-SQL
        SELECT #{columns.join ","} FROM #{table};
        LIMIT #{hashed_params[:batch_size]}
        OFFSET #{hashed_params[:start]}
      SQL

      yield(rows)
    end

    def where(*args)
      if args.count > 1
        expression = args.shift
        params = args
      else
        case args.first
        when String
          expression = args.first
        when Hash
          expression_hash = BlocRecord::Utility.convert_keys(args.first)
          expression = expression_hash.map {|key, value| "#{key}=#{BlocRecord::Utility.sql_strings(value)}"}.join(" and ")
        end
      end

      sql = <<-SQL
        SELECT #{columns.join ","} FROM #{table}
        WHERE #{expression}
      SQL

      rows = connection.execute(sql, params)
      rows_to_array(rows)
    end


    def order(*args)
      order = ""
      count = 0
      args.each do |arg|
        order += ", " if count > 0
        case arg
        when String
          order += arg
        when Symbol
          order += arg.to_s
        when Hash
          arg.each { |k,v| order += "#{k} #{v}" }
        end
        count += 1
      end
      rows = connection.execute <<-SQL
        SELECT * FROM #{table}
        ORDER BY #{order};
      SQL
      rows_to_array(rows)
    end

    def join(*args)
      if args.count > 1
        joins = args.map { |arg| "INNER JOIN #{arg} ON #{arg}.#{table}_id = #{table}.id"}.join(" ")
        rows = connection.execute <<-SQL
          SELECT * FROM #{table} #{joins}
        SQL
      else
        case args.first
        when String
          rows = connection.execute <<-SQL
            SELECT * FROM #{table} #{BlocRecord::Utility.sql_strings(args.first)};
          SQL
        when Symbol
          rows = connection.execute <<-SQL
            SELECT * FROM #{table}
            INNER JOIN #{args.first} ON #{args.first}.#{table}_id = #{table}.id
          SQL
        when Hash
          join("#{args.key}", "#{args.value}")
      end

      rows_to_array(rows)
    end

    protected

    def method_missing(meth_symb, *args)
      meth_string = meth_symb.to_s
      if meth_string =~ /^find_by_(.*)/
        attribute = find_attr(meth_string)
        unless attribute.nil
          find_by(attribute, *args)
        else
          puts "no method #{meth_string}, please try again"
        end
      end
    end

   private
    def validate_id(id)
      if (id.is_a?(Integer)) && (id >= 0)
        return
      else
        raise ArgumentError.new 'invalid id, id must be a non-negative interger'
      end
    end

   def init_object_from_row(row)
     if row
       data = Hash[columns.zip(row)]
       new(data)
     end
   end

   def rows_to_array(rows)
     collection = BlocRecord::Collection.new
     rows.each { |row| collection << new(Hash[columns.zip(row)]) }
     collection
   end

   def find_attr(string)
     arry = string.split(/[_]/)
     arry.length == 3 ? arry[-1] : nil
   end

end
