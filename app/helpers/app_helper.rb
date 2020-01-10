module AppHelper

  def pluralize(string, count)
      return "#{count} #{string}#{count != 1 ? "s" : ""}"
  end

  def format_message_to_html(message)
      return message.split("\n\n").map { |s| "<p class=\"card-text lead\">#{s}</p>" }.join("")
  end
end
