# This is just an example to get you started. A typical binary package
# uses this file as the main entry point of the application.

proc intToBytesLE(i: int): seq[byte] =
  result = @[]
  for j in 0..<4:
    result.add(byte(i shr (j * 8) and 0xFF))

proc bytesToAscii(bytes: seq[byte]): string =
  result = ""
  for b in bytes:
    result.add(char(b))

proc send_to_browser(msg: string) =
  let len = len(msg)
  let b = intToBytesLE(len)
  let s = bytesToAscii(b)
  stdout.write(s)
  stdout.write(msg)
  stdout.flushFile()

proc recv_from_browser(): string =
  try:
    var len = ord(stdin.readChar())
    if len == 0:
      quit()
    var msg: seq[char] = newSeq[char](len + 3)
    discard stdin.readChars(msg)
    return cast[string](msg)
  except:
    quit()


when isMainModule:
  send_to_browser("ping")
  let response = recv_from_browser()
  
