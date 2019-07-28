import asyncdispatch, irc, os, strformat, strutils
import within

proc onIrcEvent*(client: AsyncIrc, event: IrcEvent) {.async.} =
  case event.typ
  of EvConnected:
    echo "connected"
    if getEnv("IRC_OPER") != "":
      await client.send(
        "OPER " & getEnv("IRC_OPER"),
        sendImmediately=true,
      )
  of EvDisconnected, EvTimeout:
    await client.reconnect()
  of EvMsg:
    if event.cmd == MPrivMsg:
      var msg = event.params[event.params.high]
      if msg == "h":
        await client.privmsg(event.origin, "h")

      let args = msg.split " "
      if msg.startsWith("!"):
        if args[0] == "!info":
          await client.privmsg(event.origin, sysInfo())
        if args.len == 2 and args[0] == "!punycode":
          await client.privmsg(event.origin, punycodeConvert(args[1]))
        if args[0] == "!within":
          let
            front = await withinFront()
          await client.privmsg(event.origin, fmt"Within front: {front}")
      echo(event.raw)

var done = false
proc init*() =
  if done: return

  var client = newAsyncIrc(getEnv("IRC_SERVER"),
                          nick=getEnv("IRC_NICK"),
                          joinChans = getEnv("IRC_CHANNEL").split(","),
                          callback = onIrcEvent,
  )
  asyncCheck client.run()

  done = true
