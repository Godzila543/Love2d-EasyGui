local textbox=gui.baseClass:new()
utf8=require("utf8")
textbox.size={w=100,h=30}
textbox.color={box={50,50,50},outline={255,255,255},selected={0,255,255},cursor={255,255,255}, text={255,255,255}}
textbox.text=""
textbox.active=true
textbox.xOffset=0
textbox.xOffsetSmooth=0
textbox.textOffset=0
textbox.textOffsetSmooth=0
textbox.phase=255
textbox.font = love.graphics.newFont(25)
textbox.align="left"
textbox.timer=0

function textbox:draw()
	if self.align=="left" then
		if self.font:getWidth(self.text)+5 >= self.size.w-5 then
			self.textOffset=self.size.w-self.font:getWidth(self.text)-15
		else
			self.textOffset=0
		end
		self.xOffset=self.font:getWidth(self.text)+5+self.textOffset

	elseif self.align=="center" then
		self.xOffset=self.font:getWidth(self.text)/2+self.size.w/2+5
	elseif self.align=="rigt" then
		self.xOffset=self.size.w-5
	end
	self.xOffsetSmooth=self.xOffsetSmooth-((self.xOffsetSmooth-self.xOffset)*0.5)
	self.textOffsetSmooth=self.textOffsetSmooth-((self.textOffsetSmooth-self.textOffset)*0.5)
	love.graphics.setColor(self.color.box)
	love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.size.w, self.size.h)
	if self.active then
		self.timer=self.timer+0.1
		self.phase=math.map(math.cos(self.timer),-1,1,0,255)
		love.graphics.setColor(self.color.selected)
		if self.size.s then love.graphics.setLineWidth(self.size.s) end
		
		love.graphics.rectangle("line", self.pos.x, self.pos.y, self.size.w, self.size.h)
		love.graphics.setColor(self.color.cursor[1], self.color.cursor[2], self.color.cursor[3], self.phase)
		love.graphics.rectangle("fill", self.pos.x+self.xOffsetSmooth, self.pos.y+4/2, 2, self.size.h-4)
	else
		love.graphics.setColor(self.color.outline)
		love.graphics.rectangle("line", self.pos.x, self.pos.y, self.size.w, self.size.h)
	end
	love.graphics.setColor(255, 255, 255)
	love.graphics.setFont(self.font)
	love.graphics.stencil(function() love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.size.w, self.size.h) end, "replace", 1)
	love.graphics.setStencilTest("greater", 0)
	love.graphics.printf(self.text, self.pos.x+5+self.textOffsetSmooth, self.pos.y, self.size.w-self.textOffsetSmooth, self.align)
	love.graphics.setStencilTest()
	
end

function textbox:textInput(t)
	if self.active then
		self.text=self.text .. t
		self.timer=-0.2
	end
end

function textbox:mousepressed(x,y,button)
	if x>=self.pos.x and x<=self.pos.x+self.size.w and y>=self.pos.y and y<=self.pos.y+self.size.h then
		self.active=true
	else 
		self.active=false
	end
end

function textbox:keypressed(key)
	if self.active then
		if key == "backspace" then
	        -- get the byte offset to the last UTF-8 character in the string.
	        local byteoffset = utf8.offset(self.text, -1)
	 
	        if byteoffset then
	            -- remove the last UTF-8 character.
	            -- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
	            
	            self.text = string.sub(self.text, 1, byteoffset - 1)
	        end
    	end
	end
end

return textbox