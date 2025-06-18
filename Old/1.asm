section .data ;definicje danych
message db 'Moje ulubione miejsce jest w innym uniwersum', 0xA, 0 ;definicja tekstu
;tekst + 0xA czyli znak nowej lini + null bo windows oczekuje null-a na końcu
message_len equ $ - message ;oblicza dlugosc tekstu
;$ to pozycja w pamięci a massage to poczatek tekstu, automatycznie oblicza nam pamiec potrzebna

Section .bss ;definicja pamięci
written resd 1;reserved doubleword zmienna gdzie windows zapicze ile znaków faktycznie wyswietliło

section .text ;definicja sekcji kodu
global main ;początek programu
extern _GetStdHandle@4, _WriteConsoleA@20, _ExitProcess@4 ;deklaracje funkcji

main:
    mov ebp, esp; for correct debugging ;punkt startowy
    mov ebp, esp; tworzy ramkę stosu by program mógł się debugować
    ;Miejsce na kod
    
    ;uruchamia konsolę
    mov ecx, -11 ;parametr dla konsoli wyjściowej
    call _GetStdHandle@4 ;wywołuje funkcje którą zwraca konsolę w EAX
    mov ebx,eax ;przenosi z eax dla ebc aby użyć konsolę w pętli
    
    mov ecx, 3 ;ecx jako licznik pętli ustawiony na 3 skoki
    pętla:
        push ecx ;wrzuca ecx na stos bo potem WriteConsoleA może go zmienić
        
        ;wyświetlenie tekstu w konsoli
        push 0 ;musi być null
        push written ;adres w pamięci dla zapisanych danych
        push message_len ;długość napisu
        push message ;adres w pamięci
        push ebx ;wywołanie konsoli
        call _WriteConsoleA@20
        
        pop ecx; przywraca ecx ze stosu
        loop pętla ;zmniejsza ecx o 1 i skacze do "pętla"

    ;Miejsce na kod
    xor eax, eax ;usawienie kodu powrotu na 0
    push eax ; wrzuca eax na stos, przygotowywuje kod wyjścia dla fucnkji programu
    call _ExitProcess@4 ; wyjście z programu oraz oddaje kontrolę windowsowi