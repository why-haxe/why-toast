package why.toast;

import react.Empty;
import react.ReactComponent;
import react.ReactMacro.jsx;
import mui.core.Snackbar;
import mui.core.common.Position;
import why.Toast;

typedef MaterialUiSnackbarProps = {
	?anchorOrigin:Position,
	renderChildren:ToastOptions->ReactFragment,
}
typedef MaterialUiSnackbarState = {
	?open:Bool,
	?duration:Int,
	?options:ToastOptions
}

class MaterialUiSnackbar extends ReactComponentOfPropsAndState<MaterialUiSnackbarProps, MaterialUiSnackbarState> implements ToastObject {
	public function new(props) {
		super(props);
		state = {}
	}
	
	public function show(options:ToastOptions) {
		setState({
			open: true,
			options: options,
			duration: switch options.duration {
				case Short: 2000;
				case Long: 5000;
				case Indefinite: null;
				case Custom(v): v;
			},
		});
	}
	
	override function render() {
		return
			if(state.options == null) {
				null;
			} else {
				var children = props.renderChildren(state.options);
				var isString = Std.is(children, String);
				jsx('
					<Snackbar
						open=${state.open}
						autoHideDuration=${state.duration}
						onClose=${onClose}
						message=${isString ? children : null}
						anchorOrigin=${props.anchorOrigin}
					>
						${isString ? null : children}
					</Snackbar>
				');
			}
	}
	
	function onClose(event, reason) {
		if(reason == 'clickaway') return;
		setState({open: false});
	}
}