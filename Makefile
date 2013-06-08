SOURCE="./src/textbattery"
TARGET="$(HOME)/.config/awesome/textbattery"


all: install

install:
	cp -r $(SOURCE) $(TARGET)

uninstall:
	rm -rf $(TARGET)
