#
#  Be sure to run `pod spec lint Networking.podspec’ to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = 'push-notify'
  s.version      = '1.0.0'
  s.summary      = 'push notifty management framework'
  s.description  = 'A description of push-notify'
  s.homepage     = 'https://github.com/umutboz/push-notify-ios'
  s.author             = { 'umutboz' => 'umut.boz@outlook.com' }
  s.platform     = :ios
  s.ios.deployment_target = '10.0'
  s.source       = { :git => "https://github.com/umutboz/push-notify-ios", :tag => s.version }
  s.source_files  = 'PushNotifyManagement/**/*.swift', 'PushNotifyManagement/*.swift'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '5' }
  s.dependency 'Firebase/Analytics', '~> 8.5'
  s.dependency 'Firebase/Messaging', '~> 8.5'
  s.dependency 'Firebase', '~> 8.5'
  s.swift_version    = '5.0'
  end
  
