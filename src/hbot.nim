import asyncdispatch, dotenv, jester, os, strutils, prometheus
import hbotpkg/[hirc, within]

const
  version = staticExec "git describe --tags"

initDotEnv().overload
hirc.init()

settings:
  port = getEnv("PORT").parseInt().Port
  bindAddr = "0.0.0.0"

routes:
  get "/":
    resp Http200, "hi", "text/plain"

  get "/metrics":
    let data = generateLatest()
    resp Http200, data, "text/plain"

runForever()
