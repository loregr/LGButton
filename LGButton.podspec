Pod::Spec.new do |s|
  s.name             = 'LGButton'
  s.version          = '1.1.1'
  s.summary          = 'A fully customisable subclass of the native UIControl which allows you to create beautiful buttons without writing any line of code.'
  s.homepage         = 'https://cocoapods.org/pods/LGButton'
  s.license          = { :type => 'MIT', :file => 'LICENSE.md' }
  s.author           = { 'Lorenzo Greco' => 'lorenzo.gr90@gmail.com' }
  s.source           = { :git => 'https://github.com/loregr/LGButton.git', :tag => "#{s.version}" }

  s.ios.deployment_target = '9.0'

s.source_files = 'LGButton/Classes/**/*.{swift}'
  s.resources = "LGButton/Resources/*"

end
