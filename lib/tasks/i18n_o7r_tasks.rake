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
end
