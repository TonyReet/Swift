# Uncomment the next line to define a global platform for your project

#source `源地址`
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '13.0'
use_frameworks!

#remove warning
inhibit_all_warnings!

target 'SwiftNotes' do
  pod 'Alamofire','~> 4.8.2'    # network
  pod 'SnapKit','~> 4.2.0'    # autoLayout
  pod 'Kingfisher','~> 4.10.1'    # image
  pod 'IQKeyboardManagerSwift','~> 6.3.0'    # keyboard
  pod 'ESPullToRefresh','~> 2.9'    # refresh
  pod 'Cache','~> 5.2.0'    # cache
  pod 'PKHUD','~> 5.3.0'    # hud

  # Rx
  pod 'RxSwift','~> 5.0.0'
  pod 'RxDataSources','~> 4.0.1'

  # encryption
  pod 'CryptoSwift'
  
  #router
  pod 'URLNavigator'
end


target 'SwiftNotesTests' do
    pod 'RxBlocking', '~> 5.0'
    pod 'RxTest', '~> 5.0'
end
