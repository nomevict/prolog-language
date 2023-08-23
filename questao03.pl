:- dynamic(oceano/1).
:- dynamic(pais/1).
:- dynamic(continente/1).
:- dynamic(fronteira/2).
:- dynamic(localizacao/2).

% menu
menu :-
    nl, write('------ MENU ------'), nl,
    write('1. Cadastrar oceano'), nl,
    write('2. Cadastrar país'), nl,
    write('3. Cadastrar continente'), nl,
    write('4. Cadastrar fronteiras'), nl,
    write('5. Cadastrar localizacao'), nl,
    write('6. Localizacao'), nl,
    write('7. Paises de um continente'), nl,
    write('8. Fronteira'), nl,
    write('9. Pares de paises que tem a mesma fronteira'), nl,
    write('10. Mostrar todos os paises que fazem fronteira com oceanos'), nl,
    write('11. fronteiras de um oceano'), nl,
    write('0. Encerrar programa'), nl,
    write('-------------------'), nl,
    read(Opcao), limpar_terminal,
    escolher_opcao(Opcao).

% cadastrar varios oceanos ate o usuario digitar 0 para finalizar a insercao
cadastrar_oceano:-
    write('Digite 0 caso queira finalizar a insercao de oceanos'), nl,
    write('Digite o nome do oceano: '), nl,
    read(Oceano),
    Oceano \= 0,
    oceanoExiste(Oceano),
    cadastrar_oceano,!.
cadastrar_oceano:-
    nl, write('Finalizando insercao de oceanos'), nl, nl.

% cadastrar varios paises ate o usuario digitar 0 para finalizar a insercao
cadastrar_pais:-
    write('Digite 0 caso queira finalizar a insercao de paises'), nl,
    write('Digite o nome do pais: '), nl,
    read(Pais),
    Pais \= 0,
    paisExiste(Pais),
    cadastrar_pais,!.
cadastrar_pais:-
    nl, write('Finalizando insercao de paises'), nl, nl.

% cadastrar varios continentes ate o usuario digitar 0 para finalizar a insercao
cadastrar_continente:-
    write('Digite 0 caso queira finalizar a insercao de continentes'), nl,
    write('Digite o nome do continente: '), nl,
    read(Continente),
    Continente \= 0,
    continenteExiste(Continente),
    cadastrar_continente,!.
cadastrar_continente:-
    nl, write('Finalizando insercao de continentes'), nl, nl.

% cadastrar varias fronteiras ate o usuario digitar 0 para finalizar a insercao
% a fronteira deve ser entre dois paises que ja foram cadastrados
% buscar se o pais existe antes de cadastrar a fronteira
cadastrar_fronteira:-
    write('Digite 0 caso queira finalizar a insercao de fronteiras'), nl,
    write('Digite o nome do pais ou oceano: '), nl,
    read(Info1),
    Info1 \= 0,
    oceanoPais(Info1),
    write('Digite o nome do 2º pais ou oceano: '), nl,
    read(Info2),
    Info2 \= 0,
    oceanoPais(Info2),
    \+ fronteiraExiste(Info1,Info2),
    assertz(fronteira(Info1,Info2)),
    nl, write('Fronteira cadastrada com sucesso'), nl, nl,
    cadastrar_fronteira,!.
cadastrar_fronteira:-
    nl, write('Finalizando insercao de fronteiras'), nl, nl.

% cadastrar varias localizacoes ate o usuario digitar 0 para finalizar a insercao
% a localizacao deve ser entre um pais e um continente que ja foram cadastrados
% buscar se o pais e o continente existem antes de cadastrar a localizacao
cadastrar_localizacao:-
    write('Digite 0 caso queira finalizar a insercao de localizacoes'), nl,
    write('Digite o nome do pais ou oceano: '), nl,
    read(Info1),
    Info1 \= 0,
    oceanoPais(Info1),
    write('Digite o nome do continente: '), nl,
    read(Continente),
    Continente \= 0,
    continenteExiste(Continente),
    \+ localizacaoExiste(Info1,Continente),
    assertz(localizacao(Info1,Continente)),
    write('Localizacao cadastrada com sucesso'), nl, nl,
    cadastrar_localizacao,!.
cadastrar_localizacao:-
    nl, write('Finalizando insercao de localizacoes'), nl, nl.

% mostrar localizacao de um pais
localizacaoPais(Pais):-
    localizacao(Pais,Continente),
    nl, write(Pais), write(' esta localizado no continente '), write(Continente), nl,!.
localizacaoPais(Pais):-
    nl, write(Pais), write(' nao tem localizacao definida na base'), nl.

% mostrar paises de um continente
paisesContinente(Continente):-
    localizacao(Pais,Continente),
    write(Pais), nl,
    fail.
paisesContinente(Continente):-
    localizacao(_,Continente),!.
paisesContinente(Continente):-
    nl, write(Continente), write(' nao possui paises cadastrados na base'), nl.


% mostrar todas as fronteiras de um pais ou oceano
fronteirasPaisesOceanos(Info):-
    (fronteira(Info,Fronteira); fronteira(Fronteira, Info)),
    write(Info), write(' faz fronteira com '), write(Fronteira), nl,
    fail.
fronteirasPaisesOceanos(Info):-
    (fronteira(Info,_); fronteira(_, Info)),!.
fronteirasPaisesOceanos(Info):-
    nl, write(Info), write(' nao possui fronteira cadastrada'), nl.

% mostrar todos os paises que fazem fronteira com oceanos
fronteiraComOceanos:-
    (fronteira(Pais,Oceano), oceano(Oceano); 
    fronteira(Oceano,Pais), oceano(Oceano)),
    write(Pais), write(' faz fronteira com '), write(Oceano), nl,
    fail.
fronteiraComOceanos:-
    (fronteira(_,Oceano), oceano(Oceano); 
    fronteira(Oceano,_), oceano(Oceano)),!.
fronteiraComOceanos:-
    nl, write('Nao ha fronteiras entre paises e oceanos cadastradas'), nl.

% mostrar todos os paises que fazem fronteira com o par de paises informado
fronteirasEmComum(Pais1,Pais2):-
    (fronteira(Pais1,PaisFronteira) ; fronteira(PaisFronteira,Pais1)),
    PaisFronteira \= Pais2,
    (fronteira(Pais2,PaisFronteira) ; fronteira(PaisFronteira,Pais2)),
    write(Pais1), write(' e '), write(Pais2), write(' fazem fronteira com '), write(PaisFronteira), nl, fail.
fronteirasEmComum(Pais1,Pais2):-
    (fronteira(Pais1,PaisFronteira) ; fronteira(PaisFronteira,Pais1)),
    PaisFronteira \= Pais2,
    (fronteira(Pais2,PaisFronteira) ; fronteira(PaisFronteira,Pais2)),!.
fronteirasEmComum(Pais1,Pais2):-
    nl, write(Pais1), write(' e '), write(Pais2), write(' nao fazem fronteira com nenhum pais em comum'), nl.

% escolher opção
escolher_opcao(1) :-
    cadastrar_oceano,
    menu,!.
escolher_opcao(2) :-
    cadastrar_pais,
    menu,!.
escolher_opcao(3) :-
    cadastrar_continente,
    menu,!.
escolher_opcao(4) :-
    cadastrar_fronteira,
    menu,!.
escolher_opcao(5) :-
    cadastrar_localizacao,
    menu,!.
escolher_opcao(6) :-
    write('Digite o nome do pais ou oceano: '), nl,
    read(Info1),
    oceanoPais(Info1),
    localizacaoPais(Info1),
    menu,!.
escolher_opcao(7) :-
    write('Digite o nome do continente: '), nl,
    read(Continente), nl,
    continenteExiste(Continente),
    paisesContinente(Continente),
    menu,!.    
escolher_opcao(8) :-
    write('Digite o nome do pais ou oceano: '), nl,
    read(Info), nl,
    (paisExiste(Info) ; oceanoExiste(Info)),
    fronteirasPaisesOceanos(Info),
    menu,!.
escolher_opcao(9):-
    write('Digite o nome do primeiro pais: '), nl,
    read(Pais1), nl,
    paisExiste(Pais1),
    write('Digite o nome do segundo pais: '), nl,
    read(Pais2), nl,
    paisExiste(Pais2),
    fronteirasEmComum(Pais1,Pais2),
    menu,!.
escolher_opcao(10):-
    fronteiraComOceanos,
    menu,!.
escolher_opcao(11):-
    write('Digite o nome de um oceano'), nl,
    read(Oceano), nl,
    oceanoExiste(Oceano), 
    fronteirasPaisesOceanos(Oceano),
    menu,!.
escolher_opcao(0) :-
    write('Finalizando programa'),!.
escolher_opcao(Opcao) :-
    (Opcao < 0; Opcao > 11),
    nl, write('Opcao invalida'), nl,
    menu.
escolher_opcao(_) :-
    nl, write('Retornando ao menu principal'), nl,
    menu.

% PREDICADOS AUXILIARES

% verificar se pais esta na base de dados
paisExiste(Pais):-
    pais(Pais),
    nl, write('Pais encontrado na base'), nl, nl,!.
paisExiste(Pais):-
    nl, write(Pais), write(' nao cadastrado'), nl, nl,
    write('Deseja cadastrar?'), nl,
    write('1 - Sim'), nl,
    write('0 - Nao'), nl,
    read(Opcao),
    Opcao = 1,
    assertz(pais(Pais)).

% verificar se oceano esta na base de dados
oceanoExiste(Oceano):-
    oceano(Oceano),
    nl, write('Oceano encontrado na base'), nl, nl,!.
oceanoExiste(Oceano):-
    nl, write(Oceano), write(' ainda nao cadastrado'), nl, nl,
    write('Deseja cadastrar?'), nl,
    write('1 - Sim'), nl,
    write('0 - Nao'), nl,
    read(Opcao),
    Opcao = 1,
    assertz(oceano(Oceano)).

% verificar se continente esta na base de dados
% se nao estiver, perguntar se o usuario deseja cadastrar
continenteExiste(Continente):-
    continente(Continente),
    nl, write(Continente), write(' encontrado na base'), nl, nl,!.
continenteExiste(Continente):-
    nl, write(Continente), write(' nao cadastrado'), nl, nl,
    write('Deseja cadastrar?'), nl,
    write('1 - Sim'), nl,
    write('0 - Nao'), nl,
    read(Opcao),
    Opcao = 1,
    assertz(continente(Continente)).

% verificar se fronteira esta na base de dados
fronteiraExiste(Info1,Info2):-
    (fronteira(Info1,Info2) ; fronteira(Info2,Info1)),
    nl, write('Fronteira encontrada na base'), nl, nl.

limpar_terminal:-
    (shell('clear') ; shell('cls')). 

% verificar se oceano ou pais foi digitado
oceanoPais(S):-
    (oceano(S); pais(S)),!.
oceanoPais(S):-
    nl, write('Oceano ou pais nao encontrado'), nl, nl,
    write('Deseja cadastrar?'), nl,
    write('1 - Sim'), nl,
    write('0 - Nao'), nl,
    read(Opcao),
    Opcao = 1,
    write('Eh um oceano ou um pais?'), nl,
    write('1 - Oceano'), nl,
    write('2 - Pais'), nl,
    read(Opcao2),
    (Opcao2 = 1, assertz(oceano(S)) ; Opcao2 = 2, assertz(pais(S))).

% verificar se localização esta na base de dados
localizacaoExiste(Pais,Continente):-
    localizacao(Pais,Continente),
    nl, write('Localizacao encontrada na base'), nl, nl.

:- initialization(menu). 