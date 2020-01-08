module AppHelper
  def title(value = nil)
    @title = value if value
    @title ? @title : "Template"
  end

  def pluralize(string, count)
      return "#{count} #{string}#{count != 1 ? "s" : ""}"
  end
end
