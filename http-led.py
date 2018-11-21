try:
  import usocket as socket
except:
  import socket

from machine import Pin
import network

import esp
esp.osdebug(None)

import gc
gc.collect()

ssid = 'COLOCAR_SSID'
senha = 'COLOCAR_SENHA'
estacao = network.WLAN(network.STA_IF)
estacao.active(True)
estacao.connect(ssid, senha)

while estacao.isconnected() == False:
  pass

print('Conexao realizada.')
print(estacao.ifconfig())

led = Pin(16, Pin.OUT) # D0 (GPIO16)

def pagina_web(arquivo):
  conteudo = ''
  a = open(arquivo)
  conteudo = a.read()
  a.close()
  return conteudo

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind(('', 80))
s.listen(5)

while True:
  conexao, endereco = s.accept()
  print('Conexao de %s' % str(endereco))
  requisicao = conexao.recv(1024)
  requisicao = str(requisicao)
  print('Conteudo = %s' % requisicao)
  if requisicao.find('/led/1') != -1:
    print('Acender')
    led.value(1)
  elif requisicao.find('/led/0') != -1:
    print('Apagar')
    led.value(0)
  else:
    led.value(0)
  html = pagina_web('http-led-bootstrap.html')
  conexao.send(html)
  conexao.close()


