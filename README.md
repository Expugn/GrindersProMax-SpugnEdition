# GrindersProMax - S'pugn Edition
Original Script: https://github.com/KritixKaung/PSO2-GrindersProMax

## Information
This is a modified version of `PSO2-GrindersProMax` by `KritixKaung`.
This is designed for the GLOBAL version of `Phantasy Star Online 2`, the Japan version may or may not be compatible with this.

The differences between the original and this script is that it features a different buying route and an EX-Cube counter is included.

## Regarding ALT-TABing
It is best to bring this program to foreground with F1 to perform tasks while you're in the game instead of alt tabbing because alt tabbing 
might mess up with selections in the game. ***It is important that you don't input anything into the game while the script is running.***

## Script Timing
The original script is created for 144fps+ and around 100ping to server but has since been tweaked for a different setup.
If your performance has a huge difference from this the script might not perform as intended for you. 
Try increasing sleep timers in `50ms` increments.

**IF THIS IS YOUR FIRST TIME RUNNING THE SCRIPT, YOU MAY NEED TO MANUALLY ADJUST THE SLEEP TIMINGS TO WORK FOR YOU.**

For example, if the EX-Cube shop's product list hasn't loaded yet before the script is continuing to input keys...<br>
Use your favorite text editor to open `GrindersProMax_S'pugnEdition.ahk` and find this snippet of the script:
```
; START AT SHOP MENU, "EX-Cube Exchange Shop" IS HOVERED
ControlSend,, {Enter}, ahk_id %programid1%         ; OPEN PRODUCT LIST (SERVER ACTION)
Sleep, 1100
```
Modify `Sleep, 1100` to a timing that fits for you.

As a note, `1000` equals one second and `100` equals one-hundred milliseconds. If the shop is loading too slow, you would want to increase
`Sleep, 1100` to a higher number.

Inputs that control `(SERVER ACTIONS)` are especially important as they would depend on your connection to the server. A slower connection
may need more `Sleep` time to process the action.

## Requirements
- AutoHotKey (Tested on v1.1.33.06)
- PSO2 Material Storage Subscription 

## How To Use:
**MAKE SURE TO RUN THIS SCRIPT AS ADMINISTRATOR**. Inputs may not work otherwise.
### Buying Process
1. Make sure your Inventory and Material Storage are empty of Grinders.
	- This is to ensure you can buy as much Grinders as possible.
	- Material Storage has an item limit of 65,000 so existing Grinders may cause issues if purchasing the max.
2. Talk to Nyssa the EX-Cube NPC and open up the SHOP MENU.
3. Review the script GUI and set your desired targeted Meseta if needed.
	- Leaving the desired Meseta count as 0 will cause the script to purchase as much Grinders as possible.
4. While "EX-Cube Exchange Shop" is hovered, click the "Start Buying" button.
5. While the script is running...
	- You can also see the amount of grinders you have bought and meseta amount of it in the 
	  GUI so if you're only buying for a small amount of money you can end the buying process sooner by clicking "Stop Buying" button.

### Selling Process
1. Go to any NPC where you can sell items 
2. Select "Sell Items from Storage"
3. Open your Material Storage
4. Input "Grinder" in the search bar and Search
5. Make sure you have selected Grinders and click the "Start Selling" button.

## Script Buying Route Comparison
`GrindersProMax_v1` (18 Inputs)
```
START: Stand in front of Nyssa the EX-Cube NPC
Talk to Nyssa
Open EX-Cube Exchange Shop
Purchase 33 sets of Grinders (30) ; 990 Grinders total
Close EX-Cube Exchange Shop
Exit NPC conversation
Open Inventory (User must have material tab pre-selected)
Deposit first item in material tab to Material Storage
Close Inventory
... REPEAT ...
```

`GrindersProMax_S'pugnEdition` (15 Inputs)
```
START: Hovered over "EX-Cube Exchange Shop"
Open EX-Cube Exchange Shop
Purchase 33 sets of Grinders (30) ; 990 Grinders total
Close EX-Cube Exchange Shop
Open Storage
Batch Move to Material Storage
Close Storage
... REPEAT ...
```

## WARNING
**Please be aware that automated scripts are against the rules for `Phantasy Star Online 2`.**
I do not take responsibility for whatever happens to your account, please use this with caution.
