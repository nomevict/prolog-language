% fatos
calcado(007, 'sandalia havaianas slim', sandalia, 35, amarelo, havaianas, 29.99).
calcado(008, 'sapato oxford', sapato, 38, vermelho, vizzano, 149.99).
calcado(009, 'tenis new balance', tenis, 41, preto, 'new balance', 199.99).
calcado(010, 'tenis puma', tenis, 39, azul, puma, 249.99).
calcado(011, 'bota coturno', bota, 37, preto, dakota, 199.99).
calcado(012, 'sandalia salto alto', sandalia, 36, dourado, vizzano, 129.99).
calcado(013, 'sapatilha bico fino', sapatilha, 38, vermelho, moleca, 79.99).
calcado(014, 'tenis asics gel-nimbus', tenis, 40, azul, asics, 399.99).
calcado(015, 'chinelo rider', chinelo, 43, preto, rider, 45.99).
calcado(016, 'sandalia rasteira', sandalia, 39, rosa, moleca, 59.99).
calcado(017, 'sapato salto alto', sapato, 37, preto, vizzano, 159.99).
calcado(018, 'tenis fila disruptor', tenis, 38, branco, fila, 399.99).
calcado(019, 'bota montaria', bota, 40, marrom, bottero, 299.99).
calcado(020, 'sandalia anabela', sandalia, 36, azul, moleca, 99.99).

% imprime calcado
imprime_calcado(Codigo, Nome, Tipo, Tamanho, Cor, Marca, Preco) :-
    write('Código: '), write(Codigo), nl,
    write('Nome: '), write(Nome), nl,
    write('Tipo: '), write(Tipo), nl,
    write('Tamanho: '), write(Tamanho), nl,
    write('Cor: '), write(Cor), nl,
    write('Marca: '), write(Marca), nl,
    write('Preço: '), write(Preco), nl, nl.

% menu
menu :-
    nl, write('------ MENU ------'), nl,
    write('1. Mostrar calcado pelo codigo'), nl,
    write('2. Mostrar calçados por tipo e tamanho'), nl,
    write('3. Mostrar calçados por tipo e cor'), nl,
    write('4. Mostrar calçados por tamanho e cor'), nl,
    write('5. Sair'), nl,
    write('-------------------'), nl,
    read(Opcao),
    limpar_terminal,
    escolher_opcao(Opcao).

% mostrar calcado pelo codigo
mostrar_calcado_codigo(Codigo):-
    calcado(Codigo, Nome, Tipo, Tamanho, Cor, Marca, Preco),
    imprime_calcado(Codigo, Nome, Tipo, Tamanho, Cor, Marca, Preco),!.
mostrar_calcado_codigo(_):-
    write('Nao ha calcados com esse codigo'), nl.

% mostrar calçados por tipo e tamanho
mostrar_calcado_tipo_tamanho(Tipo, Tamanho):-
    calcado(Codigo, Nome, Tipo, Tamanho, Cor, Marca, Preco),
    imprime_calcado(Codigo, Nome, Tipo, Tamanho, Cor, Marca, Preco),
    fail.
mostrar_calcado_tipo_tamanho(Tipo, Tamanho) :-
    calcado(_, _, Tipo, Tamanho, _, _, _), !.
mostrar_calcado_tipo_tamanho(_, _):-
    write('Nao ha calcados com esse tipo e tamanho'), nl.

% mostrar calçados por tipo e cor
mostrar_calcado_tipo_cor(Tipo, Cor):-
    calcado(Codigo, Nome, Tipo, Tamanho, Cor, Marca, Preco),
    imprime_calcado(Codigo, Nome, Tipo, Tamanho, Cor, Marca, Preco),
    fail.
mostrar_calcado_tipo_cor(Tipo, Cor) :-
    calcado(_, _, Tipo, _, Cor, _, _), !.
mostrar_calcado_tipo_cor(_, _):-
    write('Nao ha calcados com esse tipo e cor'), nl.

% mostrar calçados por tamanho e cor
mostrar_calcado_tamanho_cor(Tamanho, Cor):-
    calcado(Codigo, Nome, Tipo, Tamanho, Cor, Marca, Preco),
    imprime_calcado(Codigo, Nome, Tipo, Tamanho, Cor, Marca, Preco),
    fail.
mostrar_calcado_tamanho_cor(Tamanho, Cor) :-
    calcado(_, _, _, Tamanho, Cor, _, _), !.
mostrar_calcado_tamanho_cor(_, _):-
    write('Nao ha calcados com esse tamanho e cor'), nl.


% escolher opção
escolher_opcao(1) :-
    write('Digite o codigo do calcado: '), nl,
    read(Codigo), nl,
    mostrar_calcado_codigo(Codigo),
    menu,!.
escolher_opcao(2) :-
    write('Digite o tipo de calcado: '), nl,
    read(Tipo), nl,
    write('Digite o tamanho do calcado: '), nl,
    read(Tamanho), nl,
    mostrar_calcado_tipo_tamanho(Tipo, Tamanho),
    menu,!.
escolher_opcao(3) :-
    write('Digite o tipo de calcado: '), nl,
    read(Tipo), nl,
    write('Digite a cor do calcado: '), nl,
    read(Cor), nl,
    mostrar_calcado_tipo_cor(Tipo, Cor),
    menu,!.
escolher_opcao(4) :-
    write('Digite o tamanho do calcado: '), nl,
    read(Tamanho), nl,
    write('Digite a cor do calcado: '), nl,
    read(Cor), nl,
    mostrar_calcado_tamanho_cor(Tamanho, Cor),
    menu,!.
escolher_opcao(5) :-
    write('Saindo...'), nl.
escolher_opcao(_):-
    nl, write('Opcao invalida'), nl,
    menu.

limpar_terminal:-
    (shell('clear') ; shell('cls')). 

:- initialization(menu). 