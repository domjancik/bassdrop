require 'i18n/backend/fallbacks'
I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)

I18n.default_locale = :cs
I18n.fallbacks.map(cs: :en)