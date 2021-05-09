class StyledComponent < Lucky::BaseComponent
  include Lucky::Styleable

  def render
    div class: styles["parent"] do
      text "Hello"
    end
    style_tag
  end
end
