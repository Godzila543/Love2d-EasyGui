local progress=gui.baseClass:new()
progress.range={0,100}
progress.value=0
progress.pos={x=0,y=0}
progress.size={w=200,h=20,r=10,s=2}
progress.color={{0,255,255},{50,50,50},{255,255,255}}

function progress:draw()
	print(self.size.h)
	love.graphics.stencil(function() print(self.size.h) love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.size.w, self.size.h, self.size.r or 0) end, "replace", 1)
	love.graphics.setStencilTest("greater", 0)
	love.graphics.setColor(self.color[2])
	love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.size.w, self.size.h)
	love.graphics.setColor(self.color[1])
	love.graphics.rectangle("fill", self.pos.x, self.pos.y, math.map(self.value, self.range[1], self.range[2], 0, self.size.w), self.size.h)
	love.graphics.setColor(self.color[3])
	love.graphics.setLineWidth(self.size.s or 1)
	love.graphics.rectangle("line", self.pos.x, self.pos.y, self.size.w, self.size.h, self.size.r or 0)
	love.graphics.setStencilTest()
end

return progress