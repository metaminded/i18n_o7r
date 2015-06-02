require_relative './store/dumper.rb'
require_relative './store/unifyer.rb'

class I18nO7r::Store
  include Dumper
  include Unifyer

  attr_reader :backend, :use_locales, :translations, :locales_paths

  def initialize(locales_paths: nil, use_locales: nil)
    @backend = I18n::Backend::Simple.new
    @locales_paths = locales_paths || Dir[File.join(I18nO7r.locales_root, '**/*.yml')]
    @backend.load_translations @locales_paths
    @use_locales = (use_locales || I18nO7r.languages || I18n.available_locales).map(&:to_sym)
    @translations = @backend.send(:translations).dup
    @translations.keys.each do |lang|
      next if @use_locales.member? lang
      @translations.delete(lang)
    end
  end

  def lookup(locale, key)
    @backend.send(:lookup, locale, key, [], show_missing: true, ignore_replace: true)
  end

  def for(keys, locale: nil)
    vv = keys.inject(translations[locale.try(:to_sym) || I18nO7r.primary_language]) do |a,e| a[e.to_sym] end
  end

  def reload!
    @backend.reload!
    paths = @locales_paths.select{|p| File.exist?(p)}
    paths += Dir[File.join(I18nO7r.locales_root, '**/*.yml')]
    @backend.load_translations paths.uniq
  end

  def reload_i18n!
    paths = I18n.load_path.select{|p| File.exist?(p)}
    paths += Dir[File.join(I18nO7r.locales_root, '**/*.yml')]
    I18n.load_path = paths.uniq
    I18n.reload!
  end
end
