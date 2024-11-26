Gem::Specification.new do |s|
    s.name                    = "proxypoke"
    s.version                 = "1.1.0"
    s.summary                 = "Makes an HTTP request to check if a web proxy is working"
    s.authors                 = ["David Jennings"]
    s.email                   = "david@chillidoor.com"
    s.required_ruby_version   = ">= 2.7"
    s.files                   = Dir["lib/*.rb"]
    s.executables             = ["proxypoke"] 
    s.homepage                = "https://github.com/chillidoor/proxypoke/"
    s.license                 = "MIT"

  end
