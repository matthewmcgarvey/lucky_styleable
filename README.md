# Lucky Styleable

Scoped CSS for your Lucky HTML pages and components.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     lucky_styleable:
       github: matthewmcgarvey/lucky_styleable
   ```

2. Run `shards install`

## Usage

```crystal
require "lucky_styleable"
```

Include the module in the component you want to style

```crystal
# src/components/base/header.cr
class Base::Header < BaseComponent
  include Lucky::Styleable

  def render
    div class: styles['header'] do
      h2 "HEADER", styles['header-title']
    end
    style_tag
  end
end
```

Then in css

```css
# src/components/base/header.css
.header {
  width: 100%;
  height: 20px;
}

.header-title {
  color: red;
}
```

The css will be modified/scoped so that it doesn't bleed into other places outside of the component.

## Contributing

1. Fork it (<https://github.com/matthewmcgarvey/lucky_styleable/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [matthewmcgarvey](https://github.com/matthewmcgarvey) - creator and maintainer
