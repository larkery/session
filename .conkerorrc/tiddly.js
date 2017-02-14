function content_handler_autosave (ctx) {
    // find out the buffer's url
    if (ctx.buffer.document.location.href.startsWith("file:///home/hinton/.conkerorrc/home.html")) {
        var info = register_download(ctx.buffer, ctx.launcher.source);
        info.temporary_status = DOWNLOAD_TEMPORARY_FOR_ACTION;
        ctx.launcher.saveToDisk(make_file("~/.conkerorrc/home.html"), false);
    } else {
        yield content_handler_prompt (ctx);
    }
}

content_handlers.set("text/html",
                     content_handler_autosave);

// define_page_mode("tiddlywiki-mode",
//                  function(url) { return url.spec === 'file:///home/hinton/.conkerorrc/home.html'; }
//                  function enable (buffer) {

//                  },
//                  function disable (buffer) {

//                  },
//                  $display_name = "tw"
//                 );

// page_mode_activate(tiddlywiki-mode);
