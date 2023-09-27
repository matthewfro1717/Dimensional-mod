--created with Super_Hugo's Stage Editor v1.6.3

function onCreate()

	makeLuaSprite('obj1', 'pp', -304, 14)
	setObjectOrder('obj1', 1)
	scaleObject('obj1', 1.5, 1.5)
	addLuaSprite('obj1', true)
	
	makeAnimatedLuaSprite('obj2', 'LazyLine', -235, 85)
	setObjectOrder('obj2', 2)
	scaleObject('obj2', 1.5, 1.5)
	addAnimationByPrefix('obj2', 'anim', 'LazyLine Background0', 24, true)
	playAnim('obj2', 'anim', true)
	addLuaSprite('obj2', true)
	
	makeAnimatedLuaSprite('obj3', 'C', -283, -28)
	setObjectOrder('obj3', 2)
	scaleObject('obj3', 1.5, 1.5)
	addAnimationByPrefix('obj3', 'anim', 'Background0', 24, true)
	playAnim('obj3', 'anim', true)
	addLuaSprite('obj3', true)
	
	makeLuaSprite('obj4', 'pe', -627, 8)
	setObjectOrder('obj4', 3)
	scaleObject('obj4', 3.6, 3.6)
	addLuaSprite('obj4', true)
	
end