#
# Be sure to run `pod lib lint FloatingButton.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FloatingButton'
  s.version          = '0.0.3'
  s.summary          = 'FloatingButton'
  s.description      = 'Floating Button'
  s.homepage         = 'https://github.com/DanboDuan/FloatingButton'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'bob' => 'bob170131@gmail.com' }
  s.source           = { :git => 'https://github.com/DanboDuan/FloatingButton.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.frameworks = 'Foundation','UIKit'
  s.default_subspec = 'Picker'
  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
  }
  s.subspec 'Utility' do |utility|
        utility.source_files = 'FloatingButton/Utility/**/*.{h,m}'
        utility.public_header_files = 'FloatingButton/Utility/*.h'
  end

  s.subspec 'Core' do |c|
        c.source_files = 'FloatingButton/Core/**/*.{h,m}'
        c.public_header_files = 'FloatingButton/Core/Header/*.h'
        c.dependency 'FloatingButton/Utility'
  end

  s.subspec 'Wrapper' do |w|
        w.source_files = 'FloatingButton/Wrapper/**/*.{h,m}'
        w.public_header_files = 'FloatingButton/Wrapper/*.h'
        w.dependency 'FloatingButton/Core'
        w.dependency 'FloatingButton/Utility'
  end

  s.subspec 'Picker' do |p|
    p.source_files = 'FloatingButton/Picker/**/*.{h,m}'
    p.public_header_files = 'FloatingButton/Picker/Header/*.h'
    p.dependency 'FloatingButton/Utility'
    p.dependency 'FloatingButton/Wrapper'
    p.dependency 'FloatingButton/Core'
  end

end
