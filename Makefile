build:
	gcc -fPIC -fno-stack-protector -c pam_limit_ssh.c
	sudo ld -x --shared -o /usr/lib64/security/pam_limit_ssh.so pam_limit_ssh.o
	rm pam_limit_ssh.o

test: build
	g++ -o pam_test test.c -lpam -lpam_misc

clean:
	rm pam_test
