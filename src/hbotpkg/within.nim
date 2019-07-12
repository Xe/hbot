import asyncdispatch, cpuinfo, httpClient, nativeSockets, os, punycode,
       strformat, strutils

let
  cores = cpuinfo.countProcessors()
  hostname = getHostname()

var
  hc* = newAsyncHttpClient()

proc withinFront*(hc: AsyncHttpClient): Future[string] {.async.} =
  var front = await hc.getContent(getEnv "FRONT_URL")
  front.stripLineEnd
  return front

proc sysInfo*(): string =
  return fmt"cores: {cores}, host: {hostname}"

proc punycodeConvert*(arg: string): string =
  return punycode.encode(arg)
