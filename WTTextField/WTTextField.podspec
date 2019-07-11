#
# Be sure to run `pod lib lint WTTextField.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WTTextField'
  s.version          = '1.0.1'
  s.summary          = 'A customizable custom TextField view with floating placeholder and inline error feature.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = "A customizable custom TextField view with floating placeholder and inline error feature. This is a product of Folio3"

  s.homepage         = 'https://github.com/WasiAtFolio3/WTTextField.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'WasiAtFolio3' => 'mwasi@folio3.com' }
  s.source           = { :git => 'https://github.com/WasiAtFolio3/WTTextField.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.swift_version    = '4.0'
  s.requires_arc = true
  s.source_files = 'WTTextField/WTTextField/Classes/**/*'
  
  # s.resource_bundles = {
  #   'WTTextField' => ['WTTextField/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
