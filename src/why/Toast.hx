package why;

using tink.CoreApi;

@:forward
abstract Toast(ToastObject) from ToastObject {
	/**
	 * A helper field to allow simple access to the same Toast instance across the application.
	 * Not a must to use.
	 */
	public static var instance:Toast;
	
	// shorthand
	public static var inst(get, set):Toast;
	static inline function get_inst() return instance;
	static inline function set_inst(v) return instance = v;
	
	public function success(message:String, timeout = 5000) {
		this.show({
			title: message,
			type: Success,
			timeout: timeout,
		});
	}
	
	public function outcome<T>(outcome:Outcome<T, Error>, successMessage:String, timeout = 5000) {
		switch outcome {
			case Success(_): success(successMessage, timeout);
			case Failure(e): error(e, timeout);
		}
	}
	
	public function error(e:Error, timeout = 5000) {
		this.show({
			title: e.message,
			type: Error,
			timeout: timeout,
		});
	}
}

interface ToastObject {
	function show(options:ToastOptions):Void;
}

typedef ToastOptions = {
	title:String,
	?details:String,
	?type:ToastType,
	?timeout:Int, // ms
}

enum ToastType {
	Success;
	Warning;
	Info;
	Error;
}