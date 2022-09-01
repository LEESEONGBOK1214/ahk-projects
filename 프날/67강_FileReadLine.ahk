FileReadLine, var, 67강_bom.txt, 1
MsgBox, %var%

FileReadLine, var, 67강_bom.txt, 2
MsgBox, %var%

FileReadLine, var, 67강_bom.txt, 3
MsgBox, %var%

FileReadLine, var, 67강_bom.txt, 4
MsgBox, %var%

/*
; 아래와 같이 하면 무한루프 돎
Loop
{
    FileReadLine, var, 67강.txt, %A_index%
    MsgBox, %var%
}
*/


Loop
{
    FileReadLine, var, 67강_bom.txt, %A_index%
    ;에러레벨을 통해 무한루프 방지
    ; ErrorLevel
    ; 0 = 성공
    ; 1 = 실패
    if (ErrorLevel = 1)
        break
    MsgBox, %var%
}