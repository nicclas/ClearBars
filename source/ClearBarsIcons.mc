class ClearBarsIcons {

	var _dc;
	public var _themeColor;
	public var _bgColor;
	
	// Constructor
    function initialize(dc) {
        _dc = dc;
    }



	function renderSymbol(x,y,fieldType) {
		var polygon = null;
		_dc.setColor(_themeColor, _bgColor);
			
		switch ( fieldType ) {
			case 0: //steps
			var scale = 0.8;
			_dc.setColor(_themeColor, _bgColor);
			polygon = [[0, 14],[-1,17],[0,19],[3,20],[4,18],[5,15],[0,14]];
			for(var i = 0; i < polygon.size(); i++){
				polygon[i] = [scale * polygon[i][0], scale * polygon[i][1]];
			}
			polygon =	PolyTranslate(polygon,x,y);	
			_dc.fillPolygon(polygon);
			polygon = [[1, 11],[5,12],[7,8],[7,4],[5,1],[3,1],[0,6],[1,9],[1,11]];
			for(var i = 0; i < polygon.size(); i++){
				polygon[i] = [scale * polygon[i][0], scale * polygon[i][1]];
			}
			polygon =	PolyTranslate(polygon,x,y);	
			_dc.fillPolygon(polygon);
			break;	
			case 1: //Battery
			polygon = [[8,-3],[8,-13],[6,-13],[6,-15],[2,-15],[2,-13],[0,-13],[0,-3],[8,-3]];
			polygon =	PolyTranslate(polygon,x,y);	
			_dc.setColor(_themeColor, _bgColor);
			_dc.fillPolygon(polygon);
			var stats = System.getSystemStats();
			var pwrprop = (stats.battery + 0.5)/100;
			polygon = [[6,-5-6*pwrprop],[6,-11],[2,-11],[2,-5-6*pwrprop],[6,-5-6*pwrprop]];
			polygon =	PolyTranslate(polygon,x,y);	
			_dc.setColor(Graphics.COLOR_BLACK, _bgColor);
			_dc.fillPolygon(polygon);
			break;	
			case 2: //HeartRate
			polygon = [[6,-3],[12,-8], [12,-12],[10,-15],[9,-15],[6,-12],[3,-15],[2,-15],[0,-12],[0,-8],[6,-3]];
			polygon =	PolyTranslate(polygon,x,y);	
			_dc.setColor(_themeColor, _bgColor);
			_dc.fillPolygon(polygon);
			break;	
		}
	}
	
	function PolyTranslate(Polygon,Tx,Ty) {
		if(Polygon !=null) {
			for( var j = 0; j < Polygon.size(); j++ ) {
		    	Polygon[j] =  [Polygon[j][0]+Tx,Polygon[j][1]+Ty];
			}
		}
		return Polygon;	
	}
		
	
}	