#!/bin/bash
## Script simples em ShellScript para obter os dados de um dominio ##
	
if [ $1 == "--help"  ] || [ $1 == "-h" ]
then 

echo "sdns - Search DNS
 Programa para consultar Dominios na internet

 -f   Caso queira expecificar algum arquivo que tenha uma lista de dominios, Ex: sdns -f dominios.txt
 "

elif [ $1 == "-f" ]
 then

    echo "Atenção, este comando adicionará um um diretório $PWD/dominios.d "

    mkdir -p $PWD/dominios.d 2> /dev/null

    for i in $(cat $2)  ; 
    do nslookup $i | egrep "Name|Address"  | awk   '{print $1 " => " $2 }'| tail -n 2 > $PWD/dominios.d/$i ; 
    dig $i mx +short | awk '{print  "MX => " $2 }' >> $PWD/dominios.d/$i ;
    whois $1 | grep Registrar: | head -n1 | sed 's/Registrar/Registro/' >> $PWD/dominios.d/$i ;
    whois $i | egrep "tech-c|nserver" | sed 's/tech-c/ID-Tecnico/' >> $PWD/dominios.d/$i ; 
    whois $1 | grep 'Name Server' | head -n 3 >> $PWD/dominios.d/$i ;
    whois $i | grep status >> $PWD/dominios.d/$i ;	 done

    echo "As consultas dos dominios estão em '$PWD'/dominios.d "


else

dig $1 +short | awk '{print "Address => " $1}' 

dig $1 mx +short | awk '{print "MX => " $2 }'

whois $1 | grep Registrar: | head -n1 | sed 's/Registrar/Registro/'

whois $1 | egrep "tech-c|nserver" | sed 's/tech-c/ID-Tecnico/' | sed 's/nserver/nameserver/'

	if [ $(whois $1 | grep status: | awk '{ print $2}') == "published"  ]
		then
        		whois $1 | grep status: | sed 's/published/Publicado/'
	else
       	 whois $1 | grep status: | sed 's/on-hold/Congelado/'

	fi

whois $1 | grep 'Name Server' | head -n 3

fi



