all: compile copy

compile:
	cd scripts/get-workspaces-rs/; cargo build --release

copy:
	cp scripts/get-workspaces-rs/target/release/get-workspaces scripts/

clean:
	rm -r scripts/get-workspaces-rs/target
