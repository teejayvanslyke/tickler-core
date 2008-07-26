require 'optparse'
require 'tickler/version'

module Tickler
  class Util

    @@aliases =
      {
        'ls'  => 'list',
        'add' => 'create'
      }

    @@options = 
      {
      }
    @@mandatory_options = %w(  )

      def Util.run(args=[])
        begin
          parse_options
          load_config
        rescue LoadError
          error("No Ticklerfile in this directory.  Run 'tickler init' "+
                "to create a brand-spankin' new template file in your working directory.")
          return
        end

        if args==nil || args.length==0 
          print_usage 
          return
        end

        command = args[0]

        # Look to see whether the user has entered a command alias
        # and translate it.
        if @@aliases.has_key?(command)
          command = @@aliases[command]
        end

        args.shift

        case command
        when 'create';  create(args)
        when 'info';    info(args)
        when 'list';    list(args)
        end
      end

      def Util.parse_options
        parser = OptionParser.new do |opts|
          opts.banner = usage
          opts.separator "Additional options:"
          opts.on("-h", "--help",
                  "Show this help message.") { puts opts; exit }
          opts.on("-V", "--version",
                  "Print version information.") { puts Tickler::VERSION::MESSAGE; exit }
          opts.parse!(ARGV)

          if @@mandatory_options && @@mandatory_options.find { |option| @@options[option.to_sym].nil? }
            puts opts; exit
          end
        end

        path = @@options[:path]
      end

      private 

      def Util.create(args=[])
        what = args[0]
        args.shift

        case what 
        when 'ticket';    create_ticket(args)
        when 'milestone'; create_milestone(args)
        end
      end

      # Parse attributes from command line arguments formatted
      # as such:
      #
      #   attr:val attr2:"multi-word value" attr3:323
      #
      def Util.parse_attributes(arr)
        attributes = {}
        arr.each do |attribute_and_value| 
          pair = attribute_and_value.split(':')
          key = pair[0].to_sym
          val = pair[1]
          if val[0] == 34 && val[val.length-1] == 34
            val = val[1,val.length-2]
          end
          attributes[key] = val 
        end
        return attributes
      end

      def Util.create_ticket(args=[])
        if args.length < 1
          error("You need to specify a title for your ticket.\n" + 
               "For instance:\n"+
               "\ttickler create ticket \"As a user, I want to " +
               "take over the world so I don't have to work anymore.\"")
          return
        end

        title = args[0]
        attributes = parse_attributes(args[1,args.length-1])

        Ticket.create(attributes.merge(:title => title))
      end

      def Util.create_milestone(args)
        if args.length < 1
          error("You need to specify a title for your new milestone.\n" + 
               "For instance:\n"+
               "\ttickler create milestone \"IE Bugfest")
          return
        end

        title = args[0]

        Milestone.create(:title => title)
      end

      def Util.info(args=[])
        if args.size < 2
          print_usage('info')
          return
        end

        what = args[0]
        args.shift

        case what
        when 'ticket'
          @ticket = Ticket.find(args[0])
          print_ticket_info(@ticket)
        end
      end

      def Util.load_config
        load Dir.pwd + '/Ticklerfile' 
      end

      def Util.list(args=[])
        what = args[0] || 'tickets'
        args.shift

        case what
        when 'tickets'
          if args.length > 0
            attributes = parse_attributes(args)
          else
            attributes = {}
          end

          @tickets = Ticket.find(:all, attributes)
          @tickets.each do |ticket|
            print_row(:id => ticket.id, :title => ticket.title)
          end
        when 'milestones'
          @milestones = Milestone.find(:all)
          @milestones.each do |milestone|
            print_row(:id => milestone.id, :title => milestone.title)
          end
        end
      end

      def Util.error(text)
        puts text
      end

      def Util.usage(command=nil)
        case command
        when 'info'
          "usage: TODO"
        else
          <<USAGE
Tickler will respond to the following commands:

  create ( ticket  | milestone  )
  info   ( ticket  | milestone  )
  list   ( tickets | milestones )
  help   <command>

If you type something crazy, I'll probably be 
here to rub it in your face.
USAGE
        end
      end


      def Util.print_usage(command=nil)
        print usage(command)
      end

      def Util.print_row(columns)
        Initializer.column_order.each do |name|
          column = columns[name].to_s.align_left(Initializer.column_widths[name])
          print column + ' '
        end
        print "\n"
      end

      def Util.print_separator
        print "===============================================================================\n"
      end

      def Util.println(text)
        print text + "\n"
      end

      def Util.print_ticket_info(ticket)
        println "- #{ticket.id} -".align_center(20) + ticket.title
        print_separator
        ticket.attributes.each do |attr,val|
          println attr.to_s.capitalize.align_right(14) + "     " + val.to_s.truncate(40)
        end
      end
  end
end

