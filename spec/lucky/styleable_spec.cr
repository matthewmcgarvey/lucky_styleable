require "../spec_helper"

describe Lucky::Styleable do
  it "works" do
    result = IO::Memory.new
    StyledComponent.new.view(result).context(with_context).render

    puts result
  end
end

def with_context
  response = HTTP::Server::Response.new(IO::Memory.new)
  request = HTTP::Request.new("GET", "/")
  HTTP::Server::Context.new(request, response)
end
