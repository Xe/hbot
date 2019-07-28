import asyncdispatch, cpuinfo, httpClient, nativeSockets, os, punycode,
       strformat, strutils

let
  cores = cpuinfo.countProcessors()
  hostname = getHostname()

proc userAgent(): string =
  fmt"Xe/hbot (+https://within.website/.x.botinfo; {hostname}) Nim ({NimVersion.replace('.', '_')}; {hostOS}; {hostCPU})"

var
  hc* = newAsyncHttpClient(userAgent = userAgent())

proc withinFront*(hc: AsyncHttpClient = hc): Future[string] {.async.} =
  var front = await hc.getContent(getEnv "FRONT_URL")
  front.stripLineEnd
  return front

proc sysInfo*(): string =
  return fmt"""cores: {cores}, host: {hostname}, total: {getTotalMem().formatSize} inuse: {getOccupiedMem().formatSize}, free: {getFreeMem().formatSize}"""

proc punycodeConvert*(arg: string): string =
  return punycode.encode(arg)

when isMainModule:
  echo userAgent()
