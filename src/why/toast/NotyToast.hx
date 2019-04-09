package why.toast;

#if (!hxjs_noty)
	#error 'NotyToast requires `-lib hxjs-noty`'
#end

import why.Toast;
import noty.Noty;

/**
 * <link rel="stylesheet" type="text/css" href="https://unpkg.com/noty@3.1.4/lib/noty.css">
 * <script src="https://unpkg.com/noty@3.1.4/lib/noty.min.js"></script>
 */
class NotyToast implements ToastObject {
	
	var defaults:Options;
	
	public function new(?defaults) {
		this.defaults = defaults == null ? {} : defaults;
	}
	
	public function show(options:ToastOptions) {
		var opt:Options = js.Object.assign({}, defaults);
		opt.text = options.title + (options.details == null ? '' : '<br>${options.details}');
		opt.timeout = switch options.duration {
			case null: 1500;
			case Short: 1500;
			case Long: 3500;
			case Indefinite: null;
			case Custom(ms): ms;
		}
		opt.type = switch options.type {
			case Success: Success;
			case Warning: Warning;
			case Info: Info;
			case Error: Error;
		}
		
		new Noty(opt).show();
	}
}