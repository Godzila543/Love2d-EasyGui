function drawinrect(img, x, y, w, h, r)
    local wid, hei = img:getDimensions()
    
    return love.graphics.draw(img, x, y, r or 0, w / wid, h / hei)
end

function math.lerp(v0,v1,t)
	-- body
	return (1 - t) * v0 + t * v1
end

function math.map(v,b1,b2,o1,o2)
	local scale = (o2-o1) / (b2-b1)
	local step1 = v - b1 
	local step2 = step1*scale
	local step3 = step2+o1
	return step3
end