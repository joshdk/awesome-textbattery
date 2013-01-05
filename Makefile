SOURCE="./src/textbattery.lua"
TARGET="/usr/share/awesome/lib/awful/widget/textbattery.lua"


all: install

install:
	install -m 644 $(SOURCE) $(TARGET)

uninstall:
	rm $(TARGET)
