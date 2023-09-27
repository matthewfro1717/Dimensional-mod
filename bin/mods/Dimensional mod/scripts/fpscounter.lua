function onCreatePost()
    addHaxeLibrary('Main');
runHaxeCode([[
        Main.fpsVar.defaultTextFormat = new openfl.text.TextFormat("engine/Dave.ttf", 16, -1);
    ]]);
end