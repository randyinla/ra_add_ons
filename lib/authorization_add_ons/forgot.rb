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
      def forgot_password
        @forgotten_password = true
        self.make_password_reset_code
      end
      
      def reset_password
        # Update password_reset code prior to setting the password_reset flog to avoid dup emails
        update_attributes(:password_reset_code => nil)
        password_reset = true
      end
      
      def recently_forgot_password?
        @forgotten_password
      end
      def recently_reset_password?
        @reset_password
      end
    end # instance methods
  end
end
