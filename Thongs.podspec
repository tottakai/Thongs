#
# Be sure to run `pod lib lint Thongs.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Thongs"
  s.version          = "0.9.1"
  s.summary          = "Functional library for NSAttributedString creation in swift 2.1."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description      = <<-DESC
    A functional NSAttributedString builder, allows composition of a complex NSAttributedString from multiple parts with different style attributes.
                       DESC

  s.homepage         = "https://github.com/tottakai/Thongs"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "Tomi Koskinen" => "tomi.koskinen@reaktor.fi" }
  s.source           = { :git => "https://github.com/tottakai/Thongs.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Thongs/Classes/**/*'
  # s.resource_bundles = {
  #   'Thongs' => ['Thongs/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
