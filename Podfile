# Uncomment the next line to define a global platform for your project

platform :ios, '12.0'
use_frameworks!

target 'NY Times News' do
  pod 'FirebaseCore'
  pod 'FirebaseAuth'
  pod 'FirebaseAnalytics'
  pod 'Firebase/Firestore'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if target.name == 'BoringSSL-GRPC'
      target.source_build_phase.files.each do |file|
        if file.settings && file.settings['COMPILER_FLAGS']
          flags = file.settings['COMPILER_FLAGS'].split
          flags.reject! { |flag| flag == '-GCC_WARN_INHIBIT_ALL_WARNINGS' }
          file.settings['COMPILER_FLAGS'] = flags.join(' ')
        end
      end
    end
  end
end
 
end
