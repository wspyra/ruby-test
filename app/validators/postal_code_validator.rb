class PostalCodeValidator < ActiveModel::EachValidator
  def validate_each(record, attr_name, value)
    unless value =~ /^([0-9]{2})(-[0-9]{3})?$/i
      record.errors.add(attr_name, :postal_code, options.merge(:value => value))
    end
  end
end

module ActiveModel::Validations::HelperMethods
  def validates_postal_code(*attr_names)
    validates_with PostalCodeValidator, _merge_attributes(attr_names)
  end
end

module ClientSideValidations::Middleware
  class PostalCode < ClientSideValidations::Middleware::Base
    def response
      if request.params[:id] =~ /^([0-9]{2})(-[0-9]{3})?$/i
        self.status = 200
      else
        self.status = 404
      end
      super
    end
  end
end