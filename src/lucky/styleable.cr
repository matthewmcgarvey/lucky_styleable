require "./styleable/css_parser"

module Lucky::Styleable
  VERSION = "0.1.0"

  module ClassMethods
    macro extended
      macro vars
        @@styles = Hash(String, String).new
        @@_compiled : Css::Stylesheet? = nil
        @@_css : String? = nil
        @@_file_path : String = __FILE__
      end
      vars

      macro inherited
        vars
      end
    end

    def styles
      compiled
      @@styles
    end

    def compiled : Css::Stylesheet
      @@_compiled ||= compile_css
    end

    def compile_css
      css = @@_css
      if css.nil?
        css_file_name = @@_file_path.gsub(/\.cr$/, ".css")
        css = load_from_file(css_file_name)
      end

      if css.nil? || css.blank?
        return Css::Stylesheet.new
      end

      stylesheet = CssParser.parse(css)
      css_classes = stylesheet.classes
      css_ids = stylesheet.ids
      component_name = self.name.split("::").last
      component_hash = Digest::MD5.hexdigest(component_name)[0, 5]

      css_classes.each do |css_class|
        new_class = "#{component_name}_#{component_hash}_#{css_class}"
        @@styles[css_class] = new_class
        stylesheet.update_class(css_class, new_class)
      end

      css_ids.each do |css_id|
        new_id = "#{component_name}_#{component_hash}_#{css_id}"
        @@styles[css_id] = new_id
        stylesheet.update_id(css_id, new_id)
      end

      stylesheet
    end

    def load_from_file(file : String) : String?
      if File.exists?(file)
        File.read(file)
      end
    end
  end

  macro included
    extend ClassMethods
  end

  macro css(arg)
    @@_css = {{ arg }}
  end

  def styles
    self.class.styles
  end

  def style_tag
    style self.class.compiled.to_s
  end
end
