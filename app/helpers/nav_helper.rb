module NavHelper
  def is_active?(name)
    if controller_name.include?(name) && !(controller_name == 'articles' && action_name == 'welcome')
      'active'
    else
      ''
    end
  end
end