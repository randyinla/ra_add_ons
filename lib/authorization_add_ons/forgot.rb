module AuthorizationAddOns
  module Forgot
    
    def self.included( recipient )
      recipient.extend( StatefulRolesClassMethods )
      recipient.class_eval do
        include StatefulRolesInstanceMethods
      end
    end

    module StatefulRolesClassMethods
    end # class methods

    module StatefulRolesInstanceMethods
      def recently_forgot_password?
        @forgotten_password
      end
      def recently_reset_password?
        @reset_password
      end
    end # instance methods
  end
end
