local slider=gui.baseClass:new()
slider.pos=vector.new(0,0)
slider.track={w=300,h=5,color={100,100,100},r=2.5}
slider.handle={w=100,h=15,color={50,50,50},r=7.5}
slider.value=0
slider.range={0,100}
slider.radius=5
slider.direction="horizontal"

function slider:draw()
	
	local radius
	if self.track.r then 
		radius=self.track.r
	else
		radius=self.radius
	end
	if self.track.color2 then
		if self.direction=="horizontal" then
			love.graphics.setColor(self.track.color)
			love.graphics.rectangle("fill", self.pos.x, self.pos.y, math.map(self.value, 0, 1, 0, self.track.w-self.handle.w)+self.handle.w/2, self.track.h, radius)
			love.graphics.setColor(self.track.color2)
			love.graphics.rectangle("fill", self.pos.x+math.map(self.value, 0, 1, 0, self.track.w-self.handle.w)+self.handle.w/2, self.pos.y, self.track.w-math.map(self.value, 0, 1, 0, self.track.w-self.handle.w)-self.handle.w/2, self.track.h, radius)
		elseif self.direction=="vertical" then
			love.graphics.setColor(self.track.color)
			love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.track.w, math.map(self.value, 0, 1, 0, self.track.h-self.handle.h)+self.handle.h/2, radius)
			love.graphics.setColor(self.track.color2)
			love.graphics.rectangle("fill", self.pos.x, self.pos.y+math.map(self.value, 0, 1, 0, self.track.h-self.handle.h)+self.handle.h/2, self.track.w, self.track.h-math.map(self.value, 0, 1, 0, self.track.h-self.handle.h)-self.handle.h/2, radius)
		end
	else
		love.graphics.setColor(self.track.color)
		love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.track.w, self.track.h, radius)
	end
	love.graphics.setColor(self.handle.color)
	local radius
	if self.handle.r then
		radius = self.handle.r
	else
		radius = self.radius
	end
	if self.direction=="horizontal" then
		love.graphics.rectangle("fill", self.pos.x+math.map(self.value, 0, 1, 0, self.track.w-self.handle.w), self.pos.y-(self.handle.h-self.track.h)/2, self.handle.w, self.handle.h, radius)
	elseif self.direction=="vertical" then
		love.graphics.rectangle("fill", self.pos.x-(self.handle.w-self.track.w)/2, self.pos.y+math.map(self.value, 0, 1, 0, self.track.h-self.handle.h), self.handle.w, self.handle.h, radius)
	end
end

function slider:update()
	if camera then 
		x,y = camera.getMouse()
	else
		x,y = love.mouse.getPosition()
	end
	self.oldDown=self.isdown or false
	self.isdown = love.mouse.isDown(1)

	if self.direction=="horizontal" then
		if (x>=self.pos.x+math.map(self.value, 0, 1, 0, self.track.w-self.handle.w) and x<=self.pos.x+math.map(self.value, 0, 1, 0, self.track.w-self.handle.w)+self.handle.w) or self.grabbed then
			if (y>=self.pos.y-(self.handle.h-self.track.h)/2 and y<=self.pos.y-(self.handle.h-self.track.h)/2+self.handle.h) or self.grabbed then
				
				if not self.oldDown and self.isdown then
					self.offX=x
					self.oldValue=self.value
					self.grabbed=true
				end
				if self.oldDown and self.isdown and self.grabbed then
					local distance=x-self.offX
					distance=distance/(self.track.w-self.handle.w)
					self.value=self.oldValue+distance
					if self.value>1 then self.value=1 end
					if self.value<0 then self.value=0 end
				end
				if not self.isdown then
					self.grabbed=false
				end
			end
		end
	elseif self.direction=="vertical" then
		if (x>=self.pos.x-(self.handle.w-self.track.w)/2 and x<=self.pos.x-(self.handle.w-self.track.w)/2+self.handle.w) or self.grabbed then
			if (y>=self.pos.y+math.map(self.value, 0, 1, 0, self.track.h-self.handle.h) and self.pos.y+math.map(self.value, 0, 1, 0, self.track.h-self.handle.h)+self.handle.h) or self.grabbed then
				if not self.oldDown and self.isdown then
					self.offY=y
					self.oldValue=self.value
					self.grabbed=true
				end
				if self.oldDown and self.isdown and self.grabbed then
					local distance=y-self.offY
					distance=distance/(self.track.h-self.handle.h)
					self.value=self.oldValue+distance
					if self.value>1 then self.value=1 end
					if self.value<0 then self.value=0 end
				end
				if not self.isdown then
					self.grabbed=false
				end
			end
		end
	end
end

function slider:getValue()
	return math.map(self.value, 0, 1, self.range[1],self.range[2])
end
return slider