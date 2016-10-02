module I18nO7r
  class Store
    module Unifyer

      def unify!
        primary_language = I18nO7r.primary_language
        other_locales = use_locales - [primary_language]
        primary_store = translations[primary_language]
        other_stores  = other_locales.map{|l| translations[l]}
        other_stores.each do |other_store|
          unifyer(primary_store, other_store)
        end
        self
      end

      private

      def unifyer(primary_store, other_store)
        other_store ||= {}
        primary_store.each do |key, val|
          case val
          when Hash
            other_store[key] = {} unless other_store[key].is_a?(Hash)
            unifyer(val, other_store[key])
          when Array
            other_store[key] ||= val.map {|v| nil }
          else
            other_store[key] ||= nil
          end
        end
      end

    end # Unifyer
  end # Store
end # I18nO7r
