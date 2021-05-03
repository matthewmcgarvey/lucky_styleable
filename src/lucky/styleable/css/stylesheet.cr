class Lucky::Styleable::Css::Stylesheet
  getter rules = [] of Css::Rule

  def classes : Array(String)
    rules.map(&.classes).flatten.uniq
  end

  def ids : Array(String)
    rules.map(&.ids).flatten.uniq
  end

  def to_s
    rules.map(&.to_s).join("\n\n")
  end

  def update_class(old_class, new_class)
    rules.select(&.classes.includes?(old_class))
      .each(&.update_class(old_class, new_class))
  end

  def update_id(old_id, new_id)
    rules.select(&.ids.includes?(old_id))
      .each(&.update_id(old_id, new_id))
  end
end
