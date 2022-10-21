.PHONY: build-asm
build-asm:
	as $(s).s -o $(s).o
	ld $(s).o -o $(s).out

.PHONY: build-c
build-c:
	gcc $(c).c -o $(c).out

.PHONY: build-c-compact
build-c-compact:
	gcc -O0 -Wall -masm=intel -S -fno-asynchronous-unwind-tables -fcf-protection=none $(c)

.PHONY: c2a
c2a:
	gcc -O0 -Wall -masm=intel -S $(c) -o $(o)

.PHONY: c2ac
c2ac:
	gcc -O0 -Wall -masm=intel -S -fno-asynchronous-unwind-tables -fcf-protection=none $(c) -o $(o)

.PHONY: run-c
run-c:
	gcc $(c).c --save-temps -o $(c).out
	./$(c).out

.PHONY: run-asm
run-asm:
	as $(s).s -o $(s).o
	ld $(s).o -o $(s).out
	./$(s).out