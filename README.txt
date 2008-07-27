= tickler

* http://github.com/teejayvanslyke/tickler-core/

== DESCRIPTION:

Tickler is a project-management-system agnostic interface to your favorite 
task ticketing tools.  It tries to embody the mantra of convention over  
configuration by offering developers a bridge to support any task management
system through the same interface.

tickler-core includes the command line interface for users to create and 
update tickets and milestones.  However, since Tickler aims to be platform-
agnostic, this package does not include support for actually interfacing 
with a ticket tracking tool.  The following interfaces currently exist:

* tickler-trac

== FEATURES/PROBLEMS:

* Ability to create new tickets
* Ability to list tickets according to certain criteria

== SYNOPSIS:

== Listing tickets:

$ tickler list tickets
1   As a developer, I want a ticketing system that just works!
2   As a user, I want software that just works!
...

== Creating tickets:

$ tickler create ticket "As a manager, I want developers that just work!" priority:critical

== INSTALL:

Note:  Please upgrade to RubyGems 1.2.0 before proceeding.

$ sudo gem sources -a http://gems.github.com
$ sudo gem install teejayvanslyke-tickler-core
$ sudo gem install teejayvanslyke-tickler-trac # it's the only one right now.

== LICENSE:

(The MIT License)

Copyright (c) 2008 T.J. VanSlyke

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
