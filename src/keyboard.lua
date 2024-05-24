old_dir_x, old_dir_y = 0, 0

function love.keypressed(key)
    local is_running = state == gamestates.RUNNING
    local is_game_over = state == gamestates.GAME_OVER

    if key == 'q' then
        love.event.quit()
    elseif key == 'g' and is_running then
        grid_on = not grid_on
    elseif key == 'up' and  old_dir_y ~= 1 and is_running and (head.x < width and head.x >= 0) then
        dir_x, dir_y = 0, -1
    elseif key == 'down' and old_dir_y ~= -1 and is_running and (head.x < width and head.x >= 0) then
        dir_x, dir_y = 0, 1
    elseif key == 'left' and old_dir_x ~= 1 and is_running and (head.y < height and head.y >= 0) then
        dir_x, dir_y = -1, 0
    elseif key == 'right' and old_dir_x ~= -1 and is_running and (head.y < height and head.y >= 0) then
        dir_x, dir_y = 1, 0
    elseif key == 'space' and is_game_over then
        state = gamestates.RUNNING
        snake = Snake:new()
        head = snake.body[1]
        dir_x, dir_y = 0, 0
        food.x, food.y = Food.spawn()
        score = 0
    elseif key == 'p' and not is_game_over then
        if state == gamestates.RUNNING then
            state = gamestates.PAUSE
        else
            state = gamestates.RUNNING
        end
    end
end

function update_direction()
    old_dir_x, old_dir_y = dir_x, dir_y
end