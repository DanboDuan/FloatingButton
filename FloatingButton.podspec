#
# Be sure to run `pod lib lint BDAutoTracker.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FloatingButton'
  s.version          = '0.0.1'
  s.summary          = 'FloatingButton'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/DanboDuan/FloatingButton'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'bob' => 'bob170131@gmail.com' }
  s.source           = { :git => 'https://github.com/DanboDuan/FloatingButton.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'FloatingButton/**/*.{h,m}'
  s.public_header_files = 'FloatingButton/FloatingButton.h'
  s.frameworks = 'Foundation','UIKit'
  s.default_subspec = 'Core','Wrapper'


  s.subspec 'Utility' do |utility|
        utility.source_files = 'FloatingButton/Utility/**/*.{h,m}'
  end

  s.subspec 'Core' do |c|
        c.source_files = 'FloatingButton/Core/**/*.{h,m}'
        c.public_header_files = 'FloatingButton/Core/FloatingButton.h'
        c.dependency 'FloatingButton/Utility'
  end

  s.subspec 'Wrapper' do |w|
        w.source_files = 'FloatingButton/Wrapper/**/*.{h,m}'
        w.public_header_files = 'FloatingButton/Wrapper/*.h'
        w.dependency 'FloatingButton/Utility'
  end

end
