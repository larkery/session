var theme_fix_stylesheet = make_css_data_uri(
    [
        "@-moz-document url-prefix(about:blank) {*{background-color:#202020;}}",
        "/*",
        "* Use this css file to eliminate problems in Firefox",
        "* when using dark themes that create dark on dark",
        "* input boxes, selection menus and buttons. Put this",
        "* in the ../firefox/default/chrome folder or your",
        "* individual user firefox profile chrome folder.",
        "*/",
        "input {",
        "border: 2px inset white;",
        "background-color: white;",
        "color: black;",
        "-moz-appearance: none !important;",
        "}",
        "textarea {",
        "border: 2px inset white;",
        "background-color: white;",
        "color: black;",
        "-moz-appearance: none !important;",
        "}",
        "select {",
        "border: 2px inset white;",
        "background-color: white;",
        "color: black;",
        "-moz-appearance: none !important;",
        "}",
        "input[type=radio],",
        "input[type=checkbox] {",
        "border: 2px inset white ! important;",
        "background-color: white ! important;",
        "color: ThreeDFace ! important;",
        "-moz-appearance: none !important;",
        "}",
        "*|*::-moz-radio {",
        "background-color: white;",
        "-moz-appearance: none !important;",
        "}",
        "button,",
        "input[type=reset],",
        "input[type=button],",
        "input[type=submit] {",
        "border: 2px outset white;",
        "background-color: #eeeeee;",
        "color: black;",
        "-moz-appearance: none !important;",
        "}",
        "body {",
        "background-color: white;",
        "color: black;",
        "display: block;",
        "margin: 8px;",
        "-moz-appearance: none !important;",
        "}"
    ]
);



register_user_stylesheet(theme_fix_stylesheet);

var dark_stylesheet = get_home_directory();
dark_stylesheet.append(".conkerorrc");
dark_stylesheet.append("zenburn.css");
dark_stylesheet = make_uri(dark_stylesheet);

var dark_enabled = false;

function toggle_dark_mode (I) {
    if (dark_enabled = !dark_enabled) {
        unregister_user_stylesheet(theme_fix_stylesheet);
        register_user_stylesheet(dark_stylesheet);
    } else {
        unregister_user_stylesheet(dark_stylesheet);
        register_user_stylesheet(theme_fix_stylesheet);
    }
}

interactive("toggle-dark-mode", "Darken the page, or undarken it", toggle_dark_mode);
define_key(content_buffer_normal_keymap, "C-d", "toggle-dark-mode");
toggle_dark_mode();
