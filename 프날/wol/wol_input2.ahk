#include Socket.ahk ;http://pastebin.com/CtM9p4QG
#include Logger.ahk ; 커스텀 로거

; 이 파일은 입력 박스로 사용자에게 mac 값을 받아온다.

RunWol(mac)

; 프로그램 종료
ExitApp

RunWol(mac){
    Loop, Parse, mac, `n
    {
        ;MsgBox, %A_LoopField%
        ; 각 줄별로 읽어오면서 wol 요청을 보낸다.

        ;MsgBox, 초기 mac : %mac%
        macAddr := FormatMac(A_LoopField)
        ;MsgBox, 변경 mac : %macAddr%
        WakeOnLAN(A_LoopField)
        Info("mac : " A_LoopField)
    }
}

FormatMac(mac){
    ; StringReplace,새로운변수,처음변수,찾을문자열,바꿀문자열 [, ALL]
    ; 모두 바꾸고 싶다면 바꿀문자열,ALL
    StringReplace, colonMac, mac, :, , ALL
    StringReplace, dashMac, colonMac, -, , ALL
    Return dashMac
}

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

