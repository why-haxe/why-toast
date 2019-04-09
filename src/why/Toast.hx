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
	
	public function success(message:String, duration = Long) {
		this.show({
			title: message,
			type: Success,
			duration: duration,
		});
	}
	
	public function outcome<T>(outcome:Outcome<T, Error>, successMessage:String, duration = Long, ?opt:{?includeDetails:Bool}) {
		switch outcome {
			case Success(_): success(successMessage, duration);
			case Failure(e): error(e, duration, opt);
		}
	}
	
	public function error(e:Error, duration = Long, ?opt:{?includeDetails:Bool}) {
		this.show({
			title: e.message + (opt == null || !opt.includeDetails || e.data == null ? '' : ' ' + Std.string(e.data)),
			type: Error,
			duration: duration,
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
	?duration:Duration,
}

enum Duration {
	Short;
	Long;
	Custom(ms:Int);
	Indefinite;
}

enum ToastType {
	Success;
	Warning;
	Info;
	Error;
}