external_content_handlers.set("*", "xdg-open");
external_content_handlers =
    {
        "*": "xdg-open",
        "text" : {"*": getenv("EDITOR")}
    };
