#include Socket.ahk ;http://pastebin.com/CtM9p4QG

; mac 매개변수로 mac_list.txt 파일 값을 가져온다.
FileRead, mac, mac_list.txt

; 각 줄별로 읽어오면서 wol 요청을 보낸다.
Loop, Parse, mac, `n
{
    ;MsgBox, %A_LoopField%
    WakeOnLAN(A_LoopField)
}


;Example
;

ExitApp

WakeOnLAN(mac) {
    ;MsgBox, "WakeOnLan" %mac%
    magicPacket_HexString := GenerateMagicPacketHex(mac)
    size := CreateBinary(magicPacket_HexString, magicPacket)
    UdpOut := new SocketUDP()
    UdpOut.connect("addr_broadcast", 9)
    UdpOut.enableBroadcast()
    UdpOut.send(&magicPacket, size)
}
GenerateMagicPacketHex(mac) {
    magicPacket_HexString := "FFFFFFFFFFFF"
    Loop, 16
        magicPacket_HexString .= mac
    Return magicPacket_HexString
}
CreateBinary(hexString, ByRef var) { ;Credits to RHCP!
    sizeBytes := StrLen(hexString)//2
    VarSetCapacity(var, sizeBytes)
    Loop, % sizeBytes
        NumPut("0x" SubStr(hexString, A_Index * 2 - 1, 2), var, A_Index - 1, "UChar")
    Return sizeBytes
}