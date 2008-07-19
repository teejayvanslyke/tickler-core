module Tickler

  class NoTaskAdapterError < Exception; end

  class TaskAdapter

    @@registry = {}
    @@instance = nil 

    def self.set(name)
      if name == nil 
        @@instance = nil 
      else
        @@instance = create(name) 
      end
    end

    def self.get
      raise NoTaskAdapterError unless @@instance 
      @@instance
    end

    def self.register_as(name)
      @@registry[name] = self
    end

    def self.create(name)
      if !@@registry.has_key?(name)
        begin
          require 'tickler-' + name.to_s
        rescue LoadError
          raise "You need to install (or author ;-)) the "+
                "tickler-#{name} gem."
        end
      end

      @@registry[name].new
    end

  end

end
