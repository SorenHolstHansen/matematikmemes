module AppHelper
  def title(value = nil)
    @title = value if value
    @title ? @title : "Template"
  end
end
