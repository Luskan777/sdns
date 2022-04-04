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

    echo "Arquivo sdns-output.txt criado com os resultados "

    #mkdir -p $PWD/dominios.d 2> /dev/null

    for i in $(cat $2)  ; 
    do 
    
    dig $i +short | awk '{print "Address => " $1}' >> $PWD/sdns-output.txt

    dig $i mx +short | awk '{print "MX => " $2 }' >> $PWD/sdns-output.txt

    whois $i | grep Registrar: | head -n1 | sed 's/Registrar/Registro/' >> $PWD/sdns-output.txt

    whois $i | egrep "tech-c|nserver" | sed 's/tech-c/ID-Tecnico/' | sed 's/nserver/nameserver/' >> $PWD/sdns-output.txt

	if [ $(whois $i | grep status: | awk '{ print $2}') == "published" 2> /dev/null ]
		then
        		whois $i | grep status: | sed 's/published/Publicado/' 1>> $PWD/sdns-output.txt 2> /dev/null 
        else
            whois $i | grep status: | sed 's/on-hold/Congelado/' 1>> $PWD/sdns-output.txt  2> /dev/null

	fi

    whois $i | grep 'Name Server' | head -n 3 >> $PWD/sdns-output.txt
	 
    
    done

    cat $PWD/sdns-output.txt



else

dig $1 +short | awk '{print "Address => " $1}' 

dig $1 mx +short | awk '{print "MX => " $2 }'

whois $1 | grep Registrar: | head -n1 | sed 's/Registrar/Registro/'

whois $1 | egrep "tech-c|nserver" | sed 's/tech-c/ID-Tecnico/' | sed 's/nserver/nameserver/'

	if [ $(whois $1 | grep status: | awk '{ print $2}') == "published" 2> /dev/null ]
		then
        		whois $1 | grep status: | sed 's/published/Publicado/' 2> /dev/null
	else
       	 whois $1 | grep status: | sed 's/on-hold/Congelado/' 2> /dev/null

	fi

whois $1 | grep 'Name Server' | head -n 3

fi




