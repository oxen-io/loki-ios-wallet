source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target 'CakeWallet' do
    pod 'FlexLayout'
    pod 'PinLayout'
    pod 'SkyFloatingLabelTextField', '~> 3.01'
    pod 'QRCode'
    pod 'IQKeyboardManagerSwift'
    pod 'SwiftSoup'
    pod 'JVFloatLabeledTextField'
    pod 'QRCodeReader.swift', '~> 8.0.3'
    pod 'Alamofire'
    pod 'SwiftyJSON'
    pod 'Starscream', '~> 3.0.2'
end

target 'CWMonero' do
    pod 'Alamofire'
    pod 'SwiftyJSON'
end

target 'CakeWalletLib' do
    pod 'KeychainAccess'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
        end
    end
    
    # Xcode11 Fix
    installer.pods_project.targets.each do |target|
      next unless target.name == 'SwiftSoup'
      target.build_configurations.each do |config|
        next unless config.name.start_with?('Release')
        config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Onone'
      end
    end
end
