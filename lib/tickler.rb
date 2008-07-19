$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Tickler
  require File.dirname(__FILE__) + '/tickler/task_adapter'
  require File.dirname(__FILE__) + '/tickler/initializer'
  require File.dirname(__FILE__) + '/tickler/util'
  require File.dirname(__FILE__) + '/tickler/ticket'
  require File.dirname(__FILE__) + '/tickler/milestone'
  require File.dirname(__FILE__) + '/tickler/echo_task_adapter'
end
