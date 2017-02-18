local button=gui.baseClass:new()
button.color={{150,150,150},{25,25,25}}
button.hover={{150,150,150},{255,255,255}}
button.click={{50,50,50},{255,140,0}}
button.state=0
button.pos=vector.new(0,0)
button.size={w=100,h=100,s=5,r=10}
button.style="round"
button.disp="simple"
button.font=nil--here just to keep track that it exists
button.fontColor={255,255,255}
button.text=nil--here to say it exists



function button:draw(x, y)
	local body
	local outline
	local x = x or self.pos.x
	local y = y or self.pos.y
	if self.state==0 then 
		body=self.color[1]
		outline=self.color[2]
	elseif self.state==1 then
		body=self.hover[1]
		outline=self.hover[2]
	elseif self.state==2 then
		body=self.click[1]
		outline=self.click[2]
	end

	if self.disp=="simple" then
		if self.style=="rect" then
			love.graphics.setColor(body)
			love.graphics.rectangle("fill", x, y, self.size.w, self.size.h)
			love.graphics.setColor(outline)
			love.graphics.setLineWidth(self.size.s)
			love.graphics.rectangle("line", x, y, self.size.w, self.size.h)
		elseif self.style=="round" then
			love.graphics.setColor(body)
			love.graphics.rectangle("fill", x, y, self.size.w, self.size.h,self.size.r,self.size.r, 20)
			love.graphics.setColor(outline)
			love.graphics.setLineWidth(self.size.s)
			love.graphics.rectangle("line", x, y, self.size.w, self.size.h,self.size.r,self.size.r, 20)
		elseif self.style=="circle" then
			love.graphics.setColor(body)
			love.graphics.circle("fill", x+self.size.w/2, y+self.size.w/2, self.size.w/2, 50)
			love.graphics.setColor(outline)
			love.graphics.setLineWidth(self.size.s)
			love.graphics.circle("line", x+self.size.w/2, y+self.size.w/2, self.size.w/2, 50)
		end
	elseif self.disp=="img" then
		love.graphics.setColor(255, 255, 255)
		if self.state==0 then 
			drawinrect(self.color, x, y, self.size.w, self.size.h or self.size.w)
		elseif self.state==1 then
			drawinrect(self.hover, x, y, self.size.w, self.size.h or self.size.w)
		elseif self.state==2 then
			drawinrect(self.click, x, y, self.size.w, self.size.h or self.size.w)
		end
	end
	if self.font then
		self:displayText(x, y)
	end
end

function button:dispText(x, y)--rudementary text display. should work for simple things, but if you want to do custom designs use the image display mode. 
	-- body
	if type(self.fontColor[1])=="table" then 
		love.graphics.setColor(self.fontColor[self.state+1])
	else
		love.graphics.setColor(self.fontColor)
	end
	if self.font then love.graphics.setFont(self.font) end 
	love.graphics.printf(self.text,x, y+self.size.h/2-7, self.size.w,"center")
end

function button:action()
	print("hi")
end

function button:update()
	if camera then 
		x,y = camera.getMouse()
	else
		x,y = love.mouse.getPosition()
	end
	
	local ontop
	if self.style=="rect" or self.style=="round" then --collision for rect and round style buttons
		if x>=self.pos.x and x<=self.pos.x+self.size.w and y>=self.pos.y and y<=self.pos.y+self.size.h then
			ontop=true
		end
	
	elseif self.style=="circle" then --collision for circle
		if (x-(self.pos.x+self.size.w/2))^2+(y-(self.pos.Y+self.size.w/2))^2<=(self.size.w/2)^2 then
			ontop=true
		end
	end

	if ontop then
		if love.mouse.isDown(1) then
			local oldstate=self.state
			self.state=2
			if oldstate==self.state then
				
			else
				self:action()
			end
		else
			self.state=1
		end
	else
		self.state=0
	end
	
end

return button