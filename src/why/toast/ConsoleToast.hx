package why.toast;

import js.Browser.console;
import why.Toast;

class ConsoleToast implements ToastObject {
	
	public function new() {}
	
	public function show(options:ToastOptions) {
		final content = options.title + (options.details == null ? '' : '<br>${options.details}');
		switch options.type {
			case Success: console.log(content);
			case Warning: console.warn(content);
			case Info: console.info(content);
			case Error: console.error(content);
		}
	}
}