Gem::Specification.new do |s|
    s.name        = 'poi'
    s.version     = '0.1.0'
    s.date        = '2018-04-05'
    s.summary     = "Project Init Utility"
    s.description = "A simple tools to initialize project files and structure."
    s.authors     = ["Kimmy Leo"]
    s.email       = 'kenpusney@gmail.com'
    s.files       = ["bin/poi"]
    s.executables << "poi"
    s.homepage    =
      'http://rubygems.org/gems/poi'
    s.add_runtime_dependency 'mustache', '~> 1.0', ">= 1.0.5" 
    s.metadata    = { "source_code_uri" => "https://github.com/kenpusney/poi" }
    s.license       = 'MIT'
end