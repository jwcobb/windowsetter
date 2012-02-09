--Help from
--http://www.crystalballsoft.com/content/view/129/9/
--http://daringfireball.net/2006/12/display_size_applescript_the_lazy_way
--http://www.macosxhints.com/article.php

property _menubar : 42
--property _marginLeft : 16
--property _marginRight : 16
property _marginCenterWidth : 8
--property _marginTop : 16
--property _marginBottom : 16
property _marginCenterHeight : 8

property _window1Path : "FryingDutchman:Users:jcobb:Downloads"
property _window2Path : "FryingDutchman:Users:jcobb:Downloads"
property _window3Path : "FryingDutchman:Users:jcobb:Desktop"
property _window4Path : "FryingDutchman:Users:jcobb:Desktop"

tell application "Finder"
	-- See if POS & WWW folders exist and if so overwrite_windowPath vars from above
	if (exists folder "FryingDutchman:Users:jcobb:Sites:j.pos.dev:workingcopy:pos") is true then
		set _window2Path to "FryingDutchman:Users:jcobb:Sites:j.pos.dev:workingcopy:pos"
	end if
	if (exists folder "FryingDutchman:Users:jcobb:Sites:j.pos.dev:workingcopy:pos:public") is true then
		set _window4Path to "FryingDutchman:Users:jcobb:Sites:j.pos.dev:workingcopy:pos:public"
	end if

	set _b to bounds of window of desktop
	set _width to item 3 of _b
	set _height to item 4 of _b
end tell

if _width > 1440 then
	--Must be dual monitors. Set width to half of actual
	set _width to _width / 2
end if

set _marginLeft to (_width * 0.02)
set _marginRight to (_width * 0.02)
--set _marginCenterWidth to (_width * 0.01)

set _marginTop to ((_height - _menubar) * 0.02)
set _marginBottom to ((_height - _menubar) * 0.02)
--set _marginCenterHeight to ((_height - _menubar) * 0.01)

set _windowWidth to ((_width - _marginLeft - _marginRight - _marginCenterWidth) / 2)
set _windowHeight to ((_height - _menubar - _marginTop - _marginBottom - _marginCenterHeight) / 2)




tell application "Finder"
	--set default directory (Notice that "home" represents your home directory)
	--set folder1 to home
	--This is how you can refer to a subdirectory in your Home directory
	--set folder2 to ((home as string) & "Documents") as alias
	--Use this if you'd prefer your bottom folder to go to root
	--set folder2 to the startup disk

	--clean up
	activate
	--close every Finder window

	--Get the number of windows currently open
	--Unlike most scripts I don't want to close then re-open windows
	set _numWindows to count of Finder windows

	-- WINDOW 1: Top Left
	if _numWindows < 1 then
		set _window1 to make new Finder window
		set the target of _window1 to folder (_window1Path)
		set the current view of _window1 to column view
	else
		set _window1 to Finder window 1
	end if
	--{left,top,right,bottom}
	set the bounds of _window1 to {_marginLeft, (_menubar + _marginTop), (_marginLeft + _windowWidth), (_menubar + _marginTop + _windowHeight)}


	-- WINDOW 2: Top Right
	if _numWindows < 2 then
		set _window2 to make new Finder window
		set the target of _window2 to folder (_window2Path)
		set the current view of _window2 to column view
	else
		set _window2 to Finder window 2
	end if
	--{left,top,right,bottom}
	set the bounds of _window2 to {(_marginLeft + _windowWidth + _marginCenterWidth), (_menubar + _marginTop), (_marginLeft + (_windowWidth * 2) + _marginCenterWidth), (_menubar + _marginTop + _windowHeight)}


	-- WINDOW 3: Bottom Left
	if _numWindows < 3 then
		set _window3 to make new Finder window
		set the target of _window3 to folder (_window3Path) as alias
		set the current view of _window3 to column view
	else
		set _window3 to Finder window 3
	end if
	--{left,top,right,bottom}
	set the bounds of _window3 to {_marginLeft, (_menubar + _marginTop + _windowHeight + (_marginCenterHeight * 3)), (_marginLeft + _windowWidth), (_menubar + _marginTop + (_windowHeight * 2) + _marginCenterHeight)}


	-- WINDOW 4: Bottom Right
	if _numWindows < 4 then
		set _window4 to make new Finder window
		set the target of _window4 to folder (_window4Path)
		set the current view of _window4 to column view
	else
		set _window4 to Finder window 4
	end if
	--{left,top,right,bottom}
	set the bounds of _window4 to {(_marginLeft + _windowWidth + _marginCenterWidth), (_menubar + _marginTop + _windowHeight + (_marginCenterHeight * 3)), (_marginLeft + (_windowWidth * 2) + _marginCenterWidth), (_menubar + _marginTop + (_windowHeight * 2) + _marginCenterHeight)}
end tell
