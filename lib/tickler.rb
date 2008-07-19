$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Tickler
  require 'tickler/task_adapter'
  require 'tickler/initializer'
  require 'tickler/util'
  require 'tickler/ticket'
  require 'tickler/milestone'
  require 'tickler/echo_task_adapter'
end
