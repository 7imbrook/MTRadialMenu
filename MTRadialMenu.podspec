#
# Be sure to run `pod spec lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about the attributes see http://docs.cocoapods.org/specification.html
#
Pod::Spec.new do |s|
  s.name         = "MTRadialMenu"
  s.version      = "0.1.0"
  s.summary      = "A simple radial menu."
  s.description  = <<-DESC
                    MTRadialMenu is a customizable UIControl that appears on a long press on the view its a part of,
                    and gives the user options around their finger that they can select.
                   DESC
  s.homepage     = "http://EXAMPLE/NAME"
  s.screenshots  = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license      = 'MIT'
  s.author       = { "7imbrook" => "timbrook480@gmail.com" }
  s.source       = { :git => "https://github.com/7imbrook/MTRadialMenu.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.ios.deployment_target = '7.0'
  s.requires_arc = true

  s.source_files = 'Classes'

end
