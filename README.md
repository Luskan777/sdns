# SDNS - Search DNS
Programa para consulta rápida de DNS, consulta dados como MX, IP address, status do dominio e dados referente ao registro do dominio como nameserver, id técnico e etc...


Forneça  a permissão de execução do arquivo sdns.sh e execute-o com o parametro "--help" para obter mais informações do programa


# Dependencias:
- whois 
  
   - DEB  - $ sudo apt install whois
   
   - RHEL - $ sudo yum install whois

# Intalação:

$ git clone  https://github.com/Luskan777/sdns.git

$ cd sdns

$ chmod +x sdns.sh

$ cp sdns.sh /usr/bin/sdns
