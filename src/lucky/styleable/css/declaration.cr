class Lucky::Styleable::Css::Declaration
  getter property : String
  getter value : String

  def initialize(@property, @value)
  end

  def to_s
    "     #{property}: #{value};\n"
  end
end
