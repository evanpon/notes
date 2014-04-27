module NotesHelper
  def for_display(content)
    CGI::escapeHTML(content).gsub(/\r\n/, '<br />')
  end
end
