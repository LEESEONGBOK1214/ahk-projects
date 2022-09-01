#include Socket.ahk ;http://pastebin.com/CtM9p4QG
#include Logger.ahk ; 커스텀 로거

; 이 파일은 입력 박스로 사용자에게 mac 값을 받아온다.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;             기본값 설정                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FileRead, broadcast, broadcast.txt
FileRead, port, port.txt

; 기본값 설정 - broadcast
if (asc(broadcast)=0)
{
	broadcast := "192.168.0.255"
}

; 기본값 설정 - port
if (asc(port)=0)
{
	port := 9
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;             기본값 설정                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;







InputBox, mac, WOL_사용자입력, 전원을 킬 컴퓨터의 mac address값을 입력해주세요., , 300, 150, 400, 300

Info("--------------------------------------")
length:=StrLen(mac)

;; 2 * 6 = 12 최소 12~ 최대 18 값 + 구분자 + \n까지 합해서 18
if (length>=12)
{
    ; MsgBox, %length%

    ;MsgBox, feild : %field%
    WakeOnLAN(mac, broadcast, port)
    emptyLogger()
}

; 프로그램 종료

MsgBox, 실행되었습니다.
ExitApp


WakeOnLAN(mac, broadcast, port) {

    ;MsgBox, "WakeOnLan" %mac%
    ; 현재 라인 값인 A_LoopField 에서 숫자만 남기고 모두 삭제
    mac := FormatMac(mac)
    Info("mac : " mac)
    Info("broadcast : " broadcast)

    magicPacket_HexString := GenerateMagicPacketHex(mac)
    Info("magicPacket_HexString : " magicPacket_HexString)

    size := CreateBinary(magicPacket_HexString, magicPacket)
    Info("size : " size)

    UdpOut := new SocketUDP()
    Info("UdpOut.connect -> port : " port)
    UdpOut.connect(broadcast, port)

    UdpOut.enableBroadcast()
    Info("UdpOut.enableBroadcast!")
    UdpOut.send(&magicPacket, size)
    Info("UdpOut.send!")
}

FormatMac(mac){
    ; - 랑 : 를 제거
    ; MsgBox, mac : %mac%
    mac := RegExReplace(mac, "[:-]")
    ; 줄바꿈 문자있으면 제거
    mac := RegExReplace(mac, "\s+$")
    Return mac
}

GenerateMagicPacketHex(mac) {
    magicPacket_HexString := "FFFFFFFFFFFF"
    Loop, 16
        magicPacket_HexString .= mac
    Return magicPacket_HexString
}
CreateBinary(hexString, ByRef var) { ;Credits to RHCP!
    Info("hexString : " hexString)
    sizeBytes := StrLen(hexString)//2
    VarSetCapacity(var, sizeBytes)
    Loop, % sizeBytes
        NumPut("0x" SubStr(hexString, A_Index * 2 - 1, 2), var, A_Index - 1, "UChar")
    Return sizeBytes
}