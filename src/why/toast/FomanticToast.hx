package why.toast;

import why.Toast;

class FomanticToast implements ToastObject {
	
	var defaultOptions:Options;
	
	public function new(?opt) {
		defaultOptions = opt == null ? {} : opt;
		if(opt.getClassName != null) getClassName = opt.getClassName;
	}
	
	public function show(options:ToastOptions) {
		var ctx:{toast:{}->Void} = js.Syntax.code('$("body")');
		ctx.toast({
			title: options.title,
			message: options.details,
			position: defaultOptions.position,
			'class': getClassName(options.type == null ? Info : options.type),
			displayTime:
				switch options.duration {
					case null: 5000;
					case Short: 2500;
					case Long: 5000;
					case Custom(ms): ms;
					case Indefinite: 0;
				}
		});
	}
	dynamic function getClassName(type:ToastType) {
		return switch type {
			case Success: 'success';
			case Error: 'error';
			case Warning: 'warning';
			case Info: 'info';
		}
	}
}

private typedef Options = {
	?position:String,
	?getClassName:ToastType->String,
}