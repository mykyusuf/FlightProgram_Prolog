room(z06,10,yes).
room(z11,10,yes).

roomhave(z06,projector).
roomhave(z11,smartboard).

course(cse341,genc,10,4,z06).
course(cse343,turker,6,3,z11).
course(cse331,bayrakci,5,3,z06).
course(cse321,gozupek,10,4,z11).


instructor(genc,cse341).
instructor(turker,cse343).
instructor(gozupek,cse321).
instructor(bayrakci,cse331).

instructorneeds(bayrakci,yok).
instructorneeds(genc,projector).
instructorneeds(turker,smartboard).
instructorneeds(gozupek,smartboard).

occupancy(z06,8,11,cse341).
occupancy(z06,13,15,cse331).
occupancy(z11,8,11,cse343).
occupancy(z11,14,16,cse321).

studentclass(1,cse341).
studentclass(1,cse343).
studentclass(1,cse331).
studentclass(2,cse341).
studentclass(2,cse343).
studentclass(3,cse341).
studentclass(3,cse331).
studentclass(4,cse341).
studentclass(5,cse343).
studentclass(5,cse331).
studentclass(6,cse341).
studentclass(6,cse343).
studentclass(6,cse331).
studentclass(7,cse341).
studentclass(7,cse343).
studentclass(8,cse341).
studentclass(8,cse331).
studentclass(9,cse341).
studentclass(10,cse341).
studentclass(10,cse321).
studentclass(11,cse341).
studentclass(11,cse321).
studentclass(12,cse343).
studentclass(12,cse321).
studentclass(13,cse343).
studentclass(13,cse321).
studentclass(14,cse343).
studentclass(14,cse321).
studentclass(15,cse343).
studentclass(15,cse321).

studenthcapped(1,no).
studenthcapped(2,no).
studenthcapped(3,no).
studenthcapped(4,no).
studenthcapped(5,no).
studenthcapped(6,yes).
studenthcapped(7,no).
studenthcapped(8,yes).
studenthcapped(9,no).
studenthcapped(10,no).
studenthcapped(11,no).
studenthcapped(12,no).
studenthcapped(13,no).
studenthcapped(14,no).
studenthcapped(15,yes).

conflict(D1,D2):-
occupancy(_,T1,T2,D1),
occupancy(_,T3,T4,D2),
( (T3 > (T1-1), T3 < (T2+1)) ; (T4 > (T1-1), T4 < (T2+1)) ) , D1 \= D2.

assign(R,C):-
course(C,T,S1,_,_),
room(R,S2,_),
instructorneeds(T,N1),
roomhave(R,N2),
(N1 == N2 ; N1 == yok), S1 < S2+1.

enrol(S,C):-
studenthcapped(S,H1),
course(C,_,_,_,R),
room(R,_,H2),
( (H1 == yes , H2 == yes ) ; (H1 == no )).

addStudent(S,H) :-
studenthcapped(S,_) -> false ; assert(studenthcapped(S,H)).

addCourse(C,H,S,T,R) :-
( instructor(H,_) ,
room(R,_,_) , instructorneeds(H,N) ,roomhave(R,N)) -> assert(course(C,H,S,T,R)), assert(instructor(H,C)) ; false.

addRoom(R,C,H,N) :-
(course(C,_,_,_,_),
(H == yes ; H == no) ,
(N == projector ; N == smartboard ; N == yok)) -> assert(room(R,C,H)),
assert(roomhave(R,N)) ; false .

