all: sugar

sugar:
	(cd src; make)
	bash setup.sh

clean:
	-rm sugar
	-rm *~
