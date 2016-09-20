Pod::Spec.new do |s|
  s.name             = "JSONJam"
  s.version          = "1.0.0"
  s.summary          = "JSON serialization and deserialization in Swift is my jam."
  s.homepage         = "https://github.com/mluedke2/JSONJam"
  s.license          = 'MIT'
  s.author           = { "Matt Luedke" => "mluedke2@gmail.com" }
  s.source           = { :git => "https://github.com/mluedke2/JSONJam.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/matt_luedke'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target = '9.0'
  s.requires_arc = true

  s.dependency 'JSONHelper'
  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'JSONJam' => ['Pod/Assets/*.png']
  }
end
