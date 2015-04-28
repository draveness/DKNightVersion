Pod::Spec.new do |s|
  s.name         = "DKNightVersion"
  s.version      = "0.4.5"
  s.summary      = "A light weight framework adding night version to your app on iOS."
  s.description  = <<-DESC
                   A longer description of DKNightVersion in Markdown format.

                   * This framework is target for easily integrate night dark mode in iOS App.
                   * It is inspired by many famous framework, and implement with runtime
                   * library. Hope this will help you reduce your work.
                   DESC
  s.homepage     = "https://github.com/Draveness/DKNightVersion"
  s.license      = "MIT"
  s.author             = { "Draveness" => "stark.draven@gmail.com" }
  s.platform     = :ios, "6.0"
  s.requires_arc = true
  s.source       = { :git => "https://github.com/Draveness/DKNightVersion.git", :tag => s.version }
  s.source_files = "Pod/Classes/DKNightVersion.h"

  s.subspec 'Core' do |ss|
      ss.source_files = "Pod/Classes/Core/**"
  end

  s.subspec 'UIKit' do |ss|
      ss.source_files = "Pod/Classes/UIKit/Auto/**/*", "Pod/Classes/UIKit/Manual/**/*"
      ss.dependency 'DKNightVersion/Core'
  end

end
