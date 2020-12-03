module FreddyFloatingAssist::FreddyAssist
  HINTS = YAML.load_file("config/easter_eggs.yml").symbolize_keys!
  NAVIGATORS = YAML.load_file("config/smart_navigation.yml").symbolize_keys!
  # param1: product states product name
  # param2: key states the hints/easter eggs that needs to be pushed
  def self.easter_eggs(product, module_name)
    return [] unless module_name
    HINTS.dig(product.to_sym, module_name.to_s)
  end

  # param1: product states product name
  # param2: module_name states the module for which smart navigators needs to be pushed
  def self.smart_navigators(product, module_name)
    return [] unless module_name
    navigate_routes = NAVIGATORS.dig(product.to_sym, 'modules')
    smart_navigator_mapping = NAVIGATORS.dig(product.to_sym, 'smart_navigator_mapping')
    current_module_navigator_options = smart_navigator_mapping[module_name.to_s]
    smart_navigator_paths = []
    current_module_navigator_options.each {|option| smart_navigator_paths << navigate_routes[option]}
    smart_navigator_paths
  end
end