class Developer
    # Dynamically define a method for each role
    %w[backend frontend].each do |role|
       define_method(role) do
         "I am a #{role} developer"
       end
    end
   end
   
   # Create an instance of Developer
   dev = Developer.new
   
   # Call the dynamically defined methods
   puts dev.backend    # Output: I am a backend developer
   puts dev.frontend   # Output: I am a frontend developer
   