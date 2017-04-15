module NavHelper
  def is_active?(name)
    controller_name.include?(name) ? 'active' : ''
  end
end