function draw_grid()
    love.graphics.setColor(WHITE)

    local h_x1, h_y1 = 0, Snake.body_width
    local h_x2, h_y2 = width, Snake.body_width

    local v_x1, v_y1 = Snake.body_width, 0
    local v_x2, v_y2 = Snake.body_width, height

    local total_lines = width / Snake.body_width
    for i = 1, total_lines do
        love.graphics.line(h_x1, h_y1, h_x2, h_y2)
        h_y1 = h_y1 + Snake.body_width
        h_y2 = h_y2 + Snake.body_width

        love.graphics.line(v_x1, v_y1, v_x2, v_y2)
        v_x1 = v_x1 + Snake.body_width
        v_x2 = v_x2 + Snake.body_width
    end
end