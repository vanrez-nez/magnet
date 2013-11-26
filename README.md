magnet
======

Position Helper for Corona SDK Graphics 2.0

A module to position display objects on different screen resolutions. This helper will only work with the newest version of Corona (aka 2.0). Anchors and screen orientations are internally managed to provide consistency.

positioning
===========

To position you just call the function and pass the displayObject
```lua
magnet:topLeft( displayObject )
```

margins
=======

If you need to have a margin of 10px from the left this is how you do it:
```lua
magnet:topLeft( displayObject, 10 )
```


=======
```lua
magnet:top(obj, marginY, parent)
```

If you want to reposition after a screen rotation all you need to do is call magnet:updateCurrentOrientation() on the orientation event and reposition your objects
