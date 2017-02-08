package com.skatilsya.math 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author me
	 */
	public class Trigonometry 
	{
		static public const RAD_VAL: Number = 180 / Math.PI;
		
		static public const DEG_VAL: Number = Math.PI / 180;
		
		static public function degreesToRadians(angle: Number) : Number
		{
			return angle * DEG_VAL;
		}
		
		static public function radiansToDegrees(radians: Number) : Number
		{
			return radians * RAD_VAL;
		}
		
		/**
		 * Calculates distance between two points using 4 variables
		 * tip: if performance is necessary, it's better to calc distance manually. It is faster to 
		 * multiply manually instead of usimg Math.pow (method calls cost a bit of cpu in any way)
		 * @param	x1
		 * @param	x2
		 * @param	y1
		 * @param	y2
		 * @return the distance between two points
		 */
		static public function distance(x1: Number, x2: Number, y1: Number, y2: Number) : Number
		{
			return Math.sqrt( (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
		}
		
		/**
		 * Calculates distance between 2 flash.geom.Point objects
		 * @param	obj1
		 * @param	obj2
		 * @return surprisingly, distance between two points
		 */
		static public function distanceBetweenPoints(obj1: Point, obj2: Point) : Number
		{
			return Math.sqrt((obj1.x - obj2.x) * (obj1.y - obj2.y) + (obj1.y - obj2.y) * (obj1.y - obj2.y));
		}
		
		/**
		 * Defines an angle between axis OX and a line segment (OX, destinationPoint)
		 * @param	oxPoint
		 * @param	destinationPoint
		 * @return angle between axis OX and a line segment (OX, point) in radians
		 */
		static public function angleBetweenOXandPoint(oxPoint: Point, destinationPoint: Point) : Number
		{
			return Math.atan2(destinationPoint.y - oxPoint.y, destinationPoint.x - oxPoint.x) * RAD_VAL;
		}
		
		/**
		 * Simply checks and returns value if your point is in bounds of circle. 
		 * @param	point
		 * @param	circlePosition - position of the circle center, not the top-left corner of square containing it
		 * @param	circleRadius
		 * @param	includeBorder - if set to true, it will check if point position is right on the border of circle and returns true
		 * otherwise it returns false. 
		 * @return
		 */
		static public function pointIsInCircle(point: Point, circlePosition: Point, circleRadius: Number, 
			includeBorder: Boolean = true) : Boolean
		{
			var dist: Number = distanceBetweenPoints(point, circlePosition);
			if (dist > circleRadius) return false;
			if (!includeBorder && dist == circleRadius) return false;
			return true;
		
		}
		
		/**
		 * Checks and returns boolean value if two circles intersecting each other
		 * 
		 * @param	circle1Pos - center of circle 1
		 * @param	circle1Radius - radius of circle 1
		 * @param	circl2Pos - center of circle 2
		 * @param	circle2Radius - radius of circle 2
		 * @param	includeBorder - if circle is touching another circle and you think it is not intersecting - select false
		 * @return 
		 */
		static public function circlesAreIntersecting(circle1Pos: Point, circle1Radius: Number, circl2Pos: Point, circle2Radius: Number, 
			includeBorder: Boolean = true) : Boolean
		{
			var dist: Number = distanceBetweenPoints(circle1Pos, circl2Pos);
			if (dist > circle1Radius + circle2Radius || (dist == circle1Radius && includeBorder == false)) return false;
			
			return true;
		}
		
	}

}