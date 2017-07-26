module ReviHelper
    extend ActiveSupport::Concern

    module ClassMethods
      def bodily_injury(value)
        if value == '_SUPERIOR_PROTECTION'
          '250/500'
        elsif value == '_STANDARD_PROTECTION'
          '100/300'
        elsif value == '_BASIC_PROTECTION'
          '50/100'
        else
          '25/50'
        end
      end

      def property_damage(value)
        if value == '_SUPERIOR_PROTECTION'
          '10000'
        elsif value == '_STANDARD_PROTECTION'
          '10000'
        elsif value == '_BASIC_PROTECTION'
          '5000'
        else
          '5000'
        end
      end

      def lic_ever_suspended(value)
        if value == '_ACTIVE'
          'No'
        elsif value == '_EXPIRED'
          'No'
        else
          'Yes'
        end
      end

      def one_way_distance(value)
        if value == 0
          '0'
        elsif value <= 3
          '1-3'
        elsif value <= 5
          '4-5'
        elsif value <= 9
          '6-9'
        elsif value <= 19
          '10-19'
        elsif value <= 49
          '20-49'
        else
          '50+'
        end
      end

    end
end