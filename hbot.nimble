# Package

version       = "0.1.0"
author        = "Christine Dodrill"
description   = "The h bot, in Nim"
license       = "MIT"
srcDir        = "src"
bin           = @["hbot"]
binDir        = "bin"

# Dependencies

requires "nim >= 0.20.0", "irc >= 0.2.0", "dotenv >= 1.1.0", "prometheus", "jester"

task release, "release a new version of hbot":
  exec "autotag"
  exec "git push"
  exec "git push --tags"

task docker, "build and push docker image":
  const version = staticExec "git describe --tags"
  exec "docker build -t docker.pkg.github.com/xe/hbot/hbot:" & version & " ."
  exec "docker push docker.pkg.github.com/xe/hbot/hbot:" & version
