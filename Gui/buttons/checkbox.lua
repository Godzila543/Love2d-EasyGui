local parent=require("Gui/button")
local check=parent:new()
check.toggle=false
check.check={{75,75,75},{0,255,0}}
check.hovto=nil--usefull for if you want to use custom images or if you want a custom color when its checked and you are hovering over the button. it stands for hover+toggle
check.fontColor={255,255,255}--for different color depending on state use the order |normal, hover, click, checked and normal, checked and hover|

function check:new(o)
	o=o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end




function check:draw(x,y)
	local x=x or self.pos.x
	local y=y or self.pos.y
	if self.disp=="simple" then
		local body
		local outline
		if self.state==0 then 
			body=self.color[1]
			outline=self.color[2]
		end
		if self.toggle then 
			outline=self.check[2]
		end
		if self.state==1 then
			body=self.hover[1]
			outline=self.hover[2]
		end
		if self.toggle then 
			body=self.check[1]
			outline={(self.check[2][1]+outline[1]*2)/3,(self.check[2][2]+outline[2]*2)/3,(self.check[2][3]+outline[3]*2)/3}
		end
		if self.toggle and self.hovto and self.state==1 then --check if hovto is defined, uses it if it is
			body=self.hovto[1]
			outline=self.hoveto[2]
		end
		if self.state==2 then
			body=self.click[1]
			outline=self.click[2]
		end
	
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
		if self.state==2 then
			drawinrect(self.click, x, y, self.size.w, self.size.h or self.size.w)
		elseif self.toggle and self.state==1 then
			drawinrect(self.hovto or self.check, x, y, self.size.w, self.size.h or self.size.w)
		elseif self.toggle then 
			drawinrect(self.check, x, y, self.size.w, self.size.h or self.size.w)
		elseif self.state==0 then 
			drawinrect(self.color, x, y, self.size.w, self.size.h or self.size.w)
		elseif self.state==1 then
			drawinrect(self.hover, x, y, self.size.w, self.size.h or self.size.w)
		end
	end
	if self.font then
		self:dispText(x, y)
	end
end

function check:dispText(x, y)--simple text display. should work for simple things, but if you want to do custom designs use the image display mode. 
	-- body
	if type(self.fontColor[1])=="table" then 
		if self.toggle and self.state~=2 then
			love.graphics.setColor(self.fontColor[self.state+4])
		else
			love.graphics.setColor(self.fontColor[self.state+1])
		end
	else
		love.graphics.setColor(self.fontColor)
	end
	if self.font then love.graphics.setFont(self.font) end
	love.graphics.printf(self.text,x, y+(self.size.h or self.size.w)/2-self.font:getHeight()/2, self.size.w,"center")
end



function check:update(forceX, forceY)
	if camera then 
		x,y = camera.getMouse()
	else
		x,y = love.mouse.getPosition()
	end
	local overX = forceX or self.pos.x--overwrite x
	local overY = forceY or self.pos.y--overwrite y
	local ontop

	if self.style=="rect" or self.style=="round" then --collision for rect and round style buttons
		if x>=overX and x<=overX+self.size.w and y>=overY and y<=overY+self.size.h then
			ontop=true
		end
	
	elseif self.style=="circle" then --collision for circle
		if (x-(overX+self.size.w/2))^2+(y-(overY+self.size.w/2))^2<=(self.size.w/2)^2 then
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
			local oldstate=self.state
			self.state=1
			if oldstate==2 then
				self.toggle=not self.toggle
				return true
			end
		end
	else
		self.state=0
	end
end

return check