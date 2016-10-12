Pod::Spec.new do |s|
  s.name             = 'LogCountry'
  s.version          = '0.10'
  s.summary          = 'LogCountry is a simple iOS logging framework written in Swift.'

  s.description      = <<-DESC
LogCountry is a simple iOS logging framework written in Swift written by Zeke Abuhoff.
                       DESC

  s.homepage         = 'https://github.com/Baconthorpe/LogCountry'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ezekiel Abuhoff' => 'zabuhoff@gmail.com' }
  s.source           = { :git => 'https://github.com/Baconthorpe/LogCountry.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.source_files = 'LogCountry/*.{swift,plist,h}'

end
