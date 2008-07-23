module Tickler

  class Initializer

    def self.run(&block)
      self.class_eval(&block)
    end

    def self.task_adapter(name, &block)
      @task_adapter = TaskAdapter.set(name)
      @task_adapter.instance_eval(&block)
    end

    @@column_widths = 
    {
      :id => 10,
      :title => 60
    }

    def self.column_widths(options=nil)
      if options
        @@column_widths = options
      end
      return @@column_widths
    end

    @@column_order = [ :id, :title ]

    def self.column_order(options=nil)
      if options
        @@column_order = options
      end
      return @@column_order
    end


  end

end
