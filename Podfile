source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target 'LokiWallet' do
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

target 'LWLoki' do
    pod 'Alamofire'
    pod 'SwiftyJSON'
end

target 'LokiWalletLib' do
    pod 'KeychainAccess'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
        end
    end
end