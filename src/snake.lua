Snake = class()

Snake.body_width = 20
Snake.body_height = 20

function Snake:init()
    self.x = love.graphics.getWidth() / 2
    self.y = love.graphics.getHeight() / 2
    self.body = {}
    table.insert(self.body, {
        x=self.x,
        y=self.y,
        width=Snake.body_width,
        height=Snake.body_height
    })
end

function Snake:update_head()
    head.x = head.x + (dir_x * speed)
    head.y = head.y + (dir_y * speed)
    
    if head.x < 0 then
        head.x = width - Snake.body_width
    elseif head.x > width then
        head.x = 0
    elseif head.y < 0 then
        head.y = height - Snake.body_height
    elseif head.y > height then
        head.y = 0
    end

    local has_ate_food = head.x == food.x and head.y == food.y
    if has_ate_food then
        score = score + 1
        food.x, food.y = Food.spawn()
        table.insert(snake.body, {x=food.x, y=food.y, width=food.width, height=food.height})
    end
end

function Snake:update_body(old_x, old_y)
    for i, v in ipairs(self.body) do
        if i ~= 1 then 
            local x, y = v.x, v.y
            v.x, v.y = old_x, old_y
            old_x, old_y = x, y
        end
    end
end

function Snake:is_colliding_with_self()
    for i, v in ipairs(self.body) do
        if i ~= 1 then
            if head.x == v.x and head.y == v.y then
                return true
            end
        end
    end

    return false
end

local snake_head_right = love.graphics.newImage('assets/snake_head_right.png')
local snake_head_left = love.graphics.newImage('assets/snake_head_left.png')
local snake_head_up = love.graphics.newImage('assets/snake_head_up.png')
local snake_head_down = love.graphics.newImage('assets/snake_head_down.png')
local snake_body = love.graphics.newImage('assets/snake_body.png')

local function update_head_dir()
    if dir_x == 0 and dir_y == -1 then
        return snake_head_up
    elseif dir_x == 0 and dir_y == 1 then
        return snake_head_down
    elseif dir_x == 1 and dir_y == 0 then
        return snake_head_right
    else
        return snake_head_left
    end
end

function Snake:draw()
    for i, v in ipairs(self.body) do
        if i == 1 then
            love.graphics.draw(update_head_dir(), v.x, v.y)
        else
            love.graphics.draw(snake_body, v.x, v.y)
        end
    end
end