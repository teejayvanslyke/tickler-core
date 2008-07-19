module Tickler

  class Initializer

    def self.run(&block)
      self.class_eval(&block)
    end

    def self.task_adapter(name, &block)
      @task_adapter = TaskAdapter.set(name)
      @task_adapter.instance_eval(&block)
    end

  end

end
