Magnet
======

Position Helper for Corona SDK Graphics 2.0

A module to position display objects on different screen resolutions. This helper will only work with the newest version of Corona (aka 2.0). Anchors and screen orientations are internally managed to provide consistency.

Positioning
===========

To position you just call the function and pass the displayObject
```lua
magnet:topLeft( displayObject )
```

Margins
=======

If you need to have a margin of 10px from the left this is how you do it:
```lua
magnet:topLeft( displayObject, 10 )
```
or same as before but with 20 px from the top:

```lua
magnet:topLeft( displayObject, 10, 20)
```

=======
```lua
magnet:top(obj, marginY, parent)
```

If you want to reposition after a screen rotation all you need to do is call the following function on the orientation event:
```lua
magnet:updateCurrentOrientation()
```

