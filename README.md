# PSET 01 

## Problem Set (PSET) desenvolvido no 1º Bimestre na disciplina de Design e Desenvolvimento de Banco de Dados 1 ministrado pelo Prof. Abrantes Araujo Silva Filho na Universidade Vila Velha - UVV.

##### Aluno: William Alexsander Santos Siqueira
##### Professor: Abrantes Araujo Silva Filho
##### Monitora: Suellen Miranda Amorim

Coloquei na pasta MariaDB a implementação neste SGBD, não sei se estou precisando de nota pois  tive acesso apenas a nota da prova mas como terminei o PSET nesse domingo (21/05), resolvi utilizar um pouco do tempo livre para aprender um pouco mais, talvez tenha alguma coisa ou outra errada mas importante é o conhecimento.

Detalhe 1: O usuário william possui a senha " 123456 ", porém com o comando /setenv para logar automáticamente no banco de dados UVV, assim abrindo o arquivo com o comando psql -U postgres < cc1mc_202307773_postgresql.sql ele logará automáticamente, porém abrindo dentro do postgre através do comando /c ele pedirá a senha, isso se deve ao fato que sem senha, o usuário pedia senha mesmo sem nenhuma senha cadastrada na hora de criar o usuário e essa foi a única maneira que achei de resolver isso.

Detalhe 2: Na relação entre envios e pedidos_itens, não consegui manter a relação da tabela pedidos_itens ter zero envios pois não há essa opção no Architect Power, então mantive zero ou um.

Detalhe 3: Eu coloquei um check em alguns itens com UNIQUE, porém percebi depois que o NOT NULL já faz essa tarefa, mas acabei deixando.
