/*
This is a modified version of PSO2-GrindersProMax to have a different depositing route as well as additional information on 
how many EX-Cubes will be used.

Original Script:
https://github.com/KritixKaung/PSO2-GrindersProMax

IMPORANT NOTE - REGARDING Alt-TabING:
It is best to bring this program to foreground with F1 to perform tasks while you're in the game instead of alt tabbing because alt tabbing 
might mess up with selections in the game. It is important that you don't input anything into the game while the script is running.

Script Timing:
The original script is created for 144fps+ and around 100ping to server but has since been tweaked for a different setup.
If your performance has a huge difference from this the script might not perform as intended for you. 
Try increasing sleep timers in 50ms increments.

Requirements:
- AutoHotKey (Tested on v1.1.33.06)
- PSO2 Material Storage Subscription 

How To Use:
MAKE SURE YOU RUN THIS SCRIPT IN ADMINISTRATOR MODE, INPUTS MAY NOT WORK OTHERWISE.

!Buying Process! 
1. Make sure your Inventory and Material Storage are empty of Grinders.
	- This is to ensure you can buy as much Grinders as possible.
	- Material Storage has an item limit of 65,000 so existing Grinders may cause issues if purchasing the max.
2. Talk to Nyssa the EX-Cube NPC and open up the SHOP MENU.
3. Review the GUI and set your desired targeted Meseta if needed.
	- Leaving the desired Meseta count as 0 will cause the script to purchase as much Grinders as possible.
4. While "EX-Cube Exchange Shop" is hovered, click the "Start Buying" button.
5. While the script is running...
	- You can also see the amount of grinders you have bought and meseta amount of it in the 
	  GUI so if you're only buying for a small amount of money you can end the buying process sooner by clicking "Stop Buying" button.

!Selling Process!
1. Go to any NPC where you can sell items 
2. Select "Sell Items from Storage"
3. Open your Material Storage
4. Input "Grinder" in the search bar and Search
5. Make sure you have selected Grinders and click the "Start Selling" button.

*/
#maxThreadsPerHotkey, 2
GrinderMaxBuyAmount := 64
GrinderSellAmount := 0
SoldGrinderAmount := 0
TargetMeseta := 0
toggle := false

WinGet, programid, List, Phantasy Star Online 2

Gui, Main:add, Text,r4 x15 y5 w225 Center vStatus,Idle.... `n Press F1 to insta-focus this program `n Press F4 to force close this program. `n Press F2 to see instuctions and script.
Gui, Main:Add, Text,x20, Meseta Target (in millions) -
Gui, Main:Add, Edit, x180 y60 w40 right number readonly
Gui, Main:Add, UpDown, vTargetMeseta gCountCubes Range0-25, 0
Gui, Main:add, button, x15 y90 w100 h25 vBuyBtn gStartBuying, Start Buying
Gui, Main:add, button, x130 y90 w100 h25 vBreakBtn gBreak, Stop Buying
Gui, Main:add, button, x60 w120 h25 vSellBtn gStartSelling, Start Selling
Gui, Main:add, button, x10 y150 w110 h25 vStartSellingManuallyBtn gStartSellingManually, Start Selling Manually
Gui, Main:add, button, x130 y150 w110 h25 vStopManualSellBtn gStopManualSell, Stop Manual Selling
Gui, Main:Default
Gui, -sysmenu
gui, Main:show,,GrindersProMax - S'pugn Edition
GuiControl,Disable,SellBtn
GuiControl,Disable,StopManualSellBtn
return

CountCubes: ; UpDown ACTION: UPDATE STATUS TO DISPLAY EX-Cube CONSUMPTION
	GuiControlGet, TargetMeseta
	If (TargetMeseta > 0) {
		tempTargetMeseta := TargetMeseta*1000000
		tempGrinderMaxBuyAmount := (tempTargetMeseta//399600)+1
		CubesConsumed := ((tempGrinderMaxBuyAmount*990)//30)
		UpdateStatus("Buying " . RegExReplace((tempGrinderMaxBuyAmount*990), "(\G|[^\d.])\d{1,3}(?=(\d{3})+(\D|$))", "$0,") . "/65,000 Grinders..." .  "`n EX-Cubes Consumed: " . RegExReplace(CubesConsumed, "(\G|[^\d.])\d{1,3}(?=(\d{3})+(\D|$))", "$0,"))
	}
	else {
		CubesConsumed := ((GrinderMaxBuyAmount*990)//30)+1
		UpdateStatus("Buying " . RegExReplace((GrinderMaxBuyAmount*990), "(\G|[^\d.])\d{1,3}(?=(\d{3})+(\D|$))", "$0,") . "/65,000 Grinders..." .  "`n EX-Cubes Consumed: " . RegExReplace(CubesConsumed, "(\G|[^\d.])\d{1,3}(?=(\d{3})+(\D|$))", "$0,"))
	}
	return

StartBuying: ; "Start Buying" BUTTON ACTION
	GuiControlGet, TargetMeseta
	If (TargetMeseta > 0){
		TargetMeseta := TargetMeseta*1000000
		GrinderMaxBuyAmount := (TargetMeseta//399600)+1
		UpdateStatus("Target Meseta Amount - " . RegExReplace(TargetMeseta, "(\G|[^\d.])\d{1,3}(?=(\d{3})+(\D|$))", "$0,") . " `n Buying " . GrinderMaxBuyAmount * 990 . " More Grinders...")
		GuiControl,Disable,TargetMeseta
	}
		else {
		UpdateStatus("Buying " . GrinderMaxBuyAmount * 990 . " More Grinders...")
		GuiControl,Disable,TargetMeseta
	}
	toggle := true
	While toggle = true
		if (GrinderMaxBuyAmount > 0) {
			; START AT SHOP MENU, "EX-Cube Exchange Shop" IS HOVERED
			ControlSend,, {Enter}, ahk_id %programid1%         ; OPEN PRODUCT LIST (SERVER ACTION)
			Sleep, 1100
			; PRODUCT LIST			
			ControlSend,, {Left}, ahk_id %programid1%          ; MAX BUY GRINDERS, 33 EX-Cubes FOR 990 Grinders
			Sleep, 400
			ControlSend,, {Enter}, ahk_id %programid1%         ; PURCHASE
			Sleep, 400
			ControlSend,, {Enter}, ahk_id %programid1%         ; CONFIRM EXCHANGE (SERVER ACTION)
			Sleep, 600
			ControlSend,, {Enter}, ahk_id %programid1%         ; CLOSE "Exchange Successful"
			Sleep, 400
			ControlSend,, {Esc}, ahk_id %programid1%           ; EXIT PRODUCT LIST
			Sleep, 400
			; SHOP MENU, "EX-Cube Exchange Shop" IS HOVERED
			ControlSend,, {Down}, ahk_id %programid1%          ; HOVER OVER "Open Storage"
			Sleep, 200
			ControlSend,, {Enter}, ahk_id %programid1%         ; OPEN STORAGE MENU
			Sleep, 400
			; STORAGE MENU, "Store Item" IS HOVERED
			ControlSend,, {Down}, ahk_id %programid1%          ; HOVER OVER "Retrieve Item"
			Sleep, 200
			ControlSend,, {Down}, ahk_id %programid1%          ; HOVER OVER "Batch Move to Material Storage"
			Sleep, 200
			ControlSend,, {Enter}, ahk_id %programid1%         ; CONFIRM "Batch Move to Material Storage"
			Sleep, 200
			ControlSend,, {Left}, ahk_id %programid1%          ; HOVER OVER "Yes"
			Sleep, 200
			ControlSend,, {Enter}, ahk_id %programid1%         ; CONFIRM BATCH MOVE (SERVER ACTION)
			Sleep, 200
			ControlSend,, {Esc}, ahk_id %programid1%           ; CLOSE STORAGE MENU
			Sleep, 400
			; SHOP MENU, "Open Storage" IS HOVERED
			ControlSend,, {Up}, ahk_id %programid1%            ; HOVER OVER "EX-Cube Exchange Shop"
			Sleep, 400
			; ... REPEAT LOOP ...
			--GrinderMaxBuyAmount
			++GrinderSellAmount
			UpdateStatus("Buying " . RegExReplace(GrinderMaxBuyAmount*990, "(\G|[^\d.])\d{1,3}(?=(\d{3})+(\D|$))", "$0,")   . " more Grinders... `n" . RegExReplace(GrinderSellAmount*990, "(\G|[^\d.])\d{1,3}(?=(\d{3})+(\D|$))", "$0,") . " Grinders bought `n" . RegExReplace(GrinderSellAmount*990*400, "(\G|[^\d.])\d{1,3}(?=(\d{3})+(\D|$))", "$0,") . " Meseta worth"  )
		}
		else {
			UpdateStatus("Ready to sell " . RegExReplace(GrinderSellAmount*990, "(\G|[^\d.])\d{1,3}(?=(\d{3})+(\D|$))", "$0,") . " Grinders `n" . RegExReplace(GrinderSellAmount*990*400, "(\G|[^\d.])\d{1,3}(?=(\d{3})+(\D|$))", "$0,") . " Meseta worth" )
			GuiControl,Disable,BuyBtn
			GuiControl,Enable,SellBtn
			MsgBox, 0, Grinders Bought!,% RegExReplace(GrinderSellAmount*990, "(\G|[^\d.])\d{1,3}(?=(\d{3})+(\D|$))", "$0,") " Grinders bought."
			return
		}
	; This case needed in case the loop is interrupted by a toggle
	UpdateStatus("Ready to sell " . RegExReplace(GrinderSellAmount*990, "(\G|[^\d.])\d{1,3}(?=(\d{3})+(\D|$))", "$0,") . " Grinders `n" . RegExReplace(GrinderSellAmount*990*400, "(\G|[^\d.])\d{1,3}(?=(\d{3})+(\D|$))", "$0,") . " Meseta worth"  )
	GuiControl,Enable,SellBtn
	MsgBox, 0, Purchase Complete!,% RegExReplace(GrinderSellAmount*990, "(\G|[^\d.])\d{1,3}(?=(\d{3})+(\D|$))", "$0,") " Grinders bought."
	Return

Break: ; BUTTON ACTION
toggle := false ; STOP WHILE LOOP
return

StartSelling:
	Loop {
		if (GrinderSellAmount > 0) {
			ControlSend,, {Left}, ahk_id %programid1%          ; SELECT 999 Grinders
			Sleep, 300
			ControlSend,, {Enter}, ahk_id %programid1%         ; SELL
			Sleep, 300
			ControlSend,, {Enter}, ahk_id %programid1%         ; CONFIRM SALE OF ITEMS (SERVER ACTION)
			Sleep, 500	
			ControlSend,, {Enter}, ahk_id %programid1%         ; CLOSE "Sale Complete"
			Sleep, 300	
			--GrinderSellAmount
			++SoldGrinderAmount
			UpdateStatus("Selling " . RegExReplace(GrinderSellAmount*999, "(\G|[^\d.])\d{1,3}(?=(\d{3})+(\D|$))", "$0,") . " More Grinders...")
		}
		else {	
			UpdateStatus("All Grinders Sold")
			GuiControl,Disable,SellBtn
			GuiControl,Enable,BuyBtn
			GuiControl,Enable,TargetMeseta
			GuiControl,,TargetMeseta,0
			MsgBox, 0, Grinders Sold!,% RegExReplace(SoldGrinderAmount*999, "(\G|[^\d.])\d{1,3}(?=(\d{3})+(\D|$))", "$0,") "Grinders sold for " RegExReplace(SoldGrinderAmount*999*400, "(\G|[^\d.])\d{1,3}(?=(\d{3})+(\D|$))", "$0,") " Meseta"
			GrinderMaxBuyAmount := 64
			SoldGrinderAmount := 0
			Exit
		}
	}
	
StartSellingManually: ; BUTTON ACTION
	toggle := true
	UpdateStatus("!!! MANUAL GRINDER SELLING PROCESS !!! `n Please keep an eye on your Grinder count and stop the process when it is about to reach Lambda Grinders!")
	GuiControl,Disable,SellBtn
	GuiControl,Disable,BuyBtn
	GuiControl,Disable,BreakBtn
	GuiControl,Disable,StartSellingManuallyBtn
	GuiControl,Disable,TargetMeseta
	GuiControl,Enable,StopManualSellBtn
	While toggle = true {
		ControlSend,, {Left}, ahk_id %programid1% 
		Sleep, 200
		ControlSend,, {Enter}, ahk_id %programid1%
		Sleep, 200
		ControlSend,, {Enter}, ahk_id %programid1%
		Sleep, 400	
		ControlSend,, {Enter}, ahk_id %programid1% 
		Sleep, 200	
	}
	
StopManualSell: ; BUTTON ACTION
	UpdateStatus("Idle.... `n Press F4 to force close this program. `n Press F2 to see instuctions and script.")
	GuiControl,Enable,SellBtn
	GuiControl,Enable,BuyBtn
	GuiControl,Enable,Break
	GuiControl,Enable,StartSellingManuallyBtn
	GuiControl,Enable,TargetMeseta
	GuiControl,Disable,StopManualSellBtn
	toggle := false ;while loop will stop with this
	return

UpdateStatus(status)
{
	GuiControl,,Status,%status%
}
#WinActivateForce
F1::WinActivate, GrindersProMax - S'pugn Edition
return

F2::Run https://github.com/Expugn/GrindersProMax-SpugnEdition/blob/main/README.md
return 

F4::ExitApp
