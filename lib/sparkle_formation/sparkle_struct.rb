require 'sparkle_formation'
require 'attribute_struct/monkey_camels'

class SparkleFormation
  # SparkleFormation customized AttributeStruct
  class SparkleStruct < AttributeStruct

    include ::SparkleFormation::SparkleAttribute
    # @!parse include ::SparkleFormation::SparkleAttribute

    # Override initializer to force desired behavior
    def initialize(*_)
      super
      @_camel_keys = true
      _set_state :hash_load_struct => true
    end

    # Set SparkleFormation instance
    #
    # @param inst [SparkleFormation]
    # @return [SparkleFormation]
    def _set_self(inst)
      unless(inst.is_a?(::SparkleFormation))
        ::Kernel.raise ::TypeError.new "Expecting type of `SparkleFormation` but got `#{inst.class}`"
      end
      @self = inst
    end

    # @return [SparkleFormation]
    def _self(*_)
      unless(@self)
        if(_parent.nil?)
          ::Kernel.raise ::ArgumentError.new 'Creator did not provide return reference!'
        else
          _parent._self
        end
      else
        @self
      end
    end

    # @return [Class]
    def _klass
      ::SparkleFormation::SparkleStruct
    end

    # Override the state to force helpful error when no value has been
    # provided
    #
    # @param arg [String, Symbol] name of parameter
    # @return [Object]
    # @raises [ArgumentError]
    def _state(arg)
      result = super
      unless(result)
        ::Kernel.raise ::ArgumentError.new "No value provided for compile time parameter: `#{arg}`!"
      end
      result
    end
    alias_method :state!, :_state

  end
end
