class Lucky::Styleable::Css::Rule
  getter selectors : Array(Css::Selector)
  getter declarations : Array(Css::Declaration)

  def initialize(@selectors, @declarations)
  end

  def classes : Array(String)
    selectors.map(&.classes).flatten.uniq
  end

  def ids : Array(String)
    selectors.map(&.ids).flatten.uniq
  end

  def update_class(old_class, new_class)
    selectors.select(&.classes.includes?(old_class))
      .each(&.update_class(old_class, new_class))
  end

  def update_id(old_id, new_id)
    selectors.select(&.ids.includes?(old_id))
      .each(&.update_id(old_id, new_id))
  end

  def to_s
    selector_string = selectors.map(&.value).join(", ")
    declaration_string = declarations.map(&.to_s).join
    "#{selector_string} {\n#{declaration_string}}\n"
  end
end
