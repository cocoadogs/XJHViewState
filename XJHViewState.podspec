#
# Be sure to run `pod lib lint XJHViewState.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XJHViewState'
  s.version          = '0.1.11'
  s.summary          = 'Using runtime to display a placehold subview for a view under different states.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'Using runtime to display a placehold subview for a view under different states.'

  s.homepage         = 'https://github.com/cocoadogs/XJHViewState'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'cocoadogs' => 'cocoadogs@163.com' }
  s.source           = { :git => 'https://github.com/cocoadogs/XJHViewState.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.requires_arc  = true

  s.source_files = 'XJHViewState/XJHViewState.h'
  s.public_header_files = 'XJHViewState/XJHViewState.h'
  
  s.subspec 'State' do |ss|
      ss.source_files = 'XJHViewState/UIView+State.{h,m}'
      ss.dependency 'XJHViewState/Enum'
      ss.dependency 'XJHViewState/Property'
  end
  
  s.subspec 'Property' do |ss|
      ss.source_files = 'XJHViewState/XJHViewStateProperty.{h,m}','XJHViewState/XJHViewStatePublicDataCenter.{h,m}'
      ss.dependency 'XJHViewState/Enum'
  end
  
  s.subspec 'Enum' do |ss|
      ss.source_files = 'XJHViewState/XJHViewStateEnum.h'
  end
  
  # s.resource_bundles = {
  #   'XJHViewState' => ['XJHViewState/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'ReactiveObjC', '~> 3.1.0'
end
