Pod::Spec.new do |s|
  s.name             = 'TKDocumentParser'
  s.version          = '1.0.0'
  s.summary          = 'A Swift package for parsing text from PDF and DOCX documents.'
  s.description      = <<-DESC
  `TKDocumentParser` provides a simple API to extract plain text from PDF and DOCX files. It is designed to be easy to use and integrate into iOS and macOS applications.
  DESC
  s.homepage         = 'https://github.com/toseefkhilji/TKDocumentParser'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Toseef Khilji' => 'toseefkhilji@outlook.com' }
  s.source           = { :git => 'https://github.com/toseefkhilji/TKDocumentParser.git', :tag => s.version.to_s }
#s.resources        = ['Resources/PrivacyInfo.xcprivacy']
 # s.resource_bundles = { 'TKDocumentParser' => ['Resources/**/*'] }

  s.source_files     = 'Sources/**/*.{swift}'
  s.platform         = :ios, '14.0'
  s.dependency       'SwiftyXMLParser', '~> 5.6.0'
  s.dependency       'ZIPFoundation', '~> 0.9.19'
s.swift_versions             = ['5.4', '5.5', '5.6', '5.7', '5.8', '5.9', '5.10']

end
