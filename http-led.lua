wifi.setmode(wifi.STATION)
station_cfg={}
station_cfg.ssid="COLOCAR_SSID"
station_cfg.pwd="COLOCAR_SENHA"
station_cfg.save=false
wifi.sta.config(station_cfg)
wifi.sta.connect()
print("IP do Servidor: ")
print ("Espere...")
tmr.alarm(0, 1000, 1, function()
  if wifi.sta.getip() ~= nil then
    print("Pronto! IP do Servidor: " .. wifi.sta.getip())
    tmr.stop(0)
  end
end)
srv=net.createServer(net.TCP) 
srv:listen(80, function(conn) 
  conn:on("receive", function(conn, requisicao) 
    pino=0 -- D0 (GPIO16)
    gpio.mode(pino, gpio.OUTPUT)  
    --print(requisicao)
    if string.find(requisicao, " /led/1") ~= nil then
      print("Acender")
      gpio.write(pino, gpio.HIGH)
    else 
      if string.find(requisicao, " /led/0") ~= nil then
        print("Apagar")
        gpio.write(pino, gpio.LOW)
      else
        gpio.write(pino, gpio.LOW)
      end
    end
    conteudo = ""
    file.open("http-led-bootstrap.html", "r")
    while true do
      linha = file.readline()
      if linha == nil then
        break
      end
      conteudo = conteudo .. linha
    end
    file.close()
    --print(conteudo)
    conn:send(conteudo)
  end)
  conn:on("sent", function(conn) conn:close() end) 
end)
