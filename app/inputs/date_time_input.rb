class DateTimeInput < SimpleForm::Inputs::DateTimeInput
  def input
    template.content_tag(:div, super, class: 'form-inline')
  end

  def input_html_options
    options = super
    options[:class] ||= ''
    options[:class] << ' form-group'
    options
  end
end
