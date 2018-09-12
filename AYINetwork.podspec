#
# Be sure to run `pod lib lint AYINetwork.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AYINetwork'
  s.version          = '0.1.0'
  s.summary          = '基于Alamofire的网路库'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
基于Alamofire的网路库，采用分散式的网络请求
                       DESC

  s.homepage         = 'https://github.com/aaayia/AYINetwork'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'aaayia' => 'twilightzzy@126.com' }
  s.source           = { :git => 'https://github.com/aaayia/AYINetwork.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.3'

  s.source_files = 'AYINetwork/Classes/**/*'
  
  # s.resource_bundles = {
  #   'AYINetwork' => ['AYINetwork/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
    s.swift_version = '3.2'
  s.dependency 'Alamofire'
  s.dependency 'SwiftyJSON', '~> 3.1.4'

end
