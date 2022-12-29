ORG 0100h
start:
 mov ax,0000h ;sonucun ust ust 16 biti
 mov bx,0000h ;sonucun ust alt 16 biti
 mov cx,0000h ;sonucun alt ust 16 biti
 mov dx,0000h ;sonucun alt alt 16 biti
              ;Yani cevap -> ax bx cx dx
                          ;carpan sayi 87654321h
 mov word ptr[500h],4321h ;carpan sayi alt 16 biti
 mov word ptr[502h],8765h ;carpan sayi ust 16 biti
  
                          ;carpilan sayi 12345678h
 mov word ptr[504h],5678h ;carpilan sayi alt 16 bitiç
 mov word ptr[506h],1234h ;carpilan sayi ust 16 bitiç
 
 
 mov si,20h      ;32 kez donmesi gerekir

tekrar:
 
 mov di,[500h]   ;di degerine carpanin 16 bitini ata
 AND di,01h      ;DI'nin LSB biti haricindeki bitlerini sifirla
 XOR di,01h      ;Carpan'in en anlamsiz biti lojik 1 mi?
 JZ topla_kaydir ;Evet ise Carpim sonucunu Carpilan ile topla
                 ; ve bir bit saga kaydir
 CLC

devam:
 
 rcr ax,1     ;carpim sonucun ust ust 16 bitini 1 bit saga kaydir
              ;tasma olursa yani kaydirma yapilmadan once lsb'de 1 varsa carry flag setlenir
 rcr bx,1     ;carpim sonucun ust alt 16 bitini 1 bit saga kaydir

 rcr cx,1     ;carpim sonucun alt ust 16 bitini 1 bit saga kaydir

 rcr dx,1     ;carpim sonucun alt alt 16 bitini 1 bit saga kaydir

 mov di,[502h]   ;rcr [502h],1 yanlis calisti bu yuzden di uzerinden yaptim
 rcr di,1        ;carpan ust 16 bitini 1 bit saga kaydir 
 mov [502h],di   ;cikan degeri bellekte carpanin ust 16 bitine yaz
 
 
 mov di,[500h]   ;rcr [500h],1 yanlis calisti bu yuzden di uzerinden yaptim
 rcr di,1        ;carpanin alt 16 bitini , ust 16 bitininden gelen carry ile saga kaydir
 mov [500h],di   ;cikan degeri bellekte carpanin alt 16 bitine yaz
 
 
 DEC SI     ;dongu degiskenini bir azalt
 CMP SI,0   ;dongu degiskeni sifir mi?
 JNZ tekrar ;Eger sifir degil ise ayni islemleri tekrarla
 JMP son    ;Eger sifir ise son'a git

topla_kaydir:

 add bx,[504h]     ;carpilanin alt 16 bit degerini bx ile topla ve bx'e ata
 
 add ax,[506h]     ;carry bitine gore ax degeri , carpilanin ust 16 biti ve carry flag'i topla cikan degeri ax'e ata
 
 JMP devam         ;devama zipla

son:
 
 hlt    ;halted        