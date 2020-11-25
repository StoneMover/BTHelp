Pod::Spec.new do |s|
  s.name             = "BTHelp"
  s.version          = "0.3.6"
  s.summary          = "some help class"
  s.homepage         = "https://github.com/StoneMover/BTHelp"
  s.license          = 'MIT'
  s.author           = {"StoneMover" => "stonemover@163.com"}
  s.platform         = :ios, '9.0'
  s.source           = {:git => "https://github.com/StoneMover/BTHelp.git", :tag => s.version }
  s.source_files     = 'Classes/**/*.{h,m}'
  s.requires_arc     = true
end