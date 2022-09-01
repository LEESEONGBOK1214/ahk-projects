
/*
TestInfo(msg){
	formattime , nowtime,, HH:mm:ss
	guicontrol ,,l_b, %nowtime% msg
}
*/

; 설명
; 설명

/*

*/
Info(msg){
	datetime := FormatDateTime()
	FileAppend,%datetime% - [Info]`t%msg%`n , %A_ScriptDir%/log.txt
}

Error(msg){
	datetime := FormatDateTime()
	FileAppend,%datetime% - [Error]`t%msg%`n , %A_ScriptDir%/log.txt
}

EmptyLogger(){
	datetime := FormatDateTime()
	FileAppend, `n , %A_ScriptDir%/log.txt
}
FormatDateTime(){
    FormatTime, CurrentDateTime,, yyyy-MM-dd HH:mm:ss
    Return CurrentDateTime
}