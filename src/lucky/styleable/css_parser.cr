require "./css/*"

class Lucky::Styleable::CssParser
  def self.parse(styles : String) : Css::Stylesheet
    new(IO::Memory.new(styles)).parse
  end

  @css_stylesheet = Css::Stylesheet.new

  def initialize(@style_io : IO::Memory)
  end

  def parse : Css::Stylesheet
    while @style_io.peek && !@style_io.peek.try(&.empty?)
      selectors = parse_selectors
      next if selectors.nil?

      declarations = parse_declarations
      @css_stylesheet.rules << Css::Rule.new(selectors, declarations)
    end
    @css_stylesheet
  end

  def parse_selectors : Array(Css::Selector)?
    selectors = @style_io.gets('{')
    return if selectors.nil? || selectors.strip.empty?

    selectors.chomp('{')
      .split(',')
      .map { |selector| Css::Selector.new(selector.strip) }
  end

  def parse_declarations : Array(Css::Declaration)
    declarations = @style_io.gets('}')
    return [] of Css::Declaration if declarations.nil? || declarations.blank?

    declarations.chomp('}')
      .split(';')
      .map(&.strip)
      .reject(&.blank?)
      .map do |declaration|
        decl = declaration.split(':')

        Css::Declaration.new(decl[0].strip, decl[1].strip)
      end
  end
end
