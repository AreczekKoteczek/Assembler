section .data
    message db 'Moje ulubione miejsce jest w innym uniwersum', 0xA, 0  ; Tekst + nowa linia + null

section .text
global main
extern io_print_string, io_newline, ExitProcess@4 ;funkcja wyświetlenia tekstu i nowej lini

main:
    mov ebp, esp  ; Dla poprawnego debugowania w SASM

    ; Ustaw licznik pętli
    mov ecx, 3    ; Wyświetlimy tekst 3 razy

    loop_tekst:
     push ecx      ; Zachowaj ECX na stosie
    
        mov eax, message ;wczytanie tekstu z pamięci
        call io_print_string
        ;call io_newline ;alternatywa jakby 0xA nie było
        pop ecx        ; Przywróć ECX ze stosu
        loop loop_tekst ; Zmniejsz ECX i skocz, jeśli ECX != 0

    ; Zakończ program
    xor eax, eax    ; Kod powrotu 0
    push eax
    call ExitProcess@4