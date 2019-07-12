import irc, asyncdispatch, dotenv, httpClient, nativesockets, os, strformat, strutils

import hbotpkg/[hirc, within]

initDotEnv().overload

hirc.init()
runForever()
