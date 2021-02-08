module Acсessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name      = "@#{name}".to_sym
      var_name_hist = "@#{name}_history".to_sym

      define_method(name) { instance_variable_get(var_name) }

      define_method("#{name}=".to_sym) do |value|
        old_value = send(name)
        array = instance_variable_get(var_name_hist) || []

        array << old_value
        instance_variable_set var_name_hist, array
        instance_variable_set var_name, value
      end

      define_method("#{name}_history".to_sym) { instance_variable_get(var_name_hist) }
    end
  end

  def strong_attr_accessor(name, type_class)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      raise 'Тип указанного значения не соответствует заданному' unless value.is_a?(type_class)

      instance_variable_set(var_name, value)
    end
  end
end
