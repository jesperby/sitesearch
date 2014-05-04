SimpleForm.setup do |config|
  config.wrappers :basic, tag: 'div', class: 'form-group', error_class: 'warning' do |b|
    b.use :html5
    b.use :placeholder
    b.use :label, class: 'control-label'

    b.wrapper tag: 'div', class: 'controls' do |ba|
      ba.use :input, class: 'form-control'
      ba.use :error, wrap_with: { tag: 'span', class: 'help-block' }
      ba.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end
  end

  config.wrappers :addon_after, tag: 'div', class: "input-group", error_class: 'warning' do |b|
    b.use :html5
    b.use :placeholder
    b.use :label
    b.use :input
    b.wrapper tag: 'span', class: 'input-group-btn' do |button|
      button.use :input
    end
    b.use :error, wrap_with: { tag: 'p', class: 'help-block' }
    b.use :hint,  wrap_with: { tag: 'span', class: 'help-block' }
  end
end
