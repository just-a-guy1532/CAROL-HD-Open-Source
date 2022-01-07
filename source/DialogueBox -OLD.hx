package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import haxe.Json;
import lime.utils.Assets;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;
	private var background:FlxSpriteGroup = new FlxSpriteGroup();
	private var splitBack:String = "";
	private var BGid:Int = -1;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;
	var portraitGF:FlxSprite;
	var portraitBF:FlxSprite;
	var portraitBF1:FlxSprite;
	var portraitBF2:FlxSprite;
	var portraitBF3:FlxSprite;
	var portraitGF1:FlxSprite;
	var portraitGF2:FlxSprite;
	var portraitGF3:FlxSprite;
	var portraitGF4:FlxSprite;
	var portraitGF5:FlxSprite;
	var portraitCR:FlxSprite;
	var portraitCR1:FlxSprite;
	var portraitCR2:FlxSprite;
	var portraitCR3:FlxSprite;
	var portraitCR4:FlxSprite;
	var portraitCR5:FlxSprite;
	var portraitCR6:FlxSprite;
	var portraitCR7:FlxSprite;
    

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);

			case 'carol-roll':
			    box = new FlxSprite(30, 390);
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByPrefix('normal', 'speech bubble normal', 24, true);

			case 'body':
			    box = new FlxSprite(30, 390);
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByPrefix('normal', 'speech bubble normal', 24, true);

			case 'boogie':
			    box = new FlxSprite(30, 390);
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('speech_bubble_talking');
				box.animation.addByPrefix('normalOpen', 'Speech Bubble Normal Open', 24, false);
				box.animation.addByPrefix('normal', 'speech bubble normal', 24, true);
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		
		switch (PlayState.SONG.song.toLowerCase()){
		    case 'carol-roll':
			var bgJson:Array<Dynamic> = cast Json.parse( Assets.getText( Paths.json('bg') ).trim() ).bg;

				for (ar in bgJson){
				var bg:FlxSprite = new FlxSprite();
				bg = new FlxSprite(ar[1], ar[2]).loadGraphic(Paths.image("bg/" + ar[0]));
				bg.scrollFactor.set();
				bg.antialiasing = true;
				bg.scale.set(ar[3], ar[3]);
				bg.visible = false;
				background.add(bg);
			}
			   add(background);
			   portraitLeft = new FlxSprite(50, 10);
		       portraitLeft.frames = Paths.getSparrowAtlas('Carol');
		       portraitLeft.animation.addByPrefix('enter', 'CarolPhone', 24, false);
		       portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.06));
		       portraitLeft.updateHitbox();
		       portraitLeft.scrollFactor.set();
			   portraitLeft.antialiasing = true;
		       add(portraitLeft);
		       portraitLeft.visible = false;

			   portraitCR = new FlxSprite(60, -50);
		       portraitCR.frames = Paths.getSparrowAtlas('Carol');
		       portraitCR.animation.addByPrefix('enter', 'CarolSurprised', 24, false);
		       portraitCR.setGraphicSize(Std.int(portraitCR.width * PlayState.daPixelZoom * 0.08));
		       portraitCR.updateHitbox();
		       portraitCR.scrollFactor.set();
			   portraitCR.antialiasing = true;
		       add(portraitCR);
		       portraitCR.visible = false;

			   portraitCR1 = new FlxSprite(50, 10);
		       portraitCR1.frames = Paths.getSparrowAtlas('Carol');
		       portraitCR1.animation.addByPrefix('enter', 'CarolAYO', 24, false);
		       portraitCR1.setGraphicSize(Std.int(portraitCR1.width * PlayState.daPixelZoom * 0.045));
		       portraitCR1.updateHitbox();
		       portraitCR1.scrollFactor.set();
			   portraitCR1.antialiasing = true;
		       add(portraitCR1);
		       portraitCR1.visible = false;

			   portraitCR2 = new FlxSprite(50, -50);
		       portraitCR2.frames = Paths.getSparrowAtlas('Carol');
		       portraitCR2.animation.addByPrefix('enter', 'CarolIdle', 24, false);
		       portraitCR2.setGraphicSize(Std.int(portraitCR2.width * PlayState.daPixelZoom * 0.07));
		       portraitCR2.updateHitbox();
		       portraitCR2.scrollFactor.set();
			   portraitCR2.antialiasing = true;
		       add(portraitCR2);
		       portraitCR2.visible = false;

			   portraitCR3 = new FlxSprite(50, -50);
		       portraitCR3.frames = Paths.getSparrowAtlas('Carol');
		       portraitCR3.animation.addByPrefix('enter', 'CarolQuestion', 24, false);
		       portraitCR3.setGraphicSize(Std.int(portraitCR3.width * PlayState.daPixelZoom * 0.07));
		       portraitCR3.updateHitbox();
		       portraitCR3.scrollFactor.set();
			   portraitCR3.antialiasing = true;
		       add(portraitCR3);
		       portraitCR3.visible = false;

			   portraitCR4 = new FlxSprite(50, -50);
		       portraitCR4.frames = Paths.getSparrowAtlas('Carol');
		       portraitCR4.animation.addByPrefix('enter', 'CarolFunny', 24, false);
		       portraitCR4.setGraphicSize(Std.int(portraitCR4.width * PlayState.daPixelZoom * 0.07));
		       portraitCR4.updateHitbox();
		       portraitCR4.scrollFactor.set();
			   portraitCR4.antialiasing = true;
		       add(portraitCR4);
		       portraitCR4.visible = false;

			   portraitCR5 = new FlxSprite(50, -80);
		       portraitCR5.frames = Paths.getSparrowAtlas('Carol');
		       portraitCR5.animation.addByPrefix('enter', 'CarolDown', 24, false);
		       portraitCR5.setGraphicSize(Std.int(portraitCR5.width * PlayState.daPixelZoom * 0.07));
		       portraitCR5.updateHitbox();
		       portraitCR5.scrollFactor.set();
			   portraitCR5.antialiasing = true;
		       add(portraitCR5);
		       portraitCR5.visible = false;

			   portraitCR6 = new FlxSprite(50, -50);
		       portraitCR6.frames = Paths.getSparrowAtlas('Carol');
		       portraitCR6.animation.addByPrefix('enter', 'CarolHappy', 24, false);
		       portraitCR6.setGraphicSize(Std.int(portraitCR6.width * PlayState.daPixelZoom * 0.06));
		       portraitCR6.updateHitbox();
		       portraitCR6.scrollFactor.set();
			   portraitCR6.antialiasing = true;
		       add(portraitCR6);
		       portraitCR6.visible = false;

			   portraitCR7 = new FlxSprite(50, -50);
		       portraitCR7.frames = Paths.getSparrowAtlas('Carol');
		       portraitCR7.animation.addByPrefix('enter', 'CarolLETSBATLLE', 24, false);
		       portraitCR7.setGraphicSize(Std.int(portraitCR7.width * PlayState.daPixelZoom * 0.06));
		       portraitCR7.updateHitbox();
		       portraitCR7.scrollFactor.set();
			   portraitCR7.antialiasing = true;
		       add(portraitCR7);
		       portraitCR7.visible = false;

			   portraitRight = new FlxSprite(700, 26);
		       portraitRight.frames = Paths.getSparrowAtlas('bf');
		       portraitRight.animation.addByPrefix('enter', 'bf smile', 24, false);
		       portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.07));
		       portraitRight.updateHitbox();
		       portraitRight.scrollFactor.set();
			   portraitRight.antialiasing = true;
		       add(portraitRight);
		       portraitRight.visible = false; 

			   portraitGF = new FlxSprite(620, 6);
		       portraitGF.frames = Paths.getSparrowAtlas('gf');
		       portraitGF.animation.addByPrefix('enter', 'gf smile', 24, false);
		       portraitGF.setGraphicSize(Std.int(portraitGF.width * PlayState.daPixelZoom * 0.07));
		       portraitGF.updateHitbox();
		       portraitGF.scrollFactor.set();
			   portraitGF.antialiasing = true;
		       add(portraitGF);
		       portraitGF.visible = false;

			   portraitGF1 = new FlxSprite(620, 6);
		       portraitGF1.frames = Paths.getSparrowAtlas('gf');
		       portraitGF1.animation.addByPrefix('enter', 'gf smile', 24, false);
		       portraitGF1.setGraphicSize(Std.int(portraitGF1.width * PlayState.daPixelZoom * 0.07));
		       portraitGF1.updateHitbox();
		       portraitGF1.scrollFactor.set();
			   portraitGF1.antialiasing = true;
		       add(portraitGF1);
		       portraitGF1.visible = false;

			   portraitGF2 = new FlxSprite(620, 6);
		       portraitGF2.frames = Paths.getSparrowAtlas('gf');
		       portraitGF2.animation.addByPrefix('enter', 'gf reassure', 24, false);
		       portraitGF2.setGraphicSize(Std.int(portraitGF2.width * PlayState.daPixelZoom * 0.09));
		       portraitGF2.updateHitbox();
		       portraitGF2.scrollFactor.set();
			   portraitGF2.antialiasing = true;
		       add(portraitGF2);
		       portraitGF2.visible = false;

			   portraitGF3 = new FlxSprite(620, 6);
		       portraitGF3.frames = Paths.getSparrowAtlas('gf');
		       portraitGF3.animation.addByPrefix('enter', 'gf owl', 24, false);
		       portraitGF3.setGraphicSize(Std.int(portraitGF3.width * PlayState.daPixelZoom * 0.07));
		       portraitGF3.updateHitbox();
		       portraitGF3.scrollFactor.set();
			   portraitGF3.antialiasing = true;
		       add(portraitGF3);
		       portraitGF3.visible = false;

			   portraitGF4 = new FlxSprite(620, 6);
		       portraitGF4.frames = Paths.getSparrowAtlas('gf');
		       portraitGF4.animation.addByPrefix('enter', 'gf worry', 24, false);
		       portraitGF4.setGraphicSize(Std.int(portraitGF4.width * PlayState.daPixelZoom * 0.07));
		       portraitGF4.updateHitbox();
		       portraitGF4.scrollFactor.set();
			   portraitGF4.antialiasing = true;
		       add(portraitGF4);
		       portraitGF4.visible = false;

			   portraitGF5 = new FlxSprite(620, 6);
		       portraitGF5.frames = Paths.getSparrowAtlas('gf');
		       portraitGF5.animation.addByPrefix('enter', 'gf default', 24, false);
		       portraitGF5.setGraphicSize(Std.int(portraitGF5.width * PlayState.daPixelZoom * 0.07));
		       portraitGF5.updateHitbox();
		       portraitGF5.scrollFactor.set();
			   portraitGF5.antialiasing = true;
		       add(portraitGF5);
		       portraitGF5.visible = false;

			   portraitBF = new FlxSprite(620, 6);
		       portraitBF.frames = Paths.getSparrowAtlas('bf');
		       portraitBF.animation.addByPrefix('enter', 'bf sulk', 24, false);
		       portraitBF.setGraphicSize(Std.int(portraitBF.width * PlayState.daPixelZoom * 0.07));
		       portraitBF.updateHitbox();
		       portraitBF.scrollFactor.set();
			   portraitBF.antialiasing = true;
		       add(portraitBF);
		       portraitBF.visible = false;

			   portraitBF1 = new FlxSprite(620, 6);
		       portraitBF1.frames = Paths.getSparrowAtlas('bf');
		       portraitBF1.animation.addByPrefix('enter', 'bf angry 2', 24, false);
		       portraitBF1.setGraphicSize(Std.int(portraitBF1.width * PlayState.daPixelZoom * 0.07));
		       portraitBF1.updateHitbox();
		       portraitBF1.scrollFactor.set();
			   portraitBF1.antialiasing = true;
		       add(portraitBF1);
		       portraitBF1.visible = false;
		      
			   
		    box.animation.play('normalOpen');
		    box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.17));
		    box.updateHitbox();
		    add(box);

		    box.screenCenter(X);
		   
		}

		switch (PlayState.SONG.song.toLowerCase()){
		    case 'body':
			var bgJson:Array<Dynamic> = cast Json.parse( Assets.getText( Paths.json('bg') ).trim() ).bg;

				for (ar in bgJson){
				var bg:FlxSprite = new FlxSprite();
				bg = new FlxSprite(ar[1], ar[2]).loadGraphic(Paths.image("bg/" + ar[0]));
				bg.scrollFactor.set();
				bg.antialiasing = true;
				bg.scale.set(ar[3], ar[3]);
				bg.visible = false;
				background.add(bg);
			}
			   add(background);
			   portraitLeft = new FlxSprite(50, -50);
		       portraitLeft.frames = Paths.getSparrowAtlas('Carol');
		       portraitLeft.animation.addByPrefix('enter', 'CarolStressed', 24, false);
		       portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.07));
		       portraitLeft.updateHitbox();
		       portraitLeft.scrollFactor.set();
			   portraitLeft.antialiasing = true;
		       add(portraitLeft);
		       portraitLeft.visible = false;

			   portraitCR = new FlxSprite(60, -50);
		       portraitCR.frames = Paths.getSparrowAtlas('Carol');
		       portraitCR.animation.addByPrefix('enter', 'Carolyouaredead', 24, false);
		       portraitCR.setGraphicSize(Std.int(portraitCR.width * PlayState.daPixelZoom * 0.06));
		       portraitCR.updateHitbox();
		       portraitCR.scrollFactor.set();
			   portraitCR.antialiasing = true;
		       add(portraitCR);
		       portraitCR.visible = false;

			   portraitCR1 = new FlxSprite(50, 10);
		       portraitCR1.frames = Paths.getSparrowAtlas('Carol');
		       portraitCR1.animation.addByPrefix('enter', 'CarolWorried', 24, false);
		       portraitCR1.setGraphicSize(Std.int(portraitCR1.width * PlayState.daPixelZoom * 0.07));
		       portraitCR1.updateHitbox();
		       portraitCR1.scrollFactor.set();
			   portraitCR1.antialiasing = true;
		       add(portraitCR1);
		       portraitCR1.visible = false;

			   portraitCR2 = new FlxSprite(50, -50);
		       portraitCR2.frames = Paths.getSparrowAtlas('Carol');
		       portraitCR2.animation.addByPrefix('enter', 'CarolIdle', 24, false);
		       portraitCR2.setGraphicSize(Std.int(portraitCR2.width * PlayState.daPixelZoom * 0.07));
		       portraitCR2.updateHitbox();
		       portraitCR2.scrollFactor.set();
			   portraitCR2.antialiasing = true;
		       add(portraitCR2);
		       portraitCR2.visible = false;

			   portraitCR3 = new FlxSprite(50, -50);
		       portraitCR3.frames = Paths.getSparrowAtlas('Carol');
		       portraitCR3.animation.addByPrefix('enter', 'CarolQuestion', 24, false);
		       portraitCR3.setGraphicSize(Std.int(portraitCR3.width * PlayState.daPixelZoom * 0.07));
		       portraitCR3.updateHitbox();
		       portraitCR3.scrollFactor.set();
			   portraitCR3.antialiasing = true;
		       add(portraitCR3);
		       portraitCR3.visible = false;

			   portraitCR4 = new FlxSprite(50, -50);
		       portraitCR4.frames = Paths.getSparrowAtlas('Carol');
		       portraitCR4.animation.addByPrefix('enter', 'CarolFunny', 24, false);
		       portraitCR4.setGraphicSize(Std.int(portraitCR4.width * PlayState.daPixelZoom * 0.07));
		       portraitCR4.updateHitbox();
		       portraitCR4.scrollFactor.set();
			   portraitCR4.antialiasing = true;
		       add(portraitCR4);
		       portraitCR4.visible = false;

			   portraitCR5 = new FlxSprite(50, -80);
		       portraitCR5.frames = Paths.getSparrowAtlas('Carol');
		       portraitCR5.animation.addByPrefix('enter', 'CarolDown', 24, false);
		       portraitCR5.setGraphicSize(Std.int(portraitCR5.width * PlayState.daPixelZoom * 0.07));
		       portraitCR5.updateHitbox();
		       portraitCR5.scrollFactor.set();
			   portraitCR5.antialiasing = true;
		       add(portraitCR5);
		       portraitCR5.visible = false;

			   portraitCR6 = new FlxSprite(50, -50);
		       portraitCR6.frames = Paths.getSparrowAtlas('Carol');
		       portraitCR6.animation.addByPrefix('enter', 'CarolHappy', 24, false);
		       portraitCR6.setGraphicSize(Std.int(portraitCR6.width * PlayState.daPixelZoom * 0.06));
		       portraitCR6.updateHitbox();
		       portraitCR6.scrollFactor.set();
			   portraitCR6.antialiasing = true;
		       add(portraitCR6);
		       portraitCR6.visible = false;

			   portraitCR7 = new FlxSprite(50, -50);
		       portraitCR7.frames = Paths.getSparrowAtlas('Carol');
		       portraitCR7.animation.addByPrefix('enter', 'CarolLETSBATLLE', 24, false);
		       portraitCR7.setGraphicSize(Std.int(portraitCR7.width * PlayState.daPixelZoom * 0.06));
		       portraitCR7.updateHitbox();
		       portraitCR7.scrollFactor.set();
			   portraitCR7.antialiasing = true;
		       add(portraitCR7);
		       portraitCR7.visible = false;

			   portraitRight = new FlxSprite(580, 26);
		       portraitRight.frames = Paths.getSparrowAtlas('bf');
		       portraitRight.animation.addByPrefix('enter', 'bf scoff', 24, false);
		       portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.07));
		       portraitRight.updateHitbox();
		       portraitRight.scrollFactor.set();
			   portraitRight.antialiasing = true;
		       add(portraitRight);
		       portraitRight.visible = false; 

			   portraitGF = new FlxSprite(620, 6);
		       portraitGF.frames = Paths.getSparrowAtlas('gf');
		       portraitGF.animation.addByPrefix('enter', 'gf think', 24, false);
		       portraitGF.setGraphicSize(Std.int(portraitGF.width * PlayState.daPixelZoom * 0.085));
		       portraitGF.updateHitbox();
		       portraitGF.scrollFactor.set();
			   portraitGF.antialiasing = true;
		       add(portraitGF);
		       portraitGF.visible = false;

			   portraitGF1 = new FlxSprite(620, 6);
		       portraitGF1.frames = Paths.getSparrowAtlas('gf');
		       portraitGF1.animation.addByPrefix('enter', 'gf smile', 24, false);
		       portraitGF1.setGraphicSize(Std.int(portraitGF1.width * PlayState.daPixelZoom * 0.07));
		       portraitGF1.updateHitbox();
		       portraitGF1.scrollFactor.set();
			   portraitGF1.antialiasing = true;
		       add(portraitGF1);
		       portraitGF1.visible = false;

			   portraitGF2 = new FlxSprite(620, 6);
		       portraitGF2.frames = Paths.getSparrowAtlas('gf');
		       portraitGF2.animation.addByPrefix('enter', 'gf reassure', 24, false);
		       portraitGF2.setGraphicSize(Std.int(portraitGF2.width * PlayState.daPixelZoom * 0.09));
		       portraitGF2.updateHitbox();
		       portraitGF2.scrollFactor.set();
			   portraitGF2.antialiasing = true;
		       add(portraitGF2);
		       portraitGF2.visible = false;

			   portraitGF3 = new FlxSprite(620, 6);
		       portraitGF3.frames = Paths.getSparrowAtlas('gf');
		       portraitGF3.animation.addByPrefix('enter', 'gf owl', 24, false);
		       portraitGF3.setGraphicSize(Std.int(portraitGF3.width * PlayState.daPixelZoom * 0.07));
		       portraitGF3.updateHitbox();
		       portraitGF3.scrollFactor.set();
			   portraitGF3.antialiasing = true;
		       add(portraitGF3);
		       portraitGF3.visible = false;

			   portraitGF4 = new FlxSprite(620, 6);
		       portraitGF4.frames = Paths.getSparrowAtlas('gf');
		       portraitGF4.animation.addByPrefix('enter', 'gf worry', 24, false);
		       portraitGF4.setGraphicSize(Std.int(portraitGF4.width * PlayState.daPixelZoom * 0.07));
		       portraitGF4.updateHitbox();
		       portraitGF4.scrollFactor.set();
			   portraitGF4.antialiasing = true;
		       add(portraitGF4);
		       portraitGF4.visible = false;

			   portraitGF5 = new FlxSprite(620, 6);
		       portraitGF5.frames = Paths.getSparrowAtlas('gf');
		       portraitGF5.animation.addByPrefix('enter', 'gf default', 24, false);
		       portraitGF5.setGraphicSize(Std.int(portraitGF5.width * PlayState.daPixelZoom * 0.07));
		       portraitGF5.updateHitbox();
		       portraitGF5.scrollFactor.set();
			   portraitGF5.antialiasing = true;
		       add(portraitGF5);
		       portraitGF5.visible = false;

			   portraitBF = new FlxSprite(560, 6);
		       portraitBF.frames = Paths.getSparrowAtlas('bf');
		       portraitBF.animation.addByPrefix('enter', 'bf flirt', 24, false);
		       portraitBF.setGraphicSize(Std.int(portraitBF.width * PlayState.daPixelZoom * 0.07));
		       portraitBF.updateHitbox();
		       portraitBF.scrollFactor.set();
			   portraitBF.antialiasing = true;
		       add(portraitBF);
		       portraitBF.visible = false;

			   portraitBF1 = new FlxSprite(575, 6);
		       portraitBF1.frames = Paths.getSparrowAtlas('bf');
		       portraitBF1.animation.addByPrefix('enter', 'bf default', 24, false);
		       portraitBF1.setGraphicSize(Std.int(portraitBF1.width * PlayState.daPixelZoom * 0.057));
		       portraitBF1.updateHitbox();
		       portraitBF1.scrollFactor.set();
			   portraitBF1.antialiasing = true;
		       add(portraitBF1);
		       portraitBF1.visible = false;
		      
			   
		    box.animation.play('normalOpen');
		    box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.17));
		    box.updateHitbox();
		    add(box);

		    box.screenCenter(X);
		   
		}

		switch (PlayState.SONG.song.toLowerCase()){
		    case 'boogie':
			var bgJson:Array<Dynamic> = cast Json.parse( Assets.getText( Paths.json('bg') ).trim() ).bg;

				for (ar in bgJson){
				var bg:FlxSprite = new FlxSprite();
				bg = new FlxSprite(ar[1], ar[2]).loadGraphic(Paths.image("bg/" + ar[0]));
				bg.scrollFactor.set();
				bg.antialiasing = true;
				bg.scale.set(ar[3], ar[3]);
				bg.visible = false;
				background.add(bg);
			}
			   add(background);
			   portraitLeft = new FlxSprite(50, -50);
		       portraitLeft.frames = Paths.getSparrowAtlas('Carol');
		       portraitLeft.animation.addByPrefix('enter', 'CarolZZZ', 24, false);
		       portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.07));
		       portraitLeft.updateHitbox();
		       portraitLeft.scrollFactor.set();
			   portraitLeft.antialiasing = true;
		       add(portraitLeft);
		       portraitLeft.visible = false;

			   portraitCR = new FlxSprite(60, -50);
		       portraitCR.frames = Paths.getSparrowAtlas('Carol');
		       portraitCR.animation.addByPrefix('enter', 'Carolyouaredead', 24, false);
		       portraitCR.setGraphicSize(Std.int(portraitCR.width * PlayState.daPixelZoom * 0.06));
		       portraitCR.updateHitbox();
		       portraitCR.scrollFactor.set();
			   portraitCR.antialiasing = true;
		       add(portraitCR);
		       portraitCR.visible = false;

			   portraitCR1 = new FlxSprite(50, -50);
		       portraitCR1.frames = Paths.getSparrowAtlas('Carol');
		       portraitCR1.animation.addByPrefix('enter', 'CarolStressed', 24, false);
		       portraitCR1.setGraphicSize(Std.int(portraitCR1.width * PlayState.daPixelZoom * 0.07));
		       portraitCR1.updateHitbox();
		       portraitCR1.scrollFactor.set();
			   portraitCR1.antialiasing = true;
		       add(portraitCR1);
		       portraitCR1.visible = false;

			   portraitCR2 = new FlxSprite(50, -50);
		       portraitCR2.frames = Paths.getSparrowAtlas('Carol');
		       portraitCR2.animation.addByPrefix('enter', 'CarolAngry', 24, false);
		       portraitCR2.setGraphicSize(Std.int(portraitCR2.width * PlayState.daPixelZoom * 0.07));
		       portraitCR2.updateHitbox();
		       portraitCR2.scrollFactor.set();
			   portraitCR2.antialiasing = true;
		       add(portraitCR2);
		       portraitCR2.visible = false;

			   portraitCR3 = new FlxSprite(50, -50);
		       portraitCR3.frames = Paths.getSparrowAtlas('Carol');
		       portraitCR3.animation.addByPrefix('enter', 'CarolLETSBATLLE', 24, false);
		       portraitCR3.setGraphicSize(Std.int(portraitCR3.width * PlayState.daPixelZoom * 0.07));
		       portraitCR3.updateHitbox();
		       portraitCR3.scrollFactor.set();
			   portraitCR3.antialiasing = true;
		       add(portraitCR3);
		       portraitCR3.visible = false;

			   portraitCR4 = new FlxSprite(50, -50);
		       portraitCR4.frames = Paths.getSparrowAtlas('Carol');
		       portraitCR4.animation.addByPrefix('enter', 'CarolFunny', 24, false);
		       portraitCR4.setGraphicSize(Std.int(portraitCR4.width * PlayState.daPixelZoom * 0.07));
		       portraitCR4.updateHitbox();
		       portraitCR4.scrollFactor.set();
			   portraitCR4.antialiasing = true;
		       add(portraitCR4);
		       portraitCR4.visible = false;

			   portraitCR5 = new FlxSprite(50, -80);
		       portraitCR5.frames = Paths.getSparrowAtlas('Carol');
		       portraitCR5.animation.addByPrefix('enter', 'CarolDown', 24, false);
		       portraitCR5.setGraphicSize(Std.int(portraitCR5.width * PlayState.daPixelZoom * 0.07));
		       portraitCR5.updateHitbox();
		       portraitCR5.scrollFactor.set();
			   portraitCR5.antialiasing = true;
		       add(portraitCR5);
		       portraitCR5.visible = false;

			   portraitCR6 = new FlxSprite(50, -50);
		       portraitCR6.frames = Paths.getSparrowAtlas('Carol');
		       portraitCR6.animation.addByPrefix('enter', 'CarolHappy', 24, false);
		       portraitCR6.setGraphicSize(Std.int(portraitCR6.width * PlayState.daPixelZoom * 0.06));
		       portraitCR6.updateHitbox();
		       portraitCR6.scrollFactor.set();
			   portraitCR6.antialiasing = true;
		       add(portraitCR6);
		       portraitCR6.visible = false;

			   portraitCR7 = new FlxSprite(50, -50);
		       portraitCR7.frames = Paths.getSparrowAtlas('Carol');
		       portraitCR7.animation.addByPrefix('enter', 'CarolLETSBATLLE', 24, false);
		       portraitCR7.setGraphicSize(Std.int(portraitCR7.width * PlayState.daPixelZoom * 0.06));
		       portraitCR7.updateHitbox();
		       portraitCR7.scrollFactor.set();
			   portraitCR7.antialiasing = true;
		       add(portraitCR7);
		       portraitCR7.visible = false;

			   portraitRight = new FlxSprite(580, 26);
		       portraitRight.frames = Paths.getSparrowAtlas('bf');
		       portraitRight.animation.addByPrefix('enter', 'bf scoff', 24, false);
		       portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.07));
		       portraitRight.updateHitbox();
		       portraitRight.scrollFactor.set();
			   portraitRight.antialiasing = true;
		       add(portraitRight);
		       portraitRight.visible = false; 

			   portraitGF = new FlxSprite(620, 6);
		       portraitGF.frames = Paths.getSparrowAtlas('gf');
		       portraitGF.animation.addByPrefix('enter', 'gf wehhh', 24, false);
		       portraitGF.setGraphicSize(Std.int(portraitGF.width * PlayState.daPixelZoom * 0.07));
		       portraitGF.updateHitbox();
		       portraitGF.scrollFactor.set();
			   portraitGF.antialiasing = true;
		       add(portraitGF);
		       portraitGF.visible = false;

			   portraitGF1 = new FlxSprite(620, 6);
		       portraitGF1.frames = Paths.getSparrowAtlas('gf');
		       portraitGF1.animation.addByPrefix('enter', 'gf think', 24, false);
		       portraitGF1.setGraphicSize(Std.int(portraitGF1.width * PlayState.daPixelZoom * 0.085));
		       portraitGF1.updateHitbox();
		       portraitGF1.scrollFactor.set();
			   portraitGF1.antialiasing = true;
		       add(portraitGF1);
		       portraitGF1.visible = false;

			   portraitGF2 = new FlxSprite(620, 6);
		       portraitGF2.frames = Paths.getSparrowAtlas('gf');
		       portraitGF2.animation.addByPrefix('enter', 'gf worry', 24, false);
		       portraitGF2.setGraphicSize(Std.int(portraitGF2.width * PlayState.daPixelZoom * 0.07));
		       portraitGF2.updateHitbox();
		       portraitGF2.scrollFactor.set();
			   portraitGF2.antialiasing = true;
		       add(portraitGF2);
		       portraitGF2.visible = false;

			   portraitGF3 = new FlxSprite(620, 6);
		       portraitGF3.frames = Paths.getSparrowAtlas('gf');
		       portraitGF3.animation.addByPrefix('enter', 'gf owl', 24, false);
		       portraitGF3.setGraphicSize(Std.int(portraitGF3.width * PlayState.daPixelZoom * 0.07));
		       portraitGF3.updateHitbox();
		       portraitGF3.scrollFactor.set();
			   portraitGF3.antialiasing = true;
		       add(portraitGF3);
		       portraitGF3.visible = false;

			   portraitGF4 = new FlxSprite(620, 6);
		       portraitGF4.frames = Paths.getSparrowAtlas('gf');
		       portraitGF4.animation.addByPrefix('enter', 'gf worry', 24, false);
		       portraitGF4.setGraphicSize(Std.int(portraitGF4.width * PlayState.daPixelZoom * 0.07));
		       portraitGF4.updateHitbox();
		       portraitGF4.scrollFactor.set();
			   portraitGF4.antialiasing = true;
		       add(portraitGF4);
		       portraitGF4.visible = false;

			   portraitGF5 = new FlxSprite(620, 6);
		       portraitGF5.frames = Paths.getSparrowAtlas('gf');
		       portraitGF5.animation.addByPrefix('enter', 'gf default', 24, false);
		       portraitGF5.setGraphicSize(Std.int(portraitGF5.width * PlayState.daPixelZoom * 0.07));
		       portraitGF5.updateHitbox();
		       portraitGF5.scrollFactor.set();
			   portraitGF5.antialiasing = true;
		       add(portraitGF5);
		       portraitGF5.visible = false;

			   portraitBF = new FlxSprite(560, 6);
		       portraitBF.frames = Paths.getSparrowAtlas('bf');
		       portraitBF.animation.addByPrefix('enter', 'bf oof', 24, false);
		       portraitBF.setGraphicSize(Std.int(portraitBF.width * PlayState.daPixelZoom * 0.07));
		       portraitBF.updateHitbox();
		       portraitBF.scrollFactor.set();
			   portraitBF.antialiasing = true;
		       add(portraitBF);
		       portraitBF.visible = false;

			   portraitBF1 = new FlxSprite(575, 6);
		       portraitBF1.frames = Paths.getSparrowAtlas('bf');
		       portraitBF1.animation.addByPrefix('enter', 'bf sulk', 24, false);
		       portraitBF1.setGraphicSize(Std.int(portraitBF1.width * PlayState.daPixelZoom * 0.07));
		       portraitBF1.updateHitbox();
		       portraitBF1.scrollFactor.set();
			   portraitBF1.antialiasing = true;
		       add(portraitBF1);
		       portraitBF1.visible = false;
		      
			   
		    box.animation.play('normalOpen');
		    box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.17));
		    box.updateHitbox();
		    add(box);

		    box.screenCenter(X);
		   
		}

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
		add(handSelect);


		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFFD89494;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.color = 0xFF3F2021;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

        if(FlxG.keys.justPressed.SHIFT && !isEnding){

			isEnding = true;
			endDialogue();
		}

		if (PlayerSettings.player1.controls.ACCEPT && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;
					endDialogue();

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function endDialogue(){

		if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
			FlxG.sound.music.fadeOut(2.2, 0);

		new FlxTimer().start(1.2, function(tmr:FlxTimer)
		{
			finishThing();
			kill();
			FlxG.sound.music.stop();
		});

	}

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		if(splitBack == "none"){
			background.visible = false;
			bgFade.visible = true;
		}else{
			if(background.members.length > 1 && splitBack.length > 0){
				var id = Std.parseInt(splitBack) -1;
				if(BGid != -1){
					background.members[BGid].visible = false;
				}
				if(id >= 0){
					bgFade.visible = false;
					background.visible = true;
					background.members[id].visible = true;
					BGid = id;
				}
			}
		}

		switch (curCharacter)
		{
			case 'Crol':
				portraitRight.visible = false;
				portraitGF.visible = false;
				portraitBF.visible = false;
				portraitBF1.visible = false;
				portraitGF1.visible = false;
				portraitGF2.visible = false;
				portraitGF3.visible = false;
				portraitGF4.visible = false;
				portraitGF5.visible = false;
				portraitCR.visible = false;
				portraitCR1.visible = false;
				portraitCR2.visible = false;
				portraitCR3.visible = false;
				portraitCR4.visible = false;
				portraitCR5.visible = false;
				portraitCR6.visible = false;
				portraitCR7.visible = false;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('carolText'), 0.6)];
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'Crol1':
				portraitRight.visible = false;
				portraitGF.visible = false;
				portraitBF.visible = false;
				portraitBF1.visible = false;
				portraitGF1.visible = false;
				portraitGF2.visible = false;
				portraitGF3.visible = false;
				portraitGF4.visible = false;
				portraitGF5.visible = false;
				portraitLeft.visible = false;
				portraitCR1.visible = false;
				portraitCR2.visible = false;
				portraitCR3.visible = false;
				portraitCR4.visible = false;
				portraitCR5.visible = false;
				portraitCR6.visible = false;
				portraitCR7.visible = false;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('carolText'), 0.6)];
				if (!portraitCR.visible)
				{
					portraitCR.visible = true;
					portraitCR.animation.play('enter');
				}
			case 'Crol2':
				portraitRight.visible = false;
				portraitGF.visible = false;
				portraitBF.visible = false;
				portraitBF1.visible = false;
				portraitGF1.visible = false;
				portraitGF2.visible = false;
				portraitGF3.visible = false;
				portraitGF4.visible = false;
				portraitGF5.visible = false;
				portraitLeft.visible = false;
				portraitCR.visible = false;
				portraitCR2.visible = false;
				portraitCR3.visible = false;
				portraitCR4.visible = false;
				portraitCR5.visible = false;
				portraitCR6.visible = false;
				portraitCR7.visible = false;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('carolText'), 0.6)];
				if (!portraitCR1.visible)
				{
					portraitCR1.visible = true;
					portraitCR1.animation.play('enter');
				}
			case 'Crol3':
				portraitRight.visible = false;
				portraitGF.visible = false;
				portraitBF.visible = false;
				portraitBF1.visible = false;
				portraitGF1.visible = false;
				portraitGF2.visible = false;
				portraitGF3.visible = false;
				portraitGF4.visible = false;
				portraitGF5.visible = false;
				portraitLeft.visible = false;
				portraitCR.visible = false;
				portraitCR1.visible = false;
				portraitCR3.visible = false;
				portraitCR4.visible = false;
				portraitCR5.visible = false;
				portraitCR6.visible = false;
				portraitCR7.visible = false;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('carolText'), 0.6)];
				if (!portraitCR2.visible)
				{
					portraitCR2.visible = true;
					portraitCR2.animation.play('enter');
				}
			case 'Crol4':
				portraitRight.visible = false;
				portraitGF.visible = false;
				portraitBF.visible = false;
				portraitBF1.visible = false;
				portraitGF1.visible = false;
				portraitGF2.visible = false;
				portraitGF3.visible = false;
				portraitGF4.visible = false;
				portraitGF5.visible = false;
				portraitLeft.visible = false;
				portraitCR.visible = false;
				portraitCR1.visible = false;
				portraitCR2.visible = false;
				portraitCR4.visible = false;
				portraitCR5.visible = false;
				portraitCR6.visible = false;
				portraitCR7.visible = false;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('carolText'), 0.6)];
				if (!portraitCR3.visible)
				{
					portraitCR3.visible = true;
					portraitCR3.animation.play('enter');
				}
			case 'Crol5':
				portraitRight.visible = false;
				portraitGF.visible = false;
				portraitBF.visible = false;
				portraitBF1.visible = false;
				portraitGF1.visible = false;
				portraitGF2.visible = false;
				portraitGF3.visible = false;
				portraitGF4.visible = false;
				portraitGF5.visible = false;
				portraitLeft.visible = false;
				portraitCR.visible = false;
				portraitCR1.visible = false;
				portraitCR2.visible = false;
				portraitCR3.visible = false;
				portraitCR5.visible = false;
				portraitCR6.visible = false;
				portraitCR7.visible = false;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('carolText'), 0.6)];
				if (!portraitCR4.visible)
				{
					portraitCR4.visible = true;
					portraitCR4.animation.play('enter');
				}
			case 'Crol6':
				portraitRight.visible = false;
				portraitGF.visible = false;
				portraitBF.visible = false;
				portraitBF1.visible = false;
				portraitGF1.visible = false;
				portraitGF2.visible = false;
				portraitGF3.visible = false;
				portraitGF4.visible = false;
				portraitGF5.visible = false;
				portraitLeft.visible = false;
				portraitCR.visible = false;
				portraitCR1.visible = false;
				portraitCR2.visible = false;
				portraitCR3.visible = false;
				portraitCR4.visible = false;
				portraitCR6.visible = false;
				portraitCR7.visible = false;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('carolText'), 0.6)];
				if (!portraitCR5.visible)
				{
					portraitCR5.visible = true;
					portraitCR5.animation.play('enter');
				}
			case 'Crol7':
				portraitRight.visible = false;
				portraitGF.visible = false;
				portraitBF.visible = false;
				portraitBF1.visible = false;
				portraitGF1.visible = false;
				portraitGF2.visible = false;
				portraitGF3.visible = false;
				portraitGF4.visible = false;
				portraitGF5.visible = false;
				portraitLeft.visible = false;
				portraitCR.visible = false;
				portraitCR1.visible = false;
				portraitCR2.visible = false;
				portraitCR3.visible = false;
				portraitCR4.visible = false;
				portraitCR5.visible = false;
				portraitCR7.visible = false;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('carolText'), 0.6)];
				if (!portraitCR6.visible)
				{
					portraitCR6.visible = true;
					portraitCR6.animation.play('enter');
				}
			case 'Crol8':
				portraitRight.visible = false;
				portraitGF.visible = false;
				portraitBF.visible = false;
				portraitBF1.visible = false;
				portraitGF1.visible = false;
				portraitGF2.visible = false;
				portraitGF3.visible = false;
				portraitGF4.visible = false;
				portraitGF5.visible = false;
				portraitLeft.visible = false;
				portraitCR.visible = false;
				portraitCR1.visible = false;
				portraitCR2.visible = false;
				portraitCR3.visible = false;
				portraitCR4.visible = false;
				portraitCR5.visible = false;
				portraitCR6.visible = false;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('carolText'), 0.6)];
				if (!portraitCR7.visible)
				{
					portraitCR7.visible = true;
					portraitCR7.animation.play('enter');
				}
			case 'BF':
				portraitLeft.visible = false;
				portraitGF.visible = false;
				portraitBF.visible = false;
				portraitBF1.visible = false;
				portraitGF1.visible = false;
				portraitGF2.visible = false;
				portraitGF3.visible = false;
				portraitGF4.visible = false;
				portraitGF5.visible = false;
				portraitCR.visible = false;
				portraitCR1.visible = false;
				portraitCR2.visible = false;
				portraitCR3.visible = false;
				portraitCR4.visible = false;
				portraitCR5.visible = false;
				portraitCR6.visible = false;
				portraitCR7.visible = false;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('boyfriendText'), 0.6)];
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
			case 'BF1':
				portraitLeft.visible = false;
				portraitGF.visible = false;
				portraitRight.visible = false;
				portraitBF1.visible = false;
				portraitGF1.visible = false;
				portraitGF2.visible = false;
				portraitGF3.visible = false;
				portraitGF4.visible = false;
				portraitGF5.visible = false;
				portraitCR.visible = false;
				portraitCR1.visible = false;
				portraitCR2.visible = false;
				portraitCR3.visible = false;
				portraitCR4.visible = false;
				portraitCR4.visible = false;
				portraitCR5.visible = false;
				portraitCR6.visible = false;
				portraitCR7.visible = false;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('boyfriendText'), 0.6)];
				if (!portraitBF.visible)
				{
					portraitBF.visible = true;
					portraitBF.animation.play('enter');
				}
			case 'BF2':
				portraitLeft.visible = false;
				portraitGF.visible = false;
				portraitRight.visible = false;
				portraitBF.visible = false;
				portraitGF1.visible = false;
				portraitGF2.visible = false;
				portraitGF3.visible = false;
				portraitGF4.visible = false;
				portraitGF5.visible = false;
				portraitCR.visible = false;
				portraitCR1.visible = false;
				portraitCR2.visible = false;
				portraitCR3.visible = false;
				portraitCR4.visible = false;
				portraitCR5.visible = false;
				portraitCR6.visible = false;
				portraitCR7.visible = false;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('boyfriendText'), 0.6)];
				if (!portraitBF1.visible)
				{
					portraitBF1.visible = true;
					portraitBF1.animation.play('enter');
				}
			case 'BF3':
				portraitLeft.visible = false;
				portraitGF.visible = false;
				portraitRight.visible = false;
				portraitBF.visible = false;
				portraitGF1.visible = false;
				portraitGF2.visible = false;
				portraitGF3.visible = false;
				portraitGF4.visible = false;
				portraitGF5.visible = false;
				portraitCR.visible = false;
				portraitCR1.visible = false;
				portraitCR2.visible = false;
				portraitCR3.visible = false;
				portraitCR4.visible = false;
				portraitCR5.visible = false;
				portraitCR6.visible = false;
				portraitCR7.visible = false;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('boyfriendText'), 0.6)];
				if (!portraitBF2.visible)
				{
					portraitBF2.visible = true;
					portraitBF2.animation.play('enter');
				}
			case 'GF':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitBF.visible = false;
				portraitBF1.visible = false;
				portraitGF1.visible = false;
				portraitGF2.visible = false;
				portraitGF3.visible = false;
				portraitGF4.visible = false;
				portraitGF5.visible = false;
				portraitCR.visible = false;
				portraitCR1.visible = false;
				portraitCR2.visible = false;
				portraitCR3.visible = false;
				portraitCR4.visible = false;
				portraitCR5.visible = false;
				portraitCR6.visible = false;
				portraitCR7.visible = false;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('gfText'), 0.6)];
				if (!portraitGF.visible)
				{
					portraitGF.visible = true;
					portraitGF.animation.play('enter');
				}
				case 'GF1':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitBF.visible = false;
				portraitGF2.visible = false;
				portraitBF1.visible = false;
				portraitGF3.visible = false;
				portraitGF.visible = false;
				portraitGF4.visible = false;
				portraitGF5.visible = false;
				portraitCR.visible = false;
				portraitCR1.visible = false;
				portraitCR2.visible = false;
				portraitCR3.visible = false;
				portraitCR4.visible = false;
				portraitCR5.visible = false;
				portraitCR6.visible = false;
				portraitCR7.visible = false;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('gfText'), 0.6)];
				if (!portraitGF1.visible)
				{
					portraitGF1.visible = true;
					portraitGF1.animation.play('enter');
				}
				case 'GF2':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitBF.visible = false;
				portraitBF1.visible = false;
				portraitGF1.visible = false;
				portraitGF3.visible = false;
				portraitGF.visible = false;
				portraitGF4.visible = false;
				portraitGF5.visible = false;
				portraitCR.visible = false;
				portraitCR1.visible = false;
				portraitCR2.visible = false;
				portraitCR3.visible = false;
				portraitCR4.visible = false;
				portraitCR5.visible = false;
				portraitCR6.visible = false;
				portraitCR7.visible = false;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('gfText'), 0.6)];
				if (!portraitGF2.visible)
				{
					portraitGF2.visible = true;
					portraitGF2.animation.play('enter');
				}
				case 'GF3':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitBF.visible = false;
				portraitBF1.visible = false;
				portraitGF1.visible = false;
				portraitGF2.visible = false;
				portraitGF.visible = false;
				portraitGF4.visible = false;
				portraitGF5.visible = false;
				portraitCR.visible = false;
				portraitCR1.visible = false;
				portraitCR2.visible = false;
				portraitCR3.visible = false;
				portraitCR4.visible = false;
				portraitCR5.visible = false;
				portraitCR6.visible = false;
				portraitCR7.visible = false;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('gfText'), 0.6)];
				if (!portraitGF3.visible)
				{
					portraitGF3.visible = true;
					portraitGF3.animation.play('enter');
				}
			case 'GF4':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitBF.visible = false;
				portraitBF1.visible = false;
				portraitGF1.visible = false;
				portraitGF2.visible = false;
				portraitGF.visible = false;
				portraitGF5.visible = false;
				portraitGF3.visible = false;
				portraitCR.visible = false;
				portraitCR1.visible = false;
				portraitCR2.visible = false;
				portraitCR3.visible = false;
				portraitCR4.visible = false;
				portraitCR5.visible = false;
				portraitCR6.visible = false;
				portraitCR7.visible = false;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('gfText'), 0.6)];
				if (!portraitGF4.visible)
				{
					portraitGF4.visible = true;
					portraitGF4.animation.play('enter');
				}
			case 'GF5':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitBF.visible = false;
				portraitBF1.visible = false;
				portraitGF1.visible = false;
				portraitGF2.visible = false;
				portraitGF.visible = false;
				portraitGF4.visible = false;
				portraitGF3.visible = false;
				portraitCR.visible = false;
				portraitCR1.visible = false;
				portraitCR2.visible = false;
				portraitCR3.visible = false;
				portraitCR4.visible = false;
				portraitCR5.visible = false;
				portraitCR6.visible = false;
				portraitCR7.visible = false;
				swagDialogue.sounds = [FlxG.sound.load(Paths.sound('gfText'), 0.6)];
				if (!portraitGF5.visible)
				{
					portraitGF5.visible = true;
					portraitGF5.animation.play('enter');
				}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		if(splitName[1].split("/").length > 1){
			splitBack = splitName[1].split("/")[1];
			curCharacter = splitName[1].split("/")[0];
		}
		else
			curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}

	function runEffectsQue(){
	
		for(i in 0...effectQue.length){

			switch(effectQue[i]){

				case "fadeOut":
					effectFadeOut(Std.parseFloat(effectParamQue[i]));
				case "fadeIn":
					effectFadeIn(Std.parseFloat(effectParamQue[i]));
				case "exitStageLeft":
					effectExitStageLeft(Std.parseFloat(effectParamQue[i]));
				case "exitStageRight":
					effectExitStageRight(Std.parseFloat(effectParamQue[i]));
				case "enterStageLeft":
					effectEnterStageLeft(Std.parseFloat(effectParamQue[i]));
				case "enterStageRight":
					effectEnterStageRight(Std.parseFloat(effectParamQue[i]));
				case "rightSide":
					effectFlipRight();
				case "flip":
					effectFlipDirection();
				case "toLeft":
					effectToLeft();
				case "toRight":
					effectToRight();
				case "lightningStrike":
					effectlightningStrike();
				case "beep":
					effectbeep();
				//case "shake":
					//effectShake(Std.parseFloat(effectParamQue[i]));
				default:

			}

		}

		effectQue = [""];
		effectParamQue = [""];

	}

	function effectFadeOut(?time:Float = 1):Void{
		for(i in 0...portraitArray().length){
		portraitArray()[i].effectFadeOut(time);
		}
	}

	function effectFadeIn(?time:Float = 1):Void{
		for(i in 0...portraitArray().length){
		portraitArray()[i].effectFadeIn(time);
		}
	}

	function effectExitStageLeft(?time:Float = 1):Void{
		for(i in 0...portraitArray().length){
			portraitArray()[i].effectExitStageLeft(time);
			}
	}

	function effectExitStageRight(?time:Float = 1):Void{
		for(i in 0...portraitArray().length){
			portraitArray()[i].effectExitStageRight(time);
			}
	}

	function effectFlipRight(){
		for(i in 0...portraitArray().length){
			portraitArray()[i].effectFlipRight();
			}
			box.flipX = false;
		
	}
	
	function effectFlipDirection(){
		for(i in 0...portraitArray().length){
			portraitArray()[i].effectFlipDirection();
			}
		
	}

	function effectEnterStageLeft(?time:Float = 1){
		for(i in 0...portraitArray().length){
			portraitArray()[i].effectEnterStageLeft(time);
			}
		
	}

	function effectEnterStageRight(?time:Float = 1){
		for(i in 0...portraitArray().length){
			portraitArray()[i].effectEnterStageRight(time);
			}
	
	}

	function effectToRight(?time:Float = 1){
		for(i in 0...portraitArray().length){
			portraitArray()[i].effectToRight(time);
			}
		
		box.flipX = false;
	}

	function effectToLeft(?time:Float = 1){
		for(i in 0...portraitArray().length){
			portraitArray()[i].effectToLeft(time);
			}
		
	}

	function effectlightningStrike(){
		FlxG.sound.play(Paths.soundRandom('thunder_', 1, 2));
	}
	function effectbeep(){
		FlxG.sound.play(Paths.soundRandom('Carbeep',1,1));
	}


	
}


