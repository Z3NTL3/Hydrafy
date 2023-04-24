# Author: Z3NTL3 

import yaml/serialization, streams
import std / [parseopt, parseutils, tables, net, threadpool, sysrand, strutils, os]

var
  parser = initOptParser()
  payloadSize = 1048
  targetHost: string
  targetPort: int
type
  ServerTab = ref object of RootObj
    host: string
    port: int

  ServerConf = ref object of ServerTab
    server: ref ServerTab
    use: bool

const 
  terminal = {
    "bold": "\x1b[1m",
    "reset": "\x1b[0m",
    "red": "\x1b[31m"
  }.toTable()

proc Usage(): void =
  echo $terminal["bold"] &
    $terminal["red"] & "Invalid usage" &
    $terminal["reset"]
  echo $terminal["bold"] &
    "Usage: <bin> --bytes:<number> --host:<target> --port:<port>" &
    $terminal["reset"]

var retrievedOptsCount = 0
for kind, key, val in parser.getopt():
  if kind == cmdLongOption and key == "bytes":
    discard val.parseInt(payloadSize)
    retrievedOptsCount += 1
  elif kind == cmdLongOption and key == "host":
    targetHost = val
    retrievedOptsCount += 1
  elif kind == cmdLongOption and key == "port":
    targetPort = parseInt(val.strip())
    retrievedOptsCount += 1

if(retrievedOptsCount != 3):
  Usage()
  quit(0)

proc parseConfig(): ServerConf {.used.}=
  var Config: ServerConf
  var fileStream = newFileStream("conf.yaml")

  filestream.load[:ServerConf](Config)
  fileStream.close()

  return Config

var conf = parseConfig()

proc stress_test(host: string, port: int, use: bool, size: int): void {.thread.}=
  try:
    var s = newSocket(AF_INET, SOCK_STREAM, IPPROTO_RAW)
    s.setSockOpt(OptKeepAlive,true)

    if(use): s.bindAddr(address=host, port=Port(port))

    var payload = urandom(size)
    s.sendTo(host,Port(port), addr(payload), payload.len)

    echo "SEND " & $payload.len & " bytes amount to " & host & ":" & $port
    s.close()
  except CatchableError:
    var msg = getCurrentException()
    echo terminal["red"] & terminal["bold"] & msg.msg & terminal["reset"]

while true:
  spawnX(stress_test(targetHost,targetPort,conf.use, payloadSize))
  # spawn everytime a cpu core is ready to launch a new one
