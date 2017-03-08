define_browser_object_class(
    "history-url", null,
    function (I, prompt) {
        check_buffer (I.buffer, content_buffer);
        var result = yield I.buffer.window.minibuffer.read_url(
            $prompt = prompt,  $use_webjumps = false, $use_history = true, $use_bookmarks = false);
        yield co_return (result);
    });

define_browser_object_class(
    "bookmark-url", null,
    function (I, prompt) {
        check_buffer (I.buffer, content_buffer);
        var result = yield I.buffer.window.minibuffer.read_url(
            $prompt = prompt,  $use_webjumps = false, $use_history = false, $use_bookmarks = true);
        yield co_return (result);
    });

interactive("find-url-from-history",
            "Find a page from history in the current buffer",
            "find-url",
            $browser_object = browser_object_history_url);

interactive("find-url-from-history-new-buffer",
            "Find a page from history in the current buffer",
            "find-url-new-buffer",
            $browser_object = browser_object_history_url);

define_key(content_buffer_normal_keymap, "h", "find-url-from-history-new-buffer");
define_key(content_buffer_normal_keymap, "H", "find-url-from-history");

interactive("find-bookmark",
            "Find a bookmark in the current buffer",
            "find-url",
            $browser_object = browser_object_bookmark_url);

define_key(content_buffer_normal_keymap, "M-b", "find-bookmark");

function history_clear () {
    var history = Cc["@mozilla.org/browser/nav-history-service;1"]
        .getService(Ci.nsIBrowserHistory);
    history.removeAllPages();
}

interactive("history-clear",
            "Clear the history.",
            history_clear);

function history_clear_host (host) {
    var history = Cc["@mozilla.org/browser/nav-history-service;1"]
        .getService(Ci.nsIBrowserHistory);
    history.removePagesFromHost(host, true);
}

interactive("history-clear-host",
            "Remove a specific site from the history",
            function(I) {
                history_clear_host(yield I.minibuffer.read($prompt = "host: "));
            });
