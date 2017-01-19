module BlocRecord
  module Utility
#   #1
    extend self

    def underscore(camel_cased_word)
#      #2
       string = camel_cased_word.gsub(/::/, '/')
#      #3
       string.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
#      #4
       string.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
#      #5
       string.tr!("-", "_")
#      #6
       string.downcase
    end

    def sql_strings(value)
       case value
       when String
         "'#{value}'"
       when Numeric
         value.to_s
       else
         "null"
       end
    end

     def convert_keys(options)
       options.keys.each {|k| options[k.to_s] = options.delete(k) if k.kind_of?(Symbol)}
       options
     end
  end
end
