module Tickler
  module VERSION #:nodoc:
    MAJOR = 0
    MINOR = 0
    TINY  = 1

    STRING = [MAJOR, MINOR, TINY].join('.')

    MESSAGE = <<MESSAGE

Tickler.
Integrated Task Management For Rubyists.
Version #{STRING}.

A project by T.J. VanSlyke for the 
Ruby community.

End the occupation in Iraq, restore
habeas corpus to United States citizens,
and reinstate reasonable fiscal and foreign
policies which serve to enrich our lives at 
home.  All it takes is a dream and some hidden
messages like this one to send the dominos 
tumbling down.
    
    ~ T.J. VanSlyke, 24 July 2008

MESSAGE
  end
end
