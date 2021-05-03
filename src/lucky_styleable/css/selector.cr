class Lucky::Styleable::Css::Selector
  CLASS_REGEX = /(\.-?[_a-zA-Z]+[_a-zA-Z0-9-]*)/
  ID_REGEX    = /(\#-?[_a-zA-Z]+[_a-zA-Z0-9-]*)/
  NOT_REGEX   = "(>?$|(?=[^_a-zA-Z0-9-]))"
  getter value : String

  def initialize(@value)
  end

  def classes : Array(String)
    value.scan(CLASS_REGEX)
      .map(&.captures)
      .flatten
      .map(&.not_nil!.strip.lchop('.'))
  end

  def ids : Array(String)
    value.scan(ID_REGEX)
      .map(&.captures)
      .flatten
      .map(&.not_nil!.strip.lchop('#'))
  end

  def update_class(old_class, new_class)
    regex = Regex.new(Regex.escape("." + old_class) + NOT_REGEX)
    @value = @value.gsub(regex, "." + new_class)
  end

  def update_id(old_id, new_id)
    regex = Regex.new(Regex.escape("#" + old_id) + NOT_REGEX)
    @value = @value.gsub(regex, "#" + new_id)
  end
end
