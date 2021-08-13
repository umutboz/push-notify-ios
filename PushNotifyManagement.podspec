#
#  Be sure to run `pod spec lint Networking.podspec’ to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = 'PushNotifyManagement'
  s.version      = '1.0.0'
  s.summary      = 'KocSistem push notift maangement framework'
  s.description  = 'A description of PushNotifyManagement'
  s.homepage     = 'http://bellatrix:8080/tfs/ArgeMimariCollection/OneFrameIOS/_git/PushNotifyManagement'
  s.author             = { 'KoçSistem' => 'StarForce@kocsistem.com.tr' }
  s.platform     = :ios
  s.ios.deployment_target = '10.0'
  s.source       = { :git => "http://bellatrix:8080/tfs/ArgeMimariCollection/OneFrameIOS/_git/PushNotifyManagement", :tag => s.version }
  s.source_files  = 'PushNotifyManagement/**/*.swift', 'PushNotifyManagement/*.swift'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '5' }
  s.dependency 'Firebase/Analytics'
  s.dependency 'Firebase/Messaging'
  s.swift_version    = '5.0'
  end
  