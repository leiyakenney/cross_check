class Renderer
  attr_reader :template

  def initialize
    @template = File.open('./site/webpage.erb', &:read)
  end

  def render
    ERB.new(template).result(binding)
  end
end

Renderer.new.render
