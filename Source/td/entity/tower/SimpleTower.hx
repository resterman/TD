package td.entity.tower;

import openfl.display.Shape;
import openfl.utils.Timer;
import openfl.events.TimerEvent;

import td.entity.enemy.Enemy;
import td.util.*;

class SimpleTower extends Tower
{

    public static inline var BASE_DAMAGE : Float = 10;

    public static inline var BASE_SPEED : Float = 0.5;

    public static inline var BASE_RATE_OF_FIRE : Float = 50;

    public static inline var BASE_RANGE : Float = 100;

    private var timer : Timer;

    private var lasers : Array<Shape>;

    public function new (level : Int, kills : Int)
    {
        super ();

        this.damage = SimpleTower.BASE_DAMAGE + level * 0.2;
        this.speed = SimpleTower.BASE_SPEED + level * 0.1;
        this.range = SimpleTower.BASE_RANGE + level * 10;
        this.rateOfFire = SimpleTower.BASE_RATE_OF_FIRE - level;
        this.kills = kills;
        this.level = level;
        this.lasers = new Array<Shape> ();

        this.timer = new Timer (this.rateOfFire);
        this.timer.addEventListener (TimerEvent.TIMER, shoot);
        this.timer.start ();
    }

    override public function draw () : Void
    {
        super.draw ();

        this.graphics.beginFill (0x000000);
        this.graphics.drawCircle (0, 0, Tower.WIDTH / 2 - 1);
    }

    public function shoot (e : TimerEvent) : Void
    {
        var enemies = this.gameStage.getEnemies ();

        var target : Enemy = null;
        var minDist = this.range;
        for (enemy in enemies)
        {
            var d = sqrDistanceTo (enemy);

            if (d <= minDist * minDist)
            {
                target = enemy;
                minDist = Math.sqrt (d);
            }
        }

        if (target != null) {
            drawLaser (target);
            inflictDamage (target);
        }
    }

    override public function move () : Void
    {
        super.move ();

        for (l in lasers)
        {
            if (l.alpha <= 0) {
                this.gameStage.removeChild (l);
                this.lasers.remove (l);
            }

            l.alpha -= 0.01;
        }
    }

    private function drawLaser (enemy : Enemy) : Void
    {
        var laser = new Shape ();

        laser.graphics.lineStyle (1, 0xFF0000);
        laser.graphics.moveTo (this.x, this.y);
        laser.graphics.lineTo (enemy.x, enemy.y);

        this.gameStage.addChild (laser);
        this.lasers.push (laser);
        trace ("laser added");
    }


    private function sqrDistanceTo (enemy : Enemy) : Float
    {
        var xdif = enemy.x - this.x;
        var ydif = enemy.y - this.y;

        return xdif * xdif + ydif * ydif;
    }

}
