# Package

version       = "0.1.0"
author        = "Christine Dodrill"
description   = "The h bot, in Nim"
license       = "MIT"
srcDir        = "src"
bin           = @["hbot"]
binDir        = "bin"

# Dependencies

requires "nim >= 0.20.0", "irc >= 0.2.0", "dotenv >= 1.1.0"
