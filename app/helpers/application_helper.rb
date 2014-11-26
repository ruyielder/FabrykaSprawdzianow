module ApplicationHelper

  def error_message!
    return '' if resource.errors.empty?
    field, error = resource.errors.first
    message = "#{field} #{error}"

    html = <<-HTML
    <div class="alert alert-danger" role="alert">
      <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
      <span class="sr-only">Error:</span>#{message}
    </div>
    HTML

    html.html_safe
  end

end
