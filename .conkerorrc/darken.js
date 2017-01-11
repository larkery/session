function darken_page (I) {
    var styles='* { background: #3f3f3f !important; color: #d5d2be !important; }'+
        ':link, :link * { color: #aaccff !important; }'+
        ':visited, :visited * { color: #d75047 !important; }';
    var document = I.buffer.document;
    var newSS=document.createElement('link');
    newSS.rel='stylesheet';
    newSS.href='data:text/css,'+escape(styles);
    document.getElementsByTagName("head")[0].appendChild(newSS);
}

interactive("darken-page", "Darken the page in an attempt to save your eyes.",
            darken_page);

define_key(content_buffer_normal_keymap, "C-d", "darken-page");
