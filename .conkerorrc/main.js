let home = get_home_directory();
home.append(".conkerorrc");
home.append("home.html");
homepage = home.path;

editor_shell_command = "emacsclient -c";

// browser_default_open_target = OPEN_NEW_WINDOW; - breaks stuff

require("clicks-in-new-buffer.js");

cwd = get_home_directory();
cwd.append("temp");
cwd.append("dl");

url_completion_use_history = true;

mode_line_mode(true);

add_hook("mode_line_hook", mode_line_adder(buffer_count_widget), true);

function possibly_valid_url (str) {
    return /^\s*[^\/\s]*(\/|\s*$)/.test(str)
        && /[:\/\.]/.test(str);
}

read_url_handler_list = [read_url_make_default_webjump_handler("duckduckgo")];

set_protocol_handler("mailto", find_file_in_path("xdg-open"));

interactive("open-selection",
            "Open selected URL, or search with default thingy",
            "find-url",
            $browser_object =
            function (I) {
                var sel = I.buffer.top_frame.getSelection();
                if (possibly_valid_url(sel)) {
                    return ""+sel;
                } else {
                    return "duckduckgo "+sel;
                }
            });

define_key(content_buffer_normal_keymap, "w", "open-selection");

var minibuffer_autohide_message_timeout = 3000;
var minibuffer_autohide_timer = null;
var minibuffer_mutually_exclusive_with_mode_line = true;

var old_minibuffer_restore_state = (old_minibuffer_restore_state ||
                                    minibuffer.prototype._restore_state);
var old_minibuffer_show = (old_minibuffer_show ||
                           minibuffer.prototype.show);
var old_minibuffer_clear = (old_minibuffer_clear ||
                            minibuffer.prototype.clear);

var show_minibuffer = function (window) {
    window.minibuffer.element.collapsed = false;
    if (minibuffer_mutually_exclusive_with_mode_line && window.mode_line)
        window.mode_line.container.collapsed = true;
};

var hide_minibuffer = function (window) {
    window.minibuffer.element.collapsed = true;
    if (minibuffer_mutually_exclusive_with_mode_line && window.mode_line)
        window.mode_line.container.collapsed = false;
};

minibuffer.prototype._restore_state = function () {
    if (minibuffer_autohide_timer) {
        timer_cancel(minibuffer_autohide_timer);
        minibuffer_autohide_timer = null;
    }
    if (this.current_state)
        this.show();
    else
        hide_minibuffer(this.window);
    old_minibuffer_restore_state.call(this);
};

minibuffer.prototype.hide = function () {
    hide_minibuffer(this.window);
};

minibuffer.prototype.show = function (str, force, hide_after_timeout) {
    var w = this.window;
    var self = this;
    show_minibuffer(this.window);
    old_minibuffer_show.call(this, str, force);
    if (minibuffer_autohide_timer)
        timer_cancel(minibuffer_autohide_timer);
    hide_after_timeout = hide_after_timeout ||
        (hide_after_timeout == null && this.input_element.value == '');

    if (hide_after_timeout || hide_after_timeout == null) {
        minibuffer_autohide_timer = call_after_timeout(
            function (I) {self.hide();}, minibuffer_autohide_message_timeout);
    }
};

minibuffer.prototype.clear = function () {
    if (minibuffer_autohide_timer) {
        timer_cancel(minibuffer_autohide_timer);
        minibuffer_autohide_timer = null;
    }
    if (!this.current_state)
        this.hide();
    old_minibuffer_clear.call(this);
};

add_hook("window_initialize_hook", function (I) {I.window.minibuffer.hide();});
define_key(content_buffer_normal_keymap,"C-g","unfocus");
