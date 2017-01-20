## What's a RubyGem and why would you use one?
+ A ruby gem is much like a ruby module but rather than being called in various parts of the application that contains it can be included in any ruby application by adding it to the application's gem file.  Gems are a wonderful way to reuse code in more than one application, because of the ruby community there are many gems available for free for anyone who wishes to use them. Using a gem created by another programer/programing team allows the individual or group using it to save valuable time adding the functions they desire from the gem to their own code, and for new programers can allow them powerful functionality that may be beyond their current skill to create themselves.

## What's the difference between lazy and eager loading?
+ Lazy loading is a design pattern that where the object(s) in question are not created/calculated/ect. until the first time they are needed.  Lazy loading contrasts with eager loading which is an alternate design pattern.  When utilizing eager loading the object being loaded is created/calculated/etc. when the model object it is a part of is initialized.

## What's the difference between the CREATE TABLE and INSERT INTO SQL statements?
+ CREATE TABLE creates a new table in the database.  INSERT INTO adds a new row of data to a table in the database.

## What's the difference between extend and include? When would you use one or the other?
+  Include makes all of the methods of the included module instance methods for each instance of the class that includes the module.  Extend makes all of the methods of the extended module class methods for the class that includes it.  Which of these two you would use depends on how you want to be able to call the methods.  If each instance of the class should be able to call the methods, and potentially be modified by them, then you need to use include; on the other hand if the class itself is where you want the methods called (for example a method that sorts or searches the instances of that class to return a specific one) need to be class methods and you would therefor use extend.

## In persistence.rb, why do the save methods need to be instance (vs. class) methods?
+ by insuring that the save methods are instance methods any instance of a class that includes the persistence module may save itself without worrying about how the call may be affecting other instances of the class. If we used extend instead of include to make these class methods we would need to have the method accept an argument that would be used to figure out which instance needed to be saved.

## Given the Jar-Jar Binks example earlier, what is the final SQL query in persistence.rb's save! method?
+ UPDATE #{character}
  SET #{character_name, star_rating}
  WHERE id = #{1}; assuming we had created no characters before this monstrosity.  

## AddressBook's entries instance variable no longer returns anything. We'll fix this in a later checkpoint. What changes will we need to make?
+ I don't understand the question.  the entries instance variable is not a method that would return something, if we want it to return something we'd need to write a method for it to do so. 
