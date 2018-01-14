#
# Be sure to run `pod lib lint DataPaga.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DataPaga'
  s.version          = '1.0.0'
  s.summary          = 'The DataPaga Library'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC

The DataPaga Library. Use this library to connect with DataPaga.

                       DESC

  s.homepage         = 'https://github.com/datapaga/datapaga-ios'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'DataPaga' => 'dev@datapaga.com' }
  s.source           = { :git => 'https://github.com/datapaga/datapaga-ios.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/datapagaoficial'

  s.ios.deployment_target = '11.0'

  s.source_files = 'DataPaga/Classes/**/*'
  
  # s.resource_bundles = {
  #   'DataPaga' => ['DataPaga/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Alamofire', '~> 4.6'
end
