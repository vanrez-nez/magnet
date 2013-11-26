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

If you want to reposition after a screen rotation all you need to do is call the following function on the orientation event:
```lua
magnet:updateCurrentOrientation()
```

SUPPORTED METHODS:
Basic Align
=======
```lua
magnet:top(obj, marginY)
magnet:right(obj, marginX)
magnet:bottom(obj, marginY)
magnet:left(obj, marginX)
magnet:center(obj, marginX, marginY)
```
Composed Aligns
=====
```lua
magnet:topLeft(obj, marginX, marginY)
magnet:topRight(obj, marginX, marginY)
magnet:bottomLeft(obj, marginX, marginY)
magnet:bottomRight(obj, marginX, marginY)
magnet:topCenter(obj, marginX, marginY)
magnet:centerRight(obj, marginX, marginY)
magnet:bottomCenter(obj, marginX, marginY)
magnet:centerLeft(obj, marginX, marginY, parent)
```

Composed Aligns
=====
Or a generic call with the align as a parameter:
```lua
magnet:alignTo(sAlign, obj, ...)
```
where sAlign is the method name in a string like: 
```lua
magnet("bottomRight", myObject, xMargin, yMargin)
```

Other utilities
======
```lua
magnet:getPercentX( percent )
magnet:getPercentY( percent )
```

