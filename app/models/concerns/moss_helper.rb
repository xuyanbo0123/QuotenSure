module MossHelper
    extend ActiveSupport::Concern

    module ClassMethods
      def bool_to_s(value)
        if value
          'Yes'
        else
          'No'
        end
      end
    end
end