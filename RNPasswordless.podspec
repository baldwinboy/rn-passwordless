require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))
min_ios_versions_supported = ['16.0', min_ios_version_supported]
index_of_max = min_ios_versions_supported.each_with_index.max_by { |number, _| number.to_f }[1]


Pod::Spec.new do |s|
  s.name         = "RNPasswordless"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platforms    = { :ios => min_ios_versions_supported[index_of_max] }
  s.source       = { :git => "https://github.com/baldwinboy/rn-passwordless.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,m,mm,cpp}"
  s.private_header_files = "ios/**/*.h"

  s.dependency 'Passwordless', '~> 1.0.0'

  install_modules_dependencies(s)
end
