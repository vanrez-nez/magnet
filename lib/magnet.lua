-- Magnet, Position Helper for Corona SDK G2.0
--
-- Author: Iván Juárez Núñez 2013
-- License: MIT 
-- Version: 2.0

local composer = require "composer"
local magnet = {}

local width, height, originX, originY
local abs = math.abs

function magnet:updateCurrentOrientation()
	width 	= display.actualContentWidth
	height 	= display.actualContentHeight
	originX = display.screenOriginX
	originY = display.screenOriginY
end

-- exposed attr
magnet.screenWidth 	= width
magnet.screenHeight = height

function isRelativeToParent( obj )
	local currentView = composer.getScene(composer.getSceneName( "current" )).view
	local currentStage = display.getCurrentStage()
	return obj.parent ~= nil and not (obj.parent == currentStage or obj.parent == currentView)
end

-- POSITIONING
function magnet:top(obj, marginY, parent)
	if parent or isRelativeToParent(obj) then
		obj.y = - (parent and parent.height or obj.parent.height) * 0.5
	else
		obj.y = originY
	end
	obj.y = obj.y + (marginY or 1) + obj.anchorY * obj.height
end
magnet["top"] = magnet.top

function magnet:right(obj, marginX, parent)
	if parent or isRelativeToParent(obj) then
		obj.x = (parent and parent.width or obj.parent.width) * 0.5
	else
		obj.x = width - abs(originX)
	end
	obj.x = obj.x - (marginX or 1) - obj.anchorX * obj.width
end
magnet["right"] = magnet.right

function magnet:bottom(obj, marginY, parent)
	if parent or isRelativeToParent(obj) then
		obj.y = (parent and parent.height or obj.parent.height) * 0.5
	else
		obj.y = height - abs(originY)
	end
	obj.y = obj.y - (marginY or 1) - obj.anchorY * obj.height
end
magnet["bottom"] = magnet.bottom

function magnet:left(obj, marginX, parent)
	if parent or isRelativeToParent(obj) then
		obj.x = - (parent and parent.width or obj.parent.width) * 0.5
	else
		obj.x = originX
	end
	obj.x = obj.x + (marginX or 1) + obj.anchorX * obj.width
end
magnet["left"] = magnet.left

function magnet:center(obj, marginX, marginY, parent)
	if parent or isRelativeToParent(obj) then
		obj.x = 0
		obj.y = 0
	else
		obj.x = display.contentCenterX
		obj.y = display.contentCenterY
	end
	obj.x = obj.x + (marginX or 0)
	obj.y = obj.y + (marginY or 0)
end
magnet["center"] = magnet.center

-- RESIZE
function magnet:snapToParent(obj, top, right, bottom, left, parent)
	top, right, bottom, left = top or 0, right or 0, bottom or 0, left or 0
	if isRelativeToParent(obj) then
		obj.width = obj.parent.width - left - right
		obj.height = obj.parent.height - top - bottom
	else
		obj.width = width - left - right
		obj.height = height - top - bottom
	end
	self:topLeft(obj, left, top, parent)
end

-- PERCENT SIZE
function magnet:getPercentX( percent )
	return width * (percent * 0.01)
end

function magnet:getPercentY( percent )
	return height * (percent * 0.01)
end

-- CORNER ACCESSORIES
function magnet:topLeft(obj, marginX, marginY, parent)
	self:left(obj, marginX, parent)
	self:top(obj, marginY, parent)
end
magnet["topLeft"] = magnet.topLeft

function magnet:topRight(obj, marginX, marginY, parent)
	self:right(obj, marginX, parent)
	self:top(obj, marginY, parent)
end
magnet["topRight"] = magnet.topRight

function magnet:bottomLeft(obj, marginX, marginY, parent)
	self:left(obj, marginX, parent)
	self:bottom(obj, marginY, parent)
end
magnet["bottomLeft"] = magnet.bottomLeft

function magnet:bottomRight(obj, marginX, marginY, parent)
	self:right(obj, marginX, parent)
	self:bottom(obj, marginY, parent)
end
magnet["bottomRight"] = magnet.bottomRight

-- CENTER ACCESORIES
function magnet:topCenter(obj, marginX, marginY, parent)
	self:center(obj, marginX, 0, parent)
	self:top(obj, marginY, parent)
end
magnet["topCenter"] = magnet.topCenter

function magnet:centerRight(obj, marginX, marginY, parent)
	self:center(obj, 0, marginY, parent)
	self:right(obj, marginX, parent)
end
magnet["centerRight"] = magnet.centerRight

function magnet:bottomCenter(obj, marginX, marginY, parent)
	self:center(obj, marginX, 0, parent)
	self:bottom(obj, marginY, parent)
end
magnet["bottomCenter"] = magnet.bottomCenter

function magnet:centerLeft(obj, marginX, marginY, parent)
	self:center(obj, 0, marginY, parent)
	self:left(obj, marginX, parent)
end
magnet["centerLeft"] = magnet.centerLeft

function magnet:alignTo(sAlign, obj, xMargin, yMargin, parent)
	if type(self[sAlign]) == "function" then
		magnet[sAlign](self, obj, xMargin, yMargin, parent)
	end
end

magnet:updateCurrentOrientation()
setmetatable(magnet, { __call = function(_, ...) return magnet:alignTo(...) end })

return magnet