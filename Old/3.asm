section .data
    message db 'Gwiazda', 0xA, 0  ; Tekst + nowa linia + null
    message2 db 'Ile chcesz gwiazd: ', 0xA, 0
    message3 db 'Nie lubiesz gwiazd?', 0xA, 0

section .text
global main
extern io_print_string, io_newline, io_get_dec, Sleep@4 ;funkcja wyświetlenia tekstu i nowej lini

main:
    mov ebp, esp  ; Dla poprawnego debugowania w SASM

    mov eax, message2
    call io_print_string
    call io_get_dec
    mov ecx, eax ; Ustaw licznik pętli
    cmp ecx, 0 ;porównaj wartość ecx oraz 0
    jle skip ;jeśli mniejsze lub równe,jeśli less equeal przejdź do skip
    
    loop_tekst:
     push ecx      ; Zachowaj ECX na stosie
    
        mov eax, message ;wczytanie tekstu z pamięci
        call io_print_string
        ;call io_newline ;alternatywa jakby 0xA nie było
        pop ecx        ; Przywróć ECX ze stosu
        loop loop_tekst ; Zmniejsz ECX i skocz, jeśli ECX != 0
    jmp exit ;po pętli idzie do exit aby nie wpaść przypadkiem do skip

exit:
    push 1000 ;czas trwania czekania na zakończenie programu
    call Sleep@4 ;wyświetlanie wyniku
    xor eax, eax    ; Kod powrotu 0
    ret ;koniec funkcji main
skip:
    mov eax, message3 ;napisz w przypadku 0 lub mniej
    call io_print_string
    jmp exit ;skacze do exit