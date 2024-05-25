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

            update_direction()
            timer = 0
        end
    end
end

function love.draw()
    love.graphics.setColor(WHITE)
    snake:draw()
    food:draw()

    if grid_on then
        draw_grid()
    end
    
    if state == gamestates.GAME_OVER then
        love.graphics.setColor(BLACK)
        local score_text_offset = -40
        score_text = string.format('Score: %d', score)
        text = love.graphics.newFont(40)
        love.graphics.setFont(text)
        score_x = (width / 2) - text:getWidth(score_text) / 2
        score_y = (height / 2) - text:getHeight(score_text) / 2 + score_text_offset
        love.graphics.print(score_text, score_x, score_y)

        game_over_text = 'Press \'Space\' to Restart'
        text = love.graphics.newFont(20)
        love.graphics.setFont(text)
        game_over_text_x = (width / 2) - text:getWidth(game_over_text) / 2
        game_over_text_y = (height / 2) - text:getHeight(game_over_text) / 2
        love.graphics.print(game_over_text, game_over_text_x, game_over_text_y)
    end
end