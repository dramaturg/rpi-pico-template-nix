

ifneq (, $(shell which nix-shell 2> /dev/null))
SHELL := nix-shell
.SHELLFLAGS := --command
endif

build/main.uf2: main.c
ifeq ("", $(IN_NIX_SHELL))
	exit 1
	mkdir -p build
	cd build && cmake .. && make
else
	rm -fr build
	nix-build -o build
endif

flash: build/main.uf2
	$(eval $(firstword $(shell retry -attempts 12 bash -c 'lsblk -P -p -d --output NAME,MODEL | grep RP2')))
	mountpoint /mnt && exit 1 || sudo mount $(NAME)1 /mnt -o uid=$(USER)

	cp $< /mnt/

	sync
	sudo umount /mnt

term:
	sudo bt

waitforterm:
	sudo bt -n

clean:
	rm -fr build

