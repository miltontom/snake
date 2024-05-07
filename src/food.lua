Food = class()

Food.width = Snake.body_width
Food.height = Snake.body_height

function Food:init(x, y)
    self.x = x
    self.y = y
end

function Food.spawn()
    math.randomseed(os.time())

    local rand_x = width - (Snake.body_width * math.random(1, width / Snake.body_width))
    local rand_y = height - (Snake.body_height * math.random(1, height / Snake.body_height))

    return rand_x, rand_y
end

function Food:draw()
    love.graphics.setColor(RED)
    love.graphics.rectangle('fill', self.x, self.y, Food.width, Food.height)
end