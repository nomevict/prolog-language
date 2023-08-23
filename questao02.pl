familia(lourenca, romao, zuleide).
familia(lourenca, romao, francisca).
familia(lourenca, romao, valdira).
familia(cecilia, joao, givaldo).
familia(cecilia, joao, zemeira).
familia(valdira, chicao, fabricio).
familia(zuleide, givaldo, vinicius).
familia(zuleide, rangel, bruno).
familia(leila, givaldo, ana).


% nomes dos filhos
filhos(Pessoa) :-
    (familia(Pessoa, _, Filho);familia(_, Pessoa, Filho)),
    write(Filho), nl,
    fail.
filhos(Pessoa) :-
    (familia(Pessoa, _, _);familia(_, Pessoa, _)), nl,!.
filhos(Pessoa):-
    familia(_, _, Pessoa),
    write(Pessoa), write(' nao possui filhos cadastrados na base'), nl,!.
filhos(Pessoa):-
    write(Pessoa), write(' nao está na base'), nl.


% nome dos netos passando uma pessoa no parametro
netos(Pessoa):-
    (familia(Pessoa, _, Filho);familia(_, Pessoa, Filho)),
    (familia(Filho, _, Neto);familia(_, Filho, Neto)),
    write(Neto), nl,
    fail.
netos(Pessoa):-
    (familia(Pessoa, _, Filho);familia(_, Pessoa, Filho)),
    (familia(Filho, _, _);familia(_, Filho, _)),!.
netos(Pessoa):-
    familia(_, _, Pessoa),
    write(Pessoa), write(' nao possui netos cadastrados na base'), nl,!.
netos(Pessoa):-
    write(Pessoa), write(' nao esta na base'), nl.

% nome dos irmaos
irmaos(Pessoa):-
    familia(Mae, Pai, Pessoa),
    familia(Mae, Pai, Irmao),
    Pessoa \= Irmao,
    write(Irmao), nl,
    fail.
irmaos(Pessoa):-
    familia(Mae, Pai, Pessoa),
    familia(Mae, Padrasto, Irmao),
    Pessoa \= Irmao,
    Pai \= Padrasto,
    write(Irmao), nl,
    fail.
irmaos(Pessoa):-
    familia(Mae, Pai, Pessoa),
    familia(Madrasta, Pai, Irmao),
    Pessoa \= Irmao,
    Mae \= Madrasta,
    write(Irmao), nl,
    fail.
irmaos(Pessoa):-
    familia(Mae, Pai, Pessoa),
    (familia(Mae, _, Irmao);familia(_, Pai, Irmao)),
    Pessoa \= Irmao,!.
irmaos(Pessoa):-
    (familia(Pessoa, _, _);familia(_, Pessoa, _)),
    write(Pessoa), write(' nao possui irmaos cadastrados na base'), nl,!.
irmaos(Pessoa):-
    write(Pessoa), write(' nao esta na base'), nl.

% nome dos avos
avos(Pessoa):-
    familia(Mae, Pai, Pessoa),
    familia(GrandMotherMae, GrandFatherMae, Mae),
    familia(GrandMotherPai, GrandFatherPai, Pai),
    write('Avos maternos'), nl, write(GrandMotherMae), nl, write(GrandFatherMae), nl, nl,
    write('Avos paternos'), nl, write(GrandMotherPai), nl, write(GrandFatherPai), nl, nl,!.
avos(Pessoa):-
    familia(Mae, Pai, Pessoa),
    (familia(GrandMotherMae, GrandFatherMae, Mae),
    write('Avos maternos'), nl, write(GrandMotherMae), nl, write(GrandFatherMae), nl, nl,
    write('Avos paternos'), nl, write('Nao possui'), nl, nl;
    familia(GrandMotherPai, GrandFatherPai, Pai),
    write('Avos paternos'), nl, write(GrandMotherPai), nl, write(GrandFatherPai), nl, nl,
    write('Avos maternos'), nl, write('Nao possui'), nl, nl),!.
avos(Pessoa):-
    (familia(Pessoa, _, _);familia(_, Pessoa, _)),
    write(Pessoa), write(' nao possui avos cadastrados na base'), nl,!.
avos(Pessoa):-
    write(Pessoa), write(' nao esta na base'), nl.

% nome dos tios
tios(Pessoa):-
    familia(Mae, _, Pessoa),
    familia(GrandMotherMae, GrandFatherMae, Mae),
    familia(GrandMotherMae, GrandFatherMae, TioMaterno),    
    TioMaterno \= Mae,
    write(TioMaterno), nl,
    fail.
tios(Pessoa):-
    familia(_, Pai, Pessoa),
    familia(GrandMotherPai, GrandFatherPai, Pai),
    familia(GrandMotherPai, GrandFatherPai, TioPaterno),
    TioPaterno \= Pai,
    write(TioPaterno), nl,
    fail.
tios(Pessoa):-
    familia(Mae, Pai, Pessoa),
    (familia(GrandMotherMae, GrandFatherMae, Mae),
    familia(GrandMotherMae, GrandFatherMae, TioMaterno),
    TioMaterno \= Mae;
    familia(GrandMotherPai, GrandFatherPai, Pai),
    familia(GrandMotherPai, GrandFatherPai, TioPaterno),
    TioPaterno \= Pai),!.
tios(Pessoa):-
    (familia(Pessoa, _, _);familia(_, Pessoa, _)),
    write(Pessoa), write(' nao possui tios cadastrados na base'), nl,!.
tios(Pessoa):-
    write(Pessoa), write(' nao esta na base'), nl.

% menu
menu :-
    nl, write('------ MENU ------'), nl,
    write('1. Mostrar filhos'), nl,
    write('2. Mostrar netos'), nl,
    write('3. Mostrar irmaos'), nl,
    write('4. Mostrar avos maternos e paternos'), nl,
    write('5. Mostrar tios maternos e paternos'), nl,
    write('6. Finalizar programa'), nl,
    write('-------------------'), nl,
    read(Opcao),
    limpar_terminal,
    escolher_opcao(Opcao).


% escolher opção
escolher_opcao(1) :-
    write('Digite o nome da Pessoa: '), nl,
    read(Pessoa), nl,
    filhos(Pessoa),
    menu,!.
escolher_opcao(2) :-
    write('Digite o nome da Pessoa: '), nl,
    read(Pessoa), nl,
    netos(Pessoa),
    menu,!.
escolher_opcao(3) :-
    write('Digite o nome da Pessoa: '), nl,
    read(Pessoa), nl,
    irmaos(Pessoa),
    menu,!.
escolher_opcao(4) :-
    write('Digite o nome da Pessoa: '), nl,
    read(Pessoa), nl,
    avos(Pessoa),
    menu,!.
escolher_opcao(5) :-
    write('Digite o nome da Pessoa: '), nl,
    read(Pessoa), nl,
    tios(Pessoa),
    menu,!.
escolher_opcao(6):-
    write('Programa finalizado'), nl,!.
escolher_opcao(_) :-
    write('Opcao invalida'), nl,
    menu.

limpar_terminal:-
    (shell('clear') ; shell('cls')). 


:- initialization(menu). 
