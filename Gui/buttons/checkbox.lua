local parent=require("Gui/button")
local check=parent:new()
check.toggle=false
check.check={{75,75,75},{0,255,0}}

function check:new(o)
	o=o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function check:draw(x,y)
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
	if self.state==2 then
		body=self.click[1]
		outline=self.click[2]
	end
	
	local x=x or self.pos.x
	local y=y or self.pos.y

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
		love.graphics.circle("fill", x, y, self.size.w/2, 50)
		love.graphics.setColor(outline)
		love.graphics.setLineWidth(self.size.s)
		love.graphics.circle("line", x, y, self.size.w/2, 50)
	end
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
		if (x-overX)^2+(y-overY)^2<=(self.size.w/2)^2 then
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