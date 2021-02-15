module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validations
      @validations ||= []
    end

    def validate(*attr_names, **args)
      types = args.keys
      types.each do |type|
        validation = { type => { attributes: attr_names, arg: args[type] } }
        validations << validation
      end
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    private

    def validate!
      self.class.validations.each do |validation|
        validation.each do |type, options|
          options[:attributes].each do |attr_name|
            send("validate_#{type}_of", attr_name, options[:arg])
          end
        end
      end
    end

    def validate_presence_of(attr_name, _arg)
      raise "You need to enter #{attr_name} " if send(attr_name).to_s.empty?
    end

    def validate_wallet_of(attr_name, _arg)
      raise "#{name}, you have enough money to continue  " if send(attr_name) <= 0
    end

    def validate_format_of(attr_name, arg)
      raise "Attribute format #{attr_name}- incorrect" if send(attr_name).to_s !~ arg
    end

    def validate_attr_type_of(attr_name, arg)
      if send(attr_name).is_a?(Array)
        send(attr_name).each { |line| invalid_type(line, arg) }
      else
        invalid_type(attr_name, arg)
      end
    end

    def invalid_type(attr_name, arg)
      unless send(attr_name).instance_of?(arg)
        raise "Attribute type #{attr_name}- does not match the given (#{arg})"
      end
    end

    def validate_uniqueness_of(attr_name, _arg)
      if self.class.all.keys.include?(send(attr_name))
        raise "#{self.class} with such #{attr_name} already exists"
      end
    end
  end
end
