--[[
    FIXME:
    1. when snake is on any of the boundary then changing direction should be restricted
    2. Food on the edge is not eaten when the snake's position is reset on the edge
        when on boundary
]]

function love.load()
    require('lib.class')
    require('src.snake')
    require('src.food')
    require('src.keyboard')
    require('src.colors')
    require('src.utils')
    
    gamestates = {PAUSE = 'PAUSE', RUNNING = 'RUNNING', GAME_OVER = 'GAME OVER'}
    state = gamestates.RUNNING
    width, height = love.graphics.getDimensions()
    love.graphics.setBackgroundColor(GREY)
    speed = Snake.body_width
    dir_x, dir_y = 0, 0
    delay = 0.2
    timer = 0
    score = 0

    snake = Snake:new()
    head = snake.body[1]
    food = Food:new(Food.spawn())
end

function love.update(dt)
    if state == gamestates.RUNNING then
        timer = timer + dt
        if timer >= delay then
            local old_x = head.x
            local old_y = head.y
            
            snake:update_head()
            snake:update_body(old_x, old_y)
            if snake:is_colliding_with_self() then
                state = gamestates.GAME_OVER
            end

            timer = 0
        end
    end
end

function love.draw()
    snake:draw()
    food:draw()

    if grid_on then
        draw_grid()
    end
    
    love.graphics.setColor(BLACK)
    love.graphics.setFont(love.graphics.newFont(20))
    love.graphics.print(string.format('Score: %d', score))
    
    if state == gamestates.GAME_OVER then
        game_over_text = 'Press \'Space\' to Restart'
        text = love.graphics.newFont(40)
        love.graphics.setFont(text)
        game_over_text_x = (width / 2) - text:getWidth(game_over_text) / 2
        game_over_text_y = (height / 2) - text:getHeight(game_over_text) / 2
        love.graphics.print(game_over_text, game_over_text_x, game_over_text_y)
    end
end