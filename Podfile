platform :ios, '13.0'
inhibit_all_warnings!

target 'MVPMatchChallenge' do
  use_frameworks!
  
  pod 'Kingfisher'
  pod 'SVProgressHUD'

  target 'MVPMatchChallengeTests' do
    inherit! :search_paths
    # Pods for testing
  end
  
  target 'MVPMatchChallengeUITests' do
    inherit! :search_paths
    # Pods for testing
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end
