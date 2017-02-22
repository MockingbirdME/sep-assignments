require 'sqlite3'
require 'bloc_record/schema'

module Persistence
  def self.included(base)
    base.extend(ClassMethods)
  end

  def save
    self.save! rescue false
  end

  def save!
    unless self.id
      self.id = self.class.create(BlocRecord::Utility.instance_variables_to_hash(self)).id
      BlocRecord::Utility.reload_obj(self)
      return true
    end
    fields = self.class.attributes.map { |col| "#{col}=#{BlocRecord::Utility.sql_strings(self.instance_variable_get("@#{col}"))}" }.join(",")

    self.class.connection.execute <<-SQL
       UPDATE #{self.class.table}
       SET #{fields}
       WHERE id = #{self.id};
    SQL

    true
  end

  def update_attribute(attribute, value)
    self.class.update(self.id, {attribute => value})
  end

  def update_attributes(updates)
    self.class.update(self.id, updates)
  end

  module ClassMethods

    def update_all(updates)
      update(nil, updates)
    end

    def update(ids, updates)
      updates = BlocRecord::Utility.convert_keys(updates)
      updates.delete "id"
      updates_array = updates.map { |key, value| "#{key}=#{BlocRecord::Utility.sql_strings(value)}" }

      if ids.class == Fixnum
        where_clause = "WHERE id=#{ids};"
      elsif ids.class == Array
        where_clause = ids.empty? ? ";" : "WHERE id IN (#{ids.join(",")});"
      else
        where_clause = ";"
      end

      connection.execute <<-SQL
          UPDATE #{table}
          SET #{updates_array * ","} #{where_clause}
      SQL
      true
    end

    def create(attrs)
      attrs = BlocRecord::Utility.convert_keys(attrs)
      attrs.delete "id"
      vals = attributes.map { |key| BlocRecord::Utility.sql_strings(attrs[key]) }

      connection.execute <<-SQL
         INSERT INTO #{table} (#{attributes.join ","})
         VALUES (#{vals.join ","});
      SQL

      data = Hash[attributes.zip attrs.values]
      data["id"] = connection.execute("SELECT last_insert_rowid();")[0][0]
      new(data)
    end

    def destroy(*id)
      if id.length > 1
        where_clause = "WHERE id IN (#{id.join(",")});"
      else
        where_clause = "WHERE id = #{id.first};"
      end
      connection.execue <<-SQL
        DELETE FROM #{table} #{where_clause}
      SQL

      true
    end

    def destroy
      self.class.destroy(self.id)
    end

    def destroy_all(args=nil)
      if args && !args.empty?
        if args > 1
          args.each {|arg| destroy_all(arg)}
        else
        case args.first
        when String
          conditions = args.first
        when Hash
          args = BlocRecord::Utility.convert_keys(args)
          conditions = args.map {|k,v| "#{k}=#{BlockRecord::Utility.sql_strings(v)}"}.join(" and ")
        end
        connection.execute <<-SQL
          DELETE FROM #{table}
          WHERE #{conditions};
        SQL
      else
        connection.execute <<-SQL
          DELETE FROM #{table}
        SQL
      end
      true
    end


    protected

    def method_missing(meth_symb, *args)
      meth_string = meth_symb.to_s
      if meth_string =~ /^update_(.*)/
        attribute = find_attr_for_update(meth_string)
        unless attribute.nil
          update_attribute(attribute, *args)
        else
          puts "no method #{meth_string}, please try again"
        end
      end
    end

    private

    def find_attr_for_update(string)
      arry = string.split(/[_]/)
      arry.length == 2 ? arry[-1] : nil
    end

  end

end
