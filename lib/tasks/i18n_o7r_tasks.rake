# desc "Explaining what the task does"
# task :i18n_o7r do
#   # Task goes here
# end
namespace :i18n_o7r do

  desc('lorem ipsum!')
  task :dump => :environment do |t, args|
    locales_path = ENV['locales_path'] or raise "give locale_path=/path/to/my/locales"
    target = ENV['target'] or raise "give target=path/to/new/files"
    store = I18nO7r::Store.new(Dir[locales_path])
    store.dump(target)
  end

  desc('clear missing translations')
  task clear_missing_translations: :environment do |t, args|
    mt_store = YAML::Store.new(I18nO7r.missing_translations_filename)
    mt_store.transaction do
      mt_store.roots.each do |root|
        hsh = mt_store[root]
        updated_hash = traverse(hsh)
        mt_store.delete(root) if updated_hash.empty?
      end
    end # store transaction
    @store = I18nO7r::Store.new
    @store.unify!
    @store.dump!
    I18n.reload!
  end


  def traverse(hash)
    hash.each do |k, v|
      if v.respond_to?(:each)
        updated_hash = traverse(v)
        if updated_hash.empty?
          hash.delete k
        end
      else
        if v.nil?
          hash.delete(k)
        end
      end
    end
    hash
  end
end
