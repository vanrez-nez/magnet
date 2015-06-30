--game
local composer = require ( "composer" )
local magnet	 = require ( "lib.magnet" )
local scene      = composer.newScene()

local currentAlignIdx = 1
local currentCaseIdx = 1
local currentParent = nil
local testRect, txtCurrentAlign, testContainer, testSnapshot, testGroup
local updateParentAlignment

local sAligns = {
	"center",
	"topLeft",
	"topCenter",
	"topRight",
	"centerRight",
	"bottomRight",
	"bottomCenter",
	"bottomLeft",
	"centerLeft",
}

local function updateAlignment( )
	
	magnet(sAligns[currentAlignIdx], testRect, 1, 1, testSnapshot)	
	
	txtCurrentAlign.text = sAligns[currentAlignIdx]
	magnet:center(txtCurrentAlign, 0, 70)
	testRect:toFront()

	if updateParentAlignment then
		magnet:center(currentParent)
	end
	

	if testSnapshot then
		testSnapshot:invalidate()
	end
end

function scene:create( event )
	local sceneGroup = self.view
	
	txtCurrentAlign = display.newEmbossedText( sceneGroup, "", 0, 0, nil, 24 )
	testRect = display.newRect(0, 0, 25, 25)
	testRect:setFillColor(0.4)
	testRect:setStrokeColor(1, 0, 0)
	testRect.strokeWidth = 1
end

function scene:show( event )
	local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then

	elseif ( phase == "did" ) then
		updateTestCase()
		updateAlignment()
	end
end

function scene:hide( event )
	
end

function scene:destroy( event )

end

function updateTestCase()
	local currentStage = display.getCurrentStage()
	local currentView = composer.getScene(composer.getSceneName( "current" )).view
	updateParentAlignment = false

	if currentCaseIdx > 4 then
		currentCaseIdx = 1
		currentStage:insert(testRect)
		testContainer:removeSelf()
		testSnapshot:removeSelf()
		testSnapshot = nil
		testContainer = nil
	end

	if currentCaseIdx == 1 then
		currentStage:insert(testRect)
		parent = currentParent
	elseif currentCaseIdx == 2 then
		currentView:insert(testRect)
		parent = currentView
	elseif currentCaseIdx == 3 then
		testContainer = display.newContainer(100, 100)
		local bgFill = display.newRect( testContainer, 0, 0, 100, 100 )
		bgFill:setFillColor(0.4, 0.4)
		testContainer:insert(bgFill)
		currentView:insert(testContainer)
		parent = testContainer
		testContainer:insert(testRect)
		updateParentAlignment = true
	elseif currentCaseIdx == 4 then
		testSnapshot = display.newSnapshot(100, 100)
		parent = testSnapshot
		testSnapshot.group:insert(testRect)
		currentView:insert(testSnapshot)
		testSnapshot.clearColor = {1,0,0}
		updateParentAlignment = true
	end
	currentParent = parent
end

function onScreenTap( event )
	currentAlignIdx = currentAlignIdx + 1
	if currentAlignIdx > #sAligns then
		currentAlignIdx = 1
		currentCaseIdx = currentCaseIdx + 1
		updateTestCase()
	end
	updateAlignment()
end


local function onOrientationChange( event )
   magnet:updateCurrentOrientation()   
   updateAlignment()
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

Runtime:addEventListener("orientation", onOrientationChange )
Runtime:addEventListener("tap", onScreenTap)

return scene