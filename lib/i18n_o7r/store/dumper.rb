module I18nO7r
  class Store
    module Dumper

      def dump(target, cleanup: false)
        if cleanup
          savepath = File.join(Rails.root, 'tmp', 'i18n_o7r', "#{Time.now.to_i}-saved-locales")
          FileUtils.mkdir_p(savepath)
          files = Dir[File.join(target, '*')]
          files.each do |file|
            FileUtils.move file, savepath
          end
        end
        dumper(translations, [], target)
      end

      def dump!
        dump(I18nO7r.locales_root, cleanup: true)
        reload!
        reload_i18n!
        self
      end

      private

      def dumper(hash, kpath, fpath)
        h = {}
        if I18nO7r.flatten_after && kpath.length >= I18nO7r.flatten_after
          h = hash
        else
          hash.each do |key, val|
            if val.is_a?(Hash) && val.keys != [:html]
              FileUtils.mkdir_p fpath
              dumper(val, kpath.dup << key.to_s, File.join(fpath, key.to_s.gsub('/', '-')))
            else
              h[key.to_s] = val
            end
          end
        end
        if h.present?
          begin
            store = YAML::Store.new "#{fpath}.yml"
            store.transaction do
              hh = kpath.inject(store){|a,e|a[e.to_s] = {}}
              h.sort.each do |k,v|
                hh[k.to_s] = v
              end # each
            end # transaction
          rescue
            raise "#{fpath}: #{h.inspect}"
          end
        end # if h
      end
    end # Dumper
  end # Store
end # I18nO7r
