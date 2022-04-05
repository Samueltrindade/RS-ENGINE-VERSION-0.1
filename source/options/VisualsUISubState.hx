package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;

using StringTools;

class VisualsUISubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Visuals and UI';
		rpcTitle = 'Visuals & UI Settings Menu'; //for Discord Rich Presence

		var option:Option = new Option('Note Splashes',
			"Se nao marcado, acertando e ganhando \"Sick!\" nao vai mostrar particulas.",
			'noteSplashes',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('esconder HUD',
			'se marcado, esconde o HUD.',
			'esconder HUD',
			'bool',
			false);
		addOption(option);
		
		var option:Option = new Option('Tipo de relogin:',
			"Qual tipo de relogio vc quer?",
			'tipo de relogin',
			'string',
			'Tempo faltando',
			['Tempo faltando', 'Tempo que passou', 'Nome da musica', 'Disativado']);
		addOption(option);

		var option:Option = new Option('Luz piscante',
			"DESLIGA SE TIVER EPILEPSIA!",
			'Luz piscante',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Zoom na camera',
			"Se desligado, nao vai dar zoom.",
			'Zoom na camera',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Zoom no texto no ritimo',
			"Se desligado, desliga o texto dando zoom quando acertar uma nota.",
			'Zoom no texto no ritimo',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Transparencia da barra de vida',
			'Auto explicativo certo?.',
			'Transparencia da barra de vida',
			'percent',
			1);
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		addOption(option);
		
		var option:Option = new Option('Contador de FPS',
			'Pra que explicar?.',
			'Contador de FPS',
			'bool',
			#if android false #else true #end);
		addOption(option);
		option.onChange = onChangeFPSCounter;
		
		var option:Option = new Option('Som de pause:',
			"Qual som vc quer tocando no menu pause?",
			'Som de pause',
			'string',
			'Tea Time',
			['Nenhum', 'Breakfast', 'Tea Time','Breakfast-remix','uwa']);
		addOption(option);
		option.onChange = onChangePauseMusic;

		super();
	}

	var changedMusic:Bool = false;
	function onChangePauseMusic()
	{
		if(ClientPrefs.pauseMusic == 'None')
			FlxG.sound.music.volume = 0;
		else
			FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.pauseMusic)));

		changedMusic = true;
	}

	override function destroy()
	{
		if(changedMusic) FlxG.sound.playMusic(Paths.music('freakyMenu'));
		super.destroy();
	}

	function onChangeFPSCounter()
	{
		if(Main.fpsVar != null)
			Main.fpsVar.visible = ClientPrefs.showFPS;
	}
}
