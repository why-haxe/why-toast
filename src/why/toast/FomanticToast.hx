package why.toast;

import why.Toast;

class FomanticToast implements ToastObject {
	
	public function new() {}
	
	public function show(options:ToastOptions) {
		js.Syntax.code('$("body")').toast({
			title: options.title,
			message: options.details,
			'class':
				switch options.type {
					case null: null;
					case Success: 'success';
					case Error: 'error';
					case Warning: 'warning';
					case Info: null;
				},
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
}