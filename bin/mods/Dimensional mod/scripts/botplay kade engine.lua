function onUpdatePost(elapsed)
	setProperty('botplayTxt.y', 525)
	setTextFont('botplayTxt', 'comic.ttf')
    if getPropertyFromClass('ClientPrefs', 'downScroll') == true then
        setProperty('botplayTxt.y', 900)
    end
end