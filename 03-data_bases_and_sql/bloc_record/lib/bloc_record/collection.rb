module BlocRecord
  class Collection < Array
    def update_all(updates)
      ids = self.map(&:id)
      self.any? ? self.first.class.update(ids, updates) : false
    end

=begin
  # first try
    def where(arg)
      puts self.first.class.attributes
      rows = self.first.class.connection.execute <<-SQL
        SELECT #{self.first.class.attributes} FROM #{self.first.class.table} WHERE (#{arg})
      SQL
      rows_to_array(rows)
    end
=end

    def not(args)
      where(args, 1)
    end

    def where(arg = nil, not_called = 0)
      to_be_returned = Collection.new
      arg_key = nil
      arg_value = nil
      if arg.class == String
        puts "where arg is string"
        arg_parts = arg.split(' ')
        if arg_parts.length == 3 && (arg_parts[1].downcase == 'IS')
          arg_key = arg_parts[0]
          arg_value = arg_parts[2]
        end
      elsif arg.class == Hash
        puts "where arg is hash"
        arg.each_key do |key|
          arg_key = key.to_s
          arg_value = arg[key].to_s
        end
      elsif arg.nil?
        return self
      else
        raise ArgumentError.new 'args for where must be either strings or hashes'
      end
      puts "#{arg_key} is key, #{arg_value} is value"
      puts self.class
      self.each do |item|
        puts "in self.each block"
        item.to_h.each_key do |key|
          if key.to_s == arg_key && not_called == 0
            puts "key == arg_key"
            to_be_returned << item if item.to_h[key] == arg_value
          elsif key.to_s == arg_key && not_called == 1
            to_be_returned << item unless item.to_h[key] == arg_value
          end
        end
      end

      puts "after self.each block"
      puts to_be_returned
      to_be_returned
    end

    def take(num = 1)
      to_be_returned = Collection.new
      if num > 1
        for i in (0..num) do
          to_be_returned << self[i]
        end
      else
        to_be_returned << self.first
      end
      to_be_returned
    end

  end

end
