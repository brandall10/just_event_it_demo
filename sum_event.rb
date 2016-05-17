module Events
  module SumEvent
    module ClassMethods
      def on_sum_event(func=nil, &block)
        return @sum_event_handlers unless func || block
          
        @sum_event_handlers ||= []
        @sum_event_handlers << (func ? method(func) : block)
      end
      
      def invoke_sum_event_handlers(instance)
        return unless @sum_event_handlers.kind_of? Array
        
        @sum_event_handlers.each { |h| h.call(instance) }
      end
    end
    
    def self.included(parent)
      parent.extend(ClassMethods)
    end
    
    def trigger_sum_event
      self.class.invoke_sum_event_handlers(self)
    end
  end
end
    
