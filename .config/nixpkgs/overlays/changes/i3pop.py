#!/usr/bin/env python

import i3ipc
i3 = i3ipc.Connection()
f = i3.get_tree().find_focused()
c = f
while len(c.parent.nodes) == 1 and c.parent.type == 'con':
    c = c.parent
c = c.parent

if f != c and c.type == 'con':
    c.command('mark _sp')
    f.command('move window to mark _sp')
