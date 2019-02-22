--
player = {}

function player:new(tipo, x, y, raio, velocidade)

    local instancia = {
        x = x or 20, 
        y = y or 30,  
        raio = raio or 20, 
        velocidade = velocidade or 10,
        _tipo = tipo
    }

    function instancia:draw()
        love.graphics.circle(tipo, x, y, raio, 12)
    end

    function instancia:move(x, y)
        x = x or 0
        y = y or 0
        instancia.x = instancia.x + x
        instancia.y = instancia.y + y
    end

    function instancia:debug()
        love.graphics.print(
            'x: '..instancia.x, 
            instancia.x, 
            instancia.y - 30
        )
    end

    return instancia
end

return player