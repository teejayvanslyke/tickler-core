module Tickler
  class Util

      def Util.run(args=[])
        begin
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
        args.shift

        case command

        when 'create'
          what = args[0]
          args.shift

          case what 
          when 'ticket';    create_ticket(args)
          when 'milestone'; create_milestone(args)
          end
        when 'list'
          what = args[0] || 'tickets'
          args.shift

          case what
          when 'tickets'
            @tickets = Ticket.find(:all)
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
      end

      private 
      def Util.create_ticket(args=[])
        if args.length < 1
          error("You need to specify a title for your ticket.\n" + 
               "For instance:\n"+
               "\ttickler create ticket \"As a user, I want to " +
               "take over the world so I don't have to work anymore.\"")
          return
        end

        title = args[0]
        attributes = {}
        args[1,args.length-1].each do |attribute_and_value| 
          pair = attribute_and_value.split(':')
          attributes[pair[0].to_sym] = pair[1]
        end

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

      def Util.load_config
        load Dir.pwd + '/Ticklerfile' 
      end

      def Util.error(text)
        puts text
      end

      def Util.print_usage
        puts "usage: TODO"
      end

      def Util.print_row(columns)
        Initializer.column_order.each do |name|
          column = columns[name].align_left(Initializer.column_widths[name])
          print column + ' '
        end
        print "\n"
      end
  end
end

