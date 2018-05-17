# Package

version       = "0.1.0"
author        = "enta0701"
description   = "A new awesome nimble package"
license       = "MIT"
srcDir        = "src"
binDir        = "bin"
bin           = @["template"]

# Dependencies

requires "nim >= 0.18.0"
requires "jester"
requires "nre"