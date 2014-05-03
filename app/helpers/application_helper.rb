module ApplicationHelper
  def header_and_page_title(title)
    content_for(:page_title, title)
    content_tag(:h1, title)
  end

  # Use to create error or notice block.
  # @param messages  [Array|String]
  # @param type      [Symbol] :notice (default) or :error
  # @param options   [Hash] optional. May contain :class
  # @return          [String] messages HTML or empty string if no messages were given.
  def messages_helper(messages, type = :notice, options = {})
    return if messages.blank?

    messages = [messages] if messages.is_a?(String)
    messages = messages.values.flatten if messages.is_a?(Hash)

    clazz = ['alert']

    clazz << case type
             when :notice
               'alert-success'
             when :warning
               'alert-warning'
             when :error
               'alert-danger'
             end

    clazz << options[:class]

    messages.uniq!
    return nil if messages.blank?

    case type
    when :error
      result = content_tag(:span, t('errors.errors_found', count: messages.size), class: '')

      msgs = messages.map do |m|
        content_tag(:li, m.html_safe)
      end

      result << content_tag(:ul, msgs.join.html_safe, class: '')
    when :notice
      msgs = messages.map do |m|
        content_tag(:div, m.html_safe)
      end
      result = msgs.join.html_safe
    when :warning
      msgs = messages.map do |m|
        content_tag(:div, m.html_safe)
      end
      result = msgs.join.html_safe
    end

    content_tag(:div, result, class: clazz.compact.join(' ').html_safe)
  end
end
