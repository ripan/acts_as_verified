# ActsAsVerified
module ActiveRecord #:nodoc:
  module Acts #:nodoc:
    module Verified #:nodoc:
      def self.included(base)
        base.extend(ClassMethods)
      end
      module ClassMethods
        def acts_as_verified
          has_one :state, :as => :verifyable , :dependent => :destroy
          before_save :check_state_change
          include ActiveRecord::Acts::Verified::InstanceMethods
        end
      end
      module InstanceMethods

        def verification_status
          if self.state.blank?
            self.build_state(:name => 'unverified')
            self.state.save
          end
          return self.state.name
        end

        def verification_status=(status)  
          self.state.update_attribute('name',status) if self.state
        end

        def set_as_verified
          self.verification_status = "verified"
        end

        def set_as_unverified
          self.verification_status = "unverified"
        end

        def check_state_change
          self.set_as_unverified if self.changed?
        end

      end
    end
  end
end
ActiveRecord::Base.send(:include, ActiveRecord::Acts::Verified)
