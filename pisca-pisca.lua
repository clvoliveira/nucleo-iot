-- O LED da placa é ativado com nível LOW
estado=0
pino=0 -- D0 (Também ativa o LED da placa)
gpio.mode(pino, gpio.OUTPUT)
tmr.alarm(1, 2000, 1, function()
  if estado==0 then
    estado=1
    gpio.write(pino, gpio.HIGH)
  else
    estado=0
    gpio.write(pino, gpio.LOW)
  end
end)
