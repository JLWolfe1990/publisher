module NavHelper
  def is_active?(name)
    if controller_name.include?(name) && !is_welcome_path?
      'active'
    else
      ''
    end
  end

  def is_welcome_path?
    controller_name == 'articles' && action_name == 'welcome'
  end
end