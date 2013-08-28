class EmailFormatValidator < ActiveModel::EachValidator
    def validate_each(object, attribute, value)
        unless value =~ /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
            object.errors[attribute] << (options[:message] || I18n.t('incorrect_email'))
        end
    end
end

module ActiveModel::Validations::HelperMethods
  def validates_email_format(*attr_names)
    validates_with EmailFormatValidator, _merge_attributes(attr_names)
  end
end