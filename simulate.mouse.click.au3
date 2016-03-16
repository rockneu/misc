
Global $Paused
;HotKeySet("{PAUSE}", "TogglePause")
HotKeySet("{PAUSE}", "Terminate")


Dim $x=758, $y=660

MouseMove($x, $y)
Sleep(1000)

While True
;~    MouseClick("right")
;~    Sleep(500)
;~    Send("{ESC}")
;~    Sleep(500)
   
   MouseClick("left",$x,$y)
   ;wait for content loading
   Sleep(1000*20)
   ;wait for content running
   Sleep(1000*30)
WEnd   

Func TogglePause()
    $Paused = Not $Paused
    While $Paused
        Sleep(100)
        ToolTip('Script is "Paused"', 0, 0)
    WEnd
    ToolTip("")
EndFunc   ;==>TogglePause

Func Terminate()
    Exit 0
EndFunc   ;==>Terminate
