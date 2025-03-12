THEME_NAME := HyprCross
THEME_SIZE := 29
SOURCE_DIR := hc-src
BUILD_DIR := hc
OUTPUT_DIR := theme_$(THEME_NAME)
ICON_DIR := ~/.icons/$(THEME_NAME)

all: prepare compile move clean symlink set

prepare:
	rm -rf $(BUILD_DIR) && cp -r $(SOURCE_DIR)/ $(BUILD_DIR)

compile:
	hyprcursor-util --create ./ -o ./

move:
	rm -rf $(BUILD_DIR) && mv $(OUTPUT_DIR)/$(BUILD_DIR) ./

clean:
	rm -rf $(OUTPUT_DIR)

symlink:
	rm -rf $(ICON_DIR) && ln -sr ./ $(ICON_DIR)

set:
	hyprctl setcursor $(THEME_NAME) $(THEME_SIZE)
