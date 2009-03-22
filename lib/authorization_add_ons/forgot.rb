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
      
      def self.find_for_forget(email)
        find :first, :conditions => ['email = ? and activated_at IS NOT NULL', email]
      end
      
      def make_password_reset_code
        self.password_reset_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
      end
    end # instance methods
  end
end
