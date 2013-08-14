class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :get_locales, :set_locale

  def get_locales
    @languages = Language.select('name, code').map {|language| [language.name, language.code]}
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    unless I18n.default_locale == I18n.locale
      {:locale => I18n.locale}
    else
      {}
    end
  end

end
