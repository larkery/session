#!/usr/bin/env python

import i3ipc
i3 = i3ipc.Connection()
f = i3.get_tree().find_focused()
c = f
while len(c.parent.nodes) == 1:
    c = c.parent
c = c.parent
c.command('mark _sp')
f.command('move window to mark _sp')
