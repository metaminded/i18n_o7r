module I18nO7r
  module ApplicationHelper
    def i18n_o7r_link_missing_to(path)
      <<-HTML
        <script type="text/javascript">
        $(document).on('click', '.translation_missing[title*="translation missing: "]', function(){
          var node = $(this);
          var t = node.attr('title');
          var p = t.split(': ')[1].split('.').replace(/\//g, '-').slice(1).join('/');

        });
        </script>
      HTML
    end

    def i18n_o7r_translations_path(path_components=[])
      pc = [path_components].flatten
      p = pc.map{|c| c.to_s.gsub('/', '--')}.join('/')
      i18n_o7r.translations_path(p)
    end
  end
end


__END__

translation_missing
title="translation missing: de.shop.application.navbar.logout"
