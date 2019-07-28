import asyncdispatch, dotenv, os, strutils
import hbotpkg/[hirc, within]

const
  version = staticExec "git describe --tags"

initDotEnv().overload
hirc.init()

runForever()
