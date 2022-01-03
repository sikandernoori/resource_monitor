Pod::Spec.new do |s|
  s.name             = 'resource_monitor'
  s.version          = '0.0.1'
  s.summary          = 'https://github.com/sikandernoori/resource_monitor'
  s.description      = <<-DESC
  A flutter plugin for Android and IOS to monitor CPU and RAM usage of device.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Skandar Munir' => 'skandar_munir@yahoo.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
