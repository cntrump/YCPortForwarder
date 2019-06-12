#
# Be sure to run `pod lib lint YCPortForwarder.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'YCPortForwarder'
  s.version          = '0.2.0'
  s.summary          = 'A simple tcp forwarder example using CocoaAsyncSocket.'

  s.description      = <<-DESC
  A simple tcp forwarder example using CocoaAsyncSocket. Help you to get konwn about the data flow though the specify port.
                       DESC

  s.homepage         = 'https://github.com/yichengchen/YCPortForwarder'

  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yicheng' => 'yicheng.fzu@gmail.com' }
  s.source           = { :git => 'https://github.com/yichengchen/YCPortForwarder.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.swift_version = '5'
  
  s.source_files = 'YCPortForwarder/Classes/**/*'
  
  s.dependency 'CocoaAsyncSocket'
end
