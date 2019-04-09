package why.toast;

import why.Toast;

class ReactNativeSnackbar implements ToastObject {
	
	
	
	public function new(?options) {
		if(options != null && options.getBackgroundColor != null) getBackgroundColor = options.getBackgroundColor;
		if(options != null && options.getColor != null) getColor = options.getColor;
	}
	
	public function show(options:ToastOptions) {
		Snackbar.show({
			title: options.title,
			duration: switch options.duration {
				case Short: Snackbar.LENGTH_SHORT;
				case Long: Snackbar.LENGTH_LONG;
				case Indefinite: Snackbar.LENGTH_INDEFINITE;
				case Custom(_): null;
			},
			backgroundColor: getBackgroundColor(options.type),
			color: getColor(options.type),
		});
	}
	
	dynamic function getBackgroundColor(type:ToastType) {
		return switch type {
			case Warning: '#eea863';
			case Success: '#70c976';
			case Error: '#e85f5a';
			case Info: '#6d9bb2';
		}
	}
	
	dynamic function getColor(type:ToastType) {
		return 'white';
	}
}

@:jsRequire('react-native-snackbar', 'default')
private extern class Snackbar {
	static var LENGTH_SHORT:Dynamic;
	static var LENGTH_LONG:Dynamic;
	static var LENGTH_INDEFINITE:Dynamic;
	static function show(opt:{}):Void;
}