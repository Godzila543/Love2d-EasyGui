function love.load()
	package.path="c:/Users/Colin/Documents/GitHub/Love2d/Modules/?.lua"
	require("camera")
	camera.on=false
	vector = require"vector"
	package.path="c:/Users/Colin/Documents/GitHub/Love2d-EasyGui/?.lua"
	gui = require("EasyGui")
	love.window.setMode( 800, 800)
	height = love.graphics.getHeight()
	width = love.graphics.getWidth()
	love.graphics.setBackgroundColor(250, 100, 90)
	
	--round=gui.button:new({size={w=100,h=25,s=0,r=10}})
	rect=gui.button:new({pos=vector.new(0,100),size={w=100,h=25, s=0,r=10},style="rect"})
	circle=gui.button.checkbox:new({pos=vector.new(0,200),size={w=100, h=25 ,s=5}})
	split=gui.button.split:new({pos=vector.new(0,300)})
	split:insert(gui.button.checkbox:new({style="circle",pos=vector.new(0,300),size={w=100, h=25 ,s=2, r=10},color={{255,0,0},{0,0,0}},check={{150,0,0},{255,0,0}}  }  ))
	split:insert(gui.button.checkbox:new({style="circle",pos=vector.new(100,300),size={w=100, h=25 ,s=2, r=10},color={{0,255,0},{0,0,0}},check={{0,150,0},{0,255,0}}  }  ))
	split:insert(gui.button.checkbox:new({style="circle",pos=vector.new(100,400),size={w=100, h=25 ,s=2, r=10},color={{0,0,255},{0,0,0}},check={{0,0,150},{0,0,255}}  }  ))
	split:insert(gui.button.checkbox:new({style="circle",pos=vector.new(0,400),size={w=100, h=25 ,s=2, r=10},color={{0,255,255},{0,0,0}},check={{0,150,150},{0,255,255}}  }  ))

	imagebut=gui.button.checkbox:new({pos=vector.new(0,0),size={w=100},style="circle",disp="img",
		color=love.graphics.newImage("color.png"),
		hover=love.graphics.newImage("hover.png"),
		click=love.graphics.newImage("click.png"),
		check=love.graphics.newImage("check.png"),
		hovto=love.graphics.newImage("hovto.png")})
	local font = love.graphics.newFont(14)
	text=gui.button.checkbox:new({size={w=100,h=25,s=0,r=10}, pos=vector.new(0,500), text="Hello",font=font})

	sliderR=gui.slider:new({pos=vector.new(300,100),value=0,handle={w=100,h=15,color={100,0,0},r=7.5},range={0,255}})
	sliderG=gui.slider:new({pos=vector.new(300,120),value=1,handle={w=100,h=15,color={0,100,0},r=7.5},range={0,255}})
	sliderB=gui.slider:new({pos=vector.new(300,140),value=0,handle={w=100,h=15,color={0,0,100},r=7.5},range={0,255}})
	sliderVertical=gui.slider:new({direction="vertical",pos=vector.new(150,150),track={w=2,h=300,color={100,100,100},color2={255,255,255},r=0},value=1,handle={w=30,h=15,color={200,200,200},r=7.5},range={0,255}})
	sliderFill=gui.slider:new({pos=vector.new(300,180),value=1,track={w=300,h=5,color={255,255,255},color2={100,100,100},r=0},handle={w=15,h=30,color={0,0,100},r=7.5},range={0,255}})
	sliderFill2=gui.slider:new({pos=vector.new(300,210), track={w=300,h=15,color={100,100,100},color2={255,255,255},r=7.5},handle={w=25,h=15,color={50,50,50},r=7.5}})
	sliderSquare=gui.slider:new({pos=vector.new(300,240),value=1,track={w=300,h=20,color={255,255,255},r=0},handle={w=20,h=20,color={0,0,100},r=0},range={0,255}})
end
function love.draw()
	if camera.on then camera.transformation() end
	--round:draw()
	rect:draw()
	circle:draw()
	split:draw()
	imagebut:draw()
	text:draw()
	sliderR:draw()
	sliderG:draw()
	sliderB:draw()
	sliderVertical:draw()
	sliderFill:draw()
	sliderFill2:draw()
	sliderSquare:draw()
	print(sliderR:getValue())
	love.graphics.setColor(sliderR:getValue(), sliderG:getValue(), sliderB:getValue())
	love.graphics.circle("fill", 650, 120, 20, 20)
end

function love.update(dt)
	delta = dt
	if camera.on then camera.smooth(dt) end
	--round:update()
	rect:update()
	circle:update()
	split:update(dt)
	imagebut:update()
	text:update()
	sliderR:update()
	sliderG:update()
	sliderB:update()
	sliderVertical:update()
	sliderFill:update()
	sliderFill2:update()
	sliderSquare:update()
end


function love.focus(bool)
end

function love.keypressed( key, unicode )
	print(key)
end


function love.keyreleased( key, unicode )

end

function love.mousepressed( x, y, button )
end

function love.mousereleased( x, y, button )
end

function love.wheelmoved( x, y )
	if camera.on then camera.zoom(x, y) end
end

function love.mousemoved(x, y, dx, dy, istouch)
	-- body
	if camera.on then camera.mousemoved(x, y, dx, dy, istouch) end
end

function love.quit()
end
