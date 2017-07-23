
Pod::Spec.new do |s|
  s.name         = "SKScheduler"
  s.version      = "1.0.0"
  s.summary      = "a scheduler that executes asynchronous tasks"
  s.homepage     = "https://github.com/FromHell-620/SKScheduler"
  s.license      = "MIT"
  s.author             = { "GodL" => "547188371@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/FromHell-620/SKScheduler.git", :tag => s.version.to_s }
  s.source_files  = "SKScheduler"
  s.requires_arc = true
end
