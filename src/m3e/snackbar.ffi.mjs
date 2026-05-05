// open_snackbar()
export function open_snackbar(message, action, dismissible, options) {
  const jsOptions = {
    duration: options.duration,
    closeLabel: options.close_label,
  };

  if (options.callback) {
    jsOptions.actionCallback = options.callback;
  }

  M3eSnackbar.open(message, action, dismissible, jsOptions);
}
