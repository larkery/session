var dark_stylesheet = make_css_data_uri(
    ['* { background: #3f3f3f !important; color: #d5d2be !important; }'
     , ':link, :link * { color: #aaccff !important; }'
     , ':visited, :visited * { color: #d75047 !important; }'] );

var dark_enabled = false;

function toggle_dark_mode (I) {
    if (dark_enabled = !dark_enabled) {
        register_user_stylesheet(dark_stylesheet);
    } else {
        unregister_user_stylesheet(dark_stylesheet);
    }
}

interactive("toggle-dark-mode", "Darken the page, or undarken it", toggle_dark_mode);
define_key(content_buffer_normal_keymap, "C-d", "toggle-dark-mode");
