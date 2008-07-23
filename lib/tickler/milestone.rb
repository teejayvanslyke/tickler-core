module Tickler

  class Milestone

    attr_reader :attributes

    # Initialize this milestone with a set of attributes
    # (repository-specific).
    def initialize(attributes={})
      @attributes = attributes
    end

    # Create a new milestone and push it to the repository.
    def Milestone.create(attributes={})
      @milestone = new(attributes)
      Tickler::TaskAdapter.get.save_milestone(@milestone)
      return @milestone
    end

    # Find milestones in the repository
    def Milestone.find(*args)
      Tickler::TaskAdapter.get.find_milestones(*args)
    end

    # Need this because id is special in Ruby.
    def id; attributes[:id] || attributes['id']; end

    def method_missing(name)
      return @attributes[name] if @attributes.has_key?(name)
      return super
    end

  end

end
