install! 'cocoapods',
  :disable_input_output_paths => true,
  :generate_multiple_pod_projects => true,
  :warn_for_multiple_pod_sources => false,
  :warn_for_unused_master_specs_repo => false


platform :ios, '13.0'

target 'Demo' do
  pod 'FloatingButton', :path => './'
end


def update_deployment_config(config = nil)
  return if config.nil?
  config.build_settings['ENABLE_BITCODE'] = 'NO'
  config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
  config.build_settings['ONLY_ACTIVE_ARCH'] = 'YES'
  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
  # config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64 i386'
end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    update_deployment_config(config)
  end
  
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      update_deployment_config(config)
    end
  end
  ## for generate_multiple_pod_projects = true
  installer.generated_projects.each do |project|
    project.build_configurations.each do |config|
      update_deployment_config(config)
    end
    
    project.targets.each do |target|
      target.build_configurations.each do |config|
        update_deployment_config(config)
      end
    end
  end

end
