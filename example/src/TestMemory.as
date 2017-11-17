/**
 *        __       __               __ 
 *   ____/ /_ ____/ /______ _ ___  / /_
 *  / __  / / ___/ __/ ___/ / __ `/ __/
 * / /_/ / (__  ) / / /  / / /_/ / / 
 * \__,_/_/____/_/ /_/  /_/\__, /_/ 
 *                           / / 
 *                           \/ 
 * http://distriqt.com
 *
 * This is a test application for the distriqt Memory Native Extension
 * 
 * @author Michael Archbold 
 * 	
 */
package
{
	import com.distriqt.extension.memory.Memory;
	import com.distriqt.extension.memory.MemoryInfo;
	import com.distriqt.extension.memory.events.MemoryEvent;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	
	public class TestMemory extends Sprite
	{
		
		//
		//	VARIABLES
		//
		
		private var _text		: TextField;
		
		
		//
		//	FUNCTIONALITY
		//
		
		
		public function TestMemory()
		{
			super();
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			_text = new TextField();
			_text.y = 40;
			_text.defaultTextFormat = new TextFormat( "_typewriter", 18 );
			addChild( _text );
			
			stage.addEventListener( Event.RESIZE, stage_resizeHandler, false, 0, true );
			stage.addEventListener( MouseEvent.CLICK, mouseClickHandler, false, 0, true );
			
			
			try
			{
				message( "Memory Supported: " + Memory.isSupported );
				if (Memory.isSupported)
				{
					message( "Memory Version:   " + Memory.service.version );

					Memory.service.addEventListener( MemoryEvent.LOW_MEMORY_WARNING, lowMemoryWarningHandler );
				}
			}
			catch (e:Error)
			{
				message( "ERROR::"+e.message );
			}
		}
		
		
		private function message( str:String ):void
		{
			trace( str );
			_text.appendText(str+"\n");
		}
		
		
		//
		//	EVENT HANDLERS
		//
		
		private function stage_resizeHandler( event:Event ):void
		{
			_text.width  = stage.stageWidth;
			_text.height = stage.stageHeight - 100;
		}
		
		
		private function mouseClickHandler( event:MouseEvent ):void
		{
			var info:MemoryInfo = Memory.service.getMemoryInfo();
			
			message( "available memory = " + info.availableMemory );
			message( "total memory     = " + info.totalMemory );
		
		}
		
		
		//
		//	EXTENSION HANDLERS
		//
		
		private function lowMemoryWarningHandler( event:MemoryEvent ):void
		{
			message( "low memory warning" );
		}

		
	}
}

