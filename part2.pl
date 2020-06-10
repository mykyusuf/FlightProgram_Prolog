flight(edirne,erzurum,5).
flight(erzurum,edirne,5).

flight(erzurum,antalya,2).
flight(antalya,erzurum,2).

flight(izmir,antalya,1).
flight(antalya,izmir,1).

flight(antalya,diyarbakir,5).
flight(diyarbakir,antalya,5).

flight(ankara,diyarbakir,8).
flight(diyarbakir,ankara,8).

flight(istanbul,izmir,3).
flight(izmir,istanbul,3).

flight(izmir,ankara,6).
flight(ankara,izmir,6).

flight(istanbul,ankara,2).
flight(ankara,istanbul,2).

flight(istanbul,trabzon,3).
flight(trabzon,istanbul,3).

flight(trabzon,ankara,6).
flight(ankara,trabzon,6).

flight(ankara,kars,3).
flight(kars,ankara,3).

flight(kars,gaziantep,3).
flight(gaziantep,kars,3).


route(X,Y,C) :-
travel(X,Y,P),
X \== Y,
% cost(P,P,C),
write(P).

/* cost hesaplama ile ilgili bir hata var ama cözemedim
cost([],0).

cost([X|Tail1],[X2,Y2|Tail2],Total):-
flight(X2,Y2,C1),
cost(Tail1,Tail1,Sum),
Total is Sum + C1,
write(Sum).
*/

travel(A,B,Path) :-
helper(A,B,[A],Q),
reverse(Q,Path).

helper(A,B,P,[B|P]) :-
flight(A,B,_).

helper(A,B,V,Path) :-
flight(A,C,_),
C \== B,
\+member(C,V),
helper(C,B,[C|V],Path).

