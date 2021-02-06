module ApplicationHelper
  def error_for(model, field)
    return nil if model.errors.messages[field].blank?

    message = "#{field.to_s.titleize} #{model.errors.messages[field].first}"
    content_tag :div, message, class: 'error'
  end
end
