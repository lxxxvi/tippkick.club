const moveCursorToEnd = (element) => {
  element.focus();
  if (typeof element.selectionStart == "number") {
      element.selectionStart = element.selectionEnd = element.value.length;
  } else if (typeof element.createTextRange != "undefined") {
      var range = element.createTextRange();
      range.collapse(false);
      range.select();
  }
}

export { moveCursorToEnd };
