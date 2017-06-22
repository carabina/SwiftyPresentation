Pod::Spec.new do |s|
    s.name             = 'SwiftyPresentation'
    s.version          = '1.0.2'
    s.summary          = 'Some presentations for modal controllers'

    s.description      = <<-DESC
Present controllers like slides or alerts.
                       DESC
 
    s.homepage         = 'https://github.com/NicolasRenaud/SwiftyPresentation'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Nicolas Renaud' => 'nicolasrenaud.0301@gmail.com' }
    s.source           = { :git => 'https://github.com/NicolasRenaud/SwiftyPresentation.git', :tag => s.version.to_s }
 
    s.ios.deployment_target = '9.0'
    s.source_files = 'SwiftyPresentation/Classes/*.swift'

end
