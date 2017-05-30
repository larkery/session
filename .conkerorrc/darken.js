var dark_stylesheet = get_home_directory();
dark_stylesheet.append(".conkerorrc");
dark_stylesheet.append("zenburn.css");
dark_stylesheet = make_uri(dark_stylesheet);

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
