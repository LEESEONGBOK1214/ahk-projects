﻿/*
문제 2. 다음과 같이, 동물과 식물을 구분하여 출력하는 프로그램을 만드시오.

[조건]
- 대화 상자의 내용은 "강아지 / 선인장 / 사자 / 해바라기"로 한다.
- 대화 상자에는 예 / 아니요 버튼이 있어야 한다.
- '예' 버튼을 누른다면 동물을, '아니요' 버튼을 누른다면 식물을 출력한다.
- 5초간 선택하지 않으면 대화상자가 자동으로 닫힌다.
- MsgBox의 내용을 쓸 때 콤마(,)를 사용하지 말고 슬래시(/)를 이용할 것

[결과]
'예'를 누르면 [강아지 / 사자] 출력
'아니요'를 누르면 [선인장 / 해바라기] 출력
*/

MsgBox,	4,	프로그래밍 문제 (1),	강아지 / 선인장 / 사자 / 해바라기,	5
IfMsgBox, Yes
{
	MsgBox,	강아지 / 사자
}
IfMsgBox, No
	{
	MsgBox,	선인장 / 해바라기
}