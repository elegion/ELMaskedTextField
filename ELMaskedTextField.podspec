Pod::Spec.new do |s|
  s.name         = "ELMaskedTextField"
  s.version      = "0.1.0"
  s.summary      = "ELMaskedTextField is a UITextField subclass for formatting user's input as he types. Useful for phone numbers, credit card numbers, etc."
  s.homepage     = "https://github.com/elegion/ELMaskedTextField.git"
  s.license      = 'MIT'
  s.author       = { "Vladimir Lyukov" => "v.lyukov@gmail.com" }
  s.source       = { :git => "https://github.com/elegion/ELMaskedTextField.git", :tag => s.version.to_s }
  s.platform     = :ios
  s.source_files = 'ELMaskedTextField/**/*.{h,m}'
  s.requires_arc = true
end
