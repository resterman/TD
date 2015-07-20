package td.view.components;

import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.text.TextFormatAlign;

class GamePanel extends Sprite
{

    private static inline var PANEL_WIDTH : Int = 600;

    private static inline var PANEL_HEIGHT : Int = 600;

    private var level : GameTextField;

    private var score : GameTextField;

    public function new ()
    {
        super ();

        this.mouseChildren = false;
        this.mouseEnabled = false;

        var txt = new GameTextField ();
        txt.setAlignment (TextFormatAlign.LEFT);
        txt.setFontSize (20);
        txt.x = txt.y = 5;
        txt.width = GamePanel.PANEL_WIDTH - 10;
        txt.textColor = 0xFFFFFF;
        txt.text = "Level 0";

        score = new GameTextField ();
        score.setAlignment (TextFormatAlign.RIGHT);
        score.setFontSize (20);
        score.x = score.y = 5;
        score.width = GamePanel.PANEL_WIDTH - 10;
        score.textColor = 0xFFFFFF;

        addChild (txt);
        addChild (score);
    }

    public function updateScore (score : Int) : Void
    {
        this.score.text =  "Score: " + Std.string (score);
    }


}
