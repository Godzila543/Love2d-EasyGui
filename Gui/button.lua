local button={}
button.color={{150,150,150},{25,25,25}}
button.hover={{150,150,150},{255,255,255}}
button.click={{50,50,50},{255,140,0}}
button.state=0
button.pos=vector.new(0,0)
button.size={w=100,h=100,s=5,r=10}
button.style="round"
button.disp="simple"

function button:new(o)
	o=o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function button:draw()
	local body
	local outline
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
			love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.size.w, self.size.h)
			love.graphics.setColor(outline)
			love.graphics.setLineWidth(self.size.s)
			love.graphics.rectangle("line", self.pos.x, self.pos.y, self.size.w, self.size.h)
		elseif self.style=="round" then
			love.graphics.setColor(body)
			love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.size.w, self.size.h,self.size.r,self.size.r, 20)
			love.graphics.setColor(outline)
			love.graphics.setLineWidth(self.size.s)
			love.graphics.rectangle("line", self.pos.x, self.pos.y, self.size.w, self.size.h,self.size.r,self.size.r, 20)
		elseif self.style=="circle" then
			love.graphics.setColor(body)
			love.graphics.circle("fill", self.pos.x, self.pos.y, self.size.w/2, 50)
			love.graphics.setColor(outline)
			love.graphics.setLineWidth(self.size.s)
			love.graphics.circle("line", self.pos.x, self.pos.y, self.size.w/2, 50)
		end
	elseif self.disp=="img" then
		love.graphics.setColor(255, 255, 255)
		if self.state==0 then 
			drawinrect(self.color, self.pos.x, self.pos.y, self.size.w, self.size.h or self.size.w)
		elseif self.state==1 then
			drawinrect(self.hover, self.pos.x, self.pos.y, self.size.w, self.size.h or self.size.w)
		elseif self.state==2 then
			drawinrect(self.click, self.pos.x, self.pos.y, self.size.w, self.size.h or self.size.w)
		end
	end

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
		if (x-self.pos.x)^2+(y-self.pos.y)^2<=(self.size.w/2)^2 then
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