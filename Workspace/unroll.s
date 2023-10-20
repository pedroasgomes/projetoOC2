.data
A:      .word   1, 3, 1, 6, 4
        .word   2, 4, 3, 9, 5
mult:   .word   0

        .code
        daddi   $1, $0, A      ; $1 = *A[0]             ;; Pointer
        daddi   $5, $0, 1      ; $5 = 1                 ;; i
        daddi   $6, $0, 10     ; $6 = 10                ;; N
        lw      $9, 0($1)      ; $9 = &A[0]             ;; mult
        daddi   $1, $1, 8      ; $1 += Offset           ;; Pointer

loop:   lw      $10, 0($1)     ; $13 = A[i]             ;; t1

        dmul    $10, $10, $9   ; $10 = A[i]*mult        ;; t1
        lw      $11, 8($1)     ; $12 = A[i+1]           ;; t2
        lw      $12, 16($1)    ; $11 = A[i+2]           ;; t3
        daddi   $5, $5, 3      ; $5 += 3                ;; i
        daddi   $1, $1, 24     ; $1 = Offset * 3        ;; Pointer
        dadd    $9, $9, $10    ; $9 =+ A[i]*mult        ;; mult

        dmul    $11, $11, $9   ; $11 = A[i+1]*mult      ;; t2
        dadd    $9, $9, $11    ; $9 += A[i+1]*mult      ;; mult

        dmul    $12, $12, $9   ; $12 = A[i+2]*mult      ;; t3
        dadd    $9, $9, $12    ; $9 =+ A[i+2]*mult      ;; mult

        bne     $6, $5, loop   ; (N != i)      
   
end:    sw      $9, mult($0)   ; Store result           ;; mult
        halt
        
;; Expected result: mult = f6180 (hex), 1008000 (dec)